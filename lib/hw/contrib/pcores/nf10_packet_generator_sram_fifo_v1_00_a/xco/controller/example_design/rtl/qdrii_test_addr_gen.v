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
//  /   /         Filename           : qdrii_test_addr_gen.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. generates the write and read test memory addresses.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_test_addr_gen #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter ADDR_WIDTH   = 19,
   parameter BURST_LENGTH = 4
   )
  (
   input                       user_clk0,
   input                       user_reset,
   input                       user_w_n,
   input                       test_w_n,
   input                       user_r_n,
   output reg [ADDR_WIDTH-1:0] user_ad_wr,
   output reg [ADDR_WIDTH-1:0] user_ad_rd
   );

   reg [ADDR_WIDTH:0] test_ad_wr;

   // Write Address is generated for every alternate clock for BL4 and on every
   // clock for BL2.
//   always @(posedge user_clk0)
//     begin
//        if (user_reset)
//          user_ad_wr <= 'b0;
//        else if (BURST_LENGTH == 4)
//          user_ad_wr[ADDR_WIDTH-1:0] <= test_ad_wr[ADDR_WIDTH:1];
//        else
//          user_ad_wr[ADDR_WIDTH-1:0] <= test_ad_wr[ADDR_WIDTH-1:0];
//     end

   always @(posedge user_clk0)
     begin
        if (BURST_LENGTH == 4)
          user_ad_wr[ADDR_WIDTH-1:0] <= test_ad_wr[ADDR_WIDTH:1];
        else if(BURST_LENGTH == 2)
          user_ad_wr[ADDR_WIDTH-1:0] <= test_ad_wr[ADDR_WIDTH-1:0];
     end

   always @(posedge user_clk0)
     begin
        if (user_reset)
          test_ad_wr <= 'b0;
        else if (~test_w_n | ~user_w_n )
          test_ad_wr <= test_ad_wr + 1;
        else
          test_ad_wr <= test_ad_wr;
     end

   always @(posedge user_clk0)
     begin
        if (user_reset)
          user_ad_rd <= 'b0;
        else if (~user_r_n)
          user_ad_rd <= user_ad_rd + 1;
     end

endmodule