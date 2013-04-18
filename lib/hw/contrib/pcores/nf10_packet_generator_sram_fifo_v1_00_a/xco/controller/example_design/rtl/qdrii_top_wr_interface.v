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
//  /   /         Filename           : qdrii_top_wr_interface.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Responsible for storing the Write requests made by the user design.
//          Instantiates the FIFOs for Write address, data, and control storage.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps


module qdrii_top_wr_interface #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter ADDR_WIDTH   = 19,
   parameter BURST_LENGTH = 4,
   parameter BW_WIDTH     = 8,
   parameter DATA_WIDTH   = 72
   )
  (
   input                   clk0,
   input                   user_rst_0,
   input                   clk270,
   input                   user_rst_270,
   input                   cal_done,
   input [DATA_WIDTH-1:0]  dummy_wrl,
   input [DATA_WIDTH-1:0]  dummy_wrh,
   input                   dummy_wren,
   input                   user_ad_w_n,
   input                   user_d_w_n,
   input [ADDR_WIDTH-1:0]  user_ad_wr,
   input [BW_WIDTH-1:0]    user_bw_h,
   input [BW_WIDTH-1:0]    user_bw_l,
   input [DATA_WIDTH-1:0]  user_dwl,
   input [DATA_WIDTH-1:0]  user_dwh,
   input                   wr_init_n,
   input                   wr_init2_n,
   output                  user_wr_full,
   output [ADDR_WIDTH-1:0] fifo_ad_wr,
   output [BW_WIDTH-1:0]   fifo_bw_h,
   output [BW_WIDTH-1:0]   fifo_bw_l,
   output [DATA_WIDTH-1:0] fifo_dwl,
   output [DATA_WIDTH-1:0] fifo_dwh,
   output                  fifo_wr_empty
   );


   wire wr_adr_empty;
   wire wr_adr_full;

   qdrii_top_wr_addr_interface #
      (
       .ADDR_WIDTH (ADDR_WIDTH)
       )
      U_QDRII_TOP_WR_ADDR_INTERFACE
        (
         .clk0         ( clk0 ),
         .user_rst_0   ( user_rst_0 ),
         .user_w_n     ( user_ad_w_n ),
         .user_ad_wr   ( user_ad_wr ),
         .wr_init_n    ( wr_init_n ),
         .fifo_ad_wr   ( fifo_ad_wr ),
         .wr_adr_empty ( wr_adr_empty ),
         .wr_adr_full  ( wr_adr_full )
         );

   qdrii_top_wr_data_interface #
      (
       .BURST_LENGTH (BURST_LENGTH),
       .BW_WIDTH     (BW_WIDTH),
       .DATA_WIDTH   (DATA_WIDTH)
       )
      U_QDRII_TOP_WR_DATA_INTERFACE
        (
         .clk0         ( clk0 ),
         .user_rst_0   ( user_rst_0 ),
         .clk270       ( clk270 ),
         .user_rst_270 ( user_rst_270 ),
         .cal_done     ( cal_done ),
         .dummy_wrl    ( dummy_wrl ),
         .dummy_wrh    ( dummy_wrh ),
         .dummy_wren   ( dummy_wren ),
         .user_w_n     ( user_d_w_n ),
         .user_bw_h    ( user_bw_h ),
         .user_bw_l    ( user_bw_l ),
         .user_dwl     ( user_dwl ),
         .user_dwh     ( user_dwh ),
         .wr_init2_n   ( wr_init2_n ),
         .fifo_dwl     ( fifo_dwl ),
         .fifo_dwh     ( fifo_dwh ),
         .fifo_bw_h    ( fifo_bw_h ),
         .fifo_bw_l    ( fifo_bw_l )
         );

   assign user_wr_full  = wr_adr_full ;
   assign fifo_wr_empty = wr_adr_empty ;

endmodule