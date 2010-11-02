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
//  \   \         Filename: rld_rst.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module generates the reset signals and controls
//		the memory initial configuration (reset state machine).
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Changed the initialization sequence to generate back-to-back
//             MRS commands per memory requirement along with holding the address
//             bus low during dummy MRS commands
//
//  Definition of "confMReg[17:0]" (MODE register)
//   [17:10]   [9]   [8]       [7]      [6]     [5]      [4:3]    [2:0]
//  RESERVED, TERM, RESIST, DLL_RESET, 1'b0, ADDR_MUX, BURST_LEN, CONF
//
//  bit[17:10] RESERVED
//  bit[9]     TERM      = 1'b0   (disable ODT)
//  bit[8]     RESIST    = 1'b1   (enable internal 50ohms output buffer impedance)
//  bit[7]     DLL_RESET = 1'b0   ()
//  bit[6]     ...reserved...
//  bit[5]     ADDR_MUX  = 1'b0   (non-multiplexed address)
//  bit[4:3]   BURST_LEN = 2'b00  (2'b00: BL2; 2'b01: BL4; 2'b10: BL8)
//  bit[2:0]   CONF      = 3'b001 (config = 1, 2 or 3)
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_rst  (
   clk,
   clk90,
   clk180,
   clk270,
   refClk,
   sysReset,  // system reset input, acive low, asynchronous

   confMReg,
   dcmLocked,
   issueMRS,

   calibration_done,

   sync_system_reset,  // system reset, synchronized to clk
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,
   rstHard_refClk,
   rstConfig,

   Init_Done,
   Init_Done_270,
   mrsDone_o,

   rstCmd,
   rstAd,
   rstBa
);

// public parameters -- adjustable
parameter SIMULATION_ONLY = 1'b0;  // if set (1'b1), it shortens the wait time
//
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
// end of public parameters

// private parameters -- do not change
// simulation only setting to shorten the wait time (when SIMULATION_ONLY = 1'b1)
parameter REF_VAL_shorten = 11'h032;  // refresh counts
parameter REF_TRC_shorten = 11'h032;
parameter WAIT_FOR_POWER_STABLE_CNT_shorten = 16'h0032;  // 50 ticks @210MHz is 0.238us
// normal settings for wait time (when SIMULATION_ONLY = 1'b0)
parameter REF_VAL = 11'h7FF;  // refresh counts
parameter REF_TRC = 11'h7EC;
parameter WAIT_FOR_POWER_STABLE_CNT = 16'hA410;  // 420000 ticks @210MHz is 200us
//
//  defines "rstSt" possible states
parameter WAIT200us       = 3'b000;
parameter RESET           = 3'b001;
parameter CONFIG          = 3'b010;
parameter REFRESH         = 3'b011;
parameter ALL_DONE        = 3'b100;
parameter MODE_CHANGE     = 3'b101;
parameter WAIT_DLL_STABLE = 3'b110;
//
//  defines "rstCmd" possible commands
//                    CS_N  AS_N  WE_N  REF_N
parameter MRS_CMD = { 1'b0, 1'b0, 1'b0, 1'b0 };
parameter NOP_CMD = { 1'b1, 1'b1, 1'b1, 1'b1 };
parameter REF_CMD = { 1'b0, 1'b1, 1'b1, 1'b0 };
// end of private parameters

   input                     clk;
   input                     clk90;
   input                     clk180;
   input                     clk270;
   input                     refClk;
   input                     sysReset;

   input  [17:0]             confMReg;
   input                     dcmLocked;
   input                     issueMRS;

   input                     calibration_done;  // QK and DQ calibrations are completed

   output                    sync_system_reset;
   output                    rstHard;
   output                    rstHard_90;
   output                    rstHard_180;
   output                    rstHard_270;
   output                    rstHard_refClk;
   output                    rstConfig;

   output                    Init_Done;
   output                    Init_Done_270;
   output                    mrsDone_o;

   output [3:0]              rstCmd;
   output [DEV_AD_WIDTH-1:0] rstAd;
   output [DEV_BA_WIDTH-1:0] rstBa;

   reg  hardInt;
   reg  rstConfig;
   reg  Init_Done;
   reg  [3:0]              rstCmd;
   reg  [DEV_AD_WIDTH-1:0] rstAd;
   wire [DEV_BA_WIDTH-1:0] rstBa;

   reg  [DEV_BA_WIDTH-1:0] bank;
   reg  [10:0]             refCnt;
   reg  [15:0]             WaitCnt;
   reg  [4:0]              cfgCnt;
   reg  [2:0]              mrsCnt;
   reg  [2:0]              rstSt;
   reg  waitTrc;
   reg  doRefresh;
   reg  refStart;

   reg  rstHard_0;
   reg  rstHard_a1_0;
   reg  rstHard_90;
   reg  rstHard_a1_180;
   reg  rstHard_180;
   reg  rstHard_a1_270;
   reg  rstHard_a2_270;
   reg  rstHard_270;

   reg  Init_Done_a1_270;
   reg  Init_Done_270;

   reg  rstHard_refClk, rstHard_a1_refClk, rstHard_a2_refClk;

   reg  Detect_final_WaitCnt_refClk;                    // on refClk clock domain
   reg  Detect_final_WaitCnt, Detect_final_WaitCnt_d1;  // on clk clock domain

   wire addr_mux;

   reg  mrsDone_o;
   wire mr_dll_reset_bit, prev_mr_dll_reset_bit;
   reg  dll_reset_change;
   reg [9:0] dll_stable_wait_cnt;
   reg  dll_is_stable;

   reg  sys_rst_0, sys_rst_1, sys_rst_2, sys_rst_3;
   wire sync_system_reset_pre;
   reg  sync_system_reset;
   wire sync_system_reset_int;  // internal version of "sync_system_reset"

   wire vcc, gnd;


   assign vcc = 1'b1;
   assign gnd = 1'b0;

   assign rstBa = bank;

   assign sync_system_reset_int =  sync_system_reset;  // internal copy of sync_system_reset

   assign rstHard = rstHard_0;  // align 0-deg reset with the others

   assign addr_mux              = confMReg[5];  // bit for ADDR_MUX, multiplexed address
   assign mr_dll_reset_bit      = confMReg[7];  // bit for DLL_RESET
   assign prev_mr_dll_reset_bit = rstAd[7];     // bit for DLL_RESET, previously set


   // -----------------------------------------------------------------------------
   // Generate a stable synchronous reset for the memory interface
   //   - asynchronously asserted, with system reset and DCM Lock
   //   - synchronously deasserted, once both sources of reset are gone
   // 
   // (1) sysReset is asynchronous, coming from an external source
   // (2) The DCM lock signal is considered asynchronous to the clock
   // 
   // Once sysReset is disabled (active high), the DCM starts acquiring lock;
   // this will take some time.
   // While dcmLocked stays low, ~dcmLocked is high and forces reset.
   // Once the DCM reaches "LOCKED", it will disable the asynchronous reset.
   // -----------------------------------------------------------------------------
//   assign sync_system_reset_pre = ( ~sysReset ) | ( ~dcmLocked );
   assign sync_system_reset_pre = ( ~dcmLocked );


   always @ ( posedge clk or posedge sync_system_reset_pre )
   begin
      if ( sync_system_reset_pre == 1'b1 )
      begin
         sys_rst_0         <= 1'b1;  // enable sync reset
         sys_rst_1         <= 1'b1;
         sys_rst_2         <= 1'b1;
         sys_rst_3         <= 1'b1;      
         sync_system_reset <= 1'b1;
      end
      else
      begin
         sys_rst_0         <= 1'b0;       // disable reset, inject zero
         sys_rst_1         <= sys_rst_0;  // propagate the zero
         sys_rst_2         <= sys_rst_1;
         sys_rst_3         <= sys_rst_2;
         sync_system_reset <= sys_rst_3;  // on the fifth clock, reset is disabled
      end
   end


   // -----------------------------------------------------------------------------
   // Sequence of reset for different clock domains, related to system clock
   //   - ripple main reset signal (hardInt) through 3/4 cycle minimum
   //   - all reset attached to system clock are synchronous
   // -----------------------------------------------------------------------------
   always @(posedge clk)
   begin
      rstHard_a1_0 <= hardInt;       // capture main reset with full cycle
      rstHard_0    <= rstHard_a1_0;  // create rstHard 0-deg reset (full cycle)
   end

   always @(posedge clk90)
   begin
      rstHard_90 <= rstHard_a1_180;  // capture 180-deg reset with 3/4 cycle
   end

   always @(posedge clk180)
   begin
      rstHard_a1_180 <= rstHard_a1_270;  // capture 270-deg reset with 3/4 cycle
      rstHard_180    <= rstHard_a1_180;  // create rstHard 180-deg reset (full cycle)
   end

   always @(posedge clk270)
   begin
      rstHard_a1_270 <= hardInt;         // capture main reset with 3/4 cycle
      rstHard_a2_270 <= rstHard_a1_270;  // re-align reset (full cycle)
      rstHard_270    <= rstHard_a2_270;  // create rstHard 270-deg reset (full cycle)
   end


   // -----------------------------------------------------------------------------
   // Reset sequence related to refClk clock
   //   - reset is controlled by FSM and it is a very long period (200us) => hardInt
   //   - capture main reset signal (hardInt) through metastable flops
   //   - system clock can vary from 175MHz (min memory's DLL) to 500MHz (max DLL)
   //   - so a clock period range of 5.715ns (~175MHz) down to 2.000ns (500MHz)
   //   - need one to three cycles delay which depends on system clock
   //   - delay has no impact on design, system clock module waits for refClk ready
   // -----------------------------------------------------------------------------
   always @( posedge refClk )
   begin
      rstHard_a1_refClk <= sync_system_reset;  // capture sync system reset (unknown phase but stable)
      rstHard_a2_refClk <= rstHard_a1_refClk;  // remove possible metastability (flops sequence)
      rstHard_refClk    <= rstHard_a2_refClk;  // create rstHard reset (full refClk cycle)
   end


   // -----------------------------------------------------------------------------
   // Init_Done, related to 270-deg system clock
   // -----------------------------------------------------------------------------
   always @(posedge clk270)
   begin
     Init_Done_a1_270 <= Init_Done;          // capture Init_Done with 3/4 cycle
     Init_Done_270    <= Init_Done_a1_270;   // create Init_Done 270-deg (full cycle)
   end


   // -----------------------------------------------------------------------------
   // Reset state machine
   //   - using stable sync system reset "sync_system_reset_int"
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( sync_system_reset_int )
         rstSt <= WAIT200us;
      else
         if ( rstSt == WAIT200us && Detect_final_WaitCnt == 1'b1 )
            rstSt <= RESET;
      else
         if ( rstSt == RESET )
            rstSt <= CONFIG;
      else
         if ( rstSt == CONFIG && cfgCnt == 5'b00000 )
            rstSt <= REFRESH;
      else
         if ( rstSt == REFRESH && waitTrc && bank == 3'b110 )
            rstSt <= WAIT_DLL_STABLE;
      else
         if ( rstSt == WAIT_DLL_STABLE && dll_is_stable )
            rstSt <= ALL_DONE;
      else
         if ( rstSt == ALL_DONE && issueMRS )
            rstSt <= MODE_CHANGE;
      else
         if ( rstSt == MODE_CHANGE && mrsCnt == 3'b000 )
            rstSt <= dll_reset_change ? WAIT_DLL_STABLE : ALL_DONE;
   end


   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // Wait for some time before releasing rstConfig after completing the 
   // REFRESH states specs ask for wait of Trc.  We wait for more time than that.
   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   always @( posedge clk )
   begin
      if ( ( SIMULATION_ONLY == 1'b0 && refCnt == REF_TRC ) || ( SIMULATION_ONLY == 1'b1 && refCnt == REF_TRC_shorten ) )
         waitTrc <= 1'b1;
      else
         waitTrc <= 1'b0;
   end

   always @( posedge clk )
   begin
      if ( rstSt == RESET )
         doRefresh <= 1'b0;
      else
         if ( ( SIMULATION_ONLY == 1'b0 && refCnt == REF_VAL ) || ( SIMULATION_ONLY == 1'b1 && refCnt == REF_VAL_shorten ) )
            doRefresh <= 1'b1;
         else
            doRefresh <= 1'b0;
   end


   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // Generation of external signals
   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   always @( posedge clk )
   begin
      if ( sync_system_reset_int )
      begin
         hardInt   <= 1'b1;
         rstConfig <= 1'b0;
         Init_Done <= 1'b0;
         rstCmd    <= NOP_CMD;
         rstAd     <= {DEV_AD_WIDTH{1'b0}};
         bank      <= 3'b000;
         refStart  <= 1'b1;
      end
      else
         if ( rstSt == RESET )
         begin
            hardInt   <= 1'b0;
            rstConfig <= 1'b1;
            Init_Done <= 1'b0;
            rstCmd    <= NOP_CMD;
            rstAd     <= {DEV_AD_WIDTH{1'b0}};  // keep the address bus low
            bank      <= 3'b111;
         end
         else
            if ( rstSt == CONFIG )
            begin
               case ( cfgCnt )
                  5'b01110:
                  begin
                     rstCmd <= MRS_CMD;
                     rstAd  <= {DEV_AD_WIDTH{1'b0}};
                  end
                  5'b01101:  rstCmd   <= MRS_CMD;
                  5'b01100:  
                  begin
                     rstCmd <= MRS_CMD;
                     rstAd     <= {{(DEV_AD_WIDTH-18){1'b0}}, confMReg[17:0]};
                  end
                  default:   rstCmd <= NOP_CMD;
               endcase
            end
         else
            if ( rstSt == REFRESH && doRefresh )
            begin
               rstCmd <= REF_CMD;
               if ( refStart )
                  refStart <= 1'b0;
               else 
                  case ( bank )
                     3'b111:  bank <= 3'b000;
                     3'b000:  bank <= 3'b001;
                     3'b001:  bank <= 3'b010;
                     3'b010:  bank <= 3'b011;
                     3'b011:  bank <= 3'b100;
                     3'b100:  bank <= 3'b101;
                     3'b101:  bank <= 3'b110;
                     3'b110:  bank <= 3'b111;
                  endcase
            end
            else
               if ( rstSt == REFRESH )
                  rstCmd <= NOP_CMD;
               else
                  if ( rstSt == WAIT_DLL_STABLE )
                     rstConfig <= 1'b0;
                  else
                     if ( rstSt == ALL_DONE )
                     begin
                        rstConfig <= 1'b0;
                        // make sure  "calibration_done = 1", i.e. tap calibration is complete
                        Init_Done <= calibration_done;
                     end
                     else
                        if ( rstSt == MODE_CHANGE )
                        begin
                           rstConfig <= 1'b1;
                           case ( mrsCnt )
                              3'b110:   rstCmd <= MRS_CMD;
                              default:  rstCmd <= NOP_CMD;
                           endcase
                           rstAd <= {{(DEV_AD_WIDTH-18){1'b0}}, confMReg};
                           bank  <= 3'b111;
                        end
   end


   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // Refresh counter
   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   always @( posedge clk )
   begin
      if ( sync_system_reset || rstSt == RESET || refCnt == 11'h000 )
         if ( SIMULATION_ONLY == 1'b0 )
            refCnt <= REF_VAL;
         else    // minimize the wait time when SIMULATION_ONLY is set
            refCnt <= REF_VAL_shorten;
      else
         if ( rstSt == CONFIG )
            refCnt <= refCnt - 1'b1;
         else
            if ( rstSt == REFRESH )
               refCnt <= refCnt - 1'b1;
   end


   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // Config counter
   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   always @( posedge clk )
   begin
      if ( sync_system_reset || rstSt == RESET )
         if ( addr_mux )
            cfgCnt <= 5'h15;  // 1_0101
         else
            cfgCnt <= 5'h0F;  // 0_1111
      else
         if ( rstSt == CONFIG )
            cfgCnt <= cfgCnt - 1'b1;
   end


   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   // MRS counter to handle Trc
   // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   always @( posedge clk )
   begin
      if ( sync_system_reset || rstSt == ALL_DONE )
         mrsCnt <= 3'b111;
      else
         if ( rstSt == MODE_CHANGE )
            mrsCnt <= mrsCnt - 1'b1;
   end


   // -------------------------------------------------------------------------
   // Indicates MRS is done
   // -------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( sync_system_reset || issueMRS )
         mrsDone_o <= 1'b0;
      else
         if ( rstSt == ALL_DONE )
            mrsDone_o <= 1'b1;
   end

   always @( posedge clk )
   begin
      if ( sync_system_reset )
         dll_reset_change <= 1'b0;
      else
         if ( ( rstSt == MODE_CHANGE ) && ( mrsCnt == 3'b111 ) )
            dll_reset_change <= ( prev_mr_dll_reset_bit != mr_dll_reset_bit );
   end

   // counter to wait for dll is stable (per Micron RLDRAM II Design Guide),
   // need to wait 1024 cycles for the dll locks
   always @( posedge clk )
   begin
      if ( sync_system_reset || issueMRS )
         dll_stable_wait_cnt <= 10'h000;
      else
         if ( rstSt == WAIT_DLL_STABLE )
            dll_stable_wait_cnt <= dll_stable_wait_cnt + 1;
   end

   always @( posedge clk )
   begin
      if ( sync_system_reset || issueMRS )
         dll_is_stable <= 1'b0;
      else
         if ( dll_stable_wait_cnt == 10'h3ff )
            dll_is_stable <= 1'b1;
   end


   // -----------------------------------------------------------------------------
   // Wait for a minimum of 200 us for memory initialization 
   // Use fixed reference clock refClk 200MHz for this counter
   //
   // Virtex-4 and Virtex-5 min-typ-max tolerance for refClk (200MHz +/- 10MHz)
   //                                  
   // 		freq    count   wait     wait time
   //                  (ticks)  time     (use fixed "high" count)
   // high      210MHz  42000   200us    200us
   // typical   200MHz  40000   200us    210us
   // low       190MHz  38000   200us    221.026316us
   //
   // Counter must used max frequency tolerance of refClk 210MHz (200MHz + 10MHz)
   // to cover the lowest clock period for the counter and guarantee a minimum of
   // 200us in all tolerances.
   // 
   // Max count at 210MHz is 42000 ticks, it requires 16-bit counter (~15.358 bits).
   // A fixed counter at 210MHz does not require a pre-scaler or a divide-by-x clock.
   // Of course, the count value will not depend on the input frequency.
   //
   // WaitCnt is compared against the parameter WAIT_FOR_POWER_STABLE_CNT.
   //
   // Add simulation-only parameter that minimizes wait time (SIMULATION_ONLY).
   // -----------------------------------------------------------------------------
   always @( posedge refClk )
   begin
      if ( rstHard_refClk )
         WaitCnt <= 16'h0000;
      else 
         if ( Detect_final_WaitCnt_refClk == 1'b0 )
            WaitCnt <= WaitCnt + 1'b1;
   end


   always @( posedge refClk )
   begin : simulation_only_disabled
      if ( rstHard_refClk )
         Detect_final_WaitCnt_refClk <= 1'b0;
      else
         if ( ( SIMULATION_ONLY == 1'b0 && WaitCnt == WAIT_FOR_POWER_STABLE_CNT ) || ( SIMULATION_ONLY == 1'b1 && WaitCnt == WAIT_FOR_POWER_STABLE_CNT_shorten ) )
            Detect_final_WaitCnt_refClk <= 1'b1;  // stays set once it sees "max count"
   end


   // Transfer to system clock domain, metastable flops in place
   //   - no reset needed, Detect_final_WaitCnt_refClk is stable
   //     long before the state machine rstSt comes out of reset.
   //   - once set, Detect_final_WaitCnt_refClk is stable until 
   //     another system reset occurs
   always @( posedge clk )
   begin
      Detect_final_WaitCnt_d1 <= Detect_final_WaitCnt_refClk;  // capture signal in clk domain
      Detect_final_WaitCnt    <= Detect_final_WaitCnt_d1;
   end


endmodule
