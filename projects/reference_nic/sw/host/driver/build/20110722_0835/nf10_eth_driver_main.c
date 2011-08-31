/* NetFPGA-10G http://www.netfpga.org
 * 
 * NetFPGA-10G Reference NIC Ethernet Driver
 * 
 * Revision history:
 *  2011/07/05 Jonathan Ellithorpe: "Let there be driver,"
 *                                  and there was driver,
 *                                  and it was good, for it separated 
 *                                  the hardware from the software.
 */

/* FIXME: Make function comment headers that of standard linux style. */
/* FIXME: Make naming conistent (nf10_pci_driver, probe, remove vs. nf10_netdev_ops... nf10_ prefix?? */
/* FIXME: Generally need to make sure that I free the skb_reply data structures... which I'm not doing a very good job of doing right now. */

/* Documentation resources:
 * kernel/Documentation/DMA-API-HOWTO.txt
 * kernel/Documentation/PCI/pci.txt
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/timer.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/proc_fs.h>
#include <linux/pci.h>
#include <net/genetlink.h>
#include <linux/dma-mapping.h>

/* Driver specific definitions. */
#include "nf10_eth_driver.h"

/* NF10 specific generic netlink definitions. */
#include "nf10_genl.h"

/* OpenCPI specific definitions. */
#include "occp.h"
#include "ocdp.h"

/* Function prototypes. */
static int                      nf10_ndo_open(struct net_device *netdev);
static int                      nf10_ndo_stop(struct net_device *netdev);
static netdev_tx_t              nf10_ndo_start_xmit(struct sk_buff *skb, struct net_device *netdev);
static void                     nf10_ndo_tx_timeout(struct net_device *netdev);
static struct net_device_stats* nf10_ndo_get_stats(struct net_device *netdev);
static int                      nf10_ndo_set_mac_address(struct net_device *netdev, void *addr);

static int                      nf10_napi_struct_poll(struct napi_struct *napi, int budget);

static void                     rx_poll_timer_cb(unsigned long arg);

uint32_t    rx_get_dst_iface(uint32_t opcode);
uint32_t    rx_get_src_iface(uint32_t opcode);
void        rx_set_dst_iface(uint32_t *opcode, uint32_t dst_iface);
void        rx_set_src_iface(uint32_t *opcode, uint32_t src_iface);
uint32_t    tx_get_dst_iface(uint32_t opcode);
uint32_t    tx_get_src_iface(uint32_t opcode);
void        tx_set_dst_iface(uint32_t *opcode, uint32_t dst_iface);
void        tx_set_src_iface(uint32_t *opcode, uint32_t src_iface);

char driver_name[] = "nf10_eth_driver";

/* Driver version. */
#define NF10_ETH_DRIVER_VERSION     "1.1.1"

/* Number of network devices. */
#define NUM_NETDEVS 4

/* Network devices to be registered with the kernel. */
struct net_device *nf10_netdevs[NUM_NETDEVS];

/* MMIO */
/* Like the DMA variables, probe() and remove() both use bar0_base_va, so need
 * to make global. FIXME: explore more elegant way of doing this. */
void __iomem    *bar0_base_va;
unsigned int    bar0_size;

/* DMA */
/* *_dma_reg_* need these to be global for now since probe() and remobe() both use them.
 * FIXME: possible that we can do something more elegant. */
void                *tx_dma_reg_va; /* TX DMA region kernel virtual address. */
dma_addr_t          tx_dma_reg_pa;  /* TX DMA region physical address. */
void                *rx_dma_reg_va; /* RX DMA region kernel virtual address. */
dma_addr_t          rx_dma_reg_pa;  /* RX DMA region physical address. */
struct dma_stream   tx_dma_stream;  /* To device. */
struct dma_stream   rx_dma_stream;  /* From device. */

/* DMA parameters. */
#define     DMA_BUF_SIZE        2048    /* Size of buffer for each DMA transfer. Property of the hardware. */
#define     DMA_FPGA_BUFS       4       /* Number of buffers on the FPGA side. Property of the hardware. */
#define     DMA_CPU_BUFS        32768   /* Number of buffers on the CPU side. */
#define     MIN_DMA_CPU_BUFS    8       /* Minimum number of buffers on the CPU side. */

/* Total size of a DMA region (1 region for TX, 1 region for RX). */
#define     DMA_REGION_SIZE     ((DMA_BUF_SIZE + OCDP_METADATA_SIZE + sizeof(uint32_t)) * (DMA_CPU_BUFS))

uint32_t dma_cpu_bufs;
uint32_t dma_region_size;

/* Interval at which to poll for received packets. */
#define     RX_POLL_INTERVAL    16

/* Weight used in NAPI for polling. */
#define     RX_POLL_WEIGHT      16

/* Polling timer for received packets. */
struct timer_list rx_poll_timer = TIMER_INITIALIZER(rx_poll_timer_cb, 0, 0);

/* Structure for using NAPI. */
struct napi_struct nf10_napi_struct;

/* Bundle of variables to keep track of a unidirectional DMA stream. */
struct dma_stream {
    uint8_t         *buffers;
    OcdpMetadata    *metadata;
    uint32_t        *flags;
    uint32_t        *doorbell;
    uint32_t        buf_index;
};

static const struct net_device_ops nf10_netdev_ops = {
    .ndo_open               = nf10_ndo_open,
    .ndo_stop               = nf10_ndo_stop,
    .ndo_start_xmit         = nf10_ndo_start_xmit,
    .ndo_tx_timeout         = nf10_ndo_tx_timeout,
    .ndo_get_stats          = nf10_ndo_get_stats,
    .ndo_set_mac_address    = nf10_ndo_set_mac_address,
};

/* OpenCPI */
#define WORKER_DP0      13
#define WORKER_DP1      14
#define WORKER_SMA0     2
#define WORKER_BIAS     3
#define WORKER_SMA1     4
#define WORKER_NF10     0

/* 2^OCCP_LOG_TIMEOUT is the number of cycles that a slave has to
 * respond to a request from a master. The significance for NF10 designs
 * is that they have this many cycles to respond to register accesses
 * across the AXI-lite interface to the design coming from OPED. */
#define OCCP_LOG_TIMEOUT    4

/* Pointer to OCPI register space for the NF10 design. */
uint32_t            *nf10_regs;

/* Pointer to OCPI control space for the NF10 design. */
OccpWorkerRegisters *nf10_ctrl;

/* Variable used for keeping track of the hardware state. */
uint32_t    hw_state = 0;

/* Define our attributes policy array. The array index is the attribute number,
 * and the value is a policy for that attribute type. The policy simply states
 * the type of data that attributes of that type are allowed to contain
 * (32-bit integer, null terminated string, etc.). Part of the definition of a
 * netlink operation is which policy array it uses. Then, when the generic 
 * netlink subsystem of the kernel receives a new netlink message for this
 * family, it first observes the operation, then uses the policy array 
 * associated with the operation to check each of the attributes in the message
 * of the operation. Note that, for each attribute, specifying a policy is
 * optional (although highly encouraged, even when attributes are structures or
 * arrays). */
static struct nla_policy nf10_genl_policy[NF10_GENL_A_MAX + 1] = {
    [NF10_GENL_A_MSG]    = { .type = NLA_NUL_STRING },
};

/* Define our own generic netlink family for the nf10_eth_driver. */
static struct genl_family nf10_genl_family = {
    .id         = GENL_ID_GENERATE,         /* Tells the Generic Netlink controller to choose a channel
                                             * number for us when we register the family. This channel 
                                             * number is then placed in the 'type' field of each
                                             * packet's nlmsghdr. */
    .hdrsize    = 0,                        /* Using 0 because there's no family specific header. */
    .name       = NF10_GENL_FAMILY_NAME,    /* User-space applications use this name to identify this
                                             * channel. The generic netlink controller forms a mapping
                                             * between this name and the channel number (ID). */
    .version    = NF10_GENL_FAMILY_VERSION,
    .maxattr    = NF10_GENL_A_MAX,          /* Maximum number of attributes this family supports. */
};

/* Functions of operations defined for our Generic Netlink family... */

/* A simple Echo command. 
 * Application sends us a message and we send it back to the application. */
int genl_cmd_echo(struct sk_buff *skb, struct genl_info *info)
{
    struct nlattr *na;
    char *msg;
    struct sk_buff *skb_reply;
    void *msg_reply;
    int err;

    if(info == NULL) {
        printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): info arg is NULL\n");
        return -EINVAL;
    }

    /* Receive the message. */
    na = info->attrs[NF10_GENL_A_MSG];
    if(na) {
        msg = (char *)nla_data(na);
        if(msg == NULL) {
            printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): msg attribute has no data\n");
            return 0;
        } else
            printk(KERN_INFO "nf10_eth_driver: genl_cmd_echo(): received: %s\n", msg);
    } 
    else {
        printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): no msg attribute in generic netlink command\n");
        return 0;
    }

    /* Echo the message. */
    skb_reply = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
    if(skb_reply == NULL) {
        printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): couldn't allocate the reply skb\n");
        return -ENOMEM;
    }

    msg_reply = genlmsg_put_reply(skb_reply, info, &nf10_genl_family, 0, NF10_GENL_C_ECHO);
    if(msg_reply == NULL) {
        printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): genlmsg_put_reply returned NULL\n");
        /* FIXME: need to free data structures! */
        return 0; /* FIXME: What's the proper error code for this? */
    }

    err = nla_put_string(skb_reply, NF10_GENL_A_MSG, msg);
    if(err != 0) {
        printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): couldn't add msg to reply\n");
        /* FIXME: need to free data structures! */
        return err;
    }

    genlmsg_end(skb_reply, msg_reply);

    err = genlmsg_reply(skb_reply, info);
    if(err != 0) {
        printk(KERN_WARNING "nf10_eth_driver: genl_cmd_echo(): couldn't send back reply\n");
        /* FIXME: need to free data structures! */
        return err;
    }

    /* FIXME: Is it necessary to free the skb_reply? */

    return 0;
}

/* DMA TX command. 
 * Application sends us a message to transmit to the device over DMA. */
int genl_cmd_dma_tx(struct sk_buff *skb, struct genl_info *info)
{
    struct nlattr   *na_msg, *na_opcode;    
    void*           msg_data;
    size_t          msg_len;

    /* FIXME: it's possible to call this function even when there's no hardware, need to check that 
     * the right data structures have actually been initialized and so on... */ 
    
    if(info == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_dma_tx(): info arg is NULL\n", driver_name);
        return -EINVAL;
    }
    
    /* Receive the message to transmit. */
    na_msg = info->attrs[NF10_GENL_A_MSG];
    if(na_msg) {
        if(nla_data(na_msg) == NULL) {
            printk(KERN_WARNING "%s: genl_cmd_dma_tx(): msg attribute has no data\n", driver_name);
            return 0;
        }
    } else {
        printk(KERN_WARNING "%s: genl_cmd_dma_tx(): no msg attribute found in generic netlink command\n", driver_name);
        return 0;
    }

    /* Receive the opcode to use. */
    na_opcode = info->attrs[NF10_GENL_A_OPCODE];
    if(na_opcode) {
        if(nla_data(na_opcode) == NULL) {
            printk(KERN_WARNING "%s: genl_cmd_dma_tx(): opcode attribute has no data\n", driver_name);
            return 0;
        }
    } else {
        printk(KERN_WARNING "%s: genl_cmd_dma_tx(): no opcode attribute found in generic netlink command\n", driver_name);
        return 0;
    }

    /* If all the buffers are full, abort. */
    if(tx_dma_stream.flags[tx_dma_stream.buf_index] == 0) {
        PDEBUG("genl_cmd_dma_tx(): all buffers full, aborting...\n");
        return 0;
    }

    PDEBUG("genl_cmd_dma_tx(): filling free buffer: %d\n", tx_dma_stream.buf_index);

    msg_data = nla_data(na_msg);
    /* Cap the msg_len to DMA_BUF_SIZE. */
    msg_len = (nla_len(na_msg) > DMA_BUF_SIZE) ? DMA_BUF_SIZE : nla_len(na_msg);

    /* Copy message into buffer. */
    memcpy((void*)&tx_dma_stream.buffers[tx_dma_stream.buf_index * DMA_BUF_SIZE], msg_data, msg_len);    
    
    /* Fill out metadata. */
    tx_dma_stream.metadata[tx_dma_stream.buf_index].length = msg_len;
    tx_dma_stream.metadata[tx_dma_stream.buf_index].opCode = *(uint32_t*)nla_data(na_opcode);
    
    /* Set the buffer flag to full. */
    tx_dma_stream.flags[tx_dma_stream.buf_index] = 0;

    PDEBUG("genl_cmd_dma_tx(): DMA TX operation info:\n"
        "\tReceived msg:\t\t%s\n"
        "\tReceived msg length:\t%d\n"
        "\tReceived opcode:\t0x%08x\n"
        "\tUsing buffer number:\t%d\n",
        (char*)nla_data(na_msg), nla_len(na_msg), *(uint32_t*)nla_data(na_opcode), tx_dma_stream.buf_index);    

    /* Tell hardware we filled a buffer. */
    *tx_dma_stream.doorbell = 1;

    /* Update the buffer index. */
    if(++tx_dma_stream.buf_index == dma_cpu_bufs)
        tx_dma_stream.buf_index = 0;

    return 0;
}

/* DMA RX command. 
 * Receive data over DMA and send back to the application. */
int genl_cmd_dma_rx(struct sk_buff *skb, struct genl_info *info)
{
    struct sk_buff *skb_reply;
    void *msg_reply;
    int err;

    /* Check arguments. */
    if(info == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_dma_rx(): info arg is NULL\n", driver_name);
        return -EINVAL;
    }
    
    /* Prepare a reply. */
    skb_reply = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
    if(skb_reply == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_dma_rx(): couldn't allocate the reply skb\n", driver_name);
        return -ENOMEM;
    }

    msg_reply = genlmsg_put_reply(skb_reply, info, &nf10_genl_family, 0, NF10_GENL_C_DMA_RX);
    if(msg_reply == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_dma_rx(): genlmsg_put_reply returned NULL\n", driver_name);
        /* FIXME: need to free data structures! */
        return 0; /* FIXME: What's the proper error code for this? */
    }

    /* Check if buffer has something for us. */
    if(rx_dma_stream.flags[rx_dma_stream.buf_index] == 1) {
        /* Add DMA buffer attribute. */
        err = nla_put(  skb_reply, 
                        NF10_GENL_A_DMA_BUF, 
                        rx_dma_stream.metadata[rx_dma_stream.buf_index].length, 
                        (void*)&rx_dma_stream.buffers[rx_dma_stream.buf_index * DMA_BUF_SIZE]);
        if(err != 0) {
            printk(KERN_WARNING "%s: genl_cmd_dma_rx(): couldn't add DMA buffer attribute to generic netlink msg\n", driver_name);
            /* FIXME: We need to free the allocated data structures! */
            return err;
        }

        /* Add opcode attribute. */
        err = nla_put_u32(  skb_reply,
                            NF10_GENL_A_OPCODE,
                            rx_dma_stream.metadata[rx_dma_stream.buf_index].opCode);
        if(err != 0) {
            printk(KERN_WARNING "%s: genl_cmd_dma_rx(): couldn't add opcode attribute to generic netlink msg\n", driver_name);
            /* FIXME: We need to free the allocated data structures! */
            return err;
        }

        /* Mark the buffer as empty. */
        rx_dma_stream.flags[rx_dma_stream.buf_index] = 0;
    
        PDEBUG("genl_cmd_dma_rx(): DMA RX operation info:\n"
            "\tBytes of data received:\t%d\n"
            "\tOpcode received:\t\t0x%08x\n"
            "\tFrom buffer number:\t%d\n",
            rx_dma_stream.metadata[rx_dma_stream.buf_index].length, 
            rx_dma_stream.metadata[rx_dma_stream.buf_index].opCode,
            rx_dma_stream.buf_index);    

        /* Tell the hardware we emptied the buffer. */
        *rx_dma_stream.doorbell = 1;

        /* Update the buffer index. */
        if(++rx_dma_stream.buf_index == dma_cpu_bufs)
            rx_dma_stream.buf_index = 0;
    }
    else {
        PDEBUG("genl_cmd_dma_rx(): buffer number %d is empty\n", rx_dma_stream.buf_index);
    }

    genlmsg_end(skb_reply, msg_reply);

    err = genlmsg_reply(skb_reply, info);
    if(err != 0) {
        printk(KERN_WARNING "%s: genl_cmd_dma_rx(): couldn't send back reply\n", driver_name);
        /* FIXME: do we need to free allocated data structures here? */
        return err;
    }
    
    return 0;
}

/* Register read command.
 * Application sends us an address to read and we send back the value at that address. */
int genl_cmd_reg_rd(struct sk_buff *skb, struct genl_info *info)
{
    struct nlattr   *na;    
    struct sk_buff  *skb_reply;
    void            *msg_reply;
    int             err = 0;
    uint32_t        reg_addr;
    uint32_t        reg_addr_page;
    uint32_t        reg_addr_offset;
    uint32_t        reg_val;    

    /* FIXME: it's possible to call this function even when there's no hardware, need to check that 
     * the right data structures have actually been initialized and so on... */ 
    
    if(info == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): info arg is NULL\n", driver_name);
        return -EINVAL;
    }

    /* Prepare a reply. */
    skb_reply = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
    if(skb_reply == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): couldn't allocate the reply skb\n", driver_name);
        return -ENOMEM;
    }

    msg_reply = genlmsg_put_reply(skb_reply, info, &nf10_genl_family, 0, NF10_GENL_C_REG_RD);
    if(msg_reply == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): genlmsg_put_reply returned NULL\n", driver_name);
        /* FIXME: need to free data structures! */
        return 0; /* FIXME: What's the proper error code for this? */
    }
    
    /* Get the address to read. */
    na = info->attrs[NF10_GENL_A_ADDR32];
    if(na) {
        if(nla_data(na) == NULL) {
            printk(KERN_WARNING "%s: genl_cmd_reg_rd(): address attribute has no data\n", driver_name);
            err = -1;
            goto send_error;
        }
    } else {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): no address attribute in generic netlink command\n", driver_name);
        err = -1;
        goto send_error;
    }

    /* Calculate page and offset. */
    reg_addr        = *(uint32_t*)nla_data(na);
    reg_addr_page   = reg_addr / OCCP_WORKER_CONFIG_SIZE;
    reg_addr_offset = reg_addr % OCCP_WORKER_CONFIG_SIZE;

    /* Check that offset is 4B word aligned. */
    if(reg_addr_offset % 4) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): address not 4B word aligned (0x%08x)... aborting\n", driver_name, reg_addr);
        err = -1;
        goto send_error;
    }

    /* Set page register. */
    nf10_ctrl->pageWindow = reg_addr_page;
    
    /* Make sure the page register is written before we read from the register space. */
    mb();

    /* Go get the register value! */
    reg_val = nf10_regs[(reg_addr_offset >> 2)];

    PDEBUG("genl_cmd_reg_rd(): Register read operation info:\n"
        "\tRegister page:\t\t0x%08x\n"
        "\tRegister offset:\t0x%08x\n"
        "\tRegister value:\t\t0x%08x\n",
        reg_addr_page, 
        reg_addr_offset,
        reg_val);

    /* Put the reg value in the reply. */
    err = nla_put_u32(  skb_reply, 
                        NF10_GENL_A_REGVAL32, 
                        reg_val);
    if(err != 0) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): couldn't add register value to generic netlink msg\n", driver_name);
        goto send_error;
    }

/* This is where we send back an errno to report back the status of the operation. */
send_error:
    
    err = nla_put_u32(  skb_reply,
                        NF10_GENL_A_ERRNO,
                        err);
    if(err != 0) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): couldn't add errno attribute to generic netlink msg\n", driver_name);
        /* FIXME: We need to free the allocated data structures! */
        return err;
    }    

    genlmsg_end(skb_reply, msg_reply);

    err = genlmsg_reply(skb_reply, info);
    if(err != 0) {
        printk(KERN_WARNING "%s: genl_cmd_reg_rd(): couldn't send back reply\n", driver_name);
        /* FIXME: do we need to free allocated data structures here? */
        return err;
    }    

    return 0;
}

/* Register write command.
 * Application sends us an address and data to write. */
int genl_cmd_reg_wr(struct sk_buff *skb, struct genl_info *info)
{
    struct nlattr   *na_addr, *na_val;    
    struct sk_buff  *skb_reply;
    void            *msg_reply;    
    uint32_t        reg_addr, reg_val;
    uint32_t        reg_addr_page, reg_addr_offset;
    int             err = 0;

    /* FIXME: it's possible to call this function even when there's no hardware, need to check that 
     * the right data structures have actually been initialized and so on... */ 
    
    if(info == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): info arg is NULL\n", driver_name);
        return -EINVAL;
    }

    /* Prepare a reply. */
    skb_reply = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
    if(skb_reply == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): couldn't allocate the reply skb\n", driver_name);
        return -ENOMEM;
    }

    msg_reply = genlmsg_put_reply(skb_reply, info, &nf10_genl_family, 0, NF10_GENL_C_REG_WR);
    if(msg_reply == NULL) {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): genlmsg_put_reply returned NULL\n", driver_name);
        /* FIXME: need to free data structures! */
        return 0; /* FIXME: What's the proper error code for this? */
    }
     
    /* Receive the address to write to. */
    na_addr = info->attrs[NF10_GENL_A_ADDR32];
    if(na_addr) {
        if(nla_data(na_addr) == NULL) {
            printk(KERN_WARNING "%s: genl_cmd_reg_wr(): address attribute has no data\n", driver_name);
            err = -1;
            goto send_error;
        }
    } else {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): no address attribute in generic netlink command\n", driver_name);
        err = -1;
        goto send_error;
    }

    /* Receive the value to write. */
    na_val = info->attrs[NF10_GENL_A_REGVAL32];
    if(na_val) {
        if(nla_data(na_val) == NULL) {
            printk(KERN_WARNING "%s: genl_cmd_reg_wr(): register value attribute has no data\n", driver_name);
            err = -1;
            goto send_error;
        }
    } else {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): no register value attribute in generic netlink command\n", driver_name);
        err = -1;
        goto send_error;
    }

    /* Calculate page and offset. */
    reg_addr        = *(uint32_t*)nla_data(na_addr);
    reg_addr_page   = reg_addr / OCCP_WORKER_CONFIG_SIZE;
    reg_addr_offset = reg_addr % OCCP_WORKER_CONFIG_SIZE;

    /* Check that offset is 4B word aligned. */
    if(reg_addr_offset % 4) {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): address not 4B word aligned (0x%08x)... aborting\n", driver_name, reg_addr);
        err = -1;
        goto send_error;
    }
    
    /* Get value to write. */
    reg_val = *(uint32_t*)nla_data(na_val);

    /* Set page register. */
    nf10_ctrl->pageWindow = reg_addr_page;
    
    /* Make sure the page register is written before we write to the register space. */
    mb();

    /* Go write the register value! */
    nf10_regs[reg_addr_offset] = reg_val;

    PDEBUG("genl_cmd_reg_wr(): Register write operation info:\n"
        "\tRegister page:\t\t0x%08x\n"
        "\tRegister offset:\t0x%08x\n"
        "\tRegister value:\t\t0x%08x\n",
        reg_addr_page, 
        reg_addr_offset,
        reg_val);    

/* This is where we send back an errno to report back the status of the operation. */
send_error:
    
    err = nla_put_u32(  skb_reply,
                        NF10_GENL_A_ERRNO,
                        err);
    if(err != 0) {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): couldn't add errno attribute to generic netlink msg\n", driver_name);
        /* FIXME: We need to free the allocated data structures! */
        return err;
    }    

    genlmsg_end(skb_reply, msg_reply);

    err = genlmsg_reply(skb_reply, info);
    if(err != 0) {
        printk(KERN_WARNING "%s: genl_cmd_reg_wr(): couldn't send back reply\n", driver_name);
        /* FIXME: do we need to free allocated data structures here? */
        return err;
    }

    return 0;
}

/* NAPI enable command.
 * Application sends us this command to enable NAPI polling for RX packets. */
int genl_cmd_napi_enable(struct sk_buff *skb, struct genl_info *info)
{
    /* Enable NAPI. */
    /* OK the reason for commenting this out and the napi_disable below
     * is kind of complicated. It comes down to the issue of calling
     * enable when it's already enabled, or disable when it's already
     * disabled. As far as I can see from the napi code, it seems that
     * the disabled state is simply permanently being in the scheduled
     * state (NAPI_STATE_SCHED), but this state is also used for when
     * you really have a NAPI poll scheduled. So the two states...
     * having something scheduled and being disabled are
     * indistinguishable... therefore there's no way to tell before
     * calling napi_disable if you've already disabled napi. To make
     * things simple, these functions therefore just stop/start the
     * rx_poll_timer. True, it's possible that there's a polling going
     * on when you del_timer and then the timer gets started back up
     * again at the end of the napi polling loop. These functions are
     * meant more for playing around and debugging this driver, not for
     * anything mission critical, so in this particular situation I
     * think this is fine. */
    //napi_enable(&nf10_napi_struct);
    
    /* Set the polling timer for receiving packets. */
    rx_poll_timer.expires = jiffies + RX_POLL_INTERVAL;

    /* Delete the timer just in case it's already in the list. */
    del_timer(&rx_poll_timer);

    /* Start. */
    add_timer(&rx_poll_timer); 

    PDEBUG("genl_cmd_napi_enable(): NAPI polling enabled\n");    

    return 0;
}

/* NAPI disable command.
 * Application sends us this command to disable NAPI polling for RX packets. */
int genl_cmd_napi_disable(struct sk_buff *skb, struct genl_info *info)
{
    /* Disable NAPI. */
    //napi_disable(&nf10_napi_struct);

    /* Stop the polling timer for receiving packets. */
    del_timer(&rx_poll_timer); 

    PDEBUG("genl_cmd_napi_disable(): NAPI polling disabled\n");    

    return 0;
}

/* Operations defined for our Generic Netlink family... */

/* Echo operation genl structure. */
struct genl_ops genl_ops_echo = {
    .cmd        = NF10_GENL_C_ECHO,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_echo,
    .dumpit     = NULL,
};

/* DMA TX operation genl structure. */
struct genl_ops genl_ops_dma_tx = {
    .cmd        = NF10_GENL_C_DMA_TX,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_dma_tx,
    .dumpit     = NULL,
};

/* DMA RX operation genl structure. */
struct genl_ops genl_ops_dma_rx = {
    .cmd        = NF10_GENL_C_DMA_RX,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_dma_rx,
    .dumpit     = NULL,
};

/* Register read operation genl structure. */
struct genl_ops genl_ops_reg_rd = {
    .cmd        = NF10_GENL_C_REG_RD,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_reg_rd,
    .dumpit     = NULL,
};

/* Register write operation genl structure. */
struct genl_ops genl_ops_reg_wr = {
    .cmd        = NF10_GENL_C_REG_WR,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_reg_wr,
    .dumpit     = NULL,
};

/* Register NAPI enable operation genl structure. */
struct genl_ops genl_ops_napi_enable = {
    .cmd        = NF10_GENL_C_NAPI_ENABLE,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_napi_enable,
    .dumpit     = NULL,
};

/* Register NAPI disable operation genl structure. */
struct genl_ops genl_ops_napi_disable = {
    .cmd        = NF10_GENL_C_NAPI_DISABLE,
    .flags      = 0,
    .policy     = nf10_genl_policy,
    .doit       = genl_cmd_napi_disable,
    .dumpit     = NULL,
};

static struct genl_ops *genl_all_ops[] = {
    &genl_ops_echo,
    &genl_ops_dma_tx,
    &genl_ops_dma_rx,
    &genl_ops_reg_rd,
    &genl_ops_reg_wr,
    &genl_ops_napi_enable,
    &genl_ops_napi_disable,
};

/* These are the IDs of the PCI devices that this Ethernet driver supports. */
static struct pci_device_id id_table[] = {
    { PCI_DEVICE(PCI_VENDOR_ID_NF10, PCI_DEVICE_ID_NF10_REF_NIC), }, /* NetFPGA-10G Reference NIC. */
    { 0, }
};
/* Creates a symbol used by depmod to tell the kernel that these devices 
 * are associated with this driver module. This is communicated via the 
 * /lib/modules/KVERSION/modules.pcimap file, written to by depmod. */
MODULE_DEVICE_TABLE(pci, id_table);

/* Define our net_device operations here. */
static int nf10_ndo_open(struct net_device *netdev)
{
    PDEBUG("nf10_ndo_open(): Opening net device\n");    

    /* Tell the kernel we're ready for transmitting packets. */
    netif_start_queue(netdev);

    return 0;
}

static int nf10_ndo_stop(struct net_device *netdev)
{
    PDEBUG("nf10_ndo_stop(): Closing net device\n");    

    /* Tell the kernel we can't transmit anymore. */
    netif_stop_queue(netdev);

    return 0;
}

uint32_t get_iface_from_netdev(struct net_device *netdev)
{
    int i;

    for(i = 0; i < NUM_NETDEVS; i++) {
        if(nf10_netdevs[i] == netdev)
            return i;
    }

    return -1;
}

static netdev_tx_t nf10_ndo_start_xmit(struct sk_buff *skb, struct net_device *netdev)
{
    void        *data;
    uint32_t    len;
    int         waited;
    int         iface;
    uint32_t    opcode;

    PDEBUG("nf10_ndo_start_xmit(): Transmitting packet\n");    

    /* Get data and length. */
    data = (void*)skb->data;
    len = skb->len;

    /* FIXME: When hardware is ready, may need to insert code here to check that the length
     * is within the limits of what the hardware can handle. For now I'll just use this 
     * temporary check */
    /* Also wondering for len... if the preamble/FCS are included. */
    if(len < ETH_ZLEN || len > ETH_FRAME_LEN) {
        PDEBUG("nf10_ndo_start_xmit(): packet length %d out of bounds [%d, %d]. Sending anyway.\n", len, ETH_ZLEN, ETH_FRAME_LEN);
    }

    /* Check length against the DMA buffer size. */
    if(len > DMA_BUF_SIZE) {
        printk(KERN_ERR "%s: ERROR: nf10_ndo_start_xmit(): packet length %d greater than buffer size %d\n", driver_name, len, DMA_BUF_SIZE);
        netdev->stats.tx_dropped++;;
        dev_kfree_skb(skb);
        /* FIXME: not really sure of the right return value in this case... */
        return NETDEV_TX_OK;
    }

    /* Check that the hardware is actually there and working. */
    if(!((hw_state & HW_FOUND) && (hw_state & HW_INIT))) {
        printk(KERN_WARNING "%s: WARNING: nf10_ndo_start_xmit(): trying to send packet but hardware was not found or was not initialized properly... dropping\n", driver_name);
        netdev->stats.tx_dropped++; 
        dev_kfree_skb(skb);
        return NETDEV_TX_OK;
    }
    
    /* Opcode for setting source and destination ports. */
    opcode = 0;
    iface = get_iface_from_netdev(netdev);
    if(iface < 0) {
        printk(KERN_ERR "%s: ERROR: nf10_ndo_start_xmit(): could not determine source interface number from netdev\n", driver_name);
        netdev->stats.tx_dropped++;
        dev_kfree_skb(skb);
        /* FIXME: not really sure of the right return value in this case... */
        return NETDEV_TX_OK;
    }
    tx_set_src_iface(&opcode, iface); 

    /* DMA the packet to the hardware. */

    /* Start the clock! */
    netdev->trans_start = jiffies;

    /* Wait for buffer to be free. */
    /* FIXME: Want to use netif_{stop,wake}_queue functions, except that presently we have
     * no interrupts for tx, so we don't have a proper way to call netif_wake_queue aside
     * from setting a timer and a callback. For now... just wait. */
    /* Perhaps another solution for now would be to just drop the packet after so many tries. */
    waited = 0;
    while(tx_dma_stream.flags[tx_dma_stream.buf_index] == 0) {
        if(!waited)
            PDEBUG("nf10_ndo_start_xmit(): waiting for buffer: %d\n", tx_dma_stream.buf_index);
        waited = 1;
    }

    /* Copy message into buffer. */
    memcpy((void*)&tx_dma_stream.buffers[tx_dma_stream.buf_index * DMA_BUF_SIZE], data, len);

    /* FIXME: Do I need to dev_kfree_skb(skb) here? It seems like this is only done on error. */

    /* Fill out metadata. */
    /* Length. */
    tx_dma_stream.metadata[tx_dma_stream.buf_index].length = len;
    /* OpCode. */
    tx_dma_stream.metadata[tx_dma_stream.buf_index].opCode = opcode;

    /* Set the buffer flag to full. */
    tx_dma_stream.flags[tx_dma_stream.buf_index] = 0;

    PDEBUG("nf10_ndo_start_xmit(): DMA TX operation info:\n"
        "\tMessage length:\t\t%d\n"
        "\tOpcode:\t\t\t0x%08x\n"
        "\tUsing buffer number:\t%d\n",
        skb->len, opcode, tx_dma_stream.buf_index);

    /* Make sure all the writes have been done before ringing the doorbell. */
    wmb();

    /* Tell hardware we filled a buffer. */
    *tx_dma_stream.doorbell = 1;

    /* Update the buffer index. */
    if(++tx_dma_stream.buf_index == dma_cpu_bufs)
        tx_dma_stream.buf_index = 0;

    /* Update the statistics. */
    netdev->stats.tx_packets++;
    netdev->stats.tx_bytes += len;

    return NETDEV_TX_OK;
}

/* Helper functions for getting and setting source and destination
 * ports. The interpretation of opcode depends on the direction the
 * packet is headed, therefore we need {rx,tx}x{src,dst}x{get,set}
 * functions. */
uint32_t rx_get_dst_iface(uint32_t opcode)
{
    if(opcode & OPCODE_CPU0)
        return 0;
    else if(opcode & OPCODE_CPU1)
        return 1;
    else if(opcode & OPCODE_CPU2)
        return 2;
    else if(opcode & OPCODE_CPU3)
        return 3;
    else
        return -1;
}

uint32_t rx_get_src_iface(uint32_t opcode)
{
    if(opcode & OPCODE_MAC0)
        return 0;
    else if(opcode & OPCODE_MAC1)
        return 1;
    else if(opcode & OPCODE_MAC2)
        return 2;
    else if(opcode & OPCODE_MAC3)
        return 3;
    else
        return -1;
}

void rx_set_dst_iface(uint32_t *opcode, uint32_t dst_iface)
{
    *opcode &= ~OPCODE_CPU_ALL; /* Clear destination bits. */

    if(dst_iface == 0)
        *opcode |= OPCODE_CPU0;
    else if(dst_iface == 1)
        *opcode |= OPCODE_CPU1;
    else if(dst_iface == 2)
        *opcode |= OPCODE_CPU2;
    else if(dst_iface == 3)
        *opcode |= OPCODE_CPU3;
}

void rx_set_src_iface(uint32_t *opcode, uint32_t src_iface)
{
    *opcode &= ~OPCODE_MAC_ALL; /* Clear source bits. */

    if(src_iface == 0)
        *opcode |= OPCODE_MAC0;
    else if(src_iface == 1)
        *opcode |= OPCODE_MAC1;
    else if(src_iface == 2)
        *opcode |= OPCODE_MAC2;
    else if(src_iface == 3)
        *opcode |= OPCODE_MAC3; 
}

uint32_t tx_get_dst_iface(uint32_t opcode)
{
    return rx_get_src_iface(opcode);
}

uint32_t tx_get_src_iface(uint32_t opcode)
{
    return rx_get_dst_iface(opcode);
}

void tx_set_dst_iface(uint32_t *opcode, uint32_t dst_iface)
{
    rx_set_src_iface(opcode, dst_iface);
}

void tx_set_src_iface(uint32_t *opcode, uint32_t src_iface)
{
    rx_set_dst_iface(opcode, src_iface);
}

/* Callback function for the rx_poll_timer. */
static void rx_poll_timer_cb(unsigned long arg)
{
    //PDEBUG("rx_poll_timer_fn(): Timer fired\n");
    
    /* Check for received packets. */
    if(rx_dma_stream.flags[rx_dma_stream.buf_index] == 1) {
        /* Schedule a poll. */
        napi_schedule(&nf10_napi_struct);
    } else {
        rx_poll_timer.expires += RX_POLL_INTERVAL;
        add_timer(&rx_poll_timer);
    }
}

/* Slurp up packets. */
static int nf10_napi_struct_poll(struct napi_struct *napi, int budget)
{
    int             n_rx = 0;
    struct sk_buff  *skb;
    int             buf_index = rx_dma_stream.buf_index;
    int             dst_iface; /* Destination interface. */
    
    while(n_rx < budget && rx_dma_stream.flags[buf_index] == 1) {

        PDEBUG("nf10_napi_struct_poll(): DMA RX operation info:\n"
            "\tMessage length:\t\t%d\n"
            "\tMessage opCode:\t\t0x%08x\n"
            "\tFrom buffer number:\t%d\n",
            rx_dma_stream.metadata[buf_index].length, 
            rx_dma_stream.metadata[buf_index].opCode,
            buf_index);

        dst_iface = rx_get_dst_iface(rx_dma_stream.metadata[buf_index].opCode);
        if(dst_iface < 0) {
            printk(KERN_NOTICE "NOTICE: nf10_napi_struct_poll(): failed to determine destination Ethernet interface from opcode (0x%08x)... dropping the packet\n", rx_dma_stream.metadata[buf_index].opCode);

            /* Mark the buffer as empty. */
            rx_dma_stream.flags[buf_index] = 0;

            /* Tell the hardware we emptied the buffer. */
            *rx_dma_stream.doorbell = 1;

            /* Update the buffer index. */
            if(++rx_dma_stream.buf_index == dma_cpu_bufs)
                rx_dma_stream.buf_index = 0;

            buf_index = rx_dma_stream.buf_index;   

            continue; 
        }

        /* FIXME: Do I need to allocate any more room than this? Don't
         * think so... snull driver has a +2 here */
        skb = dev_alloc_skb(rx_dma_stream.metadata[buf_index].length);
        if(!skb) {
            printk(KERN_NOTICE "NOTICE: nf10_napi_struct_poll(): failed to allocate skb, packet dropped\n");

            /* Mark the buffer as empty. */
            rx_dma_stream.flags[buf_index] = 0;

            /* Tell the hardware we emptied the buffer. */
            *rx_dma_stream.doorbell = 1;

            /* Update the buffer index. */
            if(++rx_dma_stream.buf_index == dma_cpu_bufs)
                rx_dma_stream.buf_index = 0;

            buf_index = rx_dma_stream.buf_index;   

            /* Update statistics. */
            nf10_netdevs[dst_iface]->stats.rx_dropped++; 

            continue;
        }

        memcpy( skb_put(skb, rx_dma_stream.metadata[buf_index].length),
                (void*)&rx_dma_stream.buffers[buf_index * DMA_BUF_SIZE],
                rx_dma_stream.metadata[buf_index].length);
        
        skb->dev = nf10_netdevs[dst_iface];
        /* FIXME: need to set ip_summed? */
        skb->protocol = eth_type_trans(skb, nf10_netdevs[dst_iface]);
        
        PDEBUG("nf10_napi_struct_poll(): received a packet!\n");

        netif_receive_skb(skb);

        /* Mark the buffer as empty. */
        rx_dma_stream.flags[buf_index] = 0;

        /* Tell the hardware we emptied the buffer. */
        *rx_dma_stream.doorbell = 1;

        /* Update the buffer index. */
        if(++rx_dma_stream.buf_index == dma_cpu_bufs)
            rx_dma_stream.buf_index = 0;
        
        /* Update statistics. */
        nf10_netdevs[dst_iface]->stats.rx_packets++;
        nf10_netdevs[dst_iface]->stats.rx_bytes += rx_dma_stream.metadata[buf_index].length;

        buf_index = rx_dma_stream.buf_index;       

        n_rx++;
    }    
    
    /* Check if we processed everything. */
    if(rx_dma_stream.flags[buf_index] == 0) {
        napi_complete(napi);
        rx_poll_timer.expires = jiffies + RX_POLL_INTERVAL;
        add_timer(&rx_poll_timer);
    }
    
    return n_rx;
}

static void nf10_ndo_tx_timeout(struct net_device *netdev)
{
    printk(KERN_WARNING "%s: WARNING: nf10_ndo_tx_timeout(): hit timeout!\n", driver_name);
}

static struct net_device_stats* nf10_ndo_get_stats(struct net_device *netdev)
{
    PDEBUG("nf10_ndo_get_stats(): Getting the stats\n");    
    
    return &netdev->stats;
}

static int nf10_ndo_set_mac_address(struct net_device *netdev, void *addr)
{ 
    struct sockaddr *saddr = addr;
    
    if(!is_valid_ether_addr(saddr->sa_data))
        return -EADDRNOTAVAIL;

    memcpy(netdev->dev_addr, saddr->sa_data, netdev->addr_len);    

    return 0;
}

/* When the kernel finds a device with a vendor and device ID associated with this driver
 * it will invoke this function. The job of this function is really to initialize the 
 * device that the kernel has already found for us... so the name 'probe' is a bit of a
 * misnomer. */
static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
{    
    /* OpenCPI */
    OccpSpace     *occp;
    OcdpProperties    *dp0_props;
    OcdpProperties    *dp1_props;
    uint32_t    *sma0_props;
    uint32_t    *sma1_props;
    uint32_t    *bias_props;
    OccpWorkerRegisters 
            *dp0_regs,
            *dp1_regs,
            *sma0_regs,
            *sma1_regs,
            *bias_regs;

    int err;
    
    printk(KERN_INFO "nf10_eth_driver: Found NetFPGA-10G device with vendor_id: 0x%4x, device_id: 0x%4x\n", id->vendor, id->device);    

    /* The hardware has been found. */
    hw_state |= HW_FOUND;

    /* Enable the device. pci_enable_device() will do the following (ref. PCI/pci.txt kernel doc):
     *     - wake up the device if it was in suspended state
     *     - allocate I/O and memory regions of the device (if BIOS did not)
     *     - allocate an IRQ (if BIOS did not) */
    err = pci_enable_device(pdev);
    if(err) {
        PDEBUG("probe(): pci_enable_device failed with error code: %d\n", err);    
        return err;
    }

    /* Enable DMA functionality for the device. 
     * pci_set_master() does this by (ref. PCI/pci.txt kernel doc) setting the bus master bit
     * in the PCI_COMMAND register. pci_clear_master() will disable DMA by clearing the bit. 
     * This function also sets the latency timer value if necessary. */
    pci_set_master(pdev);

    /* Mark BAR0 MMIO region as reserved by this driver. */
    err = pci_request_region(pdev, BAR_0, driver_name); 
    if(err) {
        printk(KERN_ERR "%s: ERROR: probe(): could not reserve BAR0 memory-mapped I/O region\n", driver_name);
        pci_disable_device(pdev);
        return err;
    }
    
    /* Remap BAR0 MMIO region into our address space. */
    bar0_base_va = pci_ioremap_bar(pdev, BAR_0);
    if(bar0_base_va == NULL) {
        printk(KERN_ERR "%s: ERROR: probe(): could not remap BAR0 memory-mapped I/O region into our address space\n", driver_name);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);
        /* FIXME: is this the right error code? */
        return -ENOMEM;
    }
    
    /* Take note of the size. */
    bar0_size = pci_resource_len(pdev, BAR_0);

    /* Check to make sure it's as large as we expect it to be. */
    if(!(bar0_size >= sizeof(OccpSpace))) {
        printk(KERN_ERR "%s: ERROR: probe(): expected BAR0 memory-mapped I/O region to be at least %lu bytes in size, but it is only %d bytes\n", driver_name, sizeof(OccpSpace), bar0_size);
        iounmap(bar0_base_va);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);    
        return -1;    
    }

    PDEBUG("probe(): successfully mapped BAR0 MMIO region:\n"
        "\tBAR0: Virtual address:\t\t0x%016llx\n"
        "\tBAR0: Physical address:\t\t0x%016llx\n"
        "\tBAR0 Size:\t\t\t%d\n",
        /* FIXME: typcasting might throw warnings on 32-bit systems... */
        (uint64_t)bar0_base_va, (uint64_t)pci_resource_start(pdev, BAR_0), bar0_size);

    /* Negotiate with the kernel where we can allocate DMA-capable memory regions.
     * We do this with a call to dma_set_mask. Through this function we inform
     * the kernel of what physical memory addresses our device is capable of 
     * addressing via DMA. Through the function's return value, the kernel
     * informs us of whether or not this machine's DMA controller is capable of
     * supporting our request. A return value of 0 completes the "handshake" and
     * all further DMA memory allocations will come from this region, set by the
     * mask. */
    err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
    if(err) {
        printk(KERN_ERR "%s: ERROR: probe(): this machine's DMA controller does not support the DMA address limitations of this device\n", driver_name);
        iounmap(bar0_base_va);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);    
        return err;
    }

    /* Since future DMA memory allocations will be coherent regions with the CPU
     * cache, we must additionally call dma_set_coherent_mask, which performs the
     * same negotiation process. It is guaranteed to work for a region equal to 
     * or smaller than that which we agreed upon with dma_set_mask... but we check
     * its return value just in case. */
    err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
    if(err) {
        printk(KERN_ERR "%s: ERROR: probe(): this machine's DMA controller does not support the coherent DMA address limitations of this device\n", driver_name);
        iounmap(bar0_base_va);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);    
        return err;
    }

    for(dma_cpu_bufs = DMA_CPU_BUFS; dma_cpu_bufs > MIN_DMA_CPU_BUFS; dma_cpu_bufs /= 2) {
        dma_region_size = ((DMA_BUF_SIZE + OCDP_METADATA_SIZE + sizeof(uint32_t)) * dma_cpu_bufs);
        
        /* Allocate TX DMA region. */
        /* Using __GFP_NOWARN flag because otherwise the kernel printk warns us when 
         * the allocation fails, which is unnecessary since we print our own msg. */
        tx_dma_reg_va = dma_alloc_coherent(&pdev->dev, dma_region_size, &tx_dma_reg_pa, GFP_KERNEL | __GFP_NOWARN);
        if(tx_dma_reg_va == NULL) {
            printk(KERN_ERR "nf10_eth_driver: ERROR: probe(): failed to alloc TX DMA region of size %d bytes... trying less\n", dma_region_size);
            /* Try smaller allocation. */
            continue;
        }

        /* Allocate RX DMA region. */
        rx_dma_reg_va = dma_alloc_coherent(&pdev->dev, dma_region_size, &rx_dma_reg_pa, GFP_KERNEL | __GFP_NOWARN);
        if(rx_dma_reg_va == NULL) {
            /* FIXME: replace all nf10_eth_driver with driver_name string in format. */
            printk(KERN_ERR "nf10_eth_driver: ERROR: probe(): failed to alloc RX DMA region of size %d bytes... trying less\n", dma_region_size);
            dma_free_coherent(&pdev->dev, dma_region_size, tx_dma_reg_va, tx_dma_reg_pa);
            /* Try smaller allocation. */
            continue;
        }

        /* Both memory regions have been allocated successfully. */   
        break;
 
        /* FIXME: Should I zero the memory? */
        /* FIXME: Insert a check to make sure that the memory regions really are in the lower
         * 32-bits of the address space. */
    }

    /* Check that the memory allocations succeeded. */
    if(tx_dma_reg_va == NULL || rx_dma_reg_va == NULL) {
        printk(KERN_ERR "nf10_eth_driver: ERROR: probe(): failed to allocate DMA regions\n");
        iounmap(bar0_base_va);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);    
        return err;        
    }
    
    PDEBUG("probe(): successfully allocated the TX and RX DMA regions:\n"
        "\tTX Region: Virtual address:\t0x%016llx\n"
        "\tTX Region: Physical address:\t0x%016llx\n"
        "\tTX Region Size:\t\t\t%d\n"
        "\tRX Region: Virtual address:\t0x%016llx\n"
        "\tRX Region: Physical address:\t0x%016llx\n"
        "\tRX Region Size:\t\t\t%d\n",
        /* FIXME: typcasting might throw warnings on 32-bit systems... */
        (uint64_t)tx_dma_reg_va, (uint64_t)tx_dma_reg_pa, dma_region_size,
        (uint64_t)rx_dma_reg_va, (uint64_t)rx_dma_reg_pa, dma_region_size);

    /* Now we begin to structure the BAR0 MMIO region as the set of control and status
     * registers that it is. Once we setup this structure, then we proceed to reset,
     * initialize, and then start the hardware components. */

    occp        = (OccpSpace *)bar0_base_va;

    dp0_props   = (OcdpProperties *)occp->config[WORKER_DP0];
    dp1_props   = (OcdpProperties *)occp->config[WORKER_DP1];
    sma0_props  = (uint32_t *)occp->config[WORKER_SMA0];
    sma1_props  = (uint32_t *)occp->config[WORKER_SMA1];
    bias_props  = (uint32_t *)occp->config[WORKER_BIAS];
    
    dp0_regs    = &occp->worker[WORKER_DP0].control,
    dp1_regs    = &occp->worker[WORKER_DP1].control,
    sma0_regs   = &occp->worker[WORKER_SMA0].control,
    sma1_regs   = &occp->worker[WORKER_SMA1].control,
    bias_regs   = &occp->worker[WORKER_BIAS].control;

    /* For NF10 register access and control.
     * Please forgive my blatant violation of naming consistency. Props and regs
     * just don't make sense for this particular context. */
    /* Note: nf10_regs is a pointer to a 1MB register region. It is used in conjunction 
     * with a 12-bit page register in nf10_ctrl to access up to 4GB of registers. See 
     * genl_cmd_reg_rd and genl_cmd_reg_wr to see how to use these to read and write
     * registers in an NF10 design in a 32-bit register address space. */
    nf10_regs   = (uint32_t *)occp->config[WORKER_NF10];
    nf10_ctrl   = &occp->worker[WORKER_NF10].control;
 
    /* Reset workers. */

    /* Assert reset. */
    dp0_regs->control   = OCCP_LOG_TIMEOUT;
    dp1_regs->control   = OCCP_LOG_TIMEOUT;
    sma0_regs->control  = OCCP_LOG_TIMEOUT;
    sma1_regs->control  = OCCP_LOG_TIMEOUT;
    bias_regs->control  = OCCP_LOG_TIMEOUT;    
    nf10_ctrl->control  = OCCP_LOG_TIMEOUT;

    /* Write memory barrier. */
    wmb();

    /* Take out of reset. */
    dp0_regs->control   = OCCP_CONTROL_ENABLE | OCCP_LOG_TIMEOUT;    
    dp1_regs->control   = OCCP_CONTROL_ENABLE | OCCP_LOG_TIMEOUT;
    sma0_regs->control  = OCCP_CONTROL_ENABLE | OCCP_LOG_TIMEOUT;
    sma1_regs->control  = OCCP_CONTROL_ENABLE | OCCP_LOG_TIMEOUT;    
    bias_regs->control  = OCCP_CONTROL_ENABLE | OCCP_LOG_TIMEOUT;
    nf10_ctrl->control  = OCCP_CONTROL_ENABLE | OCCP_LOG_TIMEOUT;   
    
    /* Read/Write memory barrier. */
    mb();

    /* Initialize workers. */

    /* FIXME: need to double check everything below for problems with ooe. */

    if(dp0_regs->initialize != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker initialization failure for DP0 worker\n", driver_name);
        err = -1;
    }
    
    if(dp1_regs->initialize != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker initialization failure for DP1 worker\n", driver_name);
        err = -1;
    }

    if(sma0_regs->initialize != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker initialization failure for SMA0 worker\n", driver_name);
        err = -1;
    }

    if(sma1_regs->initialize != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker initialization failure for SMA1 worker\n", driver_name);
        err = -1;
    }

    if(bias_regs->initialize != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker initialization failure for BIAS worker\n", driver_name);
        err = -1;
    }
    
    if(nf10_ctrl->initialize != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker initialization failure for NF10 worker\n", driver_name);
        err = -1;
    }

    if(err) {
        dma_free_coherent(&pdev->dev, dma_region_size, rx_dma_reg_va, rx_dma_reg_pa);
        dma_free_coherent(&pdev->dev, dma_region_size, tx_dma_reg_va, tx_dma_reg_pa);
        iounmap(bar0_base_va);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);    
        return err;
    }

    mb();

    /* Configure workers. */

    *sma0_props = 1;
    *bias_props = 0;
    *sma1_props = 2;

    tx_dma_stream.buffers    = (uint8_t *)tx_dma_reg_va;
    tx_dma_stream.metadata    = (OcdpMetadata *)(tx_dma_stream.buffers + dma_cpu_bufs * DMA_BUF_SIZE);
    tx_dma_stream.flags    = (uint32_t *)(tx_dma_stream.metadata + dma_cpu_bufs);
    tx_dma_stream.doorbell    = &dp0_props->nRemoteDone; 
    tx_dma_stream.buf_index    = 0;
    memset((void*)tx_dma_stream.flags, 1, dma_cpu_bufs * sizeof(uint32_t));

    dp0_props->nLocalBuffers     = DMA_FPGA_BUFS;
    dp0_props->nRemoteBuffers     = dma_cpu_bufs;
    dp0_props->localBufferBase     = 0;
    dp0_props->localMetadataBase     = DMA_FPGA_BUFS * DMA_BUF_SIZE;
    dp0_props->localBufferSize     = DMA_BUF_SIZE;
    dp0_props->localMetadataSize     = sizeof(OcdpMetadata);
    dp0_props->memoryBytes        = 32*1024; /* FIXME: What is this?? */
    dp0_props->remoteBufferBase    = (uint32_t)tx_dma_reg_pa;
    dp0_props->remoteMetadataBase    = (uint32_t)tx_dma_reg_pa + dma_cpu_bufs * DMA_BUF_SIZE;
    dp0_props->remoteBufferSize    = DMA_BUF_SIZE;
    dp0_props->remoteMetadataSize    = sizeof(OcdpMetadata);
    dp0_props->remoteFlagBase    = (uint32_t)tx_dma_reg_pa + (DMA_BUF_SIZE + sizeof(OcdpMetadata)) * dma_cpu_bufs;
    dp0_props->remoteFlagPitch    = sizeof(uint32_t);
    dp0_props->control        = OCDP_CONTROL(OCDP_CONTROL_CONSUMER, OCDP_ACTIVE_MESSAGE);

    rx_dma_stream.buffers    = (uint8_t *)rx_dma_reg_va;
    rx_dma_stream.metadata    = (OcdpMetadata *)(rx_dma_stream.buffers + dma_cpu_bufs * DMA_BUF_SIZE);
    rx_dma_stream.flags    = (uint32_t *)(rx_dma_stream.metadata + dma_cpu_bufs);
    rx_dma_stream.doorbell    = &dp1_props->nRemoteDone; 
    rx_dma_stream.buf_index    = 0;
    memset((void*)rx_dma_stream.flags, 0, dma_cpu_bufs * sizeof(uint32_t));

    dp1_props->nLocalBuffers     = DMA_FPGA_BUFS;
    dp1_props->nRemoteBuffers     = dma_cpu_bufs;
    dp1_props->localBufferBase     = 0;
    dp1_props->localMetadataBase     = DMA_FPGA_BUFS * DMA_BUF_SIZE;
    dp1_props->localBufferSize     = DMA_BUF_SIZE;
    dp1_props->localMetadataSize     = sizeof(OcdpMetadata);
    dp1_props->memoryBytes        = 32*1024; /* FIXME: What is this?? */
    dp1_props->remoteBufferBase    = (uint32_t)rx_dma_reg_pa;
    dp1_props->remoteMetadataBase    = (uint32_t)rx_dma_reg_pa + dma_cpu_bufs * DMA_BUF_SIZE;
    dp1_props->remoteBufferSize    = DMA_BUF_SIZE;
    dp1_props->remoteMetadataSize    = sizeof(OcdpMetadata);
    dp1_props->remoteFlagBase    = (uint32_t)rx_dma_reg_pa + (DMA_BUF_SIZE + sizeof(OcdpMetadata)) * dma_cpu_bufs;
    dp1_props->remoteFlagPitch    = sizeof(uint32_t);
    dp1_props->control        = OCDP_CONTROL(OCDP_CONTROL_PRODUCER, OCDP_ACTIVE_MESSAGE);
    
    mb();

    PDEBUG("probe(): configured dataplane OCPI workers:\n"
        "\tTX path dataplane properties (dp0, worker %d):\n"
        "\t\tnLocalBuffers:\t\t%d\n"
        "\t\tnRemoteBuffers:\t\t%d\n"
        "\t\tlocalBufferBase:\t0x%08x\n"
        "\t\tlocalMetadataBase:\t0x%08x\n"
        "\t\tlocalBufferSize:\t%d\n"
        "\t\tlocalMetadataSize:\t%d\n"
        "\t\tmemoryBytes:\t\t%d\n"
        "\t\tremoteBufferBase:\t0x%08x\n"
        "\t\tremoteMetadataBase:\t0x%08x\n"
        "\t\tremoteBufferSize:\t%d\n"
        "\t\tremoteMetadataSize:\t%d\n"
        "\t\tremoteFlagBase:\t\t0x%08x\n"
        "\t\tremoteFlagPitch:\t%d\n"
        "\tRX path dataplane properties (dp1, worker %d):\n"
        "\t\tnLocalBuffers:\t\t%d\n"
        "\t\tnRemoteBuffers:\t\t%d\n"
        "\t\tlocalBufferBase:\t0x%08x\n"
        "\t\tlocalMetadataBase:\t0x%08x\n"
        "\t\tlocalBufferSize:\t%d\n"
        "\t\tlocalMetadataSize:\t%d\n"
        "\t\tmemoryBytes:\t\t%d\n"
        "\t\tremoteBufferBase:\t0x%08x\n"
        "\t\tremoteMetadataBase:\t0x%08x\n"
        "\t\tremoteBufferSize:\t%d\n"
        "\t\tremoteMetadataSize:\t%d\n"
        "\t\tremoteFlagBase:\t\t0x%08x\n"
        "\t\tremoteFlagPitch:\t%d\n",
        WORKER_DP0,
        dp0_props->nLocalBuffers,
        dp0_props->nRemoteBuffers,
        dp0_props->localBufferBase,
        dp0_props->localMetadataBase,
        dp0_props->localBufferSize,
        dp0_props->localMetadataSize,
        dp0_props->memoryBytes,
        dp0_props->remoteBufferBase,
        dp0_props->remoteMetadataBase,
        dp0_props->remoteBufferSize,
        dp0_props->remoteMetadataSize,
        dp0_props->remoteFlagBase,
        dp0_props->remoteFlagPitch,
        WORKER_DP1,
        dp1_props->nLocalBuffers,
        dp1_props->nRemoteBuffers,
        dp1_props->localBufferBase,
        dp1_props->localMetadataBase,
        dp1_props->localBufferSize,
        dp1_props->localMetadataSize,
        dp1_props->memoryBytes,
        dp1_props->remoteBufferBase,
        dp1_props->remoteMetadataBase,
        dp1_props->remoteBufferSize,
        dp1_props->remoteMetadataSize,
        dp1_props->remoteFlagBase,
        dp1_props->remoteFlagPitch);

    /* Start workers. */

    if(dp0_regs->start != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker start failure for DP0\n", driver_name);
        err = -1;
    }
    
    if(dp1_regs->start != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker start failure for DP1\n", driver_name);
        err = -1;
    }

    if(sma0_regs->start != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker start failure for SMA0\n", driver_name);
        err = -1;
    }

    if(sma1_regs->start != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker start failure for SMA1\n", driver_name);
        err = -1;
    }

    if(bias_regs->start != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker start failure for bias worker\n", driver_name);
        err = -1;
    }
    
    if(nf10_ctrl->start != OCCP_SUCCESS_RESULT) {
        printk(KERN_ERR "%s: ERROR: probe(): OpenCPI worker start failure for nf10 worker\n", driver_name);
        err = -1;
    }

    if(err) {
        dma_free_coherent(&pdev->dev, dma_region_size, rx_dma_reg_va, rx_dma_reg_pa);
        dma_free_coherent(&pdev->dev, dma_region_size, tx_dma_reg_va, tx_dma_reg_pa);
        iounmap(bar0_base_va);
        pci_release_region(pdev, BAR_0);
        pci_disable_device(pdev);    
        return err;
    }
  
    /* Hardware has been successfully initialized. */
    hw_state |= HW_INIT;
 
    /* Start the polling timer for receiving packets. */
    rx_poll_timer.expires = jiffies + RX_POLL_INTERVAL;
    add_timer(&rx_poll_timer);
 
    return err;
}


static void remove(struct pci_dev *pdev)
{
    PDEBUG("remove(): entering remove()\n");
    
    dma_free_coherent(&pdev->dev, dma_region_size, rx_dma_reg_va, rx_dma_reg_pa);
    dma_free_coherent(&pdev->dev, dma_region_size, tx_dma_reg_va, tx_dma_reg_pa);
    iounmap(bar0_base_va);
    pci_release_region(pdev, BAR_0);
    pci_disable_device(pdev);    
}

static struct pci_driver nf10_pci_driver = {
    .name       = "nf10_eth_driver: pci_driver",
    .id_table   = id_table,
    .probe      = probe,
    .remove     = remove,
};

/* Called to fill @buf when user reads our file in /proc. */
int read_proc(char *buf, char **start, off_t offset, int count, int *eof, void *data)
{
    unsigned int c;
    int i;
    
    c = sprintf(buf, "NetFPGA-10G Ethernet Driver\n-----------------------------\n");
    c += sprintf(&buf[c], "TX Flags:\n");    

    for(i=0; i<dma_cpu_bufs; i++)
        c += sprintf(&buf[c], "\t%d:\t0x%08x\n", i, tx_dma_stream.flags[i]);

    c += sprintf(&buf[c], "RX Flags:\n");
    
    for(i=0; i<dma_cpu_bufs; i++)
        c += sprintf(&buf[c], "\t%d:\t0x%08x\n", i, rx_dma_stream.flags[i]);    

    *eof = 1;
    return c; 
}

void nf10_netdev_init(struct net_device *netdev)
{
    PDEBUG("nf10_netdev_init(): Initializing nf10_netdev\n");    

    ether_setup(netdev);

    netdev->netdev_ops = &nf10_netdev_ops;

    netdev->watchdog_timeo = 5 * HZ;
}

/* Initialization. */
static int __init nf10_eth_driver_init(void)
{
    uint32_t    mac_addr_len;
    int         err;
    int         i;    

    PDEBUG("nf10_eth_driver_init(): loading ethernet driver\n");

    /* Allocate the network interfaces. */
    for(i = 0; i < NUM_NETDEVS; i++) {
        nf10_netdevs[i] = alloc_netdev(0, "nf%d", nf10_netdev_init);
        if(nf10_netdevs[i] == NULL) {
            printk(KERN_ERR "nf10_eth_driver: ERROR: nf10_eth_driver_init(): failed to allocate net_device %d... unloading driver\n", i);
            
            for(i = i-1; i >= 0; i--) 
                free_netdev(nf10_netdevs[i]);

            pci_unregister_driver(&nf10_pci_driver);
            return -ENOMEM;
        }
    }

    PDEBUG("nf10_eth_driver_init(): allocating netdevs... victory!\n");
    
    mac_addr_len = nf10_netdevs[0]->addr_len;
    char mac_addr[mac_addr_len+1];

    /* Set network interface MAC addresses. */
    for(i = 0; i < NUM_NETDEVS; i++) {
        memset(mac_addr, 0, mac_addr_len+1);
        snprintf(&mac_addr[1], mac_addr_len, "NF%d", i);
        memcpy(nf10_netdevs[i]->dev_addr, mac_addr, mac_addr_len);
    }
    
    PDEBUG("nf10_eth_driver_init(): setting netdev MAC addresses... victory!\n");

    /* Add NAPI structure to the device. */
    /* Since we have NUM_NETDEVS net_devices, we just use the 1st one for implementing polling. */ 
    netif_napi_add(nf10_netdevs[0], &nf10_napi_struct, nf10_napi_struct_poll, RX_POLL_WEIGHT);

    PDEBUG("nf10_eth_driver_init(): adding napi struct... victory!\n");

    /* Register the network interfaces. */
    for(i = 0; i < NUM_NETDEVS; i++) {
        err = register_netdev(nf10_netdevs[i]);
        if(err != 0) {
            printk(KERN_ERR "nf10_eth_driver: ERROR: nf10_eth_driver_init(): failed to register net_device %d... unloading driver\n", i);
            
            for(i = i-1; i >= 0; i--)
                unregister_netdev(nf10_netdevs[i]);
            
            netif_napi_del(&nf10_napi_struct);
            
            for(i = 0; i < NUM_NETDEVS; i++);
                free_netdev(nf10_netdevs[i]);

            pci_unregister_driver(&nf10_pci_driver);
            return err;
        }
    }

    PDEBUG("nf10_eth_driver_init(): registering netdevs... victory!\n");

    /* Register our Generic Netlink family. */
    err = genl_register_family(&nf10_genl_family);
    if(err != 0) {
        printk(KERN_ERR "nf10_eth_driver: ERROR: nf10_eth_driver_init(): GENL family registration failed... unloading driver\n");
       
        for(i = 0; i < NUM_NETDEVS; i++) {
            unregister_netdev(nf10_netdevs[i]);
        } 

        netif_napi_del(&nf10_napi_struct);
     
        for(i = 0; i < NUM_NETDEVS; i++) {
            free_netdev(nf10_netdevs[i]);
        }

        pci_unregister_driver(&nf10_pci_driver);
        return err;
    }

    PDEBUG("nf10_eth_driver_init(): registering genl family... victory!\n");

    /* Register operations with our Generic Netlink family. */
    for(i = 0; i < ARRAY_SIZE(genl_all_ops); i++) {
        err = genl_register_ops(&nf10_genl_family, genl_all_ops[i]);
        if(err != 0) {
            printk(KERN_ERR "nf10_eth_diver: ERROR: nf10_eth_driver_init(): GENL ops registration failed... unloading driver\n");

            genl_unregister_family(&nf10_genl_family);

            for(i = 0; i < NUM_NETDEVS; i++) {
                unregister_netdev(nf10_netdevs[i]);
            } 

            netif_napi_del(&nf10_napi_struct);
     
            for(i = 0; i < NUM_NETDEVS; i++) {
                free_netdev(nf10_netdevs[i]);
            }

            pci_unregister_driver(&nf10_pci_driver);
            return err;
        }
    }

    PDEBUG("nf10_eth_driver_init(): registering genl operations... victory!\n");

    /* FIXME: Do we need to check for error on create_proc_read_entry? */
    create_proc_read_entry("driver/nf10_eth_driver", 0, NULL, read_proc, NULL);

    /* Enable NAPI. */
    napi_enable(&nf10_napi_struct);

     /* Register the pci_driver. 
     * Note: This will succeed even without a card installed in the system. */
    err = pci_register_driver(&nf10_pci_driver);
    if(err != 0) {
        printk(KERN_ERR "nf10_eth_driver: ERROR: nf10_eth_driver_init(): failed to register nf10_pci_driver... unloading driver\n");
        return err;
    } else
        PDEBUG("nf10_eth_driver_init(): pci_register_driver... victory!\n");

    /* Check the hardware state. */
    if(!(hw_state & HW_FOUND))
        printk(KERN_WARNING "nf10_eth_driver: WARNING: A NetFPGA-10G device was not found during driver loading...\n");
    else if(!(hw_state & HW_INIT))
        printk(KERN_WARNING "nf10_eth_driver: WARNING: A NetFPGA-10G device was found but could not be properly initialized... driver may be in an unstable state\n");

    printk(KERN_INFO "nf10_eth_driver: NetFPGA-10G Ethernet Driver version %s Loaded.\n", NF10_ETH_DRIVER_VERSION);
    
    return 0;
}

/* Deconstruction. */
static void __exit nf10_eth_driver_exit(void)
{
    int err;
    int i;

    /* Disable NAPI. */
    napi_disable(&nf10_napi_struct);

    /* Stop the polling timer for receiving packets. */
    del_timer(&rx_poll_timer);
    
    remove_proc_entry("driver/nf10_eth_driver", NULL);

    err = genl_unregister_family(&nf10_genl_family);
    if(err != 0)
        printk(KERN_ERR "nf10_eth_driver: ERROR: nf10_eth_driver_exit(): failed to unregister GENL family\n");

    for(i = 0; i < NUM_NETDEVS; i++) {
        unregister_netdev(nf10_netdevs[i]);
    } 

    netif_napi_del(&nf10_napi_struct);
    
    for(i = 0; i < NUM_NETDEVS; i++) {
        free_netdev(nf10_netdevs[i]);
    }

    pci_unregister_driver(&nf10_pci_driver);
    
    printk(KERN_INFO "nf10_eth_driver: NetFPGA-10G Ethernet Driver Unloaded.\n");
}

module_init(nf10_eth_driver_init);
module_exit(nf10_eth_driver_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Jonathan Ellithorpe");
MODULE_DESCRIPTION("A simple Ethernet driver for the NetFPGA-10G platform.");

