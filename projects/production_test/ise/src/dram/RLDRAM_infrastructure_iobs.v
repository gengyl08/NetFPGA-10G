//*****************************************************************************
// DISCLAIMER OF LIABILITY
// 
// This text/file contains proprietary, confidential
// information of Xilinx, Inc., is distributed under license
// from Xilinx, Inc., and may be used, copied and/or
// disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc. Xilinx hereby grants you a 
// license to use this text/file solely for design, simulation, 
// implementation and creation of design files limited 
// to Xilinx devices or technologies. Use with non-Xilinx 
// devices or technologies is expressly prohibited and 
// immediately terminates your license unless covered by
// a separate agreement.
//
// Xilinx is providing this design, code, or information 
// "as-is" solely for use in developing programs and 
// solutions for Xilinx devices, with no obligation on the 
// part of Xilinx to provide support. By providing this design, 
// code, or information as one possible implementation of 
// this feature, application or standard, Xilinx is making no 
// representation that this implementation is free from any 
// claims of infringement. You are responsible for 
// obtaining any rights you may require for your implementation. 
// Xilinx expressly disclaims any warranty whatsoever with 
// respect to the adequacy of the implementation, including 
// but not limited to any warranties or representations that this
// implementation is free from claims of infringement, implied 
// warranties of merchantability or fitness for a particular 
// purpose.
//
// Xilinx products are not intended for use in life support
// appliances, devices, or systems. Use in such applications is
// expressly prohibited.
//
// Any modifications that are made to the Source Code are 
// done at the user's sole risk and will be unsupported.
//
// Copyright (c) 2006 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: rld_infrastructure_iobs.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:	 Virtex-4 and Virtex-5
//	Purpose: This module generates the data clock (DK) and the 
//		address/command clock (CK) for the memory physical layer.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Fixed issue with NUM_OF_DKS not being used to generate DKs
//*****************************************************************************

`timescale 1ns/100ps

module  rld_infrastructure_iobs  ( 
   clk,
   clk90,

   phy_dk_p,
   phy_dk_n,
   phy_ck_p,
   phy_ck_n
);

// parameter definitions
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
// end of parameter definitions

   input  clk;
   input  clk90;

(* IOSTANDARD = "HSTL_II_18" *)  output [NUM_OF_DKS-1:0]   phy_dk_p, phy_dk_n;
(* IOSTANDARD = "HSTL_II_18" *)  output [NUM_OF_DEVS-1:0]  phy_ck_p, phy_ck_n;
   
   wire   [NUM_OF_DKS-1:0]   dk_p;
   wire   [NUM_OF_DEVS-1:0]  ck_p;
   
   wire vcc;
   wire gnd;


   assign vcc = 1'b1;
   assign gnd = 1'b0;


   // -----------------------------------------------------------------------------
   // DK data write clock
   // -----------------------------------------------------------------------------
   //  - The output buffer should be differential
   //  - The I/O standard will be defined in the UCF:
   //      - HSTL_II (standard, Vcco=1.5V) or HSTL_II_18 (if Vcco is 1.8V)
   //      - DCI should be used if no external termination exists near the FPGA output
   //  - Virtex-4 and Virtex-5 support the following:
   //      - if external output terminations exist: DIFF_HSTL_II      -or-  DIFF_HSTL_II_18
   //      - if no external terminations output   : DIFF_HSTL_II_DCI  -or-  DIFF_HSTL_II_DCI_18
   // -----------------------------------------------------------------------------
   genvar i_dk;

   generate
      for (i_dk = 0; i_dk < NUM_OF_DKS; i_dk = i_dk + 1) begin : dk_gen_inst
         OBUFDS  dk_obufds  ( .O( phy_dk_p[i_dk] ), .OB( phy_dk_n[i_dk] ), .I( dk_p[i_dk] ) );

         ODDR  #(
            .SRTYPE       ("SYNC"),
            .DDR_CLK_EDGE ("OPPOSITE_EDGE")
         )
         dk_oddr  (
            .Q  ( dk_p[i_dk] ),
            .C  ( clk ),
            .CE ( vcc ),
            .D1 ( vcc ),  // To get same phase as original clock, needs to use D1=1, D2=0
            .D2 ( gnd ),
            .R  ( gnd ),
            .S  ( gnd )
         );
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // CK address/command write clock
   //   - used of address (A, BA) and control (CS_N, WE_N, REF_N) signals
   //   - source of memory's internal DLL
   // -----------------------------------------------------------------------------
   //  - The output buffer should be differential
   //  - The I/O standard will be defined in the UCF:
   //      - HSTL_II (standard, Vcco=1.5V) or HSTL_II_18 (if Vcco is 1.8V)
   //      - DCI should be used if no external termination exists near the FPGA output
   //  - Virtex-4 and Virtex-5 support the following:
   //      - if external output terminations exist: DIFF_HSTL_II      -or-  DIFF_HSTL_II_18
   //      - if no external terminations output   : DIFF_HSTL_II_DCI  -or-  DIFF_HSTL_II_DCI_18    
   // -----------------------------------------------------------------------------
   genvar i_ck;

   generate
      for (i_ck = 0; i_ck < NUM_OF_DEVS; i_ck = i_ck + 1) begin : ck_gen_inst
         OBUFDS  ck_obufds  ( .O( phy_ck_p[i_ck] ), .OB( phy_ck_n[i_ck] ), .I( ck_p[i_ck] ) );

         ODDR  #(
            .SRTYPE       ("SYNC"),
            .DDR_CLK_EDGE ("OPPOSITE_EDGE")
         )
         ck_oddr  (
            .Q  ( ck_p[i_ck] ),
            .C  ( clk ),
            .CE ( vcc ),
            .D1 ( vcc ),  // To get same phase as original clock, needs to use D1=1, D2=0
            .D2 ( gnd ),
            .R  ( gnd ),
            .S  ( gnd )
         );
      end
   endgenerate


endmodule
