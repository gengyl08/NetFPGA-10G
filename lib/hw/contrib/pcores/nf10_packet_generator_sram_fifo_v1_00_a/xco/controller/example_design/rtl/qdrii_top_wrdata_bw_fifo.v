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
//  /   /         Filename           : qdrii_top_wrdata_bw_fifo.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Responsible for storing the Byte Write requests made by the
//          user design. Instantiates the FIFOs for Byte Write data storage.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_top_wrdata_bw_fifo #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter BW_WIDTH = 8
   )
  (
   input                     clk0,
   input                     clk270,
   input                     user_rst_270,
   input [(2*BW_WIDTH)-1:0]  idata,
   input                     rdenb,
   input                     wrenb,
   output [(2*BW_WIDTH)-1:0] odata
   );

   wire [35:0] fifo_data_in;
   wire [35:0] fifo_data_out;

   assign fifo_data_in = {{36-(2*BW_WIDTH){1'b0}}, idata[(2*BW_WIDTH)-1:0]};
   assign odata        = fifo_data_out[(2*BW_WIDTH)-1:0];

   FIFO36 #
     (
      .ALMOST_FULL_OFFSET      ( 13'h0080 ),
      .ALMOST_EMPTY_OFFSET     ( 13'h0080 ),
      .DATA_WIDTH              ( 36 ),
      .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
      .DO_REG                  ( 1 ),
      .EN_SYN                  ( "FALSE" )
      )
     U_FIFO36
       (
        .DI          ( fifo_data_in[31:0] ),
        .DIP         ( fifo_data_in[35:32] ),
        .RDCLK       ( clk270 ),
        .RDEN        ( rdenb ),
        .RST         ( user_rst_270 ),
        .WRCLK       ( clk0 ),
        .WREN        ( wrenb ),
        .ALMOSTEMPTY ( ),
        .ALMOSTFULL  ( ),
        .DO          ( fifo_data_out[31:0] ),
        .DOP         ( fifo_data_out[35:32] ),
        .EMPTY       ( ),
        .FULL        ( ),
        .RDCOUNT     ( ),
        .RDERR       ( ),
        .WRCOUNT     ( ),
        .WRERR       ( )
        );

endmodule