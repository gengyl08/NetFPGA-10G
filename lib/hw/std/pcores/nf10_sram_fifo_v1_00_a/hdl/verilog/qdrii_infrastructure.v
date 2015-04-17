/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        aximemorycontroller.v
 *
 *  Library:
 *        hw/std/pcores/nf10_sram_fifo
 *
 *  Module:
 *        nf10_sram_fifo
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        AXI4-Stream SRAM FIFO Top Module
 *
 *  Copyright notice:
 *        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
 *                                Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This package is free software: you can redistribute it and/or modify
 *        it under the terms of the GNU Lesser General Public License as
 *        published by the Free Software Foundation, either version 3 of the
 *        License, or (at your option) any later version.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */
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
