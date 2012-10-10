/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_rld_if.v
 *
 *  Library:
 *        
 *
 *  Module:
 *        nf10_rld_if
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        nf10 rldram controller
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 *        This module was developed by SRI International and the University of
 *        Cambridge Computer Laboratory under DARPA/AFRL contract (FA8750-11-C-0249)
 *        ("MRC2"), as part of the DARPA MRC research programme.
 *
 */

`timescale 1ns/100ps

module nf10_rld_if  (
   // refClk,
   sysClk_p,
   sysClk_n,
   sysRst_n,
   
   // RLD2 memory signals
   RLD2_CK_P,
   RLD2_CK_N,
   RLD2_DK_P,
   RLD2_DK_N,
   RLD2_QK_P,
   RLD2_QK_N,
   RLD2_A,
   RLD2_BA,
   RLD2_CS_N,
   RLD2_WE_N,
   RLD2_REF_N,
   RLD2_DM,
   RLD2_DQ,
   RLD2_QVLD
);

// public parameters -- adjustable
parameter SIMULATION_ONLY = 1'b0;  // if set (1'b1), it shortens the wait time
//
parameter RL_DQ_WIDTH     = 72;
parameter DEV_DQ_WIDTH    = 36;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
//
parameter RL_CK_PERIOD  = 16'd3003;  // CK clock period of the RLDRAM in ps
// MRS (Mode Register Set command) parameters   
//    please check Micron RLDRAM-II datasheet for definitions of these parameters
parameter RL_MRS_CONF            = 3'b011; // 3'b001: mode1;  3'b010: mode2;  3'b011: mode3
parameter RL_MRS_BURST_LENGTH    = 2'b01;  // 2'b00: BL2;  2'b01: BL4;  2'b10: BL8 (BL8 unsupported)
parameter RL_MRS_ADDR_MUX        = 1'b0;   // 1'b0: non-muxed addr;  1'b1: muxed addr
parameter RL_MRS_DLL_RESET       = 1'b1;   // 1'b0: Memory DLL reset; 1'b1: Memory DLL enabled
parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;   // 1'b0: internal 50ohms output buffer impedance, 1'b1: external 
parameter RL_MRS_ODT             = 1'b0;   // 1'b0: disable term;  1'b1: enable term
//
// specific to FPGA/memory devices and capture method
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b01;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b01;    // Direct Clocking=2'b00  SerDes=2'b01
parameter CAL_ADDRESS    = {DEV_AD_WIDTH{1'b0}}; //saved location to perform calibration
// end of public parameters

   // System signals and debug
   // input            refClk;
   input            sysClk_p;
   input            sysClk_n;
   input			sysRst_n;
   
   // RLD2 memory signals
   output [NUM_OF_DEVS-1:0]    RLD2_CK_P;
   output [NUM_OF_DEVS-1:0]    RLD2_CK_N;
   output [NUM_OF_DKS-1:0]     RLD2_DK_P;
   output [NUM_OF_DKS-1:0]     RLD2_DK_N;
   input  [2*NUM_OF_DEVS-1:0]  RLD2_QK_P;
   input  [2*NUM_OF_DEVS-1:0]  RLD2_QK_N;
   output [DEV_AD_WIDTH-1:0]   RLD2_A;
   output [DEV_BA_WIDTH-1:0]   RLD2_BA;
   output [NUM_OF_DEVS-1:0]    RLD2_CS_N;
   output                      RLD2_WE_N;
   output                      RLD2_REF_N;
   output [NUM_OF_DEVS-1:0]    RLD2_DM;
   inout  [RL_DQ_WIDTH-1:0]    RLD2_DQ;
   input  [NUM_OF_DEVS-1:0]    RLD2_QVLD;
      
   
   reg                         sysReset_n = 0;
   wire                        refClk0; // 200 MHz
   wire                        sysClk0;
   
   wire                        dcmlocked;
   wire                        sysClk_bufg;
   wire                        clk0_bufg_in;
   wire                        clk250_bufg_in;
   wire                        clk0_bufg_out;
   (* KEEP = "TRUE" *) wire    clk250_bufg_out;
   
   always @ (posedge sysClk_bufg) sysReset_n <= sysRst_n;

   // -----------------------------------------------------------------------------
   // instantiate one DCM
   // -----------------------------------------------------------------------------
   IBUFGDS clk250_ibufgds ( .O ( sysClk_bufg ), .I ( sysClk_p ), .IB ( sysClk_n ) );
   
   DCM_BASE  #(
      .DLL_FREQUENCY_MODE    ( "HIGH" ),
      .DUTY_CYCLE_CORRECTION ( "TRUE" ),
      .CLKDV_DIVIDE          ( 16.0 ),
      .FACTORY_JF            ( 16'hF0F0 ),
      .DFS_FREQUENCY_MODE    ( "LOW" ),
      .CLKFX_MULTIPLY        ( 5 ),
      .CLKFX_DIVIDE          ( 2 )
   )
   DCM_BASE0  (
      .CLK0     ( clk0_bufg_in ),
      .CLK180   ( ),
      .CLK270   ( ),
      .CLK2X    ( ),
      .CLK2X180 ( ),
      .CLK90    ( ),
      .CLKDV    ( ),
      .CLKFX    ( clk250_bufg_in ),
      .CLKFX180 ( ),
      .LOCKED   ( dcmlocked ),
      .CLKFB    ( clk0_bufg_out ),
      .CLKIN    ( sysClk_bufg ), 
      .RST      ( ~sysReset_n )
   );

   BUFG  dcm_clk0     ( .O( clk0_bufg_out ),    .I( clk0_bufg_in ) );
   BUFG  dcm_clk200   ( .O( clk250_bufg_out ),  .I( clk250_bufg_in ) );

   assign sysClk0 = clk250_bufg_out;
   assign refClk0 = clk250_bufg_out;

   // RLDRAM-2 Controller and User Application			     
   rld_mem_interface_top  #(
      .SIMULATION_ONLY    ( SIMULATION_ONLY ),     // if set, it shortens the wait time
      .RL_DQ_WIDTH        ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH       ( DEV_DQ_WIDTH ),        // data width of the memory device
      .DEV_AD_WIDTH       ( DEV_AD_WIDTH ),        // address width of the memory device
      .DEV_BA_WIDTH       ( DEV_BA_WIDTH ),        // bank address width of the memory device
      .DUPLICATE_CONTROLS ( DUPLICATE_CONTROLS ),  // Duplicate the ports for A, BA, WE# and REF#
      .RL_CK_PERIOD         ( RL_CK_PERIOD ),      // CK clock period of the RLDRAM in ps
      // MRS (Mode Register Set command) parameters   
      .RL_MRS_CONF            ( RL_MRS_CONF ),             // 3'b001: mode1;  3'b010: mode2;  3'b011: mode3
      .RL_MRS_BURST_LENGTH    ( RL_MRS_BURST_LENGTH ),     // 2'b00: BL2;  2'b01: BL4;  2'b10: BL8
      .RL_MRS_ADDR_MUX        ( RL_MRS_ADDR_MUX ),         // 1'b0: non-muxed addr;  1'b1: muxed addr
      .RL_MRS_DLL_RESET       ( RL_MRS_DLL_RESET ),        //
      .RL_MRS_IMPEDANCE_MATCH ( RL_MRS_IMPEDANCE_MATCH ),  // internal 50ohms output buffer impedance
      .RL_MRS_ODT             ( RL_MRS_ODT ),              // 1'b0: disable term;  1'b1: enable term
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE     ( RL_IO_TYPE ),       // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
      .DEVICE_ARCH    ( DEVICE_ARCH ),      // Virtex4=2'b00  Virtex5=2'b01
      .CAPTURE_METHOD ( CAPTURE_METHOD ),    // Direct Clocking=2'b00  SerDes=2'b01
      .CAL_ADDRESS    ( CAL_ADDRESS )
   )
   rld_mem_interface_top0  (
      // globals
      .sysReset ( sysReset_n & dcmlocked ),
      .sysClk_p ( sysClk0  ),
      .refClk_p ( refClk0  ),
     
      // RLDRAM interface signals
      .RLD2_CK_P  ( RLD2_CK_P   ),
      .RLD2_CK_N  ( RLD2_CK_N ),      
      .RLD2_CS_N  ( RLD2_CS_N  ),
      .RLD2_REF_N ( RLD2_REF_N ),
      .RLD2_WE_N  ( RLD2_WE_N  ),      
      .RLD2_A     ( RLD2_A  ),
      .RLD2_BA    ( RLD2_BA ),
      .RLD2_DM    ( RLD2_DM ),      
      .RLD2_QK_P  ( RLD2_QK_P ),
      .RLD2_QK_N  ( RLD2_QK_N ),      
      .RLD2_DK_P  ( RLD2_DK_P ),
      .RLD2_DK_N  ( RLD2_DK_N ),      
      .RLD2_QVLD  ( RLD2_QVLD ),      
      .RLD2_DQ    ( RLD2_DQ )
   );
   
endmodule


