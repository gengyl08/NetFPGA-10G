/* ****************************************************************************
 * $Id: nfutil.c 2013-02-08 15:51 Gianni Antichi $
 *
 * Module: nf10util.h
 * Project: NetFPGA-10G utils
 * Description: register read/write functions - header file
 *
 */


#define NF10_IOCTL_CMD_READ_STAT (SIOCDEVPRIVATE+0)
#define NF10_IOCTL_CMD_WRITE_REG (SIOCDEVPRIVATE+1)
#define NF10_IOCTL_CMD_READ_REG (SIOCDEVPRIVATE+2)
#define MASK_VALUE 0xffffffff


int readReg(int f, uint32_t addr, uint32_t *val);
int writeReg(int f, uint32_t addr, uint32_t val);
