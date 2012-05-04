#ifndef NF10DRIVER_H
#define NF10DRIVER_H

#define PCI_VENDOR_ID_NF10 0x10ee
#define PCI_DEVICE_ID_NF10 0x4244
#define DEVICE_NAME "nf10"

#include <linux/netdevice.h> 
#include <linux/cdev.h>
#include <asm/atomic.h>
#include <linux/workqueue.h>

void work_handler(struct work_struct *w);

struct nf10mem{
    uint64_t wr_ptr;
    uint64_t rd_ptr;
    atomic64_t cnt;
    uint64_t mask;
    uint64_t cl_size;
} __attribute__ ((aligned(64)));

struct my_work_t{
    struct work_struct work;
    struct nf10_card *card;
};

struct nf10_card{
    struct workqueue_struct *wq;
    struct my_work_t work;

    volatile void *cfg_addr;   // kernel virtual address of the card BAR0 space
    volatile void *tx_dsc;     // kernel virtual address of the card tx descriptor space
    volatile void *rx_dsc;     // kernel virtual address of the card rx descriptor space

    uint64_t tx_dsc_mask;
    uint64_t rx_dsc_mask;
    uint64_t tx_pkt_mask;
    uint64_t rx_pkt_mask;
    uint64_t tx_dne_mask;
    uint64_t rx_dne_mask;

    void *host_tx_dne_ptr;         // virtual address
    uint64_t host_tx_dne_dma;      // physical address

    void *host_rx_dne_ptr;         // virtual address
    uint64_t host_rx_dne_dma;      // physical address
    
    struct pci_dev *pdev;
    struct cdev cdev; // char device structure (for /dev/nf10)

    struct net_device *ndev[4]; // network devices
    
    // memory buffers
    struct nf10mem mem_tx_dsc;
    struct nf10mem mem_tx_pkt;
    struct nf10mem mem_rx_dsc;
    struct nf10mem mem_rx_pkt;
    struct nf10mem host_tx_dne;
    struct nf10mem host_rx_dne;

    // tx book keeping
    struct sk_buff  **tx_bk_skb;
    uint64_t *tx_bk_dma_addr;
    uint64_t *tx_bk_size;
    uint64_t *tx_bk_port;
    struct sk_buff  **rx_bk_skb;
    uint64_t *rx_bk_dma_addr;
    uint64_t *rx_bk_size;
};

struct nf10_ndev_priv{
    struct nf10_card *card;
    int port_num;
    int port_up;
};


#endif
