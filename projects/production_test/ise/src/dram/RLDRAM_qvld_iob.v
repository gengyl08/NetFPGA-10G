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
//  \   \         Filename: rld_v4_qvld_iob.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module implements the physical interface for the QVLD signal
//		provided by the memory.  QVLD follows the same input path as read
//		data and is captured by the IDDR (Virtex-4) or ISERDES (Virtex-5).
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_qvld_iob  #(
   parameter RL_IO_TYPE     = 2'b00,    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
   parameter DEVICE_ARCH    = 2'b00,    // Virtex4=2'b00  Virtex5=2'b01
   parameter CAPTURE_METHOD = 2'b00     // Direct Clocking=2'b00  SerDes=2'b01
)
(
   input    clk,
   input    refClk,
   input    clk270,
   input    bufio_clk,
   input    reset,

   input    dlyinc,
   input    dlyce,
   input    dlyrst,

   input    phy_qvld,  // (* IOSTANDARD = "HSTL_II_18" *)   input  phy_qvld,

// Virtex-4 interface
   input    first_rising_byte0,
   output   qvld_delayed_rise_byte0,
   output   qvld_delayed_fall_byte0,

   input    first_rising_byte1,
   output   qvld_delayed_rise_byte1,
   output   qvld_delayed_fall_byte1,

// Virtex-5 interface
//   output   qvld_out
   output   read_enable_rise,
   output   read_enable_fall
);

   // Virtex-4 interface
   wire     rd_en_delayed;
   wire     qvld_rise;
   wire     qvld_fall;
   reg      qvld_fall_r1;

   // Virtex-5 interface


   wire     vcc;
   wire     gnd;


   assign vcc = 1'b1;
   assign gnd = 1'b0;


   generate
      if ( DEVICE_ARCH == 2'b00 )  begin : qvld_virtex4

         IDELAY  #(
            .IOBDELAY_TYPE  ( "VARIABLE" ),
            .IOBDELAY_VALUE ( 0 )
         )
         idelay_read_en  (
            .O   ( rd_en_delayed ),
            .I   ( phy_qvld ),
            .C   ( clk ),   
            .CE  ( dlyce ),
            .INC ( dlyinc ),
            .RST ( dlyrst )
         );
         
         IDDR  #(
            .SRTYPE       ( "SYNC" ),
            .DDR_CLK_EDGE ( "SAME_EDGE_PIPELINED" )
         )
         iddr_qvld  (
            .Q1 ( qvld_rise ),
            .Q2 ( qvld_fall ),
            .C  ( clk ),
            .CE ( vcc ),           
            .D  ( rd_en_delayed ),
            .R  ( gnd ),
            .S  ( gnd )
         );
         
         // -----------------------------------------------------------------------------
         // Read enable signals from captured QVLD
         //   - independant output signals for two bytes of the same memory
         //   - QVLD tap calibration uses one tap count, assuming equal PCB routing
         // -----------------------------------------------------------------------------
         // first byte
         assign qvld_delayed_fall_byte0 = (first_rising_byte0) ? qvld_fall    : qvld_rise;
         assign qvld_delayed_rise_byte0 = (first_rising_byte0) ? qvld_fall_r1 : qvld_rise;
         // second byte
         assign qvld_delayed_fall_byte1 = (first_rising_byte1) ? qvld_fall    : qvld_rise;
         assign qvld_delayed_rise_byte1 = (first_rising_byte1) ? qvld_fall_r1 : qvld_rise;

         always @( posedge clk )
         begin : qvld_fd
            qvld_fall_r1 <= qvld_fall;
         end
      end


      else if ( DEVICE_ARCH == 2'b01 )  begin : qvld_virtex5         

  //(* LOW_JITTER = "TRUE" *)  // passing "LOW_JITTER" attribute to ISERDES
   ISERDES  #(
      .BITSLIP_ENABLE ( "FALSE" ),
      .DATA_RATE      ( "DDR" ),
      .DATA_WIDTH     ( 4 ),
      .INTERFACE_TYPE ( "MEMORY" ),
      .IOBDELAY       ( "IFD" ),
      .IOBDELAY_TYPE  ( "VARIABLE" ),
      .IOBDELAY_VALUE ( 0 ), 
      .NUM_CE         ( 2 ),
      .SERDES_MODE    ( "MASTER" )
   )  qvld_iserdes  (
      .O         ( ),
      .Q1        ( qvld_fall ),
      .Q2        ( qvld_rise ),
      .Q3        ( ),
      .Q4        ( ),
      .Q5        ( ),
      .Q6        ( ),
      .SHIFTOUT1 ( ),
      .SHIFTOUT2 ( ),
      .BITSLIP   ( ),
      .CE1       ( ~reset ),
      .CE2       ( ~reset ),
      .CLK       ( bufio_clk ),  // high speed forwarded clock input, driven by BUFIO
      .CLKDIV    ( clk270 ),     // divided high-speed forwarded clock input, drive last flop stage + IDELAY  
      .D         ( phy_qvld ),
      .DLYCE     ( dlyce ),
      .DLYINC    ( dlyinc ),
      .DLYRST    ( dlyrst ),
      .OCLK      ( clk270 ),     // high speed clock for memory apps, drive the serial-to-parallel converter
//      .REV       ( gnd ),
      .SHIFTIN1  ( ),
      .SHIFTIN2  ( ),
      .SR        ( reset )
   );
   
    assign read_enable_rise = qvld_rise;
    assign read_enable_fall = qvld_fall;
         
         
      end
   endgenerate


endmodule
