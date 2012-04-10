////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.61xd
//  \   \         Application: netgen
//  /   /         Filename: cam.v
// /___/   /\     Timestamp: Mon Feb 27 19:59:29 2012
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -sim -ofmt verilog cam.ngc 
// Device	: xc5vtx240t-ff1759-2
// Input file	: cam.ngc
// Output file	: cam.v
// # of Modules	: 1
// Design Name	: cam_wrapper
// Xilinx        : /opt/Xilinx/13.2/ISE_DS/ISE/
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

module cam (
  CLK, WE, BUSY, MATCH, DIN, WR_ADDR, CMP_DIN, MATCH_ADDR
);
  input CLK;
  input WE;
  output BUSY;
  output MATCH;
  input [47 : 0] DIN;
  input [3 : 0] WR_ADDR;
  input [47 : 0] CMP_DIN;
  output [3 : 0] MATCH_ADDR;

  //synthesis translate_off 

  wire \top_cam/rtl_cam/mlog/match_int_107 ;
  wire N1;
  wire \top_cam/rtl_cam/clog/int_reg_en_i_109 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ;
  wire \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_646 ;
  wire \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_5_647 ;
  wire \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_3_f7_648 ;
  wire \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_51_649 ;
  wire \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_6_650 ;
  wire \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_f7_651 ;
  wire \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[5] ;
  wire \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[2] ;
  wire \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[0] ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl3 ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl2 ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl1 ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl ;
  wire \top_cam/rtl_cam/clog/_n0070 ;
  wire \top_cam/rtl_cam/clog/GND_46_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o ;
  wire \top_cam/rtl_cam/clog/WE_busy_i_AND_32_o ;
  wire \top_cam/rtl_cam/clog/gwsig.end_next_write_669 ;
  wire N2;
  wire N4;
  wire N6;
  wire N8;
  wire N10;
  wire N12;
  wire N14;
  wire N16;
  wire N18;
  wire N20;
  wire N22;
  wire N24;
  wire N26;
  wire N29;
  wire N34;
  wire N36;
  wire N38;
  wire N40;
  wire N42;
  wire N44;
  wire N46;
  wire N48;
  wire N50;
  wire N52;
  wire N54;
  wire N56;
  wire N58;
  wire N60;
  wire N62;
  wire N64;
  wire \top_cam/rtl_cam/clog/int_reg_en_i_1_700 ;
  wire [3 : 0] \top_cam/rtl_cam/mlog/match_addr_bin_int ;
  wire [3 : 0] \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl ;
  wire [15 : 0] \top_cam/rtl_cam/matches ;
  wire [3 : 0] \top_cam/rtl_cam/wr_addr_ilog ;
  wire [47 : 0] \top_cam/rtl_cam/wr_data ;
  wire [47 : 0] \top_cam/rtl_cam/ilog/gwl.din_q ;
  wire [3 : 0] \top_cam/rtl_cam/ilog/gwl.wr_addr_q ;
  wire [11 : 0] \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits ;
  wire [3 : 0] \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg ;
  wire [1 : 1] \top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(6) ;
  wire [2 : 2] \top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) ;
  wire [1 : 1] \top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(2) ;
  assign
    MATCH_ADDR[3] = \top_cam/rtl_cam/mlog/match_addr_bin_int [3],
    MATCH_ADDR[2] = \top_cam/rtl_cam/mlog/match_addr_bin_int [2],
    MATCH_ADDR[1] = \top_cam/rtl_cam/mlog/match_addr_bin_int [1],
    MATCH_ADDR[0] = \top_cam/rtl_cam/mlog/match_addr_bin_int [0],
    MATCH = \top_cam/rtl_cam/mlog/match_int_107 ;
  GND   XST_GND (
    .G(N1)
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_47  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [47]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [47])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_46  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [46]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [46])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_45  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [45]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [45])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_44  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [44]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [44])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_43  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [43]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [43])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_42  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [42]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [42])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_41  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [41]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [41])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_40  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [40]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [40])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_39  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [39]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [39])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_38  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [38]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [38])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_37  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [37]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [37])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_36  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [36]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [36])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_35  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [35]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [35])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_34  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [34]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [34])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_33  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [33]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [33])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_32  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [32]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [32])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_31  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [31]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [31])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_30  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [30]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [30])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_29  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [29]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [29])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_28  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [28]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [28])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_27  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [27]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [27])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_26  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [26]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [26])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_25  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [25]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [25])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_24  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [24]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [24])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_23  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [23]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [23])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_22  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [22]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [22])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_21  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [21]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [21])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_20  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [20]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [20])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_19  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [19]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [19])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_18  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [18]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [18])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_17  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [17]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [17])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_16  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [16]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [16])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_15  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [15]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_14  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [14]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_13  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [13]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_12  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [12]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_11  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [11]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_10  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [10]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_9  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [9]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_8  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [8]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_7  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [7]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_6  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [6]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_5  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [5]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_4  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [4]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [3]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [2]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [1]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data [0]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.wr_addr_q_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .Q(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.wr_addr_q_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .Q(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.wr_addr_q_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .Q(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.wr_addr_q_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .Q(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [0])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [1])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [2])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [3])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [4])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [5])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [6])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [7])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [8])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [9])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [10])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [11])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [12])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [13])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [14])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[0].gini0.psrl  (
    .A0(CMP_DIN[0]),
    .A1(CMP_DIN[1]),
    .A2(CMP_DIN[2]),
    .A3(CMP_DIN[3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[1].gini0.psrl  (
    .A0(CMP_DIN[4]),
    .A1(CMP_DIN[5]),
    .A2(CMP_DIN[6]),
    .A3(CMP_DIN[7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[2].gini0.psrl  (
    .A0(CMP_DIN[8]),
    .A1(CMP_DIN[9]),
    .A2(CMP_DIN[10]),
    .A3(CMP_DIN[11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[3].gini0.psrl  (
    .A0(CMP_DIN[12]),
    .A1(CMP_DIN[13]),
    .A2(CMP_DIN[14]),
    .A3(CMP_DIN[15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[4].gini0.psrl  (
    .A0(CMP_DIN[16]),
    .A1(CMP_DIN[17]),
    .A2(CMP_DIN[18]),
    .A3(CMP_DIN[19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[5].gini0.psrl  (
    .A0(CMP_DIN[20]),
    .A1(CMP_DIN[21]),
    .A2(CMP_DIN[22]),
    .A3(CMP_DIN[23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[6].gini0.psrl  (
    .A0(CMP_DIN[24]),
    .A1(CMP_DIN[25]),
    .A2(CMP_DIN[26]),
    .A3(CMP_DIN[27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[7].gini0.psrl  (
    .A0(CMP_DIN[28]),
    .A1(CMP_DIN[29]),
    .A2(CMP_DIN[30]),
    .A3(CMP_DIN[31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[8].gini0.psrl  (
    .A0(CMP_DIN[32]),
    .A1(CMP_DIN[33]),
    .A2(CMP_DIN[34]),
    .A3(CMP_DIN[35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[9].gini0.psrl  (
    .A0(CMP_DIN[36]),
    .A1(CMP_DIN[37]),
    .A2(CMP_DIN[38]),
    .A3(CMP_DIN[39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[10].gini0.psrl  (
    .A0(CMP_DIN[40]),
    .A1(CMP_DIN[41]),
    .A2(CMP_DIN[42]),
    .A3(CMP_DIN[43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[11].gini0.psrl  (
    .A0(CMP_DIN[44]),
    .A1(CMP_DIN[45]),
    .A2(CMP_DIN[46]),
    .A3(CMP_DIN[47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[0].lsmux.gmux1  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(0) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(0) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[1].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(0) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(1) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(1) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[2].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(1) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(2) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(2) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[3].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(2) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(3) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(3) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[4].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(3) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(4) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(4) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[5].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(4) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(5) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(5) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[6].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(5) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(6) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(6) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[7].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(6) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(7) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(7) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[8].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(7) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(8) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(8) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[9].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(8) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(9) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(9) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[10].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(9) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(10) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(10) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[11].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(10) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(11) ),
    .O(\top_cam/rtl_cam/matches [15])
  );
  MUXF7   \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_3_f7  (
    .I0(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_5_647 ),
    .I1(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_646 ),
    .S(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) [2]),
    .O(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_3_f7_648 )
  );
  MUXF7   \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_f7  (
    .I0(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_6_650 ),
    .I1(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_51_649 ),
    .S(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[2] ),
    .O(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_f7_651 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_int  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[0] ),
    .Q(\top_cam/rtl_cam/mlog/match_int_107 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_int_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [3]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_bin_int [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_int_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [2]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_bin_int [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_int_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [1]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_bin_int [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_int_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [0]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_bin_int [0])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl3 ),
    .S(\top_cam/rtl_cam/clog/_n0070 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl2 ),
    .S(\top_cam/rtl_cam/clog/_n0070 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl1 ),
    .S(\top_cam/rtl_cam/clog/_n0070 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl ),
    .S(\top_cam/rtl_cam/clog/_n0070 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0])
  );
  FDRS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/int_reg_en_i  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .R(\top_cam/rtl_cam/clog/WE_busy_i_AND_32_o ),
    .S(\top_cam/rtl_cam/clog/gwsig.end_next_write_669 ),
    .Q(\top_cam/rtl_cam/clog/int_reg_en_i_109 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/clog/gwsig.end_next_write  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/GND_46_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o ),
    .R(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.end_next_write_669 )
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT11  (
    .I0(WR_ADDR[0]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [0])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT21  (
    .I0(WR_ADDR[1]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [1])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT31  (
    .I0(WR_ADDR[2]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [2])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT41  (
    .I0(WR_ADDR[3]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT110  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [0]),
    .I2(DIN[0]),
    .O(\top_cam/rtl_cam/wr_data [0])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT210  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [1]),
    .I2(DIN[1]),
    .O(\top_cam/rtl_cam/wr_data [1])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT310  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [10]),
    .I2(DIN[10]),
    .O(\top_cam/rtl_cam/wr_data [10])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT49  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [11]),
    .I2(DIN[11]),
    .O(\top_cam/rtl_cam/wr_data [11])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT51  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [12]),
    .I2(DIN[12]),
    .O(\top_cam/rtl_cam/wr_data [12])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT61  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [13]),
    .I2(DIN[13]),
    .O(\top_cam/rtl_cam/wr_data [13])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT71  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [14]),
    .I2(DIN[14]),
    .O(\top_cam/rtl_cam/wr_data [14])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT81  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [15]),
    .I2(DIN[15]),
    .O(\top_cam/rtl_cam/wr_data [15])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT91  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [16]),
    .I2(DIN[16]),
    .O(\top_cam/rtl_cam/wr_data [16])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT101  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [17]),
    .I2(DIN[17]),
    .O(\top_cam/rtl_cam/wr_data [17])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT111  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [18]),
    .I2(DIN[18]),
    .O(\top_cam/rtl_cam/wr_data [18])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT121  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [19]),
    .I2(DIN[19]),
    .O(\top_cam/rtl_cam/wr_data [19])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT131  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [2]),
    .I2(DIN[2]),
    .O(\top_cam/rtl_cam/wr_data [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT141  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [20]),
    .I2(DIN[20]),
    .O(\top_cam/rtl_cam/wr_data [20])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT151  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [21]),
    .I2(DIN[21]),
    .O(\top_cam/rtl_cam/wr_data [21])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT161  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [22]),
    .I2(DIN[22]),
    .O(\top_cam/rtl_cam/wr_data [22])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT171  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [23]),
    .I2(DIN[23]),
    .O(\top_cam/rtl_cam/wr_data [23])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT181  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [24]),
    .I2(DIN[24]),
    .O(\top_cam/rtl_cam/wr_data [24])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT191  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [25]),
    .I2(DIN[25]),
    .O(\top_cam/rtl_cam/wr_data [25])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT201  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [26]),
    .I2(DIN[26]),
    .O(\top_cam/rtl_cam/wr_data [26])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT211  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [27]),
    .I2(DIN[27]),
    .O(\top_cam/rtl_cam/wr_data [27])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT221  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [28]),
    .I2(DIN[28]),
    .O(\top_cam/rtl_cam/wr_data [28])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT231  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [29]),
    .I2(DIN[29]),
    .O(\top_cam/rtl_cam/wr_data [29])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT241  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [3]),
    .I2(DIN[3]),
    .O(\top_cam/rtl_cam/wr_data [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT251  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [30]),
    .I2(DIN[30]),
    .O(\top_cam/rtl_cam/wr_data [30])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT261  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [31]),
    .I2(DIN[31]),
    .O(\top_cam/rtl_cam/wr_data [31])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT271  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [32]),
    .I2(DIN[32]),
    .O(\top_cam/rtl_cam/wr_data [32])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT281  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [33]),
    .I2(DIN[33]),
    .O(\top_cam/rtl_cam/wr_data [33])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT291  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [34]),
    .I2(DIN[34]),
    .O(\top_cam/rtl_cam/wr_data [34])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT301  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [35]),
    .I2(DIN[35]),
    .O(\top_cam/rtl_cam/wr_data [35])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT311  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [36]),
    .I2(DIN[36]),
    .O(\top_cam/rtl_cam/wr_data [36])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT321  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [37]),
    .I2(DIN[37]),
    .O(\top_cam/rtl_cam/wr_data [37])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT331  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [38]),
    .I2(DIN[38]),
    .O(\top_cam/rtl_cam/wr_data [38])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT341  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [39]),
    .I2(DIN[39]),
    .O(\top_cam/rtl_cam/wr_data [39])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT351  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [4]),
    .I2(DIN[4]),
    .O(\top_cam/rtl_cam/wr_data [4])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT361  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [40]),
    .I2(DIN[40]),
    .O(\top_cam/rtl_cam/wr_data [40])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT371  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [41]),
    .I2(DIN[41]),
    .O(\top_cam/rtl_cam/wr_data [41])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT381  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [42]),
    .I2(DIN[42]),
    .O(\top_cam/rtl_cam/wr_data [42])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT391  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [43]),
    .I2(DIN[43]),
    .O(\top_cam/rtl_cam/wr_data [43])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT401  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [44]),
    .I2(DIN[44]),
    .O(\top_cam/rtl_cam/wr_data [44])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT411  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [45]),
    .I2(DIN[45]),
    .O(\top_cam/rtl_cam/wr_data [45])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT421  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [46]),
    .I2(DIN[46]),
    .O(\top_cam/rtl_cam/wr_data [46])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT431  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [47]),
    .I2(DIN[47]),
    .O(\top_cam/rtl_cam/wr_data [47])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT441  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [5]),
    .I2(DIN[5]),
    .O(\top_cam/rtl_cam/wr_data [5])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT451  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [6]),
    .I2(DIN[6]),
    .O(\top_cam/rtl_cam/wr_data [6])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT461  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [7]),
    .I2(DIN[7]),
    .O(\top_cam/rtl_cam/wr_data [7])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT471  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [8]),
    .I2(DIN[8]),
    .O(\top_cam/rtl_cam/wr_data [8])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[47]_DIN[47]_mux_5_OUT481  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [9]),
    .I2(DIN[9]),
    .O(\top_cam/rtl_cam/wr_data [9])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(6)(1)1  (
    .I0(\top_cam/rtl_cam/matches [1]),
    .I1(\top_cam/rtl_cam/matches [0]),
    .O(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(6) [1])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red(5)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [4]),
    .O(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[5] )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(2)(1)1  (
    .I0(\top_cam/rtl_cam/matches [9]),
    .I1(\top_cam/rtl_cam/matches [8]),
    .O(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(2) [1])
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \top_cam/rtl_cam/clog/GND_46_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o(3)1  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/clog/GND_46_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o )
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(9)4  (
    .I0(N2),
    .I1(\top_cam/rtl_cam/wr_data [38]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [39]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(8)4  (
    .I0(N4),
    .I1(\top_cam/rtl_cam/wr_data [34]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [35]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(7)4  (
    .I0(N6),
    .I1(\top_cam/rtl_cam/wr_data [30]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [31]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(6)4  (
    .I0(N8),
    .I1(\top_cam/rtl_cam/wr_data [26]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [27]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(5)4  (
    .I0(N10),
    .I1(\top_cam/rtl_cam/wr_data [22]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [23]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(4)4  (
    .I0(N12),
    .I1(\top_cam/rtl_cam/wr_data [18]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [19]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(3)4  (
    .I0(N14),
    .I1(\top_cam/rtl_cam/wr_data [14]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [15]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(2)4  (
    .I0(N16),
    .I1(\top_cam/rtl_cam/wr_data [10]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [11]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(11)4  (
    .I0(N18),
    .I1(\top_cam/rtl_cam/wr_data [46]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [47]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(10)4  (
    .I0(N20),
    .I1(\top_cam/rtl_cam/wr_data [42]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [43]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(1)4  (
    .I0(N22),
    .I1(\top_cam/rtl_cam/wr_data [6]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [7]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1])
  );
  LUT5 #(
    .INIT ( 32'h41000041 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(0)4  (
    .I0(N24),
    .I1(\top_cam/rtl_cam/wr_data [2]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I4(\top_cam/rtl_cam/wr_data [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(2)1_SW1  (
    .I0(\top_cam/rtl_cam/matches [3]),
    .I1(\top_cam/rtl_cam/matches [2]),
    .O(N29)
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_51  (
    .I0(\top_cam/rtl_cam/matches [8]),
    .I1(\top_cam/rtl_cam/matches [9]),
    .I2(\top_cam/rtl_cam/matches [10]),
    .O(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_51_649 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_6  (
    .I0(\top_cam/rtl_cam/matches [12]),
    .I1(\top_cam/rtl_cam/matches [13]),
    .I2(\top_cam/rtl_cam/matches [14]),
    .O(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_6_650 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/matches [1]),
    .I2(\top_cam/rtl_cam/matches [2]),
    .O(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_646 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_5  (
    .I0(\top_cam/rtl_cam/matches [4]),
    .I1(\top_cam/rtl_cam/matches [5]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .O(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_5_647 )
  );
  LUT6 #(
    .INIT ( 64'h0F0F00EE0F0F00FF ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(1)  (
    .I0(\top_cam/rtl_cam/matches [6]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(6) [1]),
    .I3(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[5] ),
    .I4(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) [2]),
    .I5(N26),
    .O(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [1])
  );
  LUT6 #(
    .INIT ( 64'h00000001FFFEFFFF ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(0)1  (
    .I0(\top_cam/rtl_cam/matches [6]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[5] ),
    .I3(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) [2]),
    .I4(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_4_f7_651 ),
    .I5(\top_cam/rtl_cam/mlog/Mmux_binad.bin_proc.bin_matches_tmp(0)(0)_3_f7_648 ),
    .O(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [0])
  );
  LUT5 #(
    .INIT ( 32'hFFFEFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N34)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFFFFFC ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted1  (
    .I0(N34),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[0]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[3]),
    .I4(WE),
    .O(N36)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted1  (
    .I0(N36),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted )
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4)(2)(1)1  (
    .I0(\top_cam/rtl_cam/matches [3]),
    .I1(\top_cam/rtl_cam/matches [2]),
    .I2(\top_cam/rtl_cam/matches [1]),
    .I3(\top_cam/rtl_cam/matches [0]),
    .O(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) [2])
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red(2)(1)1  (
    .I0(\top_cam/rtl_cam/matches [11]),
    .I1(\top_cam/rtl_cam/matches [10]),
    .I2(\top_cam/rtl_cam/matches [9]),
    .I3(\top_cam/rtl_cam/matches [8]),
    .O(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[2] )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF1110 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(1)_SW0  (
    .I0(\top_cam/rtl_cam/matches [11]),
    .I1(\top_cam/rtl_cam/matches [10]),
    .I2(\top_cam/rtl_cam/matches [13]),
    .I3(\top_cam/rtl_cam/matches [12]),
    .I4(\top_cam/rtl_cam/matches [9]),
    .I5(\top_cam/rtl_cam/matches [8]),
    .O(N26)
  );
  LUT6 #(
    .INIT ( 64'h000000000000FFFE ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(2)1_SW3  (
    .I0(\top_cam/rtl_cam/matches [11]),
    .I1(\top_cam/rtl_cam/matches [10]),
    .I2(\top_cam/rtl_cam/matches [8]),
    .I3(\top_cam/rtl_cam/matches [9]),
    .I4(\top_cam/rtl_cam/matches [6]),
    .I5(\top_cam/rtl_cam/matches [7]),
    .O(N38)
  );
  LUT6 #(
    .INIT ( 64'h000F0000000F0011 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(2)1  (
    .I0(\top_cam/rtl_cam/matches [3]),
    .I1(\top_cam/rtl_cam/matches [2]),
    .I2(N29),
    .I3(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(6) [1]),
    .I4(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[5] ),
    .I5(N38),
    .O(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [2])
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[0]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[2]),
    .I4(WE),
    .O(N40)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted1  (
    .I0(N40),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hF7FFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N42)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAACFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted1  (
    .I0(N42),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N44)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted1  (
    .I0(N44),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N46)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted1  (
    .I0(N46),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red(0)(3)1_SW0_SW0  (
    .I0(\top_cam/rtl_cam/matches [13]),
    .I1(\top_cam/rtl_cam/matches [12]),
    .I2(\top_cam/rtl_cam/matches [11]),
    .I3(\top_cam/rtl_cam/matches [10]),
    .I4(\top_cam/rtl_cam/matches [6]),
    .I5(\top_cam/rtl_cam/matches [14]),
    .O(N48)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \top_cam/rtl_cam/mlog/binad.bin_proc.matches_red(0)(3)1  (
    .I0(\top_cam/rtl_cam/matches [15]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(2) [1]),
    .I3(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[5] ),
    .I4(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) [2]),
    .I5(N48),
    .O(\top_cam/rtl_cam/mlog/binad.bin_proc.matches_red[0] )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[1]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[3]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N50)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted1  (
    .I0(N50),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[1]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[3]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N52)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted1  (
    .I0(N52),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[0]),
    .I2(WR_ADDR[2]),
    .I3(WR_ADDR[1]),
    .I4(WE),
    .O(N54)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted1  (
    .I0(N54),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hF7FFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[1]),
    .I2(WR_ADDR[2]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N56)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAACFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted1  (
    .I0(N56),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[2]),
    .I1(WR_ADDR[3]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N58)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted1  (
    .I0(N58),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[2]),
    .I1(WR_ADDR[3]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N60)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted1  (
    .I0(N60),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[2]),
    .I1(WR_ADDR[0]),
    .I2(WR_ADDR[3]),
    .I3(WR_ADDR[1]),
    .I4(WE),
    .O(N62)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted1  (
    .I0(N62),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hF7FFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[0]),
    .I3(WR_ADDR[1]),
    .I4(WE),
    .O(N64)
  );
  LUT6 #(
    .INIT ( 64'hFFFFBFFF55551555 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted1  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I5(N64),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \top_cam/rtl_cam/mlog/match_addr_bin_bf_reg(3)1  (
    .I0(\top_cam/rtl_cam/matches [4]),
    .I1(\top_cam/rtl_cam/matches [5]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(\top_cam/rtl_cam/matches [7]),
    .I4(\top_cam/rtl_cam/mlog/binad.bin_proc.bin_matches_tmp(4) [2]),
    .O(\top_cam/rtl_cam/mlog/match_addr_bin_bf_reg [3])
  );
  LUT6 #(
    .INIT ( 64'hFFFF4FFFFFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/we_inverted1  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I5(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/we_inverted )
  );
  LUT6 #(
    .INIT ( 64'h2222222222222227 ))
  \top_cam/rtl_cam/clog/_n007011  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I1(WE),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/clog/_n0070 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \top_cam/rtl_cam/clog/WE_busy_i_AND_32_o1  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .O(\top_cam/rtl_cam/clog/WE_busy_i_AND_32_o )
  );
  LUT4 #(
    .INIT ( 16'hEEEB ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl21  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl2 )
  );
  LUT5 #(
    .INIT ( 32'hEEEEEEEB ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl31  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl3 )
  );
  LUT3 #(
    .INIT ( 8'hF9 ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl_xor(1)11  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl1 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl_xor(0)11  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl )
  );
  LUT6 #(
    .INIT ( 64'h4FFFFFFFFFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted1  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I5(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted )
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(9)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [37]),
    .I3(DIN[37]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [36]),
    .O(N2)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(8)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [33]),
    .I3(DIN[33]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [32]),
    .O(N4)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(7)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [29]),
    .I3(DIN[29]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [28]),
    .O(N6)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(6)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [25]),
    .I3(DIN[25]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [24]),
    .O(N8)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(5)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [21]),
    .I3(DIN[21]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [20]),
    .O(N10)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(4)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [17]),
    .I3(DIN[17]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [16]),
    .O(N12)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(3)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [13]),
    .I3(DIN[13]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [12]),
    .O(N14)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(2)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [9]),
    .I3(DIN[9]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [8]),
    .O(N16)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(11)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [45]),
    .I3(DIN[45]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [44]),
    .O(N18)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(10)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [41]),
    .I3(DIN[41]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [40]),
    .O(N20)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(1)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [5]),
    .I3(DIN[5]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [4]),
    .O(N22)
  );
  LUT6 #(
    .INIT ( 64'h569AFFFFFFFF569A ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits(0)4_SW0  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [1]),
    .I3(DIN[1]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I5(\top_cam/rtl_cam/wr_data [0]),
    .O(N24)
  );
  LUT6 #(
    .INIT ( 64'h0002000200000002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC21  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) )
  );
  LUT6 #(
    .INIT ( 64'h0001000100000001 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC17  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) )
  );
  LUT6 #(
    .INIT ( 64'h0200020000000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC101  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) )
  );
  LUT6 #(
    .INIT ( 64'h0002000200000002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC91  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) )
  );
  LUT6 #(
    .INIT ( 64'h0200020000000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC121  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) )
  );
  LUT6 #(
    .INIT ( 64'h0002000200000002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC111  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) )
  );
  LUT6 #(
    .INIT ( 64'h0800080000000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC141  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) )
  );
  LUT6 #(
    .INIT ( 64'h0200020000000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC131  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) )
  );
  LUT6 #(
    .INIT ( 64'h0200020000000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC161  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) )
  );
  LUT6 #(
    .INIT ( 64'h0002000200000002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC151  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) )
  );
  LUT6 #(
    .INIT ( 64'h0800080000000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC41  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) )
  );
  LUT6 #(
    .INIT ( 64'h0200020000000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC31  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) )
  );
  LUT6 #(
    .INIT ( 64'h0800080000000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC61  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) )
  );
  LUT6 #(
    .INIT ( 64'h0200020000000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC51  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) )
  );
  LUT6 #(
    .INIT ( 64'h8000800000008000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC81  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) )
  );
  LUT6 #(
    .INIT ( 64'h0800080000000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC71  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .I5(WE),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) )
  );
  INV   \top_cam/rtl_cam/reg_en_inv1_INV_0  (
    .I(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 ),
    .O(BUSY)
  );
  FDRS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/int_reg_en_i_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/int_reg_en_i_109 ),
    .R(\top_cam/rtl_cam/clog/WE_busy_i_AND_32_o ),
    .S(\top_cam/rtl_cam/clog/gwsig.end_next_write_669 ),
    .Q(\top_cam/rtl_cam/clog/int_reg_en_i_1_700 )
  );

//synthesis translate_on

endmodule


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

