
/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        defines.vh
 *
 *  Library:
 *        hw/contrib/pcores/nf1g_router_port_v1_00_a
 *
 *  Module:
 *        
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        NetFPGA-1G ROUTER port defines
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


`define IO_QUEUE_STAGE_NUM                      'hFF
`define IOQ_SRC_PORT_POS                        16
`define IOQ_DST_PORT_POS                        48
`define ROUTER_OP_LUT_ROUTE_TABLE_DEPTH         32
`define ROUTER_OP_LUT_ARP_TABLE_DEPTH           32
`define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_DEPTH 32
`define UDP_REG_ADDR_WIDTH                      (32-2)
`define CPCI_NF2_DATA_WIDTH                     32

`define ROUTER_OP_LUT_REG_ADDR_WIDTH            8
`define ROUTER_OP_LUT_BLOCK_ADDR                0

`define ROUTER_OP_LUT_DEFAULT_MAC_0_HI          16'hcafe
`define ROUTER_OP_LUT_DEFAULT_MAC_0_LO          32'hf00d0001
`define ROUTER_OP_LUT_DEFAULT_MAC_1_HI          16'hcafe
`define ROUTER_OP_LUT_DEFAULT_MAC_1_LO          32'hf00d0002
`define ROUTER_OP_LUT_DEFAULT_MAC_2_HI          16'hcafe
`define ROUTER_OP_LUT_DEFAULT_MAC_2_LO          32'hf00d0003
`define ROUTER_OP_LUT_DEFAULT_MAC_3_HI          16'hcafe
`define ROUTER_OP_LUT_DEFAULT_MAC_3_LO          32'hf00d0004

`define ROUTER_OP_LUT_ARP_NUM_MISSES            0
`define ROUTER_OP_LUT_LPM_NUM_MISSES            1
`define ROUTER_OP_LUT_NUM_CPU_PKTS_SENT         2
`define ROUTER_OP_LUT_NUM_BAD_OPTS_VER          3
`define ROUTER_OP_LUT_NUM_BAD_CHKSUMS           4
`define ROUTER_OP_LUT_NUM_BAD_TTLS              5
`define ROUTER_OP_LUT_NUM_NON_IP_RCVD           6
`define ROUTER_OP_LUT_NUM_PKTS_FORWARDED        7
`define ROUTER_OP_LUT_NUM_WRONG_DEST            8
`define ROUTER_OP_LUT_NUM_FILTERED_PKTS         9

`define ROUTER_OP_LUT_MAC_0_HI                  10
`define ROUTER_OP_LUT_MAC_0_LO                  11
`define ROUTER_OP_LUT_MAC_1_HI                  12
`define ROUTER_OP_LUT_MAC_1_LO                  13
`define ROUTER_OP_LUT_MAC_2_HI                  14
`define ROUTER_OP_LUT_MAC_2_LO                  15
`define ROUTER_OP_LUT_MAC_3_HI                  16
`define ROUTER_OP_LUT_MAC_3_LO                  17
`define ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI    18
`define ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO    19
`define ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP 20
`define ROUTER_OP_LUT_ARP_TABLE_RD_ADDR         21
`define ROUTER_OP_LUT_ARP_TABLE_WR_ADDR         22
`define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP      23
`define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK    24
`define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP 25
`define ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT 26
`define ROUTER_OP_LUT_ROUTE_TABLE_RD_ADDR       27
`define ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR       28
`define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP 29
`define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_RD_ADDR 30
`define ROUTER_OP_LUT_DST_IP_FILTER_TABLE_WR_ADDR 31

