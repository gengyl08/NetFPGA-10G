/* ****************************************************************************
 * $Id: regdump.c 5456 2013-01-21 11:51:04Z g9coving, Gianni Antichi $
 *
 * Module: regdump.c
 * Description: Test program to dump the registers
 *
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>

#include <net/if.h>

#include <time.h>

#include <netlink/netlink.h>
#include "defines.h"

/* Function declarations */
void print (void);
void printMAC (unsigned, unsigned);
void printIP (unsigned);

int main(int argc, char *argv[])
{
	print();

	return 0;
}

void print(void) {
	unsigned val, val2;
	int i;
	int err;

	for(i=0; i<ROUTER_OP_LUT_ARP_TABLE_DEPTH; i=i+1){
   	  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_RD_ADDR_REG, i);
    	  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_RD_ADDR_REG, nl_geterror(err));
	  printf("   ARP table entry %02u: mac: ", i);
          err=nf10_reg_rd(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, nl_geterror(err));
          err=nf10_reg_rd(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, &val2);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, nl_geterror(err));
	  printMAC(val, val2);
	  printf(" ip: ");
          err=nf10_reg_rd(ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
	  printIP(val);
	  printf("\n", val);
	}
	printf("\n");

	for(i=0; i<ROUTER_OP_LUT_ROUTE_TABLE_DEPTH; i=i+1){
          err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_RD_ADDR_REG, i);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_RD_ADDR_REG, nl_geterror(err));
          err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, nl_geterror(err));
	  printf("   IP table entry %02u: ip: ", i);
	  printIP(val);
          err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, nl_geterror(err));
	  printf(" mask: 0x%08x", val);
          err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
	  printf(" next hop: ");
	  printIP(val);
          err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, nl_geterror(err));
	  printf(" output port: 0x%04x\n",val);
	}
	printf("\n");

	for(i=0; i<ROUTER_OP_LUT_DST_IP_FILTER_TABLE_DEPTH; i=i+1){
          err=nf10_reg_wr(ROUTER_OP_LUT_DST_IP_FILTER_TABLE_RD_ADDR_REG, i);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_DST_IP_FILTER_TABLE_RD_ADDR_REG, nl_geterror(err));
          err=nf10_reg_rd(ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG, &val);
          if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG, nl_geterror(err));
	  printf("   Dst IP Filter table entry %02u: ", i);
	  printIP(val);
	  printf("\n");
	}
	printf("\n");


        err=nf10_reg_rd(ROUTER_OP_LUT_ARP_NUM_MISSES_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_NUM_MISSES_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_ARP_NUM_MISSES: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_LPM_NUM_MISSES_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_LPM_NUM_MISSES_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_LPM_NUM_MISSES: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_CPU_PKTS_SENT_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_CPU_PKTS_SENT_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_CPU_PKTS_SENT: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_BAD_OPTS_VER_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_BAD_OPTS_VER_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_BAD_OPTS_VER: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_BAD_CHKSUMS_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_BAD_CHKSUMS_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_BAD_CHKSUMS: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_BAD_TTLS_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_BAD_TTLS_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_BAD_TTLS: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_NON_IP_RCVD_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_NON_IP_RCVD_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_NON_IP_RCVD: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_PKTS_FORWARDED_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_PKTS_FORWARDED_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_PKTS_FORWARDED: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_WRONG_DEST_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_WRONG_DEST_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_WRONG_DEST: %u\n", val);
        err=nf10_reg_rd(ROUTER_OP_LUT_NUM_FILTERED_PKTS_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_NUM_FILTERED_PKTS_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_NUM_FILTERED_PKTS: %u\n", val);
	printf("\n");

        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_0_HI_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_0_HI_REG, nl_geterror(err));
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_0_LO_REG, &val2);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_0_LO_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_MAC_0: ");
	printMAC(val, val2);
	printf("\n");
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_1_HI_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_1_HI_REG, nl_geterror(err));
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_1_LO_REG, &val2);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_1_LO_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_MAC_1: ");
	printMAC(val, val2);
	printf("\n");
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_2_HI_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_2_HI_REG, nl_geterror(err));
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_2_LO_REG, &val2);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_2_LO_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_MAC_2: ");
	printMAC(val, val2);
	printf("\n");
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_3_HI_REG, &val);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_3_HI_REG, nl_geterror(err));
        err=nf10_reg_rd(ROUTER_OP_LUT_MAC_3_LO_REG, &val2);
        if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_MAC_3_LO_REG, nl_geterror(err));
	printf("ROUTER_OP_LUT_MAC_3: ");
	printMAC(val, val2);
	printf("\n");


}

//
// printMAC: print a MAC address as a : separated value. eg:
//    00:11:22:33:44:55
//
void printMAC(unsigned hi, unsigned lo)
{
	printf("%02x:%02x:%02x:%02x:%02x:%02x",
			((hi>>8)&0xff), ((hi>>0)&0xff),
			((lo>>24)&0xff), ((lo>>16)&0xff), ((lo>>8)&0xff), ((lo>>0)&0xff)
		);
}


//
// printIP: print an IP address in dotted notation. eg: 192.168.0.1
//
void printIP(unsigned ip)
{
	printf("%u.%u.%u.%u",
			((ip>>24)&0xff), ((ip>>16)&0xff), ((ip>>8)&0xff), ((ip>>0)&0xff)
		);
}
