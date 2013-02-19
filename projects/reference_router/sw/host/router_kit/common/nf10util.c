/* ****************************************************************************
 * $Id: nfutil.c 2013-02-08 15:51 Gianni Antichi $
 *
 * Module: nf10util.c
 * Project: NetFPGA-10G utils
 * Description: register read/write functions
 *
 */

#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "nf10util.h"

#define NF10_IOCTL_CMD_READ_STAT (SIOCDEVPRIVATE+0)
#define NF10_IOCTL_CMD_WRITE_REG (SIOCDEVPRIVATE+1)
#define NF10_IOCTL_CMD_READ_REG (SIOCDEVPRIVATE+2)
#define MASK_VALUE 0xffffffff



int readReg(int f, uint32_t addr, uint32_t *val)
{
	uint64_t v;

	v = addr;
    	if(ioctl(f, NF10_IOCTL_CMD_READ_REG, &v) < 0){
        	perror("nf10 ioctl failed");
        	return 1;
    	}

	*val = v & MASK_VALUE;
	return 0;
}

int writeReg(int f, uint32_t addr, uint32_t val)
{

	uint64_t v;

	v = addr;
	v=(v<<32)+val;

	if(ioctl(f, NF10_IOCTL_CMD_WRITE_REG, v) < 0){
        	perror("nf10 ioctl failed");
        	return 1;
    	}

	return 0;
}

