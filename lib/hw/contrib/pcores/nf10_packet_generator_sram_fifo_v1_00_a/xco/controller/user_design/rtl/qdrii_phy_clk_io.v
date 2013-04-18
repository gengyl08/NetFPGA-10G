//*****************************************************************************
// DISCLAIMER OF LIABILITY
//
// This file contains proprietary and confidential information of
// Xilinx, Inc. ("Xilinx"), that is distributed under a license
// from Xilinx, and may be used, copied and/or disclosed only
// pursuant to the terms of a valid license agreement with Xilinx.
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
// LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
// MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
// does not warrant that functions included in the Materials will
// meet the requirements of Licensee, or that the operation of the
// Materials will be uninterrupted or error-free, or that defects
// in the Materials will be corrected. Furthermore, Xilinx does
// not warrant or make any representations regarding use, or the
// results of the use, of the Materials in terms of correctness,
// accuracy, reliability or otherwise.
//
// Xilinx products are not designed or intended to be fail-safe,
// or for use in any application requiring fail-safe performance,
// such as life-support or safety devices or systems, Class III
// medical devices, nuclear facilities, applications related to
// the deployment of airbags, or any other applications that could
// lead to death, personal injury or severe property or
// environmental damage (individually and collectively, "critical
// applications"). Customer assumes the sole risk and liability
// of any use of Xilinx products in critical applications,
// subject only to applicable laws and regulations governing
// limitations on product liability.
//
// Copyright 2006, 2007, 2008 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.6.1
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_phy_clk_io.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:06 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//  1. Generates the memory C/C# and K/K# clocks and the DLL Disable signal.
//
//Revision History:
//
//*****************************************************************************


`timescale 1ns/1ps

module qdrii_phy_clk_io #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter CLK_WIDTH = 2
   )
  (
   input                  clk0,
   input                  user_rst_0,
   input                  init_cnt_done,
   output [CLK_WIDTH-1:0] qdr_c,
   output [CLK_WIDTH-1:0] qdr_c_n,
   output [CLK_WIDTH-1:0] qdr_k,
   output [CLK_WIDTH-1:0] qdr_k_n,
   output                 qdr_dll_off_n
   );

   reg qdr_dll_off_int;

   wire [CLK_WIDTH-1:0] clk_out;
   wire [CLK_WIDTH-1:0] clk_outb;
   wire                 qdr_dll_off_out;

   assign qdr_c   = {CLK_WIDTH{1'b1}};
   assign qdr_c_n = {CLK_WIDTH{1'b1}};

   //QDR_DLL_OFF is asserted high after the 200 us initial count
//   always @ (posedge clk0)
//     begin
//        if (user_rst_0)
//          qdr_dll_off_int <= 1'b0;
//        else if(init_cnt_done)
//          qdr_dll_off_int <= 1'b1;
//     end

   always @ (posedge clk0)
     begin
        if(init_cnt_done)
          qdr_dll_off_int <= 1'b1;
        else
          qdr_dll_off_int <= 1'b0;
     end

   (* IOB = "FORCE" *) FDRSE #
     (
      .INIT(1'b0)
      )
     QDR_DLL_OFF_FF
       (
        .Q  ( qdr_dll_off_out ),
        .C  ( clk0 ),
        .CE ( 1'b1 ),
        .D  ( qdr_dll_off_int ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        )/* synthesis syn_useioff = 1 */;


   OBUF obuf_dll_off_n
     (
      .I(qdr_dll_off_out),
      .O(qdr_dll_off_n)
      );

   genvar clk_i;
   generate
      for(clk_i = 0; clk_i < CLK_WIDTH; clk_i = clk_i +1)
        begin : CLK_INST
           ODDR #
             (
              .DDR_CLK_EDGE ( "OPPOSITE_EDGE" )
              )
             ODDR_K_CLK0
               (
                .Q  ( clk_out[clk_i] ),
                .C  ( clk0 ),
                .CE ( 1'b1 ),
                .D1 ( 1'b1 ),
                .D2 ( 1'b0 ),
                .R  ( 1'b0 ),
                .S  ( 1'b0 )
                );

           ODDR #
             (
              .DDR_CLK_EDGE ( "OPPOSITE_EDGE" )
              )
             ODDR_K_CLKB
               (
                .Q  ( clk_outb[clk_i] ),
                .C  ( clk0 ),
                .CE ( 1'b1 ),
                .D1 ( 1'b0 ),
                .D2 ( 1'b1 ),
                .R  ( 1'b0 ),
                .S  ( 1'b0 )
                );

           OBUF OBUF_K_CLK
             (
              .I( clk_out[clk_i] ),
              .O( qdr_k[clk_i] )
              );

           OBUF OBUF_K_CLKB
             (
              .I( clk_outb[clk_i] ),
              .O( qdr_k_n[clk_i] )
              );
        end
   endgenerate

endmodule