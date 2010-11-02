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
//  \   \         Filename: rld_infrastructure_top.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module instantiates clock and reset modules for the design
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_infrastructure_top  (
	clk200,
	clk250,
   sysReset,  // system reset input, acive low, asynchronous

   confMReg,
   issueMRS,
   calibration_done,

   clk,       // global clock to all modules 
   clk90,
   refClk,
   dcmlocked,

   sync_system_reset,  // system reset, synchronized to clk
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   rstHard_refClk,
   rstConfig,

   Init_Done,
   Init_Done_270,
   mrsDone_o,

   rstCmd,
   rstAd,
   rstBa
);

// parameter definitions
parameter SIMULATION_ONLY = 1'b0;  // if set (1'b1), it shortens the wait time
//
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

   input                     clk200;
   input                     clk250;	
   input                     sysReset; 

   input  [17:0]             confMReg;
   input                     issueMRS;
   input                     calibration_done;  // QK and DQ calibrations are completed

   output                    clk;
   output                    clk90;
   output                    refClk;
   output                    dcmlocked;

   output                    sync_system_reset;
   output                    rstHard;
   output                    rstHard_90;
   output                    rstHard_180;
   output                    rstHard_270;
   output                    rstHard_refClk;
   output                    rstConfig;

   output                    Init_Done;
   output                    Init_Done_270;
   output                    mrsDone_o;

   output [3:0]              rstCmd;
   output [DEV_AD_WIDTH-1:0] rstAd;
   output [DEV_BA_WIDTH-1:0] rstBa;

   // wires
   wire   sync_system_reset;
   wire   clk;
   wire   clk90;
   wire   clk180;
   wire   clk270;


   // -----------------------------------------------------------------------------
   // Clock module: get differential clock input (sysClk and refClk)
   //    - instantiates DCM_BASE primitive for memory interface
   //    - handles 200 MHz clock for the IDELAYCTRL module
   // -----------------------------------------------------------------------------
   rld_clk_module  #(
      .RL_DQ_WIDTH    ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH   ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH   ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH   ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS ( DUPLICATE_CONTROLS ),
      .RL_IO_TYPE     ( RL_IO_TYPE ),
      .DEVICE_ARCH    ( DEVICE_ARCH ),
      .CAPTURE_METHOD ( CAPTURE_METHOD )
   )
   clk_module0  (
		.clk200    ( clk200 ),
		.clk250    ( clk250 ),
      .sysReset  ( ~sysReset ),
      .clk       ( clk ),        // Global clock to all modules, output from DCM
      .clk90     ( clk90 ),
      .clk180    ( clk180 ),
      .clk270    ( clk270 ),
      .refClk    ( refClk ),     // differential clock output, with BUFG
      .locked    ( dcmlocked )
   );


   // -----------------------------------------------------------------------------
   // Reset module: reset statet machine and reset signals
   // -----------------------------------------------------------------------------
   rld_rst  #(
      .SIMULATION_ONLY    ( SIMULATION_ONLY ),     // if set, it shortens the wait time
      .RL_DQ_WIDTH        ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH       ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH       ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH       ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS ( DUPLICATE_CONTROLS ),
      .RL_IO_TYPE         ( RL_IO_TYPE ),
      .DEVICE_ARCH        ( DEVICE_ARCH ),
      .CAPTURE_METHOD     ( CAPTURE_METHOD )
   )
   rst0  (
      .clk               ( clk ),
      .clk90             ( clk90 ),
      .clk180            ( clk180 ),
      .clk270            ( clk270 ),
      .refClk            ( refClk ),
      .sysReset          ( sysReset ),
      .confMReg          ( confMReg ),
      .dcmLocked         ( dcmlocked ),
      .issueMRS          ( issueMRS ),
      .calibration_done  ( calibration_done ),  // calibration complete for QK and DQ 
      .sync_system_reset ( sync_system_reset ),
      .rstHard           ( rstHard ),
      .rstHard_90        ( rstHard_90 ),
      .rstHard_180       ( rstHard_180 ),
      .rstHard_270       ( rstHard_270 ),
      .rstHard_refClk    ( rstHard_refClk ),
      .rstConfig         ( rstConfig ),
      .Init_Done         ( Init_Done ),
      .Init_Done_270     ( Init_Done_270 ),
      .mrsDone_o         ( mrsDone_o ),
      .rstCmd            ( rstCmd ),
      .rstAd             ( rstAd ),
      .rstBa             ( rstBa )
   );


endmodule
