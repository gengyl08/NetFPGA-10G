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
//  \   \         Filename: rld_data_path_iobs.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module instantiates the iob modules for QK, DQ, QVLD and DM
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_data_path_iobs  (
   clk,
   clk90,
   refClk,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,

   phy_qk_p,    // QK, read data clock
   phy_qk_n,    // QK#
   phy_dm,      // DM
   phy_dq,      // DQ, read and write data bus
   phy_qvld,    // QVLD

   qk_idelay_inc,    // IDELAY controls for QK (read clock)
   qk_idelay_ce,
   qk_idelay_rst,
   data_idelay_inc,  // IDELAY controls for DQ (read data)
   data_idelay_ce, 
   data_idelay_rst,
   qvld_idelay_inc,  // IDELAY controls for QVLD (read enable)
   qvld_idelay_ce,
   qvld_idelay_rst,

   wr_data_rise,
   wr_data_fall,
   wr_en_clk90,
   data_mask_rise,
   data_mask_fall,

   rd_data_rise,
   rd_data_fall,

   read_enable_rise,
   read_enable_fall
);

// parameter definitions
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter DEV_BYTE_WIDTH  = 9;                         // the width of a "byte" on the memory device (x8 or x9)
parameter QK_DATA_WIDTH   = (DEV_DQ_WIDTH == 9)  ?  DEV_DQ_WIDTH : DEV_DQ_WIDTH/2;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
//
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of parameter definitions

   input                        clk;
   input                        clk90;
   input                        refClk;
   input                        rstHard;
   input                        rstHard_90;
   input                        rstHard_180;
   input                        rstHard_270;

   input  [2*NUM_OF_DEVS-1:0]   phy_qk_p;
   input  [2*NUM_OF_DEVS-1:0]   phy_qk_n;
   output [NUM_OF_DEVS-1:0]     phy_dm;
   inout  [RL_DQ_WIDTH-1:0]     phy_dq;
   input  [NUM_OF_DEVS-1:0]     phy_qvld;

   input  [2*NUM_OF_DEVS-1:0]   qk_idelay_inc;
   input  [2*NUM_OF_DEVS-1:0]   qk_idelay_ce;		
   input  [2*NUM_OF_DEVS-1:0]   qk_idelay_rst;
   input  [2*NUM_OF_DEVS-1:0]   data_idelay_inc;
   input  [2*NUM_OF_DEVS-1:0]   data_idelay_ce;
   input  [2*NUM_OF_DEVS-1:0]   data_idelay_rst;
   input  [NUM_OF_DEVS-1:0]     qvld_idelay_inc;
   input  [NUM_OF_DEVS-1:0]     qvld_idelay_ce;
   input  [NUM_OF_DEVS-1:0]     qvld_idelay_rst;

   input  [RL_DQ_WIDTH-1:0]     wr_data_rise;
   input  [RL_DQ_WIDTH-1:0]     wr_data_fall;
   input  [NUM_OF_DEVS-1:0]     wr_en_clk90;
   input  [NUM_OF_DEVS-1:0]     data_mask_rise;
   input  [NUM_OF_DEVS-1:0]     data_mask_fall;

   output [RL_DQ_WIDTH-1:0]     rd_data_rise;
   output [RL_DQ_WIDTH-1:0]     rd_data_fall;

   output [NUM_OF_DEVS-1:0]     read_enable_rise;
   output [NUM_OF_DEVS-1:0]     read_enable_fall;


   // Virtex-4 specific
   wire   [2*NUM_OF_DEVS-1:0]   qk_delayed, qk_delayed_unused;
   wire [2*NUM_OF_DEVS-1:0]     rising_first;
   wire [2*NUM_OF_DEVS-1:0]     qvld_delayed_rise, qvld_delayed_fall;
   // Virtex-5 specific
   wire   [2*NUM_OF_DEVS-1:0]   qk_bufio;

   wire   clk180;
   wire   clk270;

   wire   bit_0 = 1'b0;  // constant
   wire   bit_1 = 1'b1;
   wire   vcc   = 1'b1;
   wire   gnd   = 1'b0;


   assign clk180 = ~clk;
   assign clk270 = ~clk90;


   // -----------------------------------------------------------------------------
   // Generate QK/QK_N instances
   //   Data capture is done with the system clock (clk)
   //   Tap calibration runs with the reference clock (refClk)
   // -----------------------------------------------------------------------------
   genvar i_qk;

   generate
 if ( DEVICE_ARCH == 2'b01 )  begin : qk_virtex5_insts
         for ( i_qk = 0; i_qk < 2*NUM_OF_DEVS; i_qk = i_qk + 1)  begin: qk_bit_insts
            rld_v5_qk_iob  qk  (
               .clk270        ( clk270 ),
               .dlyinc        ( qk_idelay_inc[i_qk] ),
               .dlyrst        ( qk_idelay_rst[i_qk] ),
               .dlyce         ( qk_idelay_ce[i_qk] ),
               .phy_qk_p      ( phy_qk_p[i_qk] ),
               .phy_qk_n      ( phy_qk_n[i_qk] ),
               .phy_qk_bufio  ( qk_bufio[i_qk] )  // connect to DQ IOBs
            );
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // DQ instances
   // -----------------------------------------------------------------------------
   genvar i_dq;
   genvar j_dq;

   generate
if ( DEVICE_ARCH == 2'b01 )  begin : dq_virtex5_insts
         for ( i_dq = 0; i_dq < RL_DQ_WIDTH; i_dq = i_dq + 1)  begin:  dq_bit_insts 
            if (i_dq % DEV_BYTE_WIDTH != 8) begin //James: Ignore the 9th bit
            rld_v5_dq_iob  dq  (
               .clk270          ( clk270 ),
               .bufio_clk       ( qk_bufio[(i_dq/QK_DATA_WIDTH)] ),
               .reset           ( rstHard_270 ),
               .dlyinc          ( data_idelay_inc[(i_dq/QK_DATA_WIDTH)] ),
               .dlyce           ( data_idelay_ce[(i_dq/QK_DATA_WIDTH)] ),
               .dlyrst          ( data_idelay_rst[(i_dq/QK_DATA_WIDTH)] ),
               .write_data_rise ( wr_data_rise[i_dq] ),
               .write_data_fall ( wr_data_fall[i_dq] ),
               .ctrl_wren       ( wr_en_clk90[(i_dq/DEV_DQ_WIDTH)] ),
               .phy_dq          ( phy_dq[i_dq] ),
               .read_data_rise  ( rd_data_rise[i_dq] ),
               .read_data_fall  ( rd_data_fall[i_dq] )
            );
	    end
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // QVLD used for data read enable
   //   - "data valid" input, captured similarly as read data DQ
   //   - For x9 device, QVLD for byte 0 is physically near QK0/QK0#
   //   - For x18 & x36 devices, QVLD for byte 0 and 1 is physically near QK0/QK0#
   //
   //   QVLD "enable"  is produced by falling edge QK/QK# "before" the data DQ
   //   QVLD "disable" is produced by falling edge QK/QK# "before" the data DQ
   // -----------------------------------------------------------------------------
   genvar i_qvld;

   generate
if ( DEVICE_ARCH == 2'b01 )  begin : qvld_virtex5_insts
         for (i_qvld = 0; i_qvld < NUM_OF_DEVS; i_qvld = i_qvld + 1)  begin : qvld_b_insts
            rld_qvld_iob  #(
               .RL_IO_TYPE     ( RL_IO_TYPE ),
               .DEVICE_ARCH    ( DEVICE_ARCH ),
               .CAPTURE_METHOD ( CAPTURE_METHOD )
            )
            qvld_b  (
               .clk                     ( ),   
               .refClk                  ( ),
               .clk270                  ( clk270 ),
               .bufio_clk               ( qk_bufio[i_qvld*2]),  //want to use 0 or 2 for Bufio clock
               .reset                   ( rstHard_270 ),
               //.dlyinc                  ( qvld_idelay_inc[i_qvld] ),
               //.dlyce                   ( qvld_idelay_ce[i_qvld] ),
               //.dlyrst                  ( qvld_idelay_rst[i_qvld] ),
               .dlyinc                  ( data_idelay_inc[i_qvld*2] ),
               .dlyce                   ( data_idelay_ce[i_qvld*2] ),
               .dlyrst                  ( data_idelay_rst[i_qvld*2] ),
               .phy_qvld                ( phy_qvld[i_qvld] ),
               .first_rising_byte0      (  ),     
               .qvld_delayed_rise_byte0 (  ),
               .qvld_delayed_fall_byte0 (  ),
               .first_rising_byte1      (  ),    
               .qvld_delayed_rise_byte1 (  ),
               .qvld_delayed_fall_byte1 (  ),
               .read_enable_rise        ( read_enable_rise[i_qvld] ),
               .read_enable_fall        ( read_enable_fall[i_qvld] )
            );
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // DM instances
   // -----------------------------------------------------------------------------
   genvar i_dm;
   
   generate
 if ( DEVICE_ARCH == 2'b01 )  begin : dm_virtex5_insts
         for (i_dm = 0; i_dm < NUM_OF_DEVS; i_dm = i_dm + 1)  begin : dm_bit_insts
            rld_v5_dm_iob  dm  (
               .clk270         ( clk270 ),
               .reset          ( rstHard_270 ),
               .mask_data_rise ( data_mask_rise[i_dm] ),
               .mask_data_fall ( data_mask_fall[i_dm] ),
               .phy_dm         ( phy_dm[i_dm] )
            );
         end
      end
   endgenerate


endmodule
