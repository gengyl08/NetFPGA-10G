///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// 
///////////////////////////////////////////////////////////////////////////////
//
//  CLOCK_MODULE
//
//
//  Description: A module provided as a convenience for desingners using 2/4-byte 
//               lane Aurora Modules. This module takes the GT reference clock as
//               input, and produces a divided clock on a global clock net suitable
//               for driving application logic connected to the Aurora User Interface.
//

`timescale 1 ns / 1 ps
(* core_generation_info = "aurora,aurora_8b10b_v5_2,{backchannel_mode=Sidebands, c_aurora_lanes=10, c_column_used=left, c_gt_clock_1=GTXD1, c_gt_clock_2=None, c_gt_loc_1=1, c_gt_loc_10=10, c_gt_loc_11=X, c_gt_loc_12=X, c_gt_loc_13=X, c_gt_loc_14=X, c_gt_loc_15=X, c_gt_loc_16=X, c_gt_loc_17=X, c_gt_loc_18=X, c_gt_loc_19=X, c_gt_loc_2=2, c_gt_loc_20=X, c_gt_loc_21=X, c_gt_loc_22=X, c_gt_loc_23=X, c_gt_loc_24=X, c_gt_loc_25=X, c_gt_loc_26=X, c_gt_loc_27=X, c_gt_loc_28=X, c_gt_loc_29=X, c_gt_loc_3=3, c_gt_loc_30=X, c_gt_loc_31=X, c_gt_loc_32=X, c_gt_loc_33=X, c_gt_loc_34=X, c_gt_loc_35=X, c_gt_loc_36=X, c_gt_loc_37=X, c_gt_loc_38=X, c_gt_loc_39=X, c_gt_loc_4=4, c_gt_loc_40=X, c_gt_loc_41=X, c_gt_loc_42=X, c_gt_loc_43=X, c_gt_loc_44=X, c_gt_loc_45=X, c_gt_loc_46=X, c_gt_loc_47=X, c_gt_loc_48=X, c_gt_loc_5=5, c_gt_loc_6=6, c_gt_loc_7=7, c_gt_loc_8=8, c_gt_loc_9=9, c_lane_width=4, c_line_rate=6.5, c_nfc=false, c_nfc_mode=IMM, c_refclk_frequency=130.0, c_simplex=false, c_simplex_mode=TX, c_stream=true, c_ufc=false, flow_mode=None, interface_mode=Streaming, dataflow_config=Duplex}" *)
module aurora_CLOCK_MODULE  #
(
   parameter MULT          =       2,
   parameter DIVIDE        =       1,
   parameter CLK_PERIOD    =       3.08,
   parameter OUT0_DIVIDE   =       4,
   parameter OUT1_DIVIDE   =       2,
   parameter OUT2_DIVIDE   =       4,
   parameter OUT3_DIVIDE   =       2
)
(
    GT_CLK,
    GT_CLK_LOCKED,
    USER_CLK,
    SYNC_CLK,
    PLL_NOT_LOCKED
);

`define DLY #1


//***********************************Port Declarations*******************************

    input       GT_CLK;
    input       GT_CLK_LOCKED;
    output      USER_CLK;
    output      SYNC_CLK;
    output      PLL_NOT_LOCKED;

//*********************************Wire Declarations**********************************

    wire            clkfb_w;
    wire            clkout0_o;
    wire            clkout1_o;
    wire            clkout2_o;
    wire            clkout3_o;
    wire            locked_w;

//*********************************Main Body of Code**********************************

    // Instantiate a PLL module to divide the reference clock.
    PLL_ADV #
    (
         .CLKFBOUT_MULT     (MULT),
         .DIVCLK_DIVIDE     (DIVIDE),
         .CLKFBOUT_PHASE    (0),
         
         .CLKIN1_PERIOD     (CLK_PERIOD),
         .CLKIN2_PERIOD     (10),   //Not used
         
         .CLKOUT0_DIVIDE    (OUT0_DIVIDE),
         .CLKOUT0_PHASE     (0),
         
         .CLKOUT1_DIVIDE    (OUT1_DIVIDE),
         .CLKOUT1_PHASE     (0),

         .CLKOUT2_DIVIDE    (OUT2_DIVIDE),
         .CLKOUT2_PHASE     (0),
         
         .CLKOUT3_DIVIDE    (OUT3_DIVIDE),
         .CLKOUT3_PHASE     (0)        
    )
    pll_adv_i   
    (
         .CLKIN1            (GT_CLK),
         .CLKIN2            (1'b0),
         .CLKINSEL          (1'b1),
         .CLKFBIN           (clkfb_w),
         .CLKOUT0           (clkout0_o),
         .CLKOUT1           (clkout1_o),
         .CLKOUT2           (clkout2_o),
         .CLKOUT3           (clkout3_o),
         .CLKOUT4           (),
         .CLKOUT5           (),
         .CLKFBOUT          (clkfb_w),
         .CLKFBDCM          (),
         .CLKOUTDCM0        (),
         .CLKOUTDCM1        (),
         .CLKOUTDCM2        (),
         .CLKOUTDCM3        (),
         .CLKOUTDCM4        (),
         .CLKOUTDCM5        (),
         .DO                (),
         .DRDY              (),
         .DADDR             (5'd0),
         .DCLK              (1'b0),
         .DEN               (1'b0),
         .DI                (16'd0),
         .DWE               (1'b0),
         .REL               (1'b0),
         .LOCKED            (locked_w),
         .RST               (!GT_CLK_LOCKED)
    );

   // The PLL_NOT_LOCKED signal is created by inverting the PLL's locked signal.
    assign  PLL_NOT_LOCKED  =   ~locked_w;

    // The User Clock is distributed on a global clock net.
    BUFG user_clk_net_i
    (
        .I(clkout0_o),
        .O(USER_CLK)
    );

    BUFG sync_clk_net_i
    (
        .I(clkout1_o),
        .O(SYNC_CLK)
    );

endmodule
