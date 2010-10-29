////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: L.57
//  \   \         Application: netgen
//  /   /         Filename: xaui.v
// /___/   /\     Timestamp: Tue Oct 13 22:58:51 2009
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog ./tmp/_cg/xaui.ngc ./tmp/_cg/xaui.v 
// Device	: 5vtx240tff1759-2
// Input file	: ./tmp/_cg/xaui.ngc
// Output file	: ./tmp/_cg/xaui.v
// # of Modules	: 1
// Design Name	: xaui
// Xilinx        : /cad_local/xilinx/ise11.3/ISE
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
  wire \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01_1443 ;
  wire \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2_1441 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1_1440 ;
  wire \BU2/U0/rx_local_fault_rstpot12_1439 ;
  wire \BU2/U0/rx_local_fault_rstpot11_1438 ;
  wire \BU2/N339 ;
  wire \BU2/N338 ;
  wire \BU2/N337 ;
  wire \BU2/N336 ;
  wire \BU2/N334 ;
  wire \BU2/N332 ;
  wire \BU2/N330 ;
  wire \BU2/N328 ;
  wire \BU2/U0/transmitter/recoder/N17 ;
  wire \BU2/U0/transmitter/recoder/N18 ;
  wire \BU2/U0/transmitter/recoder/N36 ;
  wire \BU2/U0/transmitter/recoder/N35 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>198_1425 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>198_1424 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>198_1423 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>198_1422 ;
  wire \BU2/N182 ;
  wire \BU2/U0/transmitter/recoder/txd_out_38_mux000657 ;
  wire \BU2/U0/transmitter/recoder/txd_out_14_mux000657 ;
  wire \BU2/U0/transmitter/recoder/N46 ;
  wire \BU2/U0/transmitter/recoder/N43 ;
  wire \BU2/U0/transmitter/recoder/N23 ;
  wire \BU2/U0/transmitter/recoder/N22 ;
  wire \BU2/U0/transmitter/recoder/N32 ;
  wire \BU2/U0/transmitter/recoder/N31 ;
  wire \BU2/N326 ;
  wire \BU2/N324 ;
  wire \BU2/N322 ;
  wire \BU2/N320 ;
  wire \BU2/N318 ;
  wire \BU2/N316 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>76_1406 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>175_1405 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>76_1404 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>175_1403 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>76_1402 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>175_1401 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>76_1400 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>175_1399 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>71_1398 ;
  wire \BU2/N312 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>71_1396 ;
  wire \BU2/N310 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>71_1394 ;
  wire \BU2/N308 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>71_1392 ;
  wire \BU2/N306 ;
  wire \BU2/N304 ;
  wire \BU2/N302 ;
  wire \BU2/N300 ;
  wire \BU2/N298 ;
  wire \BU2/N296 ;
  wire \BU2/N294 ;
  wire \BU2/N292 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>129_1383 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>129_1382 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>129_1381 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>129_1380 ;
  wire \BU2/N290 ;
  wire \BU2/N288 ;
  wire \BU2/N286 ;
  wire \BU2/N284 ;
  wire \BU2/N278 ;
  wire \BU2/N276 ;
  wire \BU2/N274 ;
  wire \BU2/N272 ;
  wire \BU2/N266 ;
  wire \BU2/N264 ;
  wire \BU2/N262 ;
  wire \BU2/N260 ;
  wire \BU2/N258 ;
  wire \BU2/N254 ;
  wire \BU2/N252 ;
  wire \BU2/N250 ;
  wire \BU2/N248 ;
  wire \BU2/N242 ;
  wire \BU2/N240 ;
  wire \BU2/N238 ;
  wire \BU2/N236 ;
  wire \BU2/N230 ;
  wire \BU2/N228 ;
  wire \BU2/N226 ;
  wire \BU2/N224 ;
  wire \BU2/N218 ;
  wire \BU2/N216 ;
  wire \BU2/N214 ;
  wire \BU2/N212 ;
  wire \BU2/N206 ;
  wire \BU2/N204 ;
  wire \BU2/N202 ;
  wire \BU2/N200 ;
  wire \BU2/N194 ;
  wire \BU2/N192 ;
  wire \BU2/N190 ;
  wire \BU2/N188 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux0000103_1340 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux0000103_1339 ;
  wire \BU2/N186 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or0000101_1337 ;
  wire \BU2/N179 ;
  wire \BU2/U0/receiver/recoder/rxd_out_40_rstpot1_1335 ;
  wire \BU2/U0/receiver/recoder/rxd_out_48_rstpot1_1334 ;
  wire \BU2/U0/receiver/recoder/rxd_out_16_rstpot1_1333 ;
  wire \BU2/U0/receiver/recoder/rxd_out_8_rstpot1_1332 ;
  wire \BU2/U0/transmitter/align/extra_a_rstpot1_1331 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot_1330 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot_1329 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot_1328 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot_1327 ;
  wire \BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot_1326 ;
  wire \BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot_1325 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/enable_align_rstpot_1324 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/enable_align_rstpot_1323 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/enable_align_rstpot_1322 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/enable_align_rstpot_1321 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot_1320 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot_1319 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot_1318 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot_1317 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot_1315 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot_1313 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot_1311 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot_1309 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot_1307 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot_1305 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot_1303 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot_1301 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot_1299 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot_1297 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot_1295 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot_1293 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot_1292 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot_1291 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot_1290 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot_1289 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot_1287 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot_1285 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot_1283 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot_1281 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot_1279 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot_1277 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot_1275 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot_1273 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot_1271 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot_1269 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot_1267 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot_1265 ;
  wire \BU2/U0/clear_aligned_edge_rstpot ;
  wire \BU2/U0/clear_local_fault_edge_1263 ;
  wire \BU2/U0/clear_local_fault_edge_rstpot ;
  wire \BU2/U0/usrclk_reset_rstpot_1261 ;
  wire \BU2/U0/usrclk_reset_pipe_1260 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/enchansync_rstpot_1259 ;
  wire \BU2/U0/tx_local_fault_rstpot1_1258 ;
  wire \BU2/U0/rx_local_fault_rstpot1 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1_1256 ;
  wire \BU2/U0/aligned_sticky_rstpot_1255 ;
  wire \BU2/U0/clear_aligned_edge_1254 ;
  wire \BU2/U0/receiver/recoder/rxd_out_32_rstpot_1253 ;
  wire \BU2/U0/receiver/recoder/rxd_out_33_rstpot_1252 ;
  wire \BU2/U0/receiver/recoder/rxd_out_0_rstpot_1251 ;
  wire \BU2/U0/receiver/recoder/rxd_out_1_rstpot_1250 ;
  wire \BU2/U0/transmitter/state_machine/next_ifg_is_a_1249 ;
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
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<5>11 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>11 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or000039_1168 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or000024 ;
  wire \BU2/U0/receiver/recoder/error_lane_6_or00000_1166 ;
  wire \BU2/U0/transmitter/align/N5 ;
  wire \BU2/U0/transmitter/align/extra_a_1163 ;
  wire \BU2/N164 ;
  wire \BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_1159 ;
  wire \BU2/N158 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>197_1157 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>398_1156 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>383_1155 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>244_1154 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>335_1153 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>297_1152 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>232_1151 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>169_1150 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>133_1149 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>62_1148 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>197_1147 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>398_1146 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>383_1145 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>244_1144 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>335_1143 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>297_1142 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>232_1141 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>169_1140 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>133_1139 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>62_1138 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>197_1137 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>398_1136 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>383_1135 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>244_1134 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>335_1133 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>297_1132 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>232_1131 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>169_1130 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>133_1129 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>62_1128 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>197_1127 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>398_1126 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>383_1125 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>244_1124 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>335_1123 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>297_1122 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>232_1121 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>169_1120 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>133_1119 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>62_1118 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or0000145_1117 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or000070_1116 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or000048_1115 ;
  wire \BU2/U0/receiver/recoder/error_lane_5_or000023_1114 ;
  wire \BU2/U0/receiver/recoder/error_lane_1_or0000103_1113 ;
  wire \BU2/U0/receiver/recoder/error_lane_1_or000080_1112 ;
  wire \BU2/U0/receiver/recoder/error_lane_1_or000018_1111 ;
  wire \BU2/U0/receiver/recoder/error_lane_4_or000073_1110 ;
  wire \BU2/U0/receiver/recoder/error_lane_4_or000048_1109 ;
  wire \BU2/U0/receiver/recoder/error_lane_4_or000014_1108 ;
  wire \BU2/U0/receiver/recoder/error_lane_7_or000013_1107 ;
  wire \BU2/U0/receiver/recoder/error_lane_2_or000081_1106 ;
  wire \BU2/U0/receiver/recoder/error_lane_2_or000056_1105 ;
  wire \BU2/U0/receiver/recoder/error_lane_2_or000010_1104 ;
  wire \BU2/N156 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>297_1102 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>249_1101 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>214_1100 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>192_1099 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>130_1098 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>63_1097 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>297_1096 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>249_1095 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>214_1094 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>192_1093 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>130_1092 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>63_1091 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>297_1090 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>249_1089 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>214_1088 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>192_1087 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>130_1086 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>63_1085 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>297_1084 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>249_1083 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>214_1082 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>192_1081 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>130_1080 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>63_1079 ;
  wire \BU2/N154 ;
  wire \BU2/N153 ;
  wire \BU2/U0/receiver/recoder/N35 ;
  wire \BU2/N151 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_1074 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_1069 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000097_1054 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000072_1053 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000040_1052 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000035_1051 ;
  wire \BU2/U0/transmitter/is_terminate_0_mux000010_1050 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000097_1049 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000072_1048 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000040_1047 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000035_1046 ;
  wire \BU2/U0/transmitter/is_terminate_1_mux000010_1045 ;
  wire \BU2/N149 ;
  wire \BU2/N147 ;
  wire \BU2/N145 ;
  wire \BU2/N143 ;
  wire \BU2/N141 ;
  wire \BU2/N139 ;
  wire \BU2/N137 ;
  wire \BU2/N135 ;
  wire \BU2/U0/receiver/recoder/mux0003_or0000_1036 ;
  wire \BU2/N133 ;
  wire \BU2/U0/receiver/recoder/mux0007_or0000_1027 ;
  wire \BU2/N131 ;
  wire \BU2/U0/receiver/recoder/mux0011_or0000_1019 ;
  wire \BU2/N129 ;
  wire \BU2/U0/receiver/recoder/mux0015_or0000_1011 ;
  wire \BU2/N127 ;
  wire \BU2/U0/receiver/recoder/mux0023_or0000 ;
  wire \BU2/U0/receiver/recoder/N18 ;
  wire \BU2/U0/receiver/recoder/mux0019_or0000 ;
  wire \BU2/U0/receiver/recoder/N17 ;
  wire \BU2/U0/receiver/recoder/mux0027_or0000 ;
  wire \BU2/U0/receiver/recoder/N16 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N15 ;
  wire \BU2/N125 ;
  wire \BU2/N124 ;
  wire \BU2/N123 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N15 ;
  wire \BU2/N121 ;
  wire \BU2/N120 ;
  wire \BU2/N119 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N15 ;
  wire \BU2/N117 ;
  wire \BU2/N116 ;
  wire \BU2/N115 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N15 ;
  wire \BU2/N113 ;
  wire \BU2/N112 ;
  wire \BU2/N111 ;
  wire \BU2/N107 ;
  wire \BU2/N106 ;
  wire \BU2/N104 ;
  wire \BU2/N103 ;
  wire \BU2/N102 ;
  wire \BU2/N101 ;
  wire \BU2/U0/transmitter/recoder/txd_out_14_mux000679 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ;
  wire \BU2/N79 ;
  wire \BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ;
  wire \BU2/N64 ;
  wire \BU2/N63 ;
  wire \BU2/N61 ;
  wire \BU2/N60 ;
  wire \BU2/N58 ;
  wire \BU2/N57 ;
  wire \BU2/N55 ;
  wire \BU2/N54 ;
  wire \BU2/N52 ;
  wire \BU2/N51 ;
  wire \BU2/N49 ;
  wire \BU2/N48 ;
  wire \BU2/N46 ;
  wire \BU2/N45 ;
  wire \BU2/N43 ;
  wire \BU2/N42 ;
  wire \BU2/N40 ;
  wire \BU2/N38 ;
  wire \BU2/N36 ;
  wire \BU2/N34 ;
  wire \BU2/N32 ;
  wire \BU2/N30 ;
  wire \BU2/N28 ;
  wire \BU2/N26 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N15 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N8 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N13 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N10 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N14 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N9 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N7 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/N12 ;
  wire \BU2/U0/transmitter/recoder/txd_out_11_or0000 ;
  wire \BU2/N24 ;
  wire \BU2/N22 ;
  wire \BU2/N20 ;
  wire \BU2/N18 ;
  wire \BU2/U0/receiver/recoder/N38 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N46 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N46 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N46 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N46 ;
  wire \BU2/N16 ;
  wire \BU2/N14 ;
  wire \BU2/N12 ;
  wire \BU2/N10 ;
  wire \BU2/N8 ;
  wire \BU2/N6 ;
  wire \BU2/N4 ;
  wire \BU2/N2 ;
  wire \BU2/U0/transmitter/recoder/N24 ;
  wire \BU2/U0/last_value_920 ;
  wire \BU2/U0/clear_local_fault_919 ;
  wire \BU2/U0/last_value0_918 ;
  wire \BU2/U0/clear_aligned_917 ;
  wire \BU2/U0/type_sel_reg_done_916 ;
  wire \BU2/U0/type_sel_reg_done_inv ;
  wire \BU2/U0/receiver/recoder/rxd_out_11_mux0002 ;
  wire \BU2/U0/receiver/recoder/mux0032_and0000_911 ;
  wire \BU2/U0/receiver/recoder/mux0033_and0000_909 ;
  wire \BU2/U0/receiver/recoder/mux0034_and0000_907 ;
  wire \BU2/U0/receiver/recoder/mux0035_and0000_905 ;
  wire \BU2/U0/receiver/recoder/mux0036_and0000_904 ;
  wire \BU2/U0/receiver/recoder/mux0037_and0000_903 ;
  wire \BU2/U0/receiver/recoder/mux0038_and0000_902 ;
  wire \BU2/U0/receiver/recoder/mux0039_and0000_901 ;
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
  wire \BU2/U0/receiver/recoder/rxd_out_56_mux0002_850 ;
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
  wire \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_cmp_eq0000 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_cmp_eq0000 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux0002 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux0002 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/state_1_0_721 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ;
  wire \BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><2> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><3> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><4> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last_700 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><2> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><3> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><4> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last_683 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><2> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><3> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><4> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last_666 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><2> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><3> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><4> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ;
  wire \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last_649 ;
  wire \BU2/U0/receiver/sync_status_643 ;
  wire \BU2/U0/receiver/sync_status_int ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_607 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_606 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_605 ;
  wire \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_604 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_603 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_602 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_601 ;
  wire \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_600 ;
  wire \BU2/U0/transmitter/state_machine/state_0_0_599 ;
  wire \BU2/U0/transmitter/state_machine/state_0_1_597 ;
  wire \BU2/U0/transmitter/state_machine/state_0_2_595 ;
  wire \BU2/U0/transmitter/state_machine/state_1_0_593 ;
  wire \BU2/U0/transmitter/state_machine/state_1_1_591 ;
  wire \BU2/U0/transmitter/state_machine/state_1_2_589 ;
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
  wire \BU2/U0/usrclk_reset_345 ;
  wire \BU2/N1 ;
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
  wire [3 : 0] mgt_enable_align_12;
  wire [3 : 0] mgt_syncok_13;
  wire [3 : 0] mgt_rxlock_14;
  wire [3 : 0] mgt_tx_reset_15;
  wire [3 : 0] mgt_rx_reset_16;
  wire [3 : 0] signal_detect_17;
  wire [6 : 2] configuration_vector_18;
  wire [1 : 0] NlwRenamedSignal_configuration_vector;
  wire [1 : 0] \BU2/U0/transmitter/is_terminate ;
  wire [0 : 0] \BU2/U0/transmitter/a_due ;
  wire [1 : 0] \BU2/U0/transmitter/tx_code_a ;
  wire [31 : 0] \BU2/U0/receiver/recoder/rxd_half_pipe ;
  wire [1 : 1] \BU2/U0/type_sel_reg ;
  wire [7 : 0] \BU2/U0/receiver/recoder/lane_terminate ;
  wire [7 : 0] \BU2/U0/receiver/recoder/error_lane ;
  wire [7 : 0] \BU2/U0/receiver/recoder/rxc_pipe ;
  wire [63 : 0] \BU2/U0/receiver/recoder/rxd_pipe ;
  wire [7 : 0] \BU2/U0/receiver/recoder/code_error_pipe ;
  wire [7 : 0] \BU2/U0/receiver/code_error ;
  wire [3 : 0] \BU2/U0/receiver/recoder/lane_term_pipe ;
  wire [3 : 0] \BU2/U0/receiver/recoder/code_error_delay ;
  wire [3 : 0] \BU2/U0/receiver/recoder/rxc_half_pipe ;
  wire [1 : 0] \BU2/U0/receiver/G_SYNC.deskew_state/got_align ;
  wire [1 : 0] \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error ;
  wire [2 : 0] \BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> ;
  wire [3 : 0] \BU2/U0/signal_detect_int ;
  wire [3 : 0] \BU2/U0/receiver/sync_ok_int ;
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
    mgt_rxlock_14[3] = mgt_rxlock[3],
    mgt_rxlock_14[2] = mgt_rxlock[2],
    mgt_rxlock_14[1] = mgt_rxlock[1],
    mgt_rxlock_14[0] = mgt_rxlock[0],
    mgt_tx_reset_15[3] = mgt_tx_reset[3],
    mgt_tx_reset_15[2] = mgt_tx_reset[2],
    mgt_tx_reset_15[1] = mgt_tx_reset[1],
    mgt_tx_reset_15[0] = mgt_tx_reset[0],
    mgt_txcharisk[7] = mgt_txcharisk_7[7],
    mgt_txcharisk[6] = mgt_txcharisk_7[6],
    mgt_txcharisk[5] = mgt_txcharisk_7[5],
    mgt_txcharisk[4] = mgt_txcharisk_7[4],
    mgt_txcharisk[3] = mgt_txcharisk_7[3],
    mgt_txcharisk[2] = mgt_txcharisk_7[2],
    mgt_txcharisk[1] = mgt_txcharisk_7[1],
    mgt_txcharisk[0] = mgt_txcharisk_7[0],
    mgt_syncok_13[3] = mgt_syncok[3],
    mgt_syncok_13[2] = mgt_syncok[2],
    mgt_syncok_13[1] = mgt_syncok[1],
    mgt_syncok_13[0] = mgt_syncok[0],
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
    mgt_enable_align[3] = mgt_enable_align_12[3],
    mgt_enable_align[2] = mgt_enable_align_12[2],
    mgt_enable_align[1] = mgt_enable_align_12[1],
    mgt_enable_align[0] = mgt_enable_align_12[0],
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
    configuration_vector_18[6] = configuration_vector[6],
    configuration_vector_18[5] = configuration_vector[5],
    configuration_vector_18[4] = configuration_vector[4],
    configuration_vector_18[3] = configuration_vector[3],
    configuration_vector_18[2] = configuration_vector[2],
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
    mgt_rx_reset_16[3] = mgt_rx_reset[3],
    mgt_rx_reset_16[2] = mgt_rx_reset[2],
    mgt_rx_reset_16[1] = mgt_rx_reset[1],
    mgt_rx_reset_16[0] = mgt_rx_reset[0],
    signal_detect_17[3] = signal_detect[3],
    signal_detect_17[2] = signal_detect[2],
    signal_detect_17[1] = signal_detect[1],
    signal_detect_17[0] = signal_detect[0];
  VCC   VCC_0 (
    .P(N1)
  );
  GND   GND_1 (
    .G(N0)
  );
  MUXF7   \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0_f7  (
    .I0(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01_1443 ),
    .I1(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0 ),
    .S(\BU2/U0/transmitter/tx_is_q [1]),
    .O(\BU2/N316 )
  );
  LUT6 #(
    .INIT ( 64'h2020202020A02020 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW02  (
    .I0(\BU2/U0/transmitter/tx_is_idle [1]),
    .I1(\BU2/U0/transmitter/align/count [2]),
    .I2(\BU2/U0/transmitter/align/N5 ),
    .I3(\BU2/U0/transmitter/align/count [0]),
    .I4(\BU2/U0/transmitter/align/extra_a_1163 ),
    .I5(\BU2/U0/transmitter/align/count [1]),
    .O(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01_1443 )
  );
  LUT5 #(
    .INIT ( 32'h0400FF00 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW01  (
    .I0(\BU2/U0/transmitter/align/count [1]),
    .I1(\BU2/U0/transmitter/align/extra_a_1163 ),
    .I2(\BU2/U0/transmitter/align/count [0]),
    .I3(\BU2/U0/transmitter/align/N5 ),
    .I4(\BU2/U0/transmitter/align/count [2]),
    .O(\BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW0 )
  );
  MUXF7   \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot_f7  (
    .I0(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2_1441 ),
    .I1(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1_1440 ),
    .S(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .O(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot )
  );
  LUT6 #(
    .INIT ( 64'h88DD80D088DD8ADF ))
  \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1249 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .O(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot2_1441 )
  );
  LUT4 #(
    .INIT ( 16'hC8CD ))
  \BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I1(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1249 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .O(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot1_1440 )
  );
  MUXF7   \BU2/U0/rx_local_fault_rstpot1_f7  (
    .I0(\BU2/U0/rx_local_fault_rstpot12_1439 ),
    .I1(\BU2/U0/rx_local_fault_rstpot11_1438 ),
    .S(\NlwRenamedSig_OI_status_vector[1] ),
    .O(\BU2/U0/rx_local_fault_rstpot1 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFEFF ))
  \BU2/U0/rx_local_fault_rstpot12  (
    .I0(mgt_rx_reset_16[0]),
    .I1(mgt_rx_reset_16[2]),
    .I2(mgt_rx_reset_16[3]),
    .I3(NlwRenamedSig_OI_align_status),
    .I4(mgt_rx_reset_16[1]),
    .O(\BU2/U0/rx_local_fault_rstpot12_1439 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFEFFFFFF ))
  \BU2/U0/rx_local_fault_rstpot11  (
    .I0(mgt_rx_reset_16[0]),
    .I1(mgt_rx_reset_16[1]),
    .I2(mgt_rx_reset_16[3]),
    .I3(\BU2/U0/clear_local_fault_edge_1263 ),
    .I4(NlwRenamedSig_OI_align_status),
    .I5(mgt_rx_reset_16[2]),
    .O(\BU2/U0/rx_local_fault_rstpot11_1438 )
  );
  INV   \BU2/U0/type_sel_reg_done_inv1_INV_0  (
    .I(\BU2/U0/type_sel_reg_done_916 ),
    .O(\BU2/U0/type_sel_reg_done_inv )
  );
  LUT6 #(
    .INIT ( 64'hF111FB11FFFFFB11 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>_G  (
    .I0(\BU2/U0/transmitter/tx_is_q [0]),
    .I1(\BU2/U0/transmitter/tx_is_idle [0]),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .I3(\BU2/U0/transmitter/tx_code_a [1]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/k_r_prbs_i/prbs [8]),
    .O(\BU2/N339 )
  );
  LUT5 #(
    .INIT ( 32'h111F1110 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>_F  (
    .I0(\BU2/U0/transmitter/tx_is_q [0]),
    .I1(\BU2/U0/transmitter/tx_is_idle [0]),
    .I2(\BU2/U0/transmitter/a_due [0]),
    .I3(\BU2/U0/transmitter/k_r_prbs_i/prbs [8]),
    .I4(\BU2/N182 ),
    .O(\BU2/N338 )
  );
  MUXF7   \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>  (
    .I0(\BU2/N338 ),
    .I1(\BU2/N339 ),
    .S(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .O(\BU2/U0/transmitter/state_machine/next_state<0> [0])
  );
  LUT6 #(
    .INIT ( 64'h1F1F111BFF1FFF1B ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<0>_G  (
    .I0(\BU2/U0/transmitter/tx_is_q [1]),
    .I1(\BU2/U0/transmitter/tx_is_idle [1]),
    .I2(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .I3(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .I5(\BU2/U0/transmitter/k_r_prbs_i/prbs [7]),
    .O(\BU2/N337 )
  );
  LUT6 #(
    .INIT ( 64'h022202220222FFFF ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<0>_F  (
    .I0(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I1(\BU2/U0/transmitter/k_r_prbs_i/prbs [7]),
    .I2(\BU2/N190 ),
    .I3(\BU2/U0/transmitter/align/N5 ),
    .I4(\BU2/U0/transmitter/tx_is_q [1]),
    .I5(\BU2/U0/transmitter/tx_is_idle [1]),
    .O(\BU2/N336 )
  );
  MUXF7   \BU2/U0/transmitter/state_machine/next_state_1_mux0002<0>  (
    .I0(\BU2/N336 ),
    .I1(\BU2/N337 ),
    .S(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .O(\BU2/U0/transmitter/state_machine/next_state<1> [0])
  );
  LUT6 #(
    .INIT ( 64'h0200000002020202 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000641  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(configuration_vector_18[6]),
    .I4(configuration_vector_18[5]),
    .I5(configuration_vector_18[4]),
    .O(\BU2/U0/transmitter/recoder/N36 )
  );
  LUT6 #(
    .INIT ( 64'h0200000002020202 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000631  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(configuration_vector_18[6]),
    .I4(configuration_vector_18[5]),
    .I5(configuration_vector_18[4]),
    .O(\BU2/U0/transmitter/recoder/N35 )
  );
  LUT6 #(
    .INIT ( 64'hAEAEAEAEAAAEAAAA ))
  \BU2/U0/transmitter/recoder/txc_out_0_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/N17 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_607 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_0_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hAEAEAEAEAAAEAAAA ))
  \BU2/U0/transmitter/recoder/txc_out_4_mux00061  (
    .I0(\BU2/U0/transmitter/recoder/N18 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_603 ),
    .I5(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_4_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFF02FF0AFF22FFAA ))
  \BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I5(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1_1256 )
  );
  LUT6 #(
    .INIT ( 64'hFDDFFCCF20023003 ))
  \BU2/U0/transmitter/align/count_mux0000<2>1  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/tx_code_a [0]),
    .I2(\BU2/U0/transmitter/align/count [2]),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I5(\BU2/U0/transmitter/align/prbs [3]),
    .O(\BU2/U0/transmitter/align/count_mux0000 [2])
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_14_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [14]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_14_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_22_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [22]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_22_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_30_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [30]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_30_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_38_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [6]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_38_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_46_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [14]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_46_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_54_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [22]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_54_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_62_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [30]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_62_mux000681 )
  );
  LUT6 #(
    .INIT ( 64'hC040E060C040C040 ))
  \BU2/U0/transmitter/recoder/txd_out_6_mux0006811  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [6]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
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
    .O(\BU2/U0/receiver/recoder/rxd_out_33_rstpot_1252 )
  );
  LUT6 #(
    .INIT ( 64'h22F2F202FFFFFF0F ))
  \BU2/U0/transmitter/recoder/txd_out_11_mux000632  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(configuration_vector_18[4]),
    .I3(configuration_vector_18[5]),
    .I4(configuration_vector_18[6]),
    .I5(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/N17 )
  );
  LUT6 #(
    .INIT ( 64'h22F2F202FFFFFF0F ))
  \BU2/U0/transmitter/recoder/txd_out_35_mux000622  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(configuration_vector_18[4]),
    .I3(configuration_vector_18[5]),
    .I4(configuration_vector_18[6]),
    .I5(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/N18 )
  );
  LUT6 #(
    .INIT ( 64'hF3FBF0FAC040F050 ))
  \BU2/U0/transmitter/align/count_mux0000<0>1  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I2(\BU2/U0/transmitter/align/count [0]),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I5(\BU2/U0/transmitter/align/prbs [1]),
    .O(\BU2/U0/transmitter/align/count_mux0000 [0])
  );
  LUT6 #(
    .INIT ( 64'h20EF20EFAAAA20EF ))
  \BU2/U0/transmitter/align/count_mux0000<1>1  (
    .I0(\BU2/U0/transmitter/align/prbs [2]),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/align/count_mux0000 [1])
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_16_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [16]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_16_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_24_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [24]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_24_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000612  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [0]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_32_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_40_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [8]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_40_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000612  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [0]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_0_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_48_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [16]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_48_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_56_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [24]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_56_mux00061 )
  );
  LUT6 #(
    .INIT ( 64'h4000501040004000 ))
  \BU2/U0/transmitter/recoder/txd_out_8_mux000611  (
    .I0(\BU2/U0/transmitter/recoder/txd_out_11_or0000 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [8]),
    .I4(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/recoder/txd_out_8_mux00061 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_17_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [17]),
    .O(\BU2/U0/transmitter/recoder/txd_out_17_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_1_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [1]),
    .O(\BU2/U0/transmitter/recoder/txd_out_1_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_25_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [25]),
    .O(\BU2/U0/transmitter/recoder/txd_out_25_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_33_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [1]),
    .O(\BU2/U0/transmitter/recoder/txd_out_33_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_41_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [9]),
    .O(\BU2/U0/transmitter/recoder/txd_out_41_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_49_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [17]),
    .O(\BU2/U0/transmitter/recoder/txd_out_49_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_57_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [25]),
    .O(\BU2/U0/transmitter/recoder/txd_out_57_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'h88A80020 ))
  \BU2/U0/transmitter/recoder/txd_out_9_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [9]),
    .O(\BU2/U0/transmitter/recoder/txd_out_9_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_10_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [10]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_10_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_12_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [12]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_12_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_13_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [13]),
    .O(\BU2/U0/transmitter/recoder/txd_out_13_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_15_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [15]),
    .O(\BU2/U0/transmitter/recoder/txd_out_15_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_18_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [18]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_18_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_20_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [20]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_20_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_21_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [21]),
    .O(\BU2/U0/transmitter/recoder/txd_out_21_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_23_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [23]),
    .O(\BU2/U0/transmitter/recoder/txd_out_23_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_26_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [26]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_26_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_28_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [28]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_28_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_29_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [29]),
    .O(\BU2/U0/transmitter/recoder/txd_out_29_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_2_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [2]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_2_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_31_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [31]),
    .O(\BU2/U0/transmitter/recoder/txd_out_31_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_34_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [2]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_34_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_36_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [4]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_36_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_37_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [5]),
    .O(\BU2/U0/transmitter/recoder/txd_out_37_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_39_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [7]),
    .O(\BU2/U0/transmitter/recoder/txd_out_39_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_42_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [10]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_42_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_44_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [12]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_44_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_45_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [13]),
    .O(\BU2/U0/transmitter/recoder/txd_out_45_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_47_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [15]),
    .O(\BU2/U0/transmitter/recoder/txd_out_47_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_4_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [4]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_4_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_50_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [18]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_50_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_52_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [20]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_52_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_53_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [21]),
    .O(\BU2/U0/transmitter/recoder/txd_out_53_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_55_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [23]),
    .O(\BU2/U0/transmitter/recoder/txd_out_55_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_58_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [26]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_58_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_5_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [5]),
    .O(\BU2/U0/transmitter/recoder/txd_out_5_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hDDD8FFFF ))
  \BU2/U0/transmitter/recoder/txd_out_60_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [28]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I4(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_60_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hEFED6765 ))
  \BU2/U0/transmitter/recoder/txd_out_61_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [29]),
    .O(\BU2/U0/transmitter/recoder/txd_out_61_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_63_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [31]),
    .O(\BU2/U0/transmitter/recoder/txd_out_63_mux0005 )
  );
  LUT5 #(
    .INIT ( 32'hABA92321 ))
  \BU2/U0/transmitter/recoder/txd_out_7_mux00051  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [7]),
    .O(\BU2/U0/transmitter/recoder/txd_out_7_mux0005 )
  );
  LUT4 #(
    .INIT ( 16'h22F2 ))
  \BU2/U0/transmitter/align/prbs_1_not00001  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/align/prbs_1_not0000 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/enable_align_rstpot  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/enable_align_rstpot_1324 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/enable_align_rstpot  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/enable_align_rstpot_1323 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/enable_align_rstpot  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/enable_align_rstpot_1322 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/enable_align_rstpot  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/enable_align_rstpot_1321 )
  );
  LUT6 #(
    .INIT ( 64'h8200820082000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>220  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last_700 ),
    .I2(\BU2/U0/signal_detect_int [0]),
    .I3(mgt_rxlock_14[0]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>198_1425 ),
    .I5(\BU2/N334 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><1> )
  );
  LUT5 #(
    .INIT ( 32'h44444454 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>220_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>71_1398 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>129_1383 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .O(\BU2/N334 )
  );
  LUT6 #(
    .INIT ( 64'h8200820082000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>220  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last_683 ),
    .I2(\BU2/U0/signal_detect_int [1]),
    .I3(mgt_rxlock_14[1]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>198_1424 ),
    .I5(\BU2/N332 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><1> )
  );
  LUT5 #(
    .INIT ( 32'h44444454 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>220_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>71_1396 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>129_1382 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .O(\BU2/N332 )
  );
  LUT6 #(
    .INIT ( 64'h8200820082000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>220  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last_666 ),
    .I2(\BU2/U0/signal_detect_int [2]),
    .I3(mgt_rxlock_14[2]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>198_1423 ),
    .I5(\BU2/N330 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><1> )
  );
  LUT5 #(
    .INIT ( 32'h44444454 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>220_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>71_1394 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>129_1381 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .O(\BU2/N330 )
  );
  LUT6 #(
    .INIT ( 64'h8200820082000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>220  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last_649 ),
    .I2(\BU2/U0/signal_detect_int [3]),
    .I3(mgt_rxlock_14[3]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>198_1422 ),
    .I5(\BU2/N328 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><1> )
  );
  LUT5 #(
    .INIT ( 32'h44444454 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>220_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>71_1392 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>129_1380 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .O(\BU2/N328 )
  );
  LUT6 #(
    .INIT ( 64'h2022202030333030 ))
  \BU2/U0/transmitter/align/extra_a_rstpot1  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/usrclk_reset_345 ),
    .I2(\BU2/U0/transmitter/align/extra_a_1163 ),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I4(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I5(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .O(\BU2/U0/transmitter/align/extra_a_rstpot1_1331 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_16_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/mux0011_or0000_1019 ),
    .I2(\BU2/U0/usrclk_reset_345 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [2]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [16]),
    .O(\BU2/U0/receiver/recoder/rxd_out_16_rstpot1_1333 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_8_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/mux0007_or0000_1027 ),
    .I2(\BU2/U0/usrclk_reset_345 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [1]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [8]),
    .O(\BU2/U0/receiver/recoder/rxd_out_8_rstpot1_1332 )
  );
  LUT6 #(
    .INIT ( 64'h80088008C00C8008 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>314  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>297_1102 ),
    .I1(mgt_rxlock_14[0]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last_700 ),
    .I3(\BU2/U0/signal_detect_int [0]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>249_1101 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><2> )
  );
  LUT6 #(
    .INIT ( 64'h80088008C00C8008 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>314  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>297_1096 ),
    .I1(mgt_rxlock_14[1]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last_683 ),
    .I3(\BU2/U0/signal_detect_int [1]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>249_1095 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><2> )
  );
  LUT6 #(
    .INIT ( 64'h80088008C00C8008 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>314  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>297_1090 ),
    .I1(mgt_rxlock_14[2]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last_666 ),
    .I3(\BU2/U0/signal_detect_int [2]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>249_1089 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><2> )
  );
  LUT6 #(
    .INIT ( 64'h80088008C00C8008 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>314  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>297_1084 ),
    .I1(mgt_rxlock_14[3]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last_649 ),
    .I3(\BU2/U0/signal_detect_int [3]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>249_1083 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><2> )
  );
  LUT6 #(
    .INIT ( 64'hC000C000C0008000 ))
  \BU2/U0/receiver/sync_status_int_cmp_eq00001  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I1(\BU2/U0/receiver/sync_ok_int [2]),
    .I2(\BU2/U0/receiver/sync_ok_int [3]),
    .I3(\BU2/U0/receiver/sync_ok_int [1]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/U0/receiver/sync_status_int )
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
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_1_mux00061  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/recoder/N46 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_606 ),
    .I5(\BU2/U0/transmitter/recoder/N36 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_1_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_2_mux00061  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/recoder/N46 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_605 ),
    .I5(\BU2/U0/transmitter/recoder/N36 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_2_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_3_mux00061  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/recoder/N46 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_604 ),
    .I5(\BU2/U0/transmitter/recoder/N36 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_3_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_5_mux00061  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/recoder/N43 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_602 ),
    .I5(\BU2/U0/transmitter/recoder/N35 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_5_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_6_mux00061  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/recoder/N43 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_601 ),
    .I5(\BU2/U0/transmitter/recoder/N35 ),
    .O(\BU2/U0/transmitter/recoder/txc_out_6_mux0006 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFD28FD28FD28 ))
  \BU2/U0/transmitter/recoder/txc_out_7_mux00061  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/recoder/N43 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_600 ),
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
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>198  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>198_1425 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>198  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>198_1424 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>198  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>198_1423 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>198  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>198_1422 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/recoder/rxd_out_56_mux0002_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [3]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [28]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [27]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [26]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [25]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [24]),
    .O(\BU2/N151 )
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
    .I0(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .I4(\BU2/U0/transmitter/tx_is_q [0]),
    .I5(\BU2/U0/transmitter/tx_is_idle [0]),
    .O(\BU2/N182 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAA8A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>76  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>76_1406 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAA8A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>76  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>76_1404 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAA8A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>76  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>76_1402 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAA8A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>76  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>76_1400 )
  );
  LUT6 #(
    .INIT ( 64'h8888888888F88888 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000173  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_1069 ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_605 ),
    .I4(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_1074 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_604 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 )
  );
  LUT6 #(
    .INIT ( 64'h8080AAAAC080FFAA ))
  \BU2/U0/transmitter/recoder/txd_out_62_mux000657  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I4(configuration_vector_18[4]),
    .I5(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_38_mux000657 )
  );
  LUT6 #(
    .INIT ( 64'h8080AAAAC080FFAA ))
  \BU2/U0/transmitter/recoder/txd_out_6_mux000657  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[5]),
    .I3(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I4(configuration_vector_18[4]),
    .I5(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_14_mux000657 )
  );
  LUT3 #(
    .INIT ( 8'h5D ))
  \BU2/U0/transmitter/recoder/txd_out_11_mux0006311  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .O(\BU2/U0/transmitter/recoder/N46 )
  );
  LUT3 #(
    .INIT ( 8'h5D ))
  \BU2/U0/transmitter/recoder/txd_out_35_mux0006211  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .O(\BU2/U0/transmitter/recoder/N43 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000611  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_2_595 ),
    .I2(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/recoder/N23 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000611  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/recoder/N22 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \BU2/U0/transmitter/recoder/txd_out_0_mux000631  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .O(\BU2/U0/transmitter/recoder/N32 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \BU2/U0/transmitter/recoder/txd_out_32_mux000621  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
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
    .O(\BU2/U0/receiver/recoder/rxd_out_32_rstpot_1253 )
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
    .INIT ( 32'hFFFF7FF7 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<4>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I1(mgt_rxlock_14[0]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last_700 ),
    .I3(\BU2/U0/signal_detect_int [0]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/N24 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF7FF7 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<4>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I1(mgt_rxlock_14[1]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last_683 ),
    .I3(\BU2/U0/signal_detect_int [1]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/N22 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF7FF7 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<4>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I1(mgt_rxlock_14[2]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last_666 ),
    .I3(\BU2/U0/signal_detect_int [2]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/N20 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF7FF7 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<4>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I1(mgt_rxlock_14[3]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last_649 ),
    .I3(\BU2/U0/signal_detect_int [3]),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/N18 )
  );
  LUT5 #(
    .INIT ( 32'h00044444 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>244  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>244_1154 )
  );
  LUT5 #(
    .INIT ( 32'h00044444 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>244  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>244_1144 )
  );
  LUT5 #(
    .INIT ( 32'h00044444 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>244  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>244_1134 )
  );
  LUT5 #(
    .INIT ( 32'h00044444 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>244  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>244_1124 )
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<32>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [32])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<33>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [33])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<34>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [34])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<35>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [35])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<36>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [36])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<37>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [37])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<38>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [38])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<39>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [39])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<40>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [40])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<41>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [41])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<42>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [42])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<43>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [43])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<44>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [44])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<45>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [45])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<46>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [46])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<47>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [47])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<48>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [48])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<49>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [49])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<50>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [50])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<51>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [51])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<52>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [52])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<53>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [53])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<54>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [54])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<55>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [55])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<56>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [56])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<57>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<1> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<1> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [57])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<58>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [58])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<59>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [59])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<60>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [60])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<61>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [61])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<62>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<6> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [62])
  );
  LUT4 #(
    .INIT ( 16'hEC4C ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000<63>1  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> ),
    .I2(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [63])
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
    .O(\BU2/U0/receiver/recoder/error_lane_6_or0000101_1337 )
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
  LUT3 #(
    .INIT ( 8'h01 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>175  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>175_1405 )
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>175  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>175_1403 )
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>175  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>175_1401 )
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>175  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>175_1399 )
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
    .I4(\BU2/N131 ),
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
    .I4(\BU2/N131 ),
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
    .I4(\BU2/N129 ),
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
    .I4(\BU2/N129 ),
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
    .I4(\BU2/N127 ),
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
    .I4(\BU2/N127 ),
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
    .I4(\BU2/N133 ),
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
    .I4(\BU2/N133 ),
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
    .I5(\BU2/N131 ),
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
    .I5(\BU2/N131 ),
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
    .I5(\BU2/N131 ),
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
    .I5(\BU2/N129 ),
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
    .I5(\BU2/N129 ),
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
    .I5(\BU2/N129 ),
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
    .I5(\BU2/N127 ),
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
    .I5(\BU2/N127 ),
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
    .I5(\BU2/N127 ),
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
    .I5(\BU2/N133 ),
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
    .I5(\BU2/N133 ),
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
    .I5(\BU2/N133 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_7_mux0002 )
  );
  LUT6 #(
    .INIT ( 64'hBABF101510151015 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<0>  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_0_721 ),
    .I1(\BU2/N107 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .I3(\BU2/N106 ),
    .I4(\BU2/N326 ),
    .I5(\BU2/U0/receiver/sync_status_643 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> [0])
  );
  LUT6 #(
    .INIT ( 64'hFEEBAAAA4C401911 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<0>_SW4  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .I4(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I5(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .O(\BU2/N326 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFCFFAAFFA8 ))
  \BU2/U0/receiver/recoder/error_lane_7_or000071  (
    .I0(\BU2/U0/receiver/recoder/error_lane_7_or000013_1107 ),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [5]),
    .I3(\BU2/U0/receiver/recoder/code_error_pipe [3]),
    .I4(\BU2/U0/receiver/recoder/lane_terminate [6]),
    .I5(\BU2/N324 ),
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
    .O(\BU2/N324 )
  );
  LUT6 #(
    .INIT ( 64'h111F1F1FFFFFFFFF ))
  \BU2/U0/transmitter/align/a_cnt_0_mux00011_SW0  (
    .I0(\BU2/U0/transmitter/tx_is_idle [0]),
    .I1(\BU2/U0/transmitter/tx_is_q [0]),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I4(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1249 ),
    .I5(\BU2/N322 ),
    .O(\BU2/N192 )
  );
  LUT3 #(
    .INIT ( 8'hBF ))
  \BU2/U0/transmitter/align/a_cnt_0_mux00011_SW0_SW0  (
    .I0(\BU2/U0/transmitter/align/extra_a_1163 ),
    .I1(\BU2/U0/transmitter/align/count [0]),
    .I2(\BU2/U0/transmitter/align/count [1]),
    .O(\BU2/N322 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFAEAAAAAA ))
  \BU2/U0/transmitter/is_terminate_0_mux0000128  (
    .I0(\BU2/U0/transmitter/is_terminate_0_mux0000103_1340 ),
    .I1(\BU2/U0/transmitter/is_terminate_0_mux000010_1050 ),
    .I2(\BU2/U0/transmitter/txd_pipe [17]),
    .I3(\BU2/U0/transmitter/txd_pipe [22]),
    .I4(\BU2/U0/transmitter/txd_pipe [23]),
    .I5(\BU2/N320 ),
    .O(\BU2/U0/transmitter/is_terminate [0])
  );
  LUT6 #(
    .INIT ( 64'hFFFF200020002000 ))
  \BU2/U0/transmitter/is_terminate_0_mux0000128_SW0  (
    .I0(\BU2/U0/transmitter/is_terminate_0_mux000072_1053 ),
    .I1(\BU2/U0/transmitter/txd_pipe [1]),
    .I2(\BU2/U0/transmitter/txd_pipe [6]),
    .I3(\BU2/U0/transmitter/txd_pipe [7]),
    .I4(\BU2/U0/transmitter/is_terminate_0_mux000035_1051 ),
    .I5(\BU2/U0/transmitter/is_terminate_0_mux000040_1052 ),
    .O(\BU2/N320 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFAEAAAAAA ))
  \BU2/U0/transmitter/is_terminate_1_mux0000128  (
    .I0(\BU2/U0/transmitter/is_terminate_1_mux0000103_1339 ),
    .I1(\BU2/U0/transmitter/is_terminate_1_mux000010_1045 ),
    .I2(\BU2/U0/transmitter/txd_pipe [49]),
    .I3(\BU2/U0/transmitter/txd_pipe [54]),
    .I4(\BU2/U0/transmitter/txd_pipe [55]),
    .I5(\BU2/N318 ),
    .O(\BU2/U0/transmitter/is_terminate [1])
  );
  LUT6 #(
    .INIT ( 64'hFFFF200020002000 ))
  \BU2/U0/transmitter/is_terminate_1_mux0000128_SW0  (
    .I0(\BU2/U0/transmitter/is_terminate_1_mux000072_1048 ),
    .I1(\BU2/U0/transmitter/txd_pipe [33]),
    .I2(\BU2/U0/transmitter/txd_pipe [38]),
    .I3(\BU2/U0/transmitter/txd_pipe [39]),
    .I4(\BU2/U0/transmitter/is_terminate_1_mux000035_1046 ),
    .I5(\BU2/U0/transmitter/is_terminate_1_mux000040_1047 ),
    .O(\BU2/N318 )
  );
  LUT6 #(
    .INIT ( 64'h7340734062404040 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>  (
    .I0(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .I1(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .I2(\BU2/N179 ),
    .I3(\BU2/N316 ),
    .I4(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1249 ),
    .I5(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .O(\BU2/U0/transmitter/state_machine/next_state<1> [1])
  );
  LUT6 #(
    .INIT ( 64'hFF888888FF808080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>197  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .I1(\BU2/U0/signal_detect_int [0]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>62_1148 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>175_1405 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>169_1150 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>76_1406 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>197_1157 )
  );
  LUT6 #(
    .INIT ( 64'hFF888888FF808080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>197  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .I1(\BU2/U0/signal_detect_int [1]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>62_1138 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>175_1403 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>169_1140 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>76_1404 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>197_1147 )
  );
  LUT6 #(
    .INIT ( 64'hFF888888FF808080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>197  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .I1(\BU2/U0/signal_detect_int [2]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>62_1128 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>175_1401 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>169_1130 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>76_1402 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>197_1137 )
  );
  LUT6 #(
    .INIT ( 64'hFF888888FF808080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>197  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .I1(\BU2/U0/signal_detect_int [3]),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>62_1118 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>175_1399 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>169_1120 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>76_1400 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>197_1127 )
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \BU2/U0/receiver/recoder/error_lane_6_or0000121_SW0  (
    .I0(\BU2/U0/receiver/recoder/error_lane_6_or000039_1168 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [54]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [52]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [53]),
    .O(\BU2/N186 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_40_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [8]),
    .I2(\BU2/U0/usrclk_reset_345 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [5]),
    .I4(\BU2/U0/receiver/recoder/mux0023_or0000 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_40_rstpot1_1335 )
  );
  LUT5 #(
    .INIT ( 32'h000A0008 ))
  \BU2/U0/receiver/recoder/rxd_out_48_rstpot1  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [16]),
    .I2(\BU2/U0/usrclk_reset_345 ),
    .I3(\BU2/U0/receiver/recoder/error_lane [6]),
    .I4(\BU2/U0/receiver/recoder/mux0027_or0000 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_48_rstpot1_1334 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/enchansync_rstpot  (
    .I0(\BU2/U0/receiver/sync_status_643 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_0_721 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/enchansync_rstpot_1259 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/clear_local_fault_edge_rstpot1  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/last_value_920 ),
    .I2(\BU2/U0/clear_local_fault_919 ),
    .O(\BU2/U0/clear_local_fault_edge_rstpot )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/clear_aligned_edge_rstpot1  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/last_value0_918 ),
    .I2(\BU2/U0/clear_aligned_917 ),
    .O(\BU2/U0/clear_aligned_edge_rstpot )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [4]),
    .I2(\BU2/U0/transmitter/txc_pipe [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot_1319 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [12]),
    .I2(\BU2/U0/transmitter/txc_pipe [1]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot_1313 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [20]),
    .I2(\BU2/U0/transmitter/txc_pipe [2]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot_1305 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [28]),
    .I2(\BU2/U0/transmitter/txc_pipe [3]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot_1297 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [36]),
    .I2(\BU2/U0/transmitter/txc_pipe [4]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot_1291 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [44]),
    .I2(\BU2/U0/transmitter/txc_pipe [5]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot_1285 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [52]),
    .I2(\BU2/U0/transmitter/txc_pipe [6]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot_1277 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/transmitter/txd_pipe [60]),
    .I2(\BU2/U0/transmitter/txc_pipe [7]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot_1269 )
  );
  LUT6 #(
    .INIT ( 64'h06E6068E06F6068E ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>71  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I5(\BU2/N312 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>71_1398 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>71_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/N312 )
  );
  LUT6 #(
    .INIT ( 64'h06E6068E06F6068E ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>71  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I5(\BU2/N310 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>71_1396 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>71_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/N310 )
  );
  LUT6 #(
    .INIT ( 64'h06E6068E06F6068E ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>71  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I5(\BU2/N308 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>71_1394 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>71_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/N308 )
  );
  LUT6 #(
    .INIT ( 64'h06E6068E06F6068E ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>71  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I5(\BU2/N306 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>71_1392 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>71_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/N306 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [32]),
    .I1(\BU2/U0/transmitter/txd_pipe [35]),
    .I2(\BU2/U0/transmitter/txd_pipe [34]),
    .I3(\BU2/U0/transmitter/txd_pipe [33]),
    .I4(\BU2/N304 ),
    .I5(\BU2/U0/transmitter/txd_pipe [36]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [37]),
    .I1(\BU2/U0/transmitter/txd_pipe [38]),
    .I2(\BU2/U0/transmitter/txd_pipe [39]),
    .O(\BU2/N304 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [40]),
    .I1(\BU2/U0/transmitter/txd_pipe [43]),
    .I2(\BU2/U0/transmitter/txd_pipe [42]),
    .I3(\BU2/U0/transmitter/txd_pipe [41]),
    .I4(\BU2/N302 ),
    .I5(\BU2/U0/transmitter/txd_pipe [44]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [45]),
    .I1(\BU2/U0/transmitter/txd_pipe [46]),
    .I2(\BU2/U0/transmitter/txd_pipe [47]),
    .O(\BU2/N302 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [48]),
    .I1(\BU2/U0/transmitter/txd_pipe [51]),
    .I2(\BU2/U0/transmitter/txd_pipe [50]),
    .I3(\BU2/U0/transmitter/txd_pipe [49]),
    .I4(\BU2/N300 ),
    .I5(\BU2/U0/transmitter/txd_pipe [52]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [53]),
    .I1(\BU2/U0/transmitter/txd_pipe [54]),
    .I2(\BU2/U0/transmitter/txd_pipe [55]),
    .O(\BU2/N300 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [56]),
    .I1(\BU2/U0/transmitter/txd_pipe [59]),
    .I2(\BU2/U0/transmitter/txd_pipe [58]),
    .I3(\BU2/U0/transmitter/txd_pipe [57]),
    .I4(\BU2/N298 ),
    .I5(\BU2/U0/transmitter/txd_pipe [60]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [61]),
    .I1(\BU2/U0/transmitter/txd_pipe [62]),
    .I2(\BU2/U0/transmitter/txd_pipe [63]),
    .O(\BU2/N298 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [0]),
    .I1(\BU2/U0/transmitter/txd_pipe [3]),
    .I2(\BU2/U0/transmitter/txd_pipe [2]),
    .I3(\BU2/U0/transmitter/txd_pipe [1]),
    .I4(\BU2/N296 ),
    .I5(\BU2/U0/transmitter/txd_pipe [4]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [5]),
    .I1(\BU2/U0/transmitter/txd_pipe [6]),
    .I2(\BU2/U0/transmitter/txd_pipe [7]),
    .O(\BU2/N296 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [16]),
    .I1(\BU2/U0/transmitter/txd_pipe [19]),
    .I2(\BU2/U0/transmitter/txd_pipe [18]),
    .I3(\BU2/U0/transmitter/txd_pipe [17]),
    .I4(\BU2/N294 ),
    .I5(\BU2/U0/transmitter/txd_pipe [20]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [21]),
    .I1(\BU2/U0/transmitter/txd_pipe [22]),
    .I2(\BU2/U0/transmitter/txd_pipe [23]),
    .O(\BU2/N294 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [24]),
    .I1(\BU2/U0/transmitter/txd_pipe [27]),
    .I2(\BU2/U0/transmitter/txd_pipe [26]),
    .I3(\BU2/U0/transmitter/txd_pipe [25]),
    .I4(\BU2/N292 ),
    .I5(\BU2/U0/transmitter/txd_pipe [28]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/RETVAL_mux00011_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [29]),
    .I1(\BU2/U0/transmitter/txd_pipe [30]),
    .I2(\BU2/U0/transmitter/txd_pipe [31]),
    .O(\BU2/N292 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFEFFFEFE ))
  \BU2/U0/tx_local_fault_rstpot1  (
    .I0(mgt_tx_reset_15[2]),
    .I1(mgt_tx_reset_15[3]),
    .I2(mgt_tx_reset_15[1]),
    .I3(\BU2/U0/clear_local_fault_edge_1263 ),
    .I4(\NlwRenamedSig_OI_status_vector[0] ),
    .I5(mgt_tx_reset_15[0]),
    .O(\BU2/U0/tx_local_fault_rstpot1_1258 )
  );
  LUT6 #(
    .INIT ( 64'h006420A0002020A0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>129  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I5(\BU2/U0/signal_detect_int [0]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>129_1383 )
  );
  LUT6 #(
    .INIT ( 64'h006420A0002020A0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>129  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I5(\BU2/U0/signal_detect_int [1]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>129_1382 )
  );
  LUT6 #(
    .INIT ( 64'h006420A0002020A0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>129  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I5(\BU2/U0/signal_detect_int [2]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>129_1381 )
  );
  LUT6 #(
    .INIT ( 64'h006420A0002020A0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>129  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I5(\BU2/U0/signal_detect_int [3]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>129_1380 )
  );
  LUT4 #(
    .INIT ( 16'h4C08 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<2>  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I1(\BU2/U0/receiver/sync_status_643 ),
    .I2(\BU2/N290 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> [2])
  );
  LUT6 #(
    .INIT ( 64'hABEFABEF8A8B8B8F ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<2>_SW4  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_0_721 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I4(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .I5(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .O(\BU2/N290 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [3]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N288 ),
    .I3(\BU2/U0/transmitter/txd_pipe [27]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot_1299 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [26]),
    .I1(\BU2/N135 ),
    .I2(\BU2/U0/transmitter/txd_pipe [29]),
    .I3(\BU2/U0/transmitter/txd_pipe [28]),
    .O(\BU2/N288 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [3]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N286 ),
    .I3(\BU2/U0/transmitter/txd_pipe [29]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot_1295 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [26]),
    .I1(\BU2/N135 ),
    .I2(\BU2/U0/transmitter/txd_pipe [28]),
    .I3(\BU2/U0/transmitter/txd_pipe [27]),
    .O(\BU2/N286 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [3]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N284 ),
    .I3(\BU2/U0/transmitter/txd_pipe [31]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot_1293 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [26]),
    .I1(\BU2/N135 ),
    .I2(\BU2/U0/transmitter/txd_pipe [29]),
    .I3(\BU2/U0/transmitter/txd_pipe [28]),
    .I4(\BU2/U0/transmitter/txd_pipe [27]),
    .O(\BU2/N284 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [24]),
    .I3(\BU2/N278 ),
    .I4(\BU2/N135 ),
    .I5(\BU2/U0/transmitter/txc_pipe [3]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N278 ),
    .I1(\BU2/U0/transmitter/txd_pipe [25]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [3]),
    .I4(\BU2/N135 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N278 ),
    .I1(\BU2/U0/transmitter/txd_pipe [30]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [3]),
    .I4(\BU2/N135 ),
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
    .O(\BU2/N278 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [2]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N276 ),
    .I3(\BU2/U0/transmitter/txd_pipe [19]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot_1307 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [18]),
    .I1(\BU2/N137 ),
    .I2(\BU2/U0/transmitter/txd_pipe [21]),
    .I3(\BU2/U0/transmitter/txd_pipe [20]),
    .O(\BU2/N276 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [2]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N274 ),
    .I3(\BU2/U0/transmitter/txd_pipe [21]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot_1303 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [18]),
    .I1(\BU2/N137 ),
    .I2(\BU2/U0/transmitter/txd_pipe [20]),
    .I3(\BU2/U0/transmitter/txd_pipe [19]),
    .O(\BU2/N274 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [2]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N272 ),
    .I3(\BU2/U0/transmitter/txd_pipe [23]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot_1301 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [18]),
    .I1(\BU2/N137 ),
    .I2(\BU2/U0/transmitter/txd_pipe [21]),
    .I3(\BU2/U0/transmitter/txd_pipe [20]),
    .I4(\BU2/U0/transmitter/txd_pipe [19]),
    .O(\BU2/N272 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [16]),
    .I3(\BU2/N266 ),
    .I4(\BU2/N137 ),
    .I5(\BU2/U0/transmitter/txc_pipe [2]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N266 ),
    .I1(\BU2/U0/transmitter/txd_pipe [17]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [2]),
    .I4(\BU2/N137 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N266 ),
    .I1(\BU2/U0/transmitter/txd_pipe [22]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [2]),
    .I4(\BU2/N137 ),
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
    .O(\BU2/N266 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [1]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N264 ),
    .I3(\BU2/U0/transmitter/txd_pipe [11]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot_1315 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [8]),
    .I1(\BU2/N139 ),
    .I2(\BU2/U0/transmitter/txd_pipe [13]),
    .I3(\BU2/U0/transmitter/txd_pipe [12]),
    .O(\BU2/N264 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [1]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N262 ),
    .I3(\BU2/U0/transmitter/txd_pipe [13]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot_1311 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [8]),
    .I1(\BU2/N139 ),
    .I2(\BU2/U0/transmitter/txd_pipe [12]),
    .I3(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N262 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [1]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N260 ),
    .I3(\BU2/U0/transmitter/txd_pipe [15]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot_1309 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [8]),
    .I1(\BU2/N139 ),
    .I2(\BU2/U0/transmitter/txd_pipe [13]),
    .I3(\BU2/U0/transmitter/txd_pipe [12]),
    .I4(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N260 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [8]),
    .I3(\BU2/N258 ),
    .I4(\BU2/N139 ),
    .I5(\BU2/U0/transmitter/txc_pipe [1]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>11 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW3  (
    .I0(\BU2/U0/transmitter/txd_pipe [13]),
    .I1(\BU2/U0/transmitter/txd_pipe [12]),
    .I2(\BU2/U0/transmitter/txd_pipe [11]),
    .O(\BU2/N258 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N254 ),
    .I1(\BU2/U0/transmitter/txd_pipe [9]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [1]),
    .I4(\BU2/N139 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N254 ),
    .I1(\BU2/U0/transmitter/txd_pipe [14]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [1]),
    .I4(\BU2/N139 ),
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
    .O(\BU2/N254 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [0]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N252 ),
    .I3(\BU2/U0/transmitter/txd_pipe [3]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot_1320 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [2]),
    .I1(\BU2/N141 ),
    .I2(\BU2/U0/transmitter/txd_pipe [5]),
    .I3(\BU2/U0/transmitter/txd_pipe [4]),
    .O(\BU2/N252 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [0]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N250 ),
    .I3(\BU2/U0/transmitter/txd_pipe [5]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot_1318 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [2]),
    .I1(\BU2/N141 ),
    .I2(\BU2/U0/transmitter/txd_pipe [4]),
    .I3(\BU2/U0/transmitter/txd_pipe [3]),
    .O(\BU2/N250 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [0]),
    .I1(\BU2/U0/transmitter/is_terminate [0]),
    .I2(\BU2/N248 ),
    .I3(\BU2/U0/transmitter/txd_pipe [7]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot_1317 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [2]),
    .I1(\BU2/N141 ),
    .I2(\BU2/U0/transmitter/txd_pipe [5]),
    .I3(\BU2/U0/transmitter/txd_pipe [4]),
    .I4(\BU2/U0/transmitter/txd_pipe [3]),
    .O(\BU2/N248 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [0]),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [0]),
    .I3(\BU2/N242 ),
    .I4(\BU2/N141 ),
    .I5(\BU2/U0/transmitter/txc_pipe [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N242 ),
    .I1(\BU2/U0/transmitter/txd_pipe [1]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [0]),
    .I4(\BU2/N141 ),
    .I5(\BU2/U0/transmitter/is_terminate [0]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N242 ),
    .I1(\BU2/U0/transmitter/txd_pipe [6]),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [0]),
    .I4(\BU2/N141 ),
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
    .O(\BU2/N242 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [7]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N240 ),
    .I3(\BU2/U0/transmitter/txd_pipe [59]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot_1271 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [58]),
    .I1(\BU2/N143 ),
    .I2(\BU2/U0/transmitter/txd_pipe [61]),
    .I3(\BU2/U0/transmitter/txd_pipe [60]),
    .O(\BU2/N240 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [7]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N238 ),
    .I3(\BU2/U0/transmitter/txd_pipe [61]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot_1267 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [58]),
    .I1(\BU2/N143 ),
    .I2(\BU2/U0/transmitter/txd_pipe [60]),
    .I3(\BU2/U0/transmitter/txd_pipe [59]),
    .O(\BU2/N238 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [7]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N236 ),
    .I3(\BU2/U0/transmitter/txd_pipe [63]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot_1265 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [58]),
    .I1(\BU2/N143 ),
    .I2(\BU2/U0/transmitter/txd_pipe [61]),
    .I3(\BU2/U0/transmitter/txd_pipe [60]),
    .I4(\BU2/U0/transmitter/txd_pipe [59]),
    .O(\BU2/N236 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [56]),
    .I3(\BU2/N230 ),
    .I4(\BU2/N143 ),
    .I5(\BU2/U0/transmitter/txc_pipe [7]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N230 ),
    .I1(\BU2/U0/transmitter/txd_pipe [57]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [7]),
    .I4(\BU2/N143 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N230 ),
    .I1(\BU2/U0/transmitter/txd_pipe [62]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [7]),
    .I4(\BU2/N143 ),
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
    .O(\BU2/N230 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [6]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N228 ),
    .I3(\BU2/U0/transmitter/txd_pipe [51]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot_1279 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [50]),
    .I1(\BU2/N145 ),
    .I2(\BU2/U0/transmitter/txd_pipe [53]),
    .I3(\BU2/U0/transmitter/txd_pipe [52]),
    .O(\BU2/N228 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [6]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N226 ),
    .I3(\BU2/U0/transmitter/txd_pipe [53]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot_1275 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [50]),
    .I1(\BU2/N145 ),
    .I2(\BU2/U0/transmitter/txd_pipe [52]),
    .I3(\BU2/U0/transmitter/txd_pipe [51]),
    .O(\BU2/N226 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [6]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N224 ),
    .I3(\BU2/U0/transmitter/txd_pipe [55]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot_1273 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [50]),
    .I1(\BU2/N145 ),
    .I2(\BU2/U0/transmitter/txd_pipe [53]),
    .I3(\BU2/U0/transmitter/txd_pipe [52]),
    .I4(\BU2/U0/transmitter/txd_pipe [51]),
    .O(\BU2/N224 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [48]),
    .I3(\BU2/N218 ),
    .I4(\BU2/N145 ),
    .I5(\BU2/U0/transmitter/txc_pipe [6]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N218 ),
    .I1(\BU2/U0/transmitter/txd_pipe [49]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [6]),
    .I4(\BU2/N145 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N218 ),
    .I1(\BU2/U0/transmitter/txd_pipe [54]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [6]),
    .I4(\BU2/N145 ),
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
    .O(\BU2/N218 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [5]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N216 ),
    .I3(\BU2/U0/transmitter/txd_pipe [43]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot_1287 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [42]),
    .I1(\BU2/N147 ),
    .I2(\BU2/U0/transmitter/txd_pipe [45]),
    .I3(\BU2/U0/transmitter/txd_pipe [44]),
    .O(\BU2/N216 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [5]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N214 ),
    .I3(\BU2/U0/transmitter/txd_pipe [45]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot_1283 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [42]),
    .I1(\BU2/N147 ),
    .I2(\BU2/U0/transmitter/txd_pipe [44]),
    .I3(\BU2/U0/transmitter/txd_pipe [43]),
    .O(\BU2/N214 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [5]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N212 ),
    .I3(\BU2/U0/transmitter/txd_pipe [47]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot_1281 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [42]),
    .I1(\BU2/N147 ),
    .I2(\BU2/U0/transmitter/txd_pipe [45]),
    .I3(\BU2/U0/transmitter/txd_pipe [44]),
    .I4(\BU2/U0/transmitter/txd_pipe [43]),
    .O(\BU2/N212 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [40]),
    .I3(\BU2/N206 ),
    .I4(\BU2/N147 ),
    .I5(\BU2/U0/transmitter/txc_pipe [5]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N206 ),
    .I1(\BU2/U0/transmitter/txd_pipe [41]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [5]),
    .I4(\BU2/N147 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N206 ),
    .I1(\BU2/U0/transmitter/txd_pipe [46]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [5]),
    .I4(\BU2/N147 ),
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
    .O(\BU2/N206 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [4]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N204 ),
    .I3(\BU2/U0/transmitter/txd_pipe [35]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot_1292 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW6  (
    .I0(\BU2/U0/transmitter/txd_pipe [34]),
    .I1(\BU2/N149 ),
    .I2(\BU2/U0/transmitter/txd_pipe [37]),
    .I3(\BU2/U0/transmitter/txd_pipe [36]),
    .O(\BU2/N204 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [4]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N202 ),
    .I3(\BU2/U0/transmitter/txd_pipe [37]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot_1290 )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW5  (
    .I0(\BU2/U0/transmitter/txd_pipe [34]),
    .I1(\BU2/N149 ),
    .I2(\BU2/U0/transmitter/txd_pipe [36]),
    .I3(\BU2/U0/transmitter/txd_pipe [35]),
    .O(\BU2/N202 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot  (
    .I0(\BU2/U0/transmitter/txc_pipe [4]),
    .I1(\BU2/U0/transmitter/is_terminate [1]),
    .I2(\BU2/N200 ),
    .I3(\BU2/U0/transmitter/txd_pipe [39]),
    .I4(\BU2/U0/usrclk_reset_345 ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot_1289 )
  );
  LUT5 #(
    .INIT ( 32'h00000002 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW4  (
    .I0(\BU2/U0/transmitter/txd_pipe [34]),
    .I1(\BU2/N149 ),
    .I2(\BU2/U0/transmitter/txd_pipe [37]),
    .I3(\BU2/U0/transmitter/txd_pipe [36]),
    .I4(\BU2/U0/transmitter/txd_pipe [35]),
    .O(\BU2/N200 )
  );
  LUT6 #(
    .INIT ( 64'h30303010F0F0F0F0 ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>111  (
    .I0(\BU2/U0/transmitter/is_terminate [1]),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I2(\BU2/U0/transmitter/txd_pipe [32]),
    .I3(\BU2/N194 ),
    .I4(\BU2/N149 ),
    .I5(\BU2/U0/transmitter/txc_pipe [4]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>111  (
    .I0(\BU2/N194 ),
    .I1(\BU2/U0/transmitter/txd_pipe [33]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [4]),
    .I4(\BU2/N149 ),
    .I5(\BU2/U0/transmitter/is_terminate [1]),
    .O(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>11 )
  );
  LUT6 #(
    .INIT ( 64'hFCCCA8CCFCCCFCCC ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>111  (
    .I0(\BU2/N194 ),
    .I1(\BU2/U0/transmitter/txd_pipe [38]),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/N01 ),
    .I3(\BU2/U0/transmitter/txc_pipe [4]),
    .I4(\BU2/N149 ),
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
    .O(\BU2/N194 )
  );
  LUT6 #(
    .INIT ( 64'h0404040404043704 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<1>  (
    .I0(\BU2/N164 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I3(\BU2/U0/transmitter/align/N5 ),
    .I4(\BU2/N192 ),
    .I5(\BU2/U0/transmitter/align/count [2]),
    .O(\BU2/U0/transmitter/state_machine/next_state<0> [1])
  );
  LUT4 #(
    .INIT ( 16'h02FF ))
  \BU2/U0/transmitter/align/a_cnt_1_mux00011_SW0  (
    .I0(\BU2/U0/transmitter/align/extra_a_1163 ),
    .I1(\BU2/U0/transmitter/align/count [0]),
    .I2(\BU2/U0/transmitter/align/count [1]),
    .I3(\BU2/U0/transmitter/align/count [2]),
    .O(\BU2/N190 )
  );
  LUT6 #(
    .INIT ( 64'h000A000F00020003 ))
  \BU2/U0/transmitter/align/a_cnt_0_mux000121  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I2(\BU2/U0/transmitter/align/count [4]),
    .I3(\BU2/U0/transmitter/align/count [3]),
    .I4(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I5(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/align/N5 )
  );
  LUT4 #(
    .INIT ( 16'h0302 ))
  \BU2/U0/receiver/recoder/error_lane_5_or000070  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [3]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .I3(\BU2/U0/receiver/recoder/lane_terminate [2]),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or000070_1116 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_5_or0000145  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [41]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [46]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [47]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [45]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [42]),
    .I5(\BU2/N188 ),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or0000145_1117 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_5_or0000145_SW0  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [5]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [40]),
    .I2(\BU2/U0/receiver/recoder/rxc_pipe [5]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [44]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [43]),
    .O(\BU2/N188 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/receiver/recoder/rxd_out_1_rstpot  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/error_lane [0]),
    .I2(\BU2/U0/receiver/recoder/mux0003_or0000_1036 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_1_rstpot_1250 )
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
    .I0(\BU2/U0/transmitter/is_terminate_0_mux000097_1054 ),
    .I1(\BU2/U0/transmitter/txd_pipe [14]),
    .I2(\BU2/U0/transmitter/txd_pipe [15]),
    .I3(\BU2/U0/transmitter/txd_pipe [9]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux0000103_1340 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/transmitter/is_terminate_1_mux0000103  (
    .I0(\BU2/U0/transmitter/is_terminate_1_mux000097_1049 ),
    .I1(\BU2/U0/transmitter/txd_pipe [46]),
    .I2(\BU2/U0/transmitter/txd_pipe [47]),
    .I3(\BU2/U0/transmitter/txd_pipe [41]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux0000103_1339 )
  );
  LUT6 #(
    .INIT ( 64'hEEFFEAFAEEFEEAFA ))
  \BU2/U0/receiver/recoder/error_lane_6_or0000121  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [2]),
    .I1(\BU2/U0/receiver/recoder/error_lane_6_or000024 ),
    .I2(\BU2/U0/receiver/recoder/error_lane_6_or00000_1166 ),
    .I3(\BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_1159 ),
    .I4(\BU2/U0/receiver/recoder/error_lane_6_or0000101_1337 ),
    .I5(\BU2/N186 ),
    .O(\BU2/U0/receiver/recoder/error_lane [6])
  );
  LUT4 #(
    .INIT ( 16'hAF88 ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<1>_SW5  (
    .I0(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .I1(\BU2/U0/transmitter/tx_is_idle [1]),
    .I2(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I3(\BU2/U0/transmitter/tx_is_q [1]),
    .O(\BU2/N179 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_40  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_40_rstpot1_1335 ),
    .Q(xgmii_rxd_4[40])
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_48  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_48_rstpot1_1334 ),
    .Q(xgmii_rxd_4[48])
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_16  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_16_rstpot1_1333 ),
    .Q(xgmii_rxd_4[16])
  );
  FD   \BU2/U0/receiver/recoder/rxd_out_8  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_8_rstpot1_1332 ),
    .Q(xgmii_rxd_4[8])
  );
  FD   \BU2/U0/transmitter/align/extra_a  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/align/extra_a_rstpot1_1331 ),
    .Q(\BU2/U0/transmitter/align/extra_a_1163 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot_1330 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [2])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [34]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_2_rstpot_1330 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot_1329 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [3])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [35]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_3_rstpot_1329 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot_1328 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [4])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [36]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_4_rstpot_1328 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot_1327 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [7])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [39]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_7_rstpot_1327 )
  );
  FD   \BU2/U0/receiver/recoder/rxd_half_pipe_24  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot_1326 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [24])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [56]),
    .O(\BU2/U0/receiver/recoder/rxd_half_pipe_24_rstpot_1326 )
  );
  FD   \BU2/U0/receiver/recoder/rxc_half_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot_1325 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/rxc_pipe [4]),
    .O(\BU2/U0/receiver/recoder/rxc_half_pipe_0_rstpot_1325 )
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/enable_align  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/enable_align_rstpot_1324 ),
    .Q(mgt_enable_align_12[0])
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/enable_align  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/enable_align_rstpot_1323 ),
    .Q(mgt_enable_align_12[1])
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/enable_align  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/enable_align_rstpot_1322 ),
    .Q(mgt_enable_align_12[2])
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/enable_align  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/enable_align_rstpot_1321 ),
    .Q(mgt_enable_align_12[3])
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_3_rstpot_1320 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_4_rstpot_1319 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_5_rstpot_1318 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_7_rstpot_1317 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_3_rstpot_1315 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_4_rstpot_1313 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_5_rstpot_1311 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_7_rstpot_1309 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_3_rstpot_1307 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_4_rstpot_1305 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_5_rstpot_1303 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_7_rstpot_1301 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_3_rstpot_1299 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_4_rstpot_1297 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_5_rstpot_1295 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_7_rstpot_1293 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_3_rstpot_1292 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_4_rstpot_1291 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_5_rstpot_1290 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_7_rstpot_1289 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_3_rstpot_1287 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_4_rstpot_1285 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_5_rstpot_1283 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_7_rstpot_1281 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_3_rstpot_1279 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_4_rstpot_1277 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_5_rstpot_1275 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_7_rstpot_1273 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<7> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_3_rstpot_1271 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<3> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_4_rstpot_1269 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<4> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_5_rstpot_1267 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<5> )
  );
  FD   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_7_rstpot_1265 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<7> )
  );
  FD   \BU2/U0/clear_aligned_edge  (
    .C(usrclk),
    .D(\BU2/U0/clear_aligned_edge_rstpot ),
    .Q(\BU2/U0/clear_aligned_edge_1254 )
  );
  FD #(
    .INIT ( 1'b1 ))
  \BU2/U0/usrclk_reset_pipe  (
    .C(usrclk),
    .D(reset),
    .Q(\BU2/U0/usrclk_reset_pipe_1260 )
  );
  FD   \BU2/U0/clear_local_fault_edge  (
    .C(usrclk),
    .D(\BU2/U0/clear_local_fault_edge_rstpot ),
    .Q(\BU2/U0/clear_local_fault_edge_1263 )
  );
  FD #(
    .INIT ( 1'b1 ))
  \BU2/U0/usrclk_reset  (
    .C(usrclk),
    .D(\BU2/U0/usrclk_reset_rstpot_1261 ),
    .Q(\BU2/U0/usrclk_reset_345 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/usrclk_reset_rstpot  (
    .I0(\BU2/U0/usrclk_reset_pipe_1260 ),
    .I1(reset),
    .O(\BU2/U0/usrclk_reset_rstpot_1261 )
  );
  FD   \BU2/U0/receiver/G_SYNC.deskew_state/enchansync  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/enchansync_rstpot_1259 ),
    .Q(mgt_enchansync)
  );
  FDR   \BU2/U0/tx_local_fault  (
    .C(usrclk),
    .D(\BU2/U0/tx_local_fault_rstpot1_1258 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\NlwRenamedSig_OI_status_vector[0] )
  );
  FDR   \BU2/U0/rx_local_fault  (
    .C(usrclk),
    .D(\BU2/U0/rx_local_fault_rstpot1 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\NlwRenamedSig_OI_status_vector[1] )
  );
  FDR   \BU2/U0/transmitter/tqmsg_capture_1/q_det  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/q_det_rstpot1_1256 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 )
  );
  FDR   \BU2/U0/aligned_sticky  (
    .C(usrclk),
    .D(\BU2/U0/aligned_sticky_rstpot_1255 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .Q(\NlwRenamedSig_OI_status_vector[7] )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \BU2/U0/aligned_sticky_rstpot  (
    .I0(\BU2/U0/clear_aligned_edge_1254 ),
    .I1(\NlwRenamedSig_OI_status_vector[7] ),
    .I2(\BU2/N1 ),
    .O(\BU2/U0/aligned_sticky_rstpot_1255 )
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_32  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_32_rstpot_1253 ),
    .R(\BU2/U0/receiver/recoder/rxd_out_32_or0000 ),
    .Q(xgmii_rxd_4[32])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_33  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_33_rstpot_1252 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .Q(xgmii_rxd_4[33])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_0_rstpot_1251 ),
    .R(\BU2/U0/receiver/recoder/rxd_out_0_or0000 ),
    .Q(xgmii_rxd_4[0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_0_rstpot  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [0]),
    .I1(\BU2/U0/receiver/recoder/mux0003_or0000_1036 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_0_rstpot_1251 )
  );
  FDR   \BU2/U0/receiver/recoder/rxd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_1_rstpot_1250 ),
    .R(\BU2/U0/aligned_sticky_or0000 ),
    .Q(xgmii_rxd_4[1])
  );
  FDS   \BU2/U0/transmitter/state_machine/next_ifg_is_a  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_ifg_is_a_rstpot ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/next_ifg_is_a_1249 )
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_14  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_14_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[22])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_16  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_16_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[32])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_22  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_22_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[38])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_24  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_24_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[48])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_30  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_30_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[54])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_32  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_32_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[8])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_40  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_40_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[24])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_38  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_38_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[14])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_46  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_46_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[30])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_0_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[0])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_48  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_48_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[40])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_54  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_54_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[46])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_56  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_56_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[56])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_62  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_62_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[62])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_6_mux000681 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 ),
    .Q(mgt_txdata_6[6])
  );
  FDRS   \BU2/U0/transmitter/recoder/txd_out_8  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txd_out_8_mux00061 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .S(\BU2/U0/transmitter/recoder/N24 ),
    .Q(mgt_txdata_6[16])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [32]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [33]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [37]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [5])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [38]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [6])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_8  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [40]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [8])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_9  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [41]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [9])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_10  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [42]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [10])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_11  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [43]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [11])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_12  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [44]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [12])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_13  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [45]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [13])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_14  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [46]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [14])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_15  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [47]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [15])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_16  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [48]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [16])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_17  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [49]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [17])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_18  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [50]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [18])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_19  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [51]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [19])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_20  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [52]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [20])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_21  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [53]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [21])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_22  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [54]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [22])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_23  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [55]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [23])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_25  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [57]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [25])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_26  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [58]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [26])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_27  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [59]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [27])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_28  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [60]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [28])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_29  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [61]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [29])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_30  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [62]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [30])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_half_pipe_31  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_pipe [63]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_half_pipe [31])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_half_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_half_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [6]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [2])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_half_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxc_pipe [7]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxc_half_pipe [3])
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out<6> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<7>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<0> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<6>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out<2> )
  );
  FDR   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_mux0004<1>11 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .O(\BU2/U0/receiver/recoder/error_lane_6_or000039_1168 )
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
    .O(\BU2/U0/receiver/recoder/error_lane_6_or00000_1166 )
  );
  LUT5 #(
    .INIT ( 32'h40505050 ))
  \BU2/U0/transmitter/align/a_cnt_0_mux00011  (
    .I0(\BU2/U0/transmitter/align/count [2]),
    .I1(\BU2/U0/transmitter/align/extra_a_1163 ),
    .I2(\BU2/U0/transmitter/align/N5 ),
    .I3(\BU2/U0/transmitter/align/count [1]),
    .I4(\BU2/U0/transmitter/align/count [0]),
    .O(\BU2/U0/transmitter/a_due [0])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<0>31  (
    .I0(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I1(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .O(\BU2/U0/transmitter/tx_code_a [1])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \BU2/U0/transmitter/state_machine/tx_code_a_0_or00001  (
    .I0(\BU2/U0/transmitter/state_machine/state_0_1_597 ),
    .I1(\BU2/U0/transmitter/state_machine/state_0_0_599 ),
    .O(\BU2/U0/transmitter/tx_code_a [0])
  );
  LUT4 #(
    .INIT ( 16'h11F5 ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<1>_SW0  (
    .I0(\BU2/U0/transmitter/tx_is_q [0]),
    .I1(\BU2/U0/transmitter/tx_is_idle [0]),
    .I2(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I3(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .O(\BU2/N164 )
  );
  LUT6 #(
    .INIT ( 64'h0100000000000000 ))
  \BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [49]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [48]),
    .I2(\BU2/N158 ),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [55]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [53]),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [50]),
    .O(\BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_1159 )
  );
  LUT3 #(
    .INIT ( 8'hBF ))
  \BU2/U0/receiver/recoder/check_end_early_value_7_4_cmp_eq0005_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [54]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [52]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [51]),
    .O(\BU2/N158 )
  );
  LUT5 #(
    .INIT ( 32'hF030F020 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>441  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>398_1156 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N46 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>197_1157 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>383_1155 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><0> )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>398  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>398_1156 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0A0F0F0F080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>383  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>297_1152 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>232_1151 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>244_1154 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>335_1153 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>383_1155 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000060 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>335  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>335_1153 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA00028802 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>297_1152 )
  );
  LUT6 #(
    .INIT ( 64'h00005D0000000800 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>232  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>232_1151 )
  );
  LUT6 #(
    .INIT ( 64'h0062006211730062 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>169  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>133_1149 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>169_1150 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>133  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/signal_detect_int [0]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>133_1149 )
  );
  LUT6 #(
    .INIT ( 64'h0082008200820183 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>62  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N15 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<0>62_1148 )
  );
  LUT5 #(
    .INIT ( 32'hF030F020 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>441  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>398_1146 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N46 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>197_1147 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>383_1145 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><0> )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>398  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>398_1146 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0A0F0F0F080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>383  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>297_1142 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>232_1141 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>244_1144 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>335_1143 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>383_1145 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000060 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>335  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>335_1143 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA00028802 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>297_1142 )
  );
  LUT6 #(
    .INIT ( 64'h00005D0000000800 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>232  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>232_1141 )
  );
  LUT6 #(
    .INIT ( 64'h0062006211730062 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>169  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>133_1139 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>169_1140 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>133  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/signal_detect_int [1]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>133_1139 )
  );
  LUT6 #(
    .INIT ( 64'h0082008200820183 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>62  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N15 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<0>62_1138 )
  );
  LUT5 #(
    .INIT ( 32'hF030F020 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>441  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>398_1136 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N46 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>197_1137 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>383_1135 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><0> )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>398  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>398_1136 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0A0F0F0F080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>383  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>297_1132 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>232_1131 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>244_1134 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>335_1133 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>383_1135 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000060 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>335  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>335_1133 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA00028802 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>297_1132 )
  );
  LUT6 #(
    .INIT ( 64'h00005D0000000800 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>232  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>232_1131 )
  );
  LUT6 #(
    .INIT ( 64'h0062006211730062 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>169  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>133_1129 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>169_1130 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>133  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/signal_detect_int [2]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>133_1129 )
  );
  LUT6 #(
    .INIT ( 64'h0082008200820183 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>62  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N15 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<0>62_1128 )
  );
  LUT5 #(
    .INIT ( 32'hF030F020 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>441  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>398_1126 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N46 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>197_1127 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>383_1125 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><0> )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>398  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>398_1126 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0A0F0F0F080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>383  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>297_1122 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>232_1121 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>244_1124 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>335_1123 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>383_1125 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000060 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>335  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>335_1123 )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAA00028802 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>297_1122 )
  );
  LUT6 #(
    .INIT ( 64'h00005D0000000800 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>232  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>232_1121 )
  );
  LUT6 #(
    .INIT ( 64'h0062006211730062 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>169  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>133_1119 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>169_1120 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>133  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/signal_detect_int [3]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>133_1119 )
  );
  LUT6 #(
    .INIT ( 64'h0082008200820183 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>62  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N15 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<0>62_1118 )
  );
  LUT6 #(
    .INIT ( 64'hFCCFA88AFCCFA8AA ))
  \BU2/U0/transmitter/state_machine/next_state_1_mux0002<2>1  (
    .I0(\BU2/U0/transmitter/tx_is_idle [1]),
    .I1(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .I2(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .I3(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .I4(\BU2/U0/transmitter/tx_is_q [1]),
    .I5(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .O(\BU2/U0/transmitter/state_machine/next_state<1> [2])
  );
  LUT6 #(
    .INIT ( 64'hFFFFFAEAFAEAFAEA ))
  \BU2/U0/receiver/recoder/error_lane_5_or0000172  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/error_lane_5_or000023_1114 ),
    .I2(\BU2/U0/receiver/recoder/error_lane_5_or000070_1116 ),
    .I3(\BU2/U0/receiver/recoder/error_lane_5_or000048_1115 ),
    .I4(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .I5(\BU2/U0/receiver/recoder/error_lane_5_or0000145_1117 ),
    .O(\BU2/U0/receiver/recoder/error_lane [5])
  );
  LUT4 #(
    .INIT ( 16'hD7FF ))
  \BU2/U0/receiver/recoder/error_lane_5_or000048  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [5]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [47]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [46]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [45]),
    .O(\BU2/U0/receiver/recoder/error_lane_5_or000048_1115 )
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
    .O(\BU2/U0/receiver/recoder/error_lane_5_or000023_1114 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFF8F8A8A ))
  \BU2/U0/receiver/recoder/error_lane_1_or0000128  (
    .I0(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I1(\BU2/U0/receiver/recoder/error_lane_1_or000018_1111 ),
    .I2(\BU2/U0/receiver/recoder/N18 ),
    .I3(\BU2/U0/receiver/recoder/error_lane_1_or000080_1112 ),
    .I4(\BU2/U0/receiver/recoder/error_lane_1_or0000103_1113 ),
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
    .O(\BU2/U0/receiver/recoder/error_lane_1_or0000103_1113 )
  );
  LUT5 #(
    .INIT ( 32'hFFFF9FFF ))
  \BU2/U0/receiver/recoder/error_lane_1_or000080  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I3(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .I4(\BU2/U0/receiver/recoder/code_error_pipe [1]),
    .O(\BU2/U0/receiver/recoder/error_lane_1_or000080_1112 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/recoder/error_lane_1_or000018  (
    .I0(\BU2/U0/receiver/recoder/code_error_pipe [1]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [15]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [13]),
    .I4(\BU2/U0/receiver/recoder/rxc_pipe [1]),
    .O(\BU2/U0/receiver/recoder/error_lane_1_or000018_1111 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_10_or00011  (
    .I0(\BU2/U0/receiver/recoder/error_lane [1]),
    .I1(\BU2/U0/receiver/recoder/mux0007_or0000_1027 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_10_or0001 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFA8AA ))
  \BU2/U0/receiver/recoder/error_lane_4_or000095  (
    .I0(\BU2/U0/receiver/recoder/error_lane_4_or000073_1110 ),
    .I1(\BU2/U0/receiver/recoder/error_lane_4_or000048_1109 ),
    .I2(\BU2/U0/receiver/recoder/error_lane_4_or000014_1108 ),
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
    .O(\BU2/U0/receiver/recoder/error_lane_4_or000073_1110 )
  );
  LUT4 #(
    .INIT ( 16'hD7FF ))
  \BU2/U0/receiver/recoder/error_lane_4_or000048  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [4]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [39]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [38]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [37]),
    .O(\BU2/U0/receiver/recoder/error_lane_4_or000048_1109 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFEFFF ))
  \BU2/U0/receiver/recoder/error_lane_4_or000014  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [33]),
    .I1(\BU2/U0/receiver/recoder/code_error_pipe [4]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [36]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [35]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [32]),
    .O(\BU2/U0/receiver/recoder/error_lane_4_or000014_1108 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFEFF ))
  \BU2/U0/receiver/recoder/error_lane_7_or000013  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [62]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [56]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [57]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [60]),
    .I4(\BU2/U0/receiver/recoder/code_error_pipe [7]),
    .O(\BU2/U0/receiver/recoder/error_lane_7_or000013_1107 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFF8F8A8A ))
  \BU2/U0/receiver/recoder/error_lane_2_or0000105  (
    .I0(\BU2/U0/receiver/recoder/N35 ),
    .I1(\BU2/U0/receiver/recoder/error_lane_2_or000010_1104 ),
    .I2(\BU2/U0/receiver/recoder/N16 ),
    .I3(\BU2/U0/receiver/recoder/error_lane_2_or000056_1105 ),
    .I4(\BU2/U0/receiver/recoder/error_lane_2_or000081_1106 ),
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
    .O(\BU2/U0/receiver/recoder/error_lane_2_or000081_1106 )
  );
  LUT4 #(
    .INIT ( 16'hFF9F ))
  \BU2/U0/receiver/recoder/error_lane_2_or000056  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .I3(\BU2/U0/receiver/recoder/code_error_pipe [2]),
    .O(\BU2/U0/receiver/recoder/error_lane_2_or000056_1105 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/error_lane_2_or000010  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/code_error_pipe [2]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [21]),
    .O(\BU2/U0/receiver/recoder/error_lane_2_or000010_1104 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFCFFAAFFA8 ))
  \BU2/U0/receiver/recoder/error_lane_3_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_pipe [30]),
    .I1(\BU2/U0/receiver/recoder/lane_terminate [1]),
    .I2(\BU2/U0/receiver/recoder/lane_terminate [0]),
    .I3(\BU2/U0/receiver/recoder/code_error_delay [3]),
    .I4(\BU2/U0/receiver/recoder/lane_terminate [2]),
    .I5(\BU2/N156 ),
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
    .O(\BU2/N156 )
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
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/mux0019_or0000 ),
    .I2(NlwRenamedSig_OI_align_status),
    .I3(\BU2/U0/receiver/recoder/error_lane [4]),
    .O(\BU2/U0/receiver/recoder/rxd_out_34_or0000 )
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  \BU2/U0/receiver/recoder/rxd_out_32_or00001  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(NlwRenamedSig_OI_align_status),
    .I2(\BU2/U0/receiver/recoder/error_lane [4]),
    .O(\BU2/U0/receiver/recoder/rxd_out_32_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_17_or00001  (
    .I0(\BU2/U0/receiver/recoder/error_lane [2]),
    .I1(\BU2/U0/receiver/recoder/mux0011_or0000_1019 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_17_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/recoder/rxd_out_25_or00001  (
    .I0(\BU2/U0/receiver/recoder/error_lane [3]),
    .I1(\BU2/U0/receiver/recoder/mux0015_or0000_1011 ),
    .O(\BU2/U0/receiver/recoder/rxd_out_25_or0000 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N15 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>297_1102 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>249  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>192_1099 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>130_1098 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>63_1097 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>214_1100 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>249_1101 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>214  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>214_1100 )
  );
  LUT6 #(
    .INIT ( 64'h62226222EEAA6222 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>192  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>192_1099 )
  );
  LUT6 #(
    .INIT ( 64'h0000FA0000007900 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>130  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>130_1098 )
  );
  LUT6 #(
    .INIT ( 64'h000000AA02020208 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>63  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>63_1097 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N15 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>297_1096 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>249  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>192_1093 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>130_1092 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>63_1091 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>214_1094 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>249_1095 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>214  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>214_1094 )
  );
  LUT6 #(
    .INIT ( 64'h62226222EEAA6222 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>192  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>192_1093 )
  );
  LUT6 #(
    .INIT ( 64'h0000FA0000007900 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>130  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>130_1092 )
  );
  LUT6 #(
    .INIT ( 64'h000000AA02020208 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>63  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>63_1091 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N15 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>297_1090 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>249  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>192_1087 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>130_1086 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>63_1085 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>214_1088 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>249_1089 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>214  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>214_1088 )
  );
  LUT6 #(
    .INIT ( 64'h62226222EEAA6222 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>192  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>192_1087 )
  );
  LUT6 #(
    .INIT ( 64'h0000FA0000007900 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>130  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>130_1086 )
  );
  LUT6 #(
    .INIT ( 64'h000000AA02020208 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>63  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>63_1085 )
  );
  LUT6 #(
    .INIT ( 64'h0000000200000000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>297  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N15 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>297_1084 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFAAFFFFFF80 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>249  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>192_1081 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>130_1080 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>63_1079 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>214_1082 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>249_1083 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>214  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>214_1082 )
  );
  LUT6 #(
    .INIT ( 64'h62226222EEAA6222 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>192  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>192_1081 )
  );
  LUT6 #(
    .INIT ( 64'h0000FA0000007900 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>130  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>130_1080 )
  );
  LUT6 #(
    .INIT ( 64'h000000AA02020208 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>63  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>63_1079 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<2>131  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N15 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<2>131  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N15 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<2>131  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N15 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<2>131  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N15 )
  );
  LUT6 #(
    .INIT ( 64'hABBAAAAAA88AAAAA ))
  \BU2/U0/receiver/recoder/error_lane_0_or0000  (
    .I0(\BU2/N153 ),
    .I1(\BU2/U0/receiver/recoder/code_error_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [6]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [7]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [5]),
    .I5(\BU2/N154 ),
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
    .O(\BU2/N154 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBBBBA ))
  \BU2/U0/receiver/recoder/error_lane_0_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/code_error_delay [0]),
    .I1(\BU2/U0/receiver/recoder/lane_term_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/lane_term_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/lane_term_pipe [2]),
    .I4(\BU2/U0/receiver/recoder/lane_term_pipe [1]),
    .O(\BU2/N153 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/recoder/mux0027_or000011  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [2]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [20]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [19]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [18]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [17]),
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
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(\BU2/U0/receiver/recoder/mux0003_or0000_1036 ),
    .I2(NlwRenamedSig_OI_align_status),
    .I3(\BU2/U0/receiver/recoder/error_lane [0]),
    .O(\BU2/U0/receiver/recoder/rxd_out_2_or0000 )
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  \BU2/U0/receiver/recoder/rxd_out_0_or00001  (
    .I0(\BU2/U0/usrclk_reset_345 ),
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
    .I4(\BU2/N151 ),
    .I5(\BU2/U0/receiver/recoder/rxd_pipe [24]),
    .O(\BU2/U0/receiver/recoder/rxd_out_56_mux0002_850 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139  (
    .I0(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<6> ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_606 ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<5> ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<1> ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<0> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not000139_1074 )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017  (
    .I0(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<3> ),
    .I1(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<7> ),
    .I3(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_607 ),
    .I4(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out<2> ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not00017_1069 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050  (
    .I0(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<6> ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_602 ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<5> ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<1> ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<0> ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_600 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000050_1064 )
  );
  LUT6 #(
    .INIT ( 64'h0000000080000000 ))
  \BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014  (
    .I0(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<3> ),
    .I1(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<4> ),
    .I2(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<7> ),
    .I3(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_603 ),
    .I4(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out<2> ),
    .I5(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_601 ),
    .O(\BU2/U0/transmitter/tqmsg_capture_1/mux0000_and000014_1059 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/recoder/mux0019_or000011  (
    .I0(\BU2/U0/receiver/recoder/rxc_pipe [0]),
    .I1(\BU2/U0/receiver/recoder/rxd_pipe [4]),
    .I2(\BU2/U0/receiver/recoder/rxd_pipe [3]),
    .I3(\BU2/U0/receiver/recoder/rxd_pipe [2]),
    .I4(\BU2/U0/receiver/recoder/rxd_pipe [1]),
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
    .O(\BU2/U0/transmitter/is_terminate_0_mux000097_1054 )
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
    .O(\BU2/U0/transmitter/is_terminate_0_mux000072_1053 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \BU2/U0/transmitter/is_terminate_0_mux000040  (
    .I0(\BU2/U0/transmitter/txd_pipe [30]),
    .I1(\BU2/U0/transmitter/txd_pipe [31]),
    .I2(\BU2/U0/transmitter/txd_pipe [25]),
    .O(\BU2/U0/transmitter/is_terminate_0_mux000040_1052 )
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
    .O(\BU2/U0/transmitter/is_terminate_0_mux000035_1051 )
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
    .O(\BU2/U0/transmitter/is_terminate_0_mux000010_1050 )
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
    .O(\BU2/U0/transmitter/is_terminate_1_mux000097_1049 )
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
    .O(\BU2/U0/transmitter/is_terminate_1_mux000072_1048 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \BU2/U0/transmitter/is_terminate_1_mux000040  (
    .I0(\BU2/U0/transmitter/txd_pipe [62]),
    .I1(\BU2/U0/transmitter/txd_pipe [63]),
    .I2(\BU2/U0/transmitter/txd_pipe [57]),
    .O(\BU2/U0/transmitter/is_terminate_1_mux000040_1047 )
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
    .O(\BU2/U0/transmitter/is_terminate_1_mux000035_1046 )
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
    .O(\BU2/U0/transmitter/is_terminate_1_mux000010_1045 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [32]),
    .I1(\BU2/U0/transmitter/txd_pipe [39]),
    .I2(\BU2/U0/transmitter/txd_pipe [38]),
    .I3(\BU2/U0/transmitter/txd_pipe [33]),
    .O(\BU2/N149 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [40]),
    .I1(\BU2/U0/transmitter/txd_pipe [47]),
    .I2(\BU2/U0/transmitter/txd_pipe [46]),
    .I3(\BU2/U0/transmitter/txd_pipe [41]),
    .O(\BU2/N147 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [48]),
    .I1(\BU2/U0/transmitter/txd_pipe [55]),
    .I2(\BU2/U0/transmitter/txd_pipe [54]),
    .I3(\BU2/U0/transmitter/txd_pipe [49]),
    .O(\BU2/N145 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [56]),
    .I1(\BU2/U0/transmitter/txd_pipe [63]),
    .I2(\BU2/U0/transmitter/txd_pipe [62]),
    .I3(\BU2/U0/transmitter/txd_pipe [57]),
    .O(\BU2/N143 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[0].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [0]),
    .I1(\BU2/U0/transmitter/txd_pipe [7]),
    .I2(\BU2/U0/transmitter/txd_pipe [6]),
    .I3(\BU2/U0/transmitter/txd_pipe [1]),
    .O(\BU2/N141 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [10]),
    .I1(\BU2/U0/transmitter/txd_pipe [14]),
    .I2(\BU2/U0/transmitter/txd_pipe [15]),
    .I3(\BU2/U0/transmitter/txd_pipe [9]),
    .O(\BU2/N139 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [16]),
    .I1(\BU2/U0/transmitter/txd_pipe [23]),
    .I2(\BU2/U0/transmitter/txd_pipe [22]),
    .I3(\BU2/U0/transmitter/txd_pipe [17]),
    .O(\BU2/N137 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txd_out_and0000_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [24]),
    .I1(\BU2/U0/transmitter/txd_pipe [31]),
    .I2(\BU2/U0/transmitter/txd_pipe [30]),
    .I3(\BU2/U0/transmitter/txd_pipe [25]),
    .O(\BU2/N135 )
  );
  LUT3 #(
    .INIT ( 8'h32 ))
  \BU2/U0/receiver/recoder/rxd_out_24_mux00021  (
    .I0(\BU2/U0/receiver/recoder/mux0015_or0000_1011 ),
    .I1(\BU2/U0/receiver/recoder/error_lane [3]),
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
    .I5(\BU2/N133 ),
    .O(\BU2/U0/receiver/recoder/mux0003_or0000_1036 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0003_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [2]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [0]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [1]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [0]),
    .O(\BU2/N133 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0007_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [15]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [14]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [12]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [11]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [13]),
    .I5(\BU2/N131 ),
    .O(\BU2/U0/receiver/recoder/mux0007_or0000_1027 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0007_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [10]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [8]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [9]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [1]),
    .O(\BU2/N131 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0011_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [23]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [22]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [20]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [19]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [21]),
    .I5(\BU2/N129 ),
    .O(\BU2/U0/receiver/recoder/mux0011_or0000_1019 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0011_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [18]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [16]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [17]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [2]),
    .O(\BU2/N129 )
  );
  LUT6 #(
    .INIT ( 64'h0000000060001000 ))
  \BU2/U0/receiver/recoder/mux0015_or0000  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [31]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [30]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [28]),
    .I3(\BU2/U0/receiver/recoder/rxd_half_pipe [27]),
    .I4(\BU2/U0/receiver/recoder/rxd_half_pipe [29]),
    .I5(\BU2/N127 ),
    .O(\BU2/U0/receiver/recoder/mux0015_or0000_1011 )
  );
  LUT4 #(
    .INIT ( 16'hFDFF ))
  \BU2/U0/receiver/recoder/mux0015_or0000_SW0  (
    .I0(\BU2/U0/receiver/recoder/rxd_half_pipe [26]),
    .I1(\BU2/U0/receiver/recoder/rxd_half_pipe [24]),
    .I2(\BU2/U0/receiver/recoder/rxd_half_pipe [25]),
    .I3(\BU2/U0/receiver/recoder/rxc_half_pipe [3]),
    .O(\BU2/N127 )
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
    .INIT ( 64'h08082A08082A2A2A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<3>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N46 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I2(\BU2/N124 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N15 ),
    .I4(\BU2/N125 ),
    .I5(\BU2/N123 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><3> )
  );
  LUT6 #(
    .INIT ( 64'hFFFF8532FFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<3>_SW2  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .O(\BU2/N125 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF5BA9A9AA ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<3>_SW1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/N124 )
  );
  LUT6 #(
    .INIT ( 64'hFF0FFF0F85FF34FF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<3>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/N123 )
  );
  LUT6 #(
    .INIT ( 64'h08082A08082A2A2A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<3>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N46 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I2(\BU2/N120 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N15 ),
    .I4(\BU2/N121 ),
    .I5(\BU2/N119 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><3> )
  );
  LUT6 #(
    .INIT ( 64'hFFFF8532FFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<3>_SW2  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .O(\BU2/N121 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF5BA9A9AA ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<3>_SW1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/N120 )
  );
  LUT6 #(
    .INIT ( 64'hFF0FFF0F85FF34FF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<3>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/N119 )
  );
  LUT6 #(
    .INIT ( 64'h08082A08082A2A2A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<3>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N46 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I2(\BU2/N116 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N15 ),
    .I4(\BU2/N117 ),
    .I5(\BU2/N115 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><3> )
  );
  LUT6 #(
    .INIT ( 64'hFFFF8532FFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<3>_SW2  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .O(\BU2/N117 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF5BA9A9AA ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<3>_SW1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/N116 )
  );
  LUT6 #(
    .INIT ( 64'hFF0FFF0F85FF34FF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<3>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/N115 )
  );
  LUT6 #(
    .INIT ( 64'h08082A08082A2A2A ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<3>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N46 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I2(\BU2/N112 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N15 ),
    .I4(\BU2/N113 ),
    .I5(\BU2/N111 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><3> )
  );
  LUT6 #(
    .INIT ( 64'hFFFF8532FFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<3>_SW2  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .O(\BU2/N113 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF5BA9A9AA ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<3>_SW1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/N112 )
  );
  LUT6 #(
    .INIT ( 64'hFF0FFF0F85FF34FF ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<3>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I5(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/N111 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFA0FFCCFFD7FF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<0>_SW1  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I3(\BU2/U0/receiver/sync_status_643 ),
    .I4(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I5(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .O(\BU2/N107 )
  );
  LUT6 #(
    .INIT ( 64'h5DFD5999FFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<0>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I4(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .I5(\BU2/U0/receiver/sync_status_643 ),
    .O(\BU2/N106 )
  );
  LUT6 #(
    .INIT ( 64'h028A139B46CE57DF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<1>  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_0_721 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .I2(\BU2/N103 ),
    .I3(\BU2/N104 ),
    .I4(\BU2/N101 ),
    .I5(\BU2/N102 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> [1])
  );
  LUT6 #(
    .INIT ( 64'h99AAF9D9FFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<1>_SW3  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I4(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .I5(\BU2/U0/receiver/sync_status_643 ),
    .O(\BU2/N104 )
  );
  LUT6 #(
    .INIT ( 64'hFFEEFFFFFFEBFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<1>_SW2  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I4(\BU2/U0/receiver/sync_status_643 ),
    .I5(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .O(\BU2/N103 )
  );
  LUT6 #(
    .INIT ( 64'hC33FC23FFFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<1>_SW1  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I4(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .I5(\BU2/U0/receiver/sync_status_643 ),
    .O(\BU2/N102 )
  );
  LUT6 #(
    .INIT ( 64'hFFBFFFFFFF95FFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/next_state_1_mux0000<1>_SW0  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1]),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0]),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1]),
    .I4(\BU2/U0/receiver/sync_status_643 ),
    .I5(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0]),
    .O(\BU2/N101 )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \BU2/U0/transmitter/recoder/txd_out_6_mux000679  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[5]),
    .I2(configuration_vector_18[6]),
    .O(\BU2/U0/transmitter/recoder/txd_out_14_mux000679 )
  );
  LUT6 #(
    .INIT ( 64'h973FFFBFFFFFFFFF ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/RETVAL_mux00011  (
    .I0(\BU2/U0/transmitter/txd_pipe [9]),
    .I1(\BU2/U0/transmitter/txd_pipe [11]),
    .I2(\BU2/U0/transmitter/txd_pipe [10]),
    .I3(\BU2/U0/transmitter/txd_pipe [8]),
    .I4(\BU2/N79 ),
    .I5(\BU2/U0/transmitter/txd_pipe [12]),
    .O(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/N01 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \BU2/U0/transmitter/G_FILTER_LOW[1].filter/RETVAL_mux00011_SW0  (
    .I0(\BU2/U0/transmitter/txd_pipe [13]),
    .I1(\BU2/U0/transmitter/txd_pipe [15]),
    .I2(\BU2/U0/transmitter/txd_pipe [14]),
    .O(\BU2/N79 )
  );
  LUT6 #(
    .INIT ( 64'hFCCFA88AFCCFA8AA ))
  \BU2/U0/transmitter/state_machine/state_temp_mux0000<2>1  (
    .I0(\BU2/U0/transmitter/tx_is_idle [0]),
    .I1(\BU2/U0/transmitter/state_machine/state_1_2_589 ),
    .I2(\BU2/U0/transmitter/state_machine/state_1_1_591 ),
    .I3(\BU2/U0/transmitter/state_machine/state_1_0_593 ),
    .I4(\BU2/U0/transmitter/tx_is_q [0]),
    .I5(\BU2/U0/transmitter/tqmsg_capture_1/q_det_972 ),
    .O(\BU2/U0/transmitter/state_machine/next_state<0> [2])
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_0_or0000  (
    .I0(mgt_rxdata_8[7]),
    .I1(mgt_rxdata_8[6]),
    .I2(mgt_rxdata_8[5]),
    .I3(\BU2/N64 ),
    .I4(\BU2/N63 ),
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
    .O(\BU2/N64 )
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
    .O(\BU2/N63 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_1_or0000  (
    .I0(mgt_rxdata_8[23]),
    .I1(mgt_rxdata_8[22]),
    .I2(mgt_rxdata_8[21]),
    .I3(\BU2/N61 ),
    .I4(\BU2/N60 ),
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
    .O(\BU2/N61 )
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
    .O(\BU2/N60 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_2_or0000  (
    .I0(mgt_rxdata_8[39]),
    .I1(mgt_rxdata_8[38]),
    .I2(mgt_rxdata_8[37]),
    .I3(\BU2/N58 ),
    .I4(\BU2/N57 ),
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
    .O(\BU2/N58 )
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
    .O(\BU2/N57 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_3_or0000  (
    .I0(mgt_rxdata_8[55]),
    .I1(mgt_rxdata_8[54]),
    .I2(mgt_rxdata_8[53]),
    .I3(\BU2/N55 ),
    .I4(\BU2/N54 ),
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
    .O(\BU2/N55 )
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
    .O(\BU2/N54 )
  );
  LUT6 #(
    .INIT ( 64'h80CCC4CCFFFFFFFF ))
  \BU2/U0/receiver/code_error_4_or0000  (
    .I0(mgt_rxdata_8[9]),
    .I1(mgt_rxcharisk_9[1]),
    .I2(\BU2/N52 ),
    .I3(mgt_rxdata_8[12]),
    .I4(\BU2/N51 ),
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
    .O(\BU2/N52 )
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
    .O(\BU2/N51 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_5_or0000  (
    .I0(mgt_rxdata_8[31]),
    .I1(mgt_rxdata_8[30]),
    .I2(mgt_rxdata_8[29]),
    .I3(\BU2/N49 ),
    .I4(\BU2/N48 ),
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
    .O(\BU2/N49 )
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
    .O(\BU2/N48 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_6_or0000  (
    .I0(mgt_rxdata_8[47]),
    .I1(mgt_rxdata_8[46]),
    .I2(mgt_rxdata_8[45]),
    .I3(\BU2/N46 ),
    .I4(\BU2/N45 ),
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
    .O(\BU2/N46 )
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
    .O(\BU2/N45 )
  );
  LUT6 #(
    .INIT ( 64'hFF7F8000FFFFFFFF ))
  \BU2/U0/receiver/code_error_7_or0000  (
    .I0(mgt_rxdata_8[63]),
    .I1(mgt_rxdata_8[62]),
    .I2(mgt_rxdata_8[61]),
    .I3(\BU2/N43 ),
    .I4(\BU2/N42 ),
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
    .O(\BU2/N43 )
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
    .O(\BU2/N42 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00021  (
    .I0(mgt_rxdata_8[35]),
    .I1(mgt_rxdata_8[38]),
    .I2(mgt_rxdata_8[37]),
    .I3(mgt_rxdata_8[36]),
    .I4(mgt_rxdata_8[39]),
    .I5(\BU2/N40 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N8 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00021_SW0  (
    .I0(mgt_rxdata_8[32]),
    .I1(mgt_rxdata_8[33]),
    .I2(mgt_rxdata_8[34]),
    .I3(mgt_rxcharisk_9[4]),
    .I4(mgt_codevalid_10[4]),
    .O(\BU2/N40 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00022  (
    .I0(mgt_rxdata_8[19]),
    .I1(mgt_rxdata_8[22]),
    .I2(mgt_rxdata_8[21]),
    .I3(mgt_rxdata_8[20]),
    .I4(mgt_rxdata_8[23]),
    .I5(\BU2/N38 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N10 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00022_SW0  (
    .I0(mgt_rxdata_8[16]),
    .I1(mgt_rxdata_8[17]),
    .I2(mgt_rxdata_8[18]),
    .I3(mgt_rxcharisk_9[2]),
    .I4(mgt_codevalid_10[2]),
    .O(\BU2/N38 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00023  (
    .I0(mgt_rxdata_8[3]),
    .I1(mgt_rxdata_8[6]),
    .I2(mgt_rxdata_8[5]),
    .I3(mgt_rxdata_8[4]),
    .I4(mgt_rxdata_8[7]),
    .I5(\BU2/N36 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N13 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00023_SW0  (
    .I0(mgt_rxdata_8[0]),
    .I1(mgt_rxdata_8[1]),
    .I2(mgt_rxdata_8[2]),
    .I3(mgt_rxcharisk_9[0]),
    .I4(mgt_codevalid_10[0]),
    .O(\BU2/N36 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00024  (
    .I0(mgt_rxdata_8[51]),
    .I1(mgt_rxdata_8[54]),
    .I2(mgt_rxdata_8[53]),
    .I3(mgt_rxdata_8[52]),
    .I4(mgt_rxdata_8[55]),
    .I5(\BU2/N34 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N15 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00024_SW0  (
    .I0(mgt_rxdata_8[48]),
    .I1(mgt_rxdata_8[49]),
    .I2(mgt_rxdata_8[50]),
    .I3(mgt_rxcharisk_9[6]),
    .I4(mgt_codevalid_10[6]),
    .O(\BU2/N34 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00021  (
    .I0(mgt_rxdata_8[59]),
    .I1(mgt_rxdata_8[62]),
    .I2(mgt_rxdata_8[61]),
    .I3(mgt_rxdata_8[60]),
    .I4(mgt_rxdata_8[63]),
    .I5(\BU2/N32 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N7 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00021_SW0  (
    .I0(mgt_rxdata_8[56]),
    .I1(mgt_rxdata_8[57]),
    .I2(mgt_rxdata_8[58]),
    .I3(mgt_rxcharisk_9[7]),
    .I4(mgt_codevalid_10[7]),
    .O(\BU2/N32 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00022  (
    .I0(mgt_rxdata_8[27]),
    .I1(mgt_rxdata_8[30]),
    .I2(mgt_rxdata_8[29]),
    .I3(mgt_rxdata_8[28]),
    .I4(mgt_rxdata_8[31]),
    .I5(\BU2/N30 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N9 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00022_SW0  (
    .I0(mgt_rxdata_8[24]),
    .I1(mgt_rxdata_8[25]),
    .I2(mgt_rxdata_8[26]),
    .I3(mgt_rxcharisk_9[3]),
    .I4(mgt_codevalid_10[3]),
    .O(\BU2/N30 )
  );
  LUT6 #(
    .INIT ( 64'h0100000000000000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00023  (
    .I0(mgt_rxdata_8[9]),
    .I1(mgt_rxdata_8[8]),
    .I2(mgt_rxdata_8[15]),
    .I3(mgt_rxdata_8[14]),
    .I4(mgt_rxdata_8[13]),
    .I5(\BU2/N28 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N12 )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00023_SW0  (
    .I0(mgt_rxdata_8[12]),
    .I1(mgt_rxdata_8[11]),
    .I2(mgt_rxdata_8[10]),
    .I3(mgt_rxcharisk_9[1]),
    .I4(mgt_codevalid_10[1]),
    .O(\BU2/N28 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00024  (
    .I0(mgt_rxdata_8[43]),
    .I1(mgt_rxdata_8[46]),
    .I2(mgt_rxdata_8[45]),
    .I3(mgt_rxdata_8[44]),
    .I4(mgt_rxdata_8[47]),
    .I5(\BU2/N26 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/N14 )
  );
  LUT5 #(
    .INIT ( 32'hEFFFFFFF ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00024_SW0  (
    .I0(mgt_rxdata_8[40]),
    .I1(mgt_rxdata_8[41]),
    .I2(mgt_rxdata_8[42]),
    .I3(mgt_rxcharisk_9[5]),
    .I4(mgt_codevalid_10[5]),
    .O(\BU2/N26 )
  );
  LUT4 #(
    .INIT ( 16'h7FFE ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux00025  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/N10 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/N8 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/N13 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/N15 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'h7FFE ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux00025  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/N12 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/N9 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/N14 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/N7 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux0002 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_cmp_eq00001  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/N10 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/N13 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/N8 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/N15 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_cmp_eq0000 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_cmp_eq00001  (
    .I0(\BU2/U0/receiver/G_SYNC.deskew_state/N12 ),
    .I1(\BU2/U0/receiver/G_SYNC.deskew_state/N7 ),
    .I2(\BU2/U0/receiver/G_SYNC.deskew_state/N9 ),
    .I3(\BU2/U0/receiver/G_SYNC.deskew_state/N14 ),
    .O(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_cmp_eq0000 )
  );
  LUT3 #(
    .INIT ( 8'h2A ))
  \BU2/U0/transmitter/recoder/txd_out_11_or00001  (
    .I0(configuration_vector_18[4]),
    .I1(configuration_vector_18[5]),
    .I2(configuration_vector_18[6]),
    .O(\BU2/U0/transmitter/recoder/txd_out_11_or0000 )
  );
  LUT4 #(
    .INIT ( 16'hFF4C ))
  \BU2/U0/transmitter/recoder/txd_out_12_or00001  (
    .I0(configuration_vector_18[5]),
    .I1(configuration_vector_18[4]),
    .I2(configuration_vector_18[6]),
    .I3(\BU2/U0/usrclk_reset_345 ),
    .O(\BU2/U0/transmitter/recoder/txd_out_12_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or00001  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(mgt_rx_reset_16[0]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or00001  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(mgt_rx_reset_16[1]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or00001  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(mgt_rx_reset_16[2]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or00001  (
    .I0(\BU2/U0/usrclk_reset_345 ),
    .I1(mgt_rx_reset_16[3]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \BU2/U0/receiver/recoder/rxd_out_10_or00001  (
    .I0(NlwRenamedSig_OI_align_status),
    .I1(\BU2/U0/usrclk_reset_345 ),
    .O(\BU2/U0/aligned_sticky_or0000 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<4>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 ),
    .I5(\BU2/N24 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><4> )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<4>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 ),
    .I5(\BU2/N22 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><4> )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<4>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 ),
    .I5(\BU2/N20 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><4> )
  );
  LUT6 #(
    .INIT ( 64'h0000000000008000 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<4>  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 ),
    .I3(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> ),
    .I4(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 ),
    .I5(\BU2/N18 ),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><4> )
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
  LUT3 #(
    .INIT ( 8'h82 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state_1_mux0000<1>211  (
    .I0(mgt_rxlock_14[0]),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last_700 ),
    .I2(\BU2/U0/signal_detect_int [0]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/N46 )
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state_1_mux0000<1>211  (
    .I0(mgt_rxlock_14[1]),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last_683 ),
    .I2(\BU2/U0/signal_detect_int [1]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/N46 )
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state_1_mux0000<1>211  (
    .I0(mgt_rxlock_14[2]),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last_666 ),
    .I2(\BU2/U0/signal_detect_int [2]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/N46 )
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state_1_mux0000<1>211  (
    .I0(mgt_rxlock_14[3]),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last_649 ),
    .I2(\BU2/U0/signal_detect_int [3]),
    .O(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/N46 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/sync_ok1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 ),
    .O(\BU2/U0/receiver/sync_ok_int [0])
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/sync_ok1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 ),
    .O(\BU2/U0/receiver/sync_ok_int [1])
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/sync_ok1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 ),
    .O(\BU2/U0/receiver/sync_ok_int [2])
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/sync_ok1  (
    .I0(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 ),
    .I1(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 ),
    .I2(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 ),
    .O(\BU2/U0/receiver/sync_ok_int [3])
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
    .O(\BU2/U0/receiver/recoder/mux0032_and0000_911 )
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
    .O(\BU2/U0/receiver/recoder/mux0033_and0000_909 )
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
    .O(\BU2/U0/receiver/recoder/mux0034_and0000_907 )
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
    .O(\BU2/U0/receiver/recoder/mux0035_and0000_905 )
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
    .O(\BU2/U0/receiver/recoder/mux0036_and0000_904 )
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
    .O(\BU2/U0/receiver/recoder/mux0037_and0000_903 )
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
    .O(\BU2/U0/receiver/recoder/mux0038_and0000_902 )
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
    .O(\BU2/U0/receiver/recoder/mux0039_and0000_901 )
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
    .I0(configuration_vector_18[5]),
    .I1(configuration_vector_18[6]),
    .I2(configuration_vector_18[4]),
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
  FD   \BU2/U0/clear_aligned  (
    .C(usrclk),
    .D(configuration_vector_18[3]),
    .Q(\BU2/U0/clear_aligned_917 )
  );
  FD   \BU2/U0/clear_local_fault  (
    .C(usrclk),
    .D(configuration_vector_18[2]),
    .Q(\BU2/U0/clear_local_fault_919 )
  );
  FDR   \BU2/U0/last_value  (
    .C(usrclk),
    .D(\BU2/U0/clear_local_fault_919 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/last_value_920 )
  );
  FDR   \BU2/U0/last_value0  (
    .C(usrclk),
    .D(\BU2/U0/clear_aligned_917 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/last_value0_918 )
  );
  FDRE   \BU2/U0/type_sel_reg_done  (
    .C(usrclk),
    .CE(\BU2/U0/type_sel_reg_done_inv ),
    .D(\BU2/N1 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/type_sel_reg_done_916 )
  );
  FDRE   \BU2/U0/type_sel_reg_1  (
    .C(usrclk),
    .CE(\BU2/U0/type_sel_reg_done_inv ),
    .D(N0),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/type_sel_reg [1])
  );
  FDS   \BU2/U0/signal_detect_int_0  (
    .C(usrclk),
    .D(signal_detect_17[0]),
    .S(\BU2/U0/type_sel_reg [1]),
    .Q(\BU2/U0/signal_detect_int [0])
  );
  FDS   \BU2/U0/signal_detect_int_1  (
    .C(usrclk),
    .D(signal_detect_17[1]),
    .S(\BU2/U0/type_sel_reg [1]),
    .Q(\BU2/U0/signal_detect_int [1])
  );
  FDS   \BU2/U0/signal_detect_int_2  (
    .C(usrclk),
    .D(signal_detect_17[2]),
    .S(\BU2/U0/type_sel_reg [1]),
    .Q(\BU2/U0/signal_detect_int [2])
  );
  FDS   \BU2/U0/signal_detect_int_3  (
    .C(usrclk),
    .D(signal_detect_17[3]),
    .S(\BU2/U0/type_sel_reg [1]),
    .Q(\BU2/U0/signal_detect_int [3])
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
    .D(\BU2/U0/receiver/recoder/mux0032_and0000_911 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [0])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0033_and0000_909 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [1])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0034_and0000_907 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [2])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0035_and0000_905 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [3])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0036_and0000_904 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [4])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0037_and0000_903 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [5])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0038_and0000_902 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_terminate [6])
  );
  FDR   \BU2/U0/receiver/recoder/lane_terminate_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/mux0039_and0000_901 ),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/rxc_pipe_1  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[2]),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxc_pipe [3])
  );
  FDS   \BU2/U0/receiver/recoder/rxc_pipe_4  (
    .C(usrclk),
    .D(mgt_rxcharisk_9[1]),
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [2])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_3  (
    .C(usrclk),
    .D(mgt_rxdata_8[3]),
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [5])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_6  (
    .C(usrclk),
    .D(mgt_rxdata_8[6]),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [8])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_out_56  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/rxd_out_56_mux0002_850 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [10])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_11  (
    .C(usrclk),
    .D(mgt_rxdata_8[19]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [11])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_12  (
    .C(usrclk),
    .D(mgt_rxdata_8[20]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [12])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_13  (
    .C(usrclk),
    .D(mgt_rxdata_8[21]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [13])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [2])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [3]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [3])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [4]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [4])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_5  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [5])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_6  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [6]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [6])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_pipe_7  (
    .C(usrclk),
    .D(\BU2/U0/receiver/code_error [7]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_pipe [7])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_15  (
    .C(usrclk),
    .D(mgt_rxdata_8[23]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [15])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_14  (
    .C(usrclk),
    .D(mgt_rxdata_8[22]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [14])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_20  (
    .C(usrclk),
    .D(mgt_rxdata_8[36]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [20])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_16  (
    .C(usrclk),
    .D(mgt_rxdata_8[32]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [16])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_22  (
    .C(usrclk),
    .D(mgt_rxdata_8[38]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [22])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_21  (
    .C(usrclk),
    .D(mgt_rxdata_8[37]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [21])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_17  (
    .C(usrclk),
    .D(mgt_rxdata_8[33]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [17])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_18  (
    .C(usrclk),
    .D(mgt_rxdata_8[34]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [18])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_23  (
    .C(usrclk),
    .D(mgt_rxdata_8[39]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [23])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_19  (
    .C(usrclk),
    .D(mgt_rxdata_8[35]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [19])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_24  (
    .C(usrclk),
    .D(mgt_rxdata_8[48]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [24])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_25  (
    .C(usrclk),
    .D(mgt_rxdata_8[49]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [25])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_30  (
    .C(usrclk),
    .D(mgt_rxdata_8[54]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [30])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_27  (
    .C(usrclk),
    .D(mgt_rxdata_8[51]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [27])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_26  (
    .C(usrclk),
    .D(mgt_rxdata_8[50]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [26])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_31  (
    .C(usrclk),
    .D(mgt_rxdata_8[55]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [31])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_32  (
    .C(usrclk),
    .D(mgt_rxdata_8[8]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [32])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_28  (
    .C(usrclk),
    .D(mgt_rxdata_8[52]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [28])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_34  (
    .C(usrclk),
    .D(mgt_rxdata_8[10]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [34])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_33  (
    .C(usrclk),
    .D(mgt_rxdata_8[9]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [33])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_29  (
    .C(usrclk),
    .D(mgt_rxdata_8[53]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [29])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_35  (
    .C(usrclk),
    .D(mgt_rxdata_8[11]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [35])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_40  (
    .C(usrclk),
    .D(mgt_rxdata_8[24]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [40])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_37  (
    .C(usrclk),
    .D(mgt_rxdata_8[13]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [37])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_36  (
    .C(usrclk),
    .D(mgt_rxdata_8[12]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [36])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_41  (
    .C(usrclk),
    .D(mgt_rxdata_8[25]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [41])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_42  (
    .C(usrclk),
    .D(mgt_rxdata_8[26]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [42])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_38  (
    .C(usrclk),
    .D(mgt_rxdata_8[14]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [38])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_43  (
    .C(usrclk),
    .D(mgt_rxdata_8[27]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [43])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_39  (
    .C(usrclk),
    .D(mgt_rxdata_8[15]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [39])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_44  (
    .C(usrclk),
    .D(mgt_rxdata_8[28]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [44])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_46  (
    .C(usrclk),
    .D(mgt_rxdata_8[30]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [46])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_45  (
    .C(usrclk),
    .D(mgt_rxdata_8[29]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [45])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_50  (
    .C(usrclk),
    .D(mgt_rxdata_8[42]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [50])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_51  (
    .C(usrclk),
    .D(mgt_rxdata_8[43]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [51])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_47  (
    .C(usrclk),
    .D(mgt_rxdata_8[31]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [47])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_53  (
    .C(usrclk),
    .D(mgt_rxdata_8[45]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [53])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_52  (
    .C(usrclk),
    .D(mgt_rxdata_8[44]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [52])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_48  (
    .C(usrclk),
    .D(mgt_rxdata_8[40]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [48])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_49  (
    .C(usrclk),
    .D(mgt_rxdata_8[41]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [49])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_54  (
    .C(usrclk),
    .D(mgt_rxdata_8[46]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [54])
  );
  FDS   \BU2/U0/receiver/recoder/rxd_pipe_56  (
    .C(usrclk),
    .D(mgt_rxdata_8[56]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [56])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_55  (
    .C(usrclk),
    .D(mgt_rxdata_8[47]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [55])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_60  (
    .C(usrclk),
    .D(mgt_rxdata_8[60]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [60])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_61  (
    .C(usrclk),
    .D(mgt_rxdata_8[61]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [61])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_57  (
    .C(usrclk),
    .D(mgt_rxdata_8[57]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [57])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_62  (
    .C(usrclk),
    .D(mgt_rxdata_8[62]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [62])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_58  (
    .C(usrclk),
    .D(mgt_rxdata_8[58]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [58])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_63  (
    .C(usrclk),
    .D(mgt_rxdata_8[63]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [63])
  );
  FDR   \BU2/U0/receiver/recoder/rxd_pipe_59  (
    .C(usrclk),
    .D(mgt_rxdata_8[59]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/rxd_pipe [59])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [4]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [0])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [1])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [6]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/lane_term_pipe [2])
  );
  FDR   \BU2/U0/receiver/recoder/lane_term_pipe_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/lane_terminate [7]),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_delay [0])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_delay_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/code_error_pipe [5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/recoder/code_error_delay [1])
  );
  FDR   \BU2/U0/receiver/recoder/code_error_delay_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/recoder/code_error_pipe [6]),
    .R(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
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
  FDR   \BU2/U0/receiver/G_SYNC.deskew_state/got_align_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_cmp_eq0000 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [0])
  );
  FDR   \BU2/U0/receiver/G_SYNC.deskew_state/got_align_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_cmp_eq0000 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/got_align [1])
  );
  FDR   \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_0_mux0002 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [0])
  );
  FDR   \BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error_1_mux0002 ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/deskew_error [1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_0_721 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> [1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_1_719 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.deskew_state/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/next_state<1> [2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 )
  );
  FD   \BU2/U0/receiver/G_SYNC.deskew_state/align_status  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.deskew_state/state_1_2_716 ),
    .Q(NlwRenamedSig_OI_align_status)
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe_0  (
    .C(usrclk),
    .D(mgt_codecomma_11[0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe_1  (
    .C(usrclk),
    .D(mgt_codecomma_11[1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_comma_pipe<1> )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><0> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_0_713 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><1> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_1_711 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><2> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_2_709 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><3> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_3_707 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/next_state<1><4> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/state_1_4_705 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe_0  (
    .C(usrclk),
    .D(mgt_codevalid_10[0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe_1  (
    .C(usrclk),
    .D(mgt_codevalid_10[1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/code_valid_pipe<1> )
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last  (
    .C(usrclk),
    .D(\BU2/U0/signal_detect_int [0]),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[0].pcs_sync_state/signal_detect_last_700 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe_0  (
    .C(usrclk),
    .D(mgt_codecomma_11[2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe_1  (
    .C(usrclk),
    .D(mgt_codecomma_11[3]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_comma_pipe<1> )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><0> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_0_696 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><1> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_1_694 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><2> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_2_692 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><3> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_3_690 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/next_state<1><4> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/state_1_4_688 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe_0  (
    .C(usrclk),
    .D(mgt_codevalid_10[2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe_1  (
    .C(usrclk),
    .D(mgt_codevalid_10[3]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/code_valid_pipe<1> )
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last  (
    .C(usrclk),
    .D(\BU2/U0/signal_detect_int [1]),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[1].pcs_sync_state/signal_detect_last_683 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe_0  (
    .C(usrclk),
    .D(mgt_codecomma_11[4]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe_1  (
    .C(usrclk),
    .D(mgt_codecomma_11[5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_comma_pipe<1> )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><0> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_0_679 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><1> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_1_677 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><2> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_2_675 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><3> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_3_673 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/next_state<1><4> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/state_1_4_671 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe_0  (
    .C(usrclk),
    .D(mgt_codevalid_10[4]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe_1  (
    .C(usrclk),
    .D(mgt_codevalid_10[5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/code_valid_pipe<1> )
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last  (
    .C(usrclk),
    .D(\BU2/U0/signal_detect_int [2]),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[2].pcs_sync_state/signal_detect_last_666 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe_0  (
    .C(usrclk),
    .D(mgt_codecomma_11[6]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe_1  (
    .C(usrclk),
    .D(mgt_codecomma_11[7]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_comma_pipe<1> )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><0> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_0_662 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><1> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_1_660 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><2> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_2_658 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><3> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_3_656 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4  (
    .C(usrclk),
    .D(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/next_state<1><4> ),
    .R(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_or0000 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/state_1_4_654 )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe_0  (
    .C(usrclk),
    .D(mgt_codevalid_10[6]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<0> )
  );
  FDR   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe_1  (
    .C(usrclk),
    .D(mgt_codevalid_10[7]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/code_valid_pipe<1> )
  );
  FD   \BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last  (
    .C(usrclk),
    .D(\BU2/U0/signal_detect_int [3]),
    .Q(\BU2/U0/receiver/G_SYNC.G_PCS_SYNC_STATE[3].pcs_sync_state/signal_detect_last_649 )
  );
  FDR   \BU2/U0/receiver/sync_ok_3  (
    .C(usrclk),
    .D(\BU2/U0/receiver/sync_ok_int [3]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(NlwRenamedSignal_status_vector[5])
  );
  FDR   \BU2/U0/receiver/sync_ok_2  (
    .C(usrclk),
    .D(\BU2/U0/receiver/sync_ok_int [2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(NlwRenamedSignal_status_vector[4])
  );
  FDR   \BU2/U0/receiver/sync_ok_1  (
    .C(usrclk),
    .D(\BU2/U0/receiver/sync_ok_int [1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(NlwRenamedSignal_status_vector[3])
  );
  FDR   \BU2/U0/receiver/sync_ok_0  (
    .C(usrclk),
    .D(\BU2/U0/receiver/sync_ok_int [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(NlwRenamedSignal_status_vector[2])
  );
  FDR   \BU2/U0/receiver/sync_status  (
    .C(usrclk),
    .D(\BU2/U0/receiver/sync_status_int ),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/receiver/sync_status_643 )
  );
  MUXCY_L   \BU2/U0/transmitter/idle_detect_i0/muxcy_i0  (
    .CI(\BU2/N1 ),
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
    .CI(\BU2/N1 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[0].filter/txc_out_607 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [1]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[1].filter/txc_out_606 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [2]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[2].filter/txc_out_605 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [3]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_LOW[3].filter/txc_out_604 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [4]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[4].filter/txc_out_603 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [5]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[5].filter/txc_out_602 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [6]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[6].filter/txc_out_601 )
  );
  FDS   \BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/txc_pipe [7]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/G_FILTER_HIGH[7].filter/txc_out_600 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_0_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<0> [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/state_0_0_599 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_0_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<0> [1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/state_0_1_597 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_0_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<0> [2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/state_0_2_595 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_1_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<1> [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/state_1_0_593 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_1_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<1> [1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/state_1_1_591 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/state_machine/state_1_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/state_machine/next_state<1> [2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/state_machine/state_1_2_589 )
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [1]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [3])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [3]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [5])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [5]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [7])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs_2_xor0000 ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [2])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [2]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [4])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [4]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [6])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_8  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs [6]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [8])
  );
  FDS   \BU2/U0/transmitter/k_r_prbs_i/prbs_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/k_r_prbs_i/prbs_1_xor0000 ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/k_r_prbs_i/prbs [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_0  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/count [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_1  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [1]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/count [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_2  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [2]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/count [2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_3  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [3]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/count [3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/transmitter/align/count_4  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/count_not0001 ),
    .D(\BU2/U0/transmitter/align/count_mux0000 [4]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/count [4])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_2  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [1]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/prbs [2])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_3  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [2]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/prbs [3])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_4  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [3]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/prbs [4])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_5  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [4]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/prbs [5])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_6  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [5]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/prbs [6])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_7  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs [6]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/align/prbs [7])
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \BU2/U0/transmitter/align/prbs_1  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/align/prbs_1_not0000 ),
    .D(\BU2/U0/transmitter/align/prbs_1_xor0000 ),
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(mgt_txcharisk_7[0])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_2  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_2_mux0006 ),
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(mgt_txcharisk_7[2])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_3  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_3_mux0006 ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(mgt_txcharisk_7[6])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_4  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_4_mux0006 ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(mgt_txcharisk_7[1])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_5  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_5_mux0006 ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(mgt_txcharisk_7[3])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_6  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_6_mux0006 ),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(mgt_txcharisk_7[5])
  );
  FDS   \BU2/U0/transmitter/recoder/txc_out_7  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/recoder/txc_out_7_mux0006 ),
    .S(\BU2/U0/usrclk_reset_345 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [0])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_1  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [33]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [1])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_2  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [34]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [2])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_3  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [35]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [3])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_4  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [36]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [4])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_5  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [37]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [5])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_6  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [38]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [6])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_7  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [39]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [7])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_8  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [40]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [8])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_9  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [41]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [9])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_10  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [42]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [10])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_11  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [43]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [11])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_12  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [44]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [12])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_13  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [45]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [13])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_14  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [46]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [14])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_15  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [47]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [15])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_16  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [48]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [16])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_17  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [49]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [17])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_18  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [50]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [18])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_19  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [51]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [19])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_20  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [52]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [20])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_21  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [53]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [21])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_22  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [54]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [22])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_23  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [55]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [23])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_24  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [56]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [24])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_25  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [57]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [25])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_26  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [58]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [26])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_27  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [59]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [27])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_28  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [60]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [28])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_29  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [61]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [29])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_30  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [62]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [30])
  );
  FDRE   \BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_31  (
    .C(usrclk),
    .CE(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_not0001 ),
    .D(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg_mux0000 [63]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tqmsg_capture_1/last_qmsg [31])
  );
  MUXCY_L   \BU2/U0/transmitter/seq_detect_i0/muxcy_i0  (
    .CI(\BU2/N1 ),
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
    .CI(\BU2/N1 ),
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
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tx_is_q [1])
  );
  FDR   \BU2/U0/transmitter/tx_is_q_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_q_comb [0]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tx_is_q [0])
  );
  FDS   \BU2/U0/transmitter/tx_is_idle_1  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_idle_comb [1]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tx_is_idle [1])
  );
  FDS   \BU2/U0/transmitter/tx_is_idle_0  (
    .C(usrclk),
    .D(\BU2/U0/transmitter/tx_is_idle_comb [0]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/tx_is_idle [0])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_13  (
    .C(usrclk),
    .D(xgmii_txd_2[13]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [13])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_12  (
    .C(usrclk),
    .D(xgmii_txd_2[12]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [12])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_9  (
    .C(usrclk),
    .D(xgmii_txd_2[9]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [9])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_10  (
    .C(usrclk),
    .D(xgmii_txd_2[10]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [10])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_11  (
    .C(usrclk),
    .D(xgmii_txd_2[11]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [11])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_8  (
    .C(usrclk),
    .D(xgmii_txd_2[8]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [8])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_7  (
    .C(usrclk),
    .D(xgmii_txd_2[7]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [7])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_5  (
    .C(usrclk),
    .D(xgmii_txd_2[5]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [5])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_6  (
    .C(usrclk),
    .D(xgmii_txd_2[6]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [6])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_4  (
    .C(usrclk),
    .D(xgmii_txd_2[4]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [4])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_3  (
    .C(usrclk),
    .D(xgmii_txd_2[3]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [3])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_1  (
    .C(usrclk),
    .D(xgmii_txd_2[1]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [1])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_0  (
    .C(usrclk),
    .D(xgmii_txd_2[0]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [0])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_2  (
    .C(usrclk),
    .D(xgmii_txd_2[2]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [2])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_58  (
    .C(usrclk),
    .D(xgmii_txd_2[58]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [58])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_63  (
    .C(usrclk),
    .D(xgmii_txd_2[63]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [63])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_59  (
    .C(usrclk),
    .D(xgmii_txd_2[59]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [59])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_62  (
    .C(usrclk),
    .D(xgmii_txd_2[62]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [62])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_56  (
    .C(usrclk),
    .D(xgmii_txd_2[56]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [56])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_57  (
    .C(usrclk),
    .D(xgmii_txd_2[57]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [57])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_61  (
    .C(usrclk),
    .D(xgmii_txd_2[61]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [61])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_60  (
    .C(usrclk),
    .D(xgmii_txd_2[60]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [60])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_49  (
    .C(usrclk),
    .D(xgmii_txd_2[49]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [49])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_55  (
    .C(usrclk),
    .D(xgmii_txd_2[55]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [55])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_54  (
    .C(usrclk),
    .D(xgmii_txd_2[54]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [54])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_48  (
    .C(usrclk),
    .D(xgmii_txd_2[48]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [48])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_52  (
    .C(usrclk),
    .D(xgmii_txd_2[52]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [52])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_47  (
    .C(usrclk),
    .D(xgmii_txd_2[47]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [47])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_53  (
    .C(usrclk),
    .D(xgmii_txd_2[53]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [53])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_51  (
    .C(usrclk),
    .D(xgmii_txd_2[51]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [51])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_46  (
    .C(usrclk),
    .D(xgmii_txd_2[46]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [46])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_45  (
    .C(usrclk),
    .D(xgmii_txd_2[45]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [45])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_44  (
    .C(usrclk),
    .D(xgmii_txd_2[44]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [44])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_50  (
    .C(usrclk),
    .D(xgmii_txd_2[50]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [50])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_43  (
    .C(usrclk),
    .D(xgmii_txd_2[43]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [43])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_38  (
    .C(usrclk),
    .D(xgmii_txd_2[38]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [38])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_39  (
    .C(usrclk),
    .D(xgmii_txd_2[39]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [39])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_37  (
    .C(usrclk),
    .D(xgmii_txd_2[37]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [37])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_41  (
    .C(usrclk),
    .D(xgmii_txd_2[41]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [41])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_42  (
    .C(usrclk),
    .D(xgmii_txd_2[42]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [42])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_36  (
    .C(usrclk),
    .D(xgmii_txd_2[36]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [36])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_40  (
    .C(usrclk),
    .D(xgmii_txd_2[40]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [40])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_34  (
    .C(usrclk),
    .D(xgmii_txd_2[34]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [34])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_29  (
    .C(usrclk),
    .D(xgmii_txd_2[29]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [29])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_35  (
    .C(usrclk),
    .D(xgmii_txd_2[35]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [35])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_33  (
    .C(usrclk),
    .D(xgmii_txd_2[33]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [33])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_28  (
    .C(usrclk),
    .D(xgmii_txd_2[28]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [28])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_27  (
    .C(usrclk),
    .D(xgmii_txd_2[27]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [27])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_26  (
    .C(usrclk),
    .D(xgmii_txd_2[26]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [26])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_32  (
    .C(usrclk),
    .D(xgmii_txd_2[32]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [32])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_31  (
    .C(usrclk),
    .D(xgmii_txd_2[31]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [31])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_7  (
    .C(usrclk),
    .D(xgmii_txc_3[7]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [7])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_6  (
    .C(usrclk),
    .D(xgmii_txc_3[6]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [6])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_5  (
    .C(usrclk),
    .D(xgmii_txc_3[5]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [5])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_4  (
    .C(usrclk),
    .D(xgmii_txc_3[4]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [4])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_3  (
    .C(usrclk),
    .D(xgmii_txc_3[3]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [3])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_2  (
    .C(usrclk),
    .D(xgmii_txc_3[2]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [2])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_1  (
    .C(usrclk),
    .D(xgmii_txc_3[1]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [1])
  );
  FDS   \BU2/U0/transmitter/txc_pipe_0  (
    .C(usrclk),
    .D(xgmii_txc_3[0]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txc_pipe [0])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_30  (
    .C(usrclk),
    .D(xgmii_txd_2[30]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [30])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_24  (
    .C(usrclk),
    .D(xgmii_txd_2[24]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [24])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_25  (
    .C(usrclk),
    .D(xgmii_txd_2[25]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [25])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_18  (
    .C(usrclk),
    .D(xgmii_txd_2[18]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [18])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_23  (
    .C(usrclk),
    .D(xgmii_txd_2[23]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [23])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_19  (
    .C(usrclk),
    .D(xgmii_txd_2[19]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [19])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_22  (
    .C(usrclk),
    .D(xgmii_txd_2[22]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [22])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_16  (
    .C(usrclk),
    .D(xgmii_txd_2[16]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [16])
  );
  FDS   \BU2/U0/transmitter/txd_pipe_17  (
    .C(usrclk),
    .D(xgmii_txd_2[17]),
    .S(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [17])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_21  (
    .C(usrclk),
    .D(xgmii_txd_2[21]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [21])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_20  (
    .C(usrclk),
    .D(xgmii_txd_2[20]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [20])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_14  (
    .C(usrclk),
    .D(xgmii_txd_2[14]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [14])
  );
  FDR   \BU2/U0/transmitter/txd_pipe_15  (
    .C(usrclk),
    .D(xgmii_txd_2[15]),
    .R(\BU2/U0/usrclk_reset_345 ),
    .Q(\BU2/U0/transmitter/txd_pipe [15])
  );
  VCC   \BU2/XST_VCC  (
    .P(\BU2/N1 )
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

    wire GSR;
    wire GTS;
    wire PRLD;

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
