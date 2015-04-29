////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.87xd
//  \   \         Application: netgen
//  /   /         Filename: xaui.v
// /___/   /\     Timestamp: Fri Aug  9 16:17:07 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog /home/gengyl08/NetFPGA-10G-live/lib/hw/std/pcores/nf10_10g_interface_v1_10_a/coregen/tmp/_cg/xaui.ngc /home/gengyl08/NetFPGA-10G-live/lib/hw/std/pcores/nf10_10g_interface_v1_10_a/coregen/tmp/_cg/xaui.v 
// Device	: 5vtx240tff1759-2
// Input file	: /home/gengyl08/NetFPGA-10G-live/lib/hw/std/pcores/nf10_10g_interface_v1_10_a/coregen/tmp/_cg/xaui.ngc
// Output file	: /home/gengyl08/NetFPGA-10G-live/lib/hw/std/pcores/nf10_10g_interface_v1_10_a/coregen/tmp/_cg/xaui.v
// # of Modules	: 1
// Design Name	: xaui
// Xilinx        : /cad_64/xilinx/ise13.4/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module xaui (
  align_status, mgt_enchansync, reset, usrclk, mgt_powerdown, mgt_loopback, mgt_rxlock, mgt_tx_reset, mgt_txcharisk, mgt_syncok, mgt_rxdata, xgmii_txc
, mgt_enable_align, xgmii_txd, status_vector, mgt_rxcharisk, configuration_vector, mgt_codevalid, mgt_codecomma, sync_status, xgmii_rxc, xgmii_rxd, 
mgt_txdata, mgt_rx_reset, signal_detect
)/* synthesis syn_black_box syn_noprune=1 */;
  output align_status;
  output mgt_enchansync;
  input reset;
  input usrclk;
  output mgt_powerdown;
  output mgt_loopback;
  input [3 : 0] mgt_rxlock;
  input [3 : 0] mgt_tx_reset;
  output [7 : 0] mgt_txcharisk;
  input [3 : 0] mgt_syncok;
  input [63 : 0] mgt_rxdata;
  input [7 : 0] xgmii_txc;
  output [3 : 0] mgt_enable_align;
  input [63 : 0] xgmii_txd;
  output [7 : 0] status_vector;
  input [7 : 0] mgt_rxcharisk;
  input [6 : 0] configuration_vector;
  input [7 : 0] mgt_codevalid;
  input [7 : 0] mgt_codecomma;
  output [3 : 0] sync_status;
  output [7 : 0] xgmii_rxc;
  output [63 : 0] xgmii_rxd;
  output [63 : 0] mgt_txdata;
  input [3 : 0] mgt_rx_reset;
  input [3 : 0] signal_detect;
  
  // synthesis translate_off
  
  wire N0;
  wire N1;
  wire \NlwRenamedSig_OI_status_vector[7] ;
  wire \NlwRenamedSig_OI_status_vector[1] ;
  wire \NlwRenamedSig_OI_status_vector[0] ;
  wire NlwRenamedSig_OI_align_status;
  wire \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01_1221 ;
  wire \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2_1219 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1_1218 ;
  wire \BU2/U0/rx_local_fault_rstpot12_1217 ;
  wire \BU2/U0/rx_local_fault_rstpot11_1216 ;
  wire \BU2/N280 ;
  wire \BU2/N279 ;
  wire \BU2/N278 ;
  wire \BU2/N277 ;
  wire \BU2/U0/transmitter/recoder/N17 ;
  wire \BU2/U0/transmitter/recoder/N18 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot_1209 ;
  wire \BU2/U0/transmitter/recoder/N36 ;
  wire \BU2/U0/transmitter/recoder/N35 ;
  wire \BU2/N143 ;
  wire \BU2/U0/transmitter/recoder/txd_out_38_mux000657 ;
  wire \BU2/U0/transmitter/recoder/txd_out_14_mux000657 ;
  wire \BU2/U0/transmitter/recoder/N46 ;
  wire \BU2/U0/transmitter/recoder/N43 ;
  wire \BU2/U0/transmitter/recoder/N23 ;
  wire \BU2/U0/transmitter/recoder/N22 ;
  wire \BU2/U0/transmitter/recoder/N32 ;
  wire \BU2/U0/transmitter/recoder/N31 ;
  wire \BU2/N275 ;
  wire \BU2/N273 ;
  wire \BU2/N271 ;
  wire \BU2/N269 ;
  wire \BU2/N267 ;
  wire \BU2/N263 ;
  wire \BU2/N261 ;
  wire \BU2/N259 ;
  wire \BU2/N257 ;
  wire \BU2/N255 ;
  wire \BU2/N253 ;
  wire \BU2/N251 ;
  wire \BU2/N249 ;
  wire \BU2/N247 ;
  wire \BU2/N245 ;
  wire \BU2/N239 ;
  wire \BU2/N237 ;
  wire \BU2/N235 ;
  wire \BU2/N233 ;
  wire \BU2/N227 ;
  wire \BU2/N225 ;
  wire \BU2/N223 ;
  wire \BU2/N221 ;
  wire \BU2/N219 ;
  wire \BU2/N215 ;
  wire \BU2/N213 ;
  wire \BU2/N211 ;
  wire \BU2/N209 ;
  wire \BU2/N203 ;
  wire \BU2/N201 ;
  wire \BU2/N199 ;
  wire \BU2/N197 ;
  wire \BU2/N191 ;
  wire \BU2/N189 ;
  wire \BU2/N187 ;
  wire \BU2/N185 ;
  wire \BU2/N179 ;
  wire \BU2/N177 ;
  wire \BU2/N175 ;
  wire \BU2/N173 ;
  wire \BU2/N167 ;
  wire \BU2/N165 ;
  wire \BU2/N163 ;
  wire \BU2/N161 ;
  wire \BU2/N155 ;
  wire \BU2/N153 ;
  wire \BU2/N151 ;
  wire \BU2/N149 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux0000103_1147 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux0000103_1146 ;
  wire \BU2/N147 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or0000101_1144 ;
  wire \BU2/N140 ;
  wire \BU2/U0/receiver/recoder/rxd_out_40_rstpot1_1142 ;
  wire \BU2/U0/receiver/recoder/rxd_out_48_rstpot1_1141 ;
  wire \BU2/U0/receiver/recoder/rxd_out_16_rstpot1_1140 ;
  wire \BU2/U0/receiver/recoder/rxd_out_8_rstpot1_1139 ;
  wire \BU2/U0/transmitter/align/extra_a_rstpot1_1138 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot_1137 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot_1136 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot_1135 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot_1134 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot_1133 ;
  wire \BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot_1132 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot_1131 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot_1130 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot_1129 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot_1128 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot_1127 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot_1126 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot_1125 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot_1124 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot_1123 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot_1122 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot_1121 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot_1120 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot_1119 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot_1118 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot_1117 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot_1116 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot_1115 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot_1114 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot_1113 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot_1112 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot_1111 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot_1110 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot_1109 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot_1108 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot_1107 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot_1106 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot_1105 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot_1104 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot_1103 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot_1102 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot_1101 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot_1100 ;
  wire \BU2/U0/clear_aligned_edge_rstpot ;
  wire \BU2/U0/clear_local_fault_edge_1098 ;
  wire \BU2/U0/clear_local_fault_edge_rstpot ;
  wire \BU2/U0/usrclk_reset_rstpot_1096 ;
  wire \BU2/U0/usrclk_reset_pipe_1095 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/enchansync_rstpot_1094 ;
  wire \BU2/U0/tx_local_fault_rstpot1_1093 ;
  wire \BU2/U0/rx_local_fault_rstpot1 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1_1091 ;
  wire \BU2/U0/aligned_sticky_rstpot_1090 ;
  wire \BU2/U0/clear_aligned_edge_1089 ;
  wire \BU2/U0/receiver/recoder/rxd_out_32_rstpot_1088 ;
  wire \BU2/U0/receiver/recoder/rxd_out_33_rstpot_1087 ;
  wire \BU2/U0/receiver/recoder/rxd_out_0_rstpot_1086 ;
  wire \BU2/U0/receiver/recoder/rxd_out_1_rstpot_1085 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_1084 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot ;
  wire \BU2/U0/transmitter/recoder/txd_out_14_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_16_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_22_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_24_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_30_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_32_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_40_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_38_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_46_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_0_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_48_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_54_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_56_mux00061 ;
  wire \BU2/U0/transmitter/recoder/txd_out_62_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_6_mux000681 ;
  wire \BU2/U0/transmitter/recoder/txd_out_8_mux00061 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or000039_1027 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or000024 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or00000_1025 ;
  wire \BU2/U0/transmitter/align/N5 ;
  wire \BU2/U0/transmitter/align/extra_a_1022 ;
  wire \BU2/N125 ;
  wire \BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_1018 ;
  wire \BU2/N119 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or0000145_1016 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or000070_1015 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or000048_1014 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or000023_1013 ;
  wire \BU2/U0/receiver/recoder/error_lane_1_or0000103_1012 ;
  wire \BU2/U0/receiver/recoder/error_lane_1_or000080_1011 ;
  wire \BU2/U0/receiver/recoder/error_lane_1_or000018_1010 ;
  wire \BU2/U0/receiver/recoder/error_lane_4_or000073_1009 ;
  wire \BU2/U0/receiver/recoder/error_lane_4_or000048_1008 ;
  wire \BU2/U0/receiver/recoder/error_lane_4_or000014_1007 ;
  wire \BU2/U0/receiver/recoder/error_lane_7_or000013_1006 ;
  wire \BU2/U0/receiver/recoder/error_lane_2_or000081_1005 ;
  wire \BU2/U0/receiver/recoder/error_lane_2_or000056_1004 ;
  wire \BU2/U0/receiver/recoder/error_lane_2_or000010_1003 ;
  wire \BU2/N117 ;
  wire \BU2/N115 ;
  wire \BU2/N114 ;
  wire \BU2/U0/receiver/recoder/N35 ;
  wire \BU2/N112 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_997 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_996 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000039_995 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and00003_994 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000097_993 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000072_992 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000040_991 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000035_990 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000010_989 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000097_988 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000072_987 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000040_986 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000035_985 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000010_984 ;
  wire \BU2/N110 ;
  wire \BU2/N108 ;
  wire \BU2/N106 ;
  wire \BU2/N104 ;
  wire \BU2/N102 ;
  wire \BU2/N100 ;
  wire \BU2/N98 ;
  wire \BU2/N96 ;
  wire \BU2/U0/receiver/recoder/mux0003_or0000_975 ;
  wire \BU2/N94 ;
  wire \BU2/U0/receiver/recoder/mux0007_or0000_966 ;
  wire \BU2/N92 ;
  wire \BU2/U0/receiver/recoder/mux0011_or0000_958 ;
  wire \BU2/N90 ;
  wire \BU2/U0/receiver/recoder/mux0015_or0000_950 ;
  wire \BU2/N88 ;
  wire \BU2/U0/receiver/recoder/mux0023_or0000 ;
  wire \BU2/U0/receiver/recoder/N18 ;
  wire \BU2/U0/receiver/recoder/mux0019_or0000 ;
  wire \BU2/U0/receiver/recoder/N17 ;
  wire \BU2/U0/receiver/recoder/mux0027_or0000 ;
  wire \BU2/U0/receiver/recoder/N16 ;
  wire \BU2/N86 ;
  wire \BU2/N84 ;
  wire \BU2/N82 ;
  wire \BU2/N80 ;
  wire \BU2/N78 ;
  wire \BU2/N76 ;
  wire \BU2/N74 ;
  wire \BU2/N72 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N8 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N6 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N4 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N2 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N7 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N5 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N3 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N11 ;
  wire \BU2/U0/transmitter/recoder/txd_out_14_mux000679 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ;
  wire \BU2/N50 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ;
  wire \BU2/N40 ;
  wire \BU2/N39 ;
  wire \BU2/N37 ;
  wire \BU2/N36 ;
  wire \BU2/N34 ;
  wire \BU2/N33 ;
  wire \BU2/N31 ;
  wire \BU2/N30 ;
  wire \BU2/N28 ;
  wire \BU2/N27 ;
  wire \BU2/N25 ;
  wire \BU2/N24 ;
  wire \BU2/N22 ;
  wire \BU2/N21 ;
  wire \BU2/N19 ;
  wire \BU2/N18 ;
  wire \BU2/U0/transmitter/recoder/txd_out_11_or0000 ;
  wire \BU2/U0/receiver/recoder/N38 ;
  wire \BU2/N16 ;
  wire \BU2/N14 ;
  wire \BU2/N12 ;
  wire \BU2/N10 ;
  wire \BU2/N8 ;
  wire \BU2/N6 ;
  wire \BU2/N4 ;
  wire \BU2/N2 ;
  wire \BU2/U0/transmitter/recoder/N24 ;
  wire \BU2/U0/last_value_824 ;
  wire \BU2/U0/clear_local_fault_823 ;
  wire \BU2/U0/last_value0_822 ;
  wire \BU2/U0/clear_aligned_821 ;
  wire \BU2/U0/receiver/recoder/rxd_out_11_mux0002 ;
  wire \BU2/U0/receiver/recoder/mux0032_and0000_818 ;
  wire \BU2/U0/receiver/recoder/mux0033_and0000_816 ;
  wire \BU2/U0/receiver/recoder/mux0034_and0000_814 ;
  wire \BU2/U0/receiver/recoder/mux0035_and0000_812 ;
  wire \BU2/U0/receiver/recoder/mux0036_and0000_811 ;
  wire \BU2/U0/receiver/recoder/mux0037_and0000_810 ;
  wire \BU2/U0/receiver/recoder/mux0038_and0000_809 ;
  wire \BU2/U0/receiver/recoder/mux0039_and0000_808 ;
  wire \BU2/U0/receiver/recoder/rxd_out_12_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_13_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_14_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_15_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_20_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_21_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_22_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_23_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_24_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_19_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_30_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_31_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_27_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_28_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_29_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_35_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_36_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_37_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_38_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_32_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_39_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_43_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_44_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_45_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_46_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_51_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_47_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_52_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_53_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_54_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_55_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_60_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_56_mux0002_757 ;
  wire \BU2/U0/receiver/recoder/rxd_out_61_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_62_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_3_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_63_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_5_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_4_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_59_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_6_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_0_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_7_mux0002 ;
  wire \BU2/U0/receiver/recoder/rxd_out_34_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_41_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_50_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_57_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_2_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_10_or0001 ;
  wire \BU2/U0/receiver/recoder/rxd_out_17_or0000 ;
  wire \BU2/U0/receiver/recoder/rxd_out_25_or0000 ;
  wire \BU2/U0/aligned_sticky_or0000 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_cmp_eq0000 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_cmp_eq0000 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux0002 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux0002 ;
  wire \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/state_1_627 ;
  wire \BU2/U0/receiver/sync_status_626 ;
  wire \BU2/U0/receiver/sync_status_int ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_590 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_589 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_588 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_587 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_586 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_585 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_584 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_583 ;
  wire \BU2/U0/transmitter/state_machine/state_0_0_582 ;
  wire \BU2/U0/transmitter/state_machine/state_0_1_580 ;
  wire \BU2/U0/transmitter/state_machine/state_0_2_578 ;
  wire \BU2/U0/transmitter/state_machine/state_1_0_576 ;
  wire \BU2/U0/transmitter/state_machine/state_1_1_574 ;
  wire \BU2/U0/transmitter/state_machine/state_1_2_572 ;
  wire \BU2/U0/transmitter/k_r_prbs_i/prbs_2_xor0000 ;
  wire \BU2/U0/transmitter/k_r_prbs_i/prbs_1_xor0000 ;
  wire \BU2/U0/transmitter/align/count_not0001 ;
  wire \BU2/U0/transmitter/align/prbs_1_xor0000 ;
  wire \BU2/U0/transmitter/align/prbs_1_not0000 ;
  wire \BU2/U0/transmitter/recoder/txd_out_13_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_11_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_12_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_20_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_15_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_21_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_18_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_17_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_23_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_19_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_25_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_31_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_26_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_33_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_27_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_28_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_34_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_29_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_35_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_41_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_37_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_36_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_42_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_43_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_44_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_39_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_50_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_45_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_52_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_51_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_47_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_53_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_1_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_60_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_49_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_2_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_55_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_3_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_61_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_4_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_63_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_57_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_5_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_58_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txd_out_59_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_7_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txc_out_0_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txc_out_2_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_9_mux0005 ;
  wire \BU2/U0/transmitter/recoder/txc_out_1_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txc_out_3_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txc_out_4_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txc_out_5_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txc_out_6_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txc_out_7_mux0006 ;
  wire \BU2/U0/transmitter/recoder/txd_out_12_or0000 ;
  wire \BU2/U0/transmitter/recoder/txd_out_10_mux0005 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ;
  wire \BU2/U0/usrclk_reset_328 ;
  wire \BU2/mdio_tri ;
  wire [5 : 2] NlwRenamedSignal_status_vector;
  wire [63 : 0] xgmii_txd_2;
  wire [7 : 0] xgmii_txc_3;
  wire [63 : 0] xgmii_rxd_4;
  wire [7 : 0] xgmii_rxc_5;
  wire [63 : 0] mgt_txdata_6;
  wire [7 : 0] mgt_txcharisk_7;
  wire [63 : 0] mgt_rxdata_8;
  wire [7 : 0] mgt_rxcharisk_9;
  wire [7 : 0] mgt_codevalid_10;
  wire [7 : 0] mgt_codecomma_11;
  wire [0 : 0] NlwRenamedSig_OI_mgt_enable_align;
  wire [3 : 0] mgt_syncok_12;
  wire [3 : 0] mgt_rxlock_13;
  wire [3 : 0] mgt_tx_reset_14;
  wire [3 : 0] mgt_rx_reset_15;
  wire [3 : 0] signal_detect_16;
  wire [6 : 2] configuration_vector_17;
  wire [1 : 0] NlwRenamedSignal_configuration_vector;
  wire [1 : 0] \BU2/U0/transmitter/is_terminate ;
  wire [0 : 0] \BU2/U0/transmitter/a_due ;
  wire [1 : 0] \BU2/U0/transmitter/tx_code_a ;
  wire [31 : 0] \BU2/U0/receiver/recoder/rxd_half_pipe ;
  wire [7 : 0] \BU2/U0/receiver/recoder/lane_terminate ;
  wire [7 : 0] \BU2/U0/receiver/recoder/error_lane ;
  wire [7 : 0] \BU2/U0/receiver/recoder/rxc_pipe ;
  wire [63 : 0] \BU2/U0/receiver/recoder/rxd_pipe ;
  wire [7 : 0] \BU2/U0/receiver/recoder/code_error_pipe ;
  wire [7 : 0] \BU2/U0/receiver/code_error ;
  wire [3 : 0] \BU2/U0/receiver/recoder/lane_term_pipe ;
  wire [3 : 0] \BU2/U0/receiver/recoder/code_error_delay ;
  wire [3 : 0] \BU2/U0/receiver/recoder/rxc_half_pipe ;
  wire [1 : 0] \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align ;
  wire [1 : 0] \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error ;
  wire [1 : 1] \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/next_state ;
  wire [8 : 0] \BU2/U0/transmitter/idle_detect_i0/comp ;
  wire [7 : 0] \BU2/U0/transmitter/idle_detect_i0/muxcyo ;
  wire [8 : 0] \BU2/U0/transmitter/idle_detect_i1/comp ;
  wire [7 : 0] \BU2/U0/transmitter/idle_detect_i1/muxcyo ;
  wire [2 : 0] \BU2/U0/transmitter/state_machine/next_state<0> ;
  wire [2 : 0] \BU2/U0/transmitter/state_machine/next_state<1> ;
  wire [8 : 1] \BU2/U0/transmitter/k_r_prbs_i/prbs ;
  wire [4 : 0] \BU2/U0/transmitter/align/count ;
  wire [4 : 0] \BU2/U0/transmitter/align/count_mux0000 ;
  wire [7 : 1] \BU2/U0/transmitter/align/prbs ;
  wire [31 : 0] \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg ;
  wire [63 : 32] \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 ;
  wire [2 : 0] \BU2/U0/transmitter/seq_detect_i0/comp ;
  wire [1 : 0] \BU2/U0/transmitter/seq_detect_i0/muxcyo ;
  wire [2 : 0] \BU2/U0/transmitter/seq_detect_i1/comp ;
  wire [1 : 0] \BU2/U0/transmitter/seq_detect_i1/muxcyo ;
  wire [1 : 0] \BU2/U0/transmitter/tx_is_q ;
  wire [1 : 0] \BU2/U0/transmitter/tx_is_q_comb ;
  wire [1 : 0] \BU2/U0/transmitter/tx_is_idle ;
  wire [1 : 0] \BU2/U0/transmitter/tx_is_idle_comb ;
  wire [63 : 0] \BU2/U0/transmitter/txd_pipe ;
  wire [7 : 0] \BU2/U0/transmitter/txc_pipe ;
  assign
    align_status = NlwRenamedSig_OI_align_status,
    mgt_rxlock_13[3] = mgt_rxlock[3],
    mgt_rxlock_13[2] = mgt_rxlock[2],
    mgt_rxlock_13[1] = mgt_rxlock[1],
    mgt_rxlock_13[0] = mgt_rxlock[0],
    mgt_tx_reset_14[3] = mgt_tx_reset[3],
    mgt_tx_reset_14[2] = mgt_tx_reset[2],
    mgt_tx_reset_14[1] = mgt_tx_reset[1],
    mgt_tx_reset_14[0] = mgt_tx_reset[0],
    mgt_txcharisk[7] = mgt_txcharisk_7[7],
    mgt_txcharisk[6] = mgt_txcharisk_7[6],
    mgt_txcharisk[5] = mgt_txcharisk_7[5],
    mgt_txcharisk[4] = mgt_txcharisk_7[4],
    mgt_txcharisk[3] = mgt_txcharisk_7[3],
    mgt_txcharisk[2] = mgt_txcharisk_7[2],
    mgt_txcharisk[1] = mgt_txcharisk_7[1],
    mgt_txcharisk[0] = mgt_txcharisk_7[0],
    mgt_syncok_12[3] = mgt_syncok[3],
    mgt_syncok_12[2] = mgt_syncok[2],
    mgt_syncok_12[1] = mgt_syncok[1],
    mgt_syncok_12[0] = mgt_syncok[0],
    mgt_rxdata_8[63] = mgt_rxdata[63],
    mgt_rxdata_8[62] = mgt_rxdata[62],
    mgt_rxdata_8[61] = mgt_rxdata[61],
    mgt_rxdata_8[60] = mgt_rxdata[60],
    mgt_rxdata_8[59] = mgt_rxdata[59],
    mgt_rxdata_8[58] = mgt_rxdata[58],
    mgt_rxdata_8[57] = mgt_rxdata[57],
    mgt_rxdata_8[56] = mgt_rxdata[56],
    mgt_rxdata_8[55] = mgt_rxdata[55],
    mgt_rxdata_8[54] = mgt_rxdata[54],
    mgt_rxdata_8[53] = mgt_rxdata[53],
    mgt_rxdata_8[52] = mgt_rxdata[52],
    mgt_rxdata_8[51] = mgt_rxdata[51],
    mgt_rxdata_8[50] = mgt_rxdata[50],
    mgt_rxdata_8[49] = mgt_rxdata[49],
    mgt_rxdata_8[48] = mgt_rxdata[48],
    mgt_rxdata_8[47] = mgt_rxdata[47],
    mgt_rxdata_8[46] = mgt_rxdata[46],
    mgt_rxdata_8[45] = mgt_rxdata[45],
    mgt_rxdata_8[44] = mgt_rxdata[44],
    mgt_rxdata_8[43] = mgt_rxdata[43],
    mgt_rxdata_8[42] = mgt_rxdata[42],
    mgt_rxdata_8[41] = mgt_rxdata[41],
    mgt_rxdata_8[40] = mgt_rxdata[40],
    mgt_rxdata_8[39] = mgt_rxdata[39],
    mgt_rxdata_8[38] = mgt_rxdata[38],
    mgt_rxdata_8[37] = mgt_rxdata[37],
    mgt_rxdata_8[36] = mgt_rxdata[36],
    mgt_rxdata_8[35] = mgt_rxdata[35],
    mgt_rxdata_8[34] = mgt_rxdata[34],
    mgt_rxdata_8[33] = mgt_rxdata[33],
    mgt_rxdata_8[32] = mgt_rxdata[32],
    mgt_rxdata_8[31] = mgt_rxdata[31],
    mgt_rxdata_8[30] = mgt_rxdata[30],
    mgt_rxdata_8[29] = mgt_rxdata[29],
    mgt_rxdata_8[28] = mgt_rxdata[28],
    mgt_rxdata_8[27] = mgt_rxdata[27],
    mgt_rxdata_8[26] = mgt_rxdata[26],
    mgt_rxdata_8[25] = mgt_rxdata[25],
    mgt_rxdata_8[24] = mgt_rxdata[24],
    mgt_rxdata_8[23] = mgt_rxdata[23],
    mgt_rxdata_8[22] = mgt_rxdata[22],
    mgt_rxdata_8[21] = mgt_rxdata[21],
    mgt_rxdata_8[20] = mgt_rxdata[20],
    mgt_rxdata_8[19] = mgt_rxdata[19],
    mgt_rxdata_8[18] = mgt_rxdata[18],
    mgt_rxdata_8[17] = mgt_rxdata[17],
    mgt_rxdata_8[16] = mgt_rxdata[16],
    mgt_rxdata_8[15] = mgt_rxdata[15],
    mgt_rxdata_8[14] = mgt_rxdata[14],
    mgt_rxdata_8[13] = mgt_rxdata[13],
    mgt_rxdata_8[12] = mgt_rxdata[12],
    mgt_rxdata_8[11] = mgt_rxdata[11],
    mgt_rxdata_8[10] = mgt_rxdata[10],
    mgt_rxdata_8[9] = mgt_rxdata[9],
    mgt_rxdata_8[8] = mgt_rxdata[8],
    mgt_rxdata_8[7] = mgt_rxdata[7],
    mgt_rxdata_8[6] = mgt_rxdata[6],
    mgt_rxdata_8[5] = mgt_rxdata[5],
    mgt_rxdata_8[4] = mgt_rxdata[4],
    mgt_rxdata_8[3] = mgt_rxdata[3],
    mgt_rxdata_8[2] = mgt_rxdata[2],
    mgt_rxdata_8[1] = mgt_rxdata[1],
    mgt_rxdata_8[0] = mgt_rxdata[0],
    xgmii_txc_3[7] = xgmii_txc[7],
    xgmii_txc_3[6] = xgmii_txc[6],
    xgmii_txc_3[5] = xgmii_txc[5],
    xgmii_txc_3[4] = xgmii_txc[4],
    xgmii_txc_3[3] = xgmii_txc[3],
    xgmii_txc_3[2] = xgmii_txc[2],
    xgmii_txc_3[1] = xgmii_txc[1],
    xgmii_txc_3[0] = xgmii_txc[0],
    mgt_enable_align[3] = NlwRenamedSig_OI_mgt_enable_align[0],
    mgt_enable_align[2] = NlwRenamedSig_OI_mgt_enable_align[0],
    mgt_enable_align[1] = NlwRenamedSig_OI_mgt_enable_align[0],
    mgt_enable_align[0] = NlwRenamedSig_OI_mgt_enable_align[0],
    xgmii_txd_2[63] = xgmii_txd[63],
    xgmii_txd_2[62] = xgmii_txd[62],
    xgmii_txd_2[61] = xgmii_txd[61],
    xgmii_txd_2[60] = xgmii_txd[60],
    xgmii_txd_2[59] = xgmii_txd[59],
    xgmii_txd_2[58] = xgmii_txd[58],
    xgmii_txd_2[57] = xgmii_txd[57],
    xgmii_txd_2[56] = xgmii_txd[56],
    xgmii_txd_2[55] = xgmii_txd[55],
    xgmii_txd_2[54] = xgmii_txd[54],
    xgmii_txd_2[53] = xgmii_txd[53],
    xgmii_txd_2[52] = xgmii_txd[52],
    xgmii_txd_2[51] = xgmii_txd[51],
    xgmii_txd_2[50] = xgmii_txd[50],
    xgmii_txd_2[49] = xgmii_txd[49],
    xgmii_txd_2[48] = xgmii_txd[48],
    xgmii_txd_2[47] = xgmii_txd[47],
    xgmii_txd_2[46] = xgmii_txd[46],
    xgmii_txd_2[45] = xgmii_txd[45],
    xgmii_txd_2[44] = xgmii_txd[44],
    xgmii_txd_2[43] = xgmii_txd[43],
    xgmii_txd_2[42] = xgmii_txd[42],
    xgmii_txd_2[41] = xgmii_txd[41],
    xgmii_txd_2[40] = xgmii_txd[40],
    xgmii_txd_2[39] = xgmii_txd[39],
    xgmii_txd_2[38] = xgmii_txd[38],
    xgmii_txd_2[37] = xgmii_txd[37],
    xgmii_txd_2[36] = xgmii_txd[36],
    xgmii_txd_2[35] = xgmii_txd[35],
    xgmii_txd_2[34] = xgmii_txd[34],
    xgmii_txd_2[33] = xgmii_txd[33],
    xgmii_txd_2[32] = xgmii_txd[32],
    xgmii_txd_2[31] = xgmii_txd[31],
    xgmii_txd_2[30] = xgmii_txd[30],
    xgmii_txd_2[29] = xgmii_txd[29],
    xgmii_txd_2[28] = xgmii_txd[28],
    xgmii_txd_2[27] = xgmii_txd[27],
    xgmii_txd_2[26] = xgmii_txd[26],
    xgmii_txd_2[25] = xgmii_txd[25],
    xgmii_txd_2[24] = xgmii_txd[24],
    xgmii_txd_2[23] = xgmii_txd[23],
    xgmii_txd_2[22] = xgmii_txd[22],
    xgmii_txd_2[21] = xgmii_txd[21],
    xgmii_txd_2[20] = xgmii_txd[20],
    xgmii_txd_2[19] = xgmii_txd[19],
    xgmii_txd_2[18] = xgmii_txd[18],
    xgmii_txd_2[17] = xgmii_txd[17],
    xgmii_txd_2[16] = xgmii_txd[16],
    xgmii_txd_2[15] = xgmii_txd[15],
    xgmii_txd_2[14] = xgmii_txd[14],
    xgmii_txd_2[13] = xgmii_txd[13],
    xgmii_txd_2[12] = xgmii_txd[12],
    xgmii_txd_2[11] = xgmii_txd[11],
    xgmii_txd_2[10] = xgmii_txd[10],
    xgmii_txd_2[9] = xgmii_txd[9],
    xgmii_txd_2[8] = xgmii_txd[8],
    xgmii_txd_2[7] = xgmii_txd[7],
    xgmii_txd_2[6] = xgmii_txd[6],
    xgmii_txd_2[5] = xgmii_txd[5],
    xgmii_txd_2[4] = xgmii_txd[4],
    xgmii_txd_2[3] = xgmii_txd[3],
    xgmii_txd_2[2] = xgmii_txd[2],
    xgmii_txd_2[1] = xgmii_txd[1],
    xgmii_txd_2[0] = xgmii_txd[0],
    status_vector[7] = \NlwRenamedSig_OI_status_vector[7] ,
    status_vector[6] = NlwRenamedSig_OI_align_status,
    status_vector[5] = NlwRenamedSignal_status_vector[5],
    status_vector[4] = NlwRenamedSignal_status_vector[4],
    status_vector[3] = NlwRenamedSignal_status_vector[3],
    status_vector[2] = NlwRenamedSignal_status_vector[2],
    status_vector[1] = \NlwRenamedSig_OI_status_vector[1] ,
    status_vector[0] = \NlwRenamedSig_OI_status_vector[0] ,
    mgt_rxcharisk_9[7] = mgt_rxcharisk[7],
    mgt_rxcharisk_9[6] = mgt_rxcharisk[6],
    mgt_rxcharisk_9[5] = mgt_rxcharisk[5],
    mgt_rxcharisk_9[4] = mgt_rxcharisk[4],
    mgt_rxcharisk_9[3] = mgt_rxcharisk[3],
    mgt_rxcharisk_9[2] = mgt_rxcharisk[2],
    mgt_rxcharisk_9[1] = mgt_rxcharisk[1],
    mgt_rxcharisk_9[0] = mgt_rxcharisk[0],
    configuration_vector_17[6] = configuration_vector[6],
    configuration_vector_17[5] = configuration_vector[5],
    configuration_vector_17[4] = configuration_vector[4],
    configuration_vector_17[3] = configuration_vector[3],
    configuration_vector_17[2] = configuration_vector[2],
    NlwRenamedSignal_configuration_vector[1] = configuration_vector[1],
    NlwRenamedSignal_configuration_vector[0] = configuration_vector[0],
    mgt_codevalid_10[7] = mgt_codevalid[7],
    mgt_codevalid_10[6] = mgt_codevalid[6],
    mgt_codevalid_10[5] = mgt_codevalid[5],
    mgt_codevalid_10[4] = mgt_codevalid[4],
    mgt_codevalid_10[3] = mgt_codevalid[3],
    mgt_codevalid_10[2] = mgt_codevalid[2],
    mgt_codevalid_10[1] = mgt_codevalid[1],
    mgt_codevalid_10[0] = mgt_codevalid[0],
    mgt_powerdown = NlwRenamedSignal_configuration_vector[1],
    mgt_codecomma_11[7] = mgt_codecomma[7],
    mgt_codecomma_11[6] = mgt_codecomma[6],
    mgt_codecomma_11[5] = mgt_codecomma[5],
    mgt_codecomma_11[4] = mgt_codecomma[4],
    mgt_codecomma_11[3] = mgt_codecomma[3],
    mgt_codecomma_11[2] = mgt_codecomma[2],
    mgt_codecomma_11[1] = mgt_codecomma[1],
    mgt_codecomma_11[0] = mgt_codecomma[0],
    sync_status[3] = NlwRenamedSignal_status_vector[5],
    sync_status[2] = NlwRenamedSignal_status_vector[4],
    sync_status[1] = NlwRenamedSignal_status_vector[3],
    sync_status[0] = NlwRenamedSignal_status_vector[2],
    xgmii_rxc[7] = xgmii_rxc_5[7],
    xgmii_rxc[6] = xgmii_rxc_5[6],
    xgmii_rxc[5] = xgmii_rxc_5[5],
    xgmii_rxc[4] = xgmii_rxc_5[4],
    xgmii_rxc[3] = xgmii_rxc_5[3],
    xgmii_rxc[2] = xgmii_rxc_5[2],
    xgmii_rxc[1] = xgmii_rxc_5[1],
    xgmii_rxc[0] = xgmii_rxc_5[0],
    xgmii_rxd[63] = xgmii_rxd_4[63],
    xgmii_rxd[62] = xgmii_rxd_4[62],
    xgmii_rxd[61] = xgmii_rxd_4[61],
    xgmii_rxd[60] = xgmii_rxd_4[60],
    xgmii_rxd[59] = xgmii_rxd_4[59],
    xgmii_rxd[58] = xgmii_rxd_4[58],
    xgmii_rxd[57] = xgmii_rxd_4[57],
    xgmii_rxd[56] = xgmii_rxd_4[56],
    xgmii_rxd[55] = xgmii_rxd_4[55],
    xgmii_rxd[54] = xgmii_rxd_4[54],
    xgmii_rxd[53] = xgmii_rxd_4[53],
    xgmii_rxd[52] = xgmii_rxd_4[52],
    xgmii_rxd[51] = xgmii_rxd_4[51],
    xgmii_rxd[50] = xgmii_rxd_4[50],
    xgmii_rxd[49] = xgmii_rxd_4[49],
    xgmii_rxd[48] = xgmii_rxd_4[48],
    xgmii_rxd[47] = xgmii_rxd_4[47],
    xgmii_rxd[46] = xgmii_rxd_4[46],
    xgmii_rxd[45] = xgmii_rxd_4[45],
    xgmii_rxd[44] = xgmii_rxd_4[44],
    xgmii_rxd[43] = xgmii_rxd_4[43],
    xgmii_rxd[42] = xgmii_rxd_4[42],
    xgmii_rxd[41] = xgmii_rxd_4[41],
    xgmii_rxd[40] = xgmii_rxd_4[40],
    xgmii_rxd[39] = xgmii_rxd_4[39],
    xgmii_rxd[38] = xgmii_rxd_4[38],
    xgmii_rxd[37] = xgmii_rxd_4[37],
    xgmii_rxd[36] = xgmii_rxd_4[36],
    xgmii_rxd[35] = xgmii_rxd_4[35],
    xgmii_rxd[34] = xgmii_rxd_4[34],
    xgmii_rxd[33] = xgmii_rxd_4[33],
    xgmii_rxd[32] = xgmii_rxd_4[32],
    xgmii_rxd[31] = xgmii_rxd_4[31],
    xgmii_rxd[30] = xgmii_rxd_4[30],
    xgmii_rxd[29] = xgmii_rxd_4[29],
    xgmii_rxd[28] = xgmii_rxd_4[28],
    xgmii_rxd[27] = xgmii_rxd_4[27],
    xgmii_rxd[26] = xgmii_rxd_4[26],
    xgmii_rxd[25] = xgmii_rxd_4[25],
    xgmii_rxd[24] = xgmii_rxd_4[24],
    xgmii_rxd[23] = xgmii_rxd_4[23],
    xgmii_rxd[22] = xgmii_rxd_4[22],
    xgmii_rxd[21] = xgmii_rxd_4[21],
    xgmii_rxd[20] = xgmii_rxd_4[20],
    xgmii_rxd[19] = xgmii_rxd_4[19],
    xgmii_rxd[18] = xgmii_rxd_4[18],
    xgmii_rxd[17] = xgmii_rxd_4[17],
    xgmii_rxd[16] = xgmii_rxd_4[16],
    xgmii_rxd[15] = xgmii_rxd_4[15],
    xgmii_rxd[14] = xgmii_rxd_4[14],
    xgmii_rxd[13] = xgmii_rxd_4[13],
    xgmii_rxd[12] = xgmii_rxd_4[12],
    xgmii_rxd[11] = xgmii_rxd_4[11],
    xgmii_rxd[10] = xgmii_rxd_4[10],
    xgmii_rxd[9] = xgmii_rxd_4[9],
    xgmii_rxd[8] = xgmii_rxd_4[8],
    xgmii_rxd[7] = xgmii_rxd_4[7],
    xgmii_rxd[6] = xgmii_rxd_4[6],
    xgmii_rxd[5] = xgmii_rxd_4[5],
    xgmii_rxd[4] = xgmii_rxd_4[4],
    xgmii_rxd[3] = xgmii_rxd_4[3],
    xgmii_rxd[2] = xgmii_rxd_4[2],
    xgmii_rxd[1] = xgmii_rxd_4[1],
    xgmii_rxd[0] = xgmii_rxd_4[0],
    mgt_loopback = NlwRenamedSignal_configuration_vector[0],
    mgt_txdata[63] = mgt_txdata_6[63],
    mgt_txdata[62] = mgt_txdata_6[62],
    mgt_txdata[61] = mgt_txdata_6[61],
    mgt_txdata[60] = mgt_txdata_6[60],
    mgt_txdata[59] = mgt_txdata_6[59],
    mgt_txdata[58] = mgt_txdata_6[58],
    mgt_txdata[57] = mgt_txdata_6[57],
    mgt_txdata[56] = mgt_txdata_6[56],
    mgt_txdata[55] = mgt_txdata_6[55],
    mgt_txdata[54] = mgt_txdata_6[54],
    mgt_txdata[53] = mgt_txdata_6[53],
    mgt_txdata[52] = mgt_txdata_6[52],
    mgt_txdata[51] = mgt_txdata_6[51],
    mgt_txdata[50] = mgt_txdata_6[50],
    mgt_txdata[49] = mgt_txdata_6[49],
    mgt_txdata[48] = mgt_txdata_6[48],
    mgt_txdata[47] = mgt_txdata_6[47],
    mgt_txdata[46] = mgt_txdata_6[46],
    mgt_txdata[45] = mgt_txdata_6[45],
    mgt_txdata[44] = mgt_txdata_6[44],
    mgt_txdata[43] = mgt_txdata_6[43],
    mgt_txdata[42] = mgt_txdata_6[42],
    mgt_txdata[41] = mgt_txdata_6[41],
    mgt_txdata[40] = mgt_txdata_6[40],
    mgt_txdata[39] = mgt_txdata_6[39],
    mgt_txdata[38] = mgt_txdata_6[38],
    mgt_txdata[37] = mgt_txdata_6[37],
    mgt_txdata[36] = mgt_txdata_6[36],
    mgt_txdata[35] = mgt_txdata_6[35],
    mgt_txdata[34] = mgt_txdata_6[34],
    mgt_txdata[33] = mgt_txdata_6[33],
    mgt_txdata[32] = mgt_txdata_6[32],
    mgt_txdata[31] = mgt_txdata_6[31],
    mgt_txdata[30] = mgt_txdata_6[30],
    mgt_txdata[29] = mgt_txdata_6[29],
    mgt_txdata[28] = mgt_txdata_6[28],
    mgt_txdata[27] = mgt_txdata_6[27],
    mgt_txdata[26] = mgt_txdata_6[26],
    mgt_txdata[25] = mgt_txdata_6[25],
    mgt_txdata[24] = mgt_txdata_6[24],
    mgt_txdata[23] = mgt_txdata_6[23],
    mgt_txdata[22] = mgt_txdata_6[22],
    mgt_txdata[21] = mgt_txdata_6[21],
    mgt_txdata[20] = mgt_txdata_6[20],
    mgt_txdata[19] = mgt_txdata_6[19],
    mgt_txdata[18] = mgt_txdata_6[18],
    mgt_txdata[17] = mgt_txdata_6[17],
    mgt_txdata[16] = mgt_txdata_6[16],
    mgt_txdata[15] = mgt_txdata_6[15],
    mgt_txdata[14] = mgt_txdata_6[14],
    mgt_txdata[13] = mgt_txdata_6[13],
    mgt_txdata[12] = mgt_txdata_6[12],
    mgt_txdata[11] = mgt_txdata_6[11],
    mgt_txdata[10] = mgt_txdata_6[10],
    mgt_txdata[9] = mgt_txdata_6[9],
    mgt_txdata[8] = mgt_txdata_6[8],
    mgt_txdata[7] = mgt_txdata_6[7],
    mgt_txdata[6] = mgt_txdata_6[6],
    mgt_txdata[5] = mgt_txdata_6[5],
    mgt_txdata[4] = mgt_txdata_6[4],
    mgt_txdata[3] = mgt_txdata_6[3],
    mgt_txdata[2] = mgt_txdata_6[2],
    mgt_txdata[1] = mgt_txdata_6[1],
    mgt_txdata[0] = mgt_txdata_6[0],
    mgt_rx_reset_15[3] = mgt_rx_reset[3],
    mgt_rx_reset_15[2] = mgt_rx_reset[2],
    mgt_rx_reset_15[1] = mgt_rx_reset[1],
    mgt_rx_reset_15[0] = mgt_rx_reset[0],
    signal_detect_16[3] = signal_detect[3],
    signal_detect_16[2] = signal_detect[2],
    signal_detect_16[1] = signal_detect[1],
    signal_detect_16[0] = signal_detect[0];
  VCC   VCC_0 (
    .P(N1)
  );
  GND   GND_1 (
    .G(N0)
  );
  MUXF7   \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0_f7  (
    .I0(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01_1221 ),
    .I1(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0 ),
    .S(\BU2/U0/transmitter/tx_is_q [1]),
    .O(\BU2/N267 )
  );
  LUT6 #(
    .INIT ( 64'h2020202020A02020 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW02  (
    .I0(\BU2/U0/transmitter/tx_is_idle [1]),
    .I1(\BU2/U0/transmitter/align/count [2]),
    .I2(\BU2/U0/transmitter/align/N5 ),
    .I3(\BU2/U0/transmitter/align/count [0]),
    .I4(\BU2/U0/transmitter/align/extra_a_1022 ),
    .I5(\BU2/U0/transmitter/align/count [1]),
    .O(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01_1221 )
  );
  LUT5 #(
    .INIT ( 32'h0400FF00 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01  (
    .I0(\BU2/U0/transmitter/align/count [1]),
    .I1(\BU2/U0/transmitter/align/extra_a_1022 ),
    .I2(\BU2/U0/transmitter/align/count [0]),
    .I3(\BU2/U0/transmitter/align/N5 ),
    .I4(\BU2/U0/transmitter/align/count [2]),
    .O(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0 )
  );
  MUXF7   \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot_f7  (
    .I0(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2_1219 ),
    .I1(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1_1218 ),
    .S(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .O(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot )
  );
  LUT6 #(
    .INIT ( 64'h88DD80D088DD8ADF ))
  \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1084 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .O(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2_1219 )
  );
  LUT4 #(
    .INIT ( 16'hC8CD ))
  \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I1(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1084 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .O(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1_1218 )
  );
  MUXF7   \BU2/U0/rx_local_fault_rstpot1_f7  (
    .I0(\BU2/U0/rx_local_fault_rstpot12_1217 ),
    .I1(\BU2/U0/rx_local_fault_rstpot11_1216 ),
    .S(\NlwRenamedSig_OI_status_vector[1] ),
    .O(\BU2/U0/rx_local_fault_rstpot1 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFEFF ))
  \BU2/U0/rx_local_fault_rstpot12  (
    .I0(mgt_rx_reset_15[0]),
    .I1(mgt_rx_reset_15[2]),
    .I2(mgt_rx_reset_15[3]),
    .I3(NlwRenamedSig_OI_align_status),
    .I4(mgt_rx_reset_15[1]),
    .O(\BU2/U0/rx_local_fault_rstpot12_1217 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFEFFFFFF ))
  \BU2/U0/rx_local_fault_rstpot11  (
    .I0(mgt_rx_reset_15[0]),
    .I1(mgt_rx_reset_15[1]),
    .I2(mgt_rx_reset_15[3]),
    .I3(\BU2/U0/clear_local_fault_edge_1098 ),
    .I4(NlwRenamedSig_OI_align_status),
    .I5(mgt_rx_reset_15[2]),
    .O(\BU2/U0/rx_local_fault_rstpot11_1216 )
  );
  LUT6 #(
    .INIT ( 64'hF111FB11FFFFFB11 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>_G  (
    .I0(\BU2/U0/transmitter/tx_is_q [0]),
    .I1(\BU2/U0/transmitter/tx_is_idle [0]),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .I3(\BU2/U0/transmitter/tx_code_a [1]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/k_r_prbs_i/prbs [8]),
    .O(\BU2/N280 )
  );
  LUT5 #(
    .INIT ( 32'h111F1110 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>_F  (
    .I0(\BU2/U0/transmitter/tx_is_q [0]),
    .I1(\BU2/U0/transmitter/tx_is_idle [0]),
    .I2(\BU2/U0/transmitter/a_due [0]),
    .I3(\BU2/U0/transmitter/k_r_prbs_i/prbs [8]),
    .I4(\BU2/N143 ),
    .O(\BU2/N279 )
  );
  MUXF7   \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>  (
    .I0(\BU2/N279 ),
    .I1(\BU2/N280 ),
    .S(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .O(\BU2/U0/transmitter/state_machine/next_state<0> [0])
  );
  LUT6 #(
    .INIT ( 64'h1F1F111BFF1FFF1B ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<0>_G  (
    .I0(\BU2/U0/transmitter/tx_is_q [1]),
    .I1(\BU2/U0/transmitter/tx_is_idle [1]),
    .I2(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .I3(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .I5(\BU2/U0/transmitter/k_r_prbs_i/prbs [7]),
    .O(\BU2/N278 )
  );
  LUT6 #(
    .INIT ( 64'h022202220222FFFF ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<0>_F  (
    .I0(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I1(\BU2/U0/transmitter/k_r_prbs_i/prbs [7]),
    .I2(\BU2/N151 ),
    .I3(\BU2/U0/transmitter/align/N5 ),
    .I4(\BU2/U0/transmitter/tx_is_q [1]),
    .I5(\BU2/U0/transmitter/tx_is_idle [1]),
    .O(\BU2/N277 )
  );
  MUXF7   \BU2/U0/transmitter/state_machine/next_state_1_mux0002<0>  (
    .I0(\BU2/N277 ),
    .I1(\BU2/N278 ),
    .S(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .O(\BU2/U0/transmitter/state_machine/next_state<1> [0])
  );
  LUT6 #(
    .INIT ( 64'h0200000002020202 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000641  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(configuration_vector_17[6]),
    .I4(configuration_vector_17[5]),
    .I5(configuration_vector_17[4]),
    .O(\BU2/U0/transmitter/recoder/N36 )
  );
  LUT6 #(
    .INIT ( 64'h0200000002020202 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000631  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(configuration_vector_17[6]),
    .I4(configuration_vector_17[5]),
    .I5(configuration_vector_17[4]),
    .O(\BU2/U0/transmitter/recoder/N35 )
  );
  LUT6 #(
    .INIT ( 64'hAEAEAEAEAAAEAAAA ))
  \BU2/U0/transmitter/recoder/txc_out_0_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/N17 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_590 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_0_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hAEAEAEAEAAAEAAAA ))
  \BU2/U0/transmitter/recoder/txc_out_4_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/N18 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_586 ),
    .I5(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_4_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFDDFFCCF20023003 ))
  \BU2/U0/transmitter/align/count_mux0000<2>1  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/tx_code_a [0]),
    .I2(\BU2/U0/transmitter/align/count [2]),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I5(\BU2/U0/transmitter/align/prbs [3]),
    .O(\BU2/U0/transmitter/align/count_mux0000 [2])
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_14_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [14]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_14_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_22_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [22]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_22_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_30_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [30]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_30_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_38_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [6]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_38_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_46_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [14]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_46_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_54_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [22]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_54_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_62_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [30]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_62_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_6_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [6]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_6_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFAEEAAAAE ))
  \BU2/U0/receiver/recoder/rxd_out_33_rstpot  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/N17 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I5(\BU2/U0/receiver/recoder/error_lane [4]),
    .O(\BU2/U0/receiver/recoder/rxd_out_33_rstpot_1087 )
  );
  LUT6 #(
    .INIT ( 64'h5DD1FFF35DD15DD1 ))
  \BU2/U0/transmitter/recoder/txd_out_11_mux000632  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(configuration_vector_17[4]),
    .I2(configuration_vector_17[6]),
    .I3(configuration_vector_17[5]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .O(\BU2/U0/transmitter/recoder/N17 )
  );
  LUT6 #(
    .INIT ( 64'h5DD1FFF35DD15DD1 ))
  \BU2/U0/transmitter/recoder/txd_out_35_mux000622  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(configuration_vector_17[4]),
    .I2(configuration_vector_17[6]),
    .I3(configuration_vector_17[5]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I5(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .O(\BU2/U0/transmitter/recoder/N18 )
  );
  LUT6 #(
    .INIT ( 64'hF3FBF0FAC040F050 ))
  \BU2/U0/transmitter/align/count_mux0000<0>1  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I2(\BU2/U0/transmitter/align/count [0]),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I5(\BU2/U0/transmitter/align/prbs [1]),
    .O(\BU2/U0/transmitter/align/count_mux0000 [0])
  );
  LUT6 #(
    .INIT ( 64'h20EF20EFAAAA20EF ))
  \BU2/U0/transmitter/align/count_mux0000<1>1  (
    .I0(\BU2/U0/transmitter/align/prbs [2]),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/align/count_mux0000 [1])
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_16_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [16]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_16_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_24_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [24]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_24_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000612  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [0]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_32_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_40_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [8]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_40_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000612  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [0]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_0_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_48_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [16]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_48_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_56_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [24]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_56_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_8_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [8]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_8_mux00061 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_17_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [17]),
    .O(\BU2/U0/transmitter/recoder/txd_out_17_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_1_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [1]),
    .O(\BU2/U0/transmitter/recoder/txd_out_1_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_25_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [25]),
    .O(\BU2/U0/transmitter/recoder/txd_out_25_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_33_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [1]),
    .O(\BU2/U0/transmitter/recoder/txd_out_33_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_41_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [9]),
    .O(\BU2/U0/transmitter/recoder/txd_out_41_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_49_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [17]),
    .O(\BU2/U0/transmitter/recoder/txd_out_49_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_57_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [25]),
    .O(\BU2/U0/transmitter/recoder/txd_out_57_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_9_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [9]),
    .O(\BU2/U0/transmitter/recoder/txd_out_9_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_10_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [10]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_10_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_12_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [12]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_12_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_13_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [13]),
    .O(\BU2/U0/transmitter/recoder/txd_out_13_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_15_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [15]),
    .O(\BU2/U0/transmitter/recoder/txd_out_15_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_18_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [18]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_18_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_20_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [20]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_20_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_21_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [21]),
    .O(\BU2/U0/transmitter/recoder/txd_out_21_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_23_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [23]),
    .O(\BU2/U0/transmitter/recoder/txd_out_23_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_26_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [26]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_26_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_28_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [28]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_28_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_29_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [29]),
    .O(\BU2/U0/transmitter/recoder/txd_out_29_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_2_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [2]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_2_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_31_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [31]),
    .O(\BU2/U0/transmitter/recoder/txd_out_31_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_34_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [2]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_34_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_36_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [4]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_36_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_37_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [5]),
    .O(\BU2/U0/transmitter/recoder/txd_out_37_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_39_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [7]),
    .O(\BU2/U0/transmitter/recoder/txd_out_39_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_42_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [10]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_42_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_44_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [12]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_44_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_45_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [13]),
    .O(\BU2/U0/transmitter/recoder/txd_out_45_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_47_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [15]),
    .O(\BU2/U0/transmitter/recoder/txd_out_47_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_4_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [4]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_4_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_50_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [18]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_50_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_52_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [20]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_52_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_53_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [21]),
    .O(\BU2/U0/transmitter/recoder/txd_out_53_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_55_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [23]),
    .O(\BU2/U0/transmitter/recoder/txd_out_55_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_58_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [26]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_58_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_5_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [5]),
    .O(\BU2/U0/transmitter/recoder/txd_out_5_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_60_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [28]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_60_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_61_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [29]),
    .O(\BU2/U0/transmitter/recoder/txd_out_61_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_63_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [31]),
    .O(\BU2/U0/transmitter/recoder/txd_out_63_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_7_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [7]),
    .O(\BU2/U0/transmitter/recoder/txd_out_7_mux0005 )
  );
  LUT4 #(
    .INIT ( 16'h4F44 ))
  \BU2/U0/transmitter/align/prbs_1_not00001  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .O(\BU2/U0/transmitter/align/prbs_1_not0000 )
  );
  LUT5 #(
    .INIT ( 32'h103050F0 ))
  \BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot_1209 )
  );
  LUT6 #(
    .INIT ( 64'h2022202030333030 ))
  \BU2/U0/transmitter/align/extra_a_rstpot1  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/usrclk_reset_328 ),
    .I2(\BU2/U0/transmitter/align/extra_a_1022 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I5(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .O(\BU2/U0/transmitter/align/extra_a_rstpot1_1138 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_16_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/mux0011_or0000_958 ),
    .I2(\BU2/U0/usrclk_reset_328 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [2]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [16]),
    .O(\BU2/U0/receiver/recoder/rxd_out_16_rstpot1_1140 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_8_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/mux0007_or0000_966 ),
    .I2(\BU2/U0/usrclk_reset_328 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [1]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [8]),
    .O(\BU2/U0/receiver/recoder/rxd_out_8_rstpot1_1139 )
  );
  LUT4 #(
    .INIT ( 16'h7FFE ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00025  (
    .I0(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N2 ),
    .I1(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N4 ),
    .I2(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N6 ),
    .I3(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N8 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'h7FFE ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00025  (
    .I0(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N11 ),
    .I1(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N3 ),
    .I2(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N5 ),
    .I3(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N7 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_11_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N23 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N17 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [11]),
    .I5(\BU2/U0/transmitter/recoder/N32 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_11_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_19_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N23 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N17 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [19]),
    .I5(\BU2/U0/transmitter/recoder/N32 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_19_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_27_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N23 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N17 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [27]),
    .I5(\BU2/U0/transmitter/recoder/N32 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_27_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_35_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N22 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N18 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [3]),
    .I5(\BU2/U0/transmitter/recoder/N31 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_35_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_3_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N23 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N17 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [3]),
    .I5(\BU2/U0/transmitter/recoder/N32 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_3_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_43_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N22 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N18 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [11]),
    .I5(\BU2/U0/transmitter/recoder/N31 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_43_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_51_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N22 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N18 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [19]),
    .I5(\BU2/U0/transmitter/recoder/N31 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_51_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF55FF40FF40FF40 ))
  \BU2/U0/transmitter/recoder/txd_out_59_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/recoder/N22 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> ),
    .I3(\BU2/U0/transmitter/recoder/N18 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [27]),
    .I5(\BU2/U0/transmitter/recoder/N31 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_59_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF0020 ))
  \BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_996 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_588 ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_997 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_587 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot_1209 ),
    .I5(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1_1091 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_1_mux00061  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/recoder/N46 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_589 ),
    .I5(\BU2/U0/transmitter/recoder/N36 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_1_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_2_mux00061  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/recoder/N46 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_588 ),
    .I5(\BU2/U0/transmitter/recoder/N36 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_2_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_3_mux00061  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/recoder/N46 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_587 ),
    .I5(\BU2/U0/transmitter/recoder/N36 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_3_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_5_mux00061  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/recoder/N43 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_585 ),
    .I5(\BU2/U0/transmitter/recoder/N35 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_5_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_6_mux00061  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/recoder/N43 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_584 ),
    .I5(\BU2/U0/transmitter/recoder/N35 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_6_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_7_mux00061  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/recoder/N43 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_583 ),
    .I5(\BU2/U0/transmitter/recoder/N35 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_7_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF00808008 ))
  \BU2/U0/receiver/recoder/rxd_out_41_or00001  (
    .I0(\BU2/U0/receiver/recoder/N18 ),
    .I1(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I5(\BU2/U0/receiver/recoder/error_lane [5]),
    .O(\BU2/U0/receiver/recoder/rxd_out_41_or0000 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/recoder/rxd_out_56_mux0002_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [25]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [28]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [27]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [26]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [24]),
    .O(\BU2/N112 )
  );
  LUT6 #(
    .INIT ( 64'hFEFEFEEF10101001 ))
  \BU2/U0/transmitter/align/count_mux0000<3>1  (
    .I0(\BU2/U0/transmitter/tx_code_a [1]),
    .I1(\BU2/U0/transmitter/tx_code_a [0]),
    .I2(\BU2/U0/transmitter/align/count [3]),
    .I3(\BU2/U0/transmitter/align/count [2]),
    .I4(\BU2/U0/transmitter/align/count [1]),
    .I5(\BU2/U0/transmitter/align/prbs [4]),
    .O(\BU2/U0/transmitter/align/count_mux0000 [3])
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \BU2/U0/transmitter/align/count_not00011  (
    .I0(\BU2/U0/transmitter/tx_code_a [1]),
    .I1(\BU2/U0/transmitter/tx_code_a [0]),
    .I2(\BU2/U0/transmitter/align/count [2]),
    .I3(\BU2/U0/transmitter/align/count [3]),
    .I4(\BU2/U0/transmitter/align/count [1]),
    .I5(\BU2/U0/transmitter/align/count [4]),
    .O(\BU2/U0/transmitter/align/count_not0001 )
  );
  LUT6 #(
    .INIT ( 64'hAEAEAEAAAEAEFFFF ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>_SW4  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .I4(\BU2/U0/transmitter/tx_is_q [0]),
    .I5(\BU2/U0/transmitter/tx_is_idle [0]),
    .O(\BU2/N143 )
  );
  LUT6 #(
    .INIT ( 64'h8080AAAAC080FFAA ))
  \BU2/U0/transmitter/recoder/txd_out_62_mux000657  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I4(configuration_vector_17[4]),
    .I5(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 )
  );
  LUT6 #(
    .INIT ( 64'h8080AAAAC080FFAA ))
  \BU2/U0/transmitter/recoder/txd_out_6_mux000657  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[5]),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I4(configuration_vector_17[4]),
    .I5(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 )
  );
  LUT3 #(
    .INIT ( 8'h4F ))
  \BU2/U0/transmitter/recoder/txd_out_11_mux0006311  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/N46 )
  );
  LUT3 #(
    .INIT ( 8'h4F ))
  \BU2/U0/transmitter/recoder/txd_out_35_mux0006211  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/N43 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000611  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_2_578 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/recoder/N23 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000611  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/recoder/N22 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000631  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .O(\BU2/U0/transmitter/recoder/N32 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000621  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .O(\BU2/U0/transmitter/recoder/N31 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF2802 ))
  \BU2/U0/receiver/recoder/rxd_out_32_rstpot  (
    .I0(\BU2/U0/receiver/recoder/N17 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [0]),
    .O(\BU2/U0/receiver/recoder/rxd_out_32_rstpot_1088 )
  );
  LUT6 #(
    .INIT ( 64'hA22AAAA2AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_43_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [11]),
    .I1(\BU2/U0/receiver/recoder/N18 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I5(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .O(\BU2/U0/receiver/recoder/rxd_out_43_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hA22AAAA2AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_44_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [12]),
    .I1(\BU2/U0/receiver/recoder/N18 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I5(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .O(\BU2/U0/receiver/recoder/rxd_out_44_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'hA22AAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_45_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I1(\BU2/U0/receiver/recoder/N18 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .O(\BU2/U0/receiver/recoder/rxd_out_45_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'hAAAA2AAA ))
  \BU2/U0/receiver/recoder/rxd_out_46_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I1(\BU2/U0/receiver/recoder/N18 ),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .O(\BU2/U0/receiver/recoder/rxd_out_46_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'hAAAA2AAA ))
  \BU2/U0/receiver/recoder/rxd_out_47_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I1(\BU2/U0/receiver/recoder/N18 ),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .O(\BU2/U0/receiver/recoder/rxd_out_47_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/receiver/recoder/error_lane_6_or0000101  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [3]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [2]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I3(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .O(\BU2/U0/receiver/recoder/error_lane_6_or0000101_1144 )
  );
  LUT4 #(
    .INIT ( 16'hA22A ))
  \BU2/U0/receiver/recoder/rxd_out_37_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I1(\BU2/U0/receiver/recoder/N17 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .O(\BU2/U0/receiver/recoder/rxd_out_37_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'hAA2A ))
  \BU2/U0/receiver/recoder/rxd_out_38_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I1(\BU2/U0/receiver/recoder/N17 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .O(\BU2/U0/receiver/recoder/rxd_out_38_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'hAA2A ))
  \BU2/U0/receiver/recoder/rxd_out_39_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I1(\BU2/U0/receiver/recoder/N17 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .O(\BU2/U0/receiver/recoder/rxd_out_39_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'hA22A ))
  \BU2/U0/receiver/recoder/rxd_out_53_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I1(\BU2/U0/receiver/recoder/N16 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .O(\BU2/U0/receiver/recoder/rxd_out_53_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'hAA2A ))
  \BU2/U0/receiver/recoder/rxd_out_54_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I1(\BU2/U0/receiver/recoder/N16 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .O(\BU2/U0/receiver/recoder/rxd_out_54_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'hAA2A ))
  \BU2/U0/receiver/recoder/rxd_out_55_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/N16 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .O(\BU2/U0/receiver/recoder/rxd_out_55_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFCCC9 ))
  \BU2/U0/transmitter/align/count_mux0000<4>1  (
    .I0(\BU2/U0/transmitter/align/count [2]),
    .I1(\BU2/U0/transmitter/align/count [4]),
    .I2(\BU2/U0/transmitter/align/count [3]),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/tx_code_a [1]),
    .I5(\BU2/U0/transmitter/tx_code_a [0]),
    .O(\BU2/U0/transmitter/align/count_mux0000 [4])
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_11_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I4(\BU2/N92 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .O(\BU2/U0/receiver/recoder/rxd_out_11_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_12_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I4(\BU2/N92 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .O(\BU2/U0/receiver/recoder/rxd_out_12_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_19_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I4(\BU2/N90 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .O(\BU2/U0/receiver/recoder/rxd_out_19_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_20_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I4(\BU2/N90 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .O(\BU2/U0/receiver/recoder/rxd_out_20_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_27_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I4(\BU2/N88 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .O(\BU2/U0/receiver/recoder/rxd_out_27_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_28_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I4(\BU2/N88 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .O(\BU2/U0/receiver/recoder/rxd_out_28_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_3_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [3]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [7]),
    .I4(\BU2/N94 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [4]),
    .O(\BU2/U0/receiver/recoder/rxd_out_3_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAA8A28AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_4_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [4]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [7]),
    .I4(\BU2/N94 ),
    .I5(\BU2/U0/receiver/recoder/rxd_half_pipe [3]),
    .O(\BU2/U0/receiver/recoder/rxd_out_4_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'h8A28AAAA ))
  \BU2/U0/receiver/recoder/rxd_out_35_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [3]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I4(\BU2/U0/receiver/recoder/N17 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_35_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'h8A28AAAA ))
  \BU2/U0/receiver/recoder/rxd_out_36_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [4]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I4(\BU2/U0/receiver/recoder/N17 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_36_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'h8A28AAAA ))
  \BU2/U0/receiver/recoder/rxd_out_51_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [19]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I4(\BU2/U0/receiver/recoder/N16 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_51_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'h8A28AAAA ))
  \BU2/U0/receiver/recoder/rxd_out_52_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [20]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I4(\BU2/U0/receiver/recoder/N16 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_52_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0F090F0F0F0 ))
  \BU2/U0/receiver/recoder/rxd_out_13_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .I5(\BU2/N92 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_13_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_14_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I5(\BU2/N92 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_14_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_15_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I5(\BU2/N92 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_15_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0F090F0F0F0 ))
  \BU2/U0/receiver/recoder/rxd_out_21_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .I5(\BU2/N90 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_21_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_22_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I5(\BU2/N90 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_22_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_23_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I5(\BU2/N90 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_23_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0F090F0F0F0 ))
  \BU2/U0/receiver/recoder/rxd_out_29_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .I5(\BU2/N88 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_29_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_30_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I5(\BU2/N88 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_30_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_31_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I5(\BU2/N88 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_31_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0F090F0F0F0 ))
  \BU2/U0/receiver/recoder/rxd_out_5_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [7]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [4]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [3]),
    .I5(\BU2/N94 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_5_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_6_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [6]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [7]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [4]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [3]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [5]),
    .I5(\BU2/N94 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_6_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_7_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [7]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [4]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [3]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [5]),
    .I5(\BU2/N94 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_7_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFCFFAAFFA8 ))
  \BU2/U0/receiver/recoder/error_lane_7_or000071  (
    .I0(\BU2/U0/receiver/recoder/error_lane_7_or000013_1006 ),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [5]),
    .I3(\BU2/U0/receiver/recoder/code_error_pipe [3]),
    .I4(\BU2/U0/receiver/recoder/lane_terminate [6]),
    .I5(\BU2/N275 ),
    .O(\BU2/U0/receiver/recoder/error_lane [7])
  );
  LUT5 #(
    .INIT ( 32'h7FFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_7_or000071_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [7]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [58]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [59]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [61]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [63]),
    .O(\BU2/N275 )
  );
  LUT6 #(
    .INIT ( 64'h111F1F1FFFFFFFFF ))
  \BU2/U0/transmitter/align/a_cnt_0_mux00011_SW0  (
    .I0(\BU2/U0/transmitter/tx_is_idle [0]),
    .I1(\BU2/U0/transmitter/tx_is_q [0]),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I4(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1084 ),
    .I5(\BU2/N273 ),
    .O(\BU2/N153 )
  );
  LUT3 #(
    .INIT ( 8'hF7 ))
  \BU2/U0/transmitter/align/a_cnt_0_mux00011_SW0_SW0  (
    .I0(\BU2/U0/transmitter/align/count [0]),
    .I1(\BU2/U0/transmitter/align/count [1]),
    .I2(\BU2/U0/transmitter/align/extra_a_1022 ),
    .O(\BU2/N273 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFAEAAAAAA ))
  \BU2/U0/transmitter/is_terminate_0_mux0000128  (
    .I0(\BU2/U0/transmitter/is_terminate_0_mux0000103_1147 ),
    .I1(\BU2/U0/transmitter/is_terminate_0_mux000010_989 ),
    .I2(\BU2/U0/transmitter/txd_pipe [17]),
    .I3(\BU2/U0/transmitter/txd_pipe [22]),
    .I4(\BU2/U0/transmitter/txd_pipe [23]),
    .I5(\BU2/N271 ),
    .O(\BU2/U0/transmitter/is_terminate [0])
  );
  LUT6 #(
    .INIT ( 64'hFFFF200020002000 ))
  \BU2/U0/transmitter/is_terminate_0_mux0000128_SW0  (
    .I0(\BU2/U0/transmitter/is_terminate_0_mux000072_992 ),
    .I1(\BU2/U0/transmitter/txd_pipe [1]),
    .I2(\BU2/U0/transmitter/txd_pipe [6]),
    .I3(\BU2/U0/transmitter/txd_pipe [7]),
    .I4(\BU2/U0/transmitter/is_terminate_0_mux000035_990 ),
    .I5(\BU2/U0/transmitter/is_terminate_0_mux000040_991 ),
    .O(\BU2/N271 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFAEAAAAAA ))
  \BU2/U0/transmitter/is_terminate_1_mux0000128  (
    .I0(\BU2/U0/transmitter/is_terminate_1_mux0000103_1146 ),
    .I1(\BU2/U0/transmitter/is_terminate_1_mux000010_984 ),
    .I2(\BU2/U0/transmitter/txd_pipe [49]),
    .I3(\BU2/U0/transmitter/txd_pipe [54]),
    .I4(\BU2/U0/transmitter/txd_pipe [55]),
    .I5(\BU2/N269 ),
    .O(\BU2/U0/transmitter/is_terminate [1])
  );
  LUT6 #(
    .INIT ( 64'hFFFF200020002000 ))
  \BU2/U0/transmitter/is_terminate_1_mux0000128_SW0  (
    .I0(\BU2/U0/transmitter/is_terminate_1_mux000072_987 ),
    .I1(\BU2/U0/transmitter/txd_pipe [33]),
    .I2(\BU2/U0/transmitter/txd_pipe [38]),
    .I3(\BU2/U0/transmitter/txd_pipe [39]),
    .I4(\BU2/U0/transmitter/is_terminate_1_mux000035_985 ),
    .I5(\BU2/U0/transmitter/is_terminate_1_mux000040_986 ),
    .O(\BU2/N269 )
  );
  LUT6 #(
    .INIT ( 64'h7340734062404040 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>  (
    .I0(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .I1(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .I2(\BU2/N140 ),
    .I3(\BU2/N267 ),
    .I4(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1084 ),
    .I5(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .O(\BU2/U0/transmitter/state_machine/next_state<1> [1])
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/error_lane_6_or0000121_SW0  (
    .I0(\BU2/U0/receiver/recoder/error_lane_6_or000039_1027 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [54]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [52]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [53]),
    .O(\BU2/N147 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_40_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [8]),
    .I2(\BU2/U0/usrclk_reset_328 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [5]),
    .I4(\BU2/U0/receiver/recoder/mux0023_or0000 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_40_rstpot1_1142 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_48_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [16]),
    .I2(\BU2/U0/usrclk_reset_328 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [6]),
    .I4(\BU2/U0/receiver/recoder/mux0027_or0000 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_48_rstpot1_1141 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/clear_local_fault_edge_rstpot1  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/last_value_824 ),
    .I2(\BU2/U0/clear_local_fault_823 ),
    .O(\BU2/U0/clear_local_fault_edge_rstpot )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/clear_aligned_edge_rstpot1  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/last_value0_822 ),
    .I2(\BU2/U0/clear_aligned_821 ),
    .O(\BU2/U0/clear_aligned_edge_rstpot )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [4]),
    .I2(\BU2/U0/transmitter/txc_pipe [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot_1130 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [12]),
    .I2(\BU2/U0/transmitter/txc_pipe [1]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot_1126 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [20]),
    .I2(\BU2/U0/transmitter/txc_pipe [2]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot_1122 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [28]),
    .I2(\BU2/U0/transmitter/txc_pipe [3]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot_1118 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [36]),
    .I2(\BU2/U0/transmitter/txc_pipe [4]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot_1114 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [44]),
    .I2(\BU2/U0/transmitter/txc_pipe [5]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot_1110 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [52]),
    .I2(\BU2/U0/transmitter/txc_pipe [6]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot_1106 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/txd_pipe [60]),
    .I2(\BU2/U0/transmitter/txc_pipe [7]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot_1102 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [32]),
    .I1(\BU2/U0/transmitter/txd_pipe [35]),
    .I2(\BU2/U0/transmitter/txd_pipe [34]),
    .I3(\BU2/U0/transmitter/txd_pipe [33]),
    .I4(\BU2/N263 ),
    .I5(\BU2/U0/transmitter/txd_pipe [36]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [37]),
    .I1(\BU2/U0/transmitter/txd_pipe [38]),
    .I2(\BU2/U0/transmitter/txd_pipe [39]),
    .O(\BU2/N263 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [40]),
    .I1(\BU2/U0/transmitter/txd_pipe [43]),
    .I2(\BU2/U0/transmitter/txd_pipe [42]),
    .I3(\BU2/U0/transmitter/txd_pipe [41]),
    .I4(\BU2/N261 ),
    .I5(\BU2/U0/transmitter/txd_pipe [44]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [45]),
    .I1(\BU2/U0/transmitter/txd_pipe [46]),
    .I2(\BU2/U0/transmitter/txd_pipe [47]),
    .O(\BU2/N261 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [48]),
    .I1(\BU2/U0/transmitter/txd_pipe [51]),
    .I2(\BU2/U0/transmitter/txd_pipe [50]),
    .I3(\BU2/U0/transmitter/txd_pipe [49]),
    .I4(\BU2/N259 ),
    .I5(\BU2/U0/transmitter/txd_pipe [52]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [53]),
    .I1(\BU2/U0/transmitter/txd_pipe [54]),
    .I2(\BU2/U0/transmitter/txd_pipe [55]),
    .O(\BU2/N259 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [56]),
    .I1(\BU2/U0/transmitter/txd_pipe [59]),
    .I2(\BU2/U0/transmitter/txd_pipe [58]),
    .I3(\BU2/U0/transmitter/txd_pipe [57]),
    .I4(\BU2/N257 ),
    .I5(\BU2/U0/transmitter/txd_pipe [60]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [61]),
    .I1(\BU2/U0/transmitter/txd_pipe [62]),
    .I2(\BU2/U0/transmitter/txd_pipe [63]),
    .O(\BU2/N257 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [0]),
    .I1(\BU2/U0/transmitter/txd_pipe [3]),
    .I2(\BU2/U0/transmitter/txd_pipe [2]),
    .I3(\BU2/U0/transmitter/txd_pipe [1]),
    .I4(\BU2/N255 ),
    .I5(\BU2/U0/transmitter/txd_pipe [4]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [5]),
    .I1(\BU2/U0/transmitter/txd_pipe [6]),
    .I2(\BU2/U0/transmitter/txd_pipe [7]),
    .O(\BU2/N255 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [16]),
    .I1(\BU2/U0/transmitter/txd_pipe [19]),
    .I2(\BU2/U0/transmitter/txd_pipe [18]),
    .I3(\BU2/U0/transmitter/txd_pipe [17]),
    .I4(\BU2/N253 ),
    .I5(\BU2/U0/transmitter/txd_pipe [20]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [21]),
    .I1(\BU2/U0/transmitter/txd_pipe [22]),
    .I2(\BU2/U0/transmitter/txd_pipe [23]),
    .O(\BU2/N253 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [24]),
    .I1(\BU2/U0/transmitter/txd_pipe [27]),
    .I2(\BU2/U0/transmitter/txd_pipe [26]),
    .I3(\BU2/U0/transmitter/txd_pipe [25]),
    .I4(\BU2/N251 ),
    .I5(\BU2/U0/transmitter/txd_pipe [28]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/retval_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [29]),
    .I1(\BU2/U0/transmitter/txd_pipe [30]),
    .I2(\BU2/U0/transmitter/txd_pipe [31]),
    .O(\BU2/N251 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFEFFFEFE ))
  \BU2/U0/tx_local_fault_rstpot1  (
    .I0(mgt_tx_reset_14[2]),
    .I1(mgt_tx_reset_14[3]),
    .I2(mgt_tx_reset_14[1]),
    .I3(\BU2/U0/clear_local_fault_edge_1098 ),
    .I4(\NlwRenamedSig_OI_status_vector[0] ),
    .I5(mgt_tx_reset_14[0]),
    .O(\BU2/U0/tx_local_fault_rstpot1_1093 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [3]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N249 ),
    .I5(\BU2/U0/transmitter/txd_pipe [27]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot_1119 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [26]),
    .I1(\BU2/N96 ),
    .I2(\BU2/U0/transmitter/txd_pipe [29]),
    .I3(\BU2/U0/transmitter/txd_pipe [28]),
    .O(\BU2/N249 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [3]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N247 ),
    .I5(\BU2/U0/transmitter/txd_pipe [29]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot_1117 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [26]),
    .I1(\BU2/N96 ),
    .I2(\BU2/U0/transmitter/txd_pipe [28]),
    .I3(\BU2/U0/transmitter/txd_pipe [27]),
    .O(\BU2/N247 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [3]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N245 ),
    .I5(\BU2/U0/transmitter/txd_pipe [31]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot_1116 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N96 ),
    .I1(\BU2/U0/transmitter/txd_pipe [26]),
    .I2(\BU2/U0/transmitter/txd_pipe [29]),
    .I3(\BU2/U0/transmitter/txd_pipe [28]),
    .I4(\BU2/U0/transmitter/txd_pipe [27]),
    .O(\BU2/N245 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [24]),
    .I3(\BU2/N239 ),
    .I4(\BU2/N96 ),
    .I5(\BU2/U0/transmitter/txc_pipe [3]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N239 ),
    .I1(\BU2/U0/transmitter/txd_pipe [25]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [3]),
    .I4(\BU2/N96 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N239 ),
    .I1(\BU2/U0/transmitter/txd_pipe [30]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [3]),
    .I4(\BU2/N96 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [27]),
    .I1(\BU2/U0/transmitter/txd_pipe [28]),
    .I2(\BU2/U0/transmitter/txd_pipe [26]),
    .I3(\BU2/U0/transmitter/txd_pipe [29]),
    .O(\BU2/N239 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [2]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N237 ),
    .I5(\BU2/U0/transmitter/txd_pipe [19]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot_1123 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [18]),
    .I1(\BU2/N98 ),
    .I2(\BU2/U0/transmitter/txd_pipe [21]),
    .I3(\BU2/U0/transmitter/txd_pipe [20]),
    .O(\BU2/N237 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [2]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N235 ),
    .I5(\BU2/U0/transmitter/txd_pipe [21]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot_1121 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [18]),
    .I1(\BU2/N98 ),
    .I2(\BU2/U0/transmitter/txd_pipe [20]),
    .I3(\BU2/U0/transmitter/txd_pipe [19]),
    .O(\BU2/N235 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [2]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N233 ),
    .I5(\BU2/U0/transmitter/txd_pipe [23]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot_1120 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N98 ),
    .I1(\BU2/U0/transmitter/txd_pipe [18]),
    .I2(\BU2/U0/transmitter/txd_pipe [21]),
    .I3(\BU2/U0/transmitter/txd_pipe [20]),
    .I4(\BU2/U0/transmitter/txd_pipe [19]),
    .O(\BU2/N233 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [16]),
    .I3(\BU2/N227 ),
    .I4(\BU2/N98 ),
    .I5(\BU2/U0/transmitter/txc_pipe [2]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N227 ),
    .I1(\BU2/U0/transmitter/txd_pipe [17]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [2]),
    .I4(\BU2/N98 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N227 ),
    .I1(\BU2/U0/transmitter/txd_pipe [22]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [2]),
    .I4(\BU2/N98 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [19]),
    .I1(\BU2/U0/transmitter/txd_pipe [20]),
    .I2(\BU2/U0/transmitter/txd_pipe [18]),
    .I3(\BU2/U0/transmitter/txd_pipe [21]),
    .O(\BU2/N227 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [1]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N225 ),
    .I5(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot_1127 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [8]),
    .I1(\BU2/N100 ),
    .I2(\BU2/U0/transmitter/txd_pipe [13]),
    .I3(\BU2/U0/transmitter/txd_pipe [12]),
    .O(\BU2/N225 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [1]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N223 ),
    .I5(\BU2/U0/transmitter/txd_pipe [13]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot_1125 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [8]),
    .I1(\BU2/N100 ),
    .I2(\BU2/U0/transmitter/txd_pipe [12]),
    .I3(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N223 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [1]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N221 ),
    .I5(\BU2/U0/transmitter/txd_pipe [15]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot_1124 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N100 ),
    .I1(\BU2/U0/transmitter/txd_pipe [8]),
    .I2(\BU2/U0/transmitter/txd_pipe [13]),
    .I3(\BU2/U0/transmitter/txd_pipe [12]),
    .I4(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N221 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [8]),
    .I3(\BU2/N219 ),
    .I4(\BU2/N100 ),
    .I5(\BU2/U0/transmitter/txc_pipe [1]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>11 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [13]),
    .I1(\BU2/U0/transmitter/txd_pipe [12]),
    .I2(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N219 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N215 ),
    .I1(\BU2/U0/transmitter/txd_pipe [9]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [1]),
    .I4(\BU2/N100 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N215 ),
    .I1(\BU2/U0/transmitter/txd_pipe [14]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [1]),
    .I4(\BU2/N100 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [12]),
    .I1(\BU2/U0/transmitter/txd_pipe [13]),
    .I2(\BU2/U0/transmitter/txd_pipe [8]),
    .I3(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N215 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [0]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N213 ),
    .I5(\BU2/U0/transmitter/txd_pipe [3]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot_1131 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [2]),
    .I1(\BU2/N102 ),
    .I2(\BU2/U0/transmitter/txd_pipe [5]),
    .I3(\BU2/U0/transmitter/txd_pipe [4]),
    .O(\BU2/N213 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [0]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N211 ),
    .I5(\BU2/U0/transmitter/txd_pipe [5]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot_1129 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [2]),
    .I1(\BU2/N102 ),
    .I2(\BU2/U0/transmitter/txd_pipe [4]),
    .I3(\BU2/U0/transmitter/txd_pipe [3]),
    .O(\BU2/N211 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [0]),
    .I3(\BU2/U0/transmitter/is_terminate [0]),
    .I4(\BU2/N209 ),
    .I5(\BU2/U0/transmitter/txd_pipe [7]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot_1128 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N102 ),
    .I1(\BU2/U0/transmitter/txd_pipe [2]),
    .I2(\BU2/U0/transmitter/txd_pipe [5]),
    .I3(\BU2/U0/transmitter/txd_pipe [4]),
    .I4(\BU2/U0/transmitter/txd_pipe [3]),
    .O(\BU2/N209 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [0]),
    .I3(\BU2/N203 ),
    .I4(\BU2/N102 ),
    .I5(\BU2/U0/transmitter/txc_pipe [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N203 ),
    .I1(\BU2/U0/transmitter/txd_pipe [1]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [0]),
    .I4(\BU2/N102 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N203 ),
    .I1(\BU2/U0/transmitter/txd_pipe [6]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [0]),
    .I4(\BU2/N102 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [3]),
    .I1(\BU2/U0/transmitter/txd_pipe [4]),
    .I2(\BU2/U0/transmitter/txd_pipe [2]),
    .I3(\BU2/U0/transmitter/txd_pipe [5]),
    .O(\BU2/N203 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [7]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N201 ),
    .I5(\BU2/U0/transmitter/txd_pipe [59]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot_1103 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [58]),
    .I1(\BU2/N104 ),
    .I2(\BU2/U0/transmitter/txd_pipe [61]),
    .I3(\BU2/U0/transmitter/txd_pipe [60]),
    .O(\BU2/N201 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [7]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N199 ),
    .I5(\BU2/U0/transmitter/txd_pipe [61]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot_1101 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [58]),
    .I1(\BU2/N104 ),
    .I2(\BU2/U0/transmitter/txd_pipe [60]),
    .I3(\BU2/U0/transmitter/txd_pipe [59]),
    .O(\BU2/N199 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [7]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N197 ),
    .I5(\BU2/U0/transmitter/txd_pipe [63]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot_1100 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N104 ),
    .I1(\BU2/U0/transmitter/txd_pipe [58]),
    .I2(\BU2/U0/transmitter/txd_pipe [61]),
    .I3(\BU2/U0/transmitter/txd_pipe [60]),
    .I4(\BU2/U0/transmitter/txd_pipe [59]),
    .O(\BU2/N197 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [56]),
    .I3(\BU2/N191 ),
    .I4(\BU2/N104 ),
    .I5(\BU2/U0/transmitter/txc_pipe [7]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N191 ),
    .I1(\BU2/U0/transmitter/txd_pipe [57]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [7]),
    .I4(\BU2/N104 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N191 ),
    .I1(\BU2/U0/transmitter/txd_pipe [62]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [7]),
    .I4(\BU2/N104 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [59]),
    .I1(\BU2/U0/transmitter/txd_pipe [60]),
    .I2(\BU2/U0/transmitter/txd_pipe [58]),
    .I3(\BU2/U0/transmitter/txd_pipe [61]),
    .O(\BU2/N191 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [6]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N189 ),
    .I5(\BU2/U0/transmitter/txd_pipe [51]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot_1107 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [50]),
    .I1(\BU2/N106 ),
    .I2(\BU2/U0/transmitter/txd_pipe [53]),
    .I3(\BU2/U0/transmitter/txd_pipe [52]),
    .O(\BU2/N189 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [6]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N187 ),
    .I5(\BU2/U0/transmitter/txd_pipe [53]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot_1105 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [50]),
    .I1(\BU2/N106 ),
    .I2(\BU2/U0/transmitter/txd_pipe [52]),
    .I3(\BU2/U0/transmitter/txd_pipe [51]),
    .O(\BU2/N187 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [6]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N185 ),
    .I5(\BU2/U0/transmitter/txd_pipe [55]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot_1104 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N106 ),
    .I1(\BU2/U0/transmitter/txd_pipe [50]),
    .I2(\BU2/U0/transmitter/txd_pipe [53]),
    .I3(\BU2/U0/transmitter/txd_pipe [52]),
    .I4(\BU2/U0/transmitter/txd_pipe [51]),
    .O(\BU2/N185 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [48]),
    .I3(\BU2/N179 ),
    .I4(\BU2/N106 ),
    .I5(\BU2/U0/transmitter/txc_pipe [6]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N179 ),
    .I1(\BU2/U0/transmitter/txd_pipe [49]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [6]),
    .I4(\BU2/N106 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N179 ),
    .I1(\BU2/U0/transmitter/txd_pipe [54]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [6]),
    .I4(\BU2/N106 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [51]),
    .I1(\BU2/U0/transmitter/txd_pipe [52]),
    .I2(\BU2/U0/transmitter/txd_pipe [50]),
    .I3(\BU2/U0/transmitter/txd_pipe [53]),
    .O(\BU2/N179 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [5]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N177 ),
    .I5(\BU2/U0/transmitter/txd_pipe [43]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot_1111 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [42]),
    .I1(\BU2/N108 ),
    .I2(\BU2/U0/transmitter/txd_pipe [45]),
    .I3(\BU2/U0/transmitter/txd_pipe [44]),
    .O(\BU2/N177 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [5]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N175 ),
    .I5(\BU2/U0/transmitter/txd_pipe [45]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot_1109 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [42]),
    .I1(\BU2/N108 ),
    .I2(\BU2/U0/transmitter/txd_pipe [44]),
    .I3(\BU2/U0/transmitter/txd_pipe [43]),
    .O(\BU2/N175 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [5]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N173 ),
    .I5(\BU2/U0/transmitter/txd_pipe [47]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot_1108 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N108 ),
    .I1(\BU2/U0/transmitter/txd_pipe [42]),
    .I2(\BU2/U0/transmitter/txd_pipe [45]),
    .I3(\BU2/U0/transmitter/txd_pipe [44]),
    .I4(\BU2/U0/transmitter/txd_pipe [43]),
    .O(\BU2/N173 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [40]),
    .I3(\BU2/N167 ),
    .I4(\BU2/N108 ),
    .I5(\BU2/U0/transmitter/txc_pipe [5]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N167 ),
    .I1(\BU2/U0/transmitter/txd_pipe [41]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [5]),
    .I4(\BU2/N108 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N167 ),
    .I1(\BU2/U0/transmitter/txd_pipe [46]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [5]),
    .I4(\BU2/N108 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [43]),
    .I1(\BU2/U0/transmitter/txd_pipe [44]),
    .I2(\BU2/U0/transmitter/txd_pipe [42]),
    .I3(\BU2/U0/transmitter/txd_pipe [45]),
    .O(\BU2/N167 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [4]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N165 ),
    .I5(\BU2/U0/transmitter/txd_pipe [35]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot_1115 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [34]),
    .I1(\BU2/N110 ),
    .I2(\BU2/U0/transmitter/txd_pipe [37]),
    .I3(\BU2/U0/transmitter/txd_pipe [36]),
    .O(\BU2/N165 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [4]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N163 ),
    .I5(\BU2/U0/transmitter/txd_pipe [37]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot_1113 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [34]),
    .I1(\BU2/N110 ),
    .I2(\BU2/U0/transmitter/txd_pipe [36]),
    .I3(\BU2/U0/transmitter/txd_pipe [35]),
    .O(\BU2/N163 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFAEAEAEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I2(\BU2/U0/transmitter/txc_pipe [4]),
    .I3(\BU2/U0/transmitter/is_terminate [1]),
    .I4(\BU2/N161 ),
    .I5(\BU2/U0/transmitter/txd_pipe [39]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot_1112 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW4  (
    .I0(\BU2/N110 ),
    .I1(\BU2/U0/transmitter/txd_pipe [34]),
    .I2(\BU2/U0/transmitter/txd_pipe [37]),
    .I3(\BU2/U0/transmitter/txd_pipe [36]),
    .I4(\BU2/U0/transmitter/txd_pipe [35]),
    .O(\BU2/N161 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [32]),
    .I3(\BU2/N155 ),
    .I4(\BU2/N110 ),
    .I5(\BU2/U0/transmitter/txc_pipe [4]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N155 ),
    .I1(\BU2/U0/transmitter/txd_pipe [33]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [4]),
    .I4(\BU2/N110 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N155 ),
    .I1(\BU2/U0/transmitter/txd_pipe [38]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [4]),
    .I4(\BU2/N110 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>11 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW1  (
    .I0(\BU2/U0/transmitter/txd_pipe [35]),
    .I1(\BU2/U0/transmitter/txd_pipe [36]),
    .I2(\BU2/U0/transmitter/txd_pipe [34]),
    .I3(\BU2/U0/transmitter/txd_pipe [37]),
    .O(\BU2/N155 )
  );
  LUT6 #(
    .INIT ( 64'h0404040404043704 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<1>  (
    .I0(\BU2/N125 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I3(\BU2/U0/transmitter/align/N5 ),
    .I4(\BU2/N153 ),
    .I5(\BU2/U0/transmitter/align/count [2]),
    .O(\BU2/U0/transmitter/state_machine/next_state<0> [1])
  );
  LUT4 #(
    .INIT ( 16'h02FF ))
  \BU2/U0/transmitter/align/a_cnt_1_mux00011_SW0  (
    .I0(\BU2/U0/transmitter/align/extra_a_1022 ),
    .I1(\BU2/U0/transmitter/align/count [0]),
    .I2(\BU2/U0/transmitter/align/count [1]),
    .I3(\BU2/U0/transmitter/align/count [2]),
    .O(\BU2/N151 )
  );
  LUT6 #(
    .INIT ( 64'h000A000F00020003 ))
  \BU2/U0/transmitter/align/a_cnt_0_mux000121  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I2(\BU2/U0/transmitter/align/count [4]),
    .I3(\BU2/U0/transmitter/align/count [3]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/align/N5 )
  );
  LUT4 #(
    .INIT ( 16'h0302 ))
  \BU2/U0/receiver/recoder/error_lane_5_or000070  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [3]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .I3(\BU2/U0/receiver/recoder/lane_terminate [2]),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or000070_1015 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_5_or0000145  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [41]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [46]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [47]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [45]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [42]),
    .I5(\BU2/N149 ),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or0000145_1016 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_5_or0000145_SW0  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [5]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [40]),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [44]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [43]),
    .O(\BU2/N149 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/receiver/recoder/rxd_out_1_rstpot  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/error_lane [0]),
    .I2(\BU2/U0/receiver/recoder/mux0003_or0000_975 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_1_rstpot_1085 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF2802 ))
  \BU2/U0/receiver/recoder/rxd_out_50_or00001  (
    .I0(\BU2/U0/receiver/recoder/N16 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I4(\BU2/U0/receiver/recoder/error_lane [6]),
    .O(\BU2/U0/receiver/recoder/rxd_out_50_or0000 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/is_terminate_0_mux0000103  (
    .I0(\BU2/U0/transmitter/is_terminate_0_mux000097_993 ),
    .I1(\BU2/U0/transmitter/txd_pipe [14]),
    .I2(\BU2/U0/transmitter/txd_pipe [15]),
    .I3(\BU2/U0/transmitter/txd_pipe [9]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux0000103_1147 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/is_terminate_1_mux0000103  (
    .I0(\BU2/U0/transmitter/is_terminate_1_mux000097_988 ),
    .I1(\BU2/U0/transmitter/txd_pipe [46]),
    .I2(\BU2/U0/transmitter/txd_pipe [47]),
    .I3(\BU2/U0/transmitter/txd_pipe [41]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux0000103_1146 )
  );
  LUT6 #(
    .INIT ( 64'hEEFFEAFAEEFEEAFA ))
  \BU2/U0/receiver/recoder/error_lane_6_or0000121  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [2]),
    .I1(\BU2/U0/receiver/recoder/error_lane_6_or000024 ),
    .I2(\BU2/U0/receiver/recoder/error_lane_6_or00000_1025 ),
    .I3(\BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_1018 ),
    .I4(\BU2/U0/receiver/recoder/error_lane_6_or0000101_1144 ),
    .I5(\BU2/N147 ),
    .O(\BU2/U0/receiver/recoder/error_lane [6])
  );
  LUT4 #(
    .INIT ( 16'hAF88 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW5  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .I1(\BU2/U0/transmitter/tx_is_idle [1]),
    .I2(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I3(\BU2/U0/transmitter/tx_is_q [1]),
    .O(\BU2/N140 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_40  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_40_rstpot1_1142 ),
    .Q(xgmii_rxd_4[40])
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_48  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_48_rstpot1_1141 ),
    .Q(xgmii_rxd_4[48])
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_16  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_16_rstpot1_1140 ),
    .Q(xgmii_rxd_4[16])
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_8  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_8_rstpot1_1139 ),
    .Q(xgmii_rxd_4[8])
  );
  FD   \BU2/U0/transmitter/align/extra_a  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/align/extra_a_rstpot1_1138 ),
    .Q(\BU2/U0/transmitter/align/extra_a_1022 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot_1137 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [2])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [34]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot_1137 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot_1136 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [3])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [35]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot_1136 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot_1135 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [4])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [36]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot_1135 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot_1134 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [7])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [39]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot_1134 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_24  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot_1133 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [24])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [56]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot_1133 )
  );
  FD   \BU2/U0/receiver/recoder/rxc_half_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot_1132 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/rxc_pipe [4]),
    .O(\BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot_1132 )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot_1131 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot_1130 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot_1129 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot_1128 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot_1127 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot_1126 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot_1125 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot_1124 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot_1123 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot_1122 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot_1121 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot_1120 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot_1119 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot_1118 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot_1117 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot_1116 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot_1115 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot_1114 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot_1113 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot_1112 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot_1111 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot_1110 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot_1109 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot_1108 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot_1107 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot_1106 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot_1105 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot_1104 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot_1103 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot_1102 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot_1101 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot_1100 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> )
  );
  FD   \BU2/U0/clear_aligned_edge  (
    .C(usrclk),
    .D(\BU2/U0/clear_aligned_edge_rstpot ),
    .Q(\BU2/U0/clear_aligned_edge_1089 )
  );
  FD #(
    .INIT ( 1'b1 ))
  \BU2/U0/usrclk_reset_pipe  (
    .C(usrclk),
    .D(reset),
    .Q(\BU2/U0/usrclk_reset_pipe_1095 )
  );
  FD   \BU2/U0/clear_local_fault_edge  (
    .C(usrclk),
    .D(\BU2/U0/clear_local_fault_edge_rstpot ),
    .Q(\BU2/U0/clear_local_fault_edge_1098 )
  );
  FD #(
    .INIT ( 1'b1 ))
  \BU2/U0/usrclk_reset  (
    .C(usrclk),
    .D(\BU2/U0/usrclk_reset_rstpot_1096 ),
    .Q(\BU2/U0/usrclk_reset_328 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/usrclk_reset_rstpot  (
    .I0(\BU2/U0/usrclk_reset_pipe_1095 ),
    .I1(reset),
    .O(\BU2/U0/usrclk_reset_rstpot_1096 )
  );
  FD   \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/enchansync  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/enchansync_rstpot_1094 ),
    .Q(mgt_enchansync)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/enchansync_rstpot  (
    .I0(\BU2/U0/receiver/sync_status_626 ),
    .I1(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/state_1_627 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/enchansync_rstpot_1094 )
  );
  FDR   \BU2/U0/tx_local_fault  (
    .C(usrclk),
    .D(\BU2/U0/tx_local_fault_rstpot1_1093 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\NlwRenamedSig_OI_status_vector[0] )
  );
  FDR   \BU2/U0/rx_local_fault  (
    .C(usrclk),
    .D(\BU2/U0/rx_local_fault_rstpot1 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\NlwRenamedSig_OI_status_vector[1] )
  );
  FDR   \BU2/U0/transmitter/tqmsg_capture_1/q_det  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1_1091 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 )
  );
  FDR   \BU2/U0/aligned_sticky  (
    .C(usrclk),
    .D(\BU2/U0/aligned_sticky_rstpot_1090 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .Q(\NlwRenamedSig_OI_status_vector[7] )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/aligned_sticky_rstpot  (
    .I0(\BU2/U0/clear_aligned_edge_1089 ),
    .I1(\NlwRenamedSig_OI_status_vector[7] ),
    .I2(NlwRenamedSig_OI_mgt_enable_align[0]),
    .O(\BU2/U0/aligned_sticky_rstpot_1090 )
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_32  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_32_rstpot_1088 ),
    .R(\BU2/U0/receiver/recoder/rxd_out_32_or0000 ),
    .Q(xgmii_rxd_4[32])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_33  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_33_rstpot_1087 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .Q(xgmii_rxd_4[33])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_0_rstpot_1086 ),
    .R(\BU2/U0/receiver/recoder/rxd_out_0_or0000 ),
    .Q(xgmii_rxd_4[0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_0_rstpot  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [0]),
    .I1(\BU2/U0/receiver/recoder/mux0003_or0000_975 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_0_rstpot_1086 )
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_1_rstpot_1085 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .Q(xgmii_rxd_4[1])
  );
  FDS   \BU2/U0/transmitter/state_machine/next_ifg_is_a  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1084 )
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_14  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_14_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[22])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_16  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_16_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[32])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_22  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_22_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[38])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_24  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_24_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[48])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_30  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_30_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[54])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_32  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_32_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[8])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_40  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_40_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[24])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_38  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_38_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[14])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_46  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_46_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[30])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_0_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[0])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_48  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_48_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[40])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_54  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_54_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[46])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_56  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_56_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[56])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_62  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_62_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[62])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_6_mux000681 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[6])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_8  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_8_mux00061 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[16])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [32]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [33]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [37]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [5])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [38]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [6])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_8  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [40]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [8])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_9  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [41]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [9])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_10  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [42]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [10])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_11  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [43]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [11])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_12  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [44]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [12])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_13  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [45]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [13])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_14  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [46]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [14])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_15  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [47]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [15])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_16  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [48]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [16])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_17  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [49]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [17])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_18  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [50]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [18])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_19  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [51]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [19])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_20  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [52]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [20])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_21  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [53]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [21])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_22  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [54]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [22])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_23  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [55]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [23])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_25  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [57]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [25])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_26  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [58]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [26])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_27  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [59]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [27])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_28  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [60]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [28])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_29  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [61]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [29])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_30  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [62]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [30])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_31  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [63]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [31])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_half_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_half_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [2])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_half_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [7]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [3])
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [2]),
    .I1(\BU2/U0/transmitter/txc_pipe [0]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [10]),
    .I1(\BU2/U0/transmitter/txc_pipe [1]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [18]),
    .I1(\BU2/U0/transmitter/txc_pipe [2]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [26]),
    .I1(\BU2/U0/transmitter/txc_pipe [3]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [34]),
    .I1(\BU2/U0/transmitter/txc_pipe [4]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [42]),
    .I1(\BU2/U0/transmitter/txc_pipe [5]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [50]),
    .I1(\BU2/U0/transmitter/txc_pipe [6]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<5>111  (
    .I0(\BU2/U0/transmitter/txd_pipe [58]),
    .I1(\BU2/U0/transmitter/txc_pipe [7]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<5>11 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<5>11 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> )
  );
  LUT5 #(
    .INIT ( 32'hFFFFEFFF ))
  \BU2/U0/receiver/recoder/error_lane_6_or000039  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [55]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [48]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [51]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [50]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [49]),
    .O(\BU2/U0/receiver/recoder/error_lane_6_or000039_1027 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \BU2/U0/receiver/recoder/error_lane_6_or00003  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [6]),
    .I1(\BU2/U0/receiver/recoder/code_error_pipe [6]),
    .O(\BU2/U0/receiver/recoder/error_lane_6_or000024 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/error_lane_6_or00000  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [5]),
    .O(\BU2/U0/receiver/recoder/error_lane_6_or00000_1025 )
  );
  LUT5 #(
    .INIT ( 32'h40505050 ))
  \BU2/U0/transmitter/align/a_cnt_0_mux00011  (
    .I0(\BU2/U0/transmitter/align/count [2]),
    .I1(\BU2/U0/transmitter/align/extra_a_1022 ),
    .I2(\BU2/U0/transmitter/align/N5 ),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/align/count [0]),
    .O(\BU2/U0/transmitter/a_due [0])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>31  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .O(\BU2/U0/transmitter/tx_code_a [1])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/transmitter/state_machine/tx_code_a_0_or00001  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_580 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_0_582 ),
    .O(\BU2/U0/transmitter/tx_code_a [0])
  );
  LUT4 #(
    .INIT ( 16'h11F5 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<1>_SW0  (
    .I0(\BU2/U0/transmitter/tx_is_q [0]),
    .I1(\BU2/U0/transmitter/tx_is_idle [0]),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .O(\BU2/N125 )
  );
  LUT6 #(
    .INIT ( 64'h0100000000000000 ))
  \BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [49]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [48]),
    .I2(\BU2/N119 ),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [55]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [53]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [50]),
    .O(\BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_1018 )
  );
  LUT3 #(
    .INIT ( 8'hF7 ))
  \BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [52]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [51]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [54]),
    .O(\BU2/N119 )
  );
  LUT6 #(
    .INIT ( 64'hFCCFA88AFCCFA8AA ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<2>1  (
    .I0(\BU2/U0/transmitter/tx_is_idle [1]),
    .I1(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I2(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .I3(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .I4(\BU2/U0/transmitter/tx_is_q [1]),
    .I5(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .O(\BU2/U0/transmitter/state_machine/next_state<1> [2])
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFA8A8A8 ))
  \BU2/U0/receiver/recoder/error_lane_5_or0000172  (
    .I0(\BU2/U0/receiver/recoder/error_lane_5_or000070_1015 ),
    .I1(\BU2/U0/receiver/recoder/error_lane_5_or000023_1013 ),
    .I2(\BU2/U0/receiver/recoder/error_lane_5_or000048_1014 ),
    .I3(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .I4(\BU2/U0/receiver/recoder/error_lane_5_or0000145_1016 ),
    .I5(\BU2/U0/receiver/recoder/code_error_pipe [1]),
    .O(\BU2/U0/receiver/recoder/error_lane [5])
  );
  LUT4 #(
    .INIT ( 16'hD7FF ))
  \BU2/U0/receiver/recoder/error_lane_5_or000048  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [5]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [47]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [46]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [45]),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or000048_1014 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_5_or000023  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [40]),
    .I1(\BU2/U0/receiver/recoder/code_error_pipe [5]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [44]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [43]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [42]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [41]),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or000023_1013 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFF8F8A8A ))
  \BU2/U0/receiver/recoder/error_lane_1_or0000128  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I1(\BU2/U0/receiver/recoder/error_lane_1_or000018_1010 ),
    .I2(\BU2/U0/receiver/recoder/N18 ),
    .I3(\BU2/U0/receiver/recoder/error_lane_1_or000080_1011 ),
    .I4(\BU2/U0/receiver/recoder/error_lane_1_or0000103_1012 ),
    .I5(\BU2/U0/receiver/recoder/code_error_delay [1]),
    .O(\BU2/U0/receiver/recoder/error_lane [1])
  );
  LUT4 #(
    .INIT ( 16'h0302 ))
  \BU2/U0/receiver/recoder/error_lane_1_or0000103  (
    .I0(\BU2/U0/receiver/recoder/lane_term_pipe [2]),
    .I1(\BU2/U0/receiver/recoder/lane_term_pipe [1]),
    .I2(\BU2/U0/receiver/recoder/lane_term_pipe [0]),
    .I3(\BU2/U0/receiver/recoder/lane_term_pipe [3]),
    .O(\BU2/U0/receiver/recoder/error_lane_1_or0000103_1012 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF9FFF ))
  \BU2/U0/receiver/recoder/error_lane_1_or000080  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .I4(\BU2/U0/receiver/recoder/code_error_pipe [1]),
    .O(\BU2/U0/receiver/recoder/error_lane_1_or000080_1011 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_1_or000018  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .O(\BU2/U0/receiver/recoder/error_lane_1_or000018_1010 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_10_or00011  (
    .I0(\BU2/U0/receiver/recoder/error_lane [1]),
    .I1(\BU2/U0/receiver/recoder/mux0007_or0000_966 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_10_or0001 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFA8AA ))
  \BU2/U0/receiver/recoder/error_lane_4_or000095  (
    .I0(\BU2/U0/receiver/recoder/error_lane_4_or000073_1009 ),
    .I1(\BU2/U0/receiver/recoder/error_lane_4_or000048_1008 ),
    .I2(\BU2/U0/receiver/recoder/error_lane_4_or000014_1007 ),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [34]),
    .I4(\BU2/U0/receiver/recoder/code_error_pipe [0]),
    .O(\BU2/U0/receiver/recoder/error_lane [4])
  );
  LUT4 #(
    .INIT ( 16'h3332 ))
  \BU2/U0/receiver/recoder/error_lane_4_or000073  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [2]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [3]),
    .I3(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .O(\BU2/U0/receiver/recoder/error_lane_4_or000073_1009 )
  );
  LUT4 #(
    .INIT ( 16'hD7FF ))
  \BU2/U0/receiver/recoder/error_lane_4_or000048  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [4]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [39]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [38]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [37]),
    .O(\BU2/U0/receiver/recoder/error_lane_4_or000048_1008 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFEFFF ))
  \BU2/U0/receiver/recoder/error_lane_4_or000014  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [33]),
    .I1(\BU2/U0/receiver/recoder/code_error_pipe [4]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [36]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [35]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [32]),
    .O(\BU2/U0/receiver/recoder/error_lane_4_or000014_1007 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFEFF ))
  \BU2/U0/receiver/recoder/error_lane_7_or000013  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [62]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [56]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [57]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [60]),
    .I4(\BU2/U0/receiver/recoder/code_error_pipe [7]),
    .O(\BU2/U0/receiver/recoder/error_lane_7_or000013_1006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFF8F8A8A ))
  \BU2/U0/receiver/recoder/error_lane_2_or0000105  (
    .I0(\BU2/U0/receiver/recoder/N35 ),
    .I1(\BU2/U0/receiver/recoder/error_lane_2_or000010_1003 ),
    .I2(\BU2/U0/receiver/recoder/N16 ),
    .I3(\BU2/U0/receiver/recoder/error_lane_2_or000056_1004 ),
    .I4(\BU2/U0/receiver/recoder/error_lane_2_or000081_1005 ),
    .I5(\BU2/U0/receiver/recoder/code_error_delay [2]),
    .O(\BU2/U0/receiver/recoder/error_lane [2])
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/receiver/recoder/error_lane_2_or000081  (
    .I0(\BU2/U0/receiver/recoder/lane_term_pipe [3]),
    .I1(\BU2/U0/receiver/recoder/lane_term_pipe [2]),
    .I2(\BU2/U0/receiver/recoder/lane_term_pipe [1]),
    .I3(\BU2/U0/receiver/recoder/lane_term_pipe [0]),
    .O(\BU2/U0/receiver/recoder/error_lane_2_or000081_1005 )
  );
  LUT4 #(
    .INIT ( 16'hFF9F ))
  \BU2/U0/receiver/recoder/error_lane_2_or000056  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/code_error_pipe [2]),
    .O(\BU2/U0/receiver/recoder/error_lane_2_or000056_1004 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/error_lane_2_or000010  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/code_error_pipe [2]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .O(\BU2/U0/receiver/recoder/error_lane_2_or000010_1003 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFCFFAAFFA8 ))
  \BU2/U0/receiver/recoder/error_lane_3_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I3(\BU2/U0/receiver/recoder/code_error_delay [3]),
    .I4(\BU2/U0/receiver/recoder/lane_terminate [2]),
    .I5(\BU2/N117 ),
    .O(\BU2/U0/receiver/recoder/error_lane [3])
  );
  LUT5 #(
    .INIT ( 32'hFFFF7FFF ))
  \BU2/U0/receiver/recoder/error_lane_3_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/N38 ),
    .I4(\BU2/U0/receiver/recoder/code_error_pipe [3]),
    .O(\BU2/N117 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF00808008 ))
  \BU2/U0/receiver/recoder/rxd_out_57_or00001  (
    .I0(\BU2/U0/receiver/recoder/N38 ),
    .I1(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I5(\BU2/U0/receiver/recoder/error_lane [7]),
    .O(\BU2/U0/receiver/recoder/rxd_out_57_or0000 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/receiver/recoder/rxd_out_34_or00001  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/mux0019_or0000 ),
    .I2(NlwRenamedSig_OI_align_status),
    .I3(\BU2/U0/receiver/recoder/error_lane [4]),
    .O(\BU2/U0/receiver/recoder/rxd_out_34_or0000 )
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  \BU2/U0/receiver/recoder/rxd_out_32_or00001  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(NlwRenamedSig_OI_align_status),
    .I2(\BU2/U0/receiver/recoder/error_lane [4]),
    .O(\BU2/U0/receiver/recoder/rxd_out_32_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_17_or00001  (
    .I0(\BU2/U0/receiver/recoder/error_lane [2]),
    .I1(\BU2/U0/receiver/recoder/mux0011_or0000_958 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_17_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_25_or00001  (
    .I0(\BU2/U0/receiver/recoder/error_lane [3]),
    .I1(\BU2/U0/receiver/recoder/mux0015_or0000_950 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_25_or0000 )
  );
  LUT6 #(
    .INIT ( 64'hABBAAAAAA88AAAAA ))
  \BU2/U0/receiver/recoder/error_lane_0_or0000  (
    .I0(\BU2/N114 ),
    .I1(\BU2/U0/receiver/recoder/code_error_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I5(\BU2/N115 ),
    .O(\BU2/U0/receiver/recoder/error_lane [0])
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF03030302 ))
  \BU2/U0/receiver/recoder/error_lane_0_or0000_SW1  (
    .I0(\BU2/U0/receiver/recoder/lane_term_pipe [3]),
    .I1(\BU2/U0/receiver/recoder/lane_term_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/N17 ),
    .I3(\BU2/U0/receiver/recoder/lane_term_pipe [2]),
    .I4(\BU2/U0/receiver/recoder/lane_term_pipe [1]),
    .I5(\BU2/U0/receiver/recoder/code_error_delay [0]),
    .O(\BU2/N115 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBBBBA ))
  \BU2/U0/receiver/recoder/error_lane_0_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/code_error_delay [0]),
    .I1(\BU2/U0/receiver/recoder/lane_term_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/lane_term_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/lane_term_pipe [2]),
    .I4(\BU2/U0/receiver/recoder/lane_term_pipe [1]),
    .O(\BU2/N114 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/recoder/mux0027_or000011  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [17]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [20]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [19]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [18]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [2]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [16]),
    .O(\BU2/U0/receiver/recoder/N16 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \BU2/U0/receiver/recoder/mux0023_or000011  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [12]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [11]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [10]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [9]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [8]),
    .O(\BU2/U0/receiver/recoder/N18 )
  );
  LUT4 #(
    .INIT ( 16'hFFEF ))
  \BU2/U0/receiver/recoder/rxd_out_2_or00001  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(\BU2/U0/receiver/recoder/mux0003_or0000_975 ),
    .I2(NlwRenamedSig_OI_align_status),
    .I3(\BU2/U0/receiver/recoder/error_lane [0]),
    .O(\BU2/U0/receiver/recoder/rxd_out_2_or0000 )
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  \BU2/U0/receiver/recoder/rxd_out_0_or00001  (
    .I0(\BU2/U0/usrclk_reset_328 ),
    .I1(NlwRenamedSig_OI_align_status),
    .I2(\BU2/U0/receiver/recoder/error_lane [0]),
    .O(\BU2/U0/receiver/recoder/rxd_out_0_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/error_lane_2_or000021  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .O(\BU2/U0/receiver/recoder/N35 )
  );
  LUT6 #(
    .INIT ( 64'h5555555514010000 ))
  \BU2/U0/receiver/recoder/rxd_out_56_mux0002  (
    .I0(\BU2/U0/receiver/recoder/error_lane [7]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I4(\BU2/N112 ),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [24]),
    .O(\BU2/U0/receiver/recoder/rxd_out_56_mux0002_757 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF0020 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000173  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_996 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_588 ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_997 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_587 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139  (
    .I0(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_589 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_997 )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017  (
    .I0(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_590 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_996 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000057  (
    .I0(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_584 ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and00003_994 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000039_995 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_583 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000039  (
    .I0(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_585 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000039_995 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and00003  (
    .I0(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_586 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and00003_994 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/recoder/mux0019_or000011  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [4]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [2]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [0]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [0]),
    .O(\BU2/U0/receiver/recoder/N17 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \BU2/U0/receiver/recoder/mux0029_cmp_eq000011  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [28]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [27]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [26]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [25]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [24]),
    .O(\BU2/U0/receiver/recoder/N38 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_0_mux000097  (
    .I0(\BU2/U0/transmitter/txc_pipe [1]),
    .I1(\BU2/U0/transmitter/txd_pipe [8]),
    .I2(\BU2/U0/transmitter/txd_pipe [10]),
    .I3(\BU2/U0/transmitter/txd_pipe [11]),
    .I4(\BU2/U0/transmitter/txd_pipe [12]),
    .I5(\BU2/U0/transmitter/txd_pipe [13]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux000097_993 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_0_mux000072  (
    .I0(\BU2/U0/transmitter/txc_pipe [0]),
    .I1(\BU2/U0/transmitter/txd_pipe [0]),
    .I2(\BU2/U0/transmitter/txd_pipe [2]),
    .I3(\BU2/U0/transmitter/txd_pipe [3]),
    .I4(\BU2/U0/transmitter/txd_pipe [4]),
    .I5(\BU2/U0/transmitter/txd_pipe [5]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux000072_992 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \BU2/U0/transmitter/is_terminate_0_mux000040  (
    .I0(\BU2/U0/transmitter/txd_pipe [30]),
    .I1(\BU2/U0/transmitter/txd_pipe [31]),
    .I2(\BU2/U0/transmitter/txd_pipe [25]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux000040_991 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_0_mux000035  (
    .I0(\BU2/U0/transmitter/txc_pipe [3]),
    .I1(\BU2/U0/transmitter/txd_pipe [24]),
    .I2(\BU2/U0/transmitter/txd_pipe [26]),
    .I3(\BU2/U0/transmitter/txd_pipe [27]),
    .I4(\BU2/U0/transmitter/txd_pipe [28]),
    .I5(\BU2/U0/transmitter/txd_pipe [29]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux000035_990 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_0_mux000010  (
    .I0(\BU2/U0/transmitter/txc_pipe [2]),
    .I1(\BU2/U0/transmitter/txd_pipe [16]),
    .I2(\BU2/U0/transmitter/txd_pipe [18]),
    .I3(\BU2/U0/transmitter/txd_pipe [19]),
    .I4(\BU2/U0/transmitter/txd_pipe [20]),
    .I5(\BU2/U0/transmitter/txd_pipe [21]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux000010_989 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_1_mux000097  (
    .I0(\BU2/U0/transmitter/txc_pipe [5]),
    .I1(\BU2/U0/transmitter/txd_pipe [40]),
    .I2(\BU2/U0/transmitter/txd_pipe [42]),
    .I3(\BU2/U0/transmitter/txd_pipe [43]),
    .I4(\BU2/U0/transmitter/txd_pipe [44]),
    .I5(\BU2/U0/transmitter/txd_pipe [45]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux000097_988 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_1_mux000072  (
    .I0(\BU2/U0/transmitter/txc_pipe [4]),
    .I1(\BU2/U0/transmitter/txd_pipe [32]),
    .I2(\BU2/U0/transmitter/txd_pipe [34]),
    .I3(\BU2/U0/transmitter/txd_pipe [35]),
    .I4(\BU2/U0/transmitter/txd_pipe [36]),
    .I5(\BU2/U0/transmitter/txd_pipe [37]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux000072_987 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \BU2/U0/transmitter/is_terminate_1_mux000040  (
    .I0(\BU2/U0/transmitter/txd_pipe [62]),
    .I1(\BU2/U0/transmitter/txd_pipe [63]),
    .I2(\BU2/U0/transmitter/txd_pipe [57]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux000040_986 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_1_mux000035  (
    .I0(\BU2/U0/transmitter/txc_pipe [7]),
    .I1(\BU2/U0/transmitter/txd_pipe [56]),
    .I2(\BU2/U0/transmitter/txd_pipe [58]),
    .I3(\BU2/U0/transmitter/txd_pipe [59]),
    .I4(\BU2/U0/transmitter/txd_pipe [60]),
    .I5(\BU2/U0/transmitter/txd_pipe [61]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux000035_985 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \BU2/U0/transmitter/is_terminate_1_mux000010  (
    .I0(\BU2/U0/transmitter/txc_pipe [6]),
    .I1(\BU2/U0/transmitter/txd_pipe [48]),
    .I2(\BU2/U0/transmitter/txd_pipe [50]),
    .I3(\BU2/U0/transmitter/txd_pipe [51]),
    .I4(\BU2/U0/transmitter/txd_pipe [52]),
    .I5(\BU2/U0/transmitter/txd_pipe [53]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux000010_984 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [32]),
    .I1(\BU2/U0/transmitter/txd_pipe [39]),
    .I2(\BU2/U0/transmitter/txd_pipe [38]),
    .I3(\BU2/U0/transmitter/txd_pipe [33]),
    .O(\BU2/N110 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [40]),
    .I1(\BU2/U0/transmitter/txd_pipe [47]),
    .I2(\BU2/U0/transmitter/txd_pipe [46]),
    .I3(\BU2/U0/transmitter/txd_pipe [41]),
    .O(\BU2/N108 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [48]),
    .I1(\BU2/U0/transmitter/txd_pipe [55]),
    .I2(\BU2/U0/transmitter/txd_pipe [54]),
    .I3(\BU2/U0/transmitter/txd_pipe [49]),
    .O(\BU2/N106 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [56]),
    .I1(\BU2/U0/transmitter/txd_pipe [63]),
    .I2(\BU2/U0/transmitter/txd_pipe [62]),
    .I3(\BU2/U0/transmitter/txd_pipe [57]),
    .O(\BU2/N104 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [0]),
    .I1(\BU2/U0/transmitter/txd_pipe [7]),
    .I2(\BU2/U0/transmitter/txd_pipe [6]),
    .I3(\BU2/U0/transmitter/txd_pipe [1]),
    .O(\BU2/N102 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [10]),
    .I1(\BU2/U0/transmitter/txd_pipe [14]),
    .I2(\BU2/U0/transmitter/txd_pipe [15]),
    .I3(\BU2/U0/transmitter/txd_pipe [9]),
    .O(\BU2/N100 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [16]),
    .I1(\BU2/U0/transmitter/txd_pipe [23]),
    .I2(\BU2/U0/transmitter/txd_pipe [22]),
    .I3(\BU2/U0/transmitter/txd_pipe [17]),
    .O(\BU2/N98 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [24]),
    .I1(\BU2/U0/transmitter/txd_pipe [31]),
    .I2(\BU2/U0/transmitter/txd_pipe [30]),
    .I3(\BU2/U0/transmitter/txd_pipe [25]),
    .O(\BU2/N96 )
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  \BU2/U0/receiver/recoder/rxd_out_24_mux00021  (
    .I0(\BU2/U0/receiver/recoder/error_lane [3]),
    .I1(\BU2/U0/receiver/recoder/mux0015_or0000_950 ),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [24]),
    .O(\BU2/U0/receiver/recoder/rxd_out_24_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0003_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [7]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [4]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [3]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [5]),
    .I5(\BU2/N94 ),
    .O(\BU2/U0/receiver/recoder/mux0003_or0000_975 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0003_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [2]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [1]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [0]),
    .O(\BU2/N94 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0007_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I5(\BU2/N92 ),
    .O(\BU2/U0/receiver/recoder/mux0007_or0000_966 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0007_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [10]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [8]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [9]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [1]),
    .O(\BU2/N92 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0011_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I5(\BU2/N90 ),
    .O(\BU2/U0/receiver/recoder/mux0011_or0000_958 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0011_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [18]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [16]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [17]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [2]),
    .O(\BU2/N90 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0015_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I5(\BU2/N88 ),
    .O(\BU2/U0/receiver/recoder/mux0015_or0000_950 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0015_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [26]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [24]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [25]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [3]),
    .O(\BU2/N88 )
  );
  LUT5 #(
    .INIT ( 32'h00808008 ))
  \BU2/U0/receiver/recoder/mux0023_or00002  (
    .I0(\BU2/U0/receiver/recoder/N18 ),
    .I1(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .O(\BU2/U0/receiver/recoder/mux0023_or0000 )
  );
  LUT4 #(
    .INIT ( 16'h2802 ))
  \BU2/U0/receiver/recoder/mux0019_or00002  (
    .I0(\BU2/U0/receiver/recoder/N17 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .O(\BU2/U0/receiver/recoder/mux0019_or0000 )
  );
  LUT4 #(
    .INIT ( 16'h2802 ))
  \BU2/U0/receiver/recoder/mux0027_or00002  (
    .I0(\BU2/U0/receiver/recoder/N16 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .O(\BU2/U0/receiver/recoder/mux0027_or0000 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00021  (
    .I0(mgt_rxdata_8[55]),
    .I1(mgt_rxdata_8[54]),
    .I2(mgt_rxdata_8[53]),
    .I3(mgt_rxdata_8[52]),
    .I4(mgt_rxdata_8[51]),
    .I5(\BU2/N86 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N2 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00021_SW0  (
    .I0(mgt_rxdata_8[48]),
    .I1(mgt_rxdata_8[49]),
    .I2(mgt_rxdata_8[50]),
    .I3(mgt_rxcharisk_9[6]),
    .I4(mgt_codevalid_10[6]),
    .O(\BU2/N86 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00022  (
    .I0(mgt_rxdata_8[39]),
    .I1(mgt_rxdata_8[38]),
    .I2(mgt_rxdata_8[37]),
    .I3(mgt_rxdata_8[36]),
    .I4(mgt_rxdata_8[35]),
    .I5(\BU2/N84 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N4 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00022_SW0  (
    .I0(mgt_rxdata_8[32]),
    .I1(mgt_rxdata_8[33]),
    .I2(mgt_rxdata_8[34]),
    .I3(mgt_rxcharisk_9[4]),
    .I4(mgt_codevalid_10[4]),
    .O(\BU2/N84 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00023  (
    .I0(mgt_rxdata_8[7]),
    .I1(mgt_rxdata_8[6]),
    .I2(mgt_rxdata_8[5]),
    .I3(mgt_rxdata_8[4]),
    .I4(mgt_rxdata_8[3]),
    .I5(\BU2/N82 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N6 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00023_SW0  (
    .I0(mgt_rxdata_8[0]),
    .I1(mgt_rxdata_8[1]),
    .I2(mgt_rxdata_8[2]),
    .I3(mgt_rxcharisk_9[0]),
    .I4(mgt_codevalid_10[0]),
    .O(\BU2/N82 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00024  (
    .I0(mgt_rxdata_8[23]),
    .I1(mgt_rxdata_8[22]),
    .I2(mgt_rxdata_8[21]),
    .I3(mgt_rxdata_8[20]),
    .I4(mgt_rxdata_8[19]),
    .I5(\BU2/N80 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N8 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux00024_SW0  (
    .I0(mgt_rxdata_8[16]),
    .I1(mgt_rxdata_8[17]),
    .I2(mgt_rxdata_8[18]),
    .I3(mgt_rxcharisk_9[2]),
    .I4(mgt_codevalid_10[2]),
    .O(\BU2/N80 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00021  (
    .I0(mgt_rxdata_8[47]),
    .I1(mgt_rxdata_8[46]),
    .I2(mgt_rxdata_8[45]),
    .I3(mgt_rxdata_8[44]),
    .I4(mgt_rxdata_8[43]),
    .I5(\BU2/N78 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N11 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00021_SW0  (
    .I0(mgt_rxdata_8[40]),
    .I1(mgt_rxdata_8[41]),
    .I2(mgt_rxdata_8[42]),
    .I3(mgt_rxcharisk_9[5]),
    .I4(mgt_codevalid_10[5]),
    .O(\BU2/N78 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00022  (
    .I0(mgt_rxdata_8[31]),
    .I1(mgt_rxdata_8[30]),
    .I2(mgt_rxdata_8[29]),
    .I3(mgt_rxdata_8[28]),
    .I4(mgt_rxdata_8[27]),
    .I5(\BU2/N76 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N3 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00022_SW0  (
    .I0(mgt_rxdata_8[24]),
    .I1(mgt_rxdata_8[25]),
    .I2(mgt_rxdata_8[26]),
    .I3(mgt_rxcharisk_9[3]),
    .I4(mgt_codevalid_10[3]),
    .O(\BU2/N76 )
  );
  LUT6 #(
    .INIT ( 64'h0100000000000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00023  (
    .I0(mgt_rxdata_8[9]),
    .I1(mgt_rxdata_8[8]),
    .I2(mgt_rxdata_8[15]),
    .I3(mgt_rxdata_8[14]),
    .I4(mgt_rxdata_8[13]),
    .I5(\BU2/N74 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N5 )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00023_SW0  (
    .I0(mgt_rxdata_8[12]),
    .I1(mgt_rxdata_8[11]),
    .I2(mgt_rxdata_8[10]),
    .I3(mgt_rxcharisk_9[1]),
    .I4(mgt_codevalid_10[1]),
    .O(\BU2/N74 )
  );
  LUT6 #(
    .INIT ( 64'h0000000040000000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00024  (
    .I0(mgt_rxdata_8[63]),
    .I1(mgt_rxdata_8[62]),
    .I2(mgt_rxdata_8[61]),
    .I3(mgt_rxdata_8[60]),
    .I4(mgt_rxdata_8[59]),
    .I5(\BU2/N72 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N7 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux00024_SW0  (
    .I0(mgt_rxdata_8[56]),
    .I1(mgt_rxdata_8[57]),
    .I2(mgt_rxdata_8[58]),
    .I3(mgt_rxcharisk_9[7]),
    .I4(mgt_codevalid_10[7]),
    .O(\BU2/N72 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_cmp_eq00001  (
    .I0(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N2 ),
    .I1(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N4 ),
    .I2(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N6 ),
    .I3(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N8 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_cmp_eq0000 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_cmp_eq00001  (
    .I0(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N11 ),
    .I1(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N3 ),
    .I2(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N5 ),
    .I3(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/N7 ),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_cmp_eq0000 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \BU2/U0/transmitter/recoder/txd_out_6_mux000679  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[5]),
    .I2(configuration_vector_17[6]),
    .O(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/retval_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [9]),
    .I1(\BU2/U0/transmitter/txd_pipe [11]),
    .I2(\BU2/U0/transmitter/txd_pipe [10]),
    .I3(\BU2/U0/transmitter/txd_pipe [8]),
    .I4(\BU2/N50 ),
    .I5(\BU2/U0/transmitter/txd_pipe [12]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/retval_mux00011_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [13]),
    .I1(\BU2/U0/transmitter/txd_pipe [15]),
    .I2(\BU2/U0/transmitter/txd_pipe [14]),
    .O(\BU2/N50 )
  );
  LUT6 #(
    .INIT ( 64'hFCCFA88AFCCFA8AA ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<2>1  (
    .I0(\BU2/U0/transmitter/tx_is_idle [0]),
    .I1(\BU2/U0/transmitter/state_machine/state_1_2_572 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_1_574 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_576 ),
    .I4(\BU2/U0/transmitter/tx_is_q [0]),
    .I5(\BU2/U0/transmitter/tqmsg_capture_1/q_det_917 ),
    .O(\BU2/U0/transmitter/state_machine/next_state<0> [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<32>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [32])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<33>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [33])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<34>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [34])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<35>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [35])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<36>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [36])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<37>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [37])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<38>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [38])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<39>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [39])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<40>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [40])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<41>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [41])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<42>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [42])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<43>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [43])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<44>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [44])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<45>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [45])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<46>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [46])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<47>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [47])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<48>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [48])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<49>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [49])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<50>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [50])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<51>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [51])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<52>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [52])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<53>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [53])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<54>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [54])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<55>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [55])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<56>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [56])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<57>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [57])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<58>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [58])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<59>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [59])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<60>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [60])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<61>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [61])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<62>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [62])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<63>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and0000 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [63])
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_0_or0000  (
    .I0(mgt_rxdata_8[7]),
    .I1(mgt_rxdata_8[6]),
    .I2(mgt_rxdata_8[5]),
    .I3(\BU2/N40 ),
    .I4(\BU2/N39 ),
    .I5(mgt_codevalid_10[0]),
    .O(\BU2/U0/receiver/code_error [0])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_0_or0000_SW1  (
    .I0(mgt_rxdata_8[2]),
    .I1(mgt_rxdata_8[0]),
    .I2(mgt_rxcharisk_9[0]),
    .I3(mgt_rxdata_8[3]),
    .I4(mgt_rxdata_8[1]),
    .I5(mgt_rxdata_8[4]),
    .O(\BU2/N40 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_0_or0000_SW0  (
    .I0(mgt_rxcharisk_9[0]),
    .I1(mgt_rxdata_8[1]),
    .I2(mgt_rxdata_8[4]),
    .I3(mgt_rxdata_8[3]),
    .I4(mgt_rxdata_8[2]),
    .I5(mgt_rxdata_8[0]),
    .O(\BU2/N39 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_1_or0000  (
    .I0(mgt_rxdata_8[23]),
    .I1(mgt_rxdata_8[22]),
    .I2(mgt_rxdata_8[21]),
    .I3(\BU2/N37 ),
    .I4(\BU2/N36 ),
    .I5(mgt_codevalid_10[2]),
    .O(\BU2/U0/receiver/code_error [1])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_1_or0000_SW1  (
    .I0(mgt_rxdata_8[18]),
    .I1(mgt_rxdata_8[16]),
    .I2(mgt_rxcharisk_9[2]),
    .I3(mgt_rxdata_8[19]),
    .I4(mgt_rxdata_8[17]),
    .I5(mgt_rxdata_8[20]),
    .O(\BU2/N37 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_1_or0000_SW0  (
    .I0(mgt_rxcharisk_9[2]),
    .I1(mgt_rxdata_8[17]),
    .I2(mgt_rxdata_8[20]),
    .I3(mgt_rxdata_8[19]),
    .I4(mgt_rxdata_8[18]),
    .I5(mgt_rxdata_8[16]),
    .O(\BU2/N36 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_2_or0000  (
    .I0(mgt_rxdata_8[39]),
    .I1(mgt_rxdata_8[38]),
    .I2(mgt_rxdata_8[37]),
    .I3(\BU2/N34 ),
    .I4(\BU2/N33 ),
    .I5(mgt_codevalid_10[4]),
    .O(\BU2/U0/receiver/code_error [2])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_2_or0000_SW1  (
    .I0(mgt_rxdata_8[34]),
    .I1(mgt_rxdata_8[32]),
    .I2(mgt_rxcharisk_9[4]),
    .I3(mgt_rxdata_8[35]),
    .I4(mgt_rxdata_8[33]),
    .I5(mgt_rxdata_8[36]),
    .O(\BU2/N34 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_2_or0000_SW0  (
    .I0(mgt_rxcharisk_9[4]),
    .I1(mgt_rxdata_8[33]),
    .I2(mgt_rxdata_8[36]),
    .I3(mgt_rxdata_8[35]),
    .I4(mgt_rxdata_8[34]),
    .I5(mgt_rxdata_8[32]),
    .O(\BU2/N33 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_3_or0000  (
    .I0(mgt_rxdata_8[55]),
    .I1(mgt_rxdata_8[54]),
    .I2(mgt_rxdata_8[53]),
    .I3(\BU2/N31 ),
    .I4(\BU2/N30 ),
    .I5(mgt_codevalid_10[6]),
    .O(\BU2/U0/receiver/code_error [3])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_3_or0000_SW1  (
    .I0(mgt_rxdata_8[50]),
    .I1(mgt_rxdata_8[48]),
    .I2(mgt_rxcharisk_9[6]),
    .I3(mgt_rxdata_8[51]),
    .I4(mgt_rxdata_8[49]),
    .I5(mgt_rxdata_8[52]),
    .O(\BU2/N31 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_3_or0000_SW0  (
    .I0(mgt_rxcharisk_9[6]),
    .I1(mgt_rxdata_8[49]),
    .I2(mgt_rxdata_8[52]),
    .I3(mgt_rxdata_8[51]),
    .I4(mgt_rxdata_8[50]),
    .I5(mgt_rxdata_8[48]),
    .O(\BU2/N30 )
  );
  LUT6 #(
    .INIT ( 64'h80CCC4CCFFFFFFFF ))
  \BU2/U0/receiver/code_error_4_or0000  (
    .I0(mgt_rxdata_8[9]),
    .I1(mgt_rxcharisk_9[1]),
    .I2(\BU2/N28 ),
    .I3(mgt_rxdata_8[12]),
    .I4(\BU2/N27 ),
    .I5(mgt_codevalid_10[1]),
    .O(\BU2/U0/receiver/code_error [4])
  );
  LUT6 #(
    .INIT ( 64'hF77F7FFFFFFFFFFF ))
  \BU2/U0/receiver/code_error_4_or0000_SW1  (
    .I0(mgt_rxdata_8[15]),
    .I1(mgt_rxdata_8[14]),
    .I2(mgt_rxdata_8[10]),
    .I3(mgt_rxdata_8[8]),
    .I4(mgt_rxdata_8[11]),
    .I5(mgt_rxdata_8[13]),
    .O(\BU2/N28 )
  );
  LUT6 #(
    .INIT ( 64'hC040404040404040 ))
  \BU2/U0/receiver/code_error_4_or0000_SW0  (
    .I0(mgt_rxdata_8[8]),
    .I1(mgt_rxdata_8[10]),
    .I2(mgt_rxdata_8[11]),
    .I3(mgt_rxdata_8[15]),
    .I4(mgt_rxdata_8[14]),
    .I5(mgt_rxdata_8[13]),
    .O(\BU2/N27 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_5_or0000  (
    .I0(mgt_rxdata_8[31]),
    .I1(mgt_rxdata_8[30]),
    .I2(mgt_rxdata_8[29]),
    .I3(\BU2/N25 ),
    .I4(\BU2/N24 ),
    .I5(mgt_codevalid_10[3]),
    .O(\BU2/U0/receiver/code_error [5])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_5_or0000_SW1  (
    .I0(mgt_rxdata_8[26]),
    .I1(mgt_rxdata_8[24]),
    .I2(mgt_rxcharisk_9[3]),
    .I3(mgt_rxdata_8[27]),
    .I4(mgt_rxdata_8[25]),
    .I5(mgt_rxdata_8[28]),
    .O(\BU2/N25 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_5_or0000_SW0  (
    .I0(mgt_rxcharisk_9[3]),
    .I1(mgt_rxdata_8[25]),
    .I2(mgt_rxdata_8[28]),
    .I3(mgt_rxdata_8[27]),
    .I4(mgt_rxdata_8[26]),
    .I5(mgt_rxdata_8[24]),
    .O(\BU2/N24 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_6_or0000  (
    .I0(mgt_rxdata_8[47]),
    .I1(mgt_rxdata_8[46]),
    .I2(mgt_rxdata_8[45]),
    .I3(\BU2/N22 ),
    .I4(\BU2/N21 ),
    .I5(mgt_codevalid_10[5]),
    .O(\BU2/U0/receiver/code_error [6])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_6_or0000_SW1  (
    .I0(mgt_rxdata_8[42]),
    .I1(mgt_rxdata_8[40]),
    .I2(mgt_rxcharisk_9[5]),
    .I3(mgt_rxdata_8[43]),
    .I4(mgt_rxdata_8[41]),
    .I5(mgt_rxdata_8[44]),
    .O(\BU2/N22 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_6_or0000_SW0  (
    .I0(mgt_rxcharisk_9[5]),
    .I1(mgt_rxdata_8[41]),
    .I2(mgt_rxdata_8[44]),
    .I3(mgt_rxdata_8[43]),
    .I4(mgt_rxdata_8[42]),
    .I5(mgt_rxdata_8[40]),
    .O(\BU2/N21 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_7_or0000  (
    .I0(mgt_rxdata_8[63]),
    .I1(mgt_rxdata_8[62]),
    .I2(mgt_rxdata_8[61]),
    .I3(\BU2/N19 ),
    .I4(\BU2/N18 ),
    .I5(mgt_codevalid_10[7]),
    .O(\BU2/U0/receiver/code_error [7])
  );
  LUT6 #(
    .INIT ( 64'h907050F0F0F0F0F0 ))
  \BU2/U0/receiver/code_error_7_or0000_SW1  (
    .I0(mgt_rxdata_8[58]),
    .I1(mgt_rxdata_8[56]),
    .I2(mgt_rxcharisk_9[7]),
    .I3(mgt_rxdata_8[59]),
    .I4(mgt_rxdata_8[57]),
    .I5(mgt_rxdata_8[60]),
    .O(\BU2/N19 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA8AAAAAAA ))
  \BU2/U0/receiver/code_error_7_or0000_SW0  (
    .I0(mgt_rxcharisk_9[7]),
    .I1(mgt_rxdata_8[57]),
    .I2(mgt_rxdata_8[60]),
    .I3(mgt_rxdata_8[59]),
    .I4(mgt_rxdata_8[58]),
    .I5(mgt_rxdata_8[56]),
    .O(\BU2/N18 )
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  \BU2/U0/transmitter/recoder/txd_out_11_or00001  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[5]),
    .I2(configuration_vector_17[6]),
    .O(\BU2/U0/transmitter/recoder/txd_out_11_or0000 )
  );
  LUT4 #(
    .INIT ( 16'hFF2A ))
  \BU2/U0/transmitter/recoder/txd_out_12_or00001  (
    .I0(configuration_vector_17[4]),
    .I1(configuration_vector_17[5]),
    .I2(configuration_vector_17[6]),
    .I3(\BU2/U0/usrclk_reset_328 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_12_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \BU2/U0/receiver/recoder/rxd_out_10_or00001  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/usrclk_reset_328 ),
    .O(\BU2/U0/aligned_sticky_or0000 )
  );
  LUT6 #(
    .INIT ( 64'hA22AAAA2AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_59_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [27]),
    .I1(\BU2/U0/receiver/recoder/N38 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I5(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .O(\BU2/U0/receiver/recoder/rxd_out_59_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hA22AAAA2AAAAAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_60_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [28]),
    .I1(\BU2/U0/receiver/recoder/N38 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I5(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .O(\BU2/U0/receiver/recoder/rxd_out_60_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'hA22AAAAA ))
  \BU2/U0/receiver/recoder/rxd_out_61_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I1(\BU2/U0/receiver/recoder/N38 ),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .O(\BU2/U0/receiver/recoder/rxd_out_61_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'hAAAA2AAA ))
  \BU2/U0/receiver/recoder/rxd_out_62_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I1(\BU2/U0/receiver/recoder/N38 ),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .O(\BU2/U0/receiver/recoder/rxd_out_62_mux0002 )
  );
  LUT5 #(
    .INIT ( 32'hAAAA2AAA ))
  \BU2/U0/receiver/recoder/rxd_out_63_mux00021  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [31]),
    .I1(\BU2/U0/receiver/recoder/N38 ),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [29]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .O(\BU2/U0/receiver/recoder/rxd_out_63_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_0_cmp_eq00001  (
    .I0(xgmii_txd_2[0]),
    .I1(xgmii_txd_2[1]),
    .I2(xgmii_txd_2[2]),
    .I3(xgmii_txd_2[3]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [0])
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_0_cmp_eq00001  (
    .I0(xgmii_txd_2[32]),
    .I1(xgmii_txd_2[33]),
    .I2(xgmii_txd_2[34]),
    .I3(xgmii_txd_2[35]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [0])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_1_cmp_eq00001  (
    .I0(xgmii_txd_2[4]),
    .I1(xgmii_txd_2[5]),
    .I2(xgmii_txd_2[6]),
    .I3(xgmii_txd_2[7]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [1])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_1_cmp_eq00001  (
    .I0(xgmii_txd_2[36]),
    .I1(xgmii_txd_2[37]),
    .I2(xgmii_txd_2[38]),
    .I3(xgmii_txd_2[39]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [1])
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0032_and0000  (
    .I0(mgt_rxdata_8[7]),
    .I1(mgt_rxdata_8[6]),
    .I2(mgt_rxdata_8[5]),
    .I3(mgt_rxdata_8[4]),
    .I4(mgt_rxdata_8[3]),
    .I5(\BU2/N16 ),
    .O(\BU2/U0/receiver/recoder/mux0032_and0000_818 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0032_and0000_SW0  (
    .I0(mgt_rxdata_8[1]),
    .I1(mgt_rxdata_8[2]),
    .I2(mgt_rxdata_8[0]),
    .I3(mgt_rxcharisk_9[0]),
    .O(\BU2/N16 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0033_and0000  (
    .I0(mgt_rxdata_8[23]),
    .I1(mgt_rxdata_8[22]),
    .I2(mgt_rxdata_8[21]),
    .I3(mgt_rxdata_8[20]),
    .I4(mgt_rxdata_8[19]),
    .I5(\BU2/N14 ),
    .O(\BU2/U0/receiver/recoder/mux0033_and0000_816 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0033_and0000_SW0  (
    .I0(mgt_rxdata_8[17]),
    .I1(mgt_rxdata_8[18]),
    .I2(mgt_rxdata_8[16]),
    .I3(mgt_rxcharisk_9[2]),
    .O(\BU2/N14 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0034_and0000  (
    .I0(mgt_rxdata_8[39]),
    .I1(mgt_rxdata_8[38]),
    .I2(mgt_rxdata_8[37]),
    .I3(mgt_rxdata_8[36]),
    .I4(mgt_rxdata_8[35]),
    .I5(\BU2/N12 ),
    .O(\BU2/U0/receiver/recoder/mux0034_and0000_814 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0034_and0000_SW0  (
    .I0(mgt_rxdata_8[33]),
    .I1(mgt_rxdata_8[34]),
    .I2(mgt_rxdata_8[32]),
    .I3(mgt_rxcharisk_9[4]),
    .O(\BU2/N12 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0035_and0000  (
    .I0(mgt_rxdata_8[55]),
    .I1(mgt_rxdata_8[54]),
    .I2(mgt_rxdata_8[53]),
    .I3(mgt_rxdata_8[52]),
    .I4(mgt_rxdata_8[51]),
    .I5(\BU2/N10 ),
    .O(\BU2/U0/receiver/recoder/mux0035_and0000_812 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0035_and0000_SW0  (
    .I0(mgt_rxdata_8[49]),
    .I1(mgt_rxdata_8[50]),
    .I2(mgt_rxdata_8[48]),
    .I3(mgt_rxcharisk_9[6]),
    .O(\BU2/N10 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0036_and0000  (
    .I0(\BU2/N8 ),
    .I1(mgt_rxdata_8[8]),
    .I2(mgt_rxdata_8[15]),
    .I3(mgt_rxdata_8[14]),
    .I4(mgt_rxdata_8[13]),
    .I5(mgt_rxdata_8[9]),
    .O(\BU2/U0/receiver/recoder/mux0036_and0000_811 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/receiver/recoder/mux0036_and0000_SW0  (
    .I0(mgt_rxdata_8[12]),
    .I1(mgt_rxdata_8[11]),
    .I2(mgt_rxdata_8[10]),
    .I3(mgt_rxcharisk_9[1]),
    .O(\BU2/N8 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0037_and0000  (
    .I0(mgt_rxdata_8[31]),
    .I1(mgt_rxdata_8[30]),
    .I2(mgt_rxdata_8[29]),
    .I3(mgt_rxdata_8[28]),
    .I4(mgt_rxdata_8[27]),
    .I5(\BU2/N6 ),
    .O(\BU2/U0/receiver/recoder/mux0037_and0000_810 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0037_and0000_SW0  (
    .I0(mgt_rxdata_8[25]),
    .I1(mgt_rxdata_8[26]),
    .I2(mgt_rxdata_8[24]),
    .I3(mgt_rxcharisk_9[3]),
    .O(\BU2/N6 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0038_and0000  (
    .I0(mgt_rxdata_8[47]),
    .I1(mgt_rxdata_8[46]),
    .I2(mgt_rxdata_8[45]),
    .I3(mgt_rxdata_8[44]),
    .I4(mgt_rxdata_8[43]),
    .I5(\BU2/N4 ),
    .O(\BU2/U0/receiver/recoder/mux0038_and0000_809 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0038_and0000_SW0  (
    .I0(mgt_rxdata_8[41]),
    .I1(mgt_rxdata_8[42]),
    .I2(mgt_rxdata_8[40]),
    .I3(mgt_rxcharisk_9[5]),
    .O(\BU2/N4 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/receiver/recoder/mux0039_and0000  (
    .I0(mgt_rxdata_8[63]),
    .I1(mgt_rxdata_8[62]),
    .I2(mgt_rxdata_8[61]),
    .I3(mgt_rxdata_8[60]),
    .I4(mgt_rxdata_8[59]),
    .I5(\BU2/N2 ),
    .O(\BU2/U0/receiver/recoder/mux0039_and0000_808 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/mux0039_and0000_SW0  (
    .I0(mgt_rxdata_8[57]),
    .I1(mgt_rxdata_8[58]),
    .I2(mgt_rxdata_8[56]),
    .I3(mgt_rxcharisk_9[7]),
    .O(\BU2/N2 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000621  (
    .I0(configuration_vector_17[5]),
    .I1(configuration_vector_17[6]),
    .I2(configuration_vector_17[4]),
    .O(\BU2/U0/transmitter/recoder/N24 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_2_cmp_eq00001  (
    .I0(xgmii_txd_2[8]),
    .I1(xgmii_txd_2[9]),
    .I2(xgmii_txd_2[10]),
    .I3(xgmii_txd_2[11]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [2])
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_2_cmp_eq00001  (
    .I0(xgmii_txd_2[40]),
    .I1(xgmii_txd_2[41]),
    .I2(xgmii_txd_2[42]),
    .I3(xgmii_txd_2[43]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [2])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_3_cmp_eq00001  (
    .I0(xgmii_txd_2[12]),
    .I1(xgmii_txd_2[13]),
    .I2(xgmii_txd_2[14]),
    .I3(xgmii_txd_2[15]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [3])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_3_cmp_eq00001  (
    .I0(xgmii_txd_2[44]),
    .I1(xgmii_txd_2[45]),
    .I2(xgmii_txd_2[46]),
    .I3(xgmii_txd_2[47]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [3])
  );
  LUT6 #(
    .INIT ( 64'h800088088AAA88A8 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/next_state_1_mux00001  (
    .I0(\BU2/U0/receiver/sync_status_626 ),
    .I1(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align [1]),
    .I2(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/state_1_627 ),
    .I3(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error [0]),
    .I4(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align [0]),
    .I5(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error [1]),
    .O(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/next_state [1])
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_4_cmp_eq00001  (
    .I0(xgmii_txd_2[16]),
    .I1(xgmii_txd_2[17]),
    .I2(xgmii_txd_2[18]),
    .I3(xgmii_txd_2[19]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [4])
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_4_cmp_eq00001  (
    .I0(xgmii_txd_2[48]),
    .I1(xgmii_txd_2[49]),
    .I2(xgmii_txd_2[50]),
    .I3(xgmii_txd_2[51]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [4])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/transmitter/align/Mxor_prbs_1_xor0000_Result1  (
    .I0(\BU2/U0/transmitter/align/prbs [7]),
    .I1(\BU2/U0/transmitter/align/prbs [6]),
    .O(\BU2/U0/transmitter/align/prbs_1_xor0000 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/transmitter/k_r_prbs_i/Mxor_prbs_1_xor0000_Result1  (
    .I0(\BU2/U0/transmitter/k_r_prbs_i/prbs [6]),
    .I1(\BU2/U0/transmitter/k_r_prbs_i/prbs [5]),
    .O(\BU2/U0/transmitter/k_r_prbs_i/prbs_1_xor0000 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \BU2/U0/transmitter/k_r_prbs_i/Mxor_prbs_2_xor0000_Result1  (
    .I0(\BU2/U0/transmitter/k_r_prbs_i/prbs [7]),
    .I1(\BU2/U0/transmitter/k_r_prbs_i/prbs [6]),
    .O(\BU2/U0/transmitter/k_r_prbs_i/prbs_2_xor0000 )
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_5_cmp_eq00001  (
    .I0(xgmii_txd_2[20]),
    .I1(xgmii_txd_2[21]),
    .I2(xgmii_txd_2[22]),
    .I3(xgmii_txd_2[23]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [5])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_5_cmp_eq00001  (
    .I0(xgmii_txd_2[52]),
    .I1(xgmii_txd_2[53]),
    .I2(xgmii_txd_2[54]),
    .I3(xgmii_txd_2[55]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [5])
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_6_cmp_eq00001  (
    .I0(xgmii_txd_2[24]),
    .I1(xgmii_txd_2[25]),
    .I2(xgmii_txd_2[26]),
    .I3(xgmii_txd_2[27]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [6])
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_6_cmp_eq00001  (
    .I0(xgmii_txd_2[56]),
    .I1(xgmii_txd_2[57]),
    .I2(xgmii_txd_2[58]),
    .I3(xgmii_txd_2[59]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [6])
  );
  LUT4 #(
    .INIT ( 16'h0008 ))
  \BU2/U0/transmitter/seq_detect_i0/comp_0_cmp_eq00001  (
    .I0(xgmii_txd_2[2]),
    .I1(xgmii_txd_2[3]),
    .I2(xgmii_txd_2[0]),
    .I3(xgmii_txd_2[1]),
    .O(\BU2/U0/transmitter/seq_detect_i0/comp [0])
  );
  LUT4 #(
    .INIT ( 16'h0008 ))
  \BU2/U0/transmitter/seq_detect_i1/comp_0_cmp_eq00001  (
    .I0(xgmii_txd_2[34]),
    .I1(xgmii_txd_2[35]),
    .I2(xgmii_txd_2[32]),
    .I3(xgmii_txd_2[33]),
    .O(\BU2/U0/transmitter/seq_detect_i1/comp [0])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_7_cmp_eq00001  (
    .I0(xgmii_txd_2[28]),
    .I1(xgmii_txd_2[29]),
    .I2(xgmii_txd_2[30]),
    .I3(xgmii_txd_2[31]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [7])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_7_cmp_eq00001  (
    .I0(xgmii_txd_2[60]),
    .I1(xgmii_txd_2[61]),
    .I2(xgmii_txd_2[62]),
    .I3(xgmii_txd_2[63]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [7])
  );
  LUT4 #(
    .INIT ( 16'h0008 ))
  \BU2/U0/transmitter/seq_detect_i0/comp_1_cmp_eq00001  (
    .I0(xgmii_txd_2[4]),
    .I1(xgmii_txd_2[7]),
    .I2(xgmii_txd_2[5]),
    .I3(xgmii_txd_2[6]),
    .O(\BU2/U0/transmitter/seq_detect_i0/comp [1])
  );
  LUT4 #(
    .INIT ( 16'h0008 ))
  \BU2/U0/transmitter/seq_detect_i1/comp_1_cmp_eq00001  (
    .I0(xgmii_txd_2[36]),
    .I1(xgmii_txd_2[39]),
    .I2(xgmii_txd_2[37]),
    .I3(xgmii_txd_2[38]),
    .O(\BU2/U0/transmitter/seq_detect_i1/comp [1])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/transmitter/idle_detect_i0/comp_8_cmp_eq00001  (
    .I0(xgmii_txc_3[0]),
    .I1(xgmii_txc_3[1]),
    .I2(xgmii_txc_3[2]),
    .I3(xgmii_txc_3[3]),
    .O(\BU2/U0/transmitter/idle_detect_i0/comp [8])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/transmitter/idle_detect_i1/comp_8_cmp_eq00001  (
    .I0(xgmii_txc_3[4]),
    .I1(xgmii_txc_3[5]),
    .I2(xgmii_txc_3[6]),
    .I3(xgmii_txc_3[7]),
    .O(\BU2/U0/transmitter/idle_detect_i1/comp [8])
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/seq_detect_i0/comp_2_cmp_eq00001  (
    .I0(xgmii_txc_3[0]),
    .I1(xgmii_txc_3[1]),
    .I2(xgmii_txc_3[2]),
    .I3(xgmii_txc_3[3]),
    .O(\BU2/U0/transmitter/seq_detect_i0/comp [2])
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/seq_detect_i1/comp_2_cmp_eq00001  (
    .I0(xgmii_txc_3[4]),
    .I1(xgmii_txc_3[5]),
    .I2(xgmii_txc_3[6]),
    .I3(xgmii_txc_3[7]),
    .O(\BU2/U0/transmitter/seq_detect_i1/comp [2])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/receiver/sync_status_int_cmp_eq00001  (
    .I0(mgt_syncok_12[0]),
    .I1(mgt_syncok_12[1]),
    .I2(mgt_syncok_12[2]),
    .I3(mgt_syncok_12[3]),
    .O(\BU2/U0/receiver/sync_status_int )
  );
  FD   \BU2/U0/clear_aligned  (
    .C(usrclk),
    .D(configuration_vector_17[3]),
    .Q(\BU2/U0/clear_aligned_821 )
  );
  FD   \BU2/U0/clear_local_fault  (
    .C(usrclk),
    .D(configuration_vector_17[2]),
    .Q(\BU2/U0/clear_local_fault_823 )
  );
  FDR   \BU2/U0/last_value  (
    .C(usrclk),
    .D(\BU2/U0/clear_local_fault_823 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/last_value_824 )
  );
  FDR   \BU2/U0/last_value0  (
    .C(usrclk),
    .D(\BU2/U0/clear_aligned_821 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/last_value0_822 )
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_11  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_11_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [1]),
    .Q(xgmii_rxd_4[11])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0032_and0000_818 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [0])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0033_and0000_816 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [1])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0034_and0000_814 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [2])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0035_and0000_812 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [3])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0036_and0000_811 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [4])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0037_and0000_810 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [5])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0038_and0000_809 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [6])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0039_and0000_808 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [7])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_12  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_12_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [1]),
    .Q(xgmii_rxd_4[12])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_13  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_13_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [1]),
    .Q(xgmii_rxd_4[13])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_14  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_14_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [1]),
    .Q(xgmii_rxd_4[14])
  );
  FDS   \BU2/U0/receiver/recoder/rxc_pipe_0  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[0]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_1  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[2]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [1])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_15  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_15_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [1]),
    .Q(xgmii_rxd_4[15])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_20  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_20_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [2]),
    .Q(xgmii_rxd_4[20])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_2  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[4]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [2])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_21  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_21_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [2]),
    .Q(xgmii_rxd_4[21])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_3  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [3])
  );
  FDS   \BU2/U0/receiver/recoder/rxc_pipe_4  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [4])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_22  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_22_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [2]),
    .Q(xgmii_rxd_4[22])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_23  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_23_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [2]),
    .Q(xgmii_rxd_4[23])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_24  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_24_mux0002 ),
    .S(\BU2/U0/aligned_sticky_or0000 ),
    .Q(xgmii_rxd_4[24])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_5  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[3]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [5])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_19  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_19_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [2]),
    .Q(xgmii_rxd_4[19])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_6  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [6])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_30  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_30_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [3]),
    .Q(xgmii_rxd_4[30])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_7  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[7]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [7])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_31  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_31_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [3]),
    .Q(xgmii_rxd_4[31])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_27  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_27_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [3]),
    .Q(xgmii_rxd_4[27])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_28  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_28_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [3]),
    .Q(xgmii_rxd_4[28])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_29  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_29_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [3]),
    .Q(xgmii_rxd_4[29])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_35  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_35_mux0002 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_32_or0000 ),
    .Q(xgmii_rxd_4[35])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_36  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_36_mux0002 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_32_or0000 ),
    .Q(xgmii_rxd_4[36])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_37  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_37_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [4]),
    .Q(xgmii_rxd_4[37])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_0  (
    .C(usrclk),
    .D(mgt_rxdata_8[0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [0])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_38  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_38_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [4]),
    .Q(xgmii_rxd_4[38])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_39  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_39_mux0002 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_32_or0000 ),
    .Q(xgmii_rxd_4[39])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_43  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_43_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [5]),
    .Q(xgmii_rxd_4[43])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_1  (
    .C(usrclk),
    .D(mgt_rxdata_8[1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [1])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_44  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_44_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [5]),
    .Q(xgmii_rxd_4[44])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_2  (
    .C(usrclk),
    .D(mgt_rxdata_8[2]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [2])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_3  (
    .C(usrclk),
    .D(mgt_rxdata_8[3]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [3])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_45  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_45_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [5]),
    .Q(xgmii_rxd_4[45])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_46  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_46_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [5]),
    .Q(xgmii_rxd_4[46])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_51  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_51_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [6]),
    .Q(xgmii_rxd_4[51])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_4  (
    .C(usrclk),
    .D(mgt_rxdata_8[4]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [4])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_47  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_47_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [5]),
    .Q(xgmii_rxd_4[47])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_52  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_52_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [6]),
    .Q(xgmii_rxd_4[52])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_5  (
    .C(usrclk),
    .D(mgt_rxdata_8[5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [5])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_6  (
    .C(usrclk),
    .D(mgt_rxdata_8[6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [6])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_53  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_53_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [6]),
    .Q(xgmii_rxd_4[53])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_54  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_54_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [6]),
    .Q(xgmii_rxd_4[54])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_7  (
    .C(usrclk),
    .D(mgt_rxdata_8[7]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [7])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_55  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_55_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [6]),
    .Q(xgmii_rxd_4[55])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_60  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_60_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [7]),
    .Q(xgmii_rxd_4[60])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_8  (
    .C(usrclk),
    .D(mgt_rxdata_8[16]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [8])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_56  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_56_mux0002_757 ),
    .S(\BU2/U0/aligned_sticky_or0000 ),
    .Q(xgmii_rxd_4[56])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_61  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_61_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [7]),
    .Q(xgmii_rxd_4[61])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_9  (
    .C(usrclk),
    .D(mgt_rxdata_8[17]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [9])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_62  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_62_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [7]),
    .Q(xgmii_rxd_4[62])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_3_mux0002 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_0_or0000 ),
    .Q(xgmii_rxd_4[3])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_63  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_63_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [7]),
    .Q(xgmii_rxd_4[63])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_5_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [0]),
    .Q(xgmii_rxd_4[5])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_4_mux0002 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_0_or0000 ),
    .Q(xgmii_rxd_4[4])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_59  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_59_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [7]),
    .Q(xgmii_rxd_4[59])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_6_mux0002 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/error_lane [0]),
    .Q(xgmii_rxd_4[6])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_7_mux0002 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_0_or0000 ),
    .Q(xgmii_rxd_4[7])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_10  (
    .C(usrclk),
    .D(mgt_rxdata_8[18]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [10])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_11  (
    .C(usrclk),
    .D(mgt_rxdata_8[19]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [11])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_12  (
    .C(usrclk),
    .D(mgt_rxdata_8[20]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [12])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_13  (
    .C(usrclk),
    .D(mgt_rxdata_8[21]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [13])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [2]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [2])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [3]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [3])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [4]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [4])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [5])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [6])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [7]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [7])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_15  (
    .C(usrclk),
    .D(mgt_rxdata_8[23]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [15])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_14  (
    .C(usrclk),
    .D(mgt_rxdata_8[22]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [14])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_20  (
    .C(usrclk),
    .D(mgt_rxdata_8[36]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [20])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_16  (
    .C(usrclk),
    .D(mgt_rxdata_8[32]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [16])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_22  (
    .C(usrclk),
    .D(mgt_rxdata_8[38]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [22])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_21  (
    .C(usrclk),
    .D(mgt_rxdata_8[37]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [21])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_17  (
    .C(usrclk),
    .D(mgt_rxdata_8[33]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [17])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_18  (
    .C(usrclk),
    .D(mgt_rxdata_8[34]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [18])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_23  (
    .C(usrclk),
    .D(mgt_rxdata_8[39]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [23])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_19  (
    .C(usrclk),
    .D(mgt_rxdata_8[35]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [19])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_24  (
    .C(usrclk),
    .D(mgt_rxdata_8[48]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [24])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_25  (
    .C(usrclk),
    .D(mgt_rxdata_8[49]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [25])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_30  (
    .C(usrclk),
    .D(mgt_rxdata_8[54]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [30])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_27  (
    .C(usrclk),
    .D(mgt_rxdata_8[51]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [27])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_26  (
    .C(usrclk),
    .D(mgt_rxdata_8[50]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [26])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_31  (
    .C(usrclk),
    .D(mgt_rxdata_8[55]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [31])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_32  (
    .C(usrclk),
    .D(mgt_rxdata_8[8]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [32])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_28  (
    .C(usrclk),
    .D(mgt_rxdata_8[52]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [28])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_34  (
    .C(usrclk),
    .D(mgt_rxdata_8[10]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [34])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_33  (
    .C(usrclk),
    .D(mgt_rxdata_8[9]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [33])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_29  (
    .C(usrclk),
    .D(mgt_rxdata_8[53]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [29])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_35  (
    .C(usrclk),
    .D(mgt_rxdata_8[11]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [35])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_40  (
    .C(usrclk),
    .D(mgt_rxdata_8[24]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [40])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_37  (
    .C(usrclk),
    .D(mgt_rxdata_8[13]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [37])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_36  (
    .C(usrclk),
    .D(mgt_rxdata_8[12]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [36])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_41  (
    .C(usrclk),
    .D(mgt_rxdata_8[25]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [41])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_42  (
    .C(usrclk),
    .D(mgt_rxdata_8[26]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [42])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_38  (
    .C(usrclk),
    .D(mgt_rxdata_8[14]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [38])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_43  (
    .C(usrclk),
    .D(mgt_rxdata_8[27]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [43])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_39  (
    .C(usrclk),
    .D(mgt_rxdata_8[15]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [39])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_44  (
    .C(usrclk),
    .D(mgt_rxdata_8[28]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [44])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_46  (
    .C(usrclk),
    .D(mgt_rxdata_8[30]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [46])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_45  (
    .C(usrclk),
    .D(mgt_rxdata_8[29]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [45])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_50  (
    .C(usrclk),
    .D(mgt_rxdata_8[42]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [50])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_51  (
    .C(usrclk),
    .D(mgt_rxdata_8[43]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [51])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_47  (
    .C(usrclk),
    .D(mgt_rxdata_8[31]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [47])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_53  (
    .C(usrclk),
    .D(mgt_rxdata_8[45]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [53])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_52  (
    .C(usrclk),
    .D(mgt_rxdata_8[44]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [52])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_48  (
    .C(usrclk),
    .D(mgt_rxdata_8[40]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [48])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_49  (
    .C(usrclk),
    .D(mgt_rxdata_8[41]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [49])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_54  (
    .C(usrclk),
    .D(mgt_rxdata_8[46]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [54])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_56  (
    .C(usrclk),
    .D(mgt_rxdata_8[56]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [56])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_55  (
    .C(usrclk),
    .D(mgt_rxdata_8[47]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [55])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_60  (
    .C(usrclk),
    .D(mgt_rxdata_8[60]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [60])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_61  (
    .C(usrclk),
    .D(mgt_rxdata_8[61]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [61])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_57  (
    .C(usrclk),
    .D(mgt_rxdata_8[57]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [57])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_62  (
    .C(usrclk),
    .D(mgt_rxdata_8[62]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [62])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_58  (
    .C(usrclk),
    .D(mgt_rxdata_8[58]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [58])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_63  (
    .C(usrclk),
    .D(mgt_rxdata_8[63]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [63])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_59  (
    .C(usrclk),
    .D(mgt_rxdata_8[59]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [59])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [2])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [7]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [3])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_34  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [2]),
    .S(\BU2/U0/receiver/recoder/rxd_out_34_or0000 ),
    .Q(xgmii_rxd_4[34])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_41  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [9]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_41_or0000 ),
    .Q(xgmii_rxd_4[41])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_42  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [10]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_41_or0000 ),
    .Q(xgmii_rxd_4[42])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_50  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [18]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_50_or0000 ),
    .Q(xgmii_rxd_4[50])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_49  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [17]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_50_or0000 ),
    .Q(xgmii_rxd_4[49])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_delay_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/code_error_pipe [4]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_delay [0])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_delay_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/code_error_pipe [5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_delay [1])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_delay_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/code_error_pipe [6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_delay [2])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_57  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [25]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_57_or0000 ),
    .Q(xgmii_rxd_4[57])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_delay_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/code_error_pipe [7]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/recoder/code_error_delay [3])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_58  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [26]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_57_or0000 ),
    .Q(xgmii_rxd_4[58])
  );
  FDS   \BU2/U0/receiver/recoder/rxc_out_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [0]),
    .S(\BU2/U0/receiver/recoder/rxd_out_34_or0000 ),
    .Q(xgmii_rxc_5[4])
  );
  FDRS   \BU2/U0/receiver/recoder/rxc_out_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_41_or0000 ),
    .Q(xgmii_rxc_5[5])
  );
  FDRS   \BU2/U0/receiver/recoder/rxc_out_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [2]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_50_or0000 ),
    .Q(xgmii_rxc_5[6])
  );
  FDRS   \BU2/U0/receiver/recoder/rxc_out_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_57_or0000 ),
    .Q(xgmii_rxc_5[7])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_10  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [10]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_10_or0001 ),
    .Q(xgmii_rxd_4[10])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_17  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [17]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_17_or0000 ),
    .Q(xgmii_rxd_4[17])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_18  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [18]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_17_or0000 ),
    .Q(xgmii_rxd_4[18])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_25  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [25]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_25_or0000 ),
    .Q(xgmii_rxd_4[25])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_26  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [26]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_25_or0000 ),
    .Q(xgmii_rxd_4[26])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [2]),
    .S(\BU2/U0/receiver/recoder/rxd_out_2_or0000 ),
    .Q(xgmii_rxd_4[2])
  );
  FDS   \BU2/U0/receiver/recoder/rxc_out_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_half_pipe [0]),
    .S(\BU2/U0/receiver/recoder/rxd_out_2_or0000 ),
    .Q(xgmii_rxc_5[0])
  );
  FDRS   \BU2/U0/receiver/recoder/rxd_out_9  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe [9]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_10_or0001 ),
    .Q(xgmii_rxd_4[9])
  );
  FDRS   \BU2/U0/receiver/recoder/rxc_out_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_half_pipe [1]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_10_or0001 ),
    .Q(xgmii_rxc_5[1])
  );
  FDRS   \BU2/U0/receiver/recoder/rxc_out_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_half_pipe [2]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_17_or0000 ),
    .Q(xgmii_rxc_5[2])
  );
  FDRS   \BU2/U0/receiver/recoder/rxc_out_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_half_pipe [3]),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .S(\BU2/U0/receiver/recoder/rxd_out_25_or0000 ),
    .Q(xgmii_rxc_5[3])
  );
  FDR   \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_cmp_eq0000 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align [0])
  );
  FDR   \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_cmp_eq0000 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/got_align [1])
  );
  FDR   \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_0_mux0002 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error [0])
  );
  FDR   \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error_1_mux0002 ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/deskew_error [1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/state_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/next_state [1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/state_1_627 )
  );
  FD   \BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/align_status  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_NO_SYNC.non_iee_deskew_state/state_1_627 ),
    .Q(NlwRenamedSig_OI_align_status)
  );
  FDR   \BU2/U0/receiver/sync_status  (
    .C(usrclk),
    .D(\BU2/U0/receiver/sync_status_int ),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/receiver/sync_status_626 )
  );
  FDR   \BU2/U0/receiver/sync_ok_3  (
    .C(usrclk),
    .D(mgt_syncok_12[3]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(NlwRenamedSignal_status_vector[5])
  );
  FDR   \BU2/U0/receiver/sync_ok_2  (
    .C(usrclk),
    .D(mgt_syncok_12[2]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(NlwRenamedSignal_status_vector[4])
  );
  FDR   \BU2/U0/receiver/sync_ok_1  (
    .C(usrclk),
    .D(mgt_syncok_12[1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(NlwRenamedSignal_status_vector[3])
  );
  FDR   \BU2/U0/receiver/sync_ok_0  (
    .C(usrclk),
    .D(mgt_syncok_12[0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(NlwRenamedSignal_status_vector[2])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i0  (
    .CI(NlwRenamedSig_OI_mgt_enable_align[0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [0]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [0])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i1  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [1]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [1])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i2  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [1]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [2]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [2])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i3  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [2]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [3]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [3])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i4  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [3]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [4]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [4])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i5  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [4]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [5]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [5])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i6  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [5]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [6]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [6])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i7  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [6]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [7]),
    .LO(\BU2/U0/transmitter/idle_detect_i0/muxcyo [7])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i8  (
    .CI(\BU2/U0/transmitter/idle_detect_i0/muxcyo [7]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i0/comp [8]),
    .LO(\BU2/U0/transmitter/tx_is_idle_comb [0])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i0  (
    .CI(NlwRenamedSig_OI_mgt_enable_align[0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [0]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [0])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i1  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [1]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [1])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i2  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [1]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [2]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [2])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i3  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [2]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [3]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [3])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i4  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [3]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [4]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [4])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i5  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [4]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [5]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [5])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i6  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [5]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [6]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [6])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i7  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [6]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [7]),
    .LO(\BU2/U0/transmitter/idle_detect_i1/muxcyo [7])
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i1/muxcy_i8  (
    .CI(\BU2/U0/transmitter/idle_detect_i1/muxcyo [7]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/idle_detect_i1/comp [8]),
    .LO(\BU2/U0/transmitter/tx_is_idle_comb [1])
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [0]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_590 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_589 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [2]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_588 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [3]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_587 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [4]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_586 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [5]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_585 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [6]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_584 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [7]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_583 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_0_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/state_0_0_582 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_0_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/state_0_1_580 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_0_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/state_0_2_578 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<1> [0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/state_1_0_576 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<1> [1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/state_1_1_574 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<1> [2]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/state_machine/state_1_2_572 )
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [3])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [3]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [5])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [5]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [7])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs_2_xor0000 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [2])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [2]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [4])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [4]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [6])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_8  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [6]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [8])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs_1_xor0000 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_0  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/count [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_1  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/count [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_2  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [2]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/count [2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_3  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [3]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/count [3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_4  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [4]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/count [4])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_2  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [2])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_3  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [2]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [3])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_4  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [3]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [4])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_5  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [4]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [5])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_6  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [5]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [6])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_7  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [6]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [7])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_1  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs_1_xor0000 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/align/prbs [1])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_13  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_13_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[21])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_11  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_11_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[19])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_12  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_12_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[20])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_20  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_20_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[36])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_15  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_15_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[23])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_21  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_21_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[37])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_18  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_18_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[34])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_17  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_17_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[33])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_23  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_23_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[39])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_19  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_19_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[35])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_25  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_25_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[49])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_31  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_31_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[55])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_26  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_26_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[50])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_33  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_33_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[9])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_27  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_27_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[51])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_28  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_28_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[52])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_34  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_34_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[10])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_29  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_29_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[53])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_35  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_35_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[11])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_41  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_41_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[25])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_37  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_37_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[13])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_36  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_36_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[12])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_42  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_42_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[26])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_43  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_43_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[27])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_44  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_44_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[28])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_39  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_39_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[15])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_50  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_50_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[42])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_45  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_45_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[29])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_52  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_52_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[44])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_51  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_51_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[43])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_47  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_47_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[31])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_53  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_53_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[45])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_1_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[1])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_60  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_60_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[60])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_49  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_49_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[41])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_2_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[2])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_55  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_55_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[47])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_3_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[3])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_61  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_61_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[61])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_4_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[4])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_63  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_63_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[63])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_57  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_57_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[57])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_5_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[5])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_58  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_58_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[58])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_59  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_59_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txdata_6[59])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_7_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[7])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_0_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[0])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_2_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[4])
  );
  FDR   \BU2/U0/transmitter/recoder/txd_out_9  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_9_mux0005 ),
    .R(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[17])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_1_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[2])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_3_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[6])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_4_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[1])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_5_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[3])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_6_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[5])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_7_mux0006 ),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(mgt_txcharisk_7[7])
  );
  FDS   \BU2/U0/transmitter/recoder/txd_out_10  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_10_mux0005 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_12_or0000 ),
    .Q(mgt_txdata_6[18])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_0  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [32]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [0])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_1  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [33]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [1])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_2  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [34]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [2])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_3  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [35]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [3])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_4  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [36]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [4])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_5  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [37]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [5])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_6  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [38]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [6])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_7  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [39]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [7])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_8  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [40]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [8])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_9  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [41]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [9])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_10  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [42]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [10])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_11  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [43]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [11])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_12  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [44]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [12])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_13  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [45]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [13])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_14  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [46]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [14])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_15  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [47]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [15])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_16  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [48]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [16])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_17  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [49]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [17])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_18  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [50]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [18])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_19  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [51]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [19])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_20  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [52]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [20])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_21  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [53]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [21])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_22  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [54]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [22])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_23  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [55]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [23])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_24  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [56]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [24])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_25  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [57]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [25])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_26  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [58]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [26])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_27  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [59]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [27])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_28  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [60]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [28])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_29  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [61]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [29])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_30  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [62]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [30])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_31  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [63]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [31])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i0/muxcy_i0  (
    .CI(NlwRenamedSig_OI_mgt_enable_align[0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/seq_detect_i0/comp [0]),
    .LO(\BU2/U0/transmitter/seq_detect_i0/muxcyo [0])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i0/muxcy_i1  (
    .CI(\BU2/U0/transmitter/seq_detect_i0/muxcyo [0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/seq_detect_i0/comp [1]),
    .LO(\BU2/U0/transmitter/seq_detect_i0/muxcyo [1])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i0/muxcy_i2  (
    .CI(\BU2/U0/transmitter/seq_detect_i0/muxcyo [1]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/seq_detect_i0/comp [2]),
    .LO(\BU2/U0/transmitter/tx_is_q_comb [0])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i1/muxcy_i0  (
    .CI(NlwRenamedSig_OI_mgt_enable_align[0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/seq_detect_i1/comp [0]),
    .LO(\BU2/U0/transmitter/seq_detect_i1/muxcyo [0])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i1/muxcy_i1  (
    .CI(\BU2/U0/transmitter/seq_detect_i1/muxcyo [0]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/seq_detect_i1/comp [1]),
    .LO(\BU2/U0/transmitter/seq_detect_i1/muxcyo [1])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i1/muxcy_i2  (
    .CI(\BU2/U0/transmitter/seq_detect_i1/muxcyo [1]),
    .DI(\BU2/mdio_tri ),
    .S(\BU2/U0/transmitter/seq_detect_i1/comp [2]),
    .LO(\BU2/U0/transmitter/tx_is_q_comb [1])
  );
  FDR   \BU2/U0/transmitter/tx_is_q_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_q_comb [1]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tx_is_q [1])
  );
  FDR   \BU2/U0/transmitter/tx_is_q_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_q_comb [0]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tx_is_q [0])
  );
  FDS   \BU2/U0/transmitter/tx_is_idle_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_idle_comb [1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tx_is_idle [1])
  );
  FDS   \BU2/U0/transmitter/tx_is_idle_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_idle_comb [0]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/tx_is_idle [0])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_13  (
    .C(usrclk),
    .D(xgmii_txd_2[13]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [13])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_12  (
    .C(usrclk),
    .D(xgmii_txd_2[12]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [12])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_9  (
    .C(usrclk),
    .D(xgmii_txd_2[9]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [9])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_10  (
    .C(usrclk),
    .D(xgmii_txd_2[10]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [10])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_11  (
    .C(usrclk),
    .D(xgmii_txd_2[11]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [11])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_8  (
    .C(usrclk),
    .D(xgmii_txd_2[8]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [8])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_7  (
    .C(usrclk),
    .D(xgmii_txd_2[7]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [7])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_5  (
    .C(usrclk),
    .D(xgmii_txd_2[5]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [5])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_6  (
    .C(usrclk),
    .D(xgmii_txd_2[6]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [6])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_4  (
    .C(usrclk),
    .D(xgmii_txd_2[4]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [4])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_3  (
    .C(usrclk),
    .D(xgmii_txd_2[3]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [3])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_1  (
    .C(usrclk),
    .D(xgmii_txd_2[1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [1])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_0  (
    .C(usrclk),
    .D(xgmii_txd_2[0]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [0])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_2  (
    .C(usrclk),
    .D(xgmii_txd_2[2]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [2])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_58  (
    .C(usrclk),
    .D(xgmii_txd_2[58]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [58])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_63  (
    .C(usrclk),
    .D(xgmii_txd_2[63]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [63])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_59  (
    .C(usrclk),
    .D(xgmii_txd_2[59]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [59])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_62  (
    .C(usrclk),
    .D(xgmii_txd_2[62]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [62])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_56  (
    .C(usrclk),
    .D(xgmii_txd_2[56]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [56])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_57  (
    .C(usrclk),
    .D(xgmii_txd_2[57]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [57])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_61  (
    .C(usrclk),
    .D(xgmii_txd_2[61]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [61])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_60  (
    .C(usrclk),
    .D(xgmii_txd_2[60]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [60])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_49  (
    .C(usrclk),
    .D(xgmii_txd_2[49]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [49])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_55  (
    .C(usrclk),
    .D(xgmii_txd_2[55]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [55])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_54  (
    .C(usrclk),
    .D(xgmii_txd_2[54]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [54])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_48  (
    .C(usrclk),
    .D(xgmii_txd_2[48]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [48])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_52  (
    .C(usrclk),
    .D(xgmii_txd_2[52]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [52])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_47  (
    .C(usrclk),
    .D(xgmii_txd_2[47]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [47])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_53  (
    .C(usrclk),
    .D(xgmii_txd_2[53]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [53])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_51  (
    .C(usrclk),
    .D(xgmii_txd_2[51]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [51])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_46  (
    .C(usrclk),
    .D(xgmii_txd_2[46]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [46])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_45  (
    .C(usrclk),
    .D(xgmii_txd_2[45]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [45])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_44  (
    .C(usrclk),
    .D(xgmii_txd_2[44]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [44])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_50  (
    .C(usrclk),
    .D(xgmii_txd_2[50]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [50])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_43  (
    .C(usrclk),
    .D(xgmii_txd_2[43]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [43])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_38  (
    .C(usrclk),
    .D(xgmii_txd_2[38]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [38])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_39  (
    .C(usrclk),
    .D(xgmii_txd_2[39]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [39])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_37  (
    .C(usrclk),
    .D(xgmii_txd_2[37]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [37])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_41  (
    .C(usrclk),
    .D(xgmii_txd_2[41]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [41])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_42  (
    .C(usrclk),
    .D(xgmii_txd_2[42]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [42])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_36  (
    .C(usrclk),
    .D(xgmii_txd_2[36]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [36])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_40  (
    .C(usrclk),
    .D(xgmii_txd_2[40]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [40])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_34  (
    .C(usrclk),
    .D(xgmii_txd_2[34]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [34])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_29  (
    .C(usrclk),
    .D(xgmii_txd_2[29]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [29])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_35  (
    .C(usrclk),
    .D(xgmii_txd_2[35]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [35])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_33  (
    .C(usrclk),
    .D(xgmii_txd_2[33]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [33])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_28  (
    .C(usrclk),
    .D(xgmii_txd_2[28]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [28])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_27  (
    .C(usrclk),
    .D(xgmii_txd_2[27]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [27])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_26  (
    .C(usrclk),
    .D(xgmii_txd_2[26]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [26])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_32  (
    .C(usrclk),
    .D(xgmii_txd_2[32]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [32])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_31  (
    .C(usrclk),
    .D(xgmii_txd_2[31]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [31])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_7  (
    .C(usrclk),
    .D(xgmii_txc_3[7]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [7])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_6  (
    .C(usrclk),
    .D(xgmii_txc_3[6]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [6])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_5  (
    .C(usrclk),
    .D(xgmii_txc_3[5]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [5])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_4  (
    .C(usrclk),
    .D(xgmii_txc_3[4]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [4])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_3  (
    .C(usrclk),
    .D(xgmii_txc_3[3]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [3])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_2  (
    .C(usrclk),
    .D(xgmii_txc_3[2]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [2])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_1  (
    .C(usrclk),
    .D(xgmii_txc_3[1]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [1])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_0  (
    .C(usrclk),
    .D(xgmii_txc_3[0]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txc_pipe [0])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_30  (
    .C(usrclk),
    .D(xgmii_txd_2[30]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [30])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_24  (
    .C(usrclk),
    .D(xgmii_txd_2[24]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [24])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_25  (
    .C(usrclk),
    .D(xgmii_txd_2[25]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [25])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_18  (
    .C(usrclk),
    .D(xgmii_txd_2[18]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [18])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_23  (
    .C(usrclk),
    .D(xgmii_txd_2[23]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [23])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_19  (
    .C(usrclk),
    .D(xgmii_txd_2[19]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [19])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_22  (
    .C(usrclk),
    .D(xgmii_txd_2[22]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [22])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_16  (
    .C(usrclk),
    .D(xgmii_txd_2[16]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [16])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_17  (
    .C(usrclk),
    .D(xgmii_txd_2[17]),
    .S(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [17])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_21  (
    .C(usrclk),
    .D(xgmii_txd_2[21]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [21])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_20  (
    .C(usrclk),
    .D(xgmii_txd_2[20]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [20])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_14  (
    .C(usrclk),
    .D(xgmii_txd_2[14]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [14])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_15  (
    .C(usrclk),
    .D(xgmii_txd_2[15]),
    .R(\BU2/U0/usrclk_reset_328 ),
    .Q(\BU2/U0/transmitter/txd_pipe [15])
  );
  VCC   \BU2/XST_VCC  (
    .P(NlwRenamedSig_OI_mgt_enable_align[0])
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/mdio_tri )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
