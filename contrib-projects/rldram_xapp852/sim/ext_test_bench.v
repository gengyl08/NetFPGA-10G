/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        ext_test_bench.v
 *
 *  Library:
 *        
 *
 *  Module:
 *        ext_test_bench
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        Testbench of nf10_rld_if
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

`timescale 1ns/1ps

`define BOARD_SKEW #0.500 // put a 500 ps delay on the QK lines between FPGA and RAMs 

module  ext_test_bench  ();

// parameter definitions
   parameter SIMULATION_ONLY = 1'b1;  // if set (1'b1), it shortens the wait time but Micron model requires that time
   //
   parameter RL_DQ_WIDTH     = 72;
   parameter DEV_DQ_WIDTH    = 36;  // data width of the memory device
   parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
   parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
   parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
   parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
   parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
   parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
   parameter RL_CK_PERIOD  = 16'd3003;     // CK clock period of the RLDRAM in ps
   // MRS (Mode Register Set command) parameters   
   parameter RL_MRS_CONF            = 3'b011;  // Config3   // Config1=3'b001  Config2=3'b010  Config3=3'b011
   parameter RL_MRS_BURST_LENGTH    = 2'b01;   // BL4       // BL2=2'b00  BL4=2'b01  BL8=2'b10 (BL8 unsupported)
   parameter RL_MRS_ADDR_MUX        = 1'b0;    // non-mux   // non-mux address (default)=1'b0;  multiplexed address=1'b1
   parameter RL_MRS_DLL_RESET       = 1'b1;    // 1'b0: DLL reset, 1'b1: DLL enabled
   parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;    // 1'b0: internal 50ohms output buffer impedance, 1'b1: external 
   parameter RL_MRS_ODT             = 1'b0;    // 1'b0: disable term;  1'b1: enable term
   // specific to FPGA/memory devices and capture method
   parameter RL_IO_TYPE     = 2'b00;    // CIO  // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
   parameter DEVICE_ARCH    = 2'b01;    // V5   // Virtex4=2'b00  Virtex5=2'b01
   parameter CAPTURE_METHOD = 2'b01;    // SerDes   // Direct Clocking=2'b00  SerDes=2'b01
   parameter CAL_ADDRESS    = {DEV_AD_WIDTH{1'b0}}; //saved location to perform calibration


  reg 		RESET;
  reg 		intClk;
  wire      CLK;

  wire [1:0]  RC_CK;
  wire [1:0]  RC_CK_N;
  wire [1:0]	RC_CS_N;
  wire 	  		RC_REF_N;
  wire 	  		RC_WE_N;
  wire [DEV_AD_WIDTH-1:0] 	RC_A;
  wire [DEV_BA_WIDTH-1:0] 	RC_BA;
  wire [1:0] 	RC_DM;
  wire [3:0]	RL_QK;
  wire [3:0] 	RL_QK_N;
  wire [1:0]	RL_QVLD;
  wire [RL_DQ_WIDTH-1:0] 	DQ;

  wire [NUM_OF_DKS-1:0]  RC_DK;
  wire [NUM_OF_DKS-1:0]  RC_DK_N;
  wire [3:0] 	bRL_QK;
  wire [3:0] 	bRL_QK_N;
	
  assign 	  CLK     = intClk;

  assign 	  `BOARD_SKEW RL_QK[3:0]   = bRL_QK[3:0];
  assign 	  `BOARD_SKEW RL_QK_N[3:0] = bRL_QK_N[3:0];

   // Generate system clock
   initial intClk = 0;
   always begin
    //#1.250 intClk = ~intClk;    //400MHz
    //#1.429 intClk = ~intClk;    //350MHz
    //#1.501 intClk = ~intClk;    //333MHz
    //#1.667 intClk = ~intClk;    //300MHz
    //#2.000 intClk = ~intClk;    //250MHz
    //#2.500 intClk = ~intClk;    //200MHz
    //#3.333 intClk = ~intClk;    //150MHz
	#5.000 intClk = ~intClk;    //100MHz
   end

   // Generate Reset
   initial begin
      RESET = 0;          // reset on board is active low
      #1000 RESET = 1; 
   end

// =============================================================================
// V5 implementation
// =============================================================================

// RLDRAM-2 Controller and User Application			     
  nf10_rld_if  #(
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
   rld_if_top0  (
      // globals
      .sysRst_n ( RESET   ),
      .sysClk_p ( CLK     ),
      .sysClk_n ( ~CLK    ),
     
      // RLDRAM interface signals
      .RLD2_CK_P  ( RC_CK   ),
      .RLD2_CK_N  ( RC_CK_N ),      
      .RLD2_CS_N  ( RC_CS_N  ),
      .RLD2_REF_N ( RC_REF_N ),
      .RLD2_WE_N  ( RC_WE_N  ),      
      .RLD2_A     ( RC_A  ),
      .RLD2_BA    ( RC_BA ),
      .RLD2_DM    ( RC_DM ),      
      .RLD2_QK_P  ( RL_QK   ),
      .RLD2_QK_N  ( RL_QK_N ),      
      .RLD2_DK_P  ( RC_DK   ),
      .RLD2_DK_N  ( RC_DK_N ),      
      .RLD2_QVLD  ( RL_QVLD ),      
      .RLD2_DQ    ( DQ )
);

		  
// RLDRAM-II memory models
// needs to be downloaded from Micron's website (not included in XAPP852)	
rldram2 ram0 (
    .ck     ( RC_CK[0] ),
    .ck_n   ( RC_CK_N[0] ),
    .cs_n   ( RC_CS_N[0] ),
    .we_n   ( RC_WE_N ),
    .ref_n  ( RC_REF_N ),
    .ba     ( RC_BA[2:0] ),
    .a      ( RC_A[19:0] ),
    .dm     ( RC_DM[0] ),
    .dk     ( RC_DK[NUM_OF_DKS/2-1:0] ),
    .dk_n   ( RC_DK_N[NUM_OF_DKS/2-1:0] ),
    .dq     ( DQ[RL_DQ_WIDTH/2-1:0] ),
    .qk     ( bRL_QK[2*NUM_OF_DEVS/2-1:0] ),
    .qk_n   ( bRL_QK_N[2*NUM_OF_DEVS/2-1:0] ),
    .qvld   ( RL_QVLD[0] ),
// JTAG PORTS
    .tck    (1'b0),
    .tms    (1'b0),
    .tdi    (1'b0),
    .tdo    (  )
);
    
rldram2 ram1 (
    .ck     ( RC_CK[1] ),
    .ck_n   ( RC_CK_N[1] ),
    .cs_n   ( RC_CS_N[1] ),
    .we_n   ( RC_WE_N ),
    .ref_n  ( RC_REF_N ),
    .ba     ( RC_BA[2:0] ),
    .a      ( RC_A[19:0] ),
    .dm     ( RC_DM[1] ),
    .dk     ( RC_DK[NUM_OF_DKS-1:NUM_OF_DKS/2] ),
    .dk_n   ( RC_DK_N[NUM_OF_DKS-1:NUM_OF_DKS/2] ),
    .dq     ( DQ[RL_DQ_WIDTH-1:RL_DQ_WIDTH/2] ),
    .qk     ( bRL_QK[2*NUM_OF_DEVS-1:2*NUM_OF_DEVS/2] ),
    .qk_n   ( bRL_QK_N[2*NUM_OF_DEVS-1:2*NUM_OF_DEVS/2] ),
    .qvld   ( RL_QVLD[1] ),
// JTAG PORTS
    .tck    (1'b0),
    .tms    (1'b0),
    .tdi    (1'b0),
    .tdo    (  )
); 

endmodule
