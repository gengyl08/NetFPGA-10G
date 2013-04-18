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
//  /   /         Filename           : qdrii_top_wr_data_interface.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Responsible for storing the Write data written by the user design.
//          Instantiates the FIFOs for storing the write data.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_top_wr_data_interface #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter BURST_LENGTH = 4,
   parameter BW_WIDTH     = 8,
   parameter DATA_WIDTH   = 72
   )
  (
   input                   clk0,
   input                   clk270,
   input                   user_rst_0,
   input                   user_rst_270,
   input                   cal_done,
   input [DATA_WIDTH-1:0]  dummy_wrl,
   input [DATA_WIDTH-1:0]  dummy_wrh,
   input                   dummy_wren,
   input                   user_w_n,
   input [BW_WIDTH-1:0]    user_bw_h,
   input [BW_WIDTH-1:0]    user_bw_l,
   input [DATA_WIDTH-1:0]  user_dwl,
   input [DATA_WIDTH-1:0]  user_dwh,
   input                   wr_init2_n,
   output [DATA_WIDTH-1:0] fifo_dwl,
   output [DATA_WIDTH-1:0] fifo_dwh,
   output [BW_WIDTH-1:0]   fifo_bw_h,
   output [BW_WIDTH-1:0]   fifo_bw_l
   );

   wire                    wrfifo_wren_r1;
   wire                    user_w_n_stretch;
   wire [(2*BW_WIDTH)-1:0] user_fifo_bw_out;
   wire [(2*BW_WIDTH)-1:0] user_fifo_bw_in;
   wire [(2*BW_WIDTH)-1:0] user_fifo_bw;
   wire                    wrfifo_wren;
   wire [DATA_WIDTH-1:0]   wrfifo_wrdata_l;
   wire [DATA_WIDTH-1:0]   wrfifo_wrdata_h;

//   assign wrfifo_wren =  user_w_n && ~dummy_wren;
   assign wrfifo_wren = cal_done ? user_w_n : ~dummy_wren;
//   assign wrfifo_wrdata_l =  user_dwl | dummy_wrl ;
//   assign wrfifo_wrdata_h =  user_dwh | dummy_wrh ;
   assign wrfifo_wrdata_l = cal_done ? user_dwl : dummy_wrl;
   assign wrfifo_wrdata_h = cal_done ? user_dwh : dummy_wrh;

   FDRSE #
     (
      .INIT(1'b1)
      )
     USER_W_N_FF
       (
        .Q  ( wrfifo_wren_r1 ),
        .C  ( clk0 ),
        .CE ( 1'b1 ),
        .D  ( wrfifo_wren ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   assign user_w_n_stretch = (BURST_LENGTH == 4) ? (wrfifo_wren  & wrfifo_wren_r1) :
                                                    wrfifo_wren;

   qdrii_top_wrdata_fifo #
      (
       .DATA_WIDTH (DATA_WIDTH)
       )
      U_QDRII_TOP_WRDATA_FIFO
        (
         .clk0         ( clk0 ),
         .clk270       ( clk270 ),
         .user_rst_270 ( user_rst_270 ),
         .idata_lsb    ( wrfifo_wrdata_l ),
         .idata_msb    ( wrfifo_wrdata_h ),
         .rdenb        ( ~wr_init2_n ),
         .wrenb        ( ~user_w_n_stretch ),
         .odata_lsb    ( fifo_dwl ),
         .odata_msb    ( fifo_dwh )
         );

   assign user_fifo_bw = {user_bw_h[BW_WIDTH-1:0], user_bw_l[BW_WIDTH-1:0]};
   assign user_fifo_bw_in = cal_done ? user_fifo_bw : {(2*BW_WIDTH){1'b0}};

   qdrii_top_wrdata_bw_fifo #
      (
       .BW_WIDTH (BW_WIDTH)
       )
      U_QDRII_TOP_WRDATA_BW_FIFO
         (
          .clk0         ( clk0 ),
          .clk270       ( clk270 ),
          .user_rst_270 ( user_rst_270 ),
          .idata        ( user_fifo_bw_in ),
          .rdenb        ( ~wr_init2_n ),
          .wrenb        ( ~user_w_n_stretch ),
          .odata        ( user_fifo_bw_out )
          );

//   assign user_fifo_bw_in = {user_bw_h[BW_WIDTH-1:0], user_bw_l[BW_WIDTH-1:0]};
   assign fifo_bw_l       = user_fifo_bw_out[BW_WIDTH-1:0];
   assign fifo_bw_h       = user_fifo_bw_out[(2*BW_WIDTH)-1:BW_WIDTH];

endmodule