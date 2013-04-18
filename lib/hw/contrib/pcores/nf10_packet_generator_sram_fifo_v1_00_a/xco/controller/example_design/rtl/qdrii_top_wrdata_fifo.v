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
//  /   /         Filename           : qdrii_top_wrdata_fifo.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Responsible for storing the Write/Read requests made by the user
//          design. Instantiates the FIFOs for Write/Read data storage.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_top_wrdata_fifo #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter DATA_WIDTH = 72
   )
  (
   input                   clk0,
   input                   clk270,
   input                   user_rst_270,
   input [DATA_WIDTH-1:0]  idata_lsb,
   input [DATA_WIDTH-1:0]  idata_msb,
   input                   rdenb,
   input                   wrenb,
   output [DATA_WIDTH-1:0] odata_lsb,
   output [DATA_WIDTH-1:0] odata_msb
   );

   wire [71:0] fifo_data_lsb_input;
   wire [71:0] fifo_data_msb_input;
   wire [71:0] fifo_data_lsb_output;
   wire [71:0] fifo_data_msb_output;

   assign fifo_data_lsb_input =(DATA_WIDTH == 72) ?
                                idata_lsb : {{72-DATA_WIDTH{1'b0}},idata_lsb};
   assign fifo_data_msb_input =(DATA_WIDTH == 72) ?
                                idata_msb : {{72-DATA_WIDTH{1'b0}},idata_msb};

   assign odata_lsb = fifo_data_lsb_output[DATA_WIDTH-1:0];
   assign odata_msb = fifo_data_msb_output[DATA_WIDTH-1:0];

   // Write Data FIFO - Low Word

   FIFO36_72 #
     (
      .ALMOST_FULL_OFFSET      ( 13'h0080 ),
      .ALMOST_EMPTY_OFFSET     ( 13'h0080 ),
      .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
      .DO_REG                  ( 1 ),
      .EN_SYN                  ( "FALSE" )
      )
     U_FIFO36_72_LSB
       (
        .DI          ( fifo_data_lsb_input[63:0] ),
        .DIP         ( fifo_data_lsb_input[71:64] ),
        .RDCLK       ( clk270 ),
        .RDEN        ( rdenb ),
        .RST         ( user_rst_270 ),
        .WRCLK       ( clk0 ),
        .WREN        ( wrenb ),
        .DBITERR     ( ),
        .ECCPARITY   ( ),
        .SBITERR     ( ),
        .ALMOSTEMPTY ( ),
        .ALMOSTFULL  ( ),
        .DO          ( fifo_data_lsb_output[63:0] ),
        .DOP         ( fifo_data_lsb_output[71:64] ),
        .EMPTY       ( ),
        .FULL        ( ),
        .RDCOUNT     ( ),
        .RDERR       ( ),
        .WRCOUNT     ( ),
        .WRERR       ( )
        );


   // Write Data FIFO - High Word

   FIFO36_72 #
     (
      .ALMOST_FULL_OFFSET      ( 13'h0080 ),
      .ALMOST_EMPTY_OFFSET     ( 13'h0080 ),
      .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
      .DO_REG                  ( 1 ),
      .EN_SYN                  ( "FALSE" )
      )
     U_FIFO36_72_MSB
       (
        .DI          ( fifo_data_msb_input[63:0] ),
        .DIP         ( fifo_data_msb_input[71:64] ),
        .RDCLK       ( clk270 ),
        .RDEN        ( rdenb ),
        .RST         ( user_rst_270 ),
        .WRCLK       ( clk0 ),
        .WREN        ( wrenb ),
        .DBITERR     ( ),
        .ECCPARITY   ( ),
        .SBITERR     ( ),
        .ALMOSTEMPTY ( ),
        .ALMOSTFULL  ( ),
        .DO          ( fifo_data_msb_output[63:0] ),
        .DOP         ( fifo_data_msb_output[71:64] ),
        .EMPTY       ( ),
        .FULL        ( ),
        .RDCOUNT     ( ),
        .RDERR       ( ),
        .WRCOUNT     ( ),
        .WRERR       ( )
        );

endmodule