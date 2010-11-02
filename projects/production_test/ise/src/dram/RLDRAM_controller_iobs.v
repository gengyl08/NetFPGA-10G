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
// Copyright (c) 2006-2008 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: rld_controller_iobs.v
//  /   /         Timestamp: 14 March 2008
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:	 Virtex-4 and Virtex-5
//	Purpose: This module holds the control physical layer that interfaces
//		with the memory pins: A, BA, WE#, REF# and CS#.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Added IOB=TRUE to more of the control signals
//*****************************************************************************

`timescale 1ns/100ps

module  rld_controller_iobs  (
   clk,
   clk90,
   sync_sysReset,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   
   phy_a,        // A  (address)
   phy_ba,       // BA (bank address)
   phy_cs_n,     // CS#
   phy_we_n,     // WE#
   phy_ref_n,    // REF#

   ctl_Cmd,
   ctl_Ad,
   ctl_Ba,

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

   input                      clk;
   input                      clk90;
   input                      sync_sysReset;
   input                      rstHard;
   input                      rstHard_90;
   input                      rstHard_180;
   input                      rstHard_270;

(* IOSTANDARD = "HSTL_II_18" *) output [DEV_AD_WIDTH-1:0]  phy_a;
(* IOB = "TRUE" *)              reg    [DEV_AD_WIDTH-1:0]  phy_a;
(* IOSTANDARD = "HSTL_II_18" *) output [DEV_BA_WIDTH-1:0]  phy_ba;
(* IOB = "TRUE" *)              reg    [DEV_BA_WIDTH-1:0]  phy_ba;
(* IOSTANDARD = "HSTL_II_18" *) output                     phy_we_n;
(* IOB = "TRUE" *)              reg                        phy_we_n;
(* IOSTANDARD = "HSTL_II_18" *) output                     phy_ref_n;
(* IOB = "TRUE" *)              reg                        phy_ref_n;
(* IOSTANDARD = "HSTL_II_18" *) output [NUM_OF_DEVS-1:0]   phy_cs_n;
(* IOB = "TRUE" *)              reg    [NUM_OF_DEVS-1:0]   phy_cs_n;

   input  [3:0]               ctl_Cmd;
   input  [DEV_AD_WIDTH-1:0]  ctl_Ad;
   input  [DEV_BA_WIDTH-1:0]  ctl_Ba;

   inout  [1023:0]            cs_io;


   reg    [3:0]               ctlCmd;
   reg    [DEV_AD_WIDTH-1:0]  ctlAd;
   reg    [DEV_BA_WIDTH-1:0]  ctlBa;

   // specific to Virtex-5
   reg    [DEV_BA_WIDTH-1:0]  ctlBa_d1;
   reg    [DEV_AD_WIDTH-1:0]  ctlAd_d1;
   reg    [3:0]               ctlCmd_d1;

   // specific to Virtex-4
   wire   [DEV_BA_WIDTH-1:0]  ctlBa_d7;
   reg    [DEV_BA_WIDTH-1:0]  ctlBa_d8;
   wire   [DEV_AD_WIDTH-1:0]  ctlAd_d7;
   reg    [DEV_AD_WIDTH-1:0]  ctlAd_d8;
   wire   [3:0]               ctlCmd_d7;
   reg    [3:0]               ctlCmd_d8;
   wire   [NUM_OF_DEVS-1:0]   phy_cs_dup;

   // test points
   reg                        TEST_CS_N;
   reg                        TEST_REF_N;
   reg                        TEST_WE_N;
   reg    [DEV_BA_WIDTH-1:0]  TEST_BA;

   wire   clk180;
   wire   clk270;

   wire  bit_0 = 1'b0;  // constants
   wire  bit_1 = 1'b1;  


   assign clk180 = ~clk;
   assign clk270 = ~clk90;


   // -----------------------------------------------------------------------------
   // Bank Address (BA) bits
   // -----------------------------------------------------------------------------
   genvar i_ba;

   generate
if ( DEVICE_ARCH == 2'b01 )  begin : ba_virtex5_insts
         always @( posedge clk )
         begin : Ba_fd
            ctlBa    <= ctl_Ba;
            ctlBa_d1 <= ctlBa;
            TEST_BA  <= ctlBa_d1;  // TEST probe for RC_BA[2:0] output signals
         end

         always @( posedge clk180 )
         begin : Ba_phy_fd
            if ( rstHard_180 )
               phy_ba <= {DEV_BA_WIDTH{1'b0}};
            else
               phy_ba <= ctlBa_d1;
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // Address (A) bits
   // -----------------------------------------------------------------------------
   genvar i_ad;

   generate
if ( DEVICE_ARCH == 2'b01 )  begin : ad_virtex5_insts
         always @( posedge clk )
         begin : Ad_fd
            ctlAd    <= ctl_Ad;
            ctlAd_d1 <= ctlAd;
         end

         always @( posedge clk180 )
         begin : Ad_phy_fd
            if ( rstHard_180 )
               phy_a <= {DEV_AD_WIDTH{1'b0}};
            else
               phy_a <= ctlAd_d1;
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // Signal "ctl_Cmd" holds control bits for CS#, WE# and REF#
   //    ctl_Cmd[3] : CS#
   //    ctl_Cmd[2] : <unused>  (was AS#)
   //    ctl_Cmd[1] : WE#
   //    ctl_Cmd[0] : REF#
   // -----------------------------------------------------------------------------

   // -----------------------------------------------------------------------------
   // CS chip select (control)
   // -----------------------------------------------------------------------------
   genvar i_cs;

   generate
if ( DEVICE_ARCH == 2'b01 )  begin : cs_virtex5_insts
         always @( posedge clk )
         begin : Cmd3_fd
            ctlCmd[3]    <= ctl_Cmd[3];
            ctlCmd_d1[3] <= ctlCmd[3];
            TEST_CS_N    <= ctlCmd_d1[3];  // TEST probe for RC_CS_N output signal
         end  

         always @( posedge clk180 or posedge sync_sysReset )  // D-flop, async preset
         begin : Cs_phy_fd
            if ( sync_sysReset )
               phy_cs_n <= {NUM_OF_DEVS{1'b1}};
            else
               phy_cs_n <= {NUM_OF_DEVS{ctlCmd_d1[3]}};  // duplicate ctl_Cmd[3]
         end 
         
//         for (i_cs = 0; i_cs < NUM_OF_DEVS; i_cs = i_cs + 1)  begin : cs_bit_insts
//            (* IOB = "TRUE" *)
//            FDPE  Cs_phy_fd  (
//               .C   ( clk180 ),
//               .PRE ( sync_sysReset ),
//               .CE  ( 1'b1 ),
//               .D   ( ctlCmd_d1[3] ),  // duplicate ctl_Cmd[3]
//               .Q   ( phy_cs_n[i_cs] )
//            );
//         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // ctl_Cmd[2] is unused
   // -----------------------------------------------------------------------------
   always @( posedge clk )
      ctlCmd_d1[2] <= 1'b0;


   // -----------------------------------------------------------------------------
   // WE read/write command
   // -----------------------------------------------------------------------------
   genvar i_we;

   generate
 if ( DEVICE_ARCH == 2'b01 )  begin : we_virtex5_insts
         always @( posedge clk )
         begin : We_fd
            ctlCmd[1]    <= ctl_Cmd[1];
            ctlCmd_d1[1] <= ctlCmd[1];
            TEST_WE_N    <= ctlCmd_d1[1];  // TEST probe for RC_WE_N output signal
         end

         always @( posedge clk180 or posedge sync_sysReset )  // D-flop, async preset
         begin : We_phy_fd
            if ( sync_sysReset )
               phy_we_n <= 1'b1;
            else
               phy_we_n <= ctlCmd_d1[1];
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // REF refresh command
   // -----------------------------------------------------------------------------
   genvar i_ref;

   generate
 if ( DEVICE_ARCH == 2'b01 )  begin : ref_virtex5_insts
         always @( posedge clk )
         begin : Ref_fd
            ctlCmd[0]    <= ctl_Cmd[0];
            ctlCmd_d1[0] <= ctlCmd[0];
            TEST_REF_N   <= ctlCmd_d1[0];  // TEST probe for RC_REF_N output signal
         end

         always @( posedge clk180 or posedge sync_sysReset )  // D-flop, async preset
         begin : Ref_phy_fd
            if ( sync_sysReset )
               phy_ref_n <= 1'b1;
            else
               phy_ref_n <= ctlCmd_d1[0];
         end
      end
   endgenerate


   // -----------------------------------------------------------------------------
   // Assign chipscope probes
   // -----------------------------------------------------------------------------
   generate
if ( DEVICE_ARCH == 2'b01 )  begin : cs_CTL_virtex5_probes
         // chipscope PHY related signals
         assign cs_io[93]       = TEST_CS_N;     // CS
         assign cs_io[94]       = TEST_WE_N;     // WE
         assign cs_io[95]       = TEST_REF_N;    // REF
         assign cs_io[98:96]    = TEST_BA;
         assign cs_io[99]       = 1'b0;
      end
   endgenerate


endmodule
