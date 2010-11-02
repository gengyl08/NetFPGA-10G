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
//  /   /         Filename           : qdrii_test_wr_rd_sm.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2009/05/11 21:13:38 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. generates writes and read commands emulating the user backend.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_test_wr_rd_sm #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module sram_controller module. Please refer to the
   // sram_controller module for actual values.
   parameter BURST_LENGTH = 4
   )
  (
   input      clk,
   input      reset,
   input      cal_done,
   input      user_wr_full,
   input      user_rd_full,
   output reg test_w_n,
   output reg user_ad_w_n,
   output reg user_d_w_n,
   output reg user_r_n,
   output reg wr_begin
   );


   localparam [4:0] //5 states - one-hot encoded
                    INIT         =  5'b0_0001,
                    IDLE         =  5'b0_0010,
                    TEST_WR      =  5'b0_0100,
                    TEST_RD      =  5'b0_1000,
                    TEST_WR_RD   =  5'b1_0000;

   reg [4:0]        Current_State;
   reg [4:0]        Next_State;
   reg              test_r_n;

   always @(posedge clk)
     begin
        if (reset)
          Current_State <= INIT;
        else
          Current_State <= Next_State;
     end

   always @(Current_State or user_wr_full or user_rd_full or cal_done)
     begin
        test_w_n = 1;
        test_r_n = 1;
        wr_begin = 0;

        case (Current_State)
          INIT: begin
             if (cal_done)
               Next_State = IDLE;
             else
               Next_State = INIT;
          end

          IDLE: begin
          wr_begin = 1;
             if (user_wr_full & user_rd_full)
               Next_State = IDLE;
             else if ((!user_wr_full) & (BURST_LENGTH == 4))
               Next_State = TEST_WR;
             else if (user_wr_full & (!user_rd_full) & (BURST_LENGTH == 4))
               Next_State = TEST_RD;
             else
               Next_State = TEST_WR_RD;
          end

          TEST_WR: begin
             wr_begin  = 1;
             test_w_n  = 0;  // Initiate a write cycle
             if (user_rd_full)
               Next_State = IDLE;
             else
               Next_State = TEST_RD;
          end

          TEST_RD: begin
             test_r_n = 0;  // Initiate a read cycle
             wr_begin = 1;
             if (user_wr_full)
               Next_State = IDLE;
             else
               Next_State = TEST_WR;
          end

          // BL2 design Write-Read state. For BL2 Write and Read command can be
          // issued in the same clock.
          TEST_WR_RD : begin
            wr_begin = 1;
            if(!user_wr_full)
              test_w_n = 0;
            if(!user_rd_full)
              test_r_n = 0;
            if(user_wr_full & user_rd_full)
              Next_State = IDLE;
            else
              Next_State = TEST_WR_RD;
          end

          default: Next_State = INIT;
        endcase
     end

//   always @(posedge clk)
//     begin
//        if (reset) begin
//           user_d_w_n <= 1'b1;
//           user_ad_w_n <= 1'b1;
//           user_r_n <= 1'b1;
//        end
//        else begin
//           user_d_w_n <= test_w_n ;
//           user_ad_w_n <= test_w_n ;
//           user_r_n<= test_r_n;
//        end
//     end

   always @(posedge clk)
     begin
        user_d_w_n  <= test_w_n ;
        user_ad_w_n <= test_w_n ;
        user_r_n    <= test_r_n;
     end

endmodule