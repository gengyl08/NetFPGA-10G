/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        registers.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        Collection of parameters and registers
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland
 *                                 Stanford Junior University
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

//--- Ethernet types
`define TYPE_VLAN      16'h8100
`define TYPE_VLAN_QINQ 16'h88a8
`define TYPE_IP        16'h0800
`define TYPE_ARP       16'h0806
`define TYPE_MPLS      16'h8847
`define TYPE_MPLS_MC   16'h8848

`define NO_VLAN        16'hffff

//--- IP protocols
`define PROTO_ICMP  8'h01
`define PROTO_TCP   8'h06
`define PROTO_UDP   8'h11
`define PROTO_SCTP  8'h84

//--- OpenFlow Actions

`define OPENFLOW_FORWARD_BITMASK_POS    0
`define OPENFLOW_FORWARD_BITMASK_WIDTH  16
`define OPENFLOW_NF2_ACTION_FLAG_POS    (`OPENFLOW_FORWARD_BITMASK_POS\
                                         + `OPENFLOW_FORWARD_BITMASK_WIDTH)
`define OPENFLOW_NF2_ACTION_FLAG_WIDTH 16
`define OPENFLOW_SET_VLAN_VID_POS       (`OPENFLOW_NF2_ACTION_FLAG_POS\
                                         + `OPENFLOW_NF2_ACTION_FLAG_WIDTH)
`define OPENFLOW_SET_VLAN_VID_WIDTH    16
`define OPENFLOW_SET_VLAN_PCP_POS      (`OPENFLOW_SET_VLAN_VID_POS\
                                        + `OPENFLOW_SET_VLAN_VID_WIDTH)
`define OPENFLOW_SET_VLAN_PCP_WIDTH    8
`define OPENFLOW_SET_DL_SRC_POS        (`OPENFLOW_SET_VLAN_PCP_POS\
                                        + `OPENFLOW_SET_VLAN_PCP_WIDTH)
`define OPENFLOW_SET_DL_SRC_WIDTH      48
`define OPENFLOW_SET_DL_DST_POS        (`OPENFLOW_SET_DL_SRC_POS\
                                        + `OPENFLOW_SET_DL_SRC_WIDTH)
`define OPENFLOW_SET_DL_DST_WIDTH      48
`define OPENFLOW_SET_NW_SRC_POS        (`OPENFLOW_SET_DL_DST_POS\
                                        + `OPENFLOW_SET_DL_DST_WIDTH)
`define OPENFLOW_SET_NW_SRC_WIDTH      32
`define OPENFLOW_SET_NW_DST_POS        (`OPENFLOW_SET_NW_SRC_POS\
                                        + `OPENFLOW_SET_NW_SRC_WIDTH)
`define OPENFLOW_SET_NW_DST_WIDTH      32
`define OPENFLOW_SET_NW_TOS_POS        (`OPENFLOW_SET_NW_DST_POS\
                                        + `OPENFLOW_SET_NW_DST_WIDTH)
`define OPENFLOW_SET_NW_TOS_WIDTH      6
`define OPENFLOW_SET_NW_ECN_POS        (`OPENFLOW_SET_NW_TOS_POS\
                                        + `OPENFLOW_SET_NW_TOS_WIDTH)
`define OPENFLOW_SET_NW_ECN_WIDTH      2
`define OPENFLOW_SET_TP_SRC_POS        (`OPENFLOW_SET_NW_ECN_POS\
                                        + `OPENFLOW_SET_NW_ECN_WIDTH)
`define OPENFLOW_SET_TP_SRC_WIDTH      16
`define OPENFLOW_SET_TP_DST_POS        (`OPENFLOW_SET_TP_SRC_POS\
                                        + `OPENFLOW_SET_TP_SRC_WIDTH)
`define OPENFLOW_SET_TP_DST_WIDTH      16

//--- Bitmap position for OPENFLOW_NF2_ACTION_FLAG

`define NF2_OFPAT_OUTPUT        16'h0001
`define NF2_OFPAT_PUSH_VLAN     16'h1000  //Used for ADD_VLAN IN 1.0
`define NF2_OFPAT_SET_VLAN_VID  16'h0002
`define NF2_OFPAT_SET_VLAN_PCP  16'h0004
`define NF2_OFPAT_POP_VLAN      16'h0008  //STRIP_VLAN IN 1.0
`define NF2_OFPAT_SET_DL_SRC    16'h0010
`define NF2_OFPAT_SET_DL_DST    16'h0020
`define NF2_OFPAT_SET_NW_SRC    16'h0040
`define NF2_OFPAT_SET_NW_DST    16'h0080
`define NF2_OFPAT_SET_NW_TOS    16'h0100
`define NF2_OFPAT_SET_TP_SRC    16'h0200
`define NF2_OFPAT_SET_TP_DST    16'h0400
// 1.1
`define NF2_OFPAT_SET_NW_ECN    16'h0800
`define NF2_OFPAT_SET_NW_TTL    16'h2000
`define NF2_OFPAT_DEC_NW_TTL    16'h4000

//--- Statistics Bitmap position

`define OPENFLOW_PKT_COUNTER_POS     0
`define OPENFLOW_PKT_COUNTER_WIDTH   25
`define OPENFLOW_LAST_SEEN_POS       (`OPENFLOW_PKT_COUNTER_POS\
                                      + `OPENFLOW_PKT_COUNTER_WIDTH)
`define OPENFLOW_LAST_SEEN_WIDTH     7
`define OPENFLOW_BYTE_COUNTER_POS    (`OPENFLOW_LAST_SEEN_POS\
                                      + `OPENFLOW_LAST_SEEN_WIDTH)
`define OPENFLOW_BYTE_COUNTER_WIDTH  32

//--- Register Address

`define NUM_PKTS_DROPPED_0_REG  8'h00
`define NUM_PKTS_DROPPED_1_REG  8'h01
`define NUM_PKTS_DROPPED_2_REG  8'h02
`define NUM_PKTS_DROPPED_3_REG  8'h03
`define NUM_PKTS_DROPPED_4_REG  8'h04
`define EXACT_HITS_REG          8'h05
`define EXACT_MISSES_REG        8'h06
`define WILDCARD_HITS_REG       8'h07
`define WILDCARD_MISSES_REG     8'h08
`define DL_PARSE_CNT_0_REG      8'h09
`define DL_PARSE_CNT_1_REG      8'h0a
`define DL_PARSE_CNT_2_REG      8'h0b
`define DL_PARSE_CNT_3_REG      8'h0c
`define DL_PARSE_CNT_4_REG      8'h0d
`define ACT_NUM_PROC_DONE_0_REG 8'h0e
`define ACT_NUM_PROC_DONE_1_REG 8'h0f
`define ACT_NUM_PROC_DONE_2_REG 8'h10
`define ACT_NUM_PROC_DONE_3_REG 8'h11
`define ACT_NUM_PROC_DONE_4_REG 8'h12
//`define MPLS_PARSE_CNT_0_REG    8'h0e
//`define MPLS_PARSE_CNT_1_REG    8'h0f
//`define MPLS_PARSE_CNT_2_REG    8'h10
//`define MPLS_PARSE_CNT_3_REG    8'h11
//`define MPLS_PARSE_CNT_4_REG    8'h12
`define ARP_PARSE_CNT_0_REG     8'h13
`define ARP_PARSE_CNT_1_REG     8'h14
`define ARP_PARSE_CNT_2_REG     8'h15
`define ARP_PARSE_CNT_3_REG     8'h16
`define ARP_PARSE_CNT_4_REG     8'h17
`define IP_TP_PARSE_CNT_0_REG   8'h18
`define IP_TP_PARSE_CNT_1_REG   8'h19
`define IP_TP_PARSE_CNT_2_REG   8'h1a
`define IP_TP_PARSE_CNT_3_REG   8'h1b
`define IP_TP_PARSE_CNT_4_REG   8'h1c
`define LAST_OUTSIDE_REG        `IP_TP_PARSE_CNT_4_REG

//--- Register Addresses (module internal)

`define ACC_RDY_REG          `LAST_OUTSIDE_REG + 8'h01
`define BASE_ADDR_REG        `LAST_OUTSIDE_REG + 8'h02
`define WRITE_ORDER_REG      `LAST_OUTSIDE_REG + 8'h03
`define MOD_WRITE_ORDER_REG  `LAST_OUTSIDE_REG + 8'h04
`define READ_ORDER_REG       `LAST_OUTSIDE_REG + 8'h05
`define ENTRY_BASE_REG       `LAST_OUTSIDE_REG + 8'h06

//--- Constants (Reference from software)
`define WILDCARD_BASE 16'h8000
`define EXACT_BASE 16'h0000

//--- Register Address (Reference from software)

`define LOOKUP_CMP_BASE_REG `ENTRY_BASE_REG
`define LOOKUP_CMP_MASK_BASE_REG `LOOKUP_CMP_BASE_REG + 8 //FIXME
`define LOOKUP_ACTION_BASE_REG `LOOKUP_CMP_MASK_BASE_REG + 8 //FIXME
`define STATS_BASE_REG `LOOKUP_ACTION_BASE_REG + 10 //FIXME
