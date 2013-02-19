//-----------------------------------------------------------------------------
// File:  defines.h
// Date:  Tue Dec 10 9:08:45 PDT 2012
// Author: Gianni Antichi
//
// Description:
//
// Router register HW defines
//
//-----------------------------------------------------------------------------


#define ROUTER_OP_LUT_ROUTE_TABLE_DEPTH         	16
#define ROUTER_OP_LUT_ARP_TABLE_DEPTH           	16
#define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_DEPTH 	16

/* generic counter regs */
#define ROUTER_OP_LUT_RESET_CNTRS			0x76800000
#define ROUTER_OP_LUT_ARP_NUM_MISSES_REG            	0x7680002c
#define ROUTER_OP_LUT_LPM_NUM_MISSES_REG            	0x76800028
#define ROUTER_OP_LUT_NUM_CPU_PKTS_SENT_REG         	0x76800048
#define ROUTER_OP_LUT_NUM_BAD_OPTS_VER_REG          	0x76800044
#define ROUTER_OP_LUT_NUM_BAD_CHKSUMS_REG           	0x76800034
#define ROUTER_OP_LUT_NUM_BAD_TTLS_REG              	0x76800040
#define ROUTER_OP_LUT_NUM_NON_IP_RCVD_REG           	0x76800030
#define ROUTER_OP_LUT_NUM_PKTS_FORWARDED_REG        	0x76800038
#define ROUTER_OP_LUT_NUM_WRONG_DEST_REG            	0x76800024
#define ROUTER_OP_LUT_NUM_FILTERED_PKTS_REG         	0x7680003c

/* MAC addresses regs */
#define ROUTER_OP_LUT_MAC_0_HI_REG                  	0x76800008
#define ROUTER_OP_LUT_MAC_0_LO_REG                  	0x76800004
#define ROUTER_OP_LUT_MAC_1_HI_REG                  	0x76800010
#define ROUTER_OP_LUT_MAC_1_LO_REG                  	0x7680000c
#define ROUTER_OP_LUT_MAC_2_HI_REG                  	0x76800018
#define ROUTER_OP_LUT_MAC_2_LO_REG                  	0x76800014
#define ROUTER_OP_LUT_MAC_3_HI_REG                  	0x76800020
#define ROUTER_OP_LUT_MAC_3_LO_REG                  	0x7680001c

/* ARP table */
#define ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG    	0x74800028
#define ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG    	0x74800024
#define ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG 	0x74800020
#define ROUTER_OP_LUT_ARP_TABLE_RD_ADDR_REG         	0x74800030
#define ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG         	0x7480002c

/* LPM table */
#define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG      	0x74800000
#define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG    	0x74800004
#define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG 0x74800008
#define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG 0x7480000c
#define ROUTER_OP_LUT_ROUTE_TABLE_RD_ADDR_REG       	0x74800014
#define ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG       	0x74800010

/* Filter table */
#define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG 	0x74800040
#define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_RD_ADDR_REG 	0x74800048
#define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_WR_ADDR_REG 	0x74800044

