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
//  /   /         Filename           : qdrii_top_ctrl_sm.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Monitors Read / Write queue status from User Interface FIFOs and
//      generates strobe signals to launch Read / Write requests to
//      QDR II device.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_top_ctrl_sm #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter BURST_LENGTH = 4
   )
  (
   input      clk0,
   input      user_rst_0,
   input      wr_empty,
   input      rd_empty,
   input      cal_done,
   output reg wr_init_n,
   output reg rd_init_n
   );

   reg [2:0] Current_State;
   reg [2:0] Next_State;

   localparam [2:0]
                   INIT       = 3'b000,
                   READ       = 3'b001,
                   WRITE      = 3'b010,
                   WRITE_READ = 3'b011,
                   IDLE       = 3'b100;

   always @(posedge clk0)
     begin
        if (user_rst_0)
          Current_State <= INIT;
        else
          Current_State <= Next_State;
     end


     always @ (Current_State or wr_empty or rd_empty or cal_done)
     begin
        wr_init_n = 1;
        rd_init_n = 1;
          case (Current_State)

          INIT: begin
             wr_init_n = 1;
             rd_init_n = 1;
             if (cal_done)
               Next_State = IDLE;
             else
               Next_State = INIT;
          end

          IDLE:   begin
             wr_init_n = 1;
             rd_init_n = 1;
             if ((!wr_empty) & (BURST_LENGTH == 4))
               Next_State = WRITE;
             else if ((!rd_empty) & (BURST_LENGTH == 4))
               Next_State = READ;
             else if (((!wr_empty) | (!rd_empty)) & (BURST_LENGTH == 2))
               Next_State = WRITE_READ;
             else
               Next_State = IDLE;
          end

          WRITE:   begin
             wr_init_n = 0;  // Initiate a write cycle
             rd_init_n = 1;
             if (!rd_empty)
               Next_State = READ;
             else
               Next_State = IDLE;
          end

          READ:   begin
             rd_init_n  = 0;  // Initiate a read cycle
             wr_init_n  = 1;
             if (!wr_empty)
               Next_State = WRITE;
             else
               Next_State = IDLE;
          end

          // BL2 design Write-Read state. For BL2 Write and Read command can be
          // issued in the same clock(K-Clock).
          WRITE_READ : begin
            if(!wr_empty)
              wr_init_n = 0;
            if(!rd_empty)
              rd_init_n = 0;
            if(wr_empty & rd_empty)
              Next_State = IDLE;
            else
              Next_State = WRITE_READ;
          end

          default:   begin
             wr_init_n  = 1;
             rd_init_n  = 1;
             Next_State = IDLE;
          end
        endcase
     end

endmodule