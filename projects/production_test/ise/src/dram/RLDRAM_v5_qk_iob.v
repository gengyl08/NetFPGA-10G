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
// \   \   \/     Version: 1.0
//  \   \         Filename: rld_v5_qk_iob.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-5
//	Purpose: This module implements the physical interface for the Read 
//		data path.  Generates the read path (RLD2_QK) from the IBUFs 
//		to the read data FIFOs.
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_v5_qk_iob  #(
   parameter RL_IO_TYPE     = 2'b00,    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
   parameter DEVICE_ARCH    = 2'b01,    // Virtex4=2'b00  Virtex5=2'b01
   parameter CAPTURE_METHOD = 2'b00     // Direct Clocking=2'b00  SerDes=2'b01
)
(
   input clk270,
   input dlyinc,
   input dlyrst,
   input dlyce,

   input phy_qk_p,
   input phy_qk_n,

   output phy_qk_bufio
);

   wire  qk_in;
   wire  qk_delayed;
   wire  qk_delayed_bufio;

	
   // from IDELAY to BUFIO
   BUFIO  qk_bufio  (
      .O ( qk_delayed_bufio ),  // Clock buffer output
      .I ( qk_delayed )         // Clock buffer input
   );	

   //assign #1.2 phy_qk_bufio = qk_delayed_bufio;   // for simulation
   assign #0.9 phy_qk_bufio = qk_delayed_bufio;   // for simulation
   //assign #0.6 phy_qk_bufio = qk_delayed_bufio;   // for simulation
   
//(* LOW_JITTER = "TRUE" *)  // passing "LOW_JITTER" attribute to IDELAY
   IDELAY  #(
      .IOBDELAY_TYPE  ( "VARIABLE" ),
      .IOBDELAY_VALUE ( 0 ) 
   )
   qk_idelay  (
      .O   ( qk_delayed ),
      .I   ( qk_in ),
      .C   ( clk270 ),  
      .CE  ( dlyce ),
      .INC ( dlyinc ),
      .RST ( dlyrst )
   );


   // The input buffer should be differential
   // The I/O standard will be defined in the UCF:
   //   - HSTL_II (standard, Vcco=1.5V) or HSTL_II_18 (if Vcco is 1.8V)
   //   - DCI should be used if no external termination exists near the FPGA input
   // Virtex-4 and Virtex-5 support the following:
   //   - if external input terminations exist: DIFF_HSTL_II      -or-  DIFF_HSTL_II_18
   //   - if no external terminations input   : DIFF_HSTL_II_DCI  -or-  DIFF_HSTL_II_DCI_18

   IBUFDS  qk_ibufgds  ( .O( qk_in ), .I( phy_qk_p ), .IB( phy_qk_n ) );


endmodule
