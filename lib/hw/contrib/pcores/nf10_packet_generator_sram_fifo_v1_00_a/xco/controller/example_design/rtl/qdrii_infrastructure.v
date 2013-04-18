// (c) Copyright 2006-2009 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.6.1
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_infrastructure.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:06 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module generates and distributes
//        1. Various phases of the system clock using PLL/DCM.
//        2. Reset from the input clock.
//
//Revision History:
//   Rev 1.1 - Parameter CLK_TYPE added and logic for  DIFFERENTIAL and
//             SINGLE_ENDED added. SR. 6/20/08
//   Rev 1.2 - Constant CLK_GENERATOR added and logic for clocks generation
//             using PLL or DCM added as generic code. PK. 10/14/08
//   Rev 1.3 - Added parameter NOCLK200 with default value '0'. Used for
//             controlling the instantiation of IBUFG for clk200. jul/03/09
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_infrastructure #
  (
   parameter DLL_FREQ_MODE = "HIGH",
   parameter CLK_TYPE      = "DIFFERENTIAL",
   parameter RST_ACT_LOW   = 1,
   parameter NOCLK200      = 0,
   parameter CLK_PERIOD   = 3333
   )
  (
   input  sys_clk_n,
   input  sys_clk_p,
   input  sys_clk,
   input  dly_clk_200_n,
   input  dly_clk_200_p,
   input  idly_clk_200,
   input  sys_rst_n,
   input  idelay_ctrl_rdy,
   output clk0,
   output clk180,
   output clk270,
   output clk200,
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
//   localparam CLK_PERIOD_NS = (1000.0/(2.0*CLK_FREQ)); // in nSec
//   localparam CLK_PERIOD_INT = (1000/(2.0*CLK_FREQ));
   localparam CLK_PERIOD_NS = CLK_PERIOD/1000.0; // in nSec
   localparam CLK_PERIOD_INT = CLK_PERIOD/1000;


   // By default this Parameter (CLK_GENERATOR) value is "PLL". If this
   // Parameter is set to "PLL", PLL is used to generate the design clocks.
   // If this Parameter is set to "DCM",
   // DCM is used to generate the design clocks.
   localparam CLK_GENERATOR = "PLL";

   reg [RST_SYNC_NUM-1:0] rst0_sync_r/*synthesis syn_maxfan = 10*/;
   reg [RST_SYNC_NUM-1:0] rst180_sync_r/*synthesis syn_maxfan = 10*/;
   reg [RST_SYNC_NUM-1:0] rst270_sync_r/*synthesis syn_maxfan = 10*/;
   reg [RST_SYNC_NUM-1:0] rst200_sync_r/*synthesis syn_maxfan = 10*/;

   wire clkfbout_clkfbin;
   wire locked;
   wire sysclk_in;
   wire clk200_in;
   wire sysclk0_i;
   wire sysclk270_i;
   wire user_reset_in;
   wire rst_tmp;

   generate
   if(CLK_TYPE == "DIFFERENTIAL") begin : DIFF_ENDED_CLKS_INST
    //***************************************************************************
    // Differential input clock input buffers
    //***************************************************************************
    IBUFGDS SYS_CLK_INST
      (
       .I (sys_clk_p),
       .IB(sys_clk_n),
       .O (sysclk_in)
       );

    IBUFGDS IDLY_CLK_INST
      (
       .I (dly_clk_200_p),
       .IB(dly_clk_200_n),
       .O (clk200_in)
       );

   end else if(CLK_TYPE == "SINGLE_ENDED") begin : SINGLE_ENDED_CLKS_INST
    //**************************************************************************
    // Single ended input clock input buffers
    //**************************************************************************
    IBUFG SYS_CLK_INST
      (
       .I (sys_clk),
       .O (sysclk_in)
       );

    if ( NOCLK200 == 0 ) begin : IBUFG_INST
        IBUFG IDLY_CLK_INST
          (
           .I (idly_clk_200),
           .O (clk200_in)
           );
    end

  end
  endgenerate

  generate
    if ( ((NOCLK200 == 0) && (CLK_TYPE == "SINGLE_ENDED")) || (CLK_TYPE == "DIFFERENTIAL") ) begin : BUFG_INST
      BUFG CLK_200_BUFG
        (
         .I(clk200_in),
         .O(clk200)
         );
    end else begin : NO_BUFG
      assign clk200 = 1'b0;
    end
  endgenerate

  //***************************************************************************
  // Global clock generation and distribution
  //***************************************************************************

  generate
    if (CLK_GENERATOR == "PLL") begin : gen_pll_adv
      PLL_ADV #
        (
         .BANDWIDTH          ("OPTIMIZED"),
         .CLKIN1_PERIOD      (CLK_PERIOD_NS),
         .CLKIN2_PERIOD      (10.000),
         .CLKOUT0_DIVIDE     (CLK_PERIOD_INT),
         .CLKOUT1_DIVIDE     (CLK_PERIOD_INT),
         .CLKOUT2_DIVIDE     (1),
         .CLKOUT3_DIVIDE     (1),
         .CLKOUT4_DIVIDE     (1),
         .CLKOUT5_DIVIDE     (1),
         .CLKOUT0_PHASE      (0.000),
         .CLKOUT1_PHASE      (270.000),
         .CLKOUT2_PHASE      (0.000),
         .CLKOUT3_PHASE      (0.000),
         .CLKOUT4_PHASE      (0.000),
         .CLKOUT5_PHASE      (0.000),
         .CLKOUT0_DUTY_CYCLE (0.500),
         .CLKOUT1_DUTY_CYCLE (0.500),
         .CLKOUT2_DUTY_CYCLE (0.500),
         .CLKOUT3_DUTY_CYCLE (0.500),
         .CLKOUT4_DUTY_CYCLE (0.500),
         .CLKOUT5_DUTY_CYCLE (0.500),
         .COMPENSATION       ("SYSTEM_SYNCHRONOUS"),
         .DIVCLK_DIVIDE      (1),
         .CLKFBOUT_MULT      (CLK_PERIOD_INT),
         .CLKFBOUT_PHASE     (0.0),
         .REF_JITTER         (0.005000)
         )
        u_pll_adv
          (
           .CLKFBIN     (clkfbout_clkfbin),
           .CLKINSEL    (1'b1),
           .CLKIN1      (sysclk_in),
           .CLKIN2      (1'b0),
           .DADDR       (5'b0),
           .DCLK        (1'b0),
           .DEN         (1'b0),
           .DI          (16'b0),
           .DWE         (1'b0),
           .REL         (1'b0),
           .RST         (user_reset_in),
           .CLKFBDCM    (),
           .CLKFBOUT    (clkfbout_clkfbin),
           .CLKOUTDCM0  (),
           .CLKOUTDCM1  (),
           .CLKOUTDCM2  (),
           .CLKOUTDCM3  (),
           .CLKOUTDCM4  (),
           .CLKOUTDCM5  (),
           .CLKOUT0     (sysclk0_i),
           .CLKOUT1     (sysclk270_i),
           .CLKOUT2     (),
           .CLKOUT3     (),
           .CLKOUT4     (),
           .CLKOUT5     (),
           .DO          (),
           .DRDY        (),
           .LOCKED      (locked)
           );
    end else if (CLK_GENERATOR == "DCM") begin: gen_dcm_base
      DCM_ADV #
        (
         .DLL_FREQUENCY_MODE    (DLL_FREQ_MODE),
         .SIM_DEVICE         ("VIRTEX5")
         )
        U_DCM_ADV
          (
           .CLK0      (sysclk0_i),
           .CLK180    (),
           .CLK270    (sysclk270_i),
           .CLK2X     (),
           .CLK2X180  (),
           .CLK90     (),
           .CLKDV     (),
           .CLKFX     (),
           .CLKFX180  (),
           .DO        (),
           .DRDY      (),
           .LOCKED    (locked),
           .PSDONE    (),
           .CLKFB     (clk0),
           .CLKIN     (sysclk_in),
           .DADDR     (),
           .DCLK      (),
           .DEN       (),
           .DI        (),
           .DWE       (),
           .PSCLK     (),
           .PSEN      (),
           .PSINCDEC  (),
           .RST       (user_reset_in)
           );
    end
  endgenerate

   // Global Buffers to drive clock outputs from PLL/DCM
   BUFG CLK0_BUFG_INST
     (
      .I(sysclk0_i),
      .O(clk0)
      );

   BUFG CLK270_BUFG_INST
     (
      .I(sysclk270_i),
      .O(clk270)
      );

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
