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
//  /   /         Filename           : qdrii_infrastructure.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2009/05/11 21:13:37 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Distributes various phases of the system clock
//       2. Generation and distribution of reset from the input clock.
//
//Revision History:
//   Rev 1.1 - Parameter CLK_TYPE added and logic for  DIFFERENTIAL and
//             SINGLE_ENDED added. SR. 6/20/08
//   Rev 1.2 - Loacalparam CLK_GENERATOR added and logic for clocks generation
//             using PLL or DCM added as generic code. PK. 10/14/08
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_infrastructure #
  (
   parameter RST_ACT_LOW = 1
   )
  (
   input  sys_rst_n,
   input  idelay_ctrl_rdy,
   input  locked,
   input  clk0,
//   input  clk180,
   input  clk270,
   input  clk200,
   output clk180,
   output user_rst_0,
   output user_rst_180,
   output user_rst_270,
   output user_rst_200
   );

   // # of clock cycles to delay deassertion of reset. Needs to be a fairly
   // high number not so much for metastability protection, but to give time
   // for reset (i.e. stable clock cycles) to propagate through all state
   // machines and to all control signals (i.e. not all control signals have
   // resets, instead they rely on base state logic being reset, and the effect
   // of that reset propagating through the logic). Need this because we may not
   // be getting stable clock cycles while reset asserted (i.e. since reset
   // depends on PLL/DCM lock status)
   localparam RST_SYNC_NUM = 25;

   reg [RST_SYNC_NUM-1:0] rst0_sync_r/*synthesis syn_maxfan = 10*/;
   reg [RST_SYNC_NUM-1:0] rst180_sync_r/*synthesis syn_maxfan = 10*/;
   reg [RST_SYNC_NUM-1:0] rst270_sync_r/*synthesis syn_maxfan = 10*/;
   reg [RST_SYNC_NUM-1:0] rst200_sync_r/*synthesis syn_maxfan = 10*/;

   wire user_reset_in;
   wire rst_tmp;

   assign clk180 = ~clk0;

   assign user_reset_in = RST_ACT_LOW ? ~sys_rst_n : sys_rst_n;

   //***************************************************************************
   // Reset synchronization
   // NOTES:
   //   1. shut down the whole operation if the PLL/ DCM hasn't yet locked (and
   //      by inference, this means that external SYS_RST_IN has been asserted -
   //      PLL/DCM deasserts LOCKED as soon as SYS_RST_IN asserted)
   //   2. In the case of all resets except rst200, also assert reset if the
   //      IDELAY master controller is not yet ready
   //   3. asynchronously assert reset. This was we can assert reset even if
   //      there is no clock (needed for things like 3-stating output buffers).
   //      reset deassertion is synchronous.
   //***************************************************************************
   assign rst_tmp = ~locked | ~idelay_ctrl_rdy | user_reset_in;

   // synthesis attribute max_fanout of rst0_sync_r is 10
   // synthesis attribute buffer_type of rst0_sync_r is "none"
   always @(posedge clk0 or posedge rst_tmp)
     if (rst_tmp)
       rst0_sync_r <= {RST_SYNC_NUM{1'b1}};
     else
       // logical left shift by one (pads with 0)
       rst0_sync_r <= rst0_sync_r << 1;

   // synthesis attribute max_fanout of rst180_sync_r is 10
   always @(posedge clk180 or posedge rst_tmp)
     if (rst_tmp)
       rst180_sync_r <= {RST_SYNC_NUM{1'b1}};
     else
       rst180_sync_r <= rst180_sync_r << 1;

   // synthesis attribute max_fanout of rst270_sync_r is 10
   always @(posedge clk270 or posedge rst_tmp)
     if (rst_tmp)
       rst270_sync_r <= {RST_SYNC_NUM{1'b1}};
     else
       rst270_sync_r <= rst270_sync_r << 1;

   // make sure CLK200 doesn't depend on IDELAY_CTRL_RDY, else chicken n' egg
   // synthesis attribute max_fanout of rst200_sync_r is 10
   always @(posedge clk200 or negedge locked)
     if (!locked)
       rst200_sync_r <= {RST_SYNC_NUM{1'b1}};
     else
       rst200_sync_r <= rst200_sync_r << 1;

   assign user_rst_0 = rst0_sync_r[RST_SYNC_NUM-1];
   assign user_rst_180 = rst180_sync_r[RST_SYNC_NUM-1];
   assign user_rst_270 = rst270_sync_r[RST_SYNC_NUM-1];
   assign user_rst_200 = rst200_sync_r[RST_SYNC_NUM-1];

endmodule
