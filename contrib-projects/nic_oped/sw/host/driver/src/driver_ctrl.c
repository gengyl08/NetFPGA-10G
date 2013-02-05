/* FIXME: Add proper comment headers. */
/* NOTE: This program utilizes the libnl-3.0 library for generic netlink functions.
 * You must install this library before compiling (http://www.infradead.org/~tgr/libnl/). */

/* Header files provided by libnl (probably in /usr/local/include). */
#include <netlink/netlink.h>
#include <netlink/genl/genl.h>
#include <netlink/genl/ctrl.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdarg.h>
#include <getopt.h>

/* NF10 specific generic netlink definitions. */
#include "nf10_genl.h"

static void set_program_name(const char *);
static void parse_options(int, char*[]);
static void usage(void);
static int driver_connect(void);
static void driver_disconnect(void);

struct command {
    const char *name;
    int min_args;
    int max_args;
    void (*handler)(int argc, char *argv[]);
};

const char *program_name;

struct nl_sock *nf10_genl_sock;
int nf10_genl_family;

static struct command all_commands[];

int main(int argc, char *argv[])
{
    struct command *p;

    set_program_name(argv[0]);

    /* Move past program name. */
    argc -= 1;
    argv += 1;

    if(argc < 1) {
        printf("ERROR: main(): too few arguments\n\n");
        usage();
        return 0;
    }    

    for(p = all_commands; p->name != NULL; p++) {
        if(!strcmp(p->name, argv[0])) {
            int n_arg = argc - 1;
            if(n_arg < p->min_args) {
                printf("ERROR: main(): '%s' command requires at least %d arguments\n",
                    p->name, p->min_args);
                return 0;
            }
            else if(n_arg > p->max_args) {
                printf("ERROR: main(): '%s' command takes at most %d arguments\n",
                    p->name, p->max_args);
                return 0;
            }
            else {
                p->handler(argc, argv);
                return 0;
            }
        }
    }    

    printf("ERROR: main(): unknown command '%s'\n\n", argv[0]);
    usage();

    return 0;
}

static void set_program_name(const char *argv0)
{
    const char *slash = strrchr(argv0, '/');
    program_name = slash ? slash + 1 : argv0;
}

/* FIXME: delete this code... 
static void parse_options(int argc, char *argv[])
{
    static struct option long_options[] = {
        {"help", no_argument, 0, 'h'},
        {"version", no_argument, 0, 'V'},
        {0, 0, 0, 0},
    };
    char *short_options = long_options_to_short_options(long_options);

    for(;;) {
        int c;

        c = getopt_long(argc, argv, short_options, long_options, NULL);
        if(c == EOF) {
            break;
        }
    
        switch(c) {
        case 'h':
            usage();
            exit(EXIT_SUCCESS);

        case 'V':
            printf("%s compiled "__DATE__" "__TIME__"\n",
                program_name);
            exit(EXIT_SUCCESS);

        case '?':
            printf("ERROR: parse_options(): unknown option\n");
            exit(EXIT_FAILURE);

        default:
            abort();
        }
    }
    free(short_options);
}
*/

static void usage(void)
{
    printf("%s: NetFPGA-10G Ethernet driver management, control, and testing utility\n"
        "usage: %s [OPTIONS] COMMAND [ARG...]\n\n"
        "   echo STRING             Send STRING to driver, driver echoes it back.\n"
        "   dma_tx STRING [OPCODE]  Transmit STRING to the hardware via DMA w/ optional OPCODE.\n"
        "   dma_rx                  Pull out what's next in the DMA RX buffer and print it.\n"
        "   reg_rd ADDR             Read register at address ADDR.\n"
        "   reg_wr ADDR VAL         Write VAL to register at address ADDR.\n"
        "   napi_enable             Enable driver polling for RX packets.\n"
        "   napi_disable            Disable driver polling for RX packets.\n"
        "   help                    Print this help message.\n",
        program_name, program_name);
}

static int driver_connect()
{
    int err;

    nf10_genl_sock = nl_socket_alloc();
    if(nf10_genl_sock == NULL) {
        printf("ERROR: driver_connect(): could not allocate netlink socket\n");
        return -1;
    }

    err = genl_connect(nf10_genl_sock);
    if(err != 0) {
        printf("ERROR: driver_connect(): genl_connect failed\n");
        nl_socket_free(nf10_genl_sock);
        return err;
    }

    nf10_genl_family = genl_ctrl_resolve(nf10_genl_sock, NF10_GENL_FAMILY_NAME);
    if(nf10_genl_family < 0) {
        printf("ERROR: driver_connect(): could not resolve family channel number\n");
        nl_socket_free(nf10_genl_sock);
        return -1;
    }

    return 0;
}

static void driver_disconnect()
{
    nl_socket_free(nf10_genl_sock);
}

static int do_echo_recv_msg_cb(struct nl_msg *msg, void *arg)
{
    struct nlmsghdr *nlh;
    struct nlattr *attrs[NF10_GENL_A_MAX + 1];
    char *reply;    

    nlh = nlmsg_hdr(msg);

    genlmsg_parse(nlh, 0, attrs, NF10_GENL_A_MAX, 0);

    reply = nla_data(attrs[NF10_GENL_A_MSG]);
    if(reply == NULL) {
        printf("ERROR: do_echo_recv_msg_cb(): reply is NULL\n");
        return 0;
    }

    printf("Received reply:\n%s\n", reply);

    return 0;
}

static void do_echo(int argc, char *argv[])
{
    struct nl_msg    *msg;
    int err;    

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_echo(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_echo(): could not allocate new netlink message\n");
        driver_disconnect();
        return;
    }

    /* genlmsg_put will fill in the fields of the nlmsghdr and the genlmsghdr. */
    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_ECHO, NF10_GENL_FAMILY_VERSION);

    nla_put_string(msg, NF10_GENL_A_MSG, argv[1]);

    /* nl_send_auto will automatically fill in the PID and the sequence number,
     * and also add an NLM_F_REQUEST flag. It will also add an NLM_F_ACK
     * flag unless the netlink socket has the NL_NO_AUTO_ACK flag set. */
    nl_send_auto(nf10_genl_sock, msg);

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_VALID, NL_CB_CUSTOM, do_echo_recv_msg_cb, NULL);

    nl_recvmsgs_default(nf10_genl_sock);

    driver_disconnect();
}

static int do_dma_tx_recv_ack_cb(struct nl_msg *msg, void *arg)
{
    /* FIXME: msg doesn't really make sense to user... */
    //printf("Received ACK\n");

    return 0;
}


static void do_dma_tx(int argc, char *argv[])
{
    struct nl_msg    *msg;
    int err;    

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_dma_tx(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_dma_tx(): could not allocate new netlink message\n");
        /* FIXME: need to free the msg? */
        driver_disconnect();
        return;
    }

    /* genlmsg_put will fill in the fields of the nlmsghdr and the genlmsghdr. */
    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_DMA_TX, NF10_GENL_FAMILY_VERSION);

    err = nla_put_string(msg, NF10_GENL_A_MSG, argv[1]);
    if(err) {
        printf("ERROR: do_dma_tx(): could not put string in netlink message\n");
        /* FIXME: need to free the msg? */
        driver_disconnect();
        return;
    }

    if(argc == 3)
        nla_put_u32(msg, NF10_GENL_A_OPCODE, (uint32_t)strtoull(argv[2], NULL, 0));
    else
        nla_put_u32(msg, NF10_GENL_A_OPCODE, 0);

    /* nl_send_auto will automatically fill in the PID and the sequence number,
     * and also add an NLM_F_REQUEST flag. It will also add an NLM_F_ACK
     * flag unless the netlink socket has the NL_NO_AUTO_ACK flag set. */
    nl_send_auto(nf10_genl_sock, msg);

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_ACK, NL_CB_CUSTOM, do_dma_tx_recv_ack_cb, NULL);

    /* FIXME: this function will return even if there's no ACK in the buffer. I.E. it doesn't
     * seem to wait for the ACK to be received... Ideally we'd have the behavior that getting an 
     * ACK tells us everything is OK, otherwise we time out on waiting for an ACK and tell this
     * to the user. */
    nl_recvmsgs_default(nf10_genl_sock);

    driver_disconnect();
}

static int do_dma_rx_recv_msg_cb(struct nl_msg *msg, void *arg)
{
    struct nlmsghdr *nlh;
    struct nlattr    *na_msg, *na_opcode;
    struct nlattr *attrs[NF10_GENL_A_MAX + 1];

    nlh = nlmsg_hdr(msg);

    genlmsg_parse(nlh, 0, attrs, NF10_GENL_A_MAX, 0);

    na_msg = attrs[NF10_GENL_A_DMA_BUF];
    if(na_msg && nla_data(na_msg)) {
        printf("msg:\t%s\n", nla_data(na_msg));
        printf("len:\t%d\n", nla_len(na_msg));

        na_opcode = attrs[NF10_GENL_A_OPCODE];
        if(na_opcode && nla_data(na_opcode))
            printf("opcode:\t0x%08x\n", *(uint32_t*)nla_data(na_opcode)); 
    }
    else {
        printf("Didn't find any data to receive\n");
    }

    return 0;
    
}

static void do_dma_rx(int argc, char* argv[])
{
    struct nl_msg    *msg;
    int err;

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_dma_rx(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_dma_rx(): could not allocate new netlink message\n");
        driver_disconnect();
        return;
    }

    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_DMA_RX, NF10_GENL_FAMILY_VERSION);
    
    nl_send_auto(nf10_genl_sock, msg);

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_VALID, NL_CB_CUSTOM, do_dma_rx_recv_msg_cb, NULL);
    
    nl_recvmsgs_default(nf10_genl_sock);

    driver_disconnect();    
}

static int do_reg_rd_recv_msg_cb(struct nl_msg *msg, void *arg)
{
    struct nlmsghdr *nlh;
    struct nlattr   *na_regval;
    struct nlattr   *na_errno;
    struct nlattr   *attrs[NF10_GENL_A_MAX + 1];
    uint32_t        *val_ptr;
    int             err;

    val_ptr = (uint32_t*)arg;

    nlh = nlmsg_hdr(msg);

    genlmsg_parse(nlh, 0, attrs, NF10_GENL_A_MAX, 0);

    /* First, get the errno. */
    na_errno = attrs[NF10_GENL_A_ERRNO];
    if(na_errno && nla_data(na_errno)) {
        err = *(int*)nla_data(na_errno);
    } else {
        return -NLE_NOATTR;
    }

    /* If there was an error, pass is up. */
    if(err)
        return err;

    /* Passed error check, get register value. */
    na_regval = attrs[NF10_GENL_A_REGVAL32];
    if(na_regval && nla_data(na_regval)) {
        *val_ptr = *(uint32_t*)nla_data(na_regval);
        return 0;
    } else
        return -NLE_NOATTR;
}

static void do_reg_rd(int argc, char* argv[])
{
    struct nl_msg   *msg;
    int             err;  
    uint32_t        retval; 

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_reg_rd(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_reg_rd(): could not allocate new netlink message\n");
        driver_disconnect();
        return;
    }

    /* genlmsg_put will fill in the fields of the nlmsghdr and the genlmsghdr. */
    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_REG_RD, NF10_GENL_FAMILY_VERSION);

    nla_put_u32(msg, NF10_GENL_A_ADDR32, (uint32_t)strtoull(argv[1], NULL, 0));

    /* nl_send_auto will automatically fill in the PID and the sequence number,
     * and also add an NLM_F_REQUEST flag. It will also add an NLM_F_ACK
     * flag unless the netlink socket has the NL_NO_AUTO_ACK flag set. */
    err = nl_send_auto(nf10_genl_sock, msg);
    if(err < 0) {
        printf("ERROR: do_reg_rd(): couldn't send netlink message\n");
        nlmsg_free(msg);
        driver_disconnect();
        return;
    }

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_VALID, NL_CB_CUSTOM, do_reg_rd_recv_msg_cb, (void*)&retval);
    
    err = nl_recvmsgs_default(nf10_genl_sock);
    if(err)
        printf("ERROR: do_reg_rd(): driver reported back an error\n");
    else
        printf("0x%08x\n", retval);
    
    driver_disconnect();    
}

static int do_reg_wr_recv_ack_cb(struct nl_msg *msg, void *arg)
{
    struct nlmsghdr *nlh;
    struct nlattr   *na_errno;
    struct nlattr   *attrs[NF10_GENL_A_MAX + 1];
    int             err;

    nlh = nlmsg_hdr(msg);

    genlmsg_parse(nlh, 0, attrs, NF10_GENL_A_MAX, 0);

    /* Get the errno. */
    na_errno = attrs[NF10_GENL_A_ERRNO];
    if(na_errno && nla_data(na_errno)) {
        err = *(int*)nla_data(na_errno);
    } else {
        return -NLE_NOATTR;
    }

    return err;
}

static void do_reg_wr(int argc, char *argv[])
{
    struct nl_msg   *msg;
    int err;    

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_reg_wr(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_reg_wr(): could not allocate new netlink message\n");
        driver_disconnect();
        return;
    }

    /* genlmsg_put will fill in the fields of the nlmsghdr and the genlmsghdr. */
    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_REG_WR, NF10_GENL_FAMILY_VERSION);

    nla_put_u32(msg, NF10_GENL_A_ADDR32, (uint32_t)strtoull(argv[1], NULL, 0));
    nla_put_u32(msg, NF10_GENL_A_REGVAL32, (uint32_t)strtoull(argv[2], NULL, 0));

    /* nl_send_auto will automatically fill in the PID and the sequence number,
     * and also add an NLM_F_REQUEST flag. It will also add an NLM_F_ACK
     * flag unless the netlink socket has the NL_NO_AUTO_ACK flag set. */
    err = nl_send_auto(nf10_genl_sock, msg);
    if(err < 0) {
        printf("ERROR: do_reg_wr(): couldn't send netlink message\n");
        nlmsg_free(msg);
        driver_disconnect();
        return;
    }

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_ACK, NL_CB_CUSTOM, do_reg_wr_recv_ack_cb, NULL);

    /* FIXME: this function will return even if there's no ACK in the buffer. I.E. it doesn't
     * seem to wait for the ACK to be received... Ideally we'd have the behavior that getting an 
     * ACK tells us everything is OK, otherwise we time out on waiting for an ACK and tell this
     * to the user. */
    err = nl_recvmsgs_default(nf10_genl_sock);
    if(err)
        printf("ERROR: do_reg_wr(): driver reported back an error\n");

    driver_disconnect();
}

static int do_napi_enable_recv_ack_cb(struct nl_msg *msg, void *arg)
{
    return 0;
}

static void do_napi_enable(int argc, char *argv[])
{
    struct nl_msg   *msg;
    int err;    

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_napi_enable(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_napi_enable(): could not allocate new netlink message\n");
        driver_disconnect();
        return;
    }

    /* genlmsg_put will fill in the fields of the nlmsghdr and the genlmsghdr. */
    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_NAPI_ENABLE, NF10_GENL_FAMILY_VERSION);

    /* nl_send_auto will automatically fill in the PID and the sequence number,
     * and also add an NLM_F_REQUEST flag. It will also add an NLM_F_ACK
     * flag unless the netlink socket has the NL_NO_AUTO_ACK flag set. */
    nl_send_auto(nf10_genl_sock, msg);

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_ACK, NL_CB_CUSTOM, do_napi_enable_recv_ack_cb, NULL);

    /* FIXME: this function will return even if there's no ACK in the buffer. I.E. it doesn't
     * seem to wait for the ACK to be received... Ideally we'd have the behavior that getting an 
     * ACK tells us everything is OK, otherwise we time out on waiting for an ACK and tell this
     * to the user. */
    nl_recvmsgs_default(nf10_genl_sock);

    driver_disconnect();
}

static int do_napi_disable_recv_ack_cb(struct nl_msg *msg, void *arg)
{
    return 0;
}

static void do_napi_disable(int argc, char *argv[])
{
    struct nl_msg   *msg;
    int err;    

    err = driver_connect();
    if(err != 0) {
        printf("ERROR: do_napi_disable(): failed to connect to the driver\n");
        return;
    }

    msg = nlmsg_alloc();
    if(msg == NULL) {
        printf("ERROR: do_napi_disable(): could not allocate new netlink message\n");
        driver_disconnect();
        return;
    }

    /* genlmsg_put will fill in the fields of the nlmsghdr and the genlmsghdr. */
    genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, nf10_genl_family, 0, 0,
            NF10_GENL_C_NAPI_DISABLE, NF10_GENL_FAMILY_VERSION);

    /* nl_send_auto will automatically fill in the PID and the sequence number,
     * and also add an NLM_F_REQUEST flag. It will also add an NLM_F_ACK
     * flag unless the netlink socket has the NL_NO_AUTO_ACK flag set. */
    nl_send_auto(nf10_genl_sock, msg);

    nlmsg_free(msg);

    nl_socket_modify_cb(nf10_genl_sock, NL_CB_ACK, NL_CB_CUSTOM, do_napi_disable_recv_ack_cb, NULL);

    /* FIXME: this function will return even if there's no ACK in the buffer. I.E. it doesn't
     * seem to wait for the ACK to be received... Ideally we'd have the behavior that getting an 
     * ACK tells us everything is OK, otherwise we time out on waiting for an ACK and tell this
     * to the user. */
    nl_recvmsgs_default(nf10_genl_sock);

    driver_disconnect();
}

static void do_help(int argc, char *argv[])
{
    usage();
}

 static struct command all_commands[] = {
    { "echo", 1, 1, do_echo },
    { "dma_tx", 1, 2, do_dma_tx },
    { "dma_rx", 0, 0, do_dma_rx },
    { "reg_rd", 1, 1, do_reg_rd },
    { "reg_wr", 2, 2, do_reg_wr },
    { "napi_enable", 0, 0, do_napi_enable },
    { "napi_disable", 0, 0, do_napi_disable },
    { "help", 0, 0, do_help },
    { NULL, 0, 0, NULL },
};
