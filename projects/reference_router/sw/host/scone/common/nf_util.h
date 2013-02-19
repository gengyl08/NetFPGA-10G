/* ****************************************************************************
 * $Id: nf_util.h
 *
 * Module: nf_util.h
 * Project: NetFPGA 2 Linux Kernel Driver
 * Description: Header file for kernel driver
 *
 * Change history:
 *
 */

#ifndef _NF_UTIL_H
#define _NF_UTIL_H	1

/* Include for socket IOCTLs */
#include <linux/sockios.h>

#define PATHLEN		80
#define DEVICE_STR_LEN 120


/*
 * Structure to represent an nf device to a user mode programs
 */
struct nf_device {
	char *device_name;
	int fd;
	int net_iface;
};
typedef struct nf_device nf_device;

/*
 *   IOCTLs
 */
#define SIOCREGSTAT 		(SIODEVPRIVATE+0)
#define SIOCREGREAD             (SIOCDEVPRIVATE+2)
#define SIOCREGWRITE            (SIOCDEVPRIVATE+1)

/*
 * Structure for transferring register data via an IOCTL
 */
struct nf_reg {
        unsigned int    reg;
        unsigned int    val;
};


/* Function declarations */

int check_iface(struct nf_device *nf);
int openDescriptor(struct nf_device *nf);
int closeDescriptor(struct nf_device *nf);

extern char nf_device_str[DEVICE_STR_LEN];

#endif
