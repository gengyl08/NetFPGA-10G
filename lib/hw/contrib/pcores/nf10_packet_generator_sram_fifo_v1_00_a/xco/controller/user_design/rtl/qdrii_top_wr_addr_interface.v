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
//  /   /         Filename           : qdrii_top_wr_addr_interface.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//   1. Responsible for storing the Write requests made by the user design.
//      Instantiates the FIFOs for Write address and control storage.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_top_wr_addr_interface #
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
   input                   user_w_n,
   input [ADDR_WIDTH-1:0]  user_ad_wr,
   input                   wr_init_n,
   output [ADDR_WIDTH-1:0] fifo_ad_wr,
   output                  wr_adr_empty,
   output                  wr_adr_full
   );

   wire [31:0] fifo_address_input;
   wire [31:0] fifo_adddress_output;

   assign fifo_ad_wr         = fifo_adddress_output[ADDR_WIDTH-1:0];
   assign fifo_address_input =  {{32-ADDR_WIDTH{1'b0}}, user_ad_wr[ADDR_WIDTH-1:0]};
   // Write Address / Byte Enable FIFO

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
        .DI          ( fifo_address_input ),
        .DIP         ( 4'b0 ),
        .RDCLK       ( clk0 ),
        .RDEN        ( ~wr_init_n ),
        .RST         ( user_rst_0 ),
        .WRCLK       ( clk0 ),
        .WREN        ( ~user_w_n ),
        .ALMOSTEMPTY ( ),
        .ALMOSTFULL  ( wr_adr_full ),
        .DO          ( fifo_adddress_output ),
        .DOP         ( ),
        .EMPTY       ( wr_adr_empty ),
        .FULL        ( ),
        .RDCOUNT     ( ),
        .RDERR       ( ),
        .WRCOUNT     ( ),
        .WRERR       ( )
        );

endmodule