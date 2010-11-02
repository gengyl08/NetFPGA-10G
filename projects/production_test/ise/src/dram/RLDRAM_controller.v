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
// Copyright (c) 2006-2007 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: rld_controller.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:	 Virtex-5
//	Purpose: This module instantiates the control and configuration modules
//		* Control module has the main control logic
//		* Includes refresh logic,  write logic and read logic
//		* config module has the parameters for config register
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Fixed output assignment width of ctlBa, changed the clock frequency 
//             parameter to a clock period parameter
//*****************************************************************************

`timescale 1ns/100ps

module  rld_controller  (
   // rld_ctl signals
   clk,
   rstHard,
   rstHard_180,
   rstConfig,

   afEmpty,              
   afA,                

   rstCmd,
   rstAd,
   rstBa,

   ctlafRdEn,          
   ctlIoWdEn,   
   ctlCmd,      
   ctlAd,        
   ctlWdfRdEn,   
   ctlBa,        
   ctlOkEdge,    
   rldWriteDone, 

   apWdfWrEn,        
   wdfAlmostFull,    

   // rld_conf signals
   apConfRd,
   apConfWrD, 
   apConfRdD,
   apConfWr,
   apConfA,
   confMReg,
   confBL,

   // chipscope debug ports
   cs_io
);

// public parameters -- adjustable
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
//
// specific rld_conf parameters
parameter RL_CK_PERIOD  = 16'd3003;     // CK clock period of the RLDRAM in ps
// MRS (Mode Register Set command) parameters   
//    please check Micron RLDRAM-II datasheet for definitions of these parameters
parameter RL_MRS_CONF            = 3'b001; // 3'b001: mode1;  3'b010: mode2;  3'b011: mode3
parameter RL_MRS_BURST_LENGTH    = 2'b00;  // 2'b00: BL2;  2'b01: BL4;  2'b10: BL8
parameter RL_MRS_ADDR_MUX        = 1'b0;   // 1'b0: non-muxed addr;  1'b1: muxed addr
parameter RL_MRS_DLL_RESET       = 1'b0;   //
parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;   // internal 50ohms output buffer impedance
parameter RL_MRS_ODT             = 1'b0;   // 1'b0: disable term;  1'b1: enable term
//
// specific to FPGA/memory devices and capture method
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters

   // Global signals
   input                     clk;
   input                     rstHard;
   input                     rstHard_180;
   input                     rstConfig;

   input                     afEmpty;
   input [APP_AD_WIDTH-1:0]  afA;

   // Reset configuration signals from reset module
   input [3:0]               rstCmd;
   input [DEV_AD_WIDTH-1:0]  rstAd;
   input [DEV_BA_WIDTH-1:0]  rstBa;

   output                    ctlafRdEn;
   // write data enable for pads
   output                    ctlIoWdEn;
   // commands and address, bank outputs
   output [3:0]              ctlCmd;
   output [DEV_AD_WIDTH-1:0] ctlAd;
   // write data fifo read
   output                    ctlWdfRdEn;
   output [DEV_BA_WIDTH-1:0] ctlBa;
   // indicates okay to change data valid edge for per-bit deskew
   output                    ctlOkEdge;
   output                    rldWriteDone;

   input                     apWdfWrEn;        
   output                    wdfAlmostFull;

   input  [3:0]              apConfA;
   input 	             apConfWr;
   input  [7:0]              apConfWrD;
   input 	             apConfRd;
   output [7:0]              apConfRdD;

   output [17:0]             confMReg;
   output [3:0]                confBL;
   
   // chipscope debug ports
   inout  [1023:0]               cs_io;

   // configuration register's content
   wire [17:0]               confMReg;
   wire [3:0]                confRL;
   wire [3:0]                confWL;
   wire [7:0]                confRcCnt0;
   wire [7:0]                confRcCnt1;
   wire [7:0]                confRcMargin;
   wire [3:0]                confTrc;
   //wire [2:0]                confTrdWr;
   //wire [2:0]                confTwrRd;
   wire [3:0]                confBL;
   wire                      confCycRef;   // also named "confAutoRefrEn"

   wire                      ctlafRdEn;
   wire                      ctlIoWdEn;
   wire [3:0]                ctlCmd;
   wire                      ctlOkEdge;
   wire [DEV_AD_WIDTH-1:0]   ctlAd; 
   wire [DEV_BA_WIDTH-1:0]   ctlBa; 
   wire                      ctlWdfRdEn; 
   wire                      rldWriteDone;
   wire [7:0]                apConfRdD;
   wire                      wdfAlmostFull = 1'b0;  // not assigned...


   // -----------------------------------------------------------------------------
   // rld_conf
   //   Contains the user interface to the internal configuration registers
   // -----------------------------------------------------------------------------
   rld_conf  #(
      // specific rld_conf parameters
      .RL_CK_PERIOD           ( RL_CK_PERIOD ), 
      .RL_MRS_CONF            ( RL_MRS_CONF ),
      .RL_MRS_BURST_LENGTH    ( RL_MRS_BURST_LENGTH ),
      .RL_MRS_ADDR_MUX        ( RL_MRS_ADDR_MUX ),
      .RL_MRS_DLL_RESET       ( RL_MRS_DLL_RESET ),
      .RL_MRS_IMPEDANCE_MATCH ( RL_MRS_IMPEDANCE_MATCH ),
      .RL_MRS_ODT             ( RL_MRS_ODT ),
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE             ( RL_IO_TYPE ),
      .DEVICE_ARCH            ( DEVICE_ARCH ),
      .CAPTURE_METHOD         ( CAPTURE_METHOD )
   )
   rld_conf0  (
      .clk          ( clk ),
      .rstHard      ( rstHard ),
      .rstConfig    ( ),

      .apConfA      ( apConfA ),
      .apConfWr     ( apConfWr ),
      .apConfWrD    ( apConfWrD ),
      .apConfRd     ( apConfRd ),
      .apConfRdD    ( apConfRdD ),

      .confMReg     ( confMReg ),       // Mode Register Set (MRS)
      .confRL       ( confRL ),         // Read latency  
      .confWL       ( confWL ),         // Write latency 
      .confRcCnt0   ( confRcCnt0 ),     // Refresh interval counter [7:0]
      .confRcCnt1   ( confRcCnt1 ),     // Refresh interval counter [11:8]
      .confRcMargin ( confRcMargin ),   // Refresh interval counter margin
      .confTrc      ( confTrc ),        // tRC value
      .confTrdWr    ( ),
      .confTwrRd    ( ),
      .confBL       ( confBL ),         // burst length
      .confCycRef   ( confCycRef )      // control cyclic refresh (auto refresh enable)
   );


   // -----------------------------------------------------------------------------
   // rld_ctl
   //   low-level memory controller :
   //     * Main control is implemented in this module
   //     * Initiates read, write and refresh commands to rld memory
   // -----------------------------------------------------------------------------
   rld_ctl  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
      // specific to rld_conf 
      .RL_CK_PERIOD           ( RL_CK_PERIOD ), 
      .RL_MRS_CONF            ( RL_MRS_CONF ),
      .RL_MRS_BURST_LENGTH    ( RL_MRS_BURST_LENGTH ),
      .RL_MRS_ADDR_MUX        ( RL_MRS_ADDR_MUX ),
      .RL_MRS_DLL_RESET       ( RL_MRS_DLL_RESET ),
      .RL_MRS_IMPEDANCE_MATCH ( RL_MRS_IMPEDANCE_MATCH ),
      .RL_MRS_ODT             ( RL_MRS_ODT ),
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE             ( RL_IO_TYPE ),
      .DEVICE_ARCH            ( DEVICE_ARCH ),
      .CAPTURE_METHOD         ( CAPTURE_METHOD )
   )
   rld_ctl0  (
      .clk            ( clk ),
      .rstHard        ( rstHard ),
      .rstConfig      ( rstConfig ),

      .cmdFifoEmpty   ( afEmpty ),   // merged empty signal
      .cmdFifoOut     ( afA ),       // merged address bus
      .rstCmd         ( rstCmd ),
      .rstAd          ( rstAd ),
      .rstBa          ( rstBa ),

      .confRL         ( confRL ),
      .confWL         ( confWL ),
      .confRcCnt0     ( confRcCnt0 ),
      .confRcCnt1     ( confRcCnt1 ),
      .confRcMargin   ( confRcMargin ),
      .confTrc        ( confTrc ),
      .confTrdWr      ( ),
      .confTwrRd      ( ),
      .confBL         ( confBL ),
      .confAutoRefrEn ( confCycRef ),

      .cmdFifoRdEn    ( ctlafRdEn ),
      .ctlIoWdEn      ( ctlIoWdEn ),
      .ctlCmdOut      ( ctlCmd ),
      .ctlAddrOut     ( ctlAd ),
      .ctlWdfRdEn     ( ctlWdfRdEn ),
      .ctlBankOut     ( ctlBa ),
      .ctlOkEdge      ( ctlOkEdge ),
      .rldWriteDone   ( rldWriteDone ),
      
      .cs_io          ( cs_io )
// -- OLD ---------------------------------------------
//      .apWdfWrEn     ( apWdfWrEn ),
//      .wdfAlmostFull ( wdfAlmostFull ),
//      .confMReg      ( confMReg )
// ----------------------------------------------------
   );


endmodule
