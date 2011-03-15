////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: M.70d
//  \   \         Application: netgen
//  /   /         Filename: fifo_32.v
// /___/   /\     Timestamp: Sun Feb 20 20:45:17 2011
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog ./tmp/_cg/fifo_32.ngc ./tmp/_cg/fifo_32.v 
// Device	: 5vtx240tff1759-2
// Input file	: ./tmp/_cg/fifo_32.ngc
// Output file	: ./tmp/_cg/fifo_32.v
// # of Modules	: 1
// Design Name	: fifo_32
// Xilinx        : /opt/Xilinx/12.3/ISE_DS/ISE/
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

module fifo_32 (
  valid, rd_en, wr_en, full, empty, clk, rst, dout, din
)/* synthesis syn_black_box syn_noprune=1 */;
  output valid;
  input rd_en;
  input wr_en;
  output full;
  output empty;
  input clk;
  input rst;
  output [74 : 0] dout;
  input [74 : 0] din;
  
  // synthesis translate_off
  
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot_181 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot_180 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_rstpot_179 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_173 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_169 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/wr_ack_i ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/rden_fifo ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_q_164 ;
  wire \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_fifo ;
  wire \BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ;
  wire \BU2/U0/gbiv5.bi/rstbt/wr_rst_fb_161 ;
  wire \BU2/U0/gbiv5.bi/rstbt/rd_rst_fb_160 ;
  wire \BU2/U0/gbiv5.bi/rstbt/rd_rst_reg_159 ;
  wire \BU2/N1 ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTEMPTY_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTFULL_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDERR_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRERR_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTEMPTY_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTFULL_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDERR_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRERR_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTEMPTY_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTFULL_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDERR_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRERR_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<31>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<30>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<29>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<28>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<27>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<26>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<25>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<24>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<23>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<22>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<21>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<20>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<19>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<18>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<17>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<16>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<15>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<14>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<13>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<0>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<12>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<11>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<10>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<9>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<8>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<7>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<6>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<5>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<4>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<3>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<2>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<1>_UNCONNECTED ;
  wire \NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<0>_UNCONNECTED ;
  wire [74 : 0] din_2;
  wire [74 : 0] dout_3;
  wire [3 : 1] \BU2/U0/gbiv5.bi/v5_fifo.fblk/ful ;
  wire [0 : 0] \BU2/rd_data_count ;
  assign
    dout[74] = dout_3[74],
    dout[73] = dout_3[73],
    dout[72] = dout_3[72],
    dout[71] = dout_3[71],
    dout[70] = dout_3[70],
    dout[69] = dout_3[69],
    dout[68] = dout_3[68],
    dout[67] = dout_3[67],
    dout[66] = dout_3[66],
    dout[65] = dout_3[65],
    dout[64] = dout_3[64],
    dout[63] = dout_3[63],
    dout[62] = dout_3[62],
    dout[61] = dout_3[61],
    dout[60] = dout_3[60],
    dout[59] = dout_3[59],
    dout[58] = dout_3[58],
    dout[57] = dout_3[57],
    dout[56] = dout_3[56],
    dout[55] = dout_3[55],
    dout[54] = dout_3[54],
    dout[53] = dout_3[53],
    dout[52] = dout_3[52],
    dout[51] = dout_3[51],
    dout[50] = dout_3[50],
    dout[49] = dout_3[49],
    dout[48] = dout_3[48],
    dout[47] = dout_3[47],
    dout[46] = dout_3[46],
    dout[45] = dout_3[45],
    dout[44] = dout_3[44],
    dout[43] = dout_3[43],
    dout[42] = dout_3[42],
    dout[41] = dout_3[41],
    dout[40] = dout_3[40],
    dout[39] = dout_3[39],
    dout[38] = dout_3[38],
    dout[37] = dout_3[37],
    dout[36] = dout_3[36],
    dout[35] = dout_3[35],
    dout[34] = dout_3[34],
    dout[33] = dout_3[33],
    dout[32] = dout_3[32],
    dout[31] = dout_3[31],
    dout[30] = dout_3[30],
    dout[29] = dout_3[29],
    dout[28] = dout_3[28],
    dout[27] = dout_3[27],
    dout[26] = dout_3[26],
    dout[25] = dout_3[25],
    dout[24] = dout_3[24],
    dout[23] = dout_3[23],
    dout[22] = dout_3[22],
    dout[21] = dout_3[21],
    dout[20] = dout_3[20],
    dout[19] = dout_3[19],
    dout[18] = dout_3[18],
    dout[17] = dout_3[17],
    dout[16] = dout_3[16],
    dout[15] = dout_3[15],
    dout[14] = dout_3[14],
    dout[13] = dout_3[13],
    dout[12] = dout_3[12],
    dout[11] = dout_3[11],
    dout[10] = dout_3[10],
    dout[9] = dout_3[9],
    dout[8] = dout_3[8],
    dout[7] = dout_3[7],
    dout[6] = dout_3[6],
    dout[5] = dout_3[5],
    dout[4] = dout_3[4],
    dout[3] = dout_3[3],
    dout[2] = dout_3[2],
    dout[1] = dout_3[1],
    dout[0] = dout_3[0],
    din_2[74] = din[74],
    din_2[73] = din[73],
    din_2[72] = din[72],
    din_2[71] = din[71],
    din_2[70] = din[70],
    din_2[69] = din[69],
    din_2[68] = din[68],
    din_2[67] = din[67],
    din_2[66] = din[66],
    din_2[65] = din[65],
    din_2[64] = din[64],
    din_2[63] = din[63],
    din_2[62] = din[62],
    din_2[61] = din[61],
    din_2[60] = din[60],
    din_2[59] = din[59],
    din_2[58] = din[58],
    din_2[57] = din[57],
    din_2[56] = din[56],
    din_2[55] = din[55],
    din_2[54] = din[54],
    din_2[53] = din[53],
    din_2[52] = din[52],
    din_2[51] = din[51],
    din_2[50] = din[50],
    din_2[49] = din[49],
    din_2[48] = din[48],
    din_2[47] = din[47],
    din_2[46] = din[46],
    din_2[45] = din[45],
    din_2[44] = din[44],
    din_2[43] = din[43],
    din_2[42] = din[42],
    din_2[41] = din[41],
    din_2[40] = din[40],
    din_2[39] = din[39],
    din_2[38] = din[38],
    din_2[37] = din[37],
    din_2[36] = din[36],
    din_2[35] = din[35],
    din_2[34] = din[34],
    din_2[33] = din[33],
    din_2[32] = din[32],
    din_2[31] = din[31],
    din_2[30] = din[30],
    din_2[29] = din[29],
    din_2[28] = din[28],
    din_2[27] = din[27],
    din_2[26] = din[26],
    din_2[25] = din[25],
    din_2[24] = din[24],
    din_2[23] = din[23],
    din_2[22] = din[22],
    din_2[21] = din[21],
    din_2[20] = din[20],
    din_2[19] = din[19],
    din_2[18] = din[18],
    din_2[17] = din[17],
    din_2[16] = din[16],
    din_2[15] = din[15],
    din_2[14] = din[14],
    din_2[13] = din[13],
    din_2[12] = din[12],
    din_2[11] = din[11],
    din_2[10] = din[10],
    din_2[9] = din[9],
    din_2[8] = din[8],
    din_2[7] = din[7],
    din_2[6] = din[6],
    din_2[5] = din[5],
    din_2[4] = din[4],
    din_2[3] = din[3],
    din_2[2] = din[2],
    din_2[1] = din[1],
    din_2[0] = din[0];
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/VALID1  (
    .I0(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .O(valid)
  );
  LUT6 #(
    .INIT ( 64'h888C8888AAAEAAAA ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot  (
    .I0(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I4(rd_en),
    .I5(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_173 ),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot_181 )
  );
  LUT6 #(
    .INIT ( 64'h888C8888AAAEAAAA ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot  (
    .I0(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I4(rd_en),
    .I5(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_169 ),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot_180 )
  );
  LUT6 #(
    .INIT ( 64'h888C8888AAAEAAAA ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_rstpot  (
    .I0(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I4(rd_en),
    .I5(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_q_164 ),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_rstpot_179 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot_181 ),
    .PRE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .Q(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot_180 ),
    .PRE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .Q(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_rstpot_179 ),
    .PRE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .Q(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 )
  );
  LUT6 #(
    .INIT ( 64'h0000000ACCCC000A ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo1  (
    .I0(rd_en),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_173 ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .I4(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I5(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo )
  );
  LUT6 #(
    .INIT ( 64'h0000000ACCCC000A ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo1  (
    .I0(rd_en),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_169 ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I4(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .I5(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo )
  );
  LUT6 #(
    .INIT ( 64'h0000000ACCCC000A ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/rden_fifo1  (
    .I0(rd_en),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_q_164 ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .I4(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I5(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_fifo ),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/rden_fifo )
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/wr_ack_i1  (
    .I0(wr_en),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [2]),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [3]),
    .I3(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [1]),
    .O(\BU2/U0/gbiv5.bi/v5_fifo.fblk/wr_ack_i )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/full_i1  (
    .I0(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [1]),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [3]),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [2]),
    .O(full)
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/empty_i1  (
    .I0(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_176 ),
    .I1(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_user_177 ),
    .I2(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_178 ),
    .O(empty)
  );
  FIFO36_EXP #(
    .ALMOST_FULL_OFFSET ( 13'h0001 ),
    .SIM_MODE ( "SAFE" ),
    .DATA_WIDTH ( 36 ),
    .DO_REG ( 0 ),
    .EN_SYN ( "TRUE" ),
    .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
    .ALMOST_EMPTY_OFFSET ( 13'h0003 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36  (
    .RDEN(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo ),
    .WREN(\BU2/U0/gbiv5.bi/v5_fifo.fblk/wr_ack_i ),
    .RST(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .RDCLKU(clk),
    .RDCLKL(clk),
    .WRCLKU(clk),
    .WRCLKL(clk),
    .RDRCLKU(clk),
    .RDRCLKL(clk),
    .ALMOSTEMPTY(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTEMPTY_UNCONNECTED ),
    .ALMOSTFULL(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTFULL_UNCONNECTED ),
    .EMPTY(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .FULL(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [1]),
    .RDERR(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDERR_UNCONNECTED ),
    .WRERR(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRERR_UNCONNECTED ),
    .DI({din_2[31], din_2[30], din_2[29], din_2[28], din_2[27], din_2[26], din_2[25], din_2[24], din_2[23], din_2[22], din_2[21], din_2[20], din_2[19]
, din_2[18], din_2[17], din_2[16], din_2[15], din_2[14], din_2[13], din_2[12], din_2[11], din_2[10], din_2[9], din_2[8], din_2[7], din_2[6], din_2[5]
, din_2[4], din_2[3], din_2[2], din_2[1], din_2[0]}),
    .DIP({din_2[35], din_2[34], din_2[33], din_2[32]}),
    .DO({dout_3[31], dout_3[30], dout_3[29], dout_3[28], dout_3[27], dout_3[26], dout_3[25], dout_3[24], dout_3[23], dout_3[22], dout_3[21], 
dout_3[20], dout_3[19], dout_3[18], dout_3[17], dout_3[16], dout_3[15], dout_3[14], dout_3[13], dout_3[12], dout_3[11], dout_3[10], dout_3[9], 
dout_3[8], dout_3[7], dout_3[6], dout_3[5], dout_3[4], dout_3[3], dout_3[2], dout_3[1], dout_3[0]}),
    .DOP({dout_3[35], dout_3[34], dout_3[33], dout_3[32]}),
    .RDCOUNT({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<0>_UNCONNECTED }),
    .WRCOUNT({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<0>_UNCONNECTED })
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .PRE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .Q(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_173 )
  );
  FIFO36_EXP #(
    .ALMOST_FULL_OFFSET ( 13'h0001 ),
    .SIM_MODE ( "SAFE" ),
    .DATA_WIDTH ( 36 ),
    .DO_REG ( 0 ),
    .EN_SYN ( "TRUE" ),
    .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
    .ALMOST_EMPTY_OFFSET ( 13'h0003 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36  (
    .RDEN(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo ),
    .WREN(\BU2/U0/gbiv5.bi/v5_fifo.fblk/wr_ack_i ),
    .RST(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .RDCLKU(clk),
    .RDCLKL(clk),
    .WRCLKU(clk),
    .WRCLKL(clk),
    .RDRCLKU(clk),
    .RDRCLKL(clk),
    .ALMOSTEMPTY(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTEMPTY_UNCONNECTED ),
    .ALMOSTFULL(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTFULL_UNCONNECTED ),
    .EMPTY(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .FULL(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [2]),
    .RDERR(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDERR_UNCONNECTED ),
    .WRERR(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRERR_UNCONNECTED ),
    .DI({din_2[67], din_2[66], din_2[65], din_2[64], din_2[63], din_2[62], din_2[61], din_2[60], din_2[59], din_2[58], din_2[57], din_2[56], din_2[55]
, din_2[54], din_2[53], din_2[52], din_2[51], din_2[50], din_2[49], din_2[48], din_2[47], din_2[46], din_2[45], din_2[44], din_2[43], din_2[42], 
din_2[41], din_2[40], din_2[39], din_2[38], din_2[37], din_2[36]}),
    .DIP({din_2[71], din_2[70], din_2[69], din_2[68]}),
    .DO({dout_3[67], dout_3[66], dout_3[65], dout_3[64], dout_3[63], dout_3[62], dout_3[61], dout_3[60], dout_3[59], dout_3[58], dout_3[57], 
dout_3[56], dout_3[55], dout_3[54], dout_3[53], dout_3[52], dout_3[51], dout_3[50], dout_3[49], dout_3[48], dout_3[47], dout_3[46], dout_3[45], 
dout_3[44], dout_3[43], dout_3[42], dout_3[41], dout_3[40], dout_3[39], dout_3[38], dout_3[37], dout_3[36]}),
    .DOP({dout_3[71], dout_3[70], dout_3[69], dout_3[68]}),
    .RDCOUNT({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<0>_UNCONNECTED }),
    .WRCOUNT({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<0>_UNCONNECTED })
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .PRE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .Q(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_169 )
  );
  FIFO36_EXP #(
    .ALMOST_FULL_OFFSET ( 13'h0001 ),
    .SIM_MODE ( "SAFE" ),
    .DATA_WIDTH ( 36 ),
    .DO_REG ( 0 ),
    .EN_SYN ( "TRUE" ),
    .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
    .ALMOST_EMPTY_OFFSET ( 13'h0003 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36  (
    .RDEN(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/rden_fifo ),
    .WREN(\BU2/U0/gbiv5.bi/v5_fifo.fblk/wr_ack_i ),
    .RST(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .RDCLKU(clk),
    .RDCLKL(clk),
    .WRCLKU(clk),
    .WRCLKL(clk),
    .RDRCLKU(clk),
    .RDRCLKL(clk),
    .ALMOSTEMPTY(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTEMPTY_UNCONNECTED ),
    .ALMOSTFULL(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_ALMOSTFULL_UNCONNECTED ),
    .EMPTY(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_fifo ),
    .FULL(\BU2/U0/gbiv5.bi/v5_fifo.fblk/ful [3]),
    .RDERR(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDERR_UNCONNECTED ),
    .WRERR(\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRERR_UNCONNECTED ),
    .DI({\BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], 
\BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], 
\BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], 
\BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], 
\BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], 
din_2[74], din_2[73], din_2[72]}),
    .DIP({\BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0], \BU2/rd_data_count [0]}),
    .DO({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<31>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<30>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<29>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<28>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<27>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<26>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<25>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<24>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<23>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<22>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<21>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<20>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<19>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<18>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<17>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<16>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<15>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<14>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<13>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DO<3>_UNCONNECTED , dout_3[74], dout_3[73], dout_3[72]}),
    .DOP({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_DOP<0>_UNCONNECTED }),
    .RDCOUNT({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_RDCOUNT<0>_UNCONNECTED }),
    .WRCOUNT({\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<12>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<11>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<10>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<9>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<8>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<7>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<6>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<5>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<4>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<3>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<2>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<1>_UNCONNECTED , 
\NLW_BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/gfn72.sngfifo36_WRCOUNT<0>_UNCONNECTED })
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_q  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_fifo ),
    .PRE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .Q(\BU2/U0/gbiv5.bi/v5_fifo.fblk/gextw[3].inst_extd/gonep.inst_prim/empty_q_164 )
  );
  FDPE #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/rstbt/rd_rst_reg  (
    .C(clk),
    .CE(\BU2/U0/gbiv5.bi/rstbt/rd_rst_fb_160 ),
    .D(\BU2/rd_data_count [0]),
    .PRE(rst),
    .Q(\BU2/U0/gbiv5.bi/rstbt/rd_rst_reg_159 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/rstbt/wr_rst_fb  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 ),
    .PRE(rst),
    .Q(\BU2/U0/gbiv5.bi/rstbt/wr_rst_fb_161 )
  );
  FDPE #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/rstbt/wr_rst_reg  (
    .C(clk),
    .CE(\BU2/U0/gbiv5.bi/rstbt/wr_rst_fb_161 ),
    .D(\BU2/rd_data_count [0]),
    .PRE(rst),
    .Q(\BU2/U0/gbiv5.bi/rstbt/wr_rst_reg_162 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \BU2/U0/gbiv5.bi/rstbt/rd_rst_fb  (
    .C(clk),
    .D(\BU2/U0/gbiv5.bi/rstbt/rd_rst_reg_159 ),
    .PRE(rst),
    .Q(\BU2/U0/gbiv5.bi/rstbt/rd_rst_fb_160 )
  );
  VCC   \BU2/XST_VCC  (
    .P(\BU2/N1 )
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/rd_data_count [0])
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
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

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
