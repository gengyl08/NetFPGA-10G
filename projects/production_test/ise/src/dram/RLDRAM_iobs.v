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
//  \   \         Filename: rld_iobs.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module is the top level for the physical layer and  
//		instantiates the following modules: 
//		 * data_path_iobs
//		 * controller_iobs 
//		 * infrastructure_iobs
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_iobs  (
   clk,
   clk90,
   refClk,
   sync_sysReset,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,

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

   qk_idelay_inc,
   qk_idelay_ce,
   qk_idelay_rst,
   data_idelay_inc,
   data_idelay_ce,
   data_idelay_rst,
   qvld_idelay_inc,
   qvld_idelay_ce,
   qvld_idelay_rst,   

   wr_data_rise,
   wr_data_fall,
   wr_en_clk90,
   data_mask_rise,
   data_mask_fall,

   rd_data_rise,
   rd_data_fall,

   ctlCmd,
   ctlAd,
   ctlBa,

   read_enable_rise,
   read_enable_fall,

   // chipscope debug ports
   cs_io
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

   input                       clk;
   input                       clk90;
   input                       refClk;
   input                       sync_sysReset;
   input                       rstHard;
   input                       rstHard_90;
   input                       rstHard_180;
   input                       rstHard_270;

   output [NUM_OF_DEVS-1:0]    phy_ck_p;
   output [NUM_OF_DEVS-1:0]    phy_ck_n;
   output [NUM_OF_DKS-1:0]     phy_dk_p;
   output [NUM_OF_DKS-1:0]     phy_dk_n;
   input  [2*NUM_OF_DEVS-1:0]  phy_qk_p;
   input  [2*NUM_OF_DEVS-1:0]  phy_qk_n;
   output [DEV_AD_WIDTH-1:0]   phy_a;
   output [DEV_BA_WIDTH-1:0]   phy_ba;
   output [NUM_OF_DEVS-1:0]    phy_cs_n;
   output                      phy_we_n;
   output                      phy_ref_n;
   output [NUM_OF_DEVS-1:0]    phy_dm;
   inout  [RL_DQ_WIDTH-1:0]    phy_dq;
   input  [NUM_OF_DEVS-1:0]    phy_qvld;

   input  [2*NUM_OF_DEVS-1:0]  qk_idelay_inc;
   input  [2*NUM_OF_DEVS-1:0]  qk_idelay_ce;		
   input  [2*NUM_OF_DEVS-1:0]  qk_idelay_rst;
   input  [2*NUM_OF_DEVS-1:0]  data_idelay_inc;
   input  [2*NUM_OF_DEVS-1:0]  data_idelay_ce;
   input  [2*NUM_OF_DEVS-1:0]  data_idelay_rst;   
   input  [NUM_OF_DEVS-1:0]    qvld_idelay_inc;
   input  [NUM_OF_DEVS-1:0]    qvld_idelay_ce;
   input  [NUM_OF_DEVS-1:0]    qvld_idelay_rst;   

   input  [RL_DQ_WIDTH-1:0]    wr_data_rise;
   input  [RL_DQ_WIDTH-1:0]    wr_data_fall;
   input  [NUM_OF_DEVS-1:0]    wr_en_clk90;
   input  [NUM_OF_DEVS-1:0]    data_mask_rise;
   input  [NUM_OF_DEVS-1:0]    data_mask_fall;

   output [RL_DQ_WIDTH-1:0]    rd_data_rise;
   output [RL_DQ_WIDTH-1:0]    rd_data_fall;

   input  [3:0]                ctlCmd;
   input  [DEV_AD_WIDTH-1:0]   ctlAd;
   input  [DEV_BA_WIDTH-1:0]   ctlBa;

   output [NUM_OF_DEVS-1:0]    read_enable_rise;
   output [NUM_OF_DEVS-1:0]    read_enable_fall;


   inout  [1023:0]             cs_io;

   wire   clk180;
   wire   clk270;


   assign clk180 = ~clk;
   assign clk270 = ~clk90;


   // -----------------------------------------------------------------------------
   // rld_controller_iobs
   // Holds the memory control physical layer: A, BA, WE#, REF# and CS#
   // -----------------------------------------------------------------------------
   rld_controller_iobs  #(
      .RL_DQ_WIDTH    ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH   ( DEV_DQ_WIDTH ),
      .DEV_AD_WIDTH   ( DEV_AD_WIDTH ),
      .DEV_BA_WIDTH   ( DEV_BA_WIDTH ),
      .DUPLICATE_CONTROLS ( DUPLICATE_CONTROLS ),
      .RL_IO_TYPE     ( RL_IO_TYPE ),
      .DEVICE_ARCH    ( DEVICE_ARCH ),
      .CAPTURE_METHOD ( CAPTURE_METHOD )
   )
   controller_iobs0  (
      .clk           ( clk ),
      .clk90         ( clk90 ),
      .sync_sysReset ( sync_sysReset ),
      .rstHard       ( rstHard ),
      .rstHard_90    ( rstHard_90 ),
      .rstHard_180   ( rstHard_180 ),
      .rstHard_270   ( rstHard_270 ),

      .phy_a         ( phy_a ),      // A  (address)
      .phy_ba        ( phy_ba ),     // BA (bank address)
      .phy_cs_n      ( phy_cs_n ),   // CS#
      .phy_we_n      ( phy_we_n ),   // WE#
      .phy_ref_n     ( phy_ref_n ),  // REF#

      .ctl_Cmd       ( ctlCmd ),
      .ctl_Ad        ( ctlAd ),
      .ctl_Ba        ( ctlBa ),

      .cs_io         ( cs_io )
   );


   // -----------------------------------------------------------------------------
   // rld_data_path_iobs
   // Instantiates iob modules for QK, DQ, QVLD and DM
   // -----------------------------------------------------------------------------
   rld_data_path_iobs  #(
      .RL_DQ_WIDTH    ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH   ( DEV_DQ_WIDTH ),
      .RL_IO_TYPE     ( RL_IO_TYPE ),
      .DEVICE_ARCH    ( DEVICE_ARCH ),
      .CAPTURE_METHOD ( CAPTURE_METHOD )
   )
   data_path_iobs0  (
      .clk              ( clk ),
      .clk90            ( clk90 ),
      .refClk           ( refClk ),
      .rstHard          ( rstHard ),
      .rstHard_90       ( rstHard_90 ),
      .rstHard_180      ( rstHard_180 ),
      .rstHard_270      ( rstHard_270 ),
   
      .phy_qk_p         ( phy_qk_p ),  // QK, read data clock
      .phy_qk_n         ( phy_qk_n ),  // QK#
      .phy_dm           ( phy_dm ),    // DM
      .phy_dq           ( phy_dq ),    // DQ, read and write data bus
      .phy_qvld         ( phy_qvld ),  // QVLD

      .qk_idelay_inc    ( qk_idelay_inc ),    // IDELAY controls for QK (read clock)
      .qk_idelay_ce     ( qk_idelay_ce ),
      .qk_idelay_rst    ( qk_idelay_rst ),
      .data_idelay_inc  ( data_idelay_inc ),  // IDELAY controls for DQ (read data)
      .data_idelay_ce   ( data_idelay_ce ),
      .data_idelay_rst  ( data_idelay_rst ),
      .qvld_idelay_inc  ( qvld_idelay_inc ),  // IDELAY controls for QVLD (read enable)
      .qvld_idelay_ce   ( qvld_idelay_ce ),
      .qvld_idelay_rst  ( qvld_idelay_rst ),
   
      .wr_data_rise     ( wr_data_rise),
      .wr_data_fall     ( wr_data_fall),
      .wr_en_clk90      ( wr_en_clk90),
      .data_mask_rise   ( data_mask_rise ),
      .data_mask_fall   ( data_mask_fall ),

      .rd_data_rise     ( rd_data_rise ),
      .rd_data_fall     ( rd_data_fall ),   

      .read_enable_rise ( read_enable_rise ),
      .read_enable_fall ( read_enable_fall )
   );


   // -----------------------------------------------------------------------------
   // rld_infrastructure_iobs
   // Generates data clock (DK) and address/command clock (CK) for memory physical layer
   // -----------------------------------------------------------------------------
   rld_infrastructure_iobs  #(
      .RL_DQ_WIDTH  ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH ( DEV_DQ_WIDTH )
   )
   infrastructure_iobs0  ( 
      .clk       ( clk ),
      .clk90     ( clk90 ),

      .phy_dk_p  ( phy_dk_p ),
      .phy_dk_n  ( phy_dk_n ),
      .phy_ck_p  ( phy_ck_p ),
      .phy_ck_n  ( phy_ck_n )
   );


endmodule
