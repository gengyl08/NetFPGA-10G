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
//  \   \         Filename: rld_conf.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module contains the user interface to the internal 
//		configuration registers.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - changed the clock frequency parameter to a clock period parameter
//
//  ** Features **
//  - Changed "`define" to "parameter", module can be instantiated
//    multiple times with different configurations
//  - Automatically calculate TRC, RD_LATENCY, and WR_LATENCY
//    based on the configuration setting
//  - Support of configuration 3
//
//  Register Map:
//  Addr    Mode   Description
//  4'h0    RW     apConfWrD[7:0] = Mode[7:0]  -- LSB
//  4'h1    RW     apConfWrD[3:0] = Read latency
//  4'h2    RW     apConfWrD[3:0] = Write latency
//  4'h3    RW     apConfWrD[7:0] = Refresh interval counter[7:0]
//  4'h4    RW     apConfWrD[3:0] = Refresh interval counter[11:8]
//  4'h5    RW     apConfWrD[7:0] = Refresh interval counter margin
//  4'h6    RW     apConfWrD[3:0] = tRC
//  4'h7    --     unused
//  4'h8    --     unused
//  4'h9    RW     apCOnfWrD[3:0] = burst length (valid values are 2, 4, 8)
//  4'ha    RW     apConfWrD[1:0] = Mode[9:8]  -- MSB
//  4'hb    RW     apConfWrD[0]   = Auto Refresh enable
//  4'hc    --     unused
//  4'hd    --     unused
//  4'he    --     unused
//  4'hf    --     unused
//
//
//  Definition of "MODE_DEF[17:0]", i.e. MRS, Mode Register Set
//   [17:10]     [9]               [8]                  [7]         [6]         [5]               [4:3]           [2:0]
//  RESERVED, RL_MRS_ODT, RL_MRS_IMPEDANCE_MATCH, RL_MRS_DLL_RESET, 1'b0, RL_MRS_ADDR_MUX, RL_MRS_BURST_LENGTH, RL_MRS_CONF
//
//  bit[17:10] RESERVED               (8'b0)
//  bit[9]     RL_MRS_ODT             (1'b0: disabled termination;  1'b1: enabled termination)
//  bit[8]     RL_MRS_IMPEDANCE_MATCH (1'b0: internal 50ohms output buffer impedance;  1'b1:use external resistor)
//  bit[7]     RL_MRS_DLL_RESET       (1'b0:DLL reset (default); 1'b1:DLL enabled)
//  bit[6]     ..static zero..        (1'b0)
//  bit[5]     RL_MRS_ADDR_MUX        (1'b0: non-muxed addr;  1'b1: muxed addr)
//  bit[4:3]   RL_MRS_BURST_LENGTH    (2'b00: BL2;  2'b01: BL4;  2'b10: BL8)
//  bit[2:0]   RL_MRS_CONF            (3'b001: mode1;  3'b010: mode2;  3'b011: mode3)
//
//*****************************************************************************

`timescale 1ns/100ps

// Configuration registers
module  rld_conf  (
   clk,
   rstHard,
   rstConfig,    // ...unused...

   apConfA,      // Address to access configuration registers
   apConfWr,     // Write enable to configuration registers
   apConfWrD,    // Configuration write data
   apConfRd,     // Read enable to configuration registers
   apConfRdD,    // Configuration read data

   confMReg,     // Mode Register Set (MRS)
   confRL,       // Read latency  
   confWL,       // Write latency 
   confRcCnt0,   // Refresh interval counter [7:0]
   confRcCnt1,   // Refresh interval counter [11:8]
   confRcMargin, // Refresh interval counter margin
   confTrc,      // tRC value
   confTrdWr,    // TrdWr value, unused...
   confTwrRd,    // TwrRd value, unused...
   confBL,       // burst length
   confCycRef    // control cyclic refresh (auto refresh enable)
);

// public parameters -- adjustable
parameter RL_CK_PERIOD  = 16'd3003;     // CK clock period of the RLDRAM in ps
// MRS (Mode Register Set command) parameters   
//    please check Micron RLDRAM-II datasheet for definitions of these parameters
parameter RL_MRS_CONF            = 3'b001; // 3'b001: mode1;  3'b010: mode2;  3'b011: mode3
parameter RL_MRS_BURST_LENGTH    = 2'b00;  // 2'b00: BL2;  2'b01: BL4;  2'b10: BL8
parameter RL_MRS_ADDR_MUX        = 1'b0;   // 1'b0: non-muxed addr;  1'b1: muxed addr
parameter RL_MRS_DLL_RESET       = 1'b0;   //
parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;   // internal 50ohms output buffer impedance
parameter RL_MRS_ODT             = 1'b0;   // 1'b0: disable term;  1'b1: enable term
//
// specific to FPGA/memory devices and capture method
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters
   
// private parameters -- do not modify
parameter RESERVED    = 8'h0;
parameter MODE_DEF    = {RESERVED, RL_MRS_ODT, RL_MRS_IMPEDANCE_MATCH, RL_MRS_DLL_RESET, 1'b0, RL_MRS_ADDR_MUX, RL_MRS_BURST_LENGTH, RL_MRS_CONF};
parameter CYC_REF     = 1'b1;

//parameter TRC         = (RL_MRS_CONF == 3'h1) ? 4'h4 : ((RL_MRS_CONF == 3'h2) ? 4'h6 : 4'h8);
//parameter RD_LATENCY  = (RL_MRS_CONF == 3'h1) ? 4'h4 : ((RL_MRS_CONF == 3'h2) ? 4'h6 : 4'h8);
//parameter WR_LATENCY  = (RL_MRS_CONF == 3'h1) ? 4'h5 : ((RL_MRS_CONF == 3'h2) ? 4'h7 : 4'h9);
parameter TRC         = 4'h8;
parameter RD_LATENCY  = 4'h8;
parameter WR_LATENCY  = 4'h9;

parameter BLEN        = (RL_MRS_BURST_LENGTH == 2'b00)  ? 4'h2 : 
                        ( (RL_MRS_BURST_LENGTH == 2'b01) ? 4'h4 : 4'h8 );
parameter AUTO_REF_CNT = 3880*1000/RL_CK_PERIOD;   // determine count for 3.880us minimum Refresh time, based on CK period in ps
parameter RCCNT0      = AUTO_REF_CNT[7:0];
parameter RCCNT1      = AUTO_REF_CNT[15:8];
parameter RCMGN       = 8'h20;
parameter TRW         = 3'b101;
parameter TWR         = 3'b101;
// end of private parameter

   input         clk;
   input         rstHard;
   input         rstConfig;

   input  [3:0]  apConfA;
   input         apConfWr;
   input  [7:0]  apConfWrD;
   input         apConfRd;
   output [7:0]  apConfRdD;
   
   output [17:0] confMReg;
   output [3:0]  confRL;
   output [3:0]  confWL;
   output [7:0]  confRcCnt0;
   output [7:0]  confRcCnt1;
   output [7:0]  confRcMargin;
   output [3:0]  confTrc;
   output [2:0]  confTrdWr;
   output [2:0]  confTwrRd;
   output [3:0]  confBL;
   output        confCycRef;

   // for writing the configuration registers
   reg  [17:0]   confMReg;
   reg  [3:0]    confRL;
   reg  [3:0]    confWL;
   reg  [7:0]    confRcCnt0;
   reg  [7:0]    confRcCnt1;
   reg  [7:0]    confRcMargin;
   reg  [3:0]    confTrc;
   reg  [2:0]    confTrdWr;
   reg  [2:0]    confTwrRd;
   reg  [3:0]    confBL;
   reg           confCycRef;

   // for reading the configuration registers   
   wire [9:0]    confMRegI;
   wire [3:0]    confRLI;
   wire [3:0]    confWLI;
   wire [7:0]    confRcCnt0I;
   wire [7:0]    confRcCnt1I;
   wire [7:0]    confRcMarginI;
   wire [3:0]    confTrcI;
   wire [2:0]    confTrdWrI;
   wire [2:0]    confTwrRdI;

   reg  [7:0]    cDInt;


   // -----------------------------------------------------------------------------
   // Buffered version of each registers, for reading 
   // -----------------------------------------------------------------------------
   assign  confMRegI      = confMReg[9:0];
   assign  confRLI        = confRL;
   assign  confWLI        = confWL;
   assign  confRcCnt0I    = confRcCnt0;
   assign  confRcCnt1I    = confRcCnt1;
   assign  confRcMarginI  = confRcMargin;
   assign  confTrcI       = confTrc;
   assign  confTrdWrI     = confTrdWr;
   assign  confTwrRdI     = confTwrRd;

   // 8-bit read data, transfered to output read port
   assign  apConfRdD[7:0] = cDInt[7:0];


   // -----------------------------------------------------------------------------
   // Read and Write to configuration registers
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rstHard )
      begin
         confMReg[17:0]    <= MODE_DEF;
         confRL            <= RD_LATENCY;
         confWL            <= WR_LATENCY;
         confRcCnt0[7:0]   <= RCCNT0;
         confRcCnt1[7:0]   <= RCCNT1;
         confRcMargin[7:0] <= RCMGN;
         confTrc[3:0]      <= TRC;
         confTrdWr[2:0]    <= TRW;
         confTwrRd[2:0]    <= TWR;
         confBL            <= BLEN;
         confCycRef        <= CYC_REF;
      end
      else
      begin
         if ( apConfWr )   // Write to configuration registers
         begin
            case ( apConfA )
               4'b0000:
               begin 
                  confMReg[7] <= apConfWrD[7];
                  // bit 6 is unused
                  confMReg[5:0] <= apConfWrD[5:0];
               end
               4'b0001: confRL         <= apConfWrD[3:0];  // read latency 
               4'b0010: confWL         <= apConfWrD[3:0];  // write latency
               4'b0011: confRcCnt0     <= apConfWrD[7:0];
               4'b0100: confRcCnt1     <= apConfWrD[7:0];
               4'b0101: confRcMargin   <= apConfWrD[7:0];
               4'b0110: confTrc[3:0]   <= apConfWrD[3:0];
               4'b0111: confTrdWr[2:0] <= apConfWrD[2:0];
               4'b1000: confTwrRd[2:0] <= apConfWrD[2:0];
               4'b1001: confBL         <= apConfWrD[3:0];
               4'b1010: confMReg[9:8]  <= apConfWrD[1:0];
               4'b1011: confCycRef     <= apConfWrD[0];
               // 4'b1100 to 4'b1111 are covered in "default"
               default: ;
            endcase
         end
         else
            if ( apConfRd )   // Read from configuration registers
            begin
               case ( apConfA )
                  4'b0000:  cDInt[7:0] <= confMRegI[7:0];
                  4'b0001:  cDInt[7:0] <= {4'h0, confRLI};
                  4'b0010:  cDInt[7:0] <= {4'h0, confWLI};
                  4'b0011:  cDInt[7:0] <= confRcCnt0I[7:0];
                  4'b0100:  cDInt[7:0] <= confRcCnt1I[7:0];
                  4'b0101:  cDInt[7:0] <= confRcMarginI[7:0];
                  4'b0110:  cDInt[7:0] <= {4'b0000, confTrcI[3:0]};
                  4'b0111:  cDInt[7:0] <= {5'b0000_0, confTrdWrI[2:0]};
                  4'b1000:  cDInt[7:0] <= {5'b0000_0, confTwrRdI[2:0]};
                  4'b1001:  cDInt[7:0] <= {4'b0000, confBL};
                  4'b1010:  cDInt[7:0] <= {6'b000000, confMRegI[9:8]};
                  4'b1011:  cDInt[7:0] <= {7'b000_0000, confCycRef};
                  // 4'b1100 to 4'b1111 are covered in "default"
                  default:  cDInt[7:0] <= confMRegI[7:0];
               endcase
            end
      end
   end


endmodule
