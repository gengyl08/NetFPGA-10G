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
//  \   \         Filename: rld_v4_dq_iob.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4
//	Purpose: This module implements the physical interface for the
//   		bi-directional DQ data signal.  ODDR is used for write; IDDR is 
//		used for read through an IDELAY.
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_v4_dq_iob  #(
   parameter RL_IO_TYPE     = 2'b00,    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
   parameter DEVICE_ARCH    = 2'b00,    // Virtex4=2'b00  Virtex5=2'b01
   parameter CAPTURE_METHOD = 2'b00     // Direct Clocking=2'b00  SerDes=2'b01
)
(
   input        clk,
   input        clk90,
   input        refClk,  //XBP: NOT USED!
   input        rstHard,
   input        rstHard_90,
   input        rstHard_180,
   input        rstHard_270,

   input        dlyinc,
   input        dlyce,  
   input        dlyrst,

   input        write_data_rise,
   input        write_data_fall,
   input        ctrl_wren,

   inout        phy_dq,  // (* IOSTANDARD = "HSTL_II_18" *)   inout  phy_dq,

   output       read_data_rise,
   output       read_data_fall 
);

   wire         dq_in;
   wire         dq_out;
   wire         dq_delayed;
   wire         write_en_L;
   wire         write_en_L_r1;

   wire   clk180;
   wire   clk270;

   wire   vcc;
   wire   gnd;

   
   assign vcc = 1'b1;
   assign gnd = 1'b0;

   assign clk180 = ~clk;
   assign clk270 = ~clk90;

   assign write_en_L = ~ctrl_wren;


   ODDR  #(
      .SRTYPE       ( "SYNC" ),
      .DDR_CLK_EDGE ( "SAME_EDGE" )
   )
   dq_oddr  (
      .Q  ( dq_out ),
      .C  ( clk270 ),
      .CE ( vcc ),
      .D1 ( write_data_rise ),
      .D2 ( write_data_fall ),
      .R  ( rstHard_270 ),  // Forced to use the reset in tri-state flop??? Else IDDR doesn't work in hardware
      .S  ( gnd )
   );


   (* IOB = "TRUE" *)  // passing "IOB" attribute to FDCE
   FDCE  dq_tri_state  (
      .D   ( write_en_L ), 
      .CLR ( rstHard_270 ), 
      .C   ( clk270 ), 
      .Q   ( write_en_L_r1 ), 
      .CE  ( vcc )
   );            

            
//   IOBUF  dq_iobuf  (
//      .I  ( dq_out ),
//      .T  ( write_en_L_r1 ),
//      .IO ( phy_dq ),
//      .O  ( dq_in )
//   );
// XBP: infer the IOBUF instead of usign its instantiation
   assign phy_dq = write_en_L_r1 ? dq_out : 1'bz;


   IDELAY  #(
      .IOBDELAY_TYPE  ( "VARIABLE" ),
      .IOBDELAY_VALUE ( 0 )
   )
   dq_idelay  (
      .O   ( dq_delayed ),
//      .I   ( dq_in ),
      .I   ( phy_dq ),
      .C   ( clk ),   
      .CE  ( dlyce ),
      .INC ( dlyinc ),
      .RST ( dlyrst )
   );


   IDDR  #(
      .SRTYPE       ( "SYNC" ),
      .DDR_CLK_EDGE ( "SAME_EDGE_PIPELINED" )
   )
   dq_iddr  (
      .Q1 ( read_data_rise ),
      .Q2 ( read_data_fall ),
      .C  ( clk ),
      .CE ( vcc ),           
      .D  ( dq_delayed ),
      .R  ( rstHard ),  // Forced to use the reset in tri-state flop??? Else IDDR doesn't work in hardware
      .S  ( gnd )
   );


endmodule
