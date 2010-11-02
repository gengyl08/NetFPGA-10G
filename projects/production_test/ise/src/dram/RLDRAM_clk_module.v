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
//  \   \         Filename: rld_clk_module.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  virtex-4 and Virtex-5
//	Purpose: This module instantiates DCM_BASE primitive for the memory
//		interface and the 200 MHz clock for the IDELAYCTRL module.
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_clk_module  (   
	clk200,
	clk250,
   sysReset,
   clk,        // Global clock to all modules, output from DCM
   clk90,
   clk180,      
   clk270,
   refClk,     // differential clock output, with BUFG
   locked
);

// parameter definitions
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
//
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of parameter definitions
  
   input    clk200;
   input    clk250;		
   input    sysReset; 
   output   clk;
   output   clk90;
   output   clk180;
   output   clk270;
   output   refClk;
   output   locked;

   wire     clk0_bufg_in;
   wire     clk90_bufg_in;
   wire     clk180_bufg_in;
   wire     clk270_bufg_in;
	
   wire     clk0_bufg_out;
   wire     clk90_bufg_out;
   wire     clk180_bufg_out;
   wire     clk270_bufg_out;

   wire     refClk;   
   wire     clkfx_bufg_in;

   //added for the Demo
   wire   clkin_ibufg;
   wire   clk0_pll;
   wire   clk0_pll_bufg;




   // -----------------------------------------------------------------------------
   // instantiate one DCM
   // -----------------------------------------------------------------------------
   DCM_BASE  #(
      .DLL_FREQUENCY_MODE    ( "HIGH" ),
      .DUTY_CYCLE_CORRECTION ( "TRUE" ),
      .CLKDV_DIVIDE          ( 16.0 ),
      .FACTORY_JF            ( 16'hF0F0 ),
      .DFS_FREQUENCY_MODE    ( "LOW" ),
      .CLKFX_MULTIPLY        ( 2 ),
      .CLKFX_DIVIDE          ( 8 )
   )
   DCM_BASE0  (
      .CLK0     ( clk0_bufg_in ),
      .CLK180   ( clk180_bufg_in ),
      .CLK270   ( clk270_bufg_in ),
      .CLK2X    ( ),
      .CLK2X180 ( ),
      .CLK90    ( clk90_bufg_in ),
      .CLKDV    (  ),
      .CLKFX    ( ),
      .CLKFX180 ( ),
      .LOCKED   ( locked ),
      .CLKFB    ( clk0_bufg_out ),
      .CLKIN    ( clk250 ), //sysClk   clk0_pll_bufg
      .RST      ( sysReset ) //sysReset      rst_dcm
   );

   BUFG  dcm_clk0    ( .O( clk0_bufg_out ),   .I( clk0_bufg_in ) );
   BUFG  dcm_clk90   ( .O( clk90_bufg_out ),  .I( clk90_bufg_in ) );
   //BUFG  dcm_clk180  ( .O( clk180_bufg_out ), .I( clk180_bufg_in ) );
   //BUFG  dcm_clk270  ( .O( clk270_bufg_out ), .I( clk270_bufg_in ) );

   assign clk    = clk0_bufg_out;   // CLK0 DCM output, with BUFG
   assign clk90  = clk90_bufg_out;  // CLK90 DCM output, with BUFG
   assign clk180 = ~clk;//clk180_bufg_out; // CLK180 DCM output, with BUFG
   assign clk270 = ~clk90;//clk270_bufg_out; // CLK270 DCM output, with BUFG

   assign refClk = clk200;

endmodule
