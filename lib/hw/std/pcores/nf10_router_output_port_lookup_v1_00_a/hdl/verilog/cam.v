////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.61xd
//  \   \         Application: netgen
//  /   /         Filename: cam.v
// /___/   /\     Timestamp: Mon Oct 22 09:22:12 2012
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
  input [31 : 0] DIN;
  input [3 : 0] WR_ADDR;
  input [31 : 0] CMP_DIN;
  output [15 : 0] MATCH_ADDR;


  //synthesis translate_off

  wire NlwRenamedSig_OI_BUSY;
  wire N0;
  wire N1;
  wire \top_cam/rtl_cam/wren ;
  wire \top_cam/rtl_cam/rw_dec_clr_i ;
  wire \top_cam/rtl_cam/clog/int_reg_en_i_92 ;
  wire \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)3 ;
  wire \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)3 ;
  wire \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ;
  wire \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ;
  wire \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ;
  wire \top_cam/rtl_cam/clog/gwsig.end_next_write_WE_MUX_53_o ;
  wire \top_cam/rtl_cam/clog/gwsig.end_next_write_331 ;
  wire N2;
  wire N4;
  wire N6;
  wire N8;
  wire N10;
  wire N12;
  wire N14;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i1_340 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i2_341 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i3_342 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i4_343 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i5_344 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i6_345 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i7_346 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i8_347 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i9_348 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i10_349 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i11_350 ;
  wire \top_cam/rtl_cam/clog/rw_dec_clr_i12_351 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_15_rstpot_352 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_14_rstpot_353 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_13_rstpot_354 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_12_rstpot_355 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_11_rstpot_356 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_10_rstpot_357 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_9_rstpot_358 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_8_rstpot_359 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_7_rstpot_360 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_6_rstpot_361 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_5_rstpot_362 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_4_rstpot_363 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_3_rstpot_364 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_2_rstpot_365 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_1_rstpot_366 ;
  wire \top_cam/rtl_cam/mlog/blkmem_match_disable_0_rstpot_367 ;
  wire N16;
  wire N17;
  wire N18;
  wire N19;
  wire N20;
  wire N21;
  wire N22;
  wire N23;
  wire N24;
  wire N25;
  wire N26;
  wire N27;
  wire N28;
  wire N29;
  wire N30;
  wire N31;
  wire N32;
  wire N33;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED ;
  wire \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED ;
  wire [15 : 0] \top_cam/rtl_cam/matches ;
  wire [3 : 0] \top_cam/rtl_cam/wr_addr_ilog ;
  wire [31 : 0] \top_cam/rtl_cam/wr_data ;
  wire [31 : 0] \top_cam/rtl_cam/ilog/gwl.din_q ;
  wire [3 : 0] \top_cam/rtl_cam/ilog/gwl.wr_addr_q ;
  wire [31 : 0] \top_cam/rtl_cam/mem/gblk.blkmem/mux_out ;
  wire [15 : 0] \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) ;
  wire [15 : 0] \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) ;
  wire [15 : 0] \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) ;
  wire [15 : 0] \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) ;
  wire [31 : 0] \top_cam/rtl_cam/mem/gblk.blkmem/memory_out ;
  wire [15 : 0] \top_cam/rtl_cam/mlog/blkmem_match_disable ;
  assign
    BUSY = NlwRenamedSig_OI_BUSY;
  VCC   XST_VCC (
    .P(N0)
  );
  GND   XST_GND (
    .G(N1)
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
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM32  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [31]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [31])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM31  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [30]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [30])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM30  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [29]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [29])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM29  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [28]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [28])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM28  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [27]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [27])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM27  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [26]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [26])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM25  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [24]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [24])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM24  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [23]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [23])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM26  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [25]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [25])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM23  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [22]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [22])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM22  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [21]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [21])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM21  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [20]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [20])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM20  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [19]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [19])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM19  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [18]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [18])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM18  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [17]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [17])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM16  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [15]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [15])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM15  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [14]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [14])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM17  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [16]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [16])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM14  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [13]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [13])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM13  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [12]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [12])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM12  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [11]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [11])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM11  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [10]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [10])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM10  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [9]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [9])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM9  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [8]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [8])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM7  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [6]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [6])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM6  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [5]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [5])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM8  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [7]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [7])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM5  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [4]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [4])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM4  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [3]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [3])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM2  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [1]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [1])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM1  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [0]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [0])
  );
  RAM32X1S #(
    .INIT ( 32'h00000000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gdmem.eram/Mram_MEM3  (
    .A0(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .A1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .A2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .A3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .A4(N1),
    .D(\top_cam/rtl_cam/wr_data [2]),
    .WCLK(CLK),
    .WE(NlwRenamedSig_OI_BUSY),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [2])
  );
  FDRS #(
    .INIT ( 1'b1 ))
  \top_cam/rtl_cam/clog/int_reg_en_i  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .R(\top_cam/rtl_cam/clog/gwsig.end_next_write_WE_MUX_53_o ),
    .S(\top_cam/rtl_cam/clog/gwsig.end_next_write_331 ),
    .Q(\top_cam/rtl_cam/clog/int_reg_en_i_92 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/clog/gwsig.end_next_write  (
    .C(CLK),
    .D(\top_cam/rtl_cam/clog/gwsig.end_next_write_WE_MUX_53_o ),
    .Q(\top_cam/rtl_cam/clog/gwsig.end_next_write_331 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT11  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [0]),
    .I2(WR_ADDR[0]),
    .O(\top_cam/rtl_cam/wr_addr_ilog [0])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT21  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [1]),
    .I2(WR_ADDR[1]),
    .O(\top_cam/rtl_cam/wr_addr_ilog [1])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT31  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [2]),
    .I2(WR_ADDR[2]),
    .O(\top_cam/rtl_cam/wr_addr_ilog [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_WR_ADDR_INT41  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.wr_addr_q [3]),
    .I2(WR_ADDR[3]),
    .O(\top_cam/rtl_cam/wr_addr_ilog [3])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT110  (
    .I0(DIN[0]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [0]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [0])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT210  (
    .I0(DIN[1]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [1]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [1])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT33  (
    .I0(DIN[10]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [10]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [10])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT41  (
    .I0(DIN[11]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [11]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [11])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT51  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [12]),
    .I2(DIN[12]),
    .O(\top_cam/rtl_cam/wr_data [12])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT61  (
    .I0(DIN[13]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [13]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [13])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT71  (
    .I0(DIN[14]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [14]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [14])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT81  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [15]),
    .I2(DIN[15]),
    .O(\top_cam/rtl_cam/wr_data [15])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT91  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [16]),
    .I2(DIN[16]),
    .O(\top_cam/rtl_cam/wr_data [16])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT101  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [17]),
    .I2(DIN[17]),
    .O(\top_cam/rtl_cam/wr_data [17])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT111  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [18]),
    .I2(DIN[18]),
    .O(\top_cam/rtl_cam/wr_data [18])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT121  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [19]),
    .I2(DIN[19]),
    .O(\top_cam/rtl_cam/wr_data [19])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT131  (
    .I0(DIN[2]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [2]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [2])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT141  (
    .I0(DIN[20]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [20]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [20])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT151  (
    .I0(DIN[21]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [21]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [21])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT161  (
    .I0(DIN[22]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [22]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [22])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT171  (
    .I0(DIN[23]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [23]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [23])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT181  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [24]),
    .I2(DIN[24]),
    .O(\top_cam/rtl_cam/wr_data [24])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT191  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [25]),
    .I2(DIN[25]),
    .O(\top_cam/rtl_cam/wr_data [25])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT201  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [26]),
    .I2(DIN[26]),
    .O(\top_cam/rtl_cam/wr_data [26])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT211  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [27]),
    .I2(DIN[27]),
    .O(\top_cam/rtl_cam/wr_data [27])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT221  (
    .I0(DIN[28]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [28]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [28])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT231  (
    .I0(DIN[29]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [29]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [29])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT241  (
    .I0(DIN[3]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [3]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT251  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [30]),
    .I2(DIN[30]),
    .O(\top_cam/rtl_cam/wr_data [30])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT261  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [31]),
    .I2(DIN[31]),
    .O(\top_cam/rtl_cam/wr_data [31])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT271  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [4]),
    .I2(DIN[4]),
    .O(\top_cam/rtl_cam/wr_data [4])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT281  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [5]),
    .I2(DIN[5]),
    .O(\top_cam/rtl_cam/wr_data [5])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT291  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [6]),
    .I2(DIN[6]),
    .O(\top_cam/rtl_cam/wr_data [6])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT301  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [7]),
    .I2(DIN[7]),
    .O(\top_cam/rtl_cam/wr_data [7])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT311  (
    .I0(DIN[8]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [8]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [8])
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  \top_cam/rtl_cam/ilog/Mmux_gwl.din_q[31]_DIN[31]_mux_5_OUT321  (
    .I0(DIN[9]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [9]),
    .I2(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/wr_data [9])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out151  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [15]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [15]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [15]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [15]),
    .O(\top_cam/rtl_cam/matches [15])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out141  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [14]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [14]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [14]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [14]),
    .O(\top_cam/rtl_cam/matches [14])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out131  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [13]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [13]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [13]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [13]),
    .O(\top_cam/rtl_cam/matches [13])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out121  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [12]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [12]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [12]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [12]),
    .O(\top_cam/rtl_cam/matches [12])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out111  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [11]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [11]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [11]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [11]),
    .O(\top_cam/rtl_cam/matches [11])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out101  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [10]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [10]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [10]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [10]),
    .O(\top_cam/rtl_cam/matches [10])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out91  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [9]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [9]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [9]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [9]),
    .O(\top_cam/rtl_cam/matches [9])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out81  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [8]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [8]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [8]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [8]),
    .O(\top_cam/rtl_cam/matches [8])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out71  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [7]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [7]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [7]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [7]),
    .O(\top_cam/rtl_cam/matches [7])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out61  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [6]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [6]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [6]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [6]),
    .O(\top_cam/rtl_cam/matches [6])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out51  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [5]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [5]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [5]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [5]),
    .O(\top_cam/rtl_cam/matches [5])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out41  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [4]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [4]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [4]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [4]),
    .O(\top_cam/rtl_cam/matches [4])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out31  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [3]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [3]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [3]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [3]),
    .O(\top_cam/rtl_cam/matches [3])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out21  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [2]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [2]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [2]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [2]),
    .O(\top_cam/rtl_cam/matches [2])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out11  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [1]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [1]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [1]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [1]),
    .O(\top_cam/rtl_cam/matches [1])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/out1  (
    .I0(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [0]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [0]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [0]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [0]),
    .O(\top_cam/rtl_cam/matches [0])
  );
  LUT6 #(
    .INIT ( 64'h4044000040444044 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(2)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [2]),
    .I1(\top_cam/rtl_cam/matches [2]),
    .I2(\top_cam/rtl_cam/mlog/blkmem_match_disable [1]),
    .I3(\top_cam/rtl_cam/matches [1]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [0]),
    .I5(\top_cam/rtl_cam/matches [0]),
    .O(MATCH_ADDR[2])
  );
  LUT4 #(
    .INIT ( 16'h4404 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(1)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [1]),
    .I1(\top_cam/rtl_cam/matches [1]),
    .I2(\top_cam/rtl_cam/matches [0]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [0]),
    .O(MATCH_ADDR[1])
  );
  LUT6 #(
    .INIT ( 64'h0004000400000004 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(13)(2)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [13]),
    .I1(\top_cam/rtl_cam/matches [13]),
    .I2(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I3(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I4(\top_cam/rtl_cam/matches [12]),
    .I5(\top_cam/rtl_cam/mlog/blkmem_match_disable [12]),
    .O(MATCH_ADDR[13])
  );
  LUT5 #(
    .INIT ( 32'h40400040 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [7]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)3 ),
    .I3(\top_cam/rtl_cam/matches [6]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [6]),
    .O(MATCH_ADDR[7])
  );
  LUT5 #(
    .INIT ( 32'h45004545 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)31  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [4]),
    .I2(\top_cam/rtl_cam/matches [4]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [5]),
    .I4(\top_cam/rtl_cam/matches [5]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)3 )
  );
  LUT5 #(
    .INIT ( 32'h40400040 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [11]),
    .I1(\top_cam/rtl_cam/matches [11]),
    .I2(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)3 ),
    .I3(\top_cam/rtl_cam/matches [10]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [10]),
    .O(MATCH_ADDR[11])
  );
  LUT5 #(
    .INIT ( 32'h45004545 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)31  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [8]),
    .I2(\top_cam/rtl_cam/matches [8]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [9]),
    .I4(\top_cam/rtl_cam/matches [9]),
    .O(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)3 )
  );
  LUT5 #(
    .INIT ( 32'h04040004 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(5)(10)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [5]),
    .I1(\top_cam/rtl_cam/matches [5]),
    .I2(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I3(\top_cam/rtl_cam/matches [4]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [4]),
    .O(MATCH_ADDR[5])
  );
  LUT5 #(
    .INIT ( 32'h04040004 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(9)(6)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [9]),
    .I1(\top_cam/rtl_cam/matches [9]),
    .I2(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I3(\top_cam/rtl_cam/matches [8]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [8]),
    .O(MATCH_ADDR[9])
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(12)(3)1  (
    .I0(\top_cam/rtl_cam/matches [12]),
    .I1(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I2(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [12]),
    .O(MATCH_ADDR[12])
  );
  LUT6 #(
    .INIT ( 64'h4044000040444044 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(3)(12)  (
    .I0(N2),
    .I1(\top_cam/rtl_cam/matches [3]),
    .I2(\top_cam/rtl_cam/mlog/blkmem_match_disable [2]),
    .I3(\top_cam/rtl_cam/matches [2]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [0]),
    .I5(\top_cam/rtl_cam/matches [0]),
    .O(MATCH_ADDR[3])
  );
  LUT6 #(
    .INIT ( 64'h0004000400000004 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(14)(1)  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I1(\top_cam/rtl_cam/matches [14]),
    .I2(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I3(N4),
    .I4(\top_cam/rtl_cam/matches [13]),
    .I5(\top_cam/rtl_cam/mlog/blkmem_match_disable [13]),
    .O(MATCH_ADDR[14])
  );
  LUT5 #(
    .INIT ( 32'hFFFF22F2 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(15)(0)_SW0  (
    .I0(\top_cam/rtl_cam/matches [12]),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [12]),
    .I2(\top_cam/rtl_cam/matches [14]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [14]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [15]),
    .O(N6)
  );
  LUT6 #(
    .INIT ( 64'h0004000400000004 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(15)(0)  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I1(\top_cam/rtl_cam/matches [15]),
    .I2(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I3(N6),
    .I4(\top_cam/rtl_cam/matches [13]),
    .I5(\top_cam/rtl_cam/mlog/blkmem_match_disable [13]),
    .O(MATCH_ADDR[15])
  );
  LUT6 #(
    .INIT ( 64'hFF0F330355051101 ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(0)(0)_SW0  (
    .I0(\top_cam/rtl_cam/matches [12]),
    .I1(\top_cam/rtl_cam/matches [14]),
    .I2(\top_cam/rtl_cam/matches [13]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [13]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [14]),
    .I5(\top_cam/rtl_cam/mlog/blkmem_match_disable [12]),
    .O(N8)
  );
  LUT5 #(
    .INIT ( 32'hFFFFBBFB ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(0)(0)  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] ),
    .I1(N8),
    .I2(\top_cam/rtl_cam/matches [15]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [15]),
    .I4(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .O(MATCH)
  );
  LUT4 #(
    .INIT ( 16'hF351 ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)_SW0  (
    .I0(\top_cam/rtl_cam/matches [5]),
    .I1(\top_cam/rtl_cam/matches [7]),
    .I2(\top_cam/rtl_cam/mlog/blkmem_match_disable [7]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [5]),
    .O(N10)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF5D5DFF5D ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(4)(8)  (
    .I0(N10),
    .I1(\top_cam/rtl_cam/matches [6]),
    .I2(\top_cam/rtl_cam/mlog/blkmem_match_disable [6]),
    .I3(\top_cam/rtl_cam/matches [4]),
    .I4(\top_cam/rtl_cam/mlog/blkmem_match_disable [4]),
    .I5(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .O(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] )
  );
  LUT4 #(
    .INIT ( 16'hF351 ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(6)(12)_SW0  (
    .I0(\top_cam/rtl_cam/matches [1]),
    .I1(\top_cam/rtl_cam/matches [3]),
    .I2(\top_cam/rtl_cam/mlog/blkmem_match_disable [3]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [1]),
    .O(N12)
  );
  LUT5 #(
    .INIT ( 32'h22F2FFFF ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(6)(12)  (
    .I0(\top_cam/rtl_cam/matches [0]),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [0]),
    .I2(\top_cam/rtl_cam/matches [2]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [2]),
    .I4(N12),
    .O(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] )
  );
  LUT4 #(
    .INIT ( 16'hF351 ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(2)(4)_SW0  (
    .I0(\top_cam/rtl_cam/matches [9]),
    .I1(\top_cam/rtl_cam/matches [11]),
    .I2(\top_cam/rtl_cam/mlog/blkmem_match_disable [11]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [9]),
    .O(N14)
  );
  LUT5 #(
    .INIT ( 32'h22F2FFFF ))
  \top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red(2)(4)  (
    .I0(\top_cam/rtl_cam/matches [10]),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [10]),
    .I2(\top_cam/rtl_cam/matches [8]),
    .I3(\top_cam/rtl_cam/mlog/blkmem_match_disable [8]),
    .I4(N14),
    .O(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[2] )
  );
  LUT6 #(
    .INIT ( 64'hF0F0F0F0F0F0F060 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i5  (
    .I0(CMP_DIN[21]),
    .I1(\top_cam/rtl_cam/wr_data [21]),
    .I2(\top_cam/rtl_cam/clog/rw_dec_clr_i ),
    .I3(\top_cam/rtl_cam/clog/rw_dec_clr_i2_341 ),
    .I4(\top_cam/rtl_cam/clog/rw_dec_clr_i3_342 ),
    .I5(\top_cam/rtl_cam/clog/rw_dec_clr_i1_340 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i4_343 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i9  (
    .I0(CMP_DIN[1]),
    .I1(\top_cam/rtl_cam/wr_data [1]),
    .I2(\top_cam/rtl_cam/clog/rw_dec_clr_i6_345 ),
    .I3(\top_cam/rtl_cam/clog/rw_dec_clr_i7_346 ),
    .I4(\top_cam/rtl_cam/clog/rw_dec_clr_i5_344 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i8_347 )
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i13  (
    .I0(CMP_DIN[11]),
    .I1(\top_cam/rtl_cam/wr_data [11]),
    .I2(\top_cam/rtl_cam/clog/rw_dec_clr_i9_348 ),
    .I3(\top_cam/rtl_cam/clog/rw_dec_clr_i11_350 ),
    .I4(\top_cam/rtl_cam/clog/rw_dec_clr_i10_349 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i12_351 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_15  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_15_rstpot_352 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_14  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_14_rstpot_353 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_13  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_13_rstpot_354 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_12  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_12_rstpot_355 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_11  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_11_rstpot_356 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_10  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_10_rstpot_357 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_9  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_9_rstpot_358 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_8  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_8_rstpot_359 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_7  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_7_rstpot_360 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_6  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_6_rstpot_361 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_5  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_5_rstpot_362 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_4  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_4_rstpot_363 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_3  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_3_rstpot_364 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_2  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_2_rstpot_365 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_1  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_1_rstpot_366 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_0  (
    .C(CLK),
    .D(\top_cam/rtl_cam/mlog/blkmem_match_disable_0_rstpot_367 ),
    .Q(\top_cam/rtl_cam/mlog/blkmem_match_disable [0])
  );
  LUT5 #(
    .INIT ( 32'hF4444444 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i14  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I2(\top_cam/rtl_cam/clog/rw_dec_clr_i12_351 ),
    .I3(\top_cam/rtl_cam/clog/rw_dec_clr_i8_347 ),
    .I4(\top_cam/rtl_cam/clog/rw_dec_clr_i4_343 ),
    .O(\top_cam/rtl_cam/rw_dec_clr_i )
  );
  LUT5 #(
    .INIT ( 32'h00008000 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_15_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_15_rstpot_352 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_14_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_14_rstpot_353 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_13_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_13_rstpot_354 )
  );
  LUT5 #(
    .INIT ( 32'h00000020 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_12_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_12_rstpot_355 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_11_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_11_rstpot_356 )
  );
  LUT5 #(
    .INIT ( 32'h00000020 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_10_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_10_rstpot_357 )
  );
  LUT5 #(
    .INIT ( 32'h00000020 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_9_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_9_rstpot_358 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_8_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_8_rstpot_359 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_7_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_7_rstpot_360 )
  );
  LUT5 #(
    .INIT ( 32'h00000020 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_6_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_6_rstpot_361 )
  );
  LUT5 #(
    .INIT ( 32'h00000020 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_5_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_5_rstpot_362 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_4_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_4_rstpot_363 )
  );
  LUT5 #(
    .INIT ( 32'h00000020 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_3_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_3_rstpot_364 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_2_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_2_rstpot_365 )
  );
  LUT5 #(
    .INIT ( 32'h00000004 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_1_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_1_rstpot_366 )
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  \top_cam/rtl_cam/mlog/blkmem_match_disable_0_rstpot  (
    .I0(\top_cam/rtl_cam/wr_addr_ilog [1]),
    .I1(\top_cam/rtl_cam/wr_addr_ilog [3]),
    .I2(\top_cam/rtl_cam/wr_addr_ilog [2]),
    .I3(\top_cam/rtl_cam/wr_addr_ilog [0]),
    .I4(\top_cam/rtl_cam/rw_dec_clr_i ),
    .O(\top_cam/rtl_cam/mlog/blkmem_match_disable_0_rstpot_367 )
  );
  LUT5 #(
    .INIT ( 32'h00007BDE ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i1  (
    .I0(CMP_DIN[31]),
    .I1(CMP_DIN[30]),
    .I2(\top_cam/rtl_cam/ilog/gwl.din_q [31]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [30]),
    .I4(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \top_cam/rtl_cam/clog/WREN1  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(WE),
    .O(\top_cam/rtl_cam/wren )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \top_cam/rtl_cam/clog/gwsig.end_next_write_WE_MUX_53_o1  (
    .I0(WE),
    .I1(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/gwsig.end_next_write_WE_MUX_53_o )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out110  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [0]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [0]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [0])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out210  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [1]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [1]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [1])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out33  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [10]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [10]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [10])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out41  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [11]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [11]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [11])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out51  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [12]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [12]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [12])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out61  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [13]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [13]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [13])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out71  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [14]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [14]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [14])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out81  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [15]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [15]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [15])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out91  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [16]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [16]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [16])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out101  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [17]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [17]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [17])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out111  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [18]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [18]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [18])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out121  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [19]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [19]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [19])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out131  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [2]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [2]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out141  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [20]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [20]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [20])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out151  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [21]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [21]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [21])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out161  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [22]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [22]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [22])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out171  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [23]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [23]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [23])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out181  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [24]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [24]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [24])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out191  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [25]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [25]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [25])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out201  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [26]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [26]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [26])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out211  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [27]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [27]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [27])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out221  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [28]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [28]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [28])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out231  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [29]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [29]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [29])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out241  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [3]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [3]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out251  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [30]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [30]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [30])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out261  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [31]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [31]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [31])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out271  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [4]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [4]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [4])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out281  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [5]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [5]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [5])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out291  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [6]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [6]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [6])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out301  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [7]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [7]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [7])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out311  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [8]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [8]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [8])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/Mmux_mux_out321  (
    .I0(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [9]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/memory_out [9]),
    .O(\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [9])
  );
  LUT6 #(
    .INIT ( 64'h4000000000000000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(6)(9)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [6]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [6]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [6]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [6]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [6]),
    .I5(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(7)(8)3 ),
    .O(MATCH_ADDR[6])
  );
  LUT6 #(
    .INIT ( 64'h4000000000000000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(10)(5)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [10]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [10]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [10]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [10]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [10]),
    .I5(\top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(11)(4)3 ),
    .O(MATCH_ADDR[10])
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(4)1  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[6] ),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [4]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [4]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [4]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [4]),
    .I5(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [4]),
    .O(MATCH_ADDR[4])
  );
  LUT6 #(
    .INIT ( 64'h1000000000000000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(8)1  (
    .I0(\top_cam/rtl_cam/mlog/ohadd.oh_proc.matches_red[4] ),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [8]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [8]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [8]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [8]),
    .I5(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [8]),
    .O(MATCH_ADDR[8])
  );
  LUT5 #(
    .INIT ( 32'h40000000 ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(0)1  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [0]),
    .I1(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [0]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [0]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [0]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [0]),
    .O(MATCH_ADDR[0])
  );
  LUT6 #(
    .INIT ( 64'hBAAAAAAAAAAAAAAA ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(3)(12)_SW0  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [3]),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [1]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [1]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [1]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [1]),
    .I5(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [1]),
    .O(N2)
  );
  LUT6 #(
    .INIT ( 64'hBAAAAAAAAAAAAAAA ))
  \top_cam/rtl_cam/mlog/match_addr_1h_bf_reg(14)(1)_SW0  (
    .I0(\top_cam/rtl_cam/mlog/blkmem_match_disable [14]),
    .I1(\top_cam/rtl_cam/mlog/blkmem_match_disable [12]),
    .I2(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [12]),
    .I3(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [12]),
    .I4(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [12]),
    .I5(\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [12]),
    .O(N4)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i12  (
    .I0(N16),
    .I1(N17),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i11_350 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i12_F  (
    .I0(CMP_DIN[16]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [16]),
    .I2(CMP_DIN[15]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [15]),
    .I4(CMP_DIN[17]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [17]),
    .O(N16)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i12_G  (
    .I0(CMP_DIN[16]),
    .I1(DIN[16]),
    .I2(CMP_DIN[15]),
    .I3(DIN[15]),
    .I4(CMP_DIN[17]),
    .I5(DIN[17]),
    .O(N17)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i4  (
    .I0(N18),
    .I1(N19),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i3_342 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i4_F  (
    .I0(CMP_DIN[26]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [26]),
    .I2(CMP_DIN[25]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [25]),
    .I4(CMP_DIN[27]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [27]),
    .O(N18)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i4_G  (
    .I0(CMP_DIN[26]),
    .I1(DIN[26]),
    .I2(CMP_DIN[25]),
    .I3(DIN[25]),
    .I4(CMP_DIN[27]),
    .I5(DIN[27]),
    .O(N19)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i10  (
    .I0(N20),
    .I1(N21),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i9_348 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i10_F  (
    .I0(CMP_DIN[19]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [19]),
    .I2(CMP_DIN[18]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [18]),
    .I4(CMP_DIN[12]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [12]),
    .O(N20)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i10_G  (
    .I0(CMP_DIN[19]),
    .I1(DIN[19]),
    .I2(CMP_DIN[18]),
    .I3(DIN[18]),
    .I4(CMP_DIN[12]),
    .I5(DIN[12]),
    .O(N21)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i8  (
    .I0(N22),
    .I1(N23),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i7_346 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i8_F  (
    .I0(CMP_DIN[6]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [6]),
    .I2(CMP_DIN[5]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [5]),
    .I4(CMP_DIN[7]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [7]),
    .O(N22)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i8_G  (
    .I0(CMP_DIN[6]),
    .I1(DIN[6]),
    .I2(CMP_DIN[5]),
    .I3(DIN[5]),
    .I4(CMP_DIN[7]),
    .I5(DIN[7]),
    .O(N23)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i7  (
    .I0(N24),
    .I1(N25),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i6_345 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i7_F  (
    .I0(CMP_DIN[0]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [0]),
    .I2(CMP_DIN[3]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [3]),
    .I4(CMP_DIN[4]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [4]),
    .O(N24)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i7_G  (
    .I0(CMP_DIN[0]),
    .I1(DIN[0]),
    .I2(CMP_DIN[3]),
    .I3(DIN[3]),
    .I4(CMP_DIN[4]),
    .I5(DIN[4]),
    .O(N25)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i3  (
    .I0(N26),
    .I1(N27),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i2_341 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i3_F  (
    .I0(CMP_DIN[20]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [20]),
    .I2(CMP_DIN[23]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [23]),
    .I4(CMP_DIN[24]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [24]),
    .O(N26)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i3_G  (
    .I0(CMP_DIN[20]),
    .I1(DIN[20]),
    .I2(CMP_DIN[23]),
    .I3(DIN[23]),
    .I4(CMP_DIN[24]),
    .I5(DIN[24]),
    .O(N27)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i11  (
    .I0(N28),
    .I1(N29),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i10_349 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i11_F  (
    .I0(CMP_DIN[10]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [10]),
    .I2(CMP_DIN[13]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [13]),
    .I4(CMP_DIN[14]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [14]),
    .O(N28)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i11_G  (
    .I0(CMP_DIN[10]),
    .I1(DIN[10]),
    .I2(CMP_DIN[13]),
    .I3(DIN[13]),
    .I4(CMP_DIN[14]),
    .I5(DIN[14]),
    .O(N29)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i6  (
    .I0(N30),
    .I1(N31),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i5_344 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i6_F  (
    .I0(CMP_DIN[9]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [9]),
    .I2(CMP_DIN[8]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [8]),
    .I4(CMP_DIN[2]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [2]),
    .O(N30)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i6_G  (
    .I0(CMP_DIN[9]),
    .I1(DIN[9]),
    .I2(CMP_DIN[8]),
    .I3(DIN[8]),
    .I4(CMP_DIN[2]),
    .I5(DIN[2]),
    .O(N31)
  );
  MUXF7   \top_cam/rtl_cam/clog/rw_dec_clr_i2  (
    .I0(N32),
    .I1(N33),
    .S(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(\top_cam/rtl_cam/clog/rw_dec_clr_i1_340 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i2_F  (
    .I0(CMP_DIN[29]),
    .I1(\top_cam/rtl_cam/ilog/gwl.din_q [29]),
    .I2(CMP_DIN[28]),
    .I3(\top_cam/rtl_cam/ilog/gwl.din_q [28]),
    .I4(CMP_DIN[22]),
    .I5(\top_cam/rtl_cam/ilog/gwl.din_q [22]),
    .O(N32)
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \top_cam/rtl_cam/clog/rw_dec_clr_i2_G  (
    .I0(CMP_DIN[29]),
    .I1(DIN[29]),
    .I2(CMP_DIN[28]),
    .I3(DIN[28]),
    .I4(CMP_DIN[22]),
    .I5(DIN[22]),
    .O(N33)
  );
  INV   \top_cam/rtl_cam/mem/gblk.blkmem/wr_count_inv1_INV_0  (
    .I(\top_cam/rtl_cam/clog/int_reg_en_i_92 ),
    .O(NlwRenamedSig_OI_BUSY)
  );
  RAMB36_EXP #(
    .DOA_REG ( 0 ),
    .DOB_REG ( 0 ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_10 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_11 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_12 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_13 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_14 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_15 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_16 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_17 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_18 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_19 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_20 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_21 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_22 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_23 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_24 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_25 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_26 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_27 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_28 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_29 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_30 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_31 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_32 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_33 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_34 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_35 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_36 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_37 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_38 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_39 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_40 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_41 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_42 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_43 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_44 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_45 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_46 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_47 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_48 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_49 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_50 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_51 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_52 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_53 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_54 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_55 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_56 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_57 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_58 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_59 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_60 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_61 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_62 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_63 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_64 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_65 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_66 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_67 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_68 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_69 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_70 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_71 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_72 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_73 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_74 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_75 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_76 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_77 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_78 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_79 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_A ( 36'h000000000 ),
    .INIT_B ( 36'h000000000 ),
    .INIT_FILE ( "NONE" ),
    .RAM_EXTENSION_A ( "NONE" ),
    .RAM_EXTENSION_B ( "NONE" ),
    .READ_WIDTH_A ( 1 ),
    .READ_WIDTH_B ( 36 ),
    .SIM_COLLISION_CHECK ( "NONE" ),
    .SIM_MODE ( "SAFE" ),
    .SRVAL_A ( 36'h000000000 ),
    .SRVAL_B ( 36'h000000000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .WRITE_WIDTH_A ( 1 ),
    .WRITE_WIDTH_B ( 36 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36  (
    .ENAU(N0),
    .ENAL(N0),
    .ENBU(N0),
    .ENBL(N0),
    .SSRAU(N1),
    .SSRAL(N1),
    .SSRBU(N1),
    .SSRBL(N1),
    .CLKAU(CLK),
    .CLKAL(CLK),
    .CLKBU(CLK),
    .CLKBL(CLK),
    .REGCLKAU(CLK),
    .REGCLKAL(CLK),
    .REGCLKBU(CLK),
    .REGCLKBL(CLK),
    .REGCEAU(N1),
    .REGCEAL(N1),
    .REGCEBU(N1),
    .REGCEBL(N1),
    .CASCADEINLATA(N1),
    .CASCADEINLATB(N1),
    .CASCADEINREGA(N1),
    .CASCADEINREGB(N1),
    .CASCADEOUTLATA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED )
,
    .CASCADEOUTLATB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED )
,
    .CASCADEOUTREGA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED )
,
    .CASCADEOUTREGB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED )
,
    .DIA({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, 
NlwRenamedSig_OI_BUSY}),
    .DIPA({N1, N1, N1, N1}),
    .DIB({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1}),
    .DIPB({N1, N1, N1, N1}),
    .ADDRAL({N0, N1, N1, N1, N1, N1, N1, N1, N1, \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [31], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [30], N1, 
\top_cam/rtl_cam/wr_addr_ilog [3], \top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRAU({N1, N1, N1, N1, N1, N1, N1, N1, \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [31], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [30], N1, 
\top_cam/rtl_cam/wr_addr_ilog [3], \top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRBL({N0, N1, N1, N1, N1, N1, N1, N1, N1, CMP_DIN[31], CMP_DIN[30], N0, N0, N0, N0, N0}),
    .ADDRBU({N1, N1, N1, N1, N1, N1, N1, N1, CMP_DIN[31], CMP_DIN[30], N0, N0, N0, N0, N0}),
    .WEAU({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEAL({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEBU({N1, N1, N1, N1, N1, N1, N1, N1}),
    .WEBL({N1, N1, N1, N1, N1, N1, N1, N1}),
    .DOA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED 
, \NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED 
}),
    .DOPA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED 
}),
    .DOB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED 
, \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [15], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [14], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [13], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [12], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [11], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [10], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [9], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [8], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [7], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [6], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [5], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [4], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [3], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [2], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [1], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(3) [0]}),
    .DOPB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED 
, 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[3].gincp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED 
})
  );
  RAMB36_EXP #(
    .DOA_REG ( 0 ),
    .DOB_REG ( 0 ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_10 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_11 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_12 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_13 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_14 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_15 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_16 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_17 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_18 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_19 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_20 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_21 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_22 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_23 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_24 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_25 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_26 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_27 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_28 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_29 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_30 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_31 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_32 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_33 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_34 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_35 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_36 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_37 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_38 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_39 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_40 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_41 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_42 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_43 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_44 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_45 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_46 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_47 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_48 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_49 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_50 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_51 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_52 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_53 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_54 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_55 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_56 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_57 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_58 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_59 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_60 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_61 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_62 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_63 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_64 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_65 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_66 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_67 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_68 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_69 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_70 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_71 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_72 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_73 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_74 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_75 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_76 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_77 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_78 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_79 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_A ( 36'h000000000 ),
    .INIT_B ( 36'h000000000 ),
    .INIT_FILE ( "NONE" ),
    .RAM_EXTENSION_A ( "NONE" ),
    .RAM_EXTENSION_B ( "NONE" ),
    .READ_WIDTH_A ( 1 ),
    .READ_WIDTH_B ( 36 ),
    .SIM_COLLISION_CHECK ( "NONE" ),
    .SIM_MODE ( "SAFE" ),
    .SRVAL_A ( 36'h000000000 ),
    .SRVAL_B ( 36'h000000000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .WRITE_WIDTH_A ( 1 ),
    .WRITE_WIDTH_B ( 36 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36  (
    .ENAU(N0),
    .ENAL(N0),
    .ENBU(N0),
    .ENBL(N0),
    .SSRAU(N1),
    .SSRAL(N1),
    .SSRBU(N1),
    .SSRBL(N1),
    .CLKAU(CLK),
    .CLKAL(CLK),
    .CLKBU(CLK),
    .CLKBL(CLK),
    .REGCLKAU(CLK),
    .REGCLKAL(CLK),
    .REGCLKBU(CLK),
    .REGCLKBL(CLK),
    .REGCEAU(N1),
    .REGCEAL(N1),
    .REGCEBU(N1),
    .REGCEBL(N1),
    .CASCADEINLATA(N1),
    .CASCADEINLATB(N1),
    .CASCADEINREGA(N1),
    .CASCADEINREGB(N1),
    .CASCADEOUTLATA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED )
,
    .CASCADEOUTLATB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED )
,
    .CASCADEOUTREGA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED )
,
    .CASCADEOUTREGB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED )
,
    .DIA({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, 
NlwRenamedSig_OI_BUSY}),
    .DIPA({N1, N1, N1, N1}),
    .DIB({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1}),
    .DIPB({N1, N1, N1, N1}),
    .ADDRAL({N0, \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [29], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [28], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [27], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [26], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [25], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [24], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [23], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [22], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [21], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [20], N1, \top_cam/rtl_cam/wr_addr_ilog [3], 
\top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRAU({\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [29], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [28], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [27], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [26], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [25], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [24], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [23], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [22], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [21], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [20], N1, \top_cam/rtl_cam/wr_addr_ilog [3], 
\top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRBL({N0, CMP_DIN[29], CMP_DIN[28], CMP_DIN[27], CMP_DIN[26], CMP_DIN[25], CMP_DIN[24], CMP_DIN[23], CMP_DIN[22], CMP_DIN[21], CMP_DIN[20], N0
, N0, N0, N0, N0}),
    .ADDRBU({CMP_DIN[29], CMP_DIN[28], CMP_DIN[27], CMP_DIN[26], CMP_DIN[25], CMP_DIN[24], CMP_DIN[23], CMP_DIN[22], CMP_DIN[21], CMP_DIN[20], N0, N0
, N0, N0, N0}),
    .WEAU({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEAL({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEBU({N1, N1, N1, N1, N1, N1, N1, N1}),
    .WEBL({N1, N1, N1, N1, N1, N1, N1, N1}),
    .DOA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED }),
    .DOPA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED }),
    .DOB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED , 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [15], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [14], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [13], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [12], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [11], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [10], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [9], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [8], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [7], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [6], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [5], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [4], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [3], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [2], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [1], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(2) [0]}),
    .DOPB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[2].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED })
  );
  RAMB36_EXP #(
    .DOA_REG ( 0 ),
    .DOB_REG ( 0 ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_10 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_11 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_12 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_13 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_14 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_15 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_16 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_17 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_18 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_19 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_20 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_21 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_22 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_23 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_24 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_25 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_26 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_27 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_28 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_29 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_30 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_31 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_32 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_33 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_34 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_35 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_36 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_37 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_38 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_39 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_40 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_41 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_42 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_43 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_44 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_45 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_46 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_47 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_48 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_49 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_50 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_51 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_52 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_53 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_54 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_55 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_56 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_57 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_58 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_59 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_60 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_61 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_62 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_63 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_64 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_65 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_66 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_67 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_68 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_69 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_70 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_71 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_72 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_73 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_74 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_75 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_76 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_77 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_78 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_79 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_A ( 36'h000000000 ),
    .INIT_B ( 36'h000000000 ),
    .INIT_FILE ( "NONE" ),
    .RAM_EXTENSION_A ( "NONE" ),
    .RAM_EXTENSION_B ( "NONE" ),
    .READ_WIDTH_A ( 1 ),
    .READ_WIDTH_B ( 36 ),
    .SIM_COLLISION_CHECK ( "NONE" ),
    .SIM_MODE ( "SAFE" ),
    .SRVAL_A ( 36'h000000000 ),
    .SRVAL_B ( 36'h000000000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .WRITE_WIDTH_A ( 1 ),
    .WRITE_WIDTH_B ( 36 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36  (
    .ENAU(N0),
    .ENAL(N0),
    .ENBU(N0),
    .ENBL(N0),
    .SSRAU(N1),
    .SSRAL(N1),
    .SSRBU(N1),
    .SSRBL(N1),
    .CLKAU(CLK),
    .CLKAL(CLK),
    .CLKBU(CLK),
    .CLKBL(CLK),
    .REGCLKAU(CLK),
    .REGCLKAL(CLK),
    .REGCLKBU(CLK),
    .REGCLKBL(CLK),
    .REGCEAU(N1),
    .REGCEAL(N1),
    .REGCEBU(N1),
    .REGCEBL(N1),
    .CASCADEINLATA(N1),
    .CASCADEINLATB(N1),
    .CASCADEINREGA(N1),
    .CASCADEINREGB(N1),
    .CASCADEOUTLATA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED )
,
    .CASCADEOUTLATB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED )
,
    .CASCADEOUTREGA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED )
,
    .CASCADEOUTREGB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED )
,
    .DIA({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, 
NlwRenamedSig_OI_BUSY}),
    .DIPA({N1, N1, N1, N1}),
    .DIB({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1}),
    .DIPB({N1, N1, N1, N1}),
    .ADDRAL({N0, \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [19], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [18], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [17], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [16], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [15], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [14], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [13], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [12], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [11], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [10], N1, \top_cam/rtl_cam/wr_addr_ilog [3], 
\top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRAU({\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [19], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [18], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [17], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [16], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [15], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [14], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [13], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [12], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [11], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [10], N1, \top_cam/rtl_cam/wr_addr_ilog [3], 
\top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRBL({N0, CMP_DIN[19], CMP_DIN[18], CMP_DIN[17], CMP_DIN[16], CMP_DIN[15], CMP_DIN[14], CMP_DIN[13], CMP_DIN[12], CMP_DIN[11], CMP_DIN[10], N0
, N0, N0, N0, N0}),
    .ADDRBU({CMP_DIN[19], CMP_DIN[18], CMP_DIN[17], CMP_DIN[16], CMP_DIN[15], CMP_DIN[14], CMP_DIN[13], CMP_DIN[12], CMP_DIN[11], CMP_DIN[10], N0, N0
, N0, N0, N0}),
    .WEAU({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEAL({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEBU({N1, N1, N1, N1, N1, N1, N1, N1}),
    .WEBL({N1, N1, N1, N1, N1, N1, N1, N1}),
    .DOA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED }),
    .DOPA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED }),
    .DOB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED , 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [15], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [14], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [13], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [12], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [11], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [10], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [9], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [8], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [7], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [6], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [5], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [4], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [3], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [2], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [1], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(1) [0]}),
    .DOPB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[1].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED })
  );
  RAMB36_EXP #(
    .DOA_REG ( 0 ),
    .DOB_REG ( 0 ),
    .INITP_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INITP_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_00 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_01 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_02 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_03 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_04 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_05 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_06 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_07 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_08 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_09 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_0F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_10 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_11 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_12 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_13 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_14 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_15 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_16 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_17 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_18 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_19 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_1F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_20 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_21 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_22 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_23 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_24 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_25 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_26 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_27 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_28 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_29 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_2F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_30 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_31 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_32 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_33 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_34 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_35 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_36 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_37 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_38 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_39 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_3F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_40 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_41 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_42 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_43 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_44 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_45 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_46 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_47 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_48 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_49 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_4F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_50 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_51 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_52 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_53 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_54 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_55 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_56 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_57 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_58 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_59 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_5F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_60 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_61 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_62 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_63 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_64 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_65 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_66 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_67 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_68 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_69 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_6F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_70 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_71 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_72 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_73 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_74 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_75 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_76 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_77 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_78 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_79 ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7A ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7B ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7C ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7D ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7E ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_7F ( 256'h0000000000000000000000000000000000000000000000000000000000000000 ),
    .INIT_A ( 36'h000000000 ),
    .INIT_B ( 36'h000000000 ),
    .INIT_FILE ( "NONE" ),
    .RAM_EXTENSION_A ( "NONE" ),
    .RAM_EXTENSION_B ( "NONE" ),
    .READ_WIDTH_A ( 1 ),
    .READ_WIDTH_B ( 36 ),
    .SIM_COLLISION_CHECK ( "NONE" ),
    .SIM_MODE ( "SAFE" ),
    .SRVAL_A ( 36'h000000000 ),
    .SRVAL_B ( 36'h000000000 ),
    .WRITE_MODE_A ( "WRITE_FIRST" ),
    .WRITE_MODE_B ( "WRITE_FIRST" ),
    .WRITE_WIDTH_A ( 1 ),
    .WRITE_WIDTH_B ( 36 ))
  \top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36  (
    .ENAU(N0),
    .ENAL(N0),
    .ENBU(N0),
    .ENBL(N0),
    .SSRAU(N1),
    .SSRAL(N1),
    .SSRBU(N1),
    .SSRBL(N1),
    .CLKAU(CLK),
    .CLKAL(CLK),
    .CLKBU(CLK),
    .CLKBL(CLK),
    .REGCLKAU(CLK),
    .REGCLKAL(CLK),
    .REGCLKBU(CLK),
    .REGCLKBL(CLK),
    .REGCEAU(N1),
    .REGCEAL(N1),
    .REGCEBU(N1),
    .REGCEBL(N1),
    .CASCADEINLATA(N1),
    .CASCADEINLATB(N1),
    .CASCADEINREGA(N1),
    .CASCADEINREGB(N1),
    .CASCADEOUTLATA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATA_UNCONNECTED )
,
    .CASCADEOUTLATB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTLATB_UNCONNECTED )
,
    .CASCADEOUTREGA
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGA_UNCONNECTED )
,
    .CASCADEOUTREGB
(\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_CASCADEOUTREGB_UNCONNECTED )
,
    .DIA({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, 
NlwRenamedSig_OI_BUSY}),
    .DIPA({N1, N1, N1, N1}),
    .DIB({N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1, N1}),
    .DIPB({N1, N1, N1, N1}),
    .ADDRAL({N0, \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [9], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [8], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [7], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [6], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [5], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [4], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [3], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [2], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [1], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [0], N1, \top_cam/rtl_cam/wr_addr_ilog [3], 
\top_cam/rtl_cam/wr_addr_ilog [2], \top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRAU({\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [9], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [8], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [7]
, \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [6], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [5], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [4], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [3], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [2], \top_cam/rtl_cam/mem/gblk.blkmem/mux_out [1], 
\top_cam/rtl_cam/mem/gblk.blkmem/mux_out [0], N1, \top_cam/rtl_cam/wr_addr_ilog [3], \top_cam/rtl_cam/wr_addr_ilog [2], 
\top_cam/rtl_cam/wr_addr_ilog [1], \top_cam/rtl_cam/wr_addr_ilog [0]}),
    .ADDRBL({N0, CMP_DIN[9], CMP_DIN[8], CMP_DIN[7], CMP_DIN[6], CMP_DIN[5], CMP_DIN[4], CMP_DIN[3], CMP_DIN[2], CMP_DIN[1], CMP_DIN[0], N0, N0, N0, 
N0, N0}),
    .ADDRBU({CMP_DIN[9], CMP_DIN[8], CMP_DIN[7], CMP_DIN[6], CMP_DIN[5], CMP_DIN[4], CMP_DIN[3], CMP_DIN[2], CMP_DIN[1], CMP_DIN[0], N0, N0, N0, N0, 
N0}),
    .WEAU({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEAL({\top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren , \top_cam/rtl_cam/wren }),
    .WEBU({N1, N1, N1, N1, N1, N1, N1, N1}),
    .WEBL({N1, N1, N1, N1, N1, N1, N1, N1}),
    .DOA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(31)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(30)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(29)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(28)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(27)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(26)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(25)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(24)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(23)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(22)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(21)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(20)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(19)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(18)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(17)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(16)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(15)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(14)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(13)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(12)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(11)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(10)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(9)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(8)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(7)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(6)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(5)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(4)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOA(0)_UNCONNECTED }),
    .DOPA({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPA(0)_UNCONNECTED }),
    .DOB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(31)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(30)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(29)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(28)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(27)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(26)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(25)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(24)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(23)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(22)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(21)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(20)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(19)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(18)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(17)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOB(16)_UNCONNECTED , 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [15], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [14], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [13], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [12], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [11], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [10], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [9], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [8], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [7], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [6], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [5], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [4], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [3], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [2], 
\top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [1], \top_cam/rtl_cam/mem/gblk.blkmem/matches_vector(0) [0]}),
    .DOPB({
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(3)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(2)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(1)_UNCONNECTED , 
\NLW_top_cam/rtl_cam/mem/gblk.blkmem/gextw[0].gcp.extd/gextd[0].gincp.extdp/v5prim.BRAM_TDP_MACRO_inst/ramb_v5.ramb36_dp.ram36_DOPB(0)_UNCONNECTED })
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

