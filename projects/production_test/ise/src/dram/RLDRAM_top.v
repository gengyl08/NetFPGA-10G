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
//  \   \         Filename: rld_top.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This is the RLDRAM-II top level module; the core itself.
//		It gathers data_path, controller, user_interface and iobs modules.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Pass RL_CK_PERIOD parameter to sub-modules, changed the read enable
//             for the read data FIFOs
//*****************************************************************************

`timescale 1ns/100ps

module  rld_top  (
   // global ports
   clk,
   clk90,
   refClk,               
   sync_sysReset,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   rstHard_refClk,

   issueCalibration,
   calibration_done,

   rstConfig,
   rstCmd,
   rstAd,
   rstBa, 

   // RLDRAM-II interface signals
   phy_ck_p,
   phy_ck_n,
   phy_dk_p,
   phy_dk_n,
   phy_qk_p,
   phy_qk_n,
   phy_a,
   phy_ba,
   phy_cs_n,
   phy_we_n,
   phy_ref_n,
   phy_dm,
   phy_dq,
   phy_qvld,

   // application interface signals
   apRdfRdEn,
   rldReadData,
   rldReadDataValid,

   apAddr,  
   apValid, 
   apWriteDM,
   apWriteData,
   apWriteDValid,
   apConfA,
   apConfWrD,
   apConfWr,
   apConfRdD,         

   apConfRd,
   rlWdfEmpty,
   rlWdfFull,
   rlRdfEmpty,
   rlafEmpty,
   rlafFull,
   rlWdfWrCount,
   rlWdfWordCount,
   rlafWrCount,
   rlafWordCount,

   Init_Done,
   issueMRS,
   confMReg,
   rlWdfAlmostFull,
   rlafAlmostFull
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

   // global signals
   input                         clk;
   input                         clk90;
   input                         refClk; 	
   input                         sync_sysReset;
   input                         rstHard;
   input                         rstHard_90;
   input                         rstHard_180;
   input                         rstHard_270;
   input                         rstHard_refClk;

   input                         issueCalibration;
   output                        calibration_done;

   input                         rstConfig;
   input  [3:0]                  rstCmd;
   input  [DEV_AD_WIDTH-1:0]     rstAd;
   input  [DEV_BA_WIDTH-1:0]     rstBa;

   // RLDRAM-II interface signals
   output [NUM_OF_DEVS-1:0]      phy_ck_p;
   output [NUM_OF_DEVS-1:0]      phy_ck_n;
   output [NUM_OF_DKS-1:0]       phy_dk_p;
   output [NUM_OF_DKS-1:0]       phy_dk_n;
   input  [2*NUM_OF_DEVS-1:0]    phy_qk_p;
   input  [2*NUM_OF_DEVS-1:0]    phy_qk_n;
   output [DEV_AD_WIDTH-1:0]     phy_a;
   output [DEV_BA_WIDTH-1:0]     phy_ba;
   output [NUM_OF_DEVS-1:0]      phy_cs_n;
   output                        phy_we_n;
   output                        phy_ref_n;
   output [NUM_OF_DEVS-1:0]      phy_dm;
   inout  [RL_DQ_WIDTH-1:0]      phy_dq;
   input  [NUM_OF_DEVS-1:0]      phy_qvld;

   // application interface signals
   input                         apRdfRdEn;
   output [(2*RL_DQ_WIDTH)-1:0]  rldReadData;
   output                        rldReadDataValid;

   input  [APP_AD_WIDTH-1:0]     apAddr;
   input                         apValid;
   input  [(2*NUM_OF_DEVS)-1:0]  apWriteDM;
   input  [(2*RL_DQ_WIDTH)-1:0]  apWriteData;
   input                         apWriteDValid;
   input  [3:0]                  apConfA;
   input  [7:0]                  apConfWrD;
   input                         apConfRd;
   input                         apConfWr;

   output [7:0]                  apConfRdD;
   output                        rlWdfEmpty;
   output                        rlWdfFull;
   output                        rlRdfEmpty;
   output                        rlafEmpty;
   output                        rlafFull;
   output [12:0]                 rlWdfWrCount;   // write data FIFO (wdfifo) write count
   output [12:0]                 rlWdfWordCount; // write data FIFO (wdfifo) write count
   output [12:0]                 rlafWrCount;    // command/address FIFO (rafifo) write count
   output [12:0]                 rlafWordCount;  // command/address FIFO (rafifo) word count

   input                         Init_Done;
   input                         issueMRS;
   output [17:0]                 confMReg;


   output                        rlWdfAlmostFull;
   output                        rlafAlmostFull;
	

wire [1023:0]               cs_io2;
wire [1023:0]               cs_io3;
wire [1023:0]               cs_io4;
wire [1023:0]               cs_io5;
wire [1023:0]               cs_io6;
wire [1023:0]               cs_io7;
   // wires
   wire                       clk;
   wire                       rstHard;
   wire                       rstHard_90;
   wire                       rstHard_180;
   wire                       rstHard_270;
   wire                       rstHard_refClk;
   wire                       rstConfig;
   wire [APP_AD_WIDTH-1:0]    afA;      
   wire [3:0]                 rstCmd;
   wire [DEV_AD_WIDTH-1:0]    rstAd;
   wire [DEV_BA_WIDTH-1:0]    rstBa;
   wire                       ctlafRdEn;  
   wire                       ctlIoWdEn;
   wire                       ctlWdfRdEn;
   wire                       ctlOkEdge;
   wire [17:0]                confMReg;
   wire [3:0]                 confBL;
   wire [(2*RL_DQ_WIDTH)-1:0] wdfD;
   wire [(2*NUM_OF_DEVS)-1:0] wdfDM;
   wire [RL_DQ_WIDTH-1:0]     wr_data_rise;
   wire [RL_DQ_WIDTH-1:0]     wr_data_fall;
   wire [NUM_OF_DEVS-1:0]     wr_en_clk90;
   wire [NUM_OF_DEVS-1:0]     data_mask_rise;
   wire [NUM_OF_DEVS-1:0]     data_mask_fall;
   wire [(2*RL_DQ_WIDTH)-1:0] dpRdData;

   wire [7:0] apConfRdD;
   wire       rlRdfFull;
   wire       rldWriteDone;

   wire                    first_sel_done;// first stage of calibration complete
   wire                    second_cal;    // second stage of calibration can begin
   wire                    qvld_cal;      // qvld calibration can be performed
   wire                    sel_done;      // completed QK and DQ calibration tap adjustments
   wire [3:0] 	           ctlCmd;
   wire [DEV_AD_WIDTH-1:0] ctlAd;
   wire [DEV_BA_WIDTH-1:0] ctlBa;

   wire [2*NUM_OF_DEVS-1:0] wren_RdFifo;

   wire [RL_DQ_WIDTH-1:0]   dpRdData_rise;
   wire [RL_DQ_WIDTH-1:0]   dpRdData_fall;

   wire [2*NUM_OF_DEVS-1:0] qk_idelay_inc;
   wire [2*NUM_OF_DEVS-1:0] qk_idelay_ce;
   wire [2*NUM_OF_DEVS-1:0] qk_idelay_rst;
   wire [2*NUM_OF_DEVS-1:0] data_idelay_inc;
   wire [2*NUM_OF_DEVS-1:0] data_idelay_ce;
   wire [2*NUM_OF_DEVS-1:0] data_idelay_rst;
   wire [NUM_OF_DEVS-1:0]   qvld_idelay_inc;
   wire [NUM_OF_DEVS-1:0]   qvld_idelay_ce;
   wire [NUM_OF_DEVS-1:0]   qvld_idelay_rst;
   wire [RL_DQ_WIDTH-1:0]   rd_data_rise;
   wire [RL_DQ_WIDTH-1:0]   rd_data_fall;
   wire                     rlafEmpty;
   wire                     rlafFull; 
   wire  [12:0]             rlWdfWrCount;    // write data FIFO (wdfifo) write count
   wire  [12:0]             rlWdfWordCount;  // write data FIFO (wdfifo) word count
   wire  [12:0]             rlafWrCount;     // command/address FIFO (rafifo) write count
   wire  [12:0]             rlafWordCount;   // command/address FIFO (rafifo) word count

   wire [2*NUM_OF_DEVS-1:0]  FIRST_RISING;
   wire                      wdfAlmostFull;
   wire                      rlWdfAlmostEmpty;
   wire                      rlWdfFull_1 ;
   wire [NUM_OF_DEVS-1:0]   read_enable_rise;
   wire [NUM_OF_DEVS-1:0]   read_enable_fall;

   wire apWriteDValid_dummy, apWriteDValid_m;
   wire apValid_dummy, apValid_m;

   wire start;
   wire reg_operation;  // used for mux control based on operation

   wire [APP_AD_WIDTH-1:0]    apAddr_dummy, apAddr_m; 
   wire [(2*RL_DQ_WIDTH)-1:0] apWriteData_dummy, apWriteData_m;
   wire [(2*NUM_OF_DEVS-1):0] apWriteDM_dummy, apWriteDM_m;
	
   wire [2*NUM_OF_DEVS-1:0] wren_RdFifo_mux;

   wire [2*NUM_OF_DEVS-1:0] qk_bufio;
   wire                     idelay_ctrl_rdy;

   wire clk180;
   wire clk270;
   
   reg refresh_cmd;

   reg                    calibration_done;
   reg [NUM_OF_DEVS-1:0]  calibration_done_r;
   reg    read_enable_rise_UI_r1;
   
   always @ (posedge clk270)
   begin
    if ( rstHard )
      read_enable_rise_UI_r1 <= 1'b0;
    else if ( calibration_done )
      read_enable_rise_UI_r1 <= read_enable_rise[0];
    else
      read_enable_rise_UI_r1 <= 1'b0;
   end

   assign clk180 = ~clk;
   assign clk270 = ~clk90;


   assign dpRdData[(2*RL_DQ_WIDTH)-1:RL_DQ_WIDTH] = dpRdData_rise;  
   assign dpRdData[RL_DQ_WIDTH-1:0]               = dpRdData_fall;
   assign rlWdfFull                               = rlWdfFull_1 || wdfAlmostFull;

   assign apWriteDValid_m = ( reg_operation ) ? apWriteDValid : apWriteDValid_dummy;
   assign apValid_m       = ( reg_operation ) ? apValid       : apValid_dummy;

   assign apAddr_m      = ( reg_operation ) ? apAddr      : apAddr_dummy;
   assign apWriteData_m = ( reg_operation ) ? apWriteData : apWriteData_dummy;
   assign apWriteDM_m   = ( reg_operation ) ? apWriteDM   : apWriteDM_dummy;

  // -----------------------------------------------------------------------------	
  // Transfer clock domains for the 'calibration_done' signal (clk0->clk270)
  // this signal used to MUX write_enable to the FIFOs (clk270)
  // -----------------------------------------------------------------------------	
   always @ (posedge clk)
   begin
    if ( rstHard ) begin
      calibration_done    <= 1'b0;
    end else begin
      calibration_done    <= reg_operation;
    end
   end 
   
   genvar i_cal_done_r;
   
   generate
     for ( i_cal_done_r = 0; i_cal_done_r < NUM_OF_DEVS; i_cal_done_r = i_cal_done_r + 1)
     begin : cal_done_r_insts
   
     always @ (posedge clk270)
       begin
         if ( rstHard_270 )
           calibration_done_r[i_cal_done_r] <= 1'b0;
         else
           calibration_done_r[i_cal_done_r] <= calibration_done;
       end
     
    assign wren_RdFifo_mux[2*i_cal_done_r]   = ( calibration_done_r[i_cal_done_r] ) ? wren_RdFifo[2*i_cal_done_r]   : {NUM_OF_DEVS{1'b0}};     
    assign wren_RdFifo_mux[2*i_cal_done_r+1] = ( calibration_done_r[i_cal_done_r] ) ? wren_RdFifo[2*i_cal_done_r+1] : {NUM_OF_DEVS{1'b0}};       
     end
   endgenerate
  // -----------------------------------------------------------------------------	
  // flag the refresh command so calibration can wait until refresh complete
  // -----------------------------------------------------------------------------	
   always @ (posedge clk)
   begin
    if ( rstHard )
      refresh_cmd <= 1'b0;
    else 
    if ( ctlCmd == 4'b0110 )
      refresh_cmd <= 1'b1; 
    else
      refresh_cmd <= 1'b0;
   end

   // -----------------------------------------------------------------------------
   // rld_user_interface
   //   Instantiates read fifo, write fifo and merged fifos.
   //   All user interface signals: 
   //     - write data
   //     - write address
   //     - read data
   //     - FIFO status signals
   // -----------------------------------------------------------------------------
   rld_user_interface  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE             ( RL_IO_TYPE ),
      .DEVICE_ARCH            ( DEVICE_ARCH ),
      .CAPTURE_METHOD         ( CAPTURE_METHOD )
   )
   user_interface0  (
      .clk              ( clk ),
      .clk90            ( clk90 ),
      .rstHard          ( rstHard ),
      .rstHard_90       ( rstHard_90 ),
      .rstHard_180      ( rstHard_180 ),
      .rstHard_270      ( rstHard_270 ),

      .apWriteDM        ( apWriteDM_m ),
      .apWriteData      ( apWriteData_m ),
      .apWriteDValid    ( apWriteDValid_m ),

      .ctlWdfRdEn       ( ctlWdfRdEn ),

      .apAddr           ( apAddr_m ),   // output address
      .apValid          ( apValid_m ),  // address fifo read enable

      .ctlafRdEn        ( ctlafRdEn ),
      //.apRdfRdEn        ( apRdfRdEn ),
      .apRdfRdEn        ( read_enable_rise_UI_r1 ),

      .dpRdData         ( dpRdData ),

      .wren_RdFifo      ( wren_RdFifo_mux ),

      .afA              ( afA ),
      .wdfDM            ( wdfDM ), 
      .wdfD             ( wdfD ),
      .rlWdfEmpty       ( rlWdfEmpty ),
      .rlWdfFull        ( rlWdfFull_1 ),
      .rldReadData      ( rldReadData ),
      .rldReadDataValid ( rldReadDataValid ),
      .rlafEmpty        ( rlafEmpty),
      .rlafFull         ( rlafFull ),
      .rlafAlmostEmpty  ( rlafAlmostEmpty ),
      .rlafAlmostFull   ( rlafAlmostFull ),
      .rlRdfEmpty       ( rlRdfEmpty ),
      .rlRdfFull        ( rlRdfFull ),
      .rlWdfAlmostEmpty ( rlWdfAlmostEmpty ),
      .rlWdfAlmostFull  ( rlWdfAlmostFull ),
      .rlWdfWrCount     ( rlWdfWrCount ),    // write data FIFO (wdfifo) write count
      .rlWdfWordCount   ( rlWdfWordCount ),  // write data FIFO (wdfifo) word count
      .rlafWrCount      ( rlafWrCount ),     // command/address FIFO (rafifo) write count
      .rlafWordCount    ( rlafWordCount ),    // command/address FIFO (rafifo) word count
      
      .cs_io            ( cs_io6 )
   );


   // -----------------------------------------------------------------------------
   // rld_data_path
   //   Instantiates tap_logic (calibration) and data_write (data mask) modules
   // -----------------------------------------------------------------------------
   rld_data_path  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
      .RL_CK_PERIOD           ( RL_CK_PERIOD ),
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE             ( RL_IO_TYPE ),
      .DEVICE_ARCH            ( DEVICE_ARCH ),
      .CAPTURE_METHOD         ( CAPTURE_METHOD )
   )
   data_path0  (
      .clk                  ( clk ),
      .clk90                ( clk90 ),
      .refClk               ( refClk ),
      .rstHard              ( rstHard ) ,
      .rstHard_90           ( rstHard_90 ),
      .rstHard_180          ( rstHard_180 ),
      .rstHard_270          ( rstHard_270 ),
      .rstHard_refClk       ( rstHard_refClk ),

      .qk_idelay_inc        ( qk_idelay_inc ),
      .qk_idelay_ce         ( qk_idelay_ce ),
      .qk_idelay_rst        ( qk_idelay_rst ),
      .data_idelay_inc      ( data_idelay_inc ),
      .data_idelay_ce       ( data_idelay_ce ),
      .data_idelay_rst      ( data_idelay_rst ),
      .qvld_idelay_inc      ( qvld_idelay_inc ),
      .qvld_idelay_ce       ( qvld_idelay_ce ),
      .qvld_idelay_rst      ( qvld_idelay_rst ),

      .rd_data_rise         ( rd_data_rise ),
      .rd_data_fall         ( rd_data_fall ),

      .okToSelTap           ( ctlOkEdge ),

      .ctlIoWdEn            ( ctlIoWdEn ),
      .wdfDM                ( wdfDM ),
      .wdfD                 ( wdfD ),
      .wr_data_rise         ( wr_data_rise ),
      .wr_data_fall         ( wr_data_fall ),
      .wr_en_clk90          ( wr_en_clk90 ),
      .data_mask_rise       ( data_mask_rise ),
      .data_mask_fall       ( data_mask_fall ),

      .CTRL_DUMMYREAD_START ( ~rstConfig ),
      .refresh_cmd          ( refresh_cmd ),
      .CTRL_DQS_RST         ( 1'b0 ),
      .CTRL_DQS_EN          ( 1'b0 ),
      .read_enable_rise     ( read_enable_rise ),
      .read_enable_fall     ( read_enable_fall ),
      .first_stage_done     ( first_sel_done ),
      .second_stage_begin   ( second_cal ),
      .qvld_cal             ( qvld_cal ),
      .SEL_DONE             ( sel_done ),
      .issueCalibration     ( issueCalibration ),

      .read_en_delayed      ( wren_RdFifo ),
      .read_data_rise       ( dpRdData_rise ),
      .read_data_fall       ( dpRdData_fall ),

      .idelay_ctrl_rdy      ( idelay_ctrl_rdy ),

      .cs_io                ( cs_io5 )
   );


   // -----------------------------------------------------------------------------
   // rld_iobs
   //   Top level for the physical layer (PHY).
   //   Instantiates the following modules:
   //     - data_path_iobs      : QK, DQ, QVLD and DM
   //     - controller_iobs     : A, BA, WE#, REF# and CS#
   //     - infrastructure_iobs : DK and CK
   // -----------------------------------------------------------------------------
   rld_iobs  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE             ( RL_IO_TYPE ),
      .DEVICE_ARCH            ( DEVICE_ARCH ),
      .CAPTURE_METHOD         ( CAPTURE_METHOD )
   )
   iobs0  (
      .clk              ( clk ),
      .clk90            ( clk90 ),         
      .refClk           ( refClk ),
      .sync_sysReset    ( sync_sysReset ),
      .rstHard          ( rstHard ),
      .rstHard_90       ( rstHard_90 ),
      .rstHard_180      ( rstHard_180 ),
      .rstHard_270      ( rstHard_270 ),

      .phy_ck_p         ( phy_ck_p ),
      .phy_ck_n         ( phy_ck_n ),
      .phy_dk_p         ( phy_dk_p ),
      .phy_dk_n         ( phy_dk_n ),
      .phy_qk_p         ( phy_qk_p ),
      .phy_qk_n         ( phy_qk_n ),
      .phy_a            ( phy_a ),
      .phy_ba           ( phy_ba ),
      .phy_cs_n         ( phy_cs_n ),
      .phy_we_n         ( phy_we_n ),
      .phy_ref_n        ( phy_ref_n ),
      .phy_dm           ( phy_dm ),
      .phy_dq           ( phy_dq ),
      .phy_qvld         ( phy_qvld ),

      .qk_idelay_inc    ( qk_idelay_inc ),
      .qk_idelay_ce     ( qk_idelay_ce ),
      .qk_idelay_rst    ( qk_idelay_rst ),
      .data_idelay_inc  ( data_idelay_inc ),
      .data_idelay_ce   ( data_idelay_ce ),
      .data_idelay_rst  ( data_idelay_rst ),
      .qvld_idelay_inc  ( qvld_idelay_inc ),
      .qvld_idelay_ce   ( qvld_idelay_ce ),
      .qvld_idelay_rst  ( qvld_idelay_rst ),

      .wr_data_rise     ( wr_data_rise),
      .wr_data_fall     ( wr_data_fall),
      .wr_en_clk90      ( wr_en_clk90),
      .data_mask_rise   ( data_mask_rise),
      .data_mask_fall   ( data_mask_fall),

      .rd_data_rise     ( rd_data_rise ),
      .rd_data_fall     ( rd_data_fall ),

      .ctlCmd           ( ctlCmd ),
      .ctlAd            ( ctlAd ),
      .ctlBa            ( ctlBa ),

      .read_enable_rise ( read_enable_rise ),
      .read_enable_fall ( read_enable_fall ),

      .cs_io            ( cs_io4 )
   );

//assign cs_io[71:0] = wr_data_rise[71:0];
//assign cs_io[143:72] = wr_data_fall[71:0];
//assign cs_io[215:144] = rd_data_rise[71:0];
//assign cs_io[287:216] = rd_data_fall[71:0];

//assign cs_io[289:288] = wr_en_clk90[1:0];
//assign cs_io[291:290] = read_enable_rise[1:0];
//assign cs_io[293:292] = read_enable_fall[1:0];

   // -----------------------------------------------------------------------------
   // rld_controller
   //   Instantiates the control and configuration modules:
   //     * Control module has the main control logic
   //     * Includes refresh logic, write logic and read logic
   //     * config module has the parameters for config register
   // -----------------------------------------------------------------------------
   rld_controller  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
      .RL_CK_PERIOD           ( RL_CK_PERIOD ),
      // specific to rld_conf 
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
   controller0  (
      .clk           ( clk ),
      .rstHard       ( rstHard ),
      .rstHard_180   ( rstHard_180 ),
      .rstConfig     ( rstConfig ),
   
      .afEmpty       ( rlafEmpty ),
      .afA           ( afA ),

      .rstCmd        ( rstCmd ),
      .rstAd         ( rstAd ),
      .rstBa         ( rstBa ),
   
      .ctlafRdEn     ( ctlafRdEn ),   // address fifo read enable    
      .ctlIoWdEn     ( ctlIoWdEn ),
      .ctlCmd        ( ctlCmd ),
      .ctlAd         ( ctlAd ),
      .ctlWdfRdEn    ( ctlWdfRdEn ),  // write data fifo read enable   
      .ctlBa         ( ctlBa ),
      .ctlOkEdge     ( ctlOkEdge ),
      .rldWriteDone  ( rldWriteDone ),

      .apWdfWrEn     ( apWriteDValid_m ),  // used to count transfers to fifo
      .wdfAlmostFull ( wdfAlmostFull ),
   
      .apConfRd      ( apConfRd ),
      .apConfWrD     ( apConfWrD ),
      .apConfRdD     ( apConfRdD ),
      .apConfWr      ( apConfWr ),
      .apConfA       ( apConfA ),
      .confMReg      ( confMReg ),
      .confBL        ( confBL ),
      
      .cs_io         ( cs_io2 )
   );


   // -----------------------------------------------------------------------------
   // rld_phy_calib
   //   Creates dummy read and write data for phy calibration, 
   //   writing data to FIFOs for processing by the controller.
   //   Supports BL=2 and BL=4.
   // -----------------------------------------------------------------------------
   assign start = ~rstConfig && idelay_ctrl_rdy;

   rld_phy_calib  #(
      .RL_DQ_WIDTH            ( RL_DQ_WIDTH ),
      .RL_CK_PERIOD           ( RL_CK_PERIOD ),
      .DEV_DQ_WIDTH           ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH           ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH           ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS     ( DUPLICATE_CONTROLS ),
      // specific to rld_conf 
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
      // specific to calibration scheme
      .CAL_ADDRESS            ( CAL_ADDRESS )
   )
   phy_calib0  (
      .clk              ( clk ),
      .rstHard          ( rstHard ),
      .confBL           ( confBL ),
      .start            ( start ),
      .first_sel_done   ( first_sel_done ),
      .sel_done         ( sel_done ),
      .refresh_cmd      ( refresh_cmd ),
      .issueCalibration ( issueCalibration ),

      .rlWdfFull        ( rlWdfFull ),
      .rlWdfEmpty       ( rlWdfEmpty ),
      .rlafFull         ( rlafFull ),
      .rlafAlmostEmpty  ( rlafAlmostEmpty ),
      .rlafEmpty        ( rlafEmpty ),

      .second_cal_out   ( second_cal ),
      .qvld_cal_out     ( qvld_cal ),
      .cal_done         ( reg_operation ),
      .apValid          ( apValid_dummy ),
      .apAddr           ( apAddr_dummy ),
      .apWriteDValid    ( apWriteDValid_dummy ),
      .apWriteData      ( apWriteData_dummy ),
      .apWriteDM        ( apWriteDM_dummy ),
      
      .cs_io            ( cs_io3 )
   );

endmodule
