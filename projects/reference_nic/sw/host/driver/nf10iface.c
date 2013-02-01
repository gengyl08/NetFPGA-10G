/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10iface.c
 *
 *  Project:
 *        nic
 *
 *  Author:
 *        Mario Flajslik
 *
 *  Description:
 *        This code creates and handles Ethernet interfaces presented to linux
 *        as nf0-nf3. Both interrupt handles (int_handler) and transmit
 *        function (nf10i_tx) delegate their work to functions in nf10priv.c
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

#include "nf10iface.h"
#include "nf10driver.h"
#include "nf10priv.h"

#include <linux/interrupt.h>
#include <linux/pci.h>

#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/if_ether.h>


irqreturn_t int_handler(int irq, void *dev_id){
    struct pci_dev *pdev = dev_id;
    struct nf10_card *card = (struct nf10_card*)pci_get_drvdata(pdev);
    
    queue_work(card->wq, (struct work_struct*)&card->work);

    return IRQ_HANDLED;
}

static netdev_tx_t nf10i_tx(struct sk_buff *skb, struct net_device *dev){
    struct nf10_card* card = ((struct nf10_ndev_priv*)netdev_priv(dev))->card;
    int port = ((struct nf10_ndev_priv*)netdev_priv(dev))->port_num;

    // meet minimum size requirement
    if(skb->len < 60){
        skb_pad(skb, 60 - skb->len);
        skb_put(skb, 60 - skb->len);
    }
    
    if(skb->len > 1514){
        printk(KERN_ERR "nf10: packet too big, dropping");
        dev_kfree_skb_any(skb);
        return NETDEV_TX_OK;        
    }

    // transmit packet
    if(nf10priv_xmit(card, skb, port)){
        //printk(KERN_ERR "nf10: dropping packet at port %d", port);
        dev_kfree_skb_any(skb);
        return NETDEV_TX_OK;
    }

    // update stats
    card->ndev[port]->stats.tx_packets++;
    card->ndev[port]->stats.tx_bytes += skb->len;

    return NETDEV_TX_OK;
}

static int nf10i_ioctl(struct net_device *dev, struct ifreq *rq, int cmd){
    return 0;
}

static int nf10i_open(struct net_device *dev){
    ((struct nf10_ndev_priv*)netdev_priv(dev))->port_up = 1;
    return 0;    
}

static int nf10i_stop(struct net_device *dev){
    ((struct nf10_ndev_priv*)netdev_priv(dev))->port_up = 0;
    return 0;
}

static int nf10i_set_mac(struct net_device *dev, void *a){
    struct sockaddr *addr = (struct sockaddr *) a;
    
    if (!is_valid_ether_addr(addr->sa_data))
        return -EADDRNOTAVAIL;
    
    memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
    
    return 0;
}

static struct net_device_stats *nf10i_stats(struct net_device *dev){
    return &dev->stats;
}

static const struct net_device_ops nf10_ops = {
    .ndo_open            = nf10i_open,
    .ndo_stop            = nf10i_stop,
    .ndo_do_ioctl        = nf10i_ioctl,
    .ndo_get_stats       = nf10i_stats,
    .ndo_start_xmit      = nf10i_tx,
    .ndo_set_mac_address = nf10i_set_mac
};

// init called by alloc_netdev
static void nf10iface_init(struct net_device *dev)
{
  ether_setup(dev); /* assign some of the fields */
  
  dev->netdev_ops      = &nf10_ops;
  dev->watchdog_timeo  = msecs_to_jiffies(5000);
  dev->mtu             = MTU;

}


int nf10iface_probe(struct pci_dev *pdev, struct nf10_card *card){
    int ret = -ENODEV;
    int i;

    struct net_device *netdev;
    
    char *devname = "nf%d";
    
    // request IRQ
    if(request_irq(pdev->irq, int_handler, 0, DEVICE_NAME, pdev) != 0){
        printk(KERN_ERR "nf10: request_irq failed\n");
        goto err_out_free_none;
    }

    // Set up the network device...
    for (i = 0; i < 4; i++){
        netdev = card->ndev[i] = alloc_netdev(sizeof(struct nf10_ndev_priv),
                                              devname, nf10iface_init);
        if(netdev == NULL){
            printk(KERN_ERR "nf10: Could not allocate ethernet device.\n");
            ret = -ENOMEM;
            goto err_out_free_dev;
        }
        netdev->irq = pdev->irq;

        ((struct nf10_ndev_priv*)netdev_priv(netdev))->card     = card;
        ((struct nf10_ndev_priv*)netdev_priv(netdev))->port_num = i;
        ((struct nf10_ndev_priv*)netdev_priv(netdev))->port_up  = 0;

        // assign some made up MAC adddr
        memcpy(netdev->dev_addr, "\0NF10C0", ETH_ALEN);
        netdev->dev_addr[ETH_ALEN - 1] = i;

        if(register_netdev(netdev)){
            printk(KERN_ERR "nf10: register_netdev failed\n");
        }

        netif_start_queue(netdev);
    }

    // give some descriptors to the card
    for(i = 0; i < card->mem_rx_dsc.cl_size-2; i++){
        nf10priv_send_rx_dsc(card);
    }

    // yay
    return 0;
    
    // fail
 err_out_free_dev:
    for (i = 0; i < 4; i++){
        if(card->ndev[i]){
            unregister_netdev(card->ndev[i]);
            free_netdev(card->ndev[i]);
        }
    }
    
 err_out_free_none:
    return ret;
}

int nf10iface_remove(struct pci_dev *pdev, struct nf10_card *card){
    int i;

    for (i = 0; i < 4; i++){
        if(card->ndev[i]){
            unregister_netdev(card->ndev[i]);
            free_netdev(card->ndev[i]);
        }
    }

    free_irq(pdev->irq, pdev);

    return 0;
}



