#ifndef NF10PRIV_H
#define NF10PRIV_H

#include "nf10driver.h"

int nf10priv_xmit(struct nf10_card *card, struct sk_buff *skb, int port);
void work_handler(struct work_struct *w);
int nf10priv_send_rx_dsc(struct nf10_card *card);


#endif
