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
//  \   \         Filename: rld_data_write.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module generates the write data and mask bits that go
//		to the Write Data Fifos.  
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_data_write  (
   clk,
   clk90,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,

   ctlIoWdEn,
   wdfDM,
   wdfD,
   wr_data_rise,
   wr_data_fall,
   wr_en_clk90,
   data_mask_rise,
   data_mask_fall
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
//
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters

   input                        clk;
   input                        clk90;
   input                        rstHard;
   input                        rstHard_90;
   input                        rstHard_180;
   input                        rstHard_270;

   input                        ctlIoWdEn;
   input [(2*NUM_OF_DEVS)-1:0]  wdfDM;
   input [(2*RL_DQ_WIDTH)-1:0]  wdfD;

   output [RL_DQ_WIDTH-1:0]     wr_data_rise;
   output [RL_DQ_WIDTH-1:0]     wr_data_fall;
   output [NUM_OF_DEVS-1:0]     wr_en_clk90;
   output [NUM_OF_DEVS-1:0]     data_mask_rise;
   output [NUM_OF_DEVS-1:0]     data_mask_fall;


   // internal wires
   //reg    ctlIoWdEn_d1;           
   //reg    ctlIoWdEn_d2;
(* syn_keep = "TRUE" *)(* syn_preserve = "TRUE" *)  reg  [NUM_OF_DEVS-1:0]       ctlIoWdEn_d;   

   wire  bit_0 = 1'b0;  // constants
   wire  bit_1 = 1'b1;  
   wire  vcc  = 1'b1;
   wire  gnd  = 1'b0;

   reg [RL_DQ_WIDTH-1:0]        wr_data_rise;
   reg [RL_DQ_WIDTH-1:0]        wr_data_fall;
   reg [NUM_OF_DEVS-1:0]        wr_en_clk90;
   reg [NUM_OF_DEVS-1:0]        data_mask_rise;
   reg [NUM_OF_DEVS-1:0]        data_mask_fall;

   wire  clk180 = ~clk;
   wire  clk270 = ~clk90;


   // -----------------------------------------------------------------------------
   // Adjust the "tri-state control for DQ" timings to match the "command" timings
   //    (a) one flop @clk to grab data from the controller (decoupling)
   //
   // The data_path module will transfer "tri-state control for DQ" from
   // rising CLK0 to "falling CLK90" clock domain
   // -----------------------------------------------------------------------------

   // add more flops here and see if it changes the routes
   /*always @( posedge clk )
   begin : delay_ctlIoWdEn_d1
      ctlIoWdEn_d1 <= ctlIoWdEn;
   end

   always @( posedge clk )
   begin : delay_ctlIoWdEn_d2
      ctlIoWdEn_d2 <= ctlIoWdEn;
   end */
   
   always @( posedge clk )
   begin : delay_ctlIoWdEn
      ctlIoWdEn_d <= {NUM_OF_DEVS{ctlIoWdEn}};
   end

   // -----------------------------------------------------------------------------
   // Change clock domain for "write data" DQ =============> "falling edge CLK90"
   // Change clock domain for "tri-state control" for DQ ==> "falling edge CLK90"
   //    This gives only 3/4 cycle from the previous flop clocked on clk,
   //    but gives a full CLK90 cycle for the OLOGIC DDR flops
   // align DQ and its tri-state control with respect to falling edge clk90
   // -----------------------------------------------------------------------------
   always @ ( posedge clk270 )
   begin
      if ( rstHard_270 == 1'b1 )
      begin
         wr_data_rise[RL_DQ_WIDTH-1:0] <= {RL_DQ_WIDTH{1'b0}};
         wr_data_fall[RL_DQ_WIDTH-1:0] <= {RL_DQ_WIDTH{1'b0}};
         //wr_en_clk90[0]   <= 1'b0;
         //wr_en_clk90[1]   <= 1'b0;
         wr_en_clk90                   <= {NUM_OF_DEVS{1'b0}};
      end
      else
      begin  
         wr_data_rise[RL_DQ_WIDTH-1:0] <= wdfD[(2*RL_DQ_WIDTH)-1:RL_DQ_WIDTH];  // first  DDR DQ to go out
         wr_data_fall[RL_DQ_WIDTH-1:0] <= wdfD[RL_DQ_WIDTH-1:0];                // second DDR DQ to go out
         //wr_en_clk90[0]   <= ctlIoWdEn_d1;                                      // DQ tri-state control
         //wr_en_clk90[1]   <= ctlIoWdEn_d2; 
         wr_en_clk90        <= ctlIoWdEn_d;                          // DQ tri-state control
      end
   end


   // align DM and its tri-state control with respect to falling edge clk90
   always @ ( posedge clk270 )
   begin
      if ( rstHard_270 == 1'b1 )
      begin
         data_mask_rise[NUM_OF_DEVS-1:0] <= {NUM_OF_DEVS{1'b0}};
         data_mask_fall[NUM_OF_DEVS-1:0] <= {NUM_OF_DEVS{1'b0}};
      end
      else
      begin
         data_mask_rise[NUM_OF_DEVS-1:0] <= wdfDM[(2*NUM_OF_DEVS)-1:NUM_OF_DEVS];  // first  DDR DM to go out
         data_mask_fall[NUM_OF_DEVS-1:0] <= wdfDM[NUM_OF_DEVS-1:0];              // second DDR DM to go out
      end
   end


endmodule
