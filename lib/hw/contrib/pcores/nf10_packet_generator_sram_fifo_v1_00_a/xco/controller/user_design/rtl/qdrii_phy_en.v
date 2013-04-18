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
//  /   /         Filename           : qdrii_phy_en.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module is used to align all the read data signals from the different
//    banks so that they are all aligned to each other and the valid signal when
//    presented to the backend.
//
//Revision History:
//
//*****************************************************************************


`timescale 1ns/1ps

module qdrii_phy_en #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter CQ_WIDTH     = 2,
   parameter DATA_WIDTH   = 72,
   parameter Q_PER_CQ     = 18,
   parameter STROBE_WIDTH = 4
   )
  (
   input                         clk0,
   input                         user_rst_0,
   input                         we_cal_done,
   input  [DATA_WIDTH-1:0]       rd_data_rise,
   input  [DATA_WIDTH-1:0]       rd_data_fall,
   input  [STROBE_WIDTH-1:0]     we_in,
   input  [(STROBE_WIDTH*4)-1:0] srl_count,
   output [DATA_WIDTH-1:0]       rd_data_rise_out,
   output [DATA_WIDTH-1:0]       rd_data_fall_out,
   output                        data_valid_out
   );

   localparam [3:0] EN_CAL_IDLE    = 4'h0,
                    EN_CAL_CHECK   = 4'h1,
                    EN_FLAG_SEL    = 4'h2,
                    EN_CAL_MUX_SEL = 4'h4,
                    EN_CAL_DONE    = 4'h8;

   integer i;

   reg [DATA_WIDTH-1:0]       rd_data_rise_r;
   reg [DATA_WIDTH-1:0]       rd_data_fall_r;
   reg                        data_valid_r;
   reg [3:0]                  en_cal_state;
   reg [STROBE_WIDTH-1:0]     rden_inc;
   reg [STROBE_WIDTH-1:0]     rden_dec;
   reg [3:0]                  check_count;
   reg [STROBE_WIDTH-1:0]     mux_sel;
   reg                        mux_sel_done;
   reg                        we_cal_done_r;
   reg                        we_cal_done_2r;
   reg                        we_cal_done_3r;
   reg                        mux_sel_align;
   reg [3:0]                  inc_srl_val;
   reg [3:0]                  dec_srl_val;
   reg                        inc_flag;
   reg                        dec_flag;
   reg [(STROBE_WIDTH*4)-1:0] srl_count_r;
   reg [(STROBE_WIDTH*4)-1:0] srl_count_2r;

   always @ (posedge clk0)
     begin
        if (user_rst_0) begin
           rd_data_rise_r <= 'b0;
           rd_data_fall_r <= 'b0;
           data_valid_r   <= 1'b0;
           we_cal_done_r  <= 1'b0;
           we_cal_done_2r <= 1'b0;
           we_cal_done_3r <= 1'b0;
           srl_count_r    <= 'b0;
           srl_count_2r   <= 'b0;
        end else begin
           rd_data_rise_r <= rd_data_rise;
           rd_data_fall_r <= rd_data_fall;
           data_valid_r   <= we_in[0];
           we_cal_done_r  <= we_cal_done;
           we_cal_done_2r <= we_cal_done_r;
           we_cal_done_3r <= we_cal_done_2r;
           srl_count_r    <= srl_count;
           srl_count_2r   <= srl_count_r;
        end
    end

   /////////////////////////////////////////////////////////////////////////////
   // This state machine is used to check for conditions to determine whether
   // the registered or the un-registered read data needs to be sent out.
   //
   // The following steps are followed:
   // 1. The srl_count value of the first read bank is stored in check_count.
   // 2. This check count is compared against all the srl_counts from other banks.
   //    If they are the same, the registered data is used inorder to provide
   //    the user with a predictable latency. If the check count is less than a
   //    compared value, the registered data for that bank needs to be used.
   //    Similarly, if the check count is greater than srl_count of bank 0, the
   //    registered data for bank 0 needs to be used.
   /////////////////////////////////////////////////////////////////////////////
   always @ (posedge clk0)
     begin
        if (user_rst_0) begin
           rden_inc     <= 'b0;
           rden_dec     <= 'b0;
           check_count  <= 'b0;
           mux_sel      <= 'b0;
           mux_sel_done <= 'b0;
           en_cal_state <= EN_CAL_IDLE;
           inc_srl_val  <= 'b0;
           dec_srl_val  <= 'b0;
           inc_flag     <= 1'b0;
           dec_flag     <= 1'b0;
        end else begin
           case(en_cal_state)
             EN_CAL_IDLE : begin
                if (we_cal_done_3r) begin
                   check_count  <= srl_count_2r[3:0];
                   en_cal_state <= EN_CAL_CHECK;
                end
             end

             EN_CAL_CHECK : // inc_flag indicates an srl count is higher than srl0
                            // dec_flag indicates an srl count is lower than srl0
               begin
                  for (i = 1; i < STROBE_WIDTH; i = i + 1) begin: loop_en_cal
                     if (check_count != srl_count_2r[i*4 +: 4]) begin
                        if (check_count < srl_count_2r[i*4 +: 4]) begin
                           inc_flag    <= 1'b1;
                           inc_srl_val <= srl_count_2r[i*4 +: 4];
                        end else begin
                           dec_flag    <= 1'b1;
                           dec_srl_val <= srl_count_2r[i*4 +: 4];
                        end
                     end
                  end
                  en_cal_state <= EN_FLAG_SEL;
               end

             EN_FLAG_SEL : begin
                // rden_inc is set for srl counts which need to be incremented
                // to match srl0

                if (inc_flag) begin
                   for (i = 0; i < STROBE_WIDTH; i = i + 1) begin: loop_inc_cal
                      if (srl_count_2r[i*4 +: 4] != inc_srl_val) begin
                         rden_inc[i] <= 1'b1;
                      end
                   end

                   // rden_dec is set for srl counts which need to be incremented
                   // to match the srl count which is higher than srl0

                end else if (dec_flag) begin
                   for (i = 0; i < STROBE_WIDTH; i = i + 1) begin: loop_dec_cal
                      if (srl_count_2r[i*4 +: 4] == dec_srl_val) begin
                         rden_dec[i] <= 1'b1;
                      end
                   end
                end
                en_cal_state <= EN_CAL_MUX_SEL;
             end

             EN_CAL_MUX_SEL : begin
                if (inc_flag == 1'b0 && dec_flag == 1'b0) begin
                   mux_sel <= 'b0;
                end else if (inc_flag) begin
                   for (i = 0 ; i < STROBE_WIDTH; i = i+1) begin : loop_en_cal_inc
                      if (rden_inc[i])
                        mux_sel[i] <= 1'b1;
                   end
                end else if (dec_flag) begin
                   for (i = 0 ; i < STROBE_WIDTH; i = i+1) begin : loop_en_cal_dec
                      if (rden_dec[i])
                        mux_sel[i] <= 1'b1;
                   end
                end
                en_cal_state <= EN_CAL_DONE;
             end

             EN_CAL_DONE : begin
                mux_sel_done <= 1'b1;
                en_cal_state <= EN_CAL_DONE;
             end

           endcase
        end
     end

   // Check to see if all the srl counts match. If this is true, the registered
   // version of the read data is provided to the user backend.

   always @ (posedge clk0)
     begin
        if (user_rst_0)
          mux_sel_align = 1'b0;
        else if (mux_sel_done && ~(|mux_sel))
          mux_sel_align = 1'b1;
     end

   assign data_valid_out = (|rden_dec)? we_in[0] : data_valid_r;

   genvar rd_i;
   generate
      for(rd_i=0; rd_i<STROBE_WIDTH; rd_i=rd_i+1) begin : valid_cal
         assign rd_data_rise_out[(rd_i*Q_PER_CQ)+:Q_PER_CQ]
                = (mux_sel[rd_i] | mux_sel_align) ?
                   rd_data_rise_r[(rd_i*Q_PER_CQ)+:Q_PER_CQ] :
                   rd_data_rise[(rd_i*Q_PER_CQ)+:Q_PER_CQ];
         assign rd_data_fall_out[(rd_i*Q_PER_CQ)+:Q_PER_CQ]
                = (mux_sel[rd_i] | mux_sel_align) ?
                   rd_data_fall_r[(rd_i*Q_PER_CQ)+:Q_PER_CQ] :
                   rd_data_fall[(rd_i*Q_PER_CQ)+:Q_PER_CQ];
      end
   endgenerate

endmodule