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
//  /   /         Filename           : qdrii_tb_top.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. serves as the top level synthesizable user backend module.
//       2. Instantiates the write data generation, address generation modules
//          as well the compare modules to check for error.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_tb_top #
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
   input                   user_wr_full,
   input                   user_rd_full,
   input [DATA_WIDTH-1:0]  user_qrl,
   input [DATA_WIDTH-1:0]  user_qrh,
   input                   user_qr_valid,
   input                   cal_done,
   output                  user_ad_w_n,
   output                  user_d_w_n,
   output [ADDR_WIDTH-1:0] user_ad_wr,
   output [BW_WIDTH-1:0]   user_bwh_n,
   output [BW_WIDTH-1:0]   user_bwl_n,
   output [DATA_WIDTH-1:0] user_dwl,
   output [DATA_WIDTH-1:0] user_dwh,
   output                  user_r_n,
   output [ADDR_WIDTH-1:0] user_ad_rd,
   output                  compare_error
   );

   wire                  test_w_n;
   wire [DATA_WIDTH-1:0] dwl_comp;
   wire [DATA_WIDTH-1:0] dwh_comp;
   wire                  wr_begin;

   assign user_bwh_n = {BW_WIDTH{1'b0}};  // Byte Write enables all enabled in this testbench
   assign user_bwl_n = {BW_WIDTH{1'b0}};

   // State machine for issuing Read / Write requests based on stored BRAM data

   qdrii_test_wr_rd_sm #
     (
      .BURST_LENGTH ( BURST_LENGTH )
      )
     U_QDRII_TEST_WR_RD_SM
       (
        .clk          ( clk0 ),
        .reset        ( user_rst_0 ),
        .cal_done     ( cal_done ),
        .user_wr_full ( user_wr_full ),
        .user_rd_full ( user_rd_full ),
        .test_w_n     ( test_w_n ),
        .user_d_w_n   ( user_d_w_n ),
        .user_ad_w_n  ( user_ad_w_n ),
        .user_r_n     ( user_r_n ),
        .wr_begin     ( wr_begin )
        );


   // State machine for reading back values from Read data FIFOs and comparing
   // to values stored in the testbench BRAMs.  This module is the hardware
   // testbench error detection module that makes sure the data returning from
   // the QDR II device is the same as the data written to it.

   qdrii_test_q_sm #
      (
       .DATA_WIDTH ( DATA_WIDTH )
       )
     U_QDRII_TEST_Q_SM
      (
       .clk           ( clk0 ),
       .reset         ( user_rst_0 ),
       .user_qr_valid ( user_qr_valid ),
       .user_qrl      ( user_qrl ),
       .user_qrh      ( user_qrh ),
       .dwl_comp      ( dwl_comp ),
       .dwh_comp      ( dwh_comp ),
       .compare_error ( compare_error )
       );

   qdrii_test_data_gen #
      (
       .DATA_WIDTH ( DATA_WIDTH ),
       .BW_WIDTH   ( BW_WIDTH )
       )
     U_QDRII_TEST_DATA_GEN
      (
       .user_clk0     ( clk0 ),
       .user_reset    ( user_rst_0 ),
       .user_w_n      ( user_d_w_n ),
       .test_w_n      ( test_w_n ),
       .user_qr_valid ( user_qr_valid ),
       .wr_begin      ( wr_begin ),
       .user_dwl      ( user_dwl ),
       .user_dwh      ( user_dwh ),
       .dwl_comp      ( dwl_comp ),
       .dwh_comp      ( dwh_comp )
       );

   qdrii_test_addr_gen #
      (
       .ADDR_WIDTH   ( ADDR_WIDTH ),
       .BURST_LENGTH ( BURST_LENGTH )
       )
     U_QDRII_TEST_ADDR_GEN
      (
       .user_clk0  ( clk0 ),
       .user_reset ( user_rst_0 ),
       .user_w_n   ( user_ad_w_n ),
       .test_w_n   ( test_w_n ),
       .user_r_n   ( user_r_n ),
       .user_ad_wr ( user_ad_wr ),
       .user_ad_rd ( user_ad_rd )
       );

endmodule