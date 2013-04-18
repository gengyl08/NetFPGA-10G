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
//  /   /         Filename           : qdrii_top_rd_addr_interface.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Responsible for storing the Read requests made by the user design.
//       2. Instantiates the FIFOs for Read address and control storage.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_top_rd_addr_interface #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter ADDR_WIDTH = 19
   )
  (
   input                   clk0,
   input                   user_rst_0,
   input                   user_r_n,
   input [ADDR_WIDTH-1:0]  user_ad_rd,
   input                   rd_init_n,
   output                  usr_rd_full,
   output [ADDR_WIDTH-1:0] fifo_ad_rd,
   output                  fifo_rd_empty
   );

   wire [31:0] fifo_input_address;
   wire [31:0] fifo_output_address;

   assign fifo_input_address[ADDR_WIDTH-1:0] = user_ad_rd[ADDR_WIDTH-1:0];
   assign fifo_input_address[31:ADDR_WIDTH]  = 'b0;

   assign fifo_ad_rd = fifo_output_address[ADDR_WIDTH-1:0];

   // Read Address FIFO
   FIFO36 #
     (
      .ALMOST_FULL_OFFSET      ( 13'h0080 ),
      .ALMOST_EMPTY_OFFSET     ( 13'h0080 ),
      .DATA_WIDTH              ( 36 ),
      .FIRST_WORD_FALL_THROUGH ( "TRUE" ),
      .DO_REG                  ( 1 ),
      .EN_SYN                  ( "FALSE" )
      )
     U_FIFO36
       (
        .DI          ( fifo_input_address ),
        .DIP         ( 4'b0 ),
        .RDCLK       ( clk0 ),
        .RDEN        ( ~rd_init_n ),
        .RST         ( user_rst_0 ),
        .WRCLK       ( clk0 ),
        .WREN        ( ~user_r_n ),
        .ALMOSTEMPTY ( ),
        .ALMOSTFULL  ( usr_rd_full ),
        .DO          ( fifo_output_address ),
        .DOP         ( ),
        .EMPTY       ( fifo_rd_empty ),
        .FULL        ( ),
        .RDCOUNT     ( ),
        .RDERR       ( ),
        .WRCOUNT     ( ),
        .WRERR       ( )
        );

endmodule