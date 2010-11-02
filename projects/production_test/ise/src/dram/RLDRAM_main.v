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
//  \   \         Filename: rld_main.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module instantiates the memory core (top) and the 
//		synthesizable testbench that acts as the user interface.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Pass RL_CK_PERIOD parameter to sub-modules
//
// Port Definitions:
//
// keep_qk_fall_unused[2*NUM_OF_DEVS-1:0]    output
//       keep falling edge levels of QK to prevent Q2 output of IDDR from being
//       trimmed, otherwise map 6.3.03 will crash. This has been fixed in 7.1i.
//
// apAddr[25:0]        input    
//     apAddr[25]    - user refresh
//     apAddr[24]    - R/~W  Reads and writes will be determined by bit 24 of 
//                     the "apAddr" bus
//     apAddr[23:23] - Reserved
//     apAddr[22:3]  - Memory Address bits A[19:0]
//     apAddr[2:0]   - Memory Bank Address Bits BA[2:0]
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_main  (
   clk,
   clk90,
   refClk,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   rstHard_refClk,
   sync_sysReset,
   dcmLocked,

   calibration_done,
   rstConfig,
   rstCmd,
   rstAd,
   rstBa,
   confMReg,
   Init_Done,
   issueMRS,
   mrsDone_o,

   PASS_FAIL, 

   // RLDRAM interface signals
   rld2_ck_p,
   rld2_ck_n,
   rld2_dk_p,
   rld2_dk_n,
   rld2_qk_p,
   rld2_qk_n,
   rld2_a,
   rld2_ba,
   rld2_cs_n,
   rld2_we_n,
   rld2_ref_n,
   rld2_dm,   
   rld2_dq,
   rld2_qvld
);

// public parameters -- adjustable
parameter SIMULATION_ONLY = 1'b0;  // if set (1'b1), shortens test
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
//
parameter RL_CK_PERIOD  = 16'd3003;     // CK clock period of the RLDRAM in ps
// MRS (Mode Register Set command) parameters   
//    please check Micron RLDRAM-II datasheet for definitions of these parameters
parameter RL_MRS_CONF            = 3'b001; // 3'b001: mode1;  3'b010: mode2;  3'b011: mode3
parameter RL_MRS_BURST_LENGTH    = 2'b00;  // 2'b00: BL2;  2'b01: BL4;  2'b10: BL8
parameter RL_MRS_ADDR_MUX        = 1'b0;   // 1'b0: non-muxed addr;  1'b1: muxed addr
parameter RL_MRS_DLL_RESET       = 1'b0;   //
parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;   // 1'b0: internal 50ohms output buffer impedance, 1'b1: external
parameter RL_MRS_ODT             = 1'b0;   // 1'b0: disable term;  1'b1: enable term
//
// specific to FPGA/memory devices and capture method
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
parameter CAL_ADDRESS    = {DEV_AD_WIDTH{1'b0}}; //saved location to perform calibration
// end of public parameters

   //input                       sysClk;
   input                       clk;
   input                       clk90;
   input                       refClk;
   input                       rstHard;
   input                       rstHard_90;
   input                       rstHard_180;
   input                       rstHard_270;
   input                       rstHard_refClk;
   input                       sync_sysReset;
   input                       dcmLocked;

   output                      calibration_done;
   input                       rstConfig;
   input  [3:0]                rstCmd;
   input  [DEV_AD_WIDTH-1:0]   rstAd;
   input  [DEV_BA_WIDTH-1:0]   rstBa;
   output [17:0]               confMReg;
   input                       Init_Done;
   //input                       Init_Done_270;
   output                      issueMRS;
   input                       mrsDone_o;

   output [2:0]                PASS_FAIL;
   
   // RLDRAM interface signals
   output [NUM_OF_DEVS-1:0]    rld2_ck_p;
   output [NUM_OF_DEVS-1:0]    rld2_ck_n;
   output [NUM_OF_DKS-1:0]     rld2_dk_p;
   output [NUM_OF_DKS-1:0]     rld2_dk_n;
   input  [2*NUM_OF_DEVS-1:0]  rld2_qk_p;
   input  [2*NUM_OF_DEVS-1:0]  rld2_qk_n;
   output [DEV_AD_WIDTH-1:0]   rld2_a;
   output [DEV_BA_WIDTH-1:0]   rld2_ba;
   output [NUM_OF_DEVS-1:0]    rld2_cs_n;
   output                      rld2_we_n;
   output                      rld2_ref_n;
   output [NUM_OF_DEVS-1:0]    rld2_dm;   
   inout  [RL_DQ_WIDTH-1:0]    rld2_dq;
   input  [NUM_OF_DEVS-1:0]    rld2_qvld;

   wire                        clk;
   wire                        clk90;
   wire                        refClk;
   wire                        rstHard;  
   wire                        rstHard_90;
   wire                        rstHard_180;  
   wire                        rstHard_270;
   wire                        rstHard_refClk;
   wire                        sync_sysReset;
   wire                        dcmLocked;

   wire                        Init_Done;

   wire  [NUM_OF_DEVS-1:0]     rld2_ck_p;
   wire  [NUM_OF_DEVS-1:0]     rld2_ck_n;
   wire  [NUM_OF_DKS-1:0]      rld2_dk_p;
   wire  [NUM_OF_DKS-1:0]      rld2_dk_n;
   wire  [2*NUM_OF_DEVS-1:0]   rld2_qk_p;
   wire  [2*NUM_OF_DEVS-1:0]   rld2_qk_n;
   wire  [DEV_AD_WIDTH-1:0]    rld2_a;
   wire  [DEV_BA_WIDTH-1:0]    rld2_ba;
   wire  [NUM_OF_DEVS-1:0]     rld2_cs_n;
   wire                        rld2_we_n;
   wire                        rld2_ref_n;
   wire  [NUM_OF_DEVS-1:0]     rld2_dm;
   wire  [RL_DQ_WIDTH-1:0]     rld2_dq;
   wire  [NUM_OF_DEVS-1:0]     rld2_qvld;

   wire  [(2*RL_DQ_WIDTH)-1:0] rldReadData;
   wire                        rldReadDataValid;
   wire  [APP_AD_WIDTH-1:0]    apAddr;
   wire  [(2*RL_DQ_WIDTH)-1:0] apWriteData;
   wire  [(2*NUM_OF_DEVS)-1:0] apWriteDM;
   wire                        apRdfRdEn;
   wire                        apWriteDValid;
   wire  [7:0]                 apConfRdD;
   wire                        apValid;
   wire                        rlWdfFull;
   wire                        rlWdfEmpty;
   wire                        rlafFull;
   wire                        rlafEmpty;
   wire                        rlRdfEmpty;
   wire  [12:0]                rlWdfWrCount;    // write data FIFO write count
   wire  [12:0]                rlWdfWordCount;  // write data FIFO word count
   wire  [12:0]                rlafWrCount;     // command/address FIFO write count
   wire  [12:0]                rlafWordCount;   // command/address FIFO word count

   wire  [3:0]                 apConfA;
   wire  [7:0]                 apConfWrD;
   wire                        apConfRd;
   wire                        apConfWr;

   wire                        issueCalibration;  // user command to restart the calibration
	
	wire                        rlafAlmostFull;
	wire                        rlWdfAlmostFull;
	
   wire [1023:0]             cs_io2;

   // -----------------------------------------------------------------------------
   // Main controller module:  CIO RLDRAM-II Controller
   // -----------------------------------------------------------------------------
   rld_top  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
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
      .CAPTURE_METHOD         ( CAPTURE_METHOD ),
      .CAL_ADDRESS            ( CAL_ADDRESS )
   )
   top0  (
      .clk              ( clk ),
      .clk90            ( clk90 ),
      .refClk           ( refClk ),
      .sync_sysReset    ( sync_sysReset ),
      .rstHard          ( rstHard ),
      .rstHard_90       ( rstHard_90 ),
      .rstHard_180      ( rstHard_180 ),
      .rstHard_270      ( rstHard_270 ),
      .rstHard_refClk   ( rstHard_refClk ),

      .issueCalibration ( issueCalibration ),
      .calibration_done ( calibration_done ),

      .rstConfig        ( rstConfig ),
      .rstCmd           ( rstCmd ),
      .rstAd            ( rstAd ),
      .rstBa            ( rstBa ),

      // RLDRAM-II interface signals
      .phy_ck_p         ( rld2_ck_p ),
      .phy_ck_n         ( rld2_ck_n ),
      .phy_dk_p         ( rld2_dk_p ),
      .phy_dk_n         ( rld2_dk_n ),
      .phy_qk_p         ( rld2_qk_p ),
      .phy_qk_n         ( rld2_qk_n ),
      .phy_a            ( rld2_a ),
      .phy_ba           ( rld2_ba ),
      .phy_cs_n         ( rld2_cs_n ),
      .phy_we_n         ( rld2_we_n ),
      .phy_ref_n        ( rld2_ref_n ),
      .phy_dm           ( rld2_dm ),
      .phy_dq           ( rld2_dq ),
      .phy_qvld         ( rld2_qvld ),

      // application interface signals
      .apRdfRdEn        ( apRdfRdEn ),
      .rldReadData      ( rldReadData ),
      .rldReadDataValid ( rldReadDataValid ),
   
      .apAddr           ( apAddr ),
      .apValid          ( apValid ),
      .apWriteDM        ( apWriteDM ),
      .apWriteData      ( apWriteData ),
      .apWriteDValid    ( apWriteDValid ),
      .apConfA          ( apConfA ),
      .apConfWrD        ( apConfWrD ),
      .apConfWr         ( apConfWr ),
      .apConfRdD        ( apConfRdD ),
   
      .apConfRd         ( apConfRd ),
      .rlWdfEmpty       ( rlWdfEmpty ),
      .rlWdfFull        ( rlWdfFull ),
      .rlRdfEmpty       ( rlRdfEmpty ),
      .rlafEmpty        ( rlafEmpty ),
      .rlafFull         ( rlafFull ),
      .rlWdfWrCount     ( rlWdfWrCount ),    // write data FIFO (wdfifo) write count
      .rlWdfWordCount   ( rlWdfWordCount ),  // write data FIFO (wdfifo) word count
      .rlafWrCount      ( rlafWrCount ),     // command/address FIFO (rafifo) write count
      .rlafWordCount    ( rlafWordCount ),   // command/address FIFO (rafifo) word count
      .rlafAlmostFull   ( rlafAlmostFull ),
      .rlWdfAlmostFull  ( rlWdfAlmostFull ),		
      .Init_Done        ( Init_Done ),
      .issueMRS         ( issueMRS ),
      .confMReg         ( confMReg )
   );

//
//   // -----------------------------------------------------------------------------
//   // User Application: synthesizable testbench
//   // -----------------------------------------------------------------------------
//   test_bench  #(
//      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
//      //.DEV_DQ_WIDTH           ( DEV_DQ_WIDTH )
//      //.DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
//      //.DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
//      //.DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
//      // specific to rld_conf 
//      //.RL_MRS_CONF            ( RL_MRS_CONF ),
//      .RL_MRS_BURST_LENGTH    ( RL_MRS_BURST_LENGTH )
//      //.RL_MRS_ADDR_MUX        ( RL_MRS_ADDR_MUX ),
//      //.RL_MRS_DLL_RESET       ( RL_MRS_DLL_RESET ),
//      //.RL_MRS_IMPEDANCE_MATCH ( RL_MRS_IMPEDANCE_MATCH ),
//      //.RL_MRS_ODT             ( RL_MRS_ODT ),
//      // specific to FPGA/memory devices and capture method
//      //.RL_IO_TYPE             ( RL_IO_TYPE ),
//      //.DEVICE_ARCH            ( DEVICE_ARCH ),
//      //.CAPTURE_METHOD         ( CAPTURE_METHOD )
//   )
//   test_bench0  (
//      .CLK                ( clk ),
//      .clk90              ( clk90 ),
//      .RESET              ( rstHard ),
//      .RESET_90           ( rstHard_90 ),
//      //.dcmLocked          ( dcmLocked ),
//
//      .WDF_ALMOST_FULL    ( rlWdfFull ),
//      .WDF_WR_COUNT       ( rlWdfWrCount ),    // write data FIFO (wdfifo) write count
//      //.wdf_word_count     ( rlWdfWordCount ),  // write data FIFO (wdfifo) word count
//      .RAF_ALMOST_FULL    ( rlafFull ),
//      .RAF_WR_COUNT       ( rlafWrCount ),     // command/address FIFO (rafifo) write count
//      //.raf_word_count     ( rlafWordCount ),   // command/address FIFO (rafifo) word count
//      .rlafEmpty          ( rlafEmpty ),
//      .BURST_LENGTH       ( confMReg[4:3] ),
//      .READ_DATA_FIFO_OUT ( rldReadData ),
//      .READ_DATA_VALID    ( rldReadDataValid ),  // Read Data valid flag (will be used by the user or test bench)
//
//      .Init_Done          ( Init_Done ),
//      .rlRdfEmpty         ( rlRdfEmpty ),
//      .rlWdfEmpty         ( rlWdfEmpty ),
//      //.mrsDone_o          ( mrsDone_o ),
//
//      .APADDR             ( apAddr ),
//      .APVALID            ( apValid ),
//      .APP_WDF_DATA       ( apWriteData ),
//      .APP_WDF_WREN       ( apWriteDValid ),
//      .APCONFA            ( apConfA ),
//      .APCONFWRD          ( apConfWrD ),
//      .APCONFRD           ( apConfRd ),
//      .APCONFWR           ( apConfWr ),
//      .APCONFRDD          ( apConfRdD ),
//      .APWRITEDM          ( apWriteDM ),
//      .apRdfRdEn          ( apRdfRdEn ),
//
//      .issueMRS           ( issueMRS ),
//      .issueCalibration   ( issueCalibration ),
//
//      .DISPLAY            (),
//      .error_count_BCD    (),
//   
//      .PASS_FAIL          ( PASS_FAIL ),
//
//      .cs_io              ( cs_io2 )
//   );

   // -----------------------------------------------------------------------------
   // User Application: synthesizable testbench
   // -----------------------------------------------------------------------------
   stress_test_bench  #(
      .SIMULATION_ONLY    ( SIMULATION_ONLY )     // if set, it shortens the wait time
   )
   stress_test_bench0  (
      .clk                ( clk ),
      .rst                ( rstHard ),
//      .BURST_LENGTH       ( confMReg[4:3] ),
      .write_full         ( rlWdfFull ),
      .ap_full            ( rlafFull ),
      .ap_empty           ( rlafEmpty ),

      .read_data          ( rldReadData ),
      .read_valid         ( rldReadDataValid ),  // Read Data valid flag (will be used by the user or test bench)

      .init_done          ( Init_Done ),
      .read_empty         ( rlRdfEmpty ),
      .write_empty        ( rlWdfEmpty ),
      .write_cnt          ( rlWdfWrCount ),    // write data FIFO (wdfifo) write count
      .write_word_cnt     ( rlWdfWordCount ),  // write data FIFO (wdfifo) word count
      .app_cnt            ( rlafWrCount ),     // command/address FIFO (rafifo) write count
      .app_word_cnt       ( rlafWordCount ),   // command/address FIFO (rafifo) word count

      .ap_adr             ( apAddr ),
      .ap_valid           ( apValid ),
      .write_data         ( apWriteData ),
      .write_valid        ( apWriteDValid ),
		.write_almost_full  ( rlWdfAlmostFull	),
		.app_almost_full    ( rlafAlmostFull ),
      .apConfWrD          ( apConfWrD ),
      .apConfRd           ( apConfRd ),
      .apConfWr           ( apConfWr ),
      .apWriteDM          ( apWriteDM ),
      .apRdfRdEn          ( apRdfRdEn ),
      .issueMRS           ( issueMRS ),
      .issueCalibration   ( issueCalibration ),
      .PASS_FAIL          ( PASS_FAIL )
   );

endmodule
