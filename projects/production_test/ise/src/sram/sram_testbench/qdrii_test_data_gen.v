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
// \   \   \/     Version            : 3.2
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_test_data_gen.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2009/05/11 21:13:38 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. generates test write data for the memory interface.
//
//Revision History:
//
//*****************************************************************************


`timescale 1ns/1ps

module qdrii_test_data_gen #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module sram_controller module. Please refer to the
   // sram_controller module for actual values.
   parameter BW_WIDTH   = 8,
   parameter DATA_WIDTH = 72
   )
  (
   input                       user_clk0,
   input                       user_reset,
   input                       user_w_n,
   input                       test_w_n,
   input                       user_qr_valid,
   input                       wr_begin,
   output reg [DATA_WIDTH-1:0] user_dwl,
   output reg [DATA_WIDTH-1:0] user_dwh,
   output [DATA_WIDTH-1:0]     dwl_comp,
   output [DATA_WIDTH-1:0]     dwh_comp
   );

   localparam PATTERN_A = 9'h1FF,
              PATTERN_B = 9'h000,
              PATTERN_C = 9'h155,
              PATTERN_D = 9'h0AA;

   reg [7:0] data_counter_wr;
   reg [7:0] data_counter_comp_l;

   always @ (posedge user_clk0)
     begin
        if(user_reset)
          data_counter_wr <= {8{1'b0}};
        else if (user_qr_valid)
          data_counter_wr <= data_counter_wr + 1;
     end

   assign dwl_comp = {BW_WIDTH{data_counter_wr, 1'b1}};
   assign dwh_comp = {BW_WIDTH{data_counter_wr, 1'b0}};

   always @ (posedge user_clk0)
     begin
        if(user_reset)
          data_counter_comp_l <= {8{1'b0}};
        else if  (~test_w_n | ~user_w_n)
          data_counter_comp_l <= data_counter_comp_l + 1;
     end

//   always @ (posedge user_clk0)
//     begin
//        if(user_reset) begin
//           user_dwl <= {DATA_WIDTH{1'b0}};
//           user_dwh <= {DATA_WIDTH{1'b0}};
//        end else if (wr_begin) begin
//           user_dwl <= {BW_WIDTH{data_counter_comp_l, 1'b1}};
//           user_dwh <= {BW_WIDTH{data_counter_comp_l, 1'b0}};
//        end
//     end

   always @ (posedge user_clk0)
     begin
        if (wr_begin) begin
           user_dwl <= {BW_WIDTH{data_counter_comp_l, 1'b1}};
           user_dwh <= {BW_WIDTH{data_counter_comp_l, 1'b0}};
        end
     end

endmodule