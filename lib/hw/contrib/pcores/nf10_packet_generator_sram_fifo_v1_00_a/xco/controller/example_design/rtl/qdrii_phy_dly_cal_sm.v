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
//  /   /         Filename           : qdrii_phy_dly_cal_sm.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Calibrates the IDELAY tap values for the QDR_Q and QDR_CQ inputs
//          to allow direct capture of the read data into the system clock
//          domain.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_phy_dly_cal_sm #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter BURST_LENGTH = 4,
   parameter CLK_PERIOD   = 3333,
   parameter CQ_WIDTH     = 2,
   parameter DATA_WIDTH   = 72,
   parameter DEBUG_EN     = 0,
   parameter Q_PER_CQ     = 18,
   parameter Q_PER_CQ_9   = 2
   )
  (
   input                clk0,
   input                user_rst_0,
   input                start_cal,
   input [Q_PER_CQ-1:0] rd_data_rise,
   input [Q_PER_CQ-1:0] rd_data_fall,
   input                q_delay_done,
   input                rd_en,
   input                we_cal_start,
   output reg           q_dly_rst,
   output reg           q_dly_ce,
   output reg           q_dly_inc,
   output reg           cq_dly_rst,
   output reg           cq_dly_ce,
   output reg           cq_dly_inc,
   output               dly_cal_done,
   output reg           q_init_delay_done,
   output               rdfifo_we,
   output reg           we_cal_done,
   output [3:0]         srl_count,

   // Debug Signals
   input                dbg_idel_up_q_cq,
   input                dbg_idel_down_q_cq,
   input                dbg_idel_up_cq,
   input                dbg_idel_down_cq,
   input                dbg_sel_idel_q_cq,
   input                dbg_sel_idel_cq,
   output [5:0]         dbg_q_init_delay_done_tap_count,
   output [5:0]         dbg_cq_cal_tap_count
   );

//   localparam CLK_PERIOD = 1000000/CLK_FREQ;

   localparam PATTERN_A = 9'h1FF,
              PATTERN_B = 9'h000,
              PATTERN_C = 9'h155,
              PATTERN_D = 9'h0AA;

   localparam [5:0] Q_ERROR_CHECK = 6'b000001,
                    Q_ERROR_1     = 6'b000010,
                    Q_ERROR_2     = 6'b000100,
                    Q_ERROR_1_2   = 6'b001000,
                    Q_ERROR_2_2   = 6'b010000,
                    Q_ERROR_ST    = 6'b100000;

   localparam [8:0] IDLE         = 9'b000000001,
                    CQ_TAP_INC   = 9'b000000010,
                    CQ_TAP_RST   = 9'b000000100,
                    Q_TAP_INC    = 9'b000001000,
                    Q_TAP_RST    = 9'b000010000,
                    CQ_Q_TAP_INC = 9'b000100000,
                    CQ_Q_TAP_DEC = 9'b001000000,
                    TAP_WAIT     = 9'b010000000,
                    DEBUG_ST     = 9'b100000000;

   localparam [2:0] COMP_1      = 3'b001,
                    COMP_2      = 3'b010,
                    CAL_DONE_ST = 3'b100;


   reg [Q_PER_CQ-1:0] rd_data_rise_r;
   reg [Q_PER_CQ-1:0] rd_data_fall_r;
   reg [8:0]          next_state;
   reg                cal_begin;
   reg                first_edge_detect;
   reg                first_edge_detect_r;
   reg                second_edge_detect;
   reg                second_edge_detect_r;
   reg                cq_q_detect_done;
   reg                cq_q_detect_done_r;
   reg                cq_q_detect_done_2r;
   reg                dvw_detect_done;
   reg                dvw_detect_done_r;
   reg                insuff_window_detect;
   reg                insuff_window_detect_r;
   reg [2:0]          tap_wait_cnt;
   reg                cq_cal_done;
   reg                end_of_taps;
   reg                tap_wait_en;
   reg                start_cal_r;
   reg                start_cal_2r;
   reg                start_cal_3r;
   reg                start_cal_4r;
   reg                start_cal_5r;
   reg                start_cal_6r;
   reg                q_error;
   reg                q_initdelay_inc_done;
   reg                q_initdelay_inc_done_r;
   reg                cal1_error;
   reg [5:0]          cq_tap_cnt;
   reg [5:0]          q_tap_cnt;
   reg [5:0]          cq_tap_range;
   reg                q_delay_done_r;
   reg                q_delay_done_2r;
   reg                q_delay_done_3r;
   reg                q_delay_done_4r;
   reg                q_delay_done_5r;
   reg                q_delay_done_6r;
   reg                q_delay_done_7r;
   reg                q_delay_done_8r;
   reg                q_delay_done_9r;
   reg                q_delay_done_10r;
   reg                q_delay_done_11r;
   reg                q_delay_done_12r;
   reg                q_delay_done_13r;
   reg                q_delay_done_14r;
   reg                q_delay_done_15r;
   reg                q_delay_done_16r;
   reg                q_delay_done_17r;
   reg                q_delay_done_18r;
   reg                q_delay_done_19r;
   reg                q_delay_done_20r;
   reg                q_delay_done_21r;
   reg                q_delay_done_22r;
   reg                q_delay_done_23r;
   reg                q_delay_done_24r;
   reg                q_delay_done_25r;
   reg                q_delay_done_26r;
   reg                q_delay_done_27r;
   reg                q_delay_done_28r;
   reg                q_delay_done_29r;
   reg                q_delay_done_30r;
   reg                q_delay_done_31r;
   reg                q_delay_done_32r;
   reg [5:0]          cq_tap_range_center;
   reg [5:0]          insuff_window_taps;
   reg                cal1_chk;
   reg [5:0]          cq_final_tap_cnt;
   reg [5:0]          cq_hold_range;
   reg [5:0]          cq_setup_range;
   reg                cq_initdelay_inc_done;
   reg                cq_initdelay_inc_done_r;
   reg                cq_rst_done;
   reg                q_rst_done;
   reg [5:0]          tap_inc_range;
   reg [5:0]          q_tap_range;
   reg                q_init_delay_done_r;
   reg                cal2_chk_1;
   reg                cal2_chk_2;
   reg                q_initdelay_inc_done_2r;
   reg                cq_initdelay_inc_done_2r;
   reg                q_init_delay_done_2r;
   reg [3:0]          rden_cnt_clk0;
   reg [1:0]          rd_stb_cnt;
   reg                rd_cmd;
   reg [2:0]          comp_cs;
   reg [5:0]          q_error_state;
   reg [2:0]          we_cal_cnt;
   reg                write_cal_start;
   reg                we_cal_done_r;
   reg                rd_en_i;

   wire [5:0] tap_inc_val;
   wire       cq_initdelay_done_p;
   wire       q_inc_delay_done_p;
   wire       rden_srl_clk0;
   wire [5:0] max_window;
   wire [5:0] cq_tap_range_center_w;
   wire       cnt_rst;
   wire       insuff_window_detect_p;
   reg       q_initdelay_done_p;
   wire       cq_inc_flag;
   wire       q_inc_flag;
   reg        user_rst_r;
   reg        user_rst_r1;
   //wire [5:0] low_freq_min_window;

   localparam integer half_period_taps = (CLK_PERIOD/150);

   // Low frequency window for second stage: For clk_period > 4000ps
   // if CQ/Q and CLK0 are less than 20 taps apart, insuff_window_detect is asserted.
   // Then, for frequencies with half period more than 30 taps, CQ and Q are both delayed by a fixed 30 taps.
   // Else they are both delayed by half period worth of taps so that they are both aligned to the next fpga clock edge
   // if CQ/Q and CLK0 are more than 40 taps apart, they are then delayed such that CQ/Q are atleast (cq_tap_range/2) taps away from clk0

   localparam low_freq_min_window = (half_period_taps > 30)? 6'h1E : half_period_taps;

   assign dbg_q_init_delay_done_tap_count = q_tap_cnt;
   assign dbg_cq_cal_tap_count            = cq_tap_cnt;

   // used for second stage tap centering
   assign max_window = (CLK_PERIOD > 4000)? 6'h14 : 6'h0f;

   assign srl_count[3:0] =  rden_cnt_clk0[3:0];

   always @ (posedge clk0)
     begin
        user_rst_r1 <= user_rst_0;
        user_rst_r  <= user_rst_r1;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
           rd_data_rise_r <= 'b0;
           rd_data_fall_r <= 'b0;
        end else begin
           rd_data_rise_r <= rd_data_rise;
           rd_data_fall_r <= rd_data_fall;
        end
     end

   always @ (posedge clk0)
     begin
        if (rd_data_rise_r == {Q_PER_CQ_9{PATTERN_A}} &&
                     rd_data_fall_r == {Q_PER_CQ_9{PATTERN_B}})begin
           cal1_chk <= 1'b1;
        end else begin
           cal1_chk <= 1'b0;
        end
     end

   always @ (posedge clk0)
     begin
        if (q_initdelay_inc_done) begin
           cal1_error <= 1'b0;
        end else if (tap_wait_cnt == 3'b101) begin
           if (cal1_chk)
             cal1_error <= 1'b0;
           else
             cal1_error <= 1'b1;
        end
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
           cal2_chk_1 <= 1'b0;
        end else if (rd_data_rise_r == {Q_PER_CQ_9{PATTERN_A}} &&
                     rd_data_fall_r == {Q_PER_CQ_9{PATTERN_B}})begin
           cal2_chk_1 <= 1'b1;
        end else begin
           cal2_chk_1 <= 1'b0;
        end
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
           cal2_chk_2 <= 1'b0;
        end else if (rd_data_rise_r == {Q_PER_CQ_9{PATTERN_C}} &&
                     rd_data_fall_r == {Q_PER_CQ_9{PATTERN_D}})begin
           cal2_chk_2 <= 1'b1;
        end else begin
           cal2_chk_2 <= 1'b0;
        end
     end

   always @ (posedge clk0)
    begin
       if (user_rst_r) begin
          q_error <= 1'b0;
          q_error_state  <= Q_ERROR_CHECK;
       end else begin
          case (q_error_state)
            Q_ERROR_CHECK : begin
               //q_error <= 1'b0;
               if (q_delay_done_32r && tap_wait_cnt == 3'b101) begin
                  if (cal2_chk_1) begin
                     q_error       <= 1'b0;
                     q_error_state <= Q_ERROR_1;
                  end else if (cal2_chk_2) begin
                     q_error       <= 1'b0;
                     q_error_state <= Q_ERROR_2;
                  end else begin
                     q_error       <= 1'b1;
                     q_error_state <= Q_ERROR_ST;
                  end
               end else begin
                  q_error       <= q_error;
                  q_error_state <= Q_ERROR_CHECK;
               end
            end
            Q_ERROR_1 :   begin
               if (cal2_chk_2) begin
                  q_error       <= 1'b0;
                  q_error_state <= Q_ERROR_1_2;
               end else begin
                  q_error       <= 1'b1;
                  q_error_state <= Q_ERROR_ST;
               end
            end

            Q_ERROR_1_2 :   begin
               if (cal2_chk_1) begin
                  q_error       <= 1'b0;
                  q_error_state <= Q_ERROR_1;
               end else begin
                  q_error       <= 1'b1;
                  q_error_state <= Q_ERROR_ST;
               end
            end


            Q_ERROR_2 : begin
               if (cal2_chk_1) begin
                  q_error       <= 1'b0;
                  q_error_state <= Q_ERROR_2_2;
               end else begin
                  q_error       <= 1'b1;
                  q_error_state <= Q_ERROR_ST;
               end
            end

            Q_ERROR_2_2 :   begin
               if (cal2_chk_2) begin
                  q_error       <= 1'b0;
                  q_error_state <= Q_ERROR_2;
               end else begin
                  q_error       <= 1'b1;
                  q_error_state <= Q_ERROR_ST;
               end
            end

            Q_ERROR_ST  : begin
               q_error       <= 1'b1;
               q_error_state <= Q_ERROR_CHECK;
            end
          endcase
       end
    end

   assign dly_cal_done = cq_cal_done;

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
           start_cal_r  <= 1'b0;
           start_cal_2r <= 1'b0;
           start_cal_3r <= 1'b0;
           start_cal_4r <= 1'b0;
           start_cal_5r <= 1'b0;
           start_cal_6r <= 1'b0;
        end else begin
           start_cal_r  <= start_cal;
           start_cal_2r <= start_cal_r;
           start_cal_3r <= start_cal_2r;
           start_cal_4r <= start_cal_3r;
           start_cal_5r <= start_cal_4r;
           start_cal_6r <= start_cal_5r;
        end
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
           q_delay_done_r  <= 1'b0;
           q_delay_done_2r <= 1'b0;
           q_delay_done_3r <= 1'b0;
           q_delay_done_4r <= 1'b0;
           q_delay_done_5r <= 1'b0;
           q_delay_done_6r <= 1'b0;
           q_delay_done_7r <= 1'b0;
           q_delay_done_8r <= 1'b0;
           q_delay_done_9r <= 1'b0;
           q_delay_done_10r <= 1'b0;
           q_delay_done_11r <= 1'b0;
           q_delay_done_12r <= 1'b0;
           q_delay_done_13r <= 1'b0;
           q_delay_done_14r <= 1'b0;
           q_delay_done_15r <= 1'b0;
           q_delay_done_16r <= 1'b0;
           q_delay_done_17r <= 1'b0;
           q_delay_done_18r <= 1'b0;
           q_delay_done_19r <= 1'b0;
           q_delay_done_20r <= 1'b0;
           q_delay_done_21r <= 1'b0;
           q_delay_done_22r <= 1'b0;
           q_delay_done_23r <= 1'b0;
           q_delay_done_24r <= 1'b0;
           q_delay_done_25r <= 1'b0;
           q_delay_done_26r <= 1'b0;
           q_delay_done_27r <= 1'b0;
           q_delay_done_28r <= 1'b0;
           q_delay_done_29r <= 1'b0;
           q_delay_done_30r <= 1'b0;
           q_delay_done_31r <= 1'b0;
           q_delay_done_32r <= 1'b0;

        end else begin
           q_delay_done_r   <= q_delay_done;
           q_delay_done_2r  <= q_delay_done_r;
           q_delay_done_3r  <= q_delay_done_2r;
           q_delay_done_4r  <= q_delay_done_3r;
           q_delay_done_5r  <= q_delay_done_4r;
           q_delay_done_6r  <= q_delay_done_5r;
           q_delay_done_7r  <= q_delay_done_6r;
           q_delay_done_8r  <= q_delay_done_7r;
           q_delay_done_9r  <= q_delay_done_8r;
           q_delay_done_10r <= q_delay_done_9r;
           q_delay_done_11r <= q_delay_done_10r;
           q_delay_done_12r <= q_delay_done_11r;
           q_delay_done_13r <= q_delay_done_12r;
           q_delay_done_14r <= q_delay_done_13r;
           q_delay_done_15r <= q_delay_done_14r;
           q_delay_done_16r <= q_delay_done_15r;
           q_delay_done_17r <= q_delay_done_16r;
           q_delay_done_18r <= q_delay_done_17r;
           q_delay_done_19r <= q_delay_done_18r;
           q_delay_done_20r <= q_delay_done_19r;
           q_delay_done_21r <= q_delay_done_20r;
           q_delay_done_22r <= q_delay_done_21r;
           q_delay_done_23r <= q_delay_done_22r;
           q_delay_done_24r <= q_delay_done_23r;
           q_delay_done_25r <= q_delay_done_24r;
           q_delay_done_26r <= q_delay_done_25r;
           q_delay_done_27r <= q_delay_done_26r;
           q_delay_done_28r <= q_delay_done_27r;
           q_delay_done_29r <= q_delay_done_28r;
           q_delay_done_30r <= q_delay_done_29r;
           q_delay_done_31r <= q_delay_done_30r;
           q_delay_done_32r <= q_delay_done_31r;

        end
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          cal_begin <= 1'b0;
        else if (start_cal_5r && ~start_cal_6r)
          cal_begin <= 1'b1;
        else if (q_dly_inc)
          cal_begin <= 1'b0;

     end

   /////////////////////////////////////////////////////////////////////////////
   // 1. CQ-Q calibration
   //
   // This stage is required since cq is delayed by an amount equal to the bufio
   // delay with respect to the data. This might move CQ towards the end of the
   // data window at higher frequencies. This stage of calibration helps to
   // align data within the CQ window. In this stage, a static data pattern of
   // 1s and 0s are written as rise and fall data respectively. This pattern
   // also helps to eliminate any metastability arising due to the phase
   // alignment of the data output from the ISERDES and the FPGA clock.
   // The stages of this calibration are as follows:
   // 1. Increment the cq taps to determine the hold data window.
   // 2. Reset the CQ taps once the end of window is reached or sufficient
   //    window not detected.
   // 3. Increment Q taps to determine the set up window.
   // 4. Reset the q taps.
   // 5. If the hold window detected is greater than the set up window, then no
   //    tap increments needed. If the hold window is less than the setup window,
   //    data taps are incremented so that CQ is in the center of the
   //    data valid window.
   //
   // 2. CQ-Q to FPGA clk calibration
   //
   // This stage helps to determine the relationship between cq/q with respect to
   // the fpga clk.
   // 1. CQ and Q are incremented and the window detected with respect to the
   //    FPGA clk. If there is insufficient window , CQ/Q are both incremented
   //    so that they can be aligned to the next rising edge of the FPGA clk.
   // 2. Once sufficient window is detected, CQ and Q are decremented such that
   //    they are atleast half the clock period away from the FPGA clock in case
   //    of frequencies lower than or equal to 250 MHz and atleast 20 taps away
   //    from the FPGA clock for frequencies higher than 250 MHz.
   /////////////////////////////////////////////////////////////////////////////

   always @ (posedge clk0)
     begin
       if (user_rst_r || ~start_cal) begin
          cq_dly_inc  <= 0;
          cq_dly_ce   <= 0;
          cq_dly_rst  <= 1;
          q_dly_inc   <= 0;
          q_dly_ce    <= 0;
          q_dly_rst   <= 1;
          tap_wait_en <= 1'b0;
          next_state  <= IDLE;
       end else begin
          case (next_state)
            IDLE : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 0;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 0;
               q_dly_ce    <= 0;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b0;

               //if (cal_begin && ~cq_initdelay_inc_done ) begin
               if ((cal_begin && ~cq_initdelay_inc_done )||
                   (q_rst_done && cq_inc_flag && ~q_init_delay_done))begin
                  next_state <= CQ_TAP_INC;

               end else if (cq_initdelay_inc_done_r && ~cq_rst_done) begin
                  next_state <= CQ_TAP_RST;

               end else if ((cq_rst_done && ~q_initdelay_inc_done) ||
                            //(q_rst_done && ~q_init_delay_done)) begin
                             (q_rst_done && q_inc_flag && ~q_init_delay_done)) begin
                  next_state <= Q_TAP_INC;

               end else if (q_initdelay_inc_done_r && ~q_rst_done) begin
                  next_state <= Q_TAP_RST;

               end else if ( q_delay_done_32r && ~cq_q_detect_done ) begin
                  next_state <= CQ_Q_TAP_INC;

               end else if (cq_q_detect_done_2r && ~cq_cal_done)  begin
                  next_state <=  CQ_Q_TAP_DEC;

               end else if(we_cal_done && DEBUG_EN == 1) begin
                  if(dbg_sel_idel_q_cq) begin
                    q_dly_inc <= dbg_idel_up_q_cq;
                    q_dly_ce  <= dbg_idel_up_q_cq | dbg_idel_down_q_cq;
                  end else
                    q_dly_ce  <= 0;

                  if(dbg_sel_idel_cq) begin
                    cq_dly_inc <= dbg_idel_up_cq;
                    cq_dly_ce  <= dbg_idel_up_cq | dbg_idel_down_cq;
                  end else
                    cq_dly_ce  <= 0;

                  next_state <= DEBUG_ST;

               end else begin
                  next_state <= IDLE;

               end
            end

            CQ_TAP_INC : begin
               cq_dly_inc  <= 1;
               cq_dly_ce   <= 1;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 0;
               q_dly_ce    <= 0;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b1;
               next_state  <= TAP_WAIT;
            end

            CQ_TAP_RST : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 0;
               cq_dly_rst  <= 1;
               q_dly_inc   <= 0;
               q_dly_ce    <= 0;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b1;
               next_state  <= TAP_WAIT;
            end

            Q_TAP_INC : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 0;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 1;
               q_dly_ce    <= 1;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b1;
               next_state  <= TAP_WAIT;
            end

            Q_TAP_RST : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 0;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 0;
               q_dly_ce    <= 0;
               q_dly_rst   <= 1;
               tap_wait_en <= 1'b1;
               next_state  <= TAP_WAIT;
            end

            CQ_Q_TAP_INC : begin
               cq_dly_inc  <= 1;
               cq_dly_ce   <= 1;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 1;
               q_dly_ce    <= 1;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b1;
               next_state  <= TAP_WAIT;
            end

            CQ_Q_TAP_DEC : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 1;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 0;
               q_dly_ce    <= 1;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b1;
               next_state  <= TAP_WAIT;
            end

            TAP_WAIT : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 0;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 0;
               q_dly_ce    <= 0;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b0;
               if (tap_wait_cnt == 3'b111)
                 next_state <= IDLE;
               else
                 next_state <= TAP_WAIT;
            end

            DEBUG_ST : begin
               cq_dly_inc  <= 0;
               cq_dly_ce   <= 0;
               cq_dly_rst  <= 0;
               q_dly_inc   <= 0;
               q_dly_ce    <= 0;
               q_dly_rst   <= 0;
               tap_wait_en <= 1'b1;

               if(dbg_sel_idel_q_cq) begin
                 q_dly_inc <= dbg_idel_up_q_cq;
                 q_dly_ce  <= dbg_idel_up_q_cq | dbg_idel_down_q_cq;
               end else
                 q_dly_ce  <= 0;

               if(dbg_sel_idel_cq) begin
                 cq_dly_inc <= dbg_idel_up_cq;
                 cq_dly_ce  <= dbg_idel_up_cq | dbg_idel_down_cq;
               end else
                 cq_dly_ce  <= 0;

               if((!dbg_sel_idel_q_cq) & (!dbg_sel_idel_cq))
                 next_state <= IDLE;
               else
                 next_state <= DEBUG_ST;

            end

            default : next_state <= IDLE;

          endcase
       end
     end

   assign cnt_rst = user_rst_r | insuff_window_detect_p | q_initdelay_done_p |
                    cq_initdelay_done_p | q_inc_delay_done_p;

   always @ (posedge clk0)
     begin
        if (cnt_rst)
          first_edge_detect <= 1'b0;
        else if ((~q_error && ~cal1_error) && (tap_wait_cnt == 3'b111))
          first_edge_detect <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (cnt_rst)
          second_edge_detect <= 1'b0;
        else if (first_edge_detect && (q_error|| cal1_error || end_of_taps))
          second_edge_detect <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (cnt_rst) begin
           first_edge_detect_r  <= 1'b0;
           second_edge_detect_r <= 1'b0;
        end else begin
           first_edge_detect_r  <= first_edge_detect;
           second_edge_detect_r <= second_edge_detect;
        end
     end

   always @ (posedge clk0)
     begin
        if (cnt_rst)
          dvw_detect_done <= 1'b0;
        else if (second_edge_detect_r && ~insuff_window_detect &&
                 ~(q_rst_done && ~q_delay_done_32r))
          dvw_detect_done <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (cnt_rst)
          dvw_detect_done_r <= 1'b0;
        else
          dvw_detect_done_r <= dvw_detect_done;
     end

   always @(posedge clk0)
     begin
        if (user_rst_r || cq_dly_rst)
          cq_tap_cnt <= 6'b000000;
        else if (cq_dly_ce && cq_dly_inc)
          cq_tap_cnt <= cq_tap_cnt + 1;
        else if (cq_dly_ce && ~cq_dly_inc)
          cq_tap_cnt <= cq_tap_cnt - 1;
     end

   always @(posedge clk0)
     begin
        if (user_rst_r || q_dly_rst)
          q_tap_cnt <= 6'b000000;
        else if (q_dly_ce && q_dly_inc)
          q_tap_cnt <= q_tap_cnt + 1;
        else if (q_dly_ce && ~q_dly_inc)
          q_tap_cnt <= q_tap_cnt - 1;
     end

   always @(posedge clk0)
     begin
        if (user_rst_r)
          tap_wait_cnt <= 3'b000;
        else if ((tap_wait_cnt != 3'b000) || (tap_wait_en))
          tap_wait_cnt <= tap_wait_cnt + 1;
     end

   always @(posedge clk0)
     begin
        if (cnt_rst)
          cq_tap_range <= 6'b0;
        else if (cq_dly_inc && first_edge_detect)
          cq_tap_range <= cq_tap_range + 1;
     end

   always @(posedge clk0)
     begin
        if (cnt_rst)
          q_tap_range <= 6'b0;
        else if (q_dly_inc && first_edge_detect)
          q_tap_range <= q_tap_range + 1;
     end

  //////////////////////////////////////////////////////////////////////////////
  // 1st stage calibration registers
  //////////////////////////////////////////////////////////////////////////////

  // either end of window reached or no window detected
    always @ (posedge clk0)
      begin
         if (user_rst_r)
           cq_initdelay_inc_done <= 1'b0;
         else if ((~cq_initdelay_inc_done && dvw_detect_done
                   && ~dvw_detect_done_r)|| (cq_tap_cnt == 6'h05 &&
                                             ~first_edge_detect))
           cq_initdelay_inc_done <= 1'b1;
      end

   always @(posedge clk0)
     begin
        if (user_rst_r)
          q_initdelay_inc_done <= 1'b0;
        else if (cq_initdelay_inc_done && ~q_initdelay_inc_done &&
                 dvw_detect_done && ~dvw_detect_done_r&& q_tap_range >= 6'h05)
          q_initdelay_inc_done <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          cq_rst_done <= 1'b0;
        else if (cq_initdelay_inc_done && cq_dly_rst)
          cq_rst_done <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          q_rst_done <= 1'b0;
        else if (q_initdelay_inc_done && q_dly_rst)
          q_rst_done <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          cq_hold_range <= 6'h00;
        else if (~cq_initdelay_inc_done &&  cq_dly_inc && first_edge_detect )
          cq_hold_range <= cq_hold_range + 1 ;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          cq_setup_range <= 6'h00;
        else if (~q_initdelay_inc_done && q_dly_inc && first_edge_detect  )
          cq_setup_range <= cq_setup_range +1;
     end

   always @(posedge clk0)
     begin
        if (user_rst_r) begin
           q_initdelay_inc_done_r   <= 1'b0;
           cq_initdelay_inc_done_r  <= 1'b0;
           q_init_delay_done_r      <= 1'b0;
           q_initdelay_inc_done_2r  <= 1'b0;
           cq_initdelay_inc_done_2r <= 1'b0;
           q_init_delay_done_2r     <= 1'b0;
        end else begin
           q_initdelay_inc_done_r   <= q_initdelay_inc_done;
           cq_initdelay_inc_done_r  <= cq_initdelay_inc_done;
           q_init_delay_done_r      <= q_init_delay_done;
           q_initdelay_inc_done_2r  <= q_initdelay_inc_done_r;
           cq_initdelay_inc_done_2r <= cq_initdelay_inc_done_r;
           q_init_delay_done_2r     <= q_init_delay_done_r;
        end
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          q_initdelay_done_p <= 1'b0;
        else if (q_initdelay_inc_done_r && ~q_initdelay_inc_done_2r )
          q_initdelay_done_p <= 1'b1;
        else if (q_delay_done_30r)
          q_initdelay_done_p <= 1'b0;

     end

   //assign q_initdelay_done_p  = ( q_initdelay_inc_done_r &&
   //                              ~q_initdelay_inc_done_2r )? 1'b1 : 1'b0;
   assign cq_initdelay_done_p = ( cq_initdelay_inc_done_r &&
                                 ~cq_initdelay_inc_done_2r)? 1'b1 : 1'b0;
   assign q_inc_delay_done_p  = ( q_init_delay_done_r && ~q_init_delay_done_2r )
                                ? 1'b1 : 1'b0;

   assign tap_inc_val = (q_initdelay_inc_done_r &&
                         cq_setup_range > cq_hold_range) ?
                          (cq_setup_range - cq_hold_range)>>1 :
                          (cq_hold_range - cq_setup_range)>>1;

   assign cq_inc_flag = (q_initdelay_inc_done &&
                         (cq_hold_range > cq_setup_range))? 1'b1 : 1'b0;
   assign q_inc_flag =  (q_initdelay_inc_done &&
                         (cq_setup_range >= cq_hold_range))? 1'b1 : 1'b0;

   always @(posedge clk0)
     begin
        if (user_rst_r)
          tap_inc_range <= 6'b0;
        else
          tap_inc_range <= tap_inc_val;
     end

   always @(posedge clk0)
     begin
        if (user_rst_r)
          q_init_delay_done <= 1'b0;
       // else if (q_rst_done && ~q_init_delay_done && q_tap_cnt == q_tap_inc_range) _ LG
        else if (q_rst_done && ~q_init_delay_done &&
                 (( cq_inc_flag && (cq_tap_cnt ==  tap_inc_range)) ||
                  (q_inc_flag &&  (q_tap_cnt == tap_inc_range))))
          q_init_delay_done <= 1'b1;
     end

   /////////////////////////////////////////////////////////////////////////////
   // 2nd stage calibration registers
   /////////////////////////////////////////////////////////////////////////////

   always @(posedge clk0)
     begin
        if (user_rst_r)
          cq_q_detect_done <= 1'b0;
        else if (q_delay_done_32r && dvw_detect_done && ~dvw_detect_done_r)
          cq_q_detect_done <= 1'b1;
     end

   always @(posedge clk0)
     begin
        if (user_rst_r) begin
           cq_q_detect_done_r  <= 1'b0;
           cq_q_detect_done_2r <= 1'b0;
        end else begin
           cq_q_detect_done_r  <= cq_q_detect_done;
           cq_q_detect_done_2r <= cq_q_detect_done_r;
        end
     end

   always @ (posedge clk0)
     begin
        if (cnt_rst)
          insuff_window_detect <= 1'b0;
        else if (q_delay_done_32r && second_edge_detect &&
                 (cq_tap_range < max_window))
          insuff_window_detect <= 1'b1;
        else if (insuff_window_detect && first_edge_detect_r)
          insuff_window_detect <= 1'b0;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
           insuff_window_detect_r  <= 1'b0;
        else
           insuff_window_detect_r  <= insuff_window_detect;
     end

   assign insuff_window_detect_p = (insuff_window_detect &&
                                    ~insuff_window_detect_r )? 1'b1 : 1'b0;

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
          insuff_window_taps <= 6'h0;
        end else if (insuff_window_detect && ~insuff_window_detect_r) begin
           if (cq_inc_flag)
               insuff_window_taps <= q_tap_cnt;
           else
               insuff_window_taps <= cq_tap_cnt;
        end

     end

   assign cq_tap_range_center_w = (cq_tap_range < max_window) ? 6'h00 :
                                  (cq_tap_range < 2* max_window && CLK_PERIOD > 4000 && insuff_window_taps > 0)? low_freq_min_window :
                                  (cq_tap_range < 2* max_window)?
                                   (cq_tap_range - max_window): cq_tap_range >>1;

   always @(posedge clk0)
     begin
        if (user_rst_r) begin
           cq_tap_range_center <= 6'b0;
           cq_final_tap_cnt    <= 6'b0;
        end else begin
           cq_tap_range_center <= cq_tap_range_center_w ;
           cq_final_tap_cnt    <= insuff_window_taps + cq_tap_range_center ;
        end
     end

   always @ (posedge clk0)
     begin
        if (cnt_rst)
          end_of_taps <= 1'b0;
        else if ((cq_tap_cnt == 6'h3A) || (q_tap_cnt == 6'h3A))
          end_of_taps <= 1'b1;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          cq_cal_done <= 1'b0;
        else if(((cq_inc_flag && q_tap_cnt == cq_final_tap_cnt) || (q_inc_flag && cq_tap_cnt == cq_final_tap_cnt)) && (cq_q_detect_done))
          cq_cal_done <= 1'b1;
     end

   // generate read fifo strobe logic

   generate
     if(BURST_LENGTH == 4)begin : BL4_INST
     // For BL4 design, when a single read command is issued, 4 bursts of data is
     // received. The same read command is expanded for two clock cycles and
     // then the comparision of read data with pattern data is done in this
     // particular two clock command window. Until the read data is matched with
     // the pattern data, the two clock command window is shifted using SRL.
       always @ (posedge clk0)
         begin
            if (user_rst_r) begin
               rd_stb_cnt <= 2'b00;
                end else if (!rd_en) begin
               rd_stb_cnt <= 2'b10;
            end else if (rd_stb_cnt != 2'b00) begin
               rd_stb_cnt <= rd_stb_cnt - 1;
            end else begin
               rd_stb_cnt <= rd_stb_cnt;
            end
         end

       always @ (posedge clk0)
         begin
            if (user_rst_r)
              rd_cmd <= 1'b0;
            else if (rd_stb_cnt != 2'b00)
              rd_cmd <= 1'b1;
            else
              rd_cmd <= 1'b0;
         end
     end
     else begin : BL2_INST
     // For BL2 design, when two consecutive read commands are issued, 4 bursts
     // of data is received. The read data is compared with pattern data in this
     // particular two clock command window. Until the read data is matched with
     // the pattern data, the two clock command window is shifted using SRL.
       always @ (posedge clk0)
         begin
            if (user_rst_r)
              rd_cmd <= 1'b0;
            else if (!rd_en)
              rd_cmd <= 1'b1;
            else
              rd_cmd <= 1'b0;
         end

       always @ (posedge clk0)
         rd_en_i <= ~rd_en;

     end
   endgenerate

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          rden_cnt_clk0 <= 4'b000;
        // Increment count for SRL. This count determines the number of clocks
        // two clock command window is delayed until the Read data is matched
        // with pattern data.
        else if ((rd_stb_cnt == 2'b01) & write_cal_start & ~we_cal_done
                 & (BURST_LENGTH == 4))
          rden_cnt_clk0 <= rden_cnt_clk0 + 1;
        else if ((!rd_en) & rd_en_i & write_cal_start & ~we_cal_done
                 & (BURST_LENGTH == 2))
          rden_cnt_clk0 <= rden_cnt_clk0 + 1;
        else if (we_cal_done && ~we_cal_done_r)
          rden_cnt_clk0 <= rden_cnt_clk0 - 1;
        else
          rden_cnt_clk0 <= rden_cnt_clk0;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          we_cal_done_r <= 1'b0;
        else
          we_cal_done_r <= we_cal_done;
     end

   SRL16 SRL_RDEN_CLK0
     (
      .Q   ( rden_srl_clk0 ),
      .A0  ( rden_cnt_clk0[0] ),
      .A1  ( rden_cnt_clk0[1] ),
      .A2  ( rden_cnt_clk0[2] ),
      .A3  ( rden_cnt_clk0[3] ),
      .CLK ( clk0 ),
      .D   ( rd_cmd )
      );

   FDRSE #
     (
      .INIT(1'b0)
      )
     WE_CLK0_INST
       (
        .Q  ( rdfifo_we ),
        .C  ( clk0 ),
        .CE ( 1'b1 ),
        .D  ( rden_srl_clk0 ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   // generate read fifo strobe logic

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          we_cal_cnt <= 3'b000;
        else if ((we_cal_start) || (we_cal_cnt != 3'b000) )
          we_cal_cnt <= we_cal_cnt + 1;
        else
          we_cal_cnt <= we_cal_cnt;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r)
          write_cal_start <= 1'b0;
        else if (we_cal_cnt == 3'b111)
          write_cal_start <= 1'b1;
        else
          write_cal_start <= write_cal_start;
     end

   always @ (posedge clk0)
     begin
        if (user_rst_r) begin
           we_cal_done <= 1'b0;
           comp_cs     <= COMP_1;
        end else begin
           case (comp_cs)

             COMP_1 : begin
                if (rdfifo_we && write_cal_start) begin
                   if (cal2_chk_1) begin
                      we_cal_done <= 1'b0;
                      comp_cs     <= COMP_2;
                   end else begin
                      we_cal_done <= 1'b0;
                      comp_cs     <= COMP_1;
                   end
                end else begin
                   we_cal_done <= 1'b0;
                   comp_cs     <= COMP_1;
                end
             end // case: COMP_1

             COMP_2 : begin
                if (cal2_chk_2) begin
                   we_cal_done <= 1'b1;
                   comp_cs     <= CAL_DONE_ST;
                end else begin
                   we_cal_done <= 1'b0;
                   comp_cs     <= COMP_1;
                end
             end

             CAL_DONE_ST  : begin
                we_cal_done <= 1'b1;
                comp_cs     <= CAL_DONE_ST;
             end

             default:  begin
                we_cal_done <= 1'b0;
                comp_cs     <= COMP_1;
             end
           endcase
        end
     end

endmodule