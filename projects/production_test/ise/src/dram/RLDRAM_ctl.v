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
//  \   \         Filename: rld_ctl.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module is the memory controller;
//		* Main control is implemented in this module.
//		* It initiates read, write and refresh commands to rld memory.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - changed the clock frequency parameter to a clock period parameter,
//             added the X_CORE synthesis attribute
//
//		This module processes commands from the command FIFO and sends
//		the commands to the memory interface.  It also handles 
//		auto-refresh and bank conflict.
//
//  ** Note *******************************************************************
//  1. This module has been extensively tested with random stimulus for BL=2
//     and CONF=1.  Limited tests were run for other configurations and there
//     may be uncovered problems with these configurations.  More tests will
//     be done for all supported configurations in the next phase.
//
//  2. User refresh command is not supported in this version.  Please use AREF 
//     feature provided by the controller instead.
//  ***************************************************************************
//
//
//  Port Definitions:
//     clk              (input)  clock input
//     rstHard          (input)  hard reset, active high
//     rstConfig        (input)  configuration reset
//
//     cmdFifoEmpty     (input)  command FIFO empty flag
//     cmdFifoOut[25:0] (input)  command FIFO data output
//          - [25:24]: command 00: write;  01: read
//          - [23:3] : memory address (A)
//          - [2:0]  : memory bank address (BA)
//     rstCmd           (input)  command during configuration reset
//     rstAd            (input)  memory address during configuration reset
//     rstBa            (input)  memory bank during configuration reset
//
//     confRL           (input)  memory read latency
//     confWL           (input)  memory write latency
//     confRcCnt0       (input)
//     confRcCnt1       (input) 
//          - (confRcCnt1, confRcCnt0} is the interval (in clock cycles) 
//            that AREF should be issued
//     confTrc          (input)  memory tRC setting
//     confRcMargin     (input)  confRcMargin defines how many cycles before 
//          - {confRcCnt1, confRcCnt0} expires that a AREF request should be sent to the FSM
//     confTrdWr        (input)  unused...
//     confTwrRd        (input)  unused...
//     confBL           (input)  memory burst length
//     confAutoRefrEn   (input)  enables AREF feature of the controller
//
//     cmdFifoRdEn     (output)  command FIFO read enable
//     ctlIoWdEn       (output)  IO output eanble
//     ctlCmdOut       (output)  memory command 
//     ctlAddrOut      (output)  memory address
//     ctlWdfRdEn      (output)  write data FIFO read enable
//     ctlBankOut      (output)  memory bank
//     ctlOkEdge       (output)  indicates OK to change data valid edge for per-bit deskew
//     rldWriteDone    (output)  indicates one write command was executed
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_ctl  (
   clk,
   rstHard,
   rstConfig,

   cmdFifoEmpty,
   cmdFifoOut,
   rstCmd,
   rstAd,
   rstBa,

   confRL,
   confWL,
   confRcCnt0,
   confRcCnt1,
   confRcMargin,
   confTrc,
   confTrdWr,
   confTwrRd,
   confBL,
   confAutoRefrEn,

   cmdFifoRdEn,
   ctlIoWdEn,
   ctlCmdOut,
   ctlAddrOut,
   ctlWdfRdEn,
   ctlBankOut,
   ctlOkEdge,
   rldWriteDone,
   
   // chipscope debug ports
   cs_io

`ifdef INSERT_CHIPSCOPE_CORES
`endif
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
parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;   // internal 50ohms output buffer impedance
parameter RL_MRS_ODT             = 1'b0;   // 1'b0: disable term;  1'b1: enable term
//
// specific to FPGA/memory devices and capture method
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters

// private parameters -- do not modify
// Controllet state machine (state encodings)
parameter CTL_IDLE          = 3'b000;
parameter CTL_LOAD_CMD1     = 3'b001;
parameter CTL_LOAD_CMD2     = 3'b010;
parameter CTL_PROC_CMD      = 3'b011;
parameter CTL_PROC_LAST_CMD = 3'b100;
parameter CTL_PROC_REFR     = 3'b101;
//
// CMD signals are formed by concatenating CS_N, AS_N, WE_N, REF_N, respectively
//                     CS_N  AS_N  WE_N  REF_N
parameter CMD_DESEL = {1'b1, 1'b1, 1'b1, 1'b1};
parameter CMD_RD    = {1'b0, 1'b0, 1'b1, 1'b1};
parameter CMD_WR    = {1'b0, 1'b0, 1'b0, 1'b1};
parameter CMD_NOP   = {1'b1, 1'b1, 1'b1, 1'b1};
parameter CMD_REF   = {1'b0, 1'b1, 1'b1, 1'b0};
// end of private parameters

   input          clk;
   input          rstHard;
   input          rstConfig;

   input          cmdFifoEmpty;              
   input  [25:0]  cmdFifoOut;          

   // Reset configuration signals
   input  [3:0]              rstCmd;
   input  [DEV_AD_WIDTH-1:0] rstAd;
   input  [DEV_BA_WIDTH-1:0] rstBa;

   // Configuration Register values
   input  [3:0]   confRL;
   input  [3:0]   confWL;
   input  [7:0]   confRcCnt0;
   input  [7:0]   confRcCnt1;
   input  [7:0]   confRcMargin;
   input  [3:0]   confTrc;
   input  [2:0]   confTrdWr;
   input  [2:0]   confTwrRd;
   input  [3:0]   confBL;
   input          confAutoRefrEn;

   output         cmdFifoRdEn;
   output         ctlOkEdge;

   // write data fifo read
   output         ctlWdfRdEn;
   // write data enable for pads
   output         ctlIoWdEn;

   // commands and address, bank outputs
   output [3:0]              ctlCmdOut;
   output [DEV_AD_WIDTH-1:0] ctlAddrOut;
   output [DEV_BA_WIDTH-1:0] ctlBankOut;
   output                    rldWriteDone;
   
   // chipscope debug ports
   inout  [1023:0]               cs_io;   

`ifdef INSERT_CHIPSCOPE_CORES
`endif

//  XCORE Synthesis attribute 
//  synthesis attribute X_CORE_INFO of rld_ctl is "rld_ctl, V5_rldram2_cont_verilog";

   reg                     ctlOkEdge;
   reg  [3:0]              ctlCmdOut;
   reg  [DEV_AD_WIDTH-1:0] ctlAddrOut;
   reg  [DEV_BA_WIDTH-1:0] ctlBankOut;
   reg                     ctlWdfRdEn;
   reg                     ctlWdfRdEn_r1;

   reg  [2:0]  ctl_state;
   reg         load_cmd1, load_cmd2;

   reg         rst; 
   reg [14:0]  rd_grant_sreg;
   //reg         refUser;            // register for user refresh, unsupported for now
   reg  [11:0] refr_cnt; 
   reg         refr_req, refr_req_clr, refr_trc_ok;
   reg  [7:0]  refr_req_clr_sreg;
 
   reg  [2:0]  refr_bank;
   reg         refr_done; 

   wire [DEV_AD_WIDTH-1:0] cmd_addr_r1;
   wire [1:0]              cmd_cmd_r1;
   wire [DEV_BA_WIDTH-1:0] cmd_bank_r1;

   reg  [DEV_AD_WIDTH-1:0] cmd_addr_r2;
   reg  [1:0]              cmd_cmd_r2;
   reg  [DEV_BA_WIDTH-1:0] cmd_bank_r2;
   reg                     cmd_pipe_stalled;

   wire        read_req2, write_req2;
   reg         rd_grant, wr_grant, refr_grant;
   reg         wr_grant_r1, wr_grant_r2, wr_grant_r3;
   wire        prev_is_wr_grant;
   reg  [9:0]  wd_fifo_rd_sreg ; 

   reg         trc_ok_r1, trc_ok_r2;
   wire        trc_ok;
   reg  [7:0]  bank_trc_ok;
   wire [7:0]  trc_cnt_clr;
   reg  [3:0]  trc_cnt0, trc_cnt1, trc_cnt2, trc_cnt3;
   reg  [3:0]  trc_cnt4, trc_cnt5, trc_cnt6, trc_cnt7;
   reg  [3:0]  conf_trc_int;
   reg  [1:0]  burst_cnt;
   reg         burst_allow;

   // -----------------------------------------------------------------------------
   // Output assignments
   // -----------------------------------------------------------------------------
   assign cmdFifoRdEn = load_cmd1;


   // -----------------------------------------------------------------------------
   // Internal reset signal, generated from reset config or Hard
   // -----------------------------------------------------------------------------
   always @( posedge clk ) 
      rst <= rstConfig || rstHard;


   // -----------------------------------------------------------------------------
   // Signal conf_trc_int is different from confTrc because of the 
   // pipeline used for checking the tRC violation
   // -----------------------------------------------------------------------------
   always @( posedge clk ) 
      conf_trc_int <= confTrc - 4'h3;


   // -----------------------------------------------------------------------------
   // The 1st stage of the command pipeline
   // The values will only be updated when load_cmd1 is '1', 
   // which is used as the command FIFO read enable signal cmdFifoRdEn
   // -----------------------------------------------------------------------------
   assign cmd_cmd_r1  = cmdFifoOut[25:24];
   assign cmd_addr_r1 = cmdFifoOut[23:3];
   assign cmd_bank_r1 = cmdFifoOut[2:0];


   // -----------------------------------------------------------------------------
   // The 2nd stage of the command pipeline
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
      begin
         cmd_cmd_r2  <= 2'h0;
         cmd_addr_r2 <= {DEV_AD_WIDTH{1'b0}};
         cmd_bank_r2 <= {DEV_BA_WIDTH{1'b0}};
      end
      else
         if ( load_cmd2 )
         begin
            cmd_cmd_r2  <= cmd_cmd_r1;
            cmd_addr_r2 <= cmd_addr_r1;
            cmd_bank_r2 <= cmd_bank_r1;
         end
   end


   // -----------------------------------------------------------------------------
   // The command pipe will be stalled everytime trc_ok is 0
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
         cmd_pipe_stalled <= 1'b0;
      else
         cmd_pipe_stalled <= trc_ok ? 1'b0 : 1'b1;
   end


   // -----------------------------------------------------------------------------
   // Flags that the trc counter for a bank should be cleared
   // -----------------------------------------------------------------------------
   assign trc_cnt_clr[0] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b000);
   assign trc_cnt_clr[1] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b001);
   assign trc_cnt_clr[2] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b010);
   assign trc_cnt_clr[3] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b011);
   assign trc_cnt_clr[4] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b100);
   assign trc_cnt_clr[5] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b101);
   assign trc_cnt_clr[6] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b110);
   assign trc_cnt_clr[7] = (rd_grant | wr_grant) && (cmd_bank_r2[2:0] == 3'b111);


   // -----------------------------------------------------------------------------
   // Keep track the number of cycles since last access of a bank.
   // Stop counting once the counter reaches 8 as the biggest tRC is 8.
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      // Bank 0
      if ( rstHard || trc_cnt_clr[0] )
      begin
         trc_cnt0       <= 4'h0;
         bank_trc_ok[0] <= 1'b0;
      end
      else
      begin
         trc_cnt0       <= trc_cnt0[3] ? trc_cnt0 : trc_cnt0 + 4'h1;
         bank_trc_ok[0] <= (trc_cnt0 >= conf_trc_int);
      end
   
      // Bank 1
      if ( rstHard || trc_cnt_clr[1] )
      begin
         trc_cnt1       <= 4'h0;
         bank_trc_ok[1] <= 1'b0;
      end
      else
      begin
         trc_cnt1       <= trc_cnt1[3] ? trc_cnt1 : trc_cnt1 + 4'h1;       
         bank_trc_ok[1] <= (trc_cnt1 >= conf_trc_int);
      end
   
      // Bank 2
      if ( rstHard || trc_cnt_clr[2] )
      begin
         trc_cnt2       <= 4'h0;
         bank_trc_ok[2] <= 1'b0;
      end
      else
      begin
         trc_cnt2       <= trc_cnt2[3] ? trc_cnt2 : trc_cnt2 + 4'h1;
         bank_trc_ok[2] <= (trc_cnt2 >= conf_trc_int);
      end
      
      // Bank 3
      if ( rstHard || trc_cnt_clr[3] )
      begin
         trc_cnt3       <= 4'h0;
         bank_trc_ok[3] <= 1'b0;
      end
      else
      begin
         trc_cnt3       <= trc_cnt3[3] ? trc_cnt3 : trc_cnt3 + 4'h1;
         bank_trc_ok[3] <= (trc_cnt3 >= conf_trc_int);
      end
   
      // Bank 4
      if ( rstHard || trc_cnt_clr[4] )
      begin
         trc_cnt4       <= 4'h0;
         bank_trc_ok[4] <= 1'b0;
      end
      else
      begin
         trc_cnt4       <= trc_cnt4[3] ? trc_cnt4 : trc_cnt4 + 4'h1;
         bank_trc_ok[4] <= (trc_cnt4 >= conf_trc_int);
      end
      
      // Bank 5
      if ( rstHard || trc_cnt_clr[5] )
      begin
         trc_cnt5       <= 4'h0;
         bank_trc_ok[5] <= 1'b0;
      end
      else
      begin
         trc_cnt5       <= trc_cnt5[3] ? trc_cnt5 : trc_cnt5 + 4'h1;
         bank_trc_ok[5] <= (trc_cnt5 >= conf_trc_int);
      end
      
      // Bank 6
      if ( rstHard || trc_cnt_clr[6] )
      begin
         trc_cnt6       <= 4'h0;
         bank_trc_ok[6] <= 1'b0;
      end
      else
      begin
         trc_cnt6       <= trc_cnt6[3] ? trc_cnt6 : trc_cnt6 + 4'h1;
         bank_trc_ok[6] <= (trc_cnt6 >= conf_trc_int);
      end
      
      // Bank 7
      if ( rstHard || trc_cnt_clr[7] )
      begin
         trc_cnt7       <= 4'h0;
         bank_trc_ok[7] <= 1'b0;
      end
      else begin
         trc_cnt7       <= trc_cnt7[3] ? trc_cnt7 : trc_cnt7 + 4'h1;
         bank_trc_ok[7] <= (trc_cnt7 >= conf_trc_int);
      end
   end


   // -----------------------------------------------------------------------------
   // Signal trc_ok_r1 indicates there is no tRC violation on the 1st stage of
   // the cmd pipeline.  It is registered, so it's timing lines up with the 
   // 2nd stage.  It is basically a lookahead of tRC violation to achieve better
   // timing in a continous command stream.
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rstHard )
         trc_ok_r1 <= 1'b0;
      else
      begin
         case ( cmd_bank_r1 )
            3'b000:  trc_ok_r1 <= ~trc_cnt_clr[0] & bank_trc_ok[0];
            3'b001:  trc_ok_r1 <= ~trc_cnt_clr[1] & bank_trc_ok[1];
            3'b010:  trc_ok_r1 <= ~trc_cnt_clr[2] & bank_trc_ok[2];
            3'b011:  trc_ok_r1 <= ~trc_cnt_clr[3] & bank_trc_ok[3];
            3'b100:  trc_ok_r1 <= ~trc_cnt_clr[4] & bank_trc_ok[4];
            3'b101:  trc_ok_r1 <= ~trc_cnt_clr[5] & bank_trc_ok[5];
            3'b110:  trc_ok_r1 <= ~trc_cnt_clr[6] & bank_trc_ok[6];
            3'b111:  trc_ok_r1 <= ~trc_cnt_clr[7] & bank_trc_ok[7];
            //  all cases covered, no default required
         endcase
      end
   end


   // -----------------------------------------------------------------------------
   // Check tRC violation on the 2nd stage
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rstHard )
         trc_ok_r2 <= 1'b0;
      else
      begin
         case ( cmd_bank_r2 )
            3'b000:  trc_ok_r2 <= bank_trc_ok[0];
            3'b001:  trc_ok_r2 <= bank_trc_ok[1];
            3'b010:  trc_ok_r2 <= bank_trc_ok[2];
            3'b011:  trc_ok_r2 <= bank_trc_ok[3];
            3'b100:  trc_ok_r2 <= bank_trc_ok[4];
            3'b101:  trc_ok_r2 <= bank_trc_ok[5];
            3'b110:  trc_ok_r2 <= bank_trc_ok[6];
            3'b111:  trc_ok_r2 <= bank_trc_ok[7];
            //  all cases covered, no default required
         endcase
      end
   end


   // -----------------------------------------------------------------------------
   // Signals trc_ok_r1 and trc_ok_r2 need to be used together to indicate
   // there is no tRC violation
   // -----------------------------------------------------------------------------
   assign trc_ok = cmd_pipe_stalled ? trc_ok_r2 : trc_ok_r1;


   // -----------------------------------------------------------------------------
   // - Burst counter, burst_cnt
   // - Burst_allow signal is used to control how often rd_grant or
   //   wr_grant can be issued:
   //      for BL2, burst_allow is set all the time
   //      for BL4, burst_allow is set every 2 cycles
   //      for BL8, burst allow is set every 4 cycles
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
      begin
         burst_cnt   <= 2'b00;
         burst_allow <= 1'b0;
      end
      else
      begin
         burst_cnt <= burst_cnt + 1'b1;
      
         if ( confBL == 4'h2 )
            burst_allow <= 1'b1;
         else
            if ( confBL == 4'h4 )
               burst_allow <= burst_cnt[0];
            else
               burst_allow <= &burst_cnt;
      end
   end

   assign read_req2        = ( cmd_cmd_r2 == 2'b01 );
   assign write_req2       = ( cmd_cmd_r2 == 2'b00 );
   assign prev_is_wr_grant = wd_fifo_rd_sreg[0];


   // -----------------------------------------------------------------------------
   // Controller state machine (FSM)
   // It only processes the commands from the 2nd stage of the command pipeline.
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rstHard )
         ctl_state <= CTL_IDLE;

      else
      begin
         case ( ctl_state )
         // ----------------------------------------------------------------
            CTL_IDLE :
         // ----------------------------------------------------------------
            begin
               // AREF request is only checked in CTL_IDLE to simplify logic.
               // The AREF request will be responded in maximum 4 cycles 
               // depending the current state.
               if ( refr_req )
                  ctl_state <= CTL_PROC_REFR;
               else
                  if ( ~cmdFifoEmpty )
                     ctl_state <= CTL_LOAD_CMD1;
                  else
                     ctl_state <= CTL_IDLE;
            end
         // ----------------------------------------------------------------
            CTL_LOAD_CMD1 :
         // ----------------------------------------------------------------
            begin
               ctl_state <= CTL_LOAD_CMD2;
            end
         // ----------------------------------------------------------------
            CTL_LOAD_CMD2 :
         // ----------------------------------------------------------------
            begin
               // If the cmd FIFO is empty, there is no more command to load,
               // so go to CTL_PROC_LAST_CMD and process the only command
               // in the pipeline.
               if ( ~cmdFifoEmpty )
                  ctl_state <= CTL_PROC_CMD;
               else
                  ctl_state <= CTL_PROC_LAST_CMD;
            end
         // ----------------------------------------------------------------
            CTL_PROC_CMD :
         // ----------------------------------------------------------------
            begin
               // When the cmd FIFO is empty or AREF request is high, finish 
               // processing the current cmd, then go to CTL_PROC_LAST_CMD 
               // to process the last cmd in the pipeline.
               // Otherwise stay in this state.
               if ( (cmdFifoEmpty || refr_req) & 
                     (write_req2 || (read_req2 & ~prev_is_wr_grant)) & trc_ok & burst_allow )
                  ctl_state <= CTL_PROC_LAST_CMD;
               else
                  ctl_state <= CTL_PROC_CMD;
            end
         // ----------------------------------------------------------------
            CTL_PROC_LAST_CMD :
         // ----------------------------------------------------------------
            begin
               // Processing the last command.   The command pipeline will be
               // empty after this state.  Go back to CTL_IDLE state after
               // rd_grant or wr_grant is issued
               if ( (write_req2 || (read_req2 & ~prev_is_wr_grant)) & trc_ok & burst_allow )
                  ctl_state <= CTL_IDLE;
               else
                  ctl_state <= CTL_PROC_LAST_CMD;
            end
         // ----------------------------------------------------------------
            CTL_PROC_REFR :
         // ----------------------------------------------------------------
            begin
               if ( refr_done )
                  ctl_state <= CTL_IDLE;
               else
                  ctl_state <= CTL_PROC_REFR;
            end
         // ----------------------------------------------------------------
            default :
         // ----------------------------------------------------------------
               ctl_state <= CTL_IDLE;
         endcase
      end
   end


   // -----------------------------------------------------------------------------
   // Combinatorial logic for the "ctl_state" Controller FSM
   // -----------------------------------------------------------------------------
   always @(*)
   begin
      // Default assignments.
      // Only the outputs that are different from the default values will be updated.
      // This saves typing and makes the code more readable.
      load_cmd1    <= 1'b0;
      load_cmd2    <= 1'b0;
      rd_grant     <= 1'b0;
      wr_grant     <= 1'b0;
      refr_grant   <= 1'b0;
      refr_req_clr <= 1'b0;
      
      case ( ctl_state )
      //---------------------------------------------------------------------
         CTL_IDLE :
      //---------------------------------------------------------------------
         begin
            // Use default assignments
         end
      //---------------------------------------------------------------------
         CTL_LOAD_CMD1 :
      //---------------------------------------------------------------------
         begin
            // Load the 1st stage
            load_cmd1 <= 1'b1;
         end
      //---------------------------------------------------------------------
         CTL_LOAD_CMD2 :
      //---------------------------------------------------------------------
         begin
            if ( ~cmdFifoEmpty )
            begin
               // If cmd FIFO is not empty, 
               // load both the 1st stage and 2nd stage
               load_cmd1 <= 1'b1;
               load_cmd2 <= 1'b1;
            end
            else
            begin
               // Otherwise, don't load the 1st stage and 
               // push the 1st stage to 2nd for processing
               load_cmd1 <= 1'b0;
               load_cmd2 <= 1'b1;
            end
         end
      //---------------------------------------------------------------------
         CTL_PROC_CMD :
      //---------------------------------------------------------------------
         begin
            // When in CTL_PROC_CMD state, it will always stay in this state
            // unless a rd_grant or wr_grant is issued.
            
            // One NOP needs to be inserted when transitioning from write to read.           
            if ( read_req2 & ~prev_is_wr_grant & trc_ok & burst_allow )
               rd_grant <= 1'b1;
            else
               if ( write_req2 & trc_ok & burst_allow )
                  wr_grant <= 1'b1;
   
            if ( (cmdFifoEmpty || refr_req) & 
                 (write_req2 || (read_req2 & ~prev_is_wr_grant)) & trc_ok & burst_allow )
            begin
               // Going to CTL_PROC_LAST_CMD state; only load the 2nd stage
               load_cmd1 <= 1'b0;
               load_cmd2 <= 1'b1;
            end
            else
               if ( (write_req2 || (read_req2 & ~prev_is_wr_grant)) & trc_ok & burst_allow )
               begin
                  // Staying in CTL_PROC_CMD state; load both 1st and 2nd stage
                  load_cmd1 <= 1'b1;
                  load_cmd2 <= 1'b1;
               end
         end
      //---------------------------------------------------------------------
         CTL_PROC_LAST_CMD :
      //---------------------------------------------------------------------
         begin
            // Finish processing the last command in the pipeline
            if ( read_req2 & ~prev_is_wr_grant & trc_ok & burst_allow )
               rd_grant <= 1'b1;
            else
               if ( write_req2 & trc_ok & burst_allow )
                  wr_grant <= 1'b1;
         end
      //---------------------------------------------------------------------
         CTL_PROC_REFR :
      //---------------------------------------------------------------------
         begin
            // Processing AREF request
            refr_req_clr <= 1'b1;
   
            if ( refr_done )
               refr_grant <= 1'b0;
            else
               if ( refr_trc_ok )
                  refr_grant <= 1'b1;
         end
      //---------------------------------------------------------------------
         default :
      //---------------------------------------------------------------------
         begin
            // Use default assignments
         end
      endcase
   end


   // -----------------------------------------------------------------------------
   // -----------------------------------------------------------------------------
   assign ctlIoWdEn    = ctlWdfRdEn;
   assign rldWriteDone = ctlWdfRdEn; 

   // -----------------------------------------------------------------------------
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      rd_grant_sreg[14:0] <= {rd_grant_sreg[13:0], rd_grant};
      // This signal controls when the deskew tap adjustment can be done.
      // Avoid adjusting when data could be coming in - both earliest data 
      // arrival and latest data arrival is taken care of.
      ctlOkEdge <= ~( | rd_grant_sreg[14:10] );
   end      


   // -----------------------------------------------------------------------------
   // Generate the command for the RLDRAM
   // ** Note :
   //    refUser command is not supported at this time (as of 09/07/2005)
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rstHard )
      begin
         ctlCmdOut  <= CMD_DESEL;
         ctlAddrOut <= {DEV_AD_WIDTH{1'b0}};
         ctlBankOut <= {DEV_BA_WIDTH{1'b0}};
      end
      else
         if ( rstConfig )
         begin
            ctlCmdOut  <= rstCmd;
            ctlAddrOut <= rstAd;
            ctlBankOut <= rstBa;
         end
         else
         begin
            if ( rd_grant )
            begin
                ctlCmdOut  <= CMD_RD;
                ctlAddrOut <= cmd_addr_r2;
                ctlBankOut <= cmd_bank_r2;
            end
            else
               if ( wr_grant )
               begin
                  ctlCmdOut  <= CMD_WR;
                  ctlAddrOut <= cmd_addr_r2;
                  ctlBankOut <= cmd_bank_r2;
               end
               else
                  if ( refr_grant )
                  begin
                      ctlCmdOut  <= CMD_REF;
                      ctlBankOut <= refr_bank;
                  end
   //              else
   //                 if ( refUser )
   //                 begin
   //                    ctlCmdOut  <= CMD_REF;
   //                    ctlBankOut <= cmd_bank_r2;
   //                 end
                  else
                  begin
                     ctlCmdOut[3:0] <= CMD_NOP;
                  end
         end
   end


   // -----------------------------------------------------------------------------
   // Refresh counter
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( refr_done || rst )
         refr_cnt[11:0] <= {confRcCnt1[3:0], confRcCnt0[7:0]};
      else
          refr_cnt[11:0] <= refr_cnt[11:0] - 1'b1;
   end


   // -----------------------------------------------------------------------------
   // Refresh logic
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
      begin
          refr_req          <= 1'b0;
          refr_done         <= 1'b0;
          refr_req_clr_sreg <= 8'h00;
          refr_trc_ok       <= 1'b0;
          refr_bank         <= 3'b000;
      end
      else
      begin
         if ( refr_req_clr )
            refr_req <= 1'b0;
         else
            if ( (refr_cnt[11:0] == {4'h0, confRcMargin[7:0]}) & confAutoRefrEn )
               refr_req <= 1'b1;

         refr_req_clr_sreg <= {refr_req_clr_sreg[6:0], refr_req_clr};

         // Signal refr_trc_ok indicates tRC is satisfied in the 
         // worst case scenario and refr_grant can be issued
         refr_trc_ok <= (confTrc == 3'h4) ? refr_req_clr_sreg[1] : 
                        ( (confTrc == 3'h6) ? refr_req_clr_sreg[3] : refr_req_clr_sreg[5] );

         // Finish refreshing all 8 banks
         refr_done <= refr_grant && (refr_bank == 3'b111);

         if ( ~refr_grant )
            refr_bank <= 3'b000;
         else
         begin
            case ( refr_bank )
               3'b000:  refr_bank <= 3'b001;
               3'b001:  refr_bank <= 3'b010;
               3'b010:  refr_bank <= 3'b011;
               3'b011:  refr_bank <= 3'b100;
               3'b100:  refr_bank <= 3'b101;
               3'b101:  refr_bank <= 3'b110;
               3'b110:  refr_bank <= 3'b111;
               3'b111:  refr_bank <= 3'b000;
               //  all cases covered, no default required
            endcase
         end
      end
   end


   // -----------------------------------------------------------------------------
   // Enable driving write data to the pads at the appropriate time.
   // Insert wr_grant into the right location based on burst length and write latency.
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
      begin
         wr_grant_r1     <= 1'b0;
         wr_grant_r2     <= 1'b0;
         wr_grant_r3     <= 1'b0;
         wd_fifo_rd_sreg <= 10'h000;
         ctlWdfRdEn      <= 1'b0;
      end
      else
      begin
         wr_grant_r1 <= wr_grant;
         wr_grant_r2 <= wr_grant_r1;
         wr_grant_r3 <= wr_grant_r2;
   
         if ( confBL == 4'h8 )  // need to extend the pulse width to 4
            wd_fifo_rd_sreg[0] <= wr_grant || wr_grant_r1 || wr_grant_r2 || wr_grant_r3;
         else
            if ( confBL == 4'h4 )  // need to extend the pulse width to 2
               wd_fifo_rd_sreg[0] <= wr_grant || wr_grant_r1;
            else
               wd_fifo_rd_sreg[0] <= wr_grant;
   
         wd_fifo_rd_sreg[9:1] <= wd_fifo_rd_sreg[8:0];
         ctlWdfRdEn <= (confWL == 4'h5) ? wd_fifo_rd_sreg[4] : 
                       ( (confWL == 4'h7) ? wd_fifo_rd_sreg[6] : wd_fifo_rd_sreg[8] );
      end
   end


`ifdef INSERT_CHIPSCOPE_CORES 
`endif



endmodule
