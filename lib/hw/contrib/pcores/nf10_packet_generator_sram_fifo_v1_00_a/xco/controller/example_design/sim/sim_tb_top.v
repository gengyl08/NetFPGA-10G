//*****************************************************************************
// DISCLAIMER OF LIABILITY
//
// This file contains proprietary and confidential information of
// Xilinx, Inc. ("Xilinx"), that is distributed under a license
// from Xilinx, and may be used, copied and/or disclosed only
// pursuant to the terms of a valid license agreement with Xilinx.
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
// LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
// MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
// does not warrant that functions included in the Materials will
// meet the requirements of Licensee, or that the operation of the
// Materials will be uninterrupted or error-free, or that defects
// in the Materials will be corrected. Furthermore, Xilinx does
// not warrant or make any representations regarding use, or the
// results of the use, of the Materials in terms of correctness,
// accuracy, reliability or otherwise.
//
// Xilinx products are not designed or intended to be fail-safe,
// or for use in any application requiring fail-safe performance,
// such as life-support or safety devices or systems, Class III
// medical devices, nuclear facilities, applications related to
// the deployment of airbags, or any other applications that could
// lead to death, personal injury or severe property or
// environmental damage (individually and collectively, "critical
// applications"). Customer assumes the sole risk and liability
// of any use of Xilinx products in critical applications,
// subject only to applicable laws and regulations governing
// limitations on product liability.
//
// Copyright 2008 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : %version
//  \   \         Application        : MIG
//  /   /         Filename           : sim_tb_top.v
// /___/   /\     Timestamp          : 15 May 2008
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:06 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//   This is the HDL testbench for demonstrating the top level ISE design
//   example. It includes an instantiation of the Samsung QDR II Burst Length 4
//   memory device generic Verilog model. It also generates the necessary
//   reference clock and reset signals for the top level I/O.
//
// Revision History:
//
//*****************************************************************************

`timescale  1 ns / 1 ps

module sim_tb_top();

// =============================================================================
//                         Design Specific Parameters
// =============================================================================

  // memory controller parameters
   localparam C0_QDRII_ADDR_WIDTH     = 19;       
                               // # of memory component address bits.
   localparam C0_QDRII_BURST_LENGTH   = 4;       
                               // # = 2 -> Burst Length 2 memory part,
                               
   localparam C0_QDRII_BW_WIDTH       = 4;       
                               // # of Byte Write Control bits.
   localparam F0_QDRII_DLL_FREQ_MODE  = "HIGH";       
                               // DCM's DLL Frequency mode.
   localparam F0_QDRII_CLK_PERIOD     = 4762;       
                               // Core\Memory clock period (in ps).
   localparam CLK_TYPE                = "DIFFERENTIAL";       
                               // # = "DIFFERENTIAL " -> Differential input clocks,
                               
   localparam C0_QDRII_CLK_WIDTH      = 1;       
                               // # of memory clock outputs. Represents
                               
   localparam C0_QDRII_CQ_WIDTH       = 1;       
                               // # of CQ bits.
   localparam C0_QDRII_DATA_WIDTH     = 36;       
                               // Design Data Width.
   localparam C0_QDRII_DEBUG_EN       = 0;       
                               // Enable debug signals/controls. When this
                               
   localparam C0_QDRII_HIGH_PERFORMANCE_MODE  = "TRUE";       
                               // # = "TRUE", the IODELAY performance mode
                               
   localparam C0_QDRII_MEMORY_WIDTH   = 36;       
                               // # of memory part's data width.
   localparam F0_QDRII_NOCLK200       = 0;       
                               // clk200 enable and disable.
   localparam RST_ACT_LOW             = 1;       
                               // # = 1 for active low reset,
                               
   localparam C0_QDRII_SIM_ONLY       = 1;       
                               // # = 1 to skip SRAM power up delay.
   localparam C1_QDRII_ADDR_WIDTH     = 19;       
                               // # of memory component address bits.
   localparam C1_QDRII_BURST_LENGTH   = 4;       
                               // # = 2 -> Burst Length 2 memory part,
                               
   localparam C1_QDRII_BW_WIDTH       = 4;       
                               // # of Byte Write Control bits.
   localparam C1_QDRII_CLK_WIDTH      = 1;       
                               // # of memory clock outputs. Represents
                               
   localparam C1_QDRII_CQ_WIDTH       = 1;       
                               // # of CQ bits.
   localparam C1_QDRII_DATA_WIDTH     = 36;       
                               // Design Data Width.
   localparam C1_QDRII_DEBUG_EN       = 0;       
                               // Enable debug signals/controls. When this
                               
   localparam C1_QDRII_HIGH_PERFORMANCE_MODE  = "TRUE";       
                               // # = "TRUE", the IODELAY performance mode
                               
   localparam C1_QDRII_MEMORY_WIDTH   = 36;       
                               // # of memory part's data width.
   localparam C1_QDRII_SIM_ONLY       = 1;       
                               // # = 1 to skip SRAM power up delay.
   localparam C2_QDRII_ADDR_WIDTH     = 19;       
                               // # of memory component address bits.
   localparam C2_QDRII_BURST_LENGTH   = 4;       
                               // # = 2 -> Burst Length 2 memory part,
                               
   localparam C2_QDRII_BW_WIDTH       = 4;       
                               // # of Byte Write Control bits.
   localparam C2_QDRII_CLK_WIDTH      = 1;       
                               // # of memory clock outputs. Represents
                               
   localparam C2_QDRII_CQ_WIDTH       = 1;       
                               // # of CQ bits.
   localparam C2_QDRII_DATA_WIDTH     = 36;       
                               // Design Data Width.
   localparam C2_QDRII_DEBUG_EN       = 0;       
                               // Enable debug signals/controls. When this
                               
   localparam C2_QDRII_HIGH_PERFORMANCE_MODE  = "TRUE";       
                               // # = "TRUE", the IODELAY performance mode
                               
   localparam MASTERBANK_PIN_WIDTH    = 2;       
                               // # of dummy inuput pins for the Master
                               
   localparam C2_QDRII_MEMORY_WIDTH   = 36;       
                               // # of memory part's data width.
   localparam C2_QDRII_SIM_ONLY       = 1        
                               ;// # = 1 to skip SRAM power up delay.

  localparam C0_QDRII_BW_COMP= C0_QDRII_MEMORY_WIDTH/9; 
  localparam C1_QDRII_BW_COMP= C1_QDRII_MEMORY_WIDTH/9; 
  localparam C2_QDRII_BW_COMP= C2_QDRII_MEMORY_WIDTH/9; 


   localparam      TPROP_PCB_CTRL      = 0.00; //Board delay value
   localparam      TPROP_PCB_CQ        = 0.00; //CQ delay value
   localparam      TPROP_PCB_DATA      = 0.00; //DQ delay value
   localparam      TPROP_PCB_DATA_RD   = 0.00; //READ DQ delay value
   localparam      RESET_PERIOD        = 200;    // in nSec
   localparam real F0_QDRII_HALF_CLK_PERIOD      = F0_QDRII_CLK_PERIOD / 2000.0;

   
   

// =============================================================================
//                         Test Bench Signal declaration
// =============================================================================


        reg                           qdrii_sys_clk_f0;
        wire                          qdrii_sys_clk_f0_n;
        wire                          qdrii_sys_clk_f0_p;
       
   reg                            sys_rst_n;
   reg                            clk_200;
   wire                           sys_rst_out;
   wire                           dly_clk_200_p;
   wire                           dly_clk_200_n;
   wire                           cal_done;
   wire                           compare_error;

   wire                               c0_compare_error;
   wire                               c0_cal_done;
   reg                                c0_qdr_w_n_sram;
   wire                               c0_qdr_w_n_fpga;
   reg                                c0_qdr_r_n_sram;
   wire                               c0_qdr_r_n_fpga;
   reg                                c0_qdr_dll_off_n_sram;
   wire                               c0_qdr_dll_off_n_fpga;
   reg  [C0_QDRII_CLK_WIDTH-1:0]      c0_qdr_k_sram;
   wire [C0_QDRII_CLK_WIDTH-1:0]      c0_qdr_k_fpga;
   reg  [C0_QDRII_CLK_WIDTH-1:0]      c0_qdr_k_n_sram;
   wire [C0_QDRII_CLK_WIDTH-1:0]      c0_qdr_k_n_fpga;
   wire [C0_QDRII_CLK_WIDTH-1:0]      c0_qdr_c;
   wire [C0_QDRII_CLK_WIDTH-1:0]      c0_qdr_c_n;
   reg  [C0_QDRII_ADDR_WIDTH-1:0]     c0_qdr_sa_sram;
   wire [C0_QDRII_ADDR_WIDTH-1:0]     c0_qdr_sa_fpga;
   reg  [C0_QDRII_BW_WIDTH-1:0]       c0_qdr_bw_n_sram;
   wire [C0_QDRII_BW_WIDTH-1:0]       c0_qdr_bw_n_fpga;
   reg  [C0_QDRII_DATA_WIDTH-1:0]     c0_qdr_d_sram;
   wire [C0_QDRII_DATA_WIDTH-1:0]     c0_qdr_d_fpga;
   reg  [C0_QDRII_DATA_WIDTH-1:0]     c0_qdr_q_fpga;
   wire [C0_QDRII_DATA_WIDTH-1:0]     c0_qdr_q_sram;
   reg  [C0_QDRII_CQ_WIDTH-1:0]       c0_qdr_cq_fpga;
   wire [C0_QDRII_CQ_WIDTH-1:0]       c0_qdr_cq_sram;
   reg  [C0_QDRII_CQ_WIDTH-1:0]       c0_qdr_cq_n_fpga;
   wire [C0_QDRII_CQ_WIDTH-1:0]       c0_qdr_cq_n_sram;
   wire                               c1_compare_error;
   wire                               c1_cal_done;
   reg                                c1_qdr_w_n_sram;
   wire                               c1_qdr_w_n_fpga;
   reg                                c1_qdr_r_n_sram;
   wire                               c1_qdr_r_n_fpga;
   reg                                c1_qdr_dll_off_n_sram;
   wire                               c1_qdr_dll_off_n_fpga;
   reg  [C1_QDRII_CLK_WIDTH-1:0]      c1_qdr_k_sram;
   wire [C1_QDRII_CLK_WIDTH-1:0]      c1_qdr_k_fpga;
   reg  [C1_QDRII_CLK_WIDTH-1:0]      c1_qdr_k_n_sram;
   wire [C1_QDRII_CLK_WIDTH-1:0]      c1_qdr_k_n_fpga;
   wire [C1_QDRII_CLK_WIDTH-1:0]      c1_qdr_c;
   wire [C1_QDRII_CLK_WIDTH-1:0]      c1_qdr_c_n;
   reg  [C1_QDRII_ADDR_WIDTH-1:0]     c1_qdr_sa_sram;
   wire [C1_QDRII_ADDR_WIDTH-1:0]     c1_qdr_sa_fpga;
   reg  [C1_QDRII_BW_WIDTH-1:0]       c1_qdr_bw_n_sram;
   wire [C1_QDRII_BW_WIDTH-1:0]       c1_qdr_bw_n_fpga;
   reg  [C1_QDRII_DATA_WIDTH-1:0]     c1_qdr_d_sram;
   wire [C1_QDRII_DATA_WIDTH-1:0]     c1_qdr_d_fpga;
   reg  [C1_QDRII_DATA_WIDTH-1:0]     c1_qdr_q_fpga;
   wire [C1_QDRII_DATA_WIDTH-1:0]     c1_qdr_q_sram;
   reg  [C1_QDRII_CQ_WIDTH-1:0]       c1_qdr_cq_fpga;
   wire [C1_QDRII_CQ_WIDTH-1:0]       c1_qdr_cq_sram;
   reg  [C1_QDRII_CQ_WIDTH-1:0]       c1_qdr_cq_n_fpga;
   wire [C1_QDRII_CQ_WIDTH-1:0]       c1_qdr_cq_n_sram;
   wire                               c2_compare_error;
   wire                               c2_cal_done;
   reg                                c2_qdr_w_n_sram;
   wire                               c2_qdr_w_n_fpga;
   reg                                c2_qdr_r_n_sram;
   wire                               c2_qdr_r_n_fpga;
   reg                                c2_qdr_dll_off_n_sram;
   wire                               c2_qdr_dll_off_n_fpga;
   reg  [C2_QDRII_CLK_WIDTH-1:0]      c2_qdr_k_sram;
   wire [C2_QDRII_CLK_WIDTH-1:0]      c2_qdr_k_fpga;
   reg  [C2_QDRII_CLK_WIDTH-1:0]      c2_qdr_k_n_sram;
   wire [C2_QDRII_CLK_WIDTH-1:0]      c2_qdr_k_n_fpga;
   wire [C2_QDRII_CLK_WIDTH-1:0]      c2_qdr_c;
   wire [C2_QDRII_CLK_WIDTH-1:0]      c2_qdr_c_n;
   reg  [C2_QDRII_ADDR_WIDTH-1:0]     c2_qdr_sa_sram;
   wire [C2_QDRII_ADDR_WIDTH-1:0]     c2_qdr_sa_fpga;
   reg  [C2_QDRII_BW_WIDTH-1:0]       c2_qdr_bw_n_sram;
   wire [C2_QDRII_BW_WIDTH-1:0]       c2_qdr_bw_n_fpga;
   reg  [C2_QDRII_DATA_WIDTH-1:0]     c2_qdr_d_sram;
   wire [C2_QDRII_DATA_WIDTH-1:0]     c2_qdr_d_fpga;
   reg  [C2_QDRII_DATA_WIDTH-1:0]     c2_qdr_q_fpga;
   wire [C2_QDRII_DATA_WIDTH-1:0]     c2_qdr_q_sram;
   reg  [C2_QDRII_CQ_WIDTH-1:0]       c2_qdr_cq_fpga;
   wire [C2_QDRII_CQ_WIDTH-1:0]       c2_qdr_cq_sram;
   reg  [C2_QDRII_CQ_WIDTH-1:0]       c2_qdr_cq_n_fpga;
   wire [C2_QDRII_CQ_WIDTH-1:0]       c2_qdr_cq_n_sram;
   wire [MASTERBANK_PIN_WIDTH-1:0]    masterbank_sel_pin;

   wire TDO;
   reg TCK, TMS, TDI, ZQ;






   assign masterbank_sel_pin = {MASTERBANK_PIN_WIDTH{1'b0}};

// =============================================================================
//                         CLOCKS and RESET Generation
// =============================================================================

   initial begin
     qdrii_sys_clk_f0 = 0;
        
     sys_rst_n = 0;
     clk_200 = 0;
   end

   // Generate 200MHz reference clock
   always #2.500 clk_200 = ~clk_200;

   assign dly_clk_200_p = clk_200;
   assign dly_clk_200_n = ~clk_200;

   
   // Generate design clock
   always #(F0_QDRII_HALF_CLK_PERIOD) qdrii_sys_clk_f0 = ~qdrii_sys_clk_f0;

   assign qdrii_sys_clk_f0_p = qdrii_sys_clk_f0;
   assign qdrii_sys_clk_f0_n = ~qdrii_sys_clk_f0;
        

   // Generate Reset. The active low reset is generated.
   initial begin
     #(RESET_PERIOD) sys_rst_n = 1;
   end

   // Polarity of the reset for the memory controller instantiated can be changed
   // by changing the parameter RST_ACT_LOW value.
   assign sys_rst_out = RST_ACT_LOW ? sys_rst_n : ~sys_rst_n;

// =============================================================================
//                             BOARD Parameters
// =============================================================================
// These parameter values can be changed to model varying board delays
// between the Virtex-5 device and the QDR II memory model

always @( c0_qdr_w_n_fpga or c0_qdr_r_n_fpga or c0_qdr_dll_off_n_fpga or c0_qdr_k_fpga or c0_qdr_k_n_fpga or c0_qdr_sa_fpga or c0_qdr_bw_n_fpga or c0_qdr_d_fpga or c0_qdr_q_sram or c0_qdr_cq_sram or c0_qdr_cq_n_sram ) begin
    c0_qdr_w_n_sram           <= #(TPROP_PCB_CTRL) c0_qdr_w_n_fpga;
    c0_qdr_r_n_sram           <= #(TPROP_PCB_CTRL) c0_qdr_r_n_fpga;
    c0_qdr_dll_off_n_sram     <= #(TPROP_PCB_CTRL) c0_qdr_dll_off_n_fpga;
    c0_qdr_k_sram             <= #(TPROP_PCB_CTRL) c0_qdr_k_fpga;
    c0_qdr_k_n_sram           <= #(TPROP_PCB_CTRL) c0_qdr_k_n_fpga;
    c0_qdr_sa_sram            <= #(TPROP_PCB_CTRL) c0_qdr_sa_fpga;
    c0_qdr_bw_n_sram          <= #(TPROP_PCB_CTRL) c0_qdr_bw_n_fpga;
    c0_qdr_d_sram             <= #(TPROP_PCB_CTRL) c0_qdr_d_fpga;
    c0_qdr_q_fpga             <= #(TPROP_PCB_CTRL) c0_qdr_q_sram;
    c0_qdr_cq_fpga            <= #(TPROP_PCB_CTRL) c0_qdr_cq_sram;
    c0_qdr_cq_n_fpga          <= #(TPROP_PCB_CTRL) c0_qdr_cq_n_sram;
  end

always @( c1_qdr_w_n_fpga or c1_qdr_r_n_fpga or c1_qdr_dll_off_n_fpga or c1_qdr_k_fpga or c1_qdr_k_n_fpga or c1_qdr_sa_fpga or c1_qdr_bw_n_fpga or c1_qdr_d_fpga or c1_qdr_q_sram or c1_qdr_cq_sram or c1_qdr_cq_n_sram ) begin
    c1_qdr_w_n_sram           <= #(TPROP_PCB_CTRL) c1_qdr_w_n_fpga;
    c1_qdr_r_n_sram           <= #(TPROP_PCB_CTRL) c1_qdr_r_n_fpga;
    c1_qdr_dll_off_n_sram     <= #(TPROP_PCB_CTRL) c1_qdr_dll_off_n_fpga;
    c1_qdr_k_sram             <= #(TPROP_PCB_CTRL) c1_qdr_k_fpga;
    c1_qdr_k_n_sram           <= #(TPROP_PCB_CTRL) c1_qdr_k_n_fpga;
    c1_qdr_sa_sram            <= #(TPROP_PCB_CTRL) c1_qdr_sa_fpga;
    c1_qdr_bw_n_sram          <= #(TPROP_PCB_CTRL) c1_qdr_bw_n_fpga;
    c1_qdr_d_sram             <= #(TPROP_PCB_CTRL) c1_qdr_d_fpga;
    c1_qdr_q_fpga             <= #(TPROP_PCB_CTRL) c1_qdr_q_sram;
    c1_qdr_cq_fpga            <= #(TPROP_PCB_CTRL) c1_qdr_cq_sram;
    c1_qdr_cq_n_fpga          <= #(TPROP_PCB_CTRL) c1_qdr_cq_n_sram;
  end

always @( c2_qdr_w_n_fpga or c2_qdr_r_n_fpga or c2_qdr_dll_off_n_fpga or c2_qdr_k_fpga or c2_qdr_k_n_fpga or c2_qdr_sa_fpga or c2_qdr_bw_n_fpga or c2_qdr_d_fpga or c2_qdr_q_sram or c2_qdr_cq_sram or c2_qdr_cq_n_sram ) begin
    c2_qdr_w_n_sram           <= #(TPROP_PCB_CTRL) c2_qdr_w_n_fpga;
    c2_qdr_r_n_sram           <= #(TPROP_PCB_CTRL) c2_qdr_r_n_fpga;
    c2_qdr_dll_off_n_sram     <= #(TPROP_PCB_CTRL) c2_qdr_dll_off_n_fpga;
    c2_qdr_k_sram             <= #(TPROP_PCB_CTRL) c2_qdr_k_fpga;
    c2_qdr_k_n_sram           <= #(TPROP_PCB_CTRL) c2_qdr_k_n_fpga;
    c2_qdr_sa_sram            <= #(TPROP_PCB_CTRL) c2_qdr_sa_fpga;
    c2_qdr_bw_n_sram          <= #(TPROP_PCB_CTRL) c2_qdr_bw_n_fpga;
    c2_qdr_d_sram             <= #(TPROP_PCB_CTRL) c2_qdr_d_fpga;
    c2_qdr_q_fpga             <= #(TPROP_PCB_CTRL) c2_qdr_q_sram;
    c2_qdr_cq_fpga            <= #(TPROP_PCB_CTRL) c2_qdr_cq_sram;
    c2_qdr_cq_n_fpga          <= #(TPROP_PCB_CTRL) c2_qdr_cq_n_sram;
  end







// =============================================================================
//                          FPGA Memory Controller
// =============================================================================

   controller #
     (
      .C0_QDRII_ADDR_WIDTH      (C0_QDRII_ADDR_WIDTH),
      .C0_QDRII_BURST_LENGTH    (C0_QDRII_BURST_LENGTH),
      .C0_QDRII_BW_WIDTH        (C0_QDRII_BW_WIDTH),
      .F0_QDRII_DLL_FREQ_MODE   (F0_QDRII_DLL_FREQ_MODE),
      .F0_QDRII_CLK_PERIOD      (F0_QDRII_CLK_PERIOD),
      .CLK_TYPE                 (CLK_TYPE),
      .C0_QDRII_CLK_WIDTH       (C0_QDRII_CLK_WIDTH),
      .C0_QDRII_CQ_WIDTH        (C0_QDRII_CQ_WIDTH),
      .C0_QDRII_DATA_WIDTH      (C0_QDRII_DATA_WIDTH),
      .C0_QDRII_DEBUG_EN        (C0_QDRII_DEBUG_EN),
      .C0_QDRII_HIGH_PERFORMANCE_MODE   (C0_QDRII_HIGH_PERFORMANCE_MODE),
      .C0_QDRII_MEMORY_WIDTH    (C0_QDRII_MEMORY_WIDTH),
      .F0_QDRII_NOCLK200        (F0_QDRII_NOCLK200),
      .RST_ACT_LOW              (RST_ACT_LOW),
      .C0_QDRII_SIM_ONLY        (C0_QDRII_SIM_ONLY),
      .C1_QDRII_ADDR_WIDTH      (C1_QDRII_ADDR_WIDTH),
      .C1_QDRII_BURST_LENGTH    (C1_QDRII_BURST_LENGTH),
      .C1_QDRII_BW_WIDTH        (C1_QDRII_BW_WIDTH),
      .C1_QDRII_CLK_WIDTH       (C1_QDRII_CLK_WIDTH),
      .C1_QDRII_CQ_WIDTH        (C1_QDRII_CQ_WIDTH),
      .C1_QDRII_DATA_WIDTH      (C1_QDRII_DATA_WIDTH),
      .C1_QDRII_DEBUG_EN        (C1_QDRII_DEBUG_EN),
      .C1_QDRII_HIGH_PERFORMANCE_MODE   (C1_QDRII_HIGH_PERFORMANCE_MODE),
      .C1_QDRII_MEMORY_WIDTH    (C1_QDRII_MEMORY_WIDTH),
      .C1_QDRII_SIM_ONLY        (C1_QDRII_SIM_ONLY),
      .C2_QDRII_ADDR_WIDTH      (C2_QDRII_ADDR_WIDTH),
      .C2_QDRII_BURST_LENGTH    (C2_QDRII_BURST_LENGTH),
      .C2_QDRII_BW_WIDTH        (C2_QDRII_BW_WIDTH),
      .C2_QDRII_CLK_WIDTH       (C2_QDRII_CLK_WIDTH),
      .C2_QDRII_CQ_WIDTH        (C2_QDRII_CQ_WIDTH),
      .C2_QDRII_DATA_WIDTH      (C2_QDRII_DATA_WIDTH),
      .C2_QDRII_DEBUG_EN        (C2_QDRII_DEBUG_EN),
      .C2_QDRII_HIGH_PERFORMANCE_MODE   (C2_QDRII_HIGH_PERFORMANCE_MODE),
      .MASTERBANK_PIN_WIDTH     (MASTERBANK_PIN_WIDTH),
      .C2_QDRII_MEMORY_WIDTH    (C2_QDRII_MEMORY_WIDTH),
      .C2_QDRII_SIM_ONLY        (C2_QDRII_SIM_ONLY)
      )
     U_MEM_CONTROLLER
       (
    .c0_qdr_d                  (c0_qdr_d_fpga),
    .c0_qdr_q                  (c0_qdr_q_fpga),
    .c0_qdr_sa                 (c0_qdr_sa_fpga),
    .c0_qdr_w_n                (c0_qdr_w_n_fpga),
    .c0_qdr_r_n                (c0_qdr_r_n_fpga),
    .c0_qdr_dll_off_n          (c0_qdr_dll_off_n_fpga),
    .c0_qdr_bw_n               (c0_qdr_bw_n_fpga),
    .qdrii_sys_clk_f0_p        (qdrii_sys_clk_f0_p),
    .qdrii_sys_clk_f0_n        (qdrii_sys_clk_f0_n),
    .dly_clk_200_p             (dly_clk_200_p),
    .dly_clk_200_n             (dly_clk_200_n),
    .masterbank_sel_pin        (masterbank_sel_pin),
    .sys_rst_n                  (sys_rst_out),
    .c0_cal_done               (c0_cal_done),
    .c0_compare_error          (c0_compare_error),
    .c0_qdr_cq                 (c0_qdr_cq_fpga),
    .c0_qdr_cq_n               (c0_qdr_cq_n_fpga),
    .c0_qdr_k                  (c0_qdr_k_fpga),
    .c0_qdr_k_n                (c0_qdr_k_n_fpga),
    .c0_qdr_c                  (c0_qdr_c),
    .c0_qdr_c_n                (c0_qdr_c_n),
    .c1_qdr_d                  (c1_qdr_d_fpga),
    .c1_qdr_q                  (c1_qdr_q_fpga),
    .c1_qdr_sa                 (c1_qdr_sa_fpga),
    .c1_qdr_w_n                (c1_qdr_w_n_fpga),
    .c1_qdr_r_n                (c1_qdr_r_n_fpga),
    .c1_qdr_dll_off_n          (c1_qdr_dll_off_n_fpga),
    .c1_qdr_bw_n               (c1_qdr_bw_n_fpga),
    .c1_cal_done               (c1_cal_done),
    .c1_compare_error          (c1_compare_error),
    .c1_qdr_cq                 (c1_qdr_cq_fpga),
    .c1_qdr_cq_n               (c1_qdr_cq_n_fpga),
    .c1_qdr_k                  (c1_qdr_k_fpga),
    .c1_qdr_k_n                (c1_qdr_k_n_fpga),
    .c1_qdr_c                  (c1_qdr_c),
    .c1_qdr_c_n                (c1_qdr_c_n),
    .c2_qdr_d                  (c2_qdr_d_fpga),
    .c2_qdr_q                  (c2_qdr_q_fpga),
    .c2_qdr_sa                 (c2_qdr_sa_fpga),
    .c2_qdr_w_n                (c2_qdr_w_n_fpga),
    .c2_qdr_r_n                (c2_qdr_r_n_fpga),
    .c2_qdr_dll_off_n          (c2_qdr_dll_off_n_fpga),
    .c2_qdr_bw_n               (c2_qdr_bw_n_fpga),
    .c2_cal_done               (c2_cal_done),
    .c2_compare_error          (c2_compare_error),
    .c2_qdr_cq                 (c2_qdr_cq_fpga),
    .c2_qdr_cq_n               (c2_qdr_cq_n_fpga),
    .c2_qdr_k                  (c2_qdr_k_fpga),
    .c2_qdr_k_n                (c2_qdr_k_n_fpga),
    .c2_qdr_c                  (c2_qdr_c),
    .c2_qdr_c_n                (c2_qdr_c_n)
        );





   assign cal_done = c0_cal_done & c1_cal_done & c2_cal_done;
   assign compare_error = c0_compare_error | c1_compare_error | c2_compare_error;

// =============================================================================
//                              Memory Model
// =============================================================================

cyqdr2_b4 mem0 (
   .TCK(TCK),
   .TMS(TMS),
   .TDI(TDI),
   .TDO(TDO),
   .D(c0_qdr_d_sram),
   .Q(c0_qdr_q_sram),
   .A(c0_qdr_sa_sram),
   .K(c0_qdr_k_sram),
   .Kb(c0_qdr_k_n_sram),
   .C(c0_qdr_c),
   .Cb(c0_qdr_c_n),
   .RPSb(c0_qdr_r_n_sram),
   .WPSb(c0_qdr_w_n_sram),
   .BWS0b(c0_qdr_bw_n_sram[0]),
   .BWS1b(c0_qdr_bw_n_sram[1]),
   .BWS2b(c0_qdr_bw_n_sram[2]),
   .BWS3b(c0_qdr_bw_n_sram[3]),
   .CQ(c0_qdr_cq_sram),
   .CQb(c0_qdr_cq_n_sram),
   .ZQ(ZQ),
   .DOFF(c0_qdr_dll_off_n_sram));

cyqdr2_b4 mem1 (
   .TCK(TCK),
   .TMS(TMS),
   .TDI(TDI),
   .TDO(TDO),
   .D(c1_qdr_d_sram),
   .Q(c1_qdr_q_sram),
   .A(c1_qdr_sa_sram),
   .K(c1_qdr_k_sram),
   .Kb(c1_qdr_k_n_sram),
   .C(c1_qdr_c),
   .Cb(c1_qdr_c_n),
   .RPSb(c1_qdr_r_n_sram),
   .WPSb(c1_qdr_w_n_sram),
   .BWS0b(c1_qdr_bw_n_sram[0]),
   .BWS1b(c1_qdr_bw_n_sram[1]),
   .BWS2b(c1_qdr_bw_n_sram[2]),
   .BWS3b(c1_qdr_bw_n_sram[3]),
   .CQ(c1_qdr_cq_sram),
   .CQb(c1_qdr_cq_n_sram),
   .ZQ(ZQ),
   .DOFF(c1_qdr_dll_off_n_sram));

cyqdr2_b4 mem2 (
   .TCK(TCK),
   .TMS(TMS),
   .TDI(TDI),
   .TDO(TDO),
   .D(c2_qdr_d_sram),
   .Q(c2_qdr_q_sram),
   .A(c2_qdr_sa_sram),
   .K(c2_qdr_k_sram),
   .Kb(c2_qdr_k_n_sram),
   .C(c2_qdr_c),
   .Cb(c2_qdr_c_n),
   .RPSb(c2_qdr_r_n_sram),
   .WPSb(c2_qdr_w_n_sram),
   .BWS0b(c2_qdr_bw_n_sram[0]),
   .BWS1b(c2_qdr_bw_n_sram[1]),
   .BWS2b(c2_qdr_bw_n_sram[2]),
   .BWS3b(c2_qdr_bw_n_sram[3]),
   .CQ(c2_qdr_cq_sram),
   .CQb(c2_qdr_cq_n_sram),
   .ZQ(ZQ),
   .DOFF(c2_qdr_dll_off_n_sram));


endmodule

















