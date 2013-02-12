////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.61xd
//  \   \         Application: netgen
//  /   /         Filename: tcam.v
// /___/   /\     Timestamp: Thu Sep 13 09:07:40 2012
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -sim -ofmt verilog tcam.ngc 
// Device	: xc5vtx240t-ff1759-2
// Input file	: tcam.ngc
// Output file	: tcam.v
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

module tcam (
  CLK, WE, BUSY, MATCH, DIN, DATA_MASK, WR_ADDR, CMP_DIN, CMP_DATA_MASK, MATCH_ADDR
);
  input CLK;
  input WE;
  output BUSY;
  output MATCH;
  input [31 : 0] DIN;
  input [31 : 0] DATA_MASK;
  input [3 : 0] WR_ADDR;
  input [31 : 0] CMP_DIN;
  input [31 : 0] CMP_DATA_MASK;
  output [15 : 0] MATCH_ADDR;


  //synthesis translate_off 
 

  wire \top_cam/rtl_cam/mlog/match_int_151 ;
  wire N1;
  wire \top_cam/rtl_cam/clog/int_reg_en_i_153 ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(14) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(15) ;
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
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(11) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(12) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(13) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(14) ;
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
  wire \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ;
  wire \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ;
  wire \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[0] ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl3 ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl2 ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl1 ;
  wire \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl ;
  wire \top_cam/rtl_cam/clog/_n0199 ;
  wire \top_cam/rtl_cam/clog/GND_52_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o ;
  wire \top_cam/rtl_cam/clog/WE_busy_i_AND_109_o ;
  wire \top_cam/rtl_cam/clog/gwsig.end_next_write_943 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0)1_945 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0)1_947 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0)1_949 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0)1_951 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0)1_953 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0)1_955 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0)1_957 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0)1_959 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0)1_961 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0)1_963 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0)1_965 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0)1_967 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0)1_969 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0)1_971 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0)1_973 ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0) ;
  wire \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0)1_975 ;
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
  wire N28;
  wire N30;
  wire N32;
  wire N34;
  wire N36;
  wire N38;
  wire N40;
  wire N42;
  wire N44;
  wire \top_cam/rtl_cam/clog/int_reg_en_i_1_998 ;
  wire [15 : 0] \top_cam/rtl_cam/mlog/match_addr_1h_int ;
  wire [3 : 0] \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl ;
  wire [15 : 0] \top_cam/rtl_cam/matches ;
  wire [31 : 0] \top_cam/rtl_cam/wr_din ;
  wire [31 : 0] \top_cam/rtl_cam/wr_data_mask ;
  wire [3 : 0] \top_cam/rtl_cam/wr_addr_ilog ;
  wire [63 : 0] \top_cam/rtl_cam/rd_data ;
  wire [31 : 0] \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q ;
  wire [3 : 0] \top_cam/rtl_cam/ilog/gwl.wr_addr_q ;
  wire [31 : 0] \top_cam/rtl_cam/ilog/gwl.din_q ;
  wire [15 : 0] \top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits ;
  wire [15 : 1] \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg ;
  assign
    MATCH_ADDR[15] = \top_cam/rtl_cam/mlog/match_addr_1h_int [15],
    MATCH_ADDR[14] = \top_cam/rtl_cam/mlog/match_addr_1h_int [14],
    MATCH_ADDR[13] = \top_cam/rtl_cam/mlog/match_addr_1h_int [13],
    MATCH_ADDR[12] = \top_cam/rtl_cam/mlog/match_addr_1h_int [12],
    MATCH_ADDR[11] = \top_cam/rtl_cam/mlog/match_addr_1h_int [11],
    MATCH_ADDR[10] = \top_cam/rtl_cam/mlog/match_addr_1h_int [10],
    MATCH_ADDR[9] = \top_cam/rtl_cam/mlog/match_addr_1h_int [9],
    MATCH_ADDR[8] = \top_cam/rtl_cam/mlog/match_addr_1h_int [8],
    MATCH_ADDR[7] = \top_cam/rtl_cam/mlog/match_addr_1h_int [7],
    MATCH_ADDR[6] = \top_cam/rtl_cam/mlog/match_addr_1h_int [6],
    MATCH_ADDR[5] = \top_cam/rtl_cam/mlog/match_addr_1h_int [5],
    MATCH_ADDR[4] = \top_cam/rtl_cam/mlog/match_addr_1h_int [4],
    MATCH_ADDR[3] = \top_cam/rtl_cam/mlog/match_addr_1h_int [3],
    MATCH_ADDR[2] = \top_cam/rtl_cam/mlog/match_addr_1h_int [2],
    MATCH_ADDR[1] = \top_cam/rtl_cam/mlog/match_addr_1h_int [1],
    MATCH_ADDR[0] = \top_cam/rtl_cam/mlog/match_addr_1h_int [0],
    MATCH = \top_cam/rtl_cam/mlog/match_int_151 ;
  GND   XST_GND (
    .G(N1)
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_31  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [31]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [31])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_30  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [30]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [30])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_29  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [29]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [29])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_28  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [28]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [28])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_27  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [27]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [27])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_26  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [26]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [26])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_25  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [25]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [25])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_24  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [24]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [24])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_23  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [23]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [23])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_22  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [22]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [22])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_21  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [21]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [21])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_20  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [20]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [20])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_19  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [19]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [19])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_18  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [18]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [18])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_17  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [17]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [17])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_16  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [16]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [16])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_15  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [15]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_14  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [14]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_13  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [13]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_12  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [12]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_11  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [11]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_10  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [10]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_9  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [9]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_8  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [8]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_7  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [7]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_6  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [6]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_5  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [5]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_4  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [4]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [3]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [2]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [1]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_data_mask [0]),
    .Q(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [0])
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
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_31  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [31]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [31])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_30  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [30]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [30])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_29  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [29]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [29])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_28  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [28]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [28])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_27  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [27]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [27])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_26  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [26]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [26])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_25  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [25]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [25])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_24  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [24]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [24])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_23  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [23]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [23])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_22  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [22]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [22])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_21  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [21]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [21])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_20  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [20]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [20])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_19  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [19]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [19])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_18  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [18]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [18])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_17  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [17]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [17])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_16  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [16]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [16])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_15  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [15]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_14  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [14]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_13  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [13]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_12  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [12]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_11  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [11]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_10  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [10]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_9  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [9]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_8  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [8]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_7  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [7]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_6  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [6]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_5  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [5]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_4  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [4]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [3]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [2]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [1]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/ilog/gwl.din_q_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/wr_din [0]),
    .Q(\top_cam/rtl_cam/ilog/gwl.din_q [0])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [0])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [1])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [2])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [3])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [4])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [5])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [6])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [7])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [8])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [9])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [10])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [11])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [12])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [13])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [14])
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[0].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [0]),
    .A1(\top_cam/rtl_cam/rd_data [1]),
    .A2(\top_cam/rtl_cam/rd_data [2]),
    .A3(\top_cam/rtl_cam/rd_data [3]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(0) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[1].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [4]),
    .A1(\top_cam/rtl_cam/rd_data [5]),
    .A2(\top_cam/rtl_cam/rd_data [6]),
    .A3(\top_cam/rtl_cam/rd_data [7]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(1) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[2].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [8]),
    .A1(\top_cam/rtl_cam/rd_data [9]),
    .A2(\top_cam/rtl_cam/rd_data [10]),
    .A3(\top_cam/rtl_cam/rd_data [11]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(2) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[3].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [12]),
    .A1(\top_cam/rtl_cam/rd_data [13]),
    .A2(\top_cam/rtl_cam/rd_data [14]),
    .A3(\top_cam/rtl_cam/rd_data [15]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(3) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[4].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [16]),
    .A1(\top_cam/rtl_cam/rd_data [17]),
    .A2(\top_cam/rtl_cam/rd_data [18]),
    .A3(\top_cam/rtl_cam/rd_data [19]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(4) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[5].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [20]),
    .A1(\top_cam/rtl_cam/rd_data [21]),
    .A2(\top_cam/rtl_cam/rd_data [22]),
    .A3(\top_cam/rtl_cam/rd_data [23]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(5) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[6].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [24]),
    .A1(\top_cam/rtl_cam/rd_data [25]),
    .A2(\top_cam/rtl_cam/rd_data [26]),
    .A3(\top_cam/rtl_cam/rd_data [27]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(6) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[7].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [28]),
    .A1(\top_cam/rtl_cam/rd_data [29]),
    .A2(\top_cam/rtl_cam/rd_data [30]),
    .A3(\top_cam/rtl_cam/rd_data [31]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(7) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[8].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [32]),
    .A1(\top_cam/rtl_cam/rd_data [33]),
    .A2(\top_cam/rtl_cam/rd_data [34]),
    .A3(\top_cam/rtl_cam/rd_data [35]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(8) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[9].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [36]),
    .A1(\top_cam/rtl_cam/rd_data [37]),
    .A2(\top_cam/rtl_cam/rd_data [38]),
    .A3(\top_cam/rtl_cam/rd_data [39]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(9) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[10].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [40]),
    .A1(\top_cam/rtl_cam/rd_data [41]),
    .A2(\top_cam/rtl_cam/rd_data [42]),
    .A3(\top_cam/rtl_cam/rd_data [43]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(10) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[11].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [44]),
    .A1(\top_cam/rtl_cam/rd_data [45]),
    .A2(\top_cam/rtl_cam/rd_data [46]),
    .A3(\top_cam/rtl_cam/rd_data [47]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(11) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[12].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [48]),
    .A1(\top_cam/rtl_cam/rd_data [49]),
    .A2(\top_cam/rtl_cam/rd_data [50]),
    .A3(\top_cam/rtl_cam/rd_data [51]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(12) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[13].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [52]),
    .A1(\top_cam/rtl_cam/rd_data [53]),
    .A2(\top_cam/rtl_cam/rd_data [54]),
    .A3(\top_cam/rtl_cam/rd_data [55]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(13) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[14].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [56]),
    .A1(\top_cam/rtl_cam/rd_data [57]),
    .A2(\top_cam/rtl_cam/rd_data [58]),
    .A3(\top_cam/rtl_cam/rd_data [59]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(14) )
  );
  SRL16E #(
    .INIT ( 16'h0000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[15].gini0.psrl  (
    .A0(\top_cam/rtl_cam/rd_data [60]),
    .A1(\top_cam/rtl_cam/rd_data [61]),
    .A2(\top_cam/rtl_cam/rd_data [62]),
    .A3(\top_cam/rtl_cam/rd_data [63]),
    .CE(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) ),
    .CLK(CLK),
    .D(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15]),
    .Q(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(15) )
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
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(11) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[12].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(11) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(12) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(12) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[13].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(12) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(13) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(13) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[14].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(13) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(14) ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(14) )
  );
  MUXCY   \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/gsrl[15].msmux.gmuxn  (
    .CI(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/carry(14) ),
    .DI(N1),
    .S(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/srl16_match(15) ),
    .O(\top_cam/rtl_cam/matches [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_int  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[0] ),
    .Q(\top_cam/rtl_cam/mlog/match_int_151 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_15  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [15]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_14  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [14]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_13  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [13]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_12  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [12]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_11  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [11]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_10  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [10]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_9  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [9]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_8  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [8]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_7  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [7]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_6  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [6]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_5  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [5]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_4  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [4]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [3]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [2]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [1]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_int_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/matches [0]),
    .Q(\top_cam/rtl_cam/mlog/match_addr_1h_int [0])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl3 ),
    .S(\top_cam/rtl_cam/clog/_n0199 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl2 ),
    .S(\top_cam/rtl_cam/clog/_n0199 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl1 ),
    .S(\top_cam/rtl_cam/clog/_n0199 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl ),
    .S(\top_cam/rtl_cam/clog/_n0199 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0])
  );
  FDRS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/int_reg_en_i  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .R(\top_cam/rtl_cam/clog/WE_busy_i_AND_109_o ),
    .S(\top_cam/rtl_cam/clog/gwsig.end_next_write_943 ),
    .Q(\top_cam/rtl_cam/clog/int_reg_en_i_153 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/clog/gwsig.end_next_write  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/GND_52_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o ),
    .R(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .Q(\top_cam/rtl_cam/clog/gwsig.end_next_write_943 )
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[9].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[19]),
    .I1(CMP_DIN[19]),
    .I2(CMP_DATA_MASK[18]),
    .I3(CMP_DIN[18]),
    .O(\top_cam/rtl_cam/rd_data [39])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[9].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[19]),
    .I1(CMP_DIN[19]),
    .I2(CMP_DATA_MASK[18]),
    .I3(CMP_DIN[18]),
    .O(\top_cam/rtl_cam/rd_data [37])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[9].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[18]),
    .I1(CMP_DIN[18]),
    .I2(CMP_DATA_MASK[19]),
    .I3(CMP_DIN[19]),
    .O(\top_cam/rtl_cam/rd_data [38])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[9].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[19]),
    .I1(CMP_DIN[19]),
    .I2(CMP_DATA_MASK[18]),
    .I3(CMP_DIN[18]),
    .O(\top_cam/rtl_cam/rd_data [36])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[8].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[17]),
    .I1(CMP_DIN[17]),
    .I2(CMP_DATA_MASK[16]),
    .I3(CMP_DIN[16]),
    .O(\top_cam/rtl_cam/rd_data [35])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[8].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[17]),
    .I1(CMP_DIN[17]),
    .I2(CMP_DATA_MASK[16]),
    .I3(CMP_DIN[16]),
    .O(\top_cam/rtl_cam/rd_data [33])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[8].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[16]),
    .I1(CMP_DIN[16]),
    .I2(CMP_DATA_MASK[17]),
    .I3(CMP_DIN[17]),
    .O(\top_cam/rtl_cam/rd_data [34])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[8].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[17]),
    .I1(CMP_DIN[17]),
    .I2(CMP_DATA_MASK[16]),
    .I3(CMP_DIN[16]),
    .O(\top_cam/rtl_cam/rd_data [32])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[7].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[15]),
    .I1(CMP_DIN[15]),
    .I2(CMP_DATA_MASK[14]),
    .I3(CMP_DIN[14]),
    .O(\top_cam/rtl_cam/rd_data [31])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[7].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[15]),
    .I1(CMP_DIN[15]),
    .I2(CMP_DATA_MASK[14]),
    .I3(CMP_DIN[14]),
    .O(\top_cam/rtl_cam/rd_data [29])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[7].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[14]),
    .I1(CMP_DIN[14]),
    .I2(CMP_DATA_MASK[15]),
    .I3(CMP_DIN[15]),
    .O(\top_cam/rtl_cam/rd_data [30])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[7].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[15]),
    .I1(CMP_DIN[15]),
    .I2(CMP_DATA_MASK[14]),
    .I3(CMP_DIN[14]),
    .O(\top_cam/rtl_cam/rd_data [28])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[6].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[13]),
    .I1(CMP_DIN[13]),
    .I2(CMP_DATA_MASK[12]),
    .I3(CMP_DIN[12]),
    .O(\top_cam/rtl_cam/rd_data [27])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[6].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[13]),
    .I1(CMP_DIN[13]),
    .I2(CMP_DATA_MASK[12]),
    .I3(CMP_DIN[12]),
    .O(\top_cam/rtl_cam/rd_data [25])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[6].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[12]),
    .I1(CMP_DIN[12]),
    .I2(CMP_DATA_MASK[13]),
    .I3(CMP_DIN[13]),
    .O(\top_cam/rtl_cam/rd_data [26])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[6].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[13]),
    .I1(CMP_DIN[13]),
    .I2(CMP_DATA_MASK[12]),
    .I3(CMP_DIN[12]),
    .O(\top_cam/rtl_cam/rd_data [24])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[5].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[11]),
    .I1(CMP_DIN[11]),
    .I2(CMP_DATA_MASK[10]),
    .I3(CMP_DIN[10]),
    .O(\top_cam/rtl_cam/rd_data [23])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[5].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[11]),
    .I1(CMP_DIN[11]),
    .I2(CMP_DATA_MASK[10]),
    .I3(CMP_DIN[10]),
    .O(\top_cam/rtl_cam/rd_data [21])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[5].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[10]),
    .I1(CMP_DIN[10]),
    .I2(CMP_DATA_MASK[11]),
    .I3(CMP_DIN[11]),
    .O(\top_cam/rtl_cam/rd_data [22])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[5].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[11]),
    .I1(CMP_DIN[11]),
    .I2(CMP_DATA_MASK[10]),
    .I3(CMP_DIN[10]),
    .O(\top_cam/rtl_cam/rd_data [20])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[4].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[9]),
    .I1(CMP_DIN[9]),
    .I2(CMP_DATA_MASK[8]),
    .I3(CMP_DIN[8]),
    .O(\top_cam/rtl_cam/rd_data [19])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[4].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[9]),
    .I1(CMP_DIN[9]),
    .I2(CMP_DATA_MASK[8]),
    .I3(CMP_DIN[8]),
    .O(\top_cam/rtl_cam/rd_data [17])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[4].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[8]),
    .I1(CMP_DIN[8]),
    .I2(CMP_DATA_MASK[9]),
    .I3(CMP_DIN[9]),
    .O(\top_cam/rtl_cam/rd_data [18])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[4].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[9]),
    .I1(CMP_DIN[9]),
    .I2(CMP_DATA_MASK[8]),
    .I3(CMP_DIN[8]),
    .O(\top_cam/rtl_cam/rd_data [16])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[3].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[7]),
    .I1(CMP_DIN[7]),
    .I2(CMP_DATA_MASK[6]),
    .I3(CMP_DIN[6]),
    .O(\top_cam/rtl_cam/rd_data [15])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[3].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[7]),
    .I1(CMP_DIN[7]),
    .I2(CMP_DATA_MASK[6]),
    .I3(CMP_DIN[6]),
    .O(\top_cam/rtl_cam/rd_data [13])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[3].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[6]),
    .I1(CMP_DIN[6]),
    .I2(CMP_DATA_MASK[7]),
    .I3(CMP_DIN[7]),
    .O(\top_cam/rtl_cam/rd_data [14])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[3].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[7]),
    .I1(CMP_DIN[7]),
    .I2(CMP_DATA_MASK[6]),
    .I3(CMP_DIN[6]),
    .O(\top_cam/rtl_cam/rd_data [12])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[2].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[5]),
    .I1(CMP_DIN[5]),
    .I2(CMP_DATA_MASK[4]),
    .I3(CMP_DIN[4]),
    .O(\top_cam/rtl_cam/rd_data [11])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[2].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[5]),
    .I1(CMP_DIN[5]),
    .I2(CMP_DATA_MASK[4]),
    .I3(CMP_DIN[4]),
    .O(\top_cam/rtl_cam/rd_data [9])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[2].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[4]),
    .I1(CMP_DIN[4]),
    .I2(CMP_DATA_MASK[5]),
    .I3(CMP_DIN[5]),
    .O(\top_cam/rtl_cam/rd_data [10])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[2].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[5]),
    .I1(CMP_DIN[5]),
    .I2(CMP_DATA_MASK[4]),
    .I3(CMP_DIN[4]),
    .O(\top_cam/rtl_cam/rd_data [8])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[1].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[3]),
    .I1(CMP_DIN[3]),
    .I2(CMP_DATA_MASK[2]),
    .I3(CMP_DIN[2]),
    .O(\top_cam/rtl_cam/rd_data [7])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[1].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[3]),
    .I1(CMP_DIN[3]),
    .I2(CMP_DATA_MASK[2]),
    .I3(CMP_DIN[2]),
    .O(\top_cam/rtl_cam/rd_data [5])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[1].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[2]),
    .I1(CMP_DIN[2]),
    .I2(CMP_DATA_MASK[3]),
    .I3(CMP_DIN[3]),
    .O(\top_cam/rtl_cam/rd_data [6])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[1].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[3]),
    .I1(CMP_DIN[3]),
    .I2(CMP_DATA_MASK[2]),
    .I3(CMP_DIN[2]),
    .O(\top_cam/rtl_cam/rd_data [4])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[15].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[31]),
    .I1(CMP_DIN[31]),
    .I2(CMP_DATA_MASK[30]),
    .I3(CMP_DIN[30]),
    .O(\top_cam/rtl_cam/rd_data [63])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[15].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[31]),
    .I1(CMP_DIN[31]),
    .I2(CMP_DATA_MASK[30]),
    .I3(CMP_DIN[30]),
    .O(\top_cam/rtl_cam/rd_data [61])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[15].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[30]),
    .I1(CMP_DIN[30]),
    .I2(CMP_DATA_MASK[31]),
    .I3(CMP_DIN[31]),
    .O(\top_cam/rtl_cam/rd_data [62])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[15].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[31]),
    .I1(CMP_DIN[31]),
    .I2(CMP_DATA_MASK[30]),
    .I3(CMP_DIN[30]),
    .O(\top_cam/rtl_cam/rd_data [60])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[14].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[29]),
    .I1(CMP_DIN[29]),
    .I2(CMP_DATA_MASK[28]),
    .I3(CMP_DIN[28]),
    .O(\top_cam/rtl_cam/rd_data [59])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[14].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[29]),
    .I1(CMP_DIN[29]),
    .I2(CMP_DATA_MASK[28]),
    .I3(CMP_DIN[28]),
    .O(\top_cam/rtl_cam/rd_data [57])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[14].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[28]),
    .I1(CMP_DIN[28]),
    .I2(CMP_DATA_MASK[29]),
    .I3(CMP_DIN[29]),
    .O(\top_cam/rtl_cam/rd_data [58])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[14].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[29]),
    .I1(CMP_DIN[29]),
    .I2(CMP_DATA_MASK[28]),
    .I3(CMP_DIN[28]),
    .O(\top_cam/rtl_cam/rd_data [56])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[13].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[27]),
    .I1(CMP_DIN[27]),
    .I2(CMP_DATA_MASK[26]),
    .I3(CMP_DIN[26]),
    .O(\top_cam/rtl_cam/rd_data [55])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[13].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[27]),
    .I1(CMP_DIN[27]),
    .I2(CMP_DATA_MASK[26]),
    .I3(CMP_DIN[26]),
    .O(\top_cam/rtl_cam/rd_data [53])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[13].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[26]),
    .I1(CMP_DIN[26]),
    .I2(CMP_DATA_MASK[27]),
    .I3(CMP_DIN[27]),
    .O(\top_cam/rtl_cam/rd_data [54])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[13].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[27]),
    .I1(CMP_DIN[27]),
    .I2(CMP_DATA_MASK[26]),
    .I3(CMP_DIN[26]),
    .O(\top_cam/rtl_cam/rd_data [52])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[12].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[25]),
    .I1(CMP_DIN[25]),
    .I2(CMP_DATA_MASK[24]),
    .I3(CMP_DIN[24]),
    .O(\top_cam/rtl_cam/rd_data [51])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[12].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[25]),
    .I1(CMP_DIN[25]),
    .I2(CMP_DATA_MASK[24]),
    .I3(CMP_DIN[24]),
    .O(\top_cam/rtl_cam/rd_data [49])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[12].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[24]),
    .I1(CMP_DIN[24]),
    .I2(CMP_DATA_MASK[25]),
    .I3(CMP_DIN[25]),
    .O(\top_cam/rtl_cam/rd_data [50])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[12].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[25]),
    .I1(CMP_DIN[25]),
    .I2(CMP_DATA_MASK[24]),
    .I3(CMP_DIN[24]),
    .O(\top_cam/rtl_cam/rd_data [48])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[11].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[23]),
    .I1(CMP_DIN[23]),
    .I2(CMP_DATA_MASK[22]),
    .I3(CMP_DIN[22]),
    .O(\top_cam/rtl_cam/rd_data [47])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[11].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[23]),
    .I1(CMP_DIN[23]),
    .I2(CMP_DATA_MASK[22]),
    .I3(CMP_DIN[22]),
    .O(\top_cam/rtl_cam/rd_data [45])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[11].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[22]),
    .I1(CMP_DIN[22]),
    .I2(CMP_DATA_MASK[23]),
    .I3(CMP_DIN[23]),
    .O(\top_cam/rtl_cam/rd_data [46])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[11].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[23]),
    .I1(CMP_DIN[23]),
    .I2(CMP_DATA_MASK[22]),
    .I3(CMP_DIN[22]),
    .O(\top_cam/rtl_cam/rd_data [44])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[10].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[21]),
    .I1(CMP_DIN[21]),
    .I2(CMP_DATA_MASK[20]),
    .I3(CMP_DIN[20]),
    .O(\top_cam/rtl_cam/rd_data [43])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[10].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[21]),
    .I1(CMP_DIN[21]),
    .I2(CMP_DATA_MASK[20]),
    .I3(CMP_DIN[20]),
    .O(\top_cam/rtl_cam/rd_data [41])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[10].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[20]),
    .I1(CMP_DIN[20]),
    .I2(CMP_DATA_MASK[21]),
    .I3(CMP_DIN[21]),
    .O(\top_cam/rtl_cam/rd_data [42])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[10].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[21]),
    .I1(CMP_DIN[21]),
    .I2(CMP_DATA_MASK[20]),
    .I3(CMP_DIN[20]),
    .O(\top_cam/rtl_cam/rd_data [40])
  );
  LUT4 #(
    .INIT ( 16'hB0BB ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[0].ternblk/TERNARY_DATA(3)1  (
    .I0(CMP_DATA_MASK[1]),
    .I1(CMP_DIN[1]),
    .I2(CMP_DATA_MASK[0]),
    .I3(CMP_DIN[0]),
    .O(\top_cam/rtl_cam/rd_data [3])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[0].ternblk/TERNARY_DATA(1)1  (
    .I0(CMP_DATA_MASK[1]),
    .I1(CMP_DIN[1]),
    .I2(CMP_DATA_MASK[0]),
    .I3(CMP_DIN[0]),
    .O(\top_cam/rtl_cam/rd_data [1])
  );
  LUT4 #(
    .INIT ( 16'hE0EE ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[0].ternblk/TERNARY_DATA(2)1  (
    .I0(CMP_DATA_MASK[0]),
    .I1(CMP_DIN[0]),
    .I2(CMP_DATA_MASK[1]),
    .I3(CMP_DIN[1]),
    .O(\top_cam/rtl_cam/rd_data [2])
  );
  LUT4 #(
    .INIT ( 16'hEEE0 ))
  \top_cam/rtl_cam/ilog/grt.rddatatern/gtern[0].ternblk/TERNARY_DATA(0)1  (
    .I0(CMP_DATA_MASK[1]),
    .I1(CMP_DIN[1]),
    .I2(CMP_DATA_MASK[0]),
    .I3(CMP_DIN[0]),
    .O(\top_cam/rtl_cam/rd_data [0])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT11  (
    .I0(WR_ADDR[0]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [0])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT21  (
    .I0(WR_ADDR[1]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [1])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT31  (
    .I0(WR_ADDR[2]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [2])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT41  (
    .I0(WR_ADDR[3]),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/wr_addr_ilog [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT110  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [0]),
    .I2(DATA_MASK[0]),
    .O(\top_cam/rtl_cam/wr_data_mask [0])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT210  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [1]),
    .I2(DATA_MASK[1]),
    .O(\top_cam/rtl_cam/wr_data_mask [1])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT33  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [10]),
    .I2(DATA_MASK[10]),
    .O(\top_cam/rtl_cam/wr_data_mask [10])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT41  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [11]),
    .I2(DATA_MASK[11]),
    .O(\top_cam/rtl_cam/wr_data_mask [11])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT51  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [12]),
    .I2(DATA_MASK[12]),
    .O(\top_cam/rtl_cam/wr_data_mask [12])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT61  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [13]),
    .I2(DATA_MASK[13]),
    .O(\top_cam/rtl_cam/wr_data_mask [13])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT71  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [14]),
    .I2(DATA_MASK[14]),
    .O(\top_cam/rtl_cam/wr_data_mask [14])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT81  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [15]),
    .I2(DATA_MASK[15]),
    .O(\top_cam/rtl_cam/wr_data_mask [15])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT91  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [16]),
    .I2(DATA_MASK[16]),
    .O(\top_cam/rtl_cam/wr_data_mask [16])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT101  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [17]),
    .I2(DATA_MASK[17]),
    .O(\top_cam/rtl_cam/wr_data_mask [17])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT111  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [18]),
    .I2(DATA_MASK[18]),
    .O(\top_cam/rtl_cam/wr_data_mask [18])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT121  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [19]),
    .I2(DATA_MASK[19]),
    .O(\top_cam/rtl_cam/wr_data_mask [19])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT131  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [2]),
    .I2(DATA_MASK[2]),
    .O(\top_cam/rtl_cam/wr_data_mask [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT141  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [20]),
    .I2(DATA_MASK[20]),
    .O(\top_cam/rtl_cam/wr_data_mask [20])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT151  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [21]),
    .I2(DATA_MASK[21]),
    .O(\top_cam/rtl_cam/wr_data_mask [21])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT161  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [22]),
    .I2(DATA_MASK[22]),
    .O(\top_cam/rtl_cam/wr_data_mask [22])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT171  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [23]),
    .I2(DATA_MASK[23]),
    .O(\top_cam/rtl_cam/wr_data_mask [23])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT181  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [24]),
    .I2(DATA_MASK[24]),
    .O(\top_cam/rtl_cam/wr_data_mask [24])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT191  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [25]),
    .I2(DATA_MASK[25]),
    .O(\top_cam/rtl_cam/wr_data_mask [25])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT201  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [26]),
    .I2(DATA_MASK[26]),
    .O(\top_cam/rtl_cam/wr_data_mask [26])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT211  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [27]),
    .I2(DATA_MASK[27]),
    .O(\top_cam/rtl_cam/wr_data_mask [27])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT221  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [28]),
    .I2(DATA_MASK[28]),
    .O(\top_cam/rtl_cam/wr_data_mask [28])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT231  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [29]),
    .I2(DATA_MASK[29]),
    .O(\top_cam/rtl_cam/wr_data_mask [29])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT241  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [3]),
    .I2(DATA_MASK[3]),
    .O(\top_cam/rtl_cam/wr_data_mask [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT251  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [30]),
    .I2(DATA_MASK[30]),
    .O(\top_cam/rtl_cam/wr_data_mask [30])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT261  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [31]),
    .I2(DATA_MASK[31]),
    .O(\top_cam/rtl_cam/wr_data_mask [31])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT271  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [4]),
    .I2(DATA_MASK[4]),
    .O(\top_cam/rtl_cam/wr_data_mask [4])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT281  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [5]),
    .I2(DATA_MASK[5]),
    .O(\top_cam/rtl_cam/wr_data_mask [5])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT291  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [6]),
    .I2(DATA_MASK[6]),
    .O(\top_cam/rtl_cam/wr_data_mask [6])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT301  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [7]),
    .I2(DATA_MASK[7]),
    .O(\top_cam/rtl_cam/wr_data_mask [7])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT311  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [8]),
    .I2(DATA_MASK[8]),
    .O(\top_cam/rtl_cam/wr_data_mask [8])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.gwdt.data_mask_q[31]_DATA_MASK[31]_mux_3_OUT321  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.gwdt.data_mask_q [9]),
    .I2(DATA_MASK[9]),
    .O(\top_cam/rtl_cam/wr_data_mask [9])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT110  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [0]),
    .I2(DIN[0]),
    .O(\top_cam/rtl_cam/wr_din [0])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT210  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [1]),
    .I2(DIN[1]),
    .O(\top_cam/rtl_cam/wr_din [1])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT33  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [10]),
    .I2(DIN[10]),
    .O(\top_cam/rtl_cam/wr_din [10])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT41  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [11]),
    .I2(DIN[11]),
    .O(\top_cam/rtl_cam/wr_din [11])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT51  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [12]),
    .I2(DIN[12]),
    .O(\top_cam/rtl_cam/wr_din [12])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT61  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [13]),
    .I2(DIN[13]),
    .O(\top_cam/rtl_cam/wr_din [13])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT71  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [14]),
    .I2(DIN[14]),
    .O(\top_cam/rtl_cam/wr_din [14])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT81  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [15]),
    .I2(DIN[15]),
    .O(\top_cam/rtl_cam/wr_din [15])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT91  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [16]),
    .I2(DIN[16]),
    .O(\top_cam/rtl_cam/wr_din [16])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT101  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [17]),
    .I2(DIN[17]),
    .O(\top_cam/rtl_cam/wr_din [17])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT111  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [18]),
    .I2(DIN[18]),
    .O(\top_cam/rtl_cam/wr_din [18])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT121  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [19]),
    .I2(DIN[19]),
    .O(\top_cam/rtl_cam/wr_din [19])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT131  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [2]),
    .I2(DIN[2]),
    .O(\top_cam/rtl_cam/wr_din [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT141  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [20]),
    .I2(DIN[20]),
    .O(\top_cam/rtl_cam/wr_din [20])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT151  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [21]),
    .I2(DIN[21]),
    .O(\top_cam/rtl_cam/wr_din [21])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT161  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [22]),
    .I2(DIN[22]),
    .O(\top_cam/rtl_cam/wr_din [22])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT171  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [23]),
    .I2(DIN[23]),
    .O(\top_cam/rtl_cam/wr_din [23])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT181  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [24]),
    .I2(DIN[24]),
    .O(\top_cam/rtl_cam/wr_din [24])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT191  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [25]),
    .I2(DIN[25]),
    .O(\top_cam/rtl_cam/wr_din [25])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT201  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [26]),
    .I2(DIN[26]),
    .O(\top_cam/rtl_cam/wr_din [26])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT211  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [27]),
    .I2(DIN[27]),
    .O(\top_cam/rtl_cam/wr_din [27])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT221  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [28]),
    .I2(DIN[28]),
    .O(\top_cam/rtl_cam/wr_din [28])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT231  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [29]),
    .I2(DIN[29]),
    .O(\top_cam/rtl_cam/wr_din [29])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT241  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [3]),
    .I2(DIN[3]),
    .O(\top_cam/rtl_cam/wr_din [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT251  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [30]),
    .I2(DIN[30]),
    .O(\top_cam/rtl_cam/wr_din [30])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT261  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [31]),
    .I2(DIN[31]),
    .O(\top_cam/rtl_cam/wr_din [31])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT271  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [4]),
    .I2(DIN[4]),
    .O(\top_cam/rtl_cam/wr_din [4])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT281  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [5]),
    .I2(DIN[5]),
    .O(\top_cam/rtl_cam/wr_din [5])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT291  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [6]),
    .I2(DIN[6]),
    .O(\top_cam/rtl_cam/wr_din [6])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT301  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [7]),
    .I2(DIN[7]),
    .O(\top_cam/rtl_cam/wr_din [7])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT311  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [8]),
    .I2(DIN[8]),
    .O(\top_cam/rtl_cam/wr_din [8])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_7_OUT321  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [9]),
    .I2(DIN[9]),
    .O(\top_cam/rtl_cam/wr_din [9])
  );
  LUT4 #(
    .INIT ( 16'h0010 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(6)(9)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [4]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [6])
  );
  LUT5 #(
    .INIT ( 32'h00000010 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [4]),
    .I2(\top_cam/rtl_cam/matches [7]),
    .I3(\top_cam/rtl_cam/matches [6]),
    .I4(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [7])
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(2)(4)1  (
    .I0(\top_cam/rtl_cam/matches [11]),
    .I1(\top_cam/rtl_cam/matches [9]),
    .I2(\top_cam/rtl_cam/matches [8]),
    .I3(\top_cam/rtl_cam/matches [10]),
    .O(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] )
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(2)1  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/matches [2]),
    .I2(\top_cam/rtl_cam/matches [1]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [2])
  );
  LUT4 #(
    .INIT ( 16'h0004 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(3)(12)1  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/matches [3]),
    .I2(\top_cam/rtl_cam/matches [2]),
    .I3(\top_cam/rtl_cam/matches [1]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [3])
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(6)(12)1  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/matches [3]),
    .I2(\top_cam/rtl_cam/matches [2]),
    .I3(\top_cam/rtl_cam/matches [1]),
    .O(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(1)1  (
    .I0(\top_cam/rtl_cam/matches [1]),
    .I1(\top_cam/rtl_cam/matches [0]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [1])
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \top_cam/rtl_cam/clog/GND_52_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o1  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/clog/GND_52_o_gwsig.gsrl.wr_count_integer_srl[3]_equal_4_o )
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [1]),
    .I1(\top_cam/rtl_cam/wr_data_mask [1]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [0]),
    .I4(\top_cam/rtl_cam/wr_data_mask [0]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [1]),
    .I1(\top_cam/rtl_cam/wr_din [1]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [0]),
    .I4(\top_cam/rtl_cam/wr_data_mask [0]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0)1_945 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[0].tern.wr_comp/WR_DATA_BIT(0)1_945 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [0])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [3]),
    .I1(\top_cam/rtl_cam/wr_data_mask [3]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [2]),
    .I4(\top_cam/rtl_cam/wr_data_mask [2]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [3]),
    .I1(\top_cam/rtl_cam/wr_din [3]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [2]),
    .I4(\top_cam/rtl_cam/wr_data_mask [2]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0)1_947 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[1].tern.wr_comp/WR_DATA_BIT(0)1_947 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [1])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [5]),
    .I1(\top_cam/rtl_cam/wr_data_mask [5]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [4]),
    .I4(\top_cam/rtl_cam/wr_data_mask [4]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [5]),
    .I1(\top_cam/rtl_cam/wr_din [5]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [4]),
    .I4(\top_cam/rtl_cam/wr_data_mask [4]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0)1_949 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[2].tern.wr_comp/WR_DATA_BIT(0)1_949 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [2])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [7]),
    .I1(\top_cam/rtl_cam/wr_data_mask [7]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [6]),
    .I4(\top_cam/rtl_cam/wr_data_mask [6]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [7]),
    .I1(\top_cam/rtl_cam/wr_din [7]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [6]),
    .I4(\top_cam/rtl_cam/wr_data_mask [6]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0)1_951 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[3].tern.wr_comp/WR_DATA_BIT(0)1_951 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [3])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [9]),
    .I1(\top_cam/rtl_cam/wr_data_mask [9]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [8]),
    .I4(\top_cam/rtl_cam/wr_data_mask [8]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [9]),
    .I1(\top_cam/rtl_cam/wr_din [9]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [8]),
    .I4(\top_cam/rtl_cam/wr_data_mask [8]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0)1_953 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[4].tern.wr_comp/WR_DATA_BIT(0)1_953 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [4])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [11]),
    .I1(\top_cam/rtl_cam/wr_data_mask [11]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [10]),
    .I4(\top_cam/rtl_cam/wr_data_mask [10]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [11]),
    .I1(\top_cam/rtl_cam/wr_din [11]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [10]),
    .I4(\top_cam/rtl_cam/wr_data_mask [10]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0)1_955 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[5].tern.wr_comp/WR_DATA_BIT(0)1_955 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [5])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [13]),
    .I1(\top_cam/rtl_cam/wr_data_mask [13]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [12]),
    .I4(\top_cam/rtl_cam/wr_data_mask [12]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [13]),
    .I1(\top_cam/rtl_cam/wr_din [13]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [12]),
    .I4(\top_cam/rtl_cam/wr_data_mask [12]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0)1_957 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[6].tern.wr_comp/WR_DATA_BIT(0)1_957 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [6])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [15]),
    .I1(\top_cam/rtl_cam/wr_data_mask [15]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [14]),
    .I4(\top_cam/rtl_cam/wr_data_mask [14]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [15]),
    .I1(\top_cam/rtl_cam/wr_din [15]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [14]),
    .I4(\top_cam/rtl_cam/wr_data_mask [14]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0)1_959 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[7].tern.wr_comp/WR_DATA_BIT(0)1_959 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [7])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [17]),
    .I1(\top_cam/rtl_cam/wr_data_mask [17]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [16]),
    .I4(\top_cam/rtl_cam/wr_data_mask [16]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [17]),
    .I1(\top_cam/rtl_cam/wr_din [17]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [16]),
    .I4(\top_cam/rtl_cam/wr_data_mask [16]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0)1_961 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[8].tern.wr_comp/WR_DATA_BIT(0)1_961 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [8])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [19]),
    .I1(\top_cam/rtl_cam/wr_data_mask [19]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [18]),
    .I4(\top_cam/rtl_cam/wr_data_mask [18]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [19]),
    .I1(\top_cam/rtl_cam/wr_din [19]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [18]),
    .I4(\top_cam/rtl_cam/wr_data_mask [18]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0)1_963 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[9].tern.wr_comp/WR_DATA_BIT(0)1_963 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [9])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [21]),
    .I1(\top_cam/rtl_cam/wr_data_mask [21]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [20]),
    .I4(\top_cam/rtl_cam/wr_data_mask [20]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [21]),
    .I1(\top_cam/rtl_cam/wr_din [21]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [20]),
    .I4(\top_cam/rtl_cam/wr_data_mask [20]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0)1_965 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[10].tern.wr_comp/WR_DATA_BIT(0)1_965 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [10])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [23]),
    .I1(\top_cam/rtl_cam/wr_data_mask [23]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [22]),
    .I4(\top_cam/rtl_cam/wr_data_mask [22]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [23]),
    .I1(\top_cam/rtl_cam/wr_din [23]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [22]),
    .I4(\top_cam/rtl_cam/wr_data_mask [22]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0)1_967 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[11].tern.wr_comp/WR_DATA_BIT(0)1_967 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [11])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [25]),
    .I1(\top_cam/rtl_cam/wr_data_mask [25]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [24]),
    .I4(\top_cam/rtl_cam/wr_data_mask [24]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [25]),
    .I1(\top_cam/rtl_cam/wr_din [25]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [24]),
    .I4(\top_cam/rtl_cam/wr_data_mask [24]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0)1_969 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[12].tern.wr_comp/WR_DATA_BIT(0)1_969 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [12])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [27]),
    .I1(\top_cam/rtl_cam/wr_data_mask [27]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [26]),
    .I4(\top_cam/rtl_cam/wr_data_mask [26]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [27]),
    .I1(\top_cam/rtl_cam/wr_din [27]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [26]),
    .I4(\top_cam/rtl_cam/wr_data_mask [26]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0)1_971 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[13].tern.wr_comp/WR_DATA_BIT(0)1_971 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [13])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [29]),
    .I1(\top_cam/rtl_cam/wr_data_mask [29]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [28]),
    .I4(\top_cam/rtl_cam/wr_data_mask [28]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [29]),
    .I1(\top_cam/rtl_cam/wr_din [29]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [28]),
    .I4(\top_cam/rtl_cam/wr_data_mask [28]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0)1_973 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[14].tern.wr_comp/WR_DATA_BIT(0)1_973 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [14])
  );
  LUT6 #(
    .INIT ( 64'hEEEEE0EEE0E0E000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0)1  (
    .I0(\top_cam/rtl_cam/wr_din [31]),
    .I1(\top_cam/rtl_cam/wr_data_mask [31]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/wr_din [30]),
    .I4(\top_cam/rtl_cam/wr_data_mask [30]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0) )
  );
  LUT6 #(
    .INIT ( 64'hBBBBB0BBB0B0B000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0)2  (
    .I0(\top_cam/rtl_cam/wr_data_mask [31]),
    .I1(\top_cam/rtl_cam/wr_din [31]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/wr_din [30]),
    .I4(\top_cam/rtl_cam/wr_data_mask [30]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0)1_975 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0)3  (
    .I0(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0) ),
    .I1(\top_cam/rtl_cam/mem/gsrl.srlmem/loopc[15].tern.wr_comp/WR_DATA_BIT(0)1_975 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/wr_data_bits [15])
  );
  LUT6 #(
    .INIT ( 64'h0000000000000002 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(8)1  (
    .I0(\top_cam/rtl_cam/matches [8]),
    .I1(\top_cam/rtl_cam/matches [5]),
    .I2(\top_cam/rtl_cam/matches [4]),
    .I3(\top_cam/rtl_cam/matches [7]),
    .I4(\top_cam/rtl_cam/matches [6]),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [8])
  );
  LUT3 #(
    .INIT ( 8'hFD ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW0  (
    .I0(\top_cam/rtl_cam/matches [10]),
    .I1(\top_cam/rtl_cam/matches [5]),
    .I2(\top_cam/rtl_cam/matches [4]),
    .O(N2)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(10)(5)1  (
    .I0(\top_cam/rtl_cam/matches [9]),
    .I1(\top_cam/rtl_cam/matches [8]),
    .I2(\top_cam/rtl_cam/matches [7]),
    .I3(\top_cam/rtl_cam/matches [6]),
    .I4(N2),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [10])
  );
  LUT4 #(
    .INIT ( 16'hFFFD ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW1  (
    .I0(\top_cam/rtl_cam/matches [11]),
    .I1(\top_cam/rtl_cam/matches [10]),
    .I2(\top_cam/rtl_cam/matches [5]),
    .I3(\top_cam/rtl_cam/matches [4]),
    .O(N4)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)1  (
    .I0(\top_cam/rtl_cam/matches [9]),
    .I1(\top_cam/rtl_cam/matches [8]),
    .I2(\top_cam/rtl_cam/matches [7]),
    .I3(\top_cam/rtl_cam/matches [6]),
    .I4(N4),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [11])
  );
  LUT4 #(
    .INIT ( 16'hFFFD ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW2  (
    .I0(\top_cam/rtl_cam/matches [14]),
    .I1(\top_cam/rtl_cam/matches [13]),
    .I2(\top_cam/rtl_cam/matches [12]),
    .I3(\top_cam/rtl_cam/matches [4]),
    .O(N6)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(14)(1)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I4(N6),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [14])
  );
  LUT5 #(
    .INIT ( 32'hFFFEFFFF ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW3  (
    .I0(\top_cam/rtl_cam/matches [12]),
    .I1(\top_cam/rtl_cam/matches [4]),
    .I2(\top_cam/rtl_cam/matches [14]),
    .I3(\top_cam/rtl_cam/matches [13]),
    .I4(\top_cam/rtl_cam/matches [15]),
    .O(N8)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(15)(0)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I4(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I5(N8),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [15])
  );
  LUT3 #(
    .INIT ( 8'hFD ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW4  (
    .I0(\top_cam/rtl_cam/matches [13]),
    .I1(\top_cam/rtl_cam/matches [12]),
    .I2(\top_cam/rtl_cam/matches [4]),
    .O(N10)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(13)(2)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(N10),
    .I4(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [13])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW5  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [4]),
    .O(N12)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000002 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(9)(6)1  (
    .I0(\top_cam/rtl_cam/matches [9]),
    .I1(\top_cam/rtl_cam/matches [8]),
    .I2(\top_cam/rtl_cam/matches [7]),
    .I3(\top_cam/rtl_cam/matches [6]),
    .I4(N12),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [9])
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW6  (
    .I0(\top_cam/rtl_cam/matches [12]),
    .I1(\top_cam/rtl_cam/matches [4]),
    .O(N14)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(12)(3)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(N14),
    .I4(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [12])
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)1_SW7  (
    .I0(\top_cam/rtl_cam/matches [15]),
    .I1(\top_cam/rtl_cam/matches [14]),
    .I2(\top_cam/rtl_cam/matches [13]),
    .I3(\top_cam/rtl_cam/matches [12]),
    .I4(\top_cam/rtl_cam/matches [4]),
    .O(N16)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(0)(0)1  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/matches [6]),
    .I3(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I4(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I5(N16),
    .O(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[0] )
  );
  LUT5 #(
    .INIT ( 32'h00010000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(4)1  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/matches [3]),
    .I2(\top_cam/rtl_cam/matches [2]),
    .I3(\top_cam/rtl_cam/matches [1]),
    .I4(\top_cam/rtl_cam/matches [4]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [4])
  );
  LUT6 #(
    .INIT ( 64'h0000000000010000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(5)(10)1  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/matches [3]),
    .I2(\top_cam/rtl_cam/matches [2]),
    .I3(\top_cam/rtl_cam/matches [1]),
    .I4(\top_cam/rtl_cam/matches [5]),
    .I5(\top_cam/rtl_cam/matches [4]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg [5])
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[0]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[3]),
    .I4(WE),
    .O(N18)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted1  (
    .I0(N18),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[1].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[1]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[3]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N20)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[2].sword/we_inverted1  (
    .I0(N20),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
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
    .O(N22)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted1  (
    .I0(N22),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[3].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[2]),
    .I1(WR_ADDR[3]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N24)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[4].sword/we_inverted1  (
    .I0(N24),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
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
    .O(N26)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted1  (
    .I0(N26),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[5].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFDFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N28)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFCFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[8].sword/we_inverted1  (
    .I0(N28),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
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
    .O(N30)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted1  (
    .I0(N30),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[9].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[0]),
    .I2(WR_ADDR[2]),
    .I3(WR_ADDR[1]),
    .I4(WE),
    .O(N32)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[10].sword/we_inverted1  (
    .I0(N32),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
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
    .O(N34)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAACFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted1  (
    .I0(N34),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[11].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFDFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[0]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[2]),
    .I4(WE),
    .O(N36)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFCFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[12].sword/we_inverted1  (
    .I0(N36),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
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
    .O(N38)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAACFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted1  (
    .I0(N38),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[13].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hF7FFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[0]),
    .I3(WR_ADDR[1]),
    .I4(WE),
    .O(N40)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAACFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted1  (
    .I0(N40),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[14].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N42)
  );
  LUT6 #(
    .INIT ( 64'h555555553FFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted1  (
    .I0(N42),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[15].sword/we_inverted )
  );
  LUT5 #(
    .INIT ( 32'hFFFEFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted1_SW0  (
    .I0(WR_ADDR[3]),
    .I1(WR_ADDR[2]),
    .I2(WR_ADDR[1]),
    .I3(WR_ADDR[0]),
    .I4(WE),
    .O(N44)
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAFFFFFFFC ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted1  (
    .I0(N44),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I3(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I4(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[0].sword/we_inverted )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFF4FFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted1  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I5(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[6].sword/we_inverted )
  );
  LUT6 #(
    .INIT ( 64'hFFFF4FFFFFFFFFFF ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/we_inverted1  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I5(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/loopw[7].sword/we_inverted )
  );
  LUT6 #(
    .INIT ( 64'h2222222222222227 ))
  \top_cam/rtl_cam/clog/_n019921  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(WE),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I4(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I5(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .O(\top_cam/rtl_cam/clog/_n0199 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \top_cam/rtl_cam/clog/WE_busy_i_AND_109_o11  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/clog/WE_busy_i_AND_109_o )
  );
  LUT3 #(
    .INIT ( 8'hEB ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl11  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl1 )
  );
  LUT4 #(
    .INIT ( 16'hEEEB ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl21  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl2 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFAAA9 ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl31  (
    .I0(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [3]),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [1]),
    .I2(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [2]),
    .I3(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl3 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl_xor(0)11  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .I1(\top_cam/rtl_cam/clog/gwsig.gsrl.wr_count_integer_srl [0]),
    .O(\top_cam/rtl_cam/clog/Mcount_gwsig.gsrl.wr_count_integer_srl )
  );
  LUT6 #(
    .INIT ( 64'h0002000000020002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC21  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(1) )
  );
  LUT6 #(
    .INIT ( 64'h0001000000010001 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC17  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(0) )
  );
  LUT6 #(
    .INIT ( 64'h0200000002000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC101  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(3) )
  );
  LUT6 #(
    .INIT ( 64'h0002000000020002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC91  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(2) )
  );
  LUT6 #(
    .INIT ( 64'h0200000002000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC121  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(5) )
  );
  LUT6 #(
    .INIT ( 64'h0002000000020002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC111  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(4) )
  );
  LUT6 #(
    .INIT ( 64'h0800000008000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC141  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(7) )
  );
  LUT6 #(
    .INIT ( 64'h0200000002000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC131  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(6) )
  );
  LUT6 #(
    .INIT ( 64'h0200000002000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC161  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(9) )
  );
  LUT6 #(
    .INIT ( 64'h0002000000020002 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC151  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(8) )
  );
  LUT6 #(
    .INIT ( 64'h0800000008000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC41  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(11) )
  );
  LUT6 #(
    .INIT ( 64'h0200000002000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC31  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(10) )
  );
  LUT6 #(
    .INIT ( 64'h0800000008000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC61  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(13) )
  );
  LUT6 #(
    .INIT ( 64'h0200000002000200 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC51  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(12) )
  );
  LUT6 #(
    .INIT ( 64'h8000000080008000 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC81  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(15) )
  );
  LUT6 #(
    .INIT ( 64'h0800000008000800 ))
  \top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/gedec.gdecm/Mmux_DEC71  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(WE),
    .I5(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(\top_cam/rtl_cam/mem/gsrl.srlmem/gblks[0].glast.blkb/wes(14) )
  );
  INV   \top_cam/rtl_cam/reg_en_inv1_INV_0  (
    .I(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 ),
    .O(BUSY)
  );
  FDRS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/int_reg_en_i_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/int_reg_en_i_153 ),
    .R(\top_cam/rtl_cam/clog/WE_busy_i_AND_109_o ),
    .S(\top_cam/rtl_cam/clog/gwsig.end_next_write_943 ),
    .Q(\top_cam/rtl_cam/clog/int_reg_en_i_1_998 )
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

