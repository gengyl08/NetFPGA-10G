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
//  \   \         Filename: rld_v5_dq_iob.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-5
//	Purpose: This module implements the physical interface for the Read 
//		data path.  Generates the read path (RLD2_DQ) from the IBUFs 
//		to the read data FIFOs.
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_v5_dq_iob  #(
   parameter RL_IO_TYPE     = 2'b00,    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
   parameter DEVICE_ARCH    = 2'b01,    // Virtex4=2'b00  Virtex5=2'b01
   parameter CAPTURE_METHOD = 2'b00     // Direct Clocking=2'b00  SerDes=2'b01
)
(
   input        clk270,
   input        bufio_clk,

   input        reset,

   input        dlyinc,   // the tap calibration runs with CLKDIV
   input        dlyce,  
   input        dlyrst,
   input        write_data_rise,
   input        write_data_fall,
   input        ctrl_wren,

   inout        phy_dq,   // (* IOSTANDARD = "HSTL_II_18" *)   inout  phy_dq,

   output       read_data_rise,
   output       read_data_fall
);
   

   wire         dq_in;
   wire         dq_out;
   wire         write_en_L;
   wire         write_en_L_r1;

   wire         vcc = 1'b1;
   wire         gnd = 1'b0;
	
   wire         Q1, Q2, Q3, Q4, Q5, Q6;   // for testing
   

   assign write_en_L = ~ctrl_wren;


   ODDR  #(
      .SRTYPE       ( "SYNC" ),
      .DDR_CLK_EDGE ( "SAME_EDGE" )
   )  dq_oddr  (
      .Q  ( dq_out ),
      .C  ( clk270 ),
      .CE ( vcc ),
      .D1 ( write_data_rise ),
      .D2 ( write_data_fall ),
      .R  ( 1'b0 ),
      .S  ( gnd )
   );


   (* IOB = "TRUE" *)  // passing "IOB" attribute to FDCE
   FDCE  dq_tri_state  (
      .D   ( write_en_L ), 
      .CLR ( reset ), 
      .C   ( clk270 ), 
      .Q   ( write_en_L_r1 ), 
      .CE  ( vcc )
   );            


   IOBUF  dq_iobuf  (
      .I  ( dq_out ),
      .T  ( write_en_L_r1 ),
      .IO ( phy_dq ),
      .O  ( dq_in )
   ); 

						
   assign Q1 = read_data_fall;
   assign Q2 = read_data_rise;					


   //(* LOW_JITTER = "TRUE" *)  // passing "LOW_JITTER" attribute to ISERDES
   ISERDES  #(
      .BITSLIP_ENABLE ( "FALSE" ),
      .DATA_RATE      ( "DDR" ),
      .DATA_WIDTH     ( 4 ),
      .INTERFACE_TYPE ( "MEMORY" ),
      .IOBDELAY       ( "IFD" ),
      .IOBDELAY_TYPE  ( "VARIABLE" ),
      .IOBDELAY_VALUE ( 0 ),  // was 8...
      .NUM_CE         ( 2 ),
      .SERDES_MODE    ( "MASTER" )
   )  dq_iserdes  (
      .O         ( ),
      .Q1        ( read_data_fall ),
      .Q2        ( read_data_rise ),
      .Q3        ( Q3 ),
      .Q4        ( Q4 ),
      .Q5        ( Q5 ),
      .Q6        ( Q6 ),
      .SHIFTOUT1 ( ),
      .SHIFTOUT2 ( ),
      .BITSLIP   ( ),
      .CE1       ( ~reset ),
      .CE2       ( ~reset ),
      .CLK       ( bufio_clk ),  // high speed forwarded clock input, driven by BUFIO
      .CLKDIV    ( clk270 ),     // divided high-speed forwarded clock input, drive last flop stage + IDELAY  
      .D         ( dq_in ),
      .DLYCE     ( dlyce ),
      .DLYINC    ( dlyinc ),
      .DLYRST    ( dlyrst ),
      .OCLK      ( clk270 ),     // high speed clock for memory apps, drive the serial-to-parallel converter
//      .REV       ( gnd ),
      .SHIFTIN1  ( ),
      .SHIFTIN2  ( ),
      .SR        ( reset )
   );


endmodule
