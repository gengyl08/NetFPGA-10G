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
//  \   \         Filename: rld_data_path.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module instantiates data_write and tap_logic modules.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Pass RL_CK_PERIOD parameter to sub-modules
//*****************************************************************************

`timescale 1ns/100ps

module  rld_data_path  (
   clk,
   clk90,
   refClk,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   rstHard_refClk,

   qk_idelay_inc,    // IDELAY controls for QK (read clock)
   qk_idelay_ce,
   qk_idelay_rst,
   data_idelay_inc,  // IDELAY controls for DQ (read data)
   data_idelay_ce,
   data_idelay_rst,
   qvld_idelay_inc,  // IDELAY controls for QVLD (read enable)
   qvld_idelay_ce,
   qvld_idelay_rst,

   rd_data_rise,
   rd_data_fall,

   okToSelTap ,

   ctlIoWdEn,
   wdfDM,
   wdfD,
   wr_data_rise,
   wr_data_fall,
   wr_en_clk90,
   data_mask_rise,
   data_mask_fall,

   CTRL_DUMMYREAD_START,
   refresh_cmd,
   CTRL_DQS_RST,
   CTRL_DQS_EN,
   read_enable_rise,
   read_enable_fall,
   first_stage_done,  
   second_stage_begin,
   qvld_cal,
   SEL_DONE,
   issueCalibration,

   read_en_delayed,
   read_data_rise,
   read_data_fall,

   idelay_ctrl_rdy,

   // chipscope debug ports
   cs_io
);

// public parameters -- adjustable
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter QK_DATA_WIDTH   = (DEV_DQ_WIDTH == 9)  ?  DEV_DQ_WIDTH : DEV_DQ_WIDTH/2;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
parameter RL_CK_PERIOD  = 16'd3003;     // CK clock period of the RLDRAM in ps

parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters

// PRIVATE parameters -- Do not change
parameter ALIGNED = 2'b00;
parameter EARLY   = 2'b01;
parameter LATE    = 2'b10;

   input                         clk;
   input                         clk90;
   input                         refClk;
   input                         rstHard;
   input                         rstHard_90;
   input                         rstHard_180;
   input                         rstHard_270;
   input                         rstHard_refClk;

   input                         CTRL_DUMMYREAD_START;
   input                         refresh_cmd;
   input                         CTRL_DQS_RST;
   input                         CTRL_DQS_EN;
   input                         ctlIoWdEn;
   input  [(2*NUM_OF_DEVS)-1:0]  wdfDM;
   input  [2*RL_DQ_WIDTH-1:0]    wdfD;
   input                         okToSelTap;
   input  [NUM_OF_DEVS-1:0]      read_enable_rise;
   input  [NUM_OF_DEVS-1:0]      read_enable_fall;

   input  [RL_DQ_WIDTH-1:0]      rd_data_rise;
   input  [RL_DQ_WIDTH-1:0]      rd_data_fall;

   output [RL_DQ_WIDTH-1:0]      wr_data_rise;
   output [RL_DQ_WIDTH-1:0]      wr_data_fall;
   output [NUM_OF_DEVS-1:0]      wr_en_clk90;
   output [NUM_OF_DEVS-1:0]      data_mask_rise;
   output [NUM_OF_DEVS-1:0]      data_mask_fall;

   output                        SEL_DONE;
   output                        first_stage_done;  
   input                         second_stage_begin;
   input                         qvld_cal;
   input                         issueCalibration;

   output [2*NUM_OF_DEVS-1:0]    read_en_delayed;
   output [RL_DQ_WIDTH-1:0]      read_data_rise;
   output [RL_DQ_WIDTH-1:0]      read_data_fall;

   output [2*NUM_OF_DEVS-1:0]    qk_idelay_inc;
   output [2*NUM_OF_DEVS-1:0]    qk_idelay_ce;
   output [2*NUM_OF_DEVS-1:0]    qk_idelay_rst;
   output [2*NUM_OF_DEVS-1:0]    data_idelay_inc;
   output [2*NUM_OF_DEVS-1:0]    data_idelay_ce;
   output [2*NUM_OF_DEVS-1:0]    data_idelay_rst;
   output [NUM_OF_DEVS-1:0]      qvld_idelay_inc;
   output [NUM_OF_DEVS-1:0]      qvld_idelay_ce;
   output [NUM_OF_DEVS-1:0]      qvld_idelay_rst;

   output                        idelay_ctrl_rdy;

   inout [1023:0]   cs_io;

   reg  [NUM_OF_DEVS-1:0]    read_enable_rise_r;

   reg                       SEL_DONE, SEL_DONE_a1, SEL_DONE_a2;
   reg  [RL_DQ_WIDTH-1:0]    rd_data_rise_r1;
   reg  [RL_DQ_WIDTH-1:0]    rd_data_fall_r1;

   wire [2*NUM_OF_DEVS-1:0]  data_tap_select;

   wire  [2*NUM_OF_DEVS*6-1:0]  DQ_tap_count;
    
   wire [4*NUM_OF_DEVS-1:0]   delay_select;

   wire [2*NUM_OF_DEVS-1:0]    read_enable_out;
   wire [NUM_OF_DEVS-1:0]      late_valid;
   wire [2*NUM_OF_DEVS-1:0]    delay;

   wire  clk180 = ~clk;
   wire  clk270 = ~clk90;

   reg [2*NUM_OF_DEVS-1:0]  delay_r;
   reg [NUM_OF_DEVS-1:0]    late_valid_r;

   // Assign data outputs per byte
   genvar i_byte;

   generate
      for ( i_byte = 0; i_byte < NUM_OF_DEVS; i_byte = i_byte + 1)
      begin : read_byte_insts
         // even bytes (0, 2, 4, ...)
         assign read_en_delayed[2*i_byte] = (late_valid_r[i_byte]) ? read_enable_rise_r[i_byte] : read_enable_rise[i_byte];
         assign read_data_rise[(2*i_byte+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] = (delay_r[2*i_byte]) ? rd_data_rise_r1[(2*i_byte+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] : rd_data_rise[(2*i_byte+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH];
         assign read_data_fall[(2*i_byte+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] = (delay_r[2*i_byte]) ? rd_data_fall_r1[(2*i_byte+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] : rd_data_fall[(2*i_byte+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH];
         // odd bytes  (1, 3, 5, ...)
         assign read_en_delayed[2*i_byte+1] = read_en_delayed[2*i_byte];
         assign read_data_rise[(2*i_byte+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] = (delay_r[2*i_byte+1]) ? rd_data_rise_r1[(2*i_byte+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] : rd_data_rise[(2*i_byte+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH];
         assign read_data_fall[(2*i_byte+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] = (delay_r[2*i_byte+1]) ? rd_data_fall_r1[(2*i_byte+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] : rd_data_fall[(2*i_byte+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH];
      end
   endgenerate

   //to be used with Chipscope for checking output of ISERDES (DEBUG)
   /*assign cs_io[8:0]  = {rd_data_rise[8:0]};     //1st byte
   assign cs_io[17:9] = {rd_data_fall[8:0]};

   assign cs_io[26:18] = {rd_data_rise[17:9]};    //2nd byte
   assign cs_io[35:27] = {rd_data_fall[17:9]};

   assign cs_io[44:36] = {rd_data_rise[26:18]};   //3rd byte
   assign cs_io[53:45] = {rd_data_fall[26:18]};

   assign cs_io[62:54] = {rd_data_rise[35:27]};   //4th byte
   assign cs_io[71:63] = {rd_data_fall[35:27]}; */

   // -----------------------------------------------------------------------------
   // For controller to stop (dummy reads) waiting for calibration to finish...
   //   transfer clock domains from clk270 to clk0
   // -----------------------------------------------------------------------------
   
  always @( posedge clk180 ) // from CLK270 to CLK180 before transfer to CLK0
   begin
      if ( rstHard_180 == 1'b1 )
         SEL_DONE_a1 <= 1'b0;
      else
         SEL_DONE_a1 <= &data_tap_select[2*NUM_OF_DEVS-1:0];
   end
   
   always @( posedge clk ) // from CLK180 to CLK0
   begin
      if ( rstHard == 1'b1 )
         SEL_DONE_a2 <= 1'b0;
      else
         SEL_DONE_a2 <= SEL_DONE_a1;
   end
   
   always @( posedge clk )
   begin
      if ( rstHard == 1'b1 )
         SEL_DONE <= 1'b0;
      else
         SEL_DONE <= SEL_DONE_a2;
   end

   // -----------------------------------------------------------------------------
   // May need to delay data by one clock to line up both bytes with the enable
   //   Mux used to select between either normal or registered output
   // -----------------------------------------------------------------------------	
   always @( posedge clk270 )
   begin
         rd_data_rise_r1 <= rd_data_rise;
         rd_data_fall_r1 <= rd_data_fall;		
   end 
   
   genvar i_qvld_r;
   
   generate
     for ( i_qvld_r = 0; i_qvld_r < NUM_OF_DEVS; i_qvld_r = i_qvld_r + 1)
     begin : qvld_r_insts
   
     always @ (posedge clk270)
       begin
         if ( rstHard_270 )
           read_enable_rise_r[i_qvld_r] <= 1'b0;
         else
           read_enable_rise_r[i_qvld_r] <= read_enable_rise[i_qvld_r];
       end
     end
   endgenerate

//Debug the QVLD alignment logic
//assign cs_io[79:72] = {delay_select}; 
//assign cs_io[86:81] = {1'b0, late_valid_r, delay_r};
  
//want to register the result of camparisons for better timing
genvar  i_delay;
  
generate
  for (i_delay = 0; i_delay < NUM_OF_DEVS; i_delay = i_delay + 1)
  begin : delay_insts

    // Two bytes share the same QVLD, and both bytes can be misaligned by 1 clock cycle
    // If byte early or the byte sharing valid with is aligned and I am late, delay me one clock

    // Even Bytes
    always @ (posedge clk270)
    begin
      if ( rstHard_270 ) begin
        delay_r[2*i_delay]    <= 1'b0;
      end else if ( delay_select[4*i_delay+1:4*i_delay] == EARLY ||
                  ( delay_select[4*i_delay+1:4*i_delay] == ALIGNED && delay_select[4*i_delay+3:4*i_delay+2] == LATE) ) begin
        delay_r[2*i_delay]    <= 1'b1;
      end else begin
        delay_r[2*i_delay]    <= 1'b0;
      end
    end
    
    // Odd Bytes
    always @ (posedge clk270)
    begin
      if ( rstHard_270 ) begin
        delay_r[2*i_delay+1]  <= 1'b0;
      end else if ( delay_select[4*i_delay+3:4*i_delay+2] == EARLY ||
                  ( delay_select[4*i_delay+3:4*i_delay+2] == ALIGNED && delay_select[4*i_delay+1:4*i_delay] == LATE) ) begin
        delay_r[2*i_delay+1]  <= 1'b1;
      end else begin
        delay_r[2*i_delay+1]  <= 1'b0;
      end
    end
    
    // Determine which QVLD to use: Output of ISERDES, or 1 clk registered version
    // If either byte is late then use the registered version, else use ISERDES output
    always @ (posedge clk270)
    begin
      if ( rstHard_270 ) begin
        late_valid_r[i_delay] <= 1'b0;
      end else if ( delay_select[4*i_delay+1:4*i_delay] == LATE || 
                delay_select[4*i_delay+3:4*i_delay+2] == LATE ) begin
        late_valid_r[i_delay] <= 1'b1;
      end else begin
        late_valid_r[i_delay] <= 1'b0;
      end
    end
    
  end
endgenerate

   //-------------------------------------------------------------------
   // data_write instantiation
   //-------------------------------------------------------------------
   rld_data_write  #(
      .RL_DQ_WIDTH     ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH    ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH    ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH    ( DEV_BA_WIDTH ),
      .RL_IO_TYPE      ( RL_IO_TYPE ),
      .DEVICE_ARCH     ( DEVICE_ARCH ),
      .CAPTURE_METHOD  ( CAPTURE_METHOD )
   )
   data_write0  (
      .clk            ( clk ),
      .clk90          ( clk90 ),
      .rstHard        ( rstHard ),
      .rstHard_90     ( rstHard_90 ),
      .rstHard_180    ( rstHard_180 ),
      .rstHard_270    ( rstHard_270 ),

      .ctlIoWdEn      ( ctlIoWdEn ),
      .wdfDM          ( wdfDM ),
      .wdfD           ( wdfD ),
      .wr_data_rise   ( wr_data_rise ),
      .wr_data_fall   ( wr_data_fall ),
      .wr_en_clk90    ( wr_en_clk90 ),
      .data_mask_rise ( data_mask_rise ),
      .data_mask_fall ( data_mask_fall )
   );


   //-------------------------------------------------------------------
   // tap_logic instantiation
   //-------------------------------------------------------------------
   rld_tap_logic  #(
      .RL_DQ_WIDTH     ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH    ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH    ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH    ( DEV_BA_WIDTH ),
      .RL_CK_PERIOD    ( RL_CK_PERIOD ), 
      .RL_IO_TYPE      ( RL_IO_TYPE ),
      .DEVICE_ARCH     ( DEVICE_ARCH ),
      .CAPTURE_METHOD  ( CAPTURE_METHOD )
   )
   taplogic0  (
      .clk                  ( clk ),
      .clk90                ( clk90 ),
      .refClk               ( refClk ),
      .rstHard              ( rstHard ),
      .rstHard_90           ( rstHard_90 ),
      .rstHard_180          ( rstHard_180 ),
      .rstHard_270          ( rstHard_270 ),
      .rstHard_refClk       ( rstHard_refClk ),
   
      .read_enable_rise     ( read_enable_rise ),
      .read_enable_fall     ( read_enable_fall ),
      .read_enable_rise_r   ( read_enable_rise_r ),
      .CTRL_DUMMYREAD_START ( CTRL_DUMMYREAD_START ),
      .refresh_cmd          ( refresh_cmd ),
      .issueCalibration     ( issueCalibration ),
   
      .qk_idelay_inc        ( qk_idelay_inc ),
      .qk_idelay_ce         ( qk_idelay_ce ),
      .qk_idelay_rst        ( qk_idelay_rst ),

      .data_idelay_inc      ( data_idelay_inc ),
      .data_idelay_ce       ( data_idelay_ce ),
      .data_idelay_rst      ( data_idelay_rst ),
   
      .qvld_idelay_inc      ( qvld_idelay_inc ),
      .qvld_idelay_ce       ( qvld_idelay_ce ),
      .qvld_idelay_rst      ( qvld_idelay_rst ),
   
      .read_enable_out      ( read_enable_out ),
      .delay_select         ( delay_select ),
   
      .DQ_tap_count         ( DQ_tap_count ),
      
      .first_stage_done     ( first_stage_done ),  
      .second_stage_begin   ( second_stage_begin ),
      .qvld_cal             ( qvld_cal ),
      .data_tap_select      ( data_tap_select ),
      .idelay_ctrl_rdy_r1   ( idelay_ctrl_rdy ),
   
      .rd_data_rise         ( rd_data_rise ),
      .rd_data_fall         ( rd_data_fall ),
   
      .cs_io                ( cs_io )
   );


endmodule
