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
//  \   \         Filename: rld_tap_logic.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-5
//	Purpose: This module instantiates the tap control modules that control
//		the physical layer IDELAY elements.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Pass DEV_DQ_WIDTH, RL_CK_PERIOD, & QK_DATA_WIDTH parameter 
//             to sub-modules
//*****************************************************************************

`timescale 1ns/100ps

module  rld_tap_logic  (
   clk,
   clk90,
   refClk,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   rstHard_refClk,

   read_enable_rise,
   read_enable_fall,
   read_enable_rise_r,
   CTRL_DUMMYREAD_START,
   refresh_cmd,
   issueCalibration,

   qk_idelay_inc,
   qk_idelay_ce,
   qk_idelay_rst,

   data_idelay_inc,
   data_idelay_ce,
   data_idelay_rst,

   qvld_idelay_inc,
   qvld_idelay_ce,
   qvld_idelay_rst,

   read_enable_out,
   delay_select,

   DQ_tap_count,

   first_stage_done,  
   second_stage_begin,
   qvld_cal,
   data_tap_select,
   idelay_ctrl_rdy_r1,

   rd_data_rise,
   rd_data_fall,

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
//
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters

   input                       clk;
   input                       clk90;
   input                       refClk;
   input                       rstHard;
   input                       rstHard_90;
   input                       rstHard_180;
   input                       rstHard_270;
   input                       rstHard_refClk;

   input  [NUM_OF_DEVS-1:0]    read_enable_rise;
   input  [NUM_OF_DEVS-1:0]    read_enable_fall;
   input  [NUM_OF_DEVS-1:0]    read_enable_rise_r;
   input                       CTRL_DUMMYREAD_START;
   input                       refresh_cmd;
   input                       issueCalibration;

   output                      first_stage_done;    //QK centered in DQ window 
   input                       second_stage_begin;  //ready to start next phase
   input                       qvld_cal;            //align qvld
    
   output [2*NUM_OF_DEVS-1:0]  qk_idelay_inc;
   output [2*NUM_OF_DEVS-1:0]  qk_idelay_ce;
   output [2*NUM_OF_DEVS-1:0]  qk_idelay_rst;

   output [2*NUM_OF_DEVS-1:0]  data_idelay_inc;
   output [2*NUM_OF_DEVS-1:0]  data_idelay_ce;
   output [2*NUM_OF_DEVS-1:0]  data_idelay_rst;

   output [NUM_OF_DEVS-1:0]    qvld_idelay_inc;
   output [NUM_OF_DEVS-1:0]    qvld_idelay_ce;
   output [NUM_OF_DEVS-1:0]    qvld_idelay_rst;

   output [2*NUM_OF_DEVS-1:0]  read_enable_out; 
   output [4*NUM_OF_DEVS-1:0]  delay_select;

   output [2*NUM_OF_DEVS*6-1:0]  DQ_tap_count;  // 6-bit DQ counts, expandable per device, 2 counts per device

   output [2*NUM_OF_DEVS-1:0]  data_tap_select;
   output                      idelay_ctrl_rdy_r1;

   input  [RL_DQ_WIDTH-1:0]    rd_data_rise;
   input  [RL_DQ_WIDTH-1:0]    rd_data_fall;

   inout  [1023:0]   cs_io;
   
   reg [NUM_OF_DEVS-1:0] delay_start_r1;
   reg           delay_start;
   
   reg           idelay_ctrl_rdy;
   reg           idelay_ctrl_rdy_r1;
   
   reg           first_stage_done_r0;
   reg           first_stage_done_r1;
   reg           first_stage_done_r2;
   reg                            second_stage_begin_r1;
   reg [NUM_OF_DEVS-1:0]          second_stage_begin_r2;
   reg                            qvld_cal_r1;
   reg [NUM_OF_DEVS-1:0]          qvld_cal_r2;
   
   reg                            refresh_cmd_r1;
   reg [NUM_OF_DEVS-1:0]          refresh_cmd_r2;
   
   //create 2 registers of the "fall" output of QVLD
   reg  [NUM_OF_DEVS-1:0]    read_enable_fall_r1, read_enable_fall_r2;

   wire  [2*NUM_OF_DEVS*6-1:0]    DQ_tap_count;  // 6-bit DQ counts, expandable per device, 2 counts per device

   wire  [2*NUM_OF_DEVS*6-1:0]    QK_tap_count;  // 6-bit QK counts, expandable per device, 2 counts per device

   wire [2*NUM_OF_DEVS-1:0]  valid_tap_count;

   wire [2*NUM_OF_DEVS-1:0]  qk_idelay_inc;
   wire [2*NUM_OF_DEVS-1:0]  qk_idelay_ce;
   wire [2*NUM_OF_DEVS-1:0]  qk_idelay_rst; 
   wire [2*NUM_OF_DEVS-1:0]  data_idelay_inc;
   wire [2*NUM_OF_DEVS-1:0]  data_idelay_ce;
   wire [2*NUM_OF_DEVS-1:0]  data_idelay_rst; 
   wire [NUM_OF_DEVS-1:0]    qvld_idelay_inc;
   wire [NUM_OF_DEVS-1:0]    qvld_idelay_ce;
   wire [NUM_OF_DEVS-1:0]    qvld_idelay_rst; 
   
   wire [2*NUM_OF_DEVS-1:0]  first_cal_done; //QK centered in DQ window
   wire [2*NUM_OF_DEVS-1:0]  data_tap_select;
   
   wire [NUM_OF_DEVS-1:0]    wait_for_refresh;
   wire [NUM_OF_DEVS-1:0]    qvld_cal_done;

   wire 	 idelay_ctrl_rdy1;
   wire 	 idelay_ctrl_rdy2;

   wire [2*NUM_OF_DEVS*128-1:0]  test_cal;   // reserve 2 words of 128-bit per external device for debug
   wire [NUM_OF_DEVS*36-1:0]  test_qvld;

   wire  clk180 = ~clk;
   wire  clk270 = ~clk90;


   // The following can be used for debugging
  /*assign cs_io[173:100]   = { test_cal[73:0] }; //Test for Byte0
  assign cs_io[255:174] = {  
                            test_cal[432:421], test_cal[416:415], test_cal[412], test_cal[395:384],
                            test_cal[304:293], test_cal[288:287], test_cal[284], test_cal[267:256],
                            test_cal[176:165], test_cal[160:159], test_cal[156], test_cal[139:128] 
                          }; */

   // -----------------------------------------------------------------------------
   // IDELAYCTRL instantiation
   // -----------------------------------------------------------------------------
//   (* LOC = "IDELAYCTRL_X2Y1" *)  // passing "LOC" attribute to IDELAYCTRL
// moved constraint to UCF
   IDELAYCTRL  idelayctrl0  (
      .RDY    ( idelay_ctrl_rdy1 ),
      .REFCLK ( refClk ),
      .RST    ( rstHard_refClk )
   );

//   (* LOC = "IDELAYCTRL_X2Y2" *)  // passing "LOC" attribute to IDELAYCTRL
// moved constraint to UCF
   IDELAYCTRL  idelayctrl1  (
      .RDY    ( idelay_ctrl_rdy2 ),
      .REFCLK ( refClk ),
      .RST    ( rstHard_refClk )
   );

   // Ready Signal transferred to system clock domain
   // Uses 2 flops for metastability
   always @ ( posedge clk )
   begin
      if ( rstHard )
      begin
         idelay_ctrl_rdy    <= 1'b0;
         idelay_ctrl_rdy_r1 <= 1'b0;
      end
      else
      begin
         idelay_ctrl_rdy    <= idelay_ctrl_rdy1 & idelay_ctrl_rdy2;
         idelay_ctrl_rdy_r1 <= idelay_ctrl_rdy;
      end
   end


   // -----------------------------------------------------------------------------
   // hold up calibration until start signal given and first read data is seen
   // -----------------------------------------------------------------------------
   always @( posedge clk270 )
   begin
      if ( rstHard_270 )
         delay_start <= 1'b0;
      else
         if ( CTRL_DUMMYREAD_START && read_enable_fall_r1[0] ) 
            delay_start <= 1'b1;
         else
            delay_start <= delay_start;
   end
   
   genvar i_dly_start;

   generate
      for ( i_dly_start = 0; i_dly_start < NUM_OF_DEVS; i_dly_start = i_dly_start + 1)
      begin : i_dly_start_insts   
        always @( posedge clk270 )
        begin
          if ( rstHard_270 )
            delay_start_r1[i_dly_start] <= 1'b0;
          else	
            delay_start_r1[i_dly_start] <= delay_start;
        end
      end
   endgenerate
   
   // -----------------------------------------------------------------------------
   // Wait for all bytes to finish the first step in calibration before moving on
   // -----------------------------------------------------------------------------
  always @ (posedge clk270)
  begin
    if ( rstHard_270 )
      first_stage_done_r0 <= 1'b0;
    else
      first_stage_done_r0 <= &first_cal_done[2*NUM_OF_DEVS-1:0];
  end
  
  //transfer from CLK270 to CLK90 Domain first
  always @ (posedge clk90)
  begin
    if ( rstHard_90 )
      first_stage_done_r1 <= 1'b0;
    else
      first_stage_done_r1 <= first_stage_done_r0;
  end
  
  //transfer from CLK90 to CLK0 Domain
  always @ (posedge clk)
  begin
    if ( rstHard )
      first_stage_done_r2 <= 1'b0;
    else
      first_stage_done_r2 <= first_stage_done_r1;
  end
  
  assign first_stage_done = first_stage_done_r2;
  
   // -----------------------------------------------------------------------------
   // Transfer clock domains for signal to start 2nd phase and align qvld signals
   // ----------------------------------------------------------------------------- 
   always @ (posedge clk270)
   begin
    if ( rstHard_270 ) begin
      second_stage_begin_r1 <= 1'b0;
      qvld_cal_r1           <= 1'b0;
    end else begin
      second_stage_begin_r1 <= second_stage_begin;
      qvld_cal_r1           <= qvld_cal;
    end
   end
   
  genvar  i_second_stage;
  
  generate
    for (i_second_stage = 0; i_second_stage < NUM_OF_DEVS; i_second_stage = i_second_stage + 1)
    begin : second_stage_inst
    
      always @ (posedge clk270)
      begin
        if (rstHard_270) begin
            second_stage_begin_r2[i_second_stage] <= 1'b0;
            qvld_cal_r2[i_second_stage]           <= 1'b0;
        end else begin
            second_stage_begin_r2[i_second_stage] <= second_stage_begin_r1;
            qvld_cal_r2[i_second_stage]           <= qvld_cal_r1;
        end    
      end
    
    end
  endgenerate
  
   
   // -----------------------------------------------------------------------------
   // Hold up calibration while a refresh occurs
   // use the QVLD fall output (less load) to ensure data has started up again
   // ----------------------------------------------------------------------------- 
  always @ (posedge clk270)
  begin
    if ( rstHard_270 ) begin
      refresh_cmd_r1 <= 1'b0;
    end else begin
      refresh_cmd_r1 <= refresh_cmd;
    end
   end
  
  genvar  i_wait_var;
  
  generate
    for (i_wait_var = 0; i_wait_var < NUM_OF_DEVS; i_wait_var = i_wait_var + 1)
    begin : wait_gen_inst
    
      always @ (posedge clk270)
      begin
        if (rstHard_270)
          begin
            read_enable_fall_r1[i_wait_var] <= 1'b0;
            read_enable_fall_r2[i_wait_var] <= 1'b0;
            refresh_cmd_r2[i_wait_var]      <= 1'b0;
          end
        else
          begin
            read_enable_fall_r1[i_wait_var] <= read_enable_fall[i_wait_var];
            read_enable_fall_r2[i_wait_var] <= read_enable_fall_r1[i_wait_var];
            refresh_cmd_r2[i_wait_var]      <= refresh_cmd_r1;
          end
      end
    
      assign wait_for_refresh[i_wait_var] = ~read_enable_fall_r2[i_wait_var] || refresh_cmd_r2[i_wait_var];
    end
  endgenerate

   // -----------------------------------------------------------------------------
   // rld_dly_cal_sm
   //   - Calibrates IDELAY tap values for DQ and QK inputs
   //   - Allows capture of read data with FPGA clock domain
   //   - Requires memory to constantly send back read data
   //   - Figures out how byte lines up to QVLD signal
   // 
   // Number of SM instances depends on the number of independent bytes
   // -----------------------------------------------------------------------------
   genvar i_tap_sm;

   generate
      for ( i_tap_sm = 0; i_tap_sm < NUM_OF_DEVS; i_tap_sm = i_tap_sm + 1 )
      begin : byte_cal_gen_inst
         // even-byte Calibration
         rld_dly_cal_sm  #(
            .DEV_DQ_WIDTH    ( DEV_DQ_WIDTH ),            
            .RL_CK_PERIOD    ( RL_CK_PERIOD ),
            .QK_DATA_WIDTH   ( QK_DATA_WIDTH )            
         )
         tap_ctrl_e  (
            .clk             ( clk270 ),
            .rst             ( rstHard_270 || issueCalibration ),
            .start_cal       ( delay_start_r1[i_tap_sm] ),
            .second_stage    ( second_stage_begin_r2[i_tap_sm] ),
            .qvld_cal        ( qvld_cal_r2[i_tap_sm] ),
            .wait_for_refresh( wait_for_refresh[i_tap_sm] ),
            .rd_data_rise    ( rd_data_rise[(2*i_tap_sm+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] ),   // from IOBs
            .rd_data_fall    ( rd_data_fall[(2*i_tap_sm+1)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] ),   // from IOBs
            .rd_data_valid   ( read_enable_rise[i_tap_sm] ),
            .rd_data_valid_r ( read_enable_rise_r[i_tap_sm] ),
      
            .dq_dly_rst      ( data_idelay_rst[2*i_tap_sm] ),
            .dq_dly_ce       ( data_idelay_ce[2*i_tap_sm] ),
            .dq_dly_inc      ( data_idelay_inc[2*i_tap_sm] ),
            .qk_dly_rst      ( qk_idelay_rst[2*i_tap_sm] ),
            .qk_dly_ce       ( qk_idelay_ce[2*i_tap_sm] ),
            .qk_dly_inc      ( qk_idelay_inc[2*i_tap_sm] ),
            
            .first_cal_done  ( first_cal_done[2*i_tap_sm] ),
            .dly_cal_done    ( data_tap_select[2*i_tap_sm] ),
            .delay_select    ( delay_select[4*i_tap_sm+1:4*i_tap_sm] ),
      
            .QK_tap_count    ( QK_tap_count[(2*i_tap_sm+1)*6-1:2*i_tap_sm*6] ),
            .DQ_tap_count    ( DQ_tap_count[(2*i_tap_sm+1)*6-1:2*i_tap_sm*6] ),
            .test_cal        ( test_cal[(2*i_tap_sm+1)*128-1:2*i_tap_sm*128] )           // debug signal
         );

         // odd-byte Calibration
         rld_dly_cal_sm  #(
            .DEV_DQ_WIDTH    ( DEV_DQ_WIDTH ),
            .RL_CK_PERIOD    ( RL_CK_PERIOD ),
            .QK_DATA_WIDTH   ( QK_DATA_WIDTH )
         )
         tap_ctrl_o  (
            .clk             ( clk270 ),       
            .rst             ( rstHard_270 || issueCalibration ),
            .start_cal       ( delay_start_r1[i_tap_sm] ),
            .second_stage    ( second_stage_begin_r2[i_tap_sm]  ),
            .qvld_cal        ( qvld_cal_r2[i_tap_sm] ),
            .wait_for_refresh( wait_for_refresh[i_tap_sm] ),
            .rd_data_rise    ( rd_data_rise[(2*i_tap_sm+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] ),  // from IOBs
            .rd_data_fall    ( rd_data_fall[(2*i_tap_sm+2)*QK_DATA_WIDTH-1 -:QK_DATA_WIDTH] ),  // from IOBs
            .rd_data_valid   ( read_enable_rise[i_tap_sm] ),
            .rd_data_valid_r ( read_enable_rise_r[i_tap_sm] ),             
      			
            .dq_dly_rst      ( data_idelay_rst[2*i_tap_sm+1] ),
            .dq_dly_ce       ( data_idelay_ce[2*i_tap_sm+1] ),
            .dq_dly_inc      ( data_idelay_inc[2*i_tap_sm+1] ),
            .qk_dly_rst      ( qk_idelay_rst[2*i_tap_sm+1] ),
            .qk_dly_ce       ( qk_idelay_ce[2*i_tap_sm+1] ),
            .qk_dly_inc      ( qk_idelay_inc[2*i_tap_sm+1] ),
            
            .first_cal_done  ( first_cal_done[2*i_tap_sm+1] ),
            .dly_cal_done    ( data_tap_select[2*i_tap_sm+1] ),
            .delay_select    ( delay_select[4*i_tap_sm+3:4*i_tap_sm+2] ),
      
            .QK_tap_count    ( QK_tap_count[(2*i_tap_sm+2)*6-1:(2*i_tap_sm+1)*6] ),
            .DQ_tap_count    ( DQ_tap_count[(2*i_tap_sm+2)*6-1:(2*i_tap_sm+1)*6] ),
            .test_cal        ( test_cal[(2*i_tap_sm+2)*128-1:(2*i_tap_sm+1)*128] )           // debug signal
         );
      end
   endgenerate


endmodule
