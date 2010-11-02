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
//  /   /         Filename           : qdrii_test_q_sm.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2009/05/11 21:13:38 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. generates the compare data and compares the write data against the
//          captured read data.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_test_q_sm #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module sram_controller module. Please refer to the
   // sram_controller module for actual values.
   parameter DATA_WIDTH = 72
   )
  (
   input                  clk,
   input                  reset,
   input                  user_qr_valid,
   input [DATA_WIDTH-1:0] user_qrl,
   input [DATA_WIDTH-1:0] user_qrh,
   input [DATA_WIDTH-1:0] dwl_comp,
   input [DATA_WIDTH-1:0] dwh_comp,
   output reg             compare_error
   );

   reg                   compare_en;
   reg                   compare_lsb;
   reg                   compare_msb;
   reg                   cmp_err;
   reg                   compare_en_r;
   reg                   compare_en_2r;
   reg                   compare_error_i;
   reg                   compare_error_2i;
   reg  [DATA_WIDTH-1:0] user_qrl_r ;
   reg  [DATA_WIDTH-1:0] user_qrl_2r;
   reg  [DATA_WIDTH-1:0] user_qrh_r ;
   reg  [DATA_WIDTH-1:0] user_qrh_2r;
   reg  [DATA_WIDTH-1:0] dwh_comp_r ;
   reg  [DATA_WIDTH-1:0] dwh_comp_2r;
   reg  [DATA_WIDTH-1:0] dwl_comp_r ;
   reg  [DATA_WIDTH-1:0] dwl_comp_2r;

   wire [DATA_WIDTH-1:0] comp_lsb;
   wire [DATA_WIDTH-1:0] comp_msb;

//   always @(posedge clk)
//     begin
//        if (reset)
//          compare_en <= 1'b0;
//        else
//          compare_en <= user_qr_valid;
//     end

   always @(posedge clk)
     compare_en <= user_qr_valid;

//   always @ (posedge clk)
//     begin
//        if(reset) begin
//           user_qrl_r    <= 'b0;
//           user_qrl_2r   <= 'b0;
//           user_qrh_r    <= 'b0;
//           user_qrh_2r   <= 'b0;
//           dwh_comp_r    <= 'b0;
//           dwh_comp_2r   <= 'b0;
//           dwl_comp_r    <= 'b0;
//           dwl_comp_2r   <= 'b0;
//           compare_en_r  <= 1'b0;
//           compare_en_2r <= 1'b0;
//        end else begin
//           user_qrl_r    <= user_qrl;
//           user_qrl_2r   <= user_qrl_r;
//           user_qrh_r    <= user_qrh;
//           user_qrh_2r   <= user_qrh_r;
//           dwh_comp_r    <= dwh_comp;
//           dwh_comp_2r   <= dwh_comp_r;
//           dwl_comp_r    <= dwl_comp;
//           dwl_comp_2r   <= dwl_comp_r;
//           compare_en_r  <= user_qr_valid;
//           compare_en_2r <= compare_en_r;
//        end
//     end

   always @ (posedge clk)
     begin
        user_qrl_r    <= user_qrl;
        user_qrl_2r   <= user_qrl_r;
        user_qrh_r    <= user_qrh;
        user_qrh_2r   <= user_qrh_r;
        dwh_comp_r    <= dwh_comp;
        dwh_comp_2r   <= dwh_comp_r;
        dwl_comp_r    <= dwl_comp;
        dwl_comp_2r   <= dwl_comp_r;
        compare_en_r  <= user_qr_valid;
        compare_en_2r <= compare_en_r;
     end

   genvar comp_i;
   generate
      for(comp_i=0; comp_i<DATA_WIDTH; comp_i=comp_i+1)
        begin:COMPARE_DATA
           qdrii_test_cmp_data U_QDRII_TEST_CMP_DATA
             (
              .clk       ( clk ),
              .reset     ( reset ),
              .cmp_en    ( compare_en_2r ),
              .user_qrh  ( user_qrh_2r[comp_i] ),
              .user_qrl  ( user_qrl_2r[comp_i] ),
              .dwh_comp  ( dwh_comp_2r[comp_i] ),
              .dwl_comp  ( dwl_comp_2r[comp_i] ),
              .cmp_lsb   ( comp_lsb[comp_i] ),
              .cmp_msb   ( comp_msb[comp_i] )
              );
        end
   endgenerate

   always@(posedge clk or posedge reset)
     begin
        if(reset)
          begin
             compare_lsb <= 1'b0;
             compare_msb <= 1'b0;
             cmp_err     <= 1'b0;
          end
        else if(compare_en)
          begin
             compare_lsb <= |comp_lsb;
             compare_msb <= |comp_msb;
             cmp_err     <= (compare_lsb | compare_msb);
          end
     end

   always @(posedge clk)
     begin
        if(reset)
          compare_error_i <= 1'b0;
        else if ((cmp_err == 1'b0) && (compare_error_i == 1'b0))
          compare_error_i <= 1'b0;
        else
          compare_error_i <= 1'b1;
     end

   // synthesis translate_off
   always @(negedge clk)
   begin
      if (compare_error_i)
          $display ("%m DATA ERROR at time %t" , $time);
   end
   // synthesis translate_on

   always @(posedge clk) begin
     compare_error_2i <= compare_error_i;
     compare_error    <= compare_error_2i;
   end

endmodule
