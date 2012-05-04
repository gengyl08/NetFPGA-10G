#ifndef NF10FOPS_H
#define NF10FOPS_H

#include <linux/fs.h>
#include "nf10driver.h"

#define NF10_IOCTL_CMD_READ_STAT (SIOCDEVPRIVATE+0)
#define NF10_IOCTL_CMD_WRITE_REG (SIOCDEVPRIVATE+1)
#define NF10_IOCTL_CMD_READ_REG (SIOCDEVPRIVATE+2)

int nf10fops_open (struct inode *n, struct file *f);
long nf10fops_ioctl (struct file *f, unsigned int cmd, unsigned long arg);
int nf10fops_release (struct inode *n, struct file *f);

int nf10fops_probe(struct pci_dev *pdev, struct nf10_card *card);
int nf10fops_remove(struct pci_dev *pdev, struct nf10_card *card);

#endif
