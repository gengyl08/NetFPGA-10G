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
// Copyright 2006, 2007, 2008 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.0
//  \   \         Application        : MIG
//  /   /         Filename           : netfpga_c012.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2009/02/03 19:30:00 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//   Top-level module. Simple model for what the user might use
//   Typically, the user will only instantiate MEM_INTERFACE_TOP in their
//   code, and generate all backend logic (test bench) separately.
//   In addition to the memory controller, the module instantiates:
//     1. Clock generation/distribution, reset logic
//     2. IDELAY control block
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

(* X_CORE_INFO = "mig_v3_0_qdrii_v5, Coregen 11.1" , CORE_GENERATION_INFO = "qdrii_v5,mig_v3_0,{component_name=sram_controller_top, C0_ADDR_WIDTH = 19, C0_BURST_LENGTH = 4, C0_BW_WIDTH = 4, C0_CLK_FREQ = 300, C0_CLK_WIDTH = 1, C0_CQ_WIDTH = 1, C0_DATA_WIDTH = 36, C0_MEMORY_WIDTH = 36, RST_ACT_LOW = 1,C1_ADDR_WIDTH = 19, C1_BURST_LENGTH = 4, C1_BW_WIDTH = 4, C1_CLK_FREQ = 300, C1_CLK_WIDTH = 1, C1_CQ_WIDTH = 1, C1_DATA_WIDTH = 36, C1_MEMORY_WIDTH = 36, RST_ACT_LOW = 1,C2_ADDR_WIDTH = 19, C2_BURST_LENGTH = 4, C2_BW_WIDTH = 4, C2_CLK_FREQ = 300, C2_CLK_WIDTH = 1, C2_CQ_WIDTH = 1, C2_DATA_WIDTH = 36, C2_MEMORY_WIDTH = 36, RST_ACT_LOW = 1}" *)
module sram_controller_top #
  (
   parameter C0_QDRII_ADDR_WIDTH     = 19,       
                               // # of memory component address bits.
   parameter C0_QDRII_BURST_LENGTH   = 4,       
                               // # = 2 -> Burst Length 2 memory part,
                               
   parameter C0_QDRII_BW_WIDTH       = 4,       
                               // # of Byte Write Control bits.
   parameter QDRII_CLK_FREQ          = 250,       
                               // Core\Memory clock frequency (in MHz).                               
   parameter C0_QDRII_CLK_WIDTH      = 1,       
                               // # of memory clock outputs. Represents
                               
   parameter C0_QDRII_CQ_WIDTH       = 1,       
                               // # of CQ bits.
   parameter C0_QDRII_DATA_WIDTH     = 36,       
                               // Design Data Width.
   parameter C0_QDRII_DEBUG_EN       = 0,       
                               // Enable debug signals/controls. When this

   parameter HIGH_PERFORMANCE_MODE   = "TRUE",       
                               // # = "TRUE", the IODELAY performance mode
                               
   parameter C0_QDRII_MEMORY_WIDTH   = 36,       
                               // # of memory part's data width.
   parameter RST_ACT_LOW             = 1,       
                               // # = 1 for active low reset,
                               
   parameter C0_QDRII_SIM_ONLY       = 1,       
                               // # = 1 to skip SRAM power up delay.
   parameter C1_QDRII_ADDR_WIDTH     = 19,      
                               // # of memory component address bits.
   parameter C1_QDRII_BURST_LENGTH   = 4,       
                               // # = 2 -> Burst Length 2 memory part,
                               
   parameter C1_QDRII_BW_WIDTH       = 4,       
                               // # of Byte Write Control bits.
   parameter C1_QDRII_CLK_WIDTH      = 1,       
                               // # of memory clock outputs. Represents
                               
   parameter C1_QDRII_CQ_WIDTH       = 1,       
                               // # of CQ bits.
   parameter C1_QDRII_DATA_WIDTH     = 36,       
                               // Design Data Width.
   parameter C1_QDRII_DEBUG_EN       = 0,       
                               // Enable debug signals/controls. When this
                               
   parameter C1_QDRII_MEMORY_WIDTH   = 36,       
                               // # of memory part's data width.
   parameter C1_QDRII_SIM_ONLY       = 1,       
                               // # = 1 to skip SRAM power up delay.
   parameter C2_QDRII_ADDR_WIDTH     = 19,       
                               // # of memory component address bits.
   parameter C2_QDRII_BURST_LENGTH   = 4,       
                               // # = 2 -> Burst Length 2 memory part,
                               
   parameter C2_QDRII_BW_WIDTH       = 4,       
                               // # of Byte Write Control bits.
   parameter C2_QDRII_CLK_WIDTH      = 1,       
                               // # of memory clock outputs. Represents
                               
   parameter C2_QDRII_CQ_WIDTH       = 1,       
                               // # of CQ bits.
   parameter C2_QDRII_DATA_WIDTH     = 36,       
                               // Design Data Width.
   parameter C2_QDRII_DEBUG_EN       = 0,       
                               // Enable debug signals/controls. When this
                               
   parameter MASTERBANK_PIN_WIDTH    = 3,       
                               // # of dummy inuput pins for the Master
                               
   parameter C2_QDRII_MEMORY_WIDTH   = 36,       
                               // # of memory part's data width.
   parameter C2_QDRII_SIM_ONLY       = 1        
                               // # = 1 to skip SRAM power up delay.
   )
  (
   output [C0_QDRII_DATA_WIDTH-1:0]            c0_qdr_d,
   input  [C0_QDRII_DATA_WIDTH-1:0]            c0_qdr_q,
   output [C0_QDRII_ADDR_WIDTH-1:0]            c0_qdr_sa,
   output                                     c0_qdr_w_n,
   output                                     c0_qdr_r_n,
   output                                     c0_qdr_dll_off_n,
   output [C0_QDRII_BW_WIDTH-1:0]              c0_qdr_bw_n,
   input                                      locked,
   input                                      clk0,
   input                                      clk270,
   input                                      clk200,
   output reg				      c0_user_rst_0,
   output reg				      c1_user_rst_0,
   output reg				      c2_user_rst_0,
   input                                      sys_rst_n,
   output                                     c0_cal_done,
   input                                      c0_user_ad_w_n,
   input                                      c0_user_d_w_n,
   input                                      c0_user_r_n,
   output                                     c0_user_wr_full,
   output                                     c0_user_rd_full,
   output                                     c0_user_qr_valid,
   input  [C0_QDRII_DATA_WIDTH-1:0]            c0_user_dwl,
   input  [C0_QDRII_DATA_WIDTH-1:0]            c0_user_dwh,
   output [C0_QDRII_DATA_WIDTH-1:0]            c0_user_qrl,
   output [C0_QDRII_DATA_WIDTH-1:0]            c0_user_qrh,
   input  [C0_QDRII_BW_WIDTH-1:0]              c0_user_bwl_n,
   input  [C0_QDRII_BW_WIDTH-1:0]              c0_user_bwh_n,
   input  [C0_QDRII_ADDR_WIDTH-1:0]            c0_user_ad_wr,
   input  [C0_QDRII_ADDR_WIDTH-1:0]            c0_user_ad_rd,
   input  [C0_QDRII_CQ_WIDTH-1:0]              c0_qdr_cq,
   input  [C0_QDRII_CQ_WIDTH-1:0]              c0_qdr_cq_n,
   output [C0_QDRII_CLK_WIDTH-1:0]             c0_qdr_k,
   output [C0_QDRII_CLK_WIDTH-1:0]             c0_qdr_k_n,
   output [C0_QDRII_CLK_WIDTH-1:0]             c0_qdr_c,
   output [C0_QDRII_CLK_WIDTH-1:0]             c0_qdr_c_n,
   output [C1_QDRII_DATA_WIDTH-1:0]            c1_qdr_d,
   input  [C1_QDRII_DATA_WIDTH-1:0]            c1_qdr_q,
   output [C1_QDRII_ADDR_WIDTH-1:0]            c1_qdr_sa,
   output                                     c1_qdr_w_n,
   output                                     c1_qdr_r_n,
   output                                     c1_qdr_dll_off_n,
   output [C1_QDRII_BW_WIDTH-1:0]              c1_qdr_bw_n,
   output                                     c1_cal_done,
   input                                      c1_user_ad_w_n,
   input                                      c1_user_d_w_n,
   input                                      c1_user_r_n,
   output                                     c1_user_wr_full,
   output                                     c1_user_rd_full,
   output                                     c1_user_qr_valid,
   input  [C1_QDRII_DATA_WIDTH-1:0]            c1_user_dwl,
   input  [C1_QDRII_DATA_WIDTH-1:0]            c1_user_dwh,
   output [C1_QDRII_DATA_WIDTH-1:0]            c1_user_qrl,
   output [C1_QDRII_DATA_WIDTH-1:0]            c1_user_qrh,
   input  [C1_QDRII_BW_WIDTH-1:0]              c1_user_bwl_n,
   input  [C1_QDRII_BW_WIDTH-1:0]              c1_user_bwh_n,
   input  [C1_QDRII_ADDR_WIDTH-1:0]            c1_user_ad_wr,
   input  [C1_QDRII_ADDR_WIDTH-1:0]            c1_user_ad_rd,
   input  [C1_QDRII_CQ_WIDTH-1:0]              c1_qdr_cq,
   input  [C1_QDRII_CQ_WIDTH-1:0]              c1_qdr_cq_n,
   output [C1_QDRII_CLK_WIDTH-1:0]             c1_qdr_k,
   output [C1_QDRII_CLK_WIDTH-1:0]             c1_qdr_k_n,
   output [C1_QDRII_CLK_WIDTH-1:0]             c1_qdr_c,
   output [C1_QDRII_CLK_WIDTH-1:0]             c1_qdr_c_n,
/*synthesis syn_keep = 1 */(* S = "TRUE" *)
   input  [MASTERBANK_PIN_WIDTH-1:0]  masterbank_sel_pin,
   
   output [C2_QDRII_DATA_WIDTH-1:0]            c2_qdr_d,
   input  [C2_QDRII_DATA_WIDTH-1:0]            c2_qdr_q,
   output [C2_QDRII_ADDR_WIDTH-1:0]            c2_qdr_sa,
   output                                     c2_qdr_w_n,
   output                                     c2_qdr_r_n,
   output                                     c2_qdr_dll_off_n,
   output [C2_QDRII_BW_WIDTH-1:0]              c2_qdr_bw_n,

   output                                     c2_cal_done,
   input                                      c2_user_ad_w_n,
   input                                      c2_user_d_w_n,
   input                                      c2_user_r_n,
   output                                     c2_user_wr_full,
   output                                     c2_user_rd_full,
   output                                     c2_user_qr_valid,
   input  [C2_QDRII_DATA_WIDTH-1:0]            c2_user_dwl,
   input  [C2_QDRII_DATA_WIDTH-1:0]            c2_user_dwh,
   output [C2_QDRII_DATA_WIDTH-1:0]            c2_user_qrl,
   output [C2_QDRII_DATA_WIDTH-1:0]            c2_user_qrh,
   input  [C2_QDRII_BW_WIDTH-1:0]              c2_user_bwl_n,
   input  [C2_QDRII_BW_WIDTH-1:0]              c2_user_bwh_n,
   input  [C2_QDRII_ADDR_WIDTH-1:0]            c2_user_ad_wr,
   input  [C2_QDRII_ADDR_WIDTH-1:0]            c2_user_ad_rd,
   input  [C2_QDRII_CQ_WIDTH-1:0]              c2_qdr_cq,
   input  [C2_QDRII_CQ_WIDTH-1:0]              c2_qdr_cq_n,
   output [C2_QDRII_CLK_WIDTH-1:0]             c2_qdr_k,
   output [C2_QDRII_CLK_WIDTH-1:0]             c2_qdr_k_n,
   output [C2_QDRII_CLK_WIDTH-1:0]             c2_qdr_c,
   output [C2_QDRII_CLK_WIDTH-1:0]             c2_qdr_c_n,

   output				       idelay_ctrl_rdy
   );

  //***************************************************************************
  // IODELAY Group Name: Replication and placement of IDELAYCTRLs will be
  // handled automatically by software tools if IDELAYCTRLs have same refclk,
  // reset and rdy nets. Designs with a unique RESET will commonly create a
  // unique RDY. Constraint IODELAY_GROUP is associated to a set of IODELAYs
  // with an IDELAYCTRL. The parameter IODELAY_GRP value can be any string.
  //***************************************************************************

  localparam IODELAY_GRP = "IODELAY_MIG";

  localparam  [C0_QDRII_CQ_WIDTH-1:0] C0_CQ_ZEROS = {C0_QDRII_CQ_WIDTH{1'b0}};
  localparam  [C1_QDRII_CQ_WIDTH-1:0] C1_CQ_ZEROS = {C1_QDRII_CQ_WIDTH{1'b0}};
  localparam  [C2_QDRII_CQ_WIDTH-1:0] C2_CQ_ZEROS = {C2_QDRII_CQ_WIDTH{1'b0}};

  wire                              user_rst_0;
  wire                              user_rst_180;
  wire                              user_rst_270;
  wire                              user_rst_200;

  //wire                              clk0;
  wire                              clk180;
  //wire                              clk270;
  //wire                              clk200;

  //Debug Signals

  wire [35:0] control0;
  wire [36:0] dbg_sync_out;
  wire [67:0] dbg_async_in;

(* KEEP = "TRUE" *) wire [MASTERBANK_PIN_WIDTH-1:0] masterbank_sel_pin_out/*synthesis syn_keep = 1 */;

  genvar dpw_i;
  generate
    for(dpw_i = 0; dpw_i < MASTERBANK_PIN_WIDTH; dpw_i=dpw_i+1)begin : DUMMY_INST1
      MUXCY DUMMY_INST2
        (
         .O  (masterbank_sel_pin_out[dpw_i]),
         .CI (masterbank_sel_pin[dpw_i]),
         .DI (1'b0),
         .S  (1'b1)
         )/* synthesis syn_noprune = 1 */;
    end
  endgenerate
  
   qdrii_idelay_ctrl #
   (
    .IODELAY_GRP         (IODELAY_GRP)
   )
   u_qdrii_idelay_ctrl
   (
   .user_rst_200           (user_rst_200),
   .idelay_ctrl_rdy        (idelay_ctrl_rdy),
   .clk200                 (clk200)
   );


qdrii_infrastructure #
 (
   .RST_ACT_LOW            (RST_ACT_LOW)
   )
u_qdrii_infrastructure
 (
   .sys_rst_n              (sys_rst_n),
   .locked                 (locked),
   .user_rst_0             (user_rst_0),
   .user_rst_180           (user_rst_180),
   .user_rst_270           (user_rst_270),
   .user_rst_200           (user_rst_200),
   .idelay_ctrl_rdy        (idelay_ctrl_rdy),
   .clk0                   (clk0),
   .clk180                 (clk180),
   .clk270                 (clk270),
   .clk200                 (clk200)
   );

// Reset Visor to avoid timing problem

  always @ (posedge clk0 or posedge user_rst_0) begin
	if(user_rst_0) begin
		c0_user_rst_0 <= 1;
		c1_user_rst_0 <= 1;
		c2_user_rst_0 <= 1;
	end
	else begin
		c0_user_rst_0 <= 0;
		c1_user_rst_0 <= 0;
		c2_user_rst_0 <= 0;
	end
  end


reg user_rst_0_0, user_rst_0_1, user_rst_0_2;
reg user_rst_180_0, user_rst_180_1, user_rst_180_2;
reg user_rst_270_0, user_rst_270_1, user_rst_270_2;
reg user_rst_200_0, user_rst_200_1, user_rst_200_2;
always @(posedge clk0) begin
	user_rst_0_0 <= user_rst_0;
	user_rst_0_1 <= user_rst_0;
	user_rst_0_2 <= user_rst_0;
end

always @(posedge clk180) begin
	user_rst_180_0 <= user_rst_180;
	user_rst_180_1 <= user_rst_180;
	user_rst_180_2 <= user_rst_180;
end

always @(posedge clk270) begin
	user_rst_270_0 <= user_rst_270;
	user_rst_270_1 <= user_rst_270;
	user_rst_270_2 <= user_rst_270;
end

always @(posedge clk200) begin
	user_rst_200_0 <= user_rst_200;
	user_rst_200_1 <= user_rst_200;
	user_rst_200_2 <= user_rst_200;
end
// synthesis attribute equivalent_register_removal of c0_user_rst_0 is no;
// synthesis attribute equivalent_register_removal of c1_user_rst_0 is no;
// synthesis attribute equivalent_register_removal of c2_user_rst_0 is no;

// synthesis attribute equivalent_register_removal of user_rst_0_0 is no;
// synthesis attribute equivalent_register_removal of user_rst_0_1 is no;
// synthesis attribute equivalent_register_removal of user_rst_0_2 is no;
// synthesis attribute max_fanout of user_rst_0_0 is 10
// synthesis attribute max_fanout of user_rst_0_1 is 10
// synthesis attribute max_fanout of user_rst_0_2 is 10

// synthesis attribute equivalent_register_removal of user_rst_180_0 is no;
// synthesis attribute equivalent_register_removal of user_rst_180_1 is no;
// synthesis attribute equivalent_register_removal of user_rst_180_2 is no;

// synthesis attribute equivalent_register_removal of user_rst_270_0 is no;
// synthesis attribute equivalent_register_removal of user_rst_270_1 is no;
// synthesis attribute equivalent_register_removal of user_rst_270_2 is no;

// synthesis attribute equivalent_register_removal of user_rst_200_0 is no;
// synthesis attribute equivalent_register_removal of user_rst_200_1 is no;
// synthesis attribute equivalent_register_removal of user_rst_200_2 is no;


// End of Reset Visor

qdrii_top #
 (
   .ADDR_WIDTH             (C0_QDRII_ADDR_WIDTH),
   .BURST_LENGTH           (C0_QDRII_BURST_LENGTH),
   .BW_WIDTH               (C0_QDRII_BW_WIDTH),
   .CLK_FREQ               (QDRII_CLK_FREQ),
   .CLK_WIDTH              (C0_QDRII_CLK_WIDTH),
   .CQ_WIDTH               (C0_QDRII_CQ_WIDTH),
   .DATA_WIDTH             (C0_QDRII_DATA_WIDTH),
   .DEBUG_EN               (C0_QDRII_DEBUG_EN),
   .HIGH_PERFORMANCE_MODE  (HIGH_PERFORMANCE_MODE),
   .IODELAY_GRP            (IODELAY_GRP),
   .MEMORY_WIDTH           (C0_QDRII_MEMORY_WIDTH),
   .SIM_ONLY               (C0_QDRII_SIM_ONLY)
   )
u_qdrii_top_0
(
   .qdr_d                  (c0_qdr_d),
   .qdr_q                  (c0_qdr_q),
   .qdr_sa                 (c0_qdr_sa),
   .qdr_w_n                (c0_qdr_w_n),
   .qdr_r_n                (c0_qdr_r_n),
   .qdr_dll_off_n          (c0_qdr_dll_off_n),
   .qdr_bw_n               (c0_qdr_bw_n),
   .cal_done               (c0_cal_done),
   .user_rst_0             (user_rst_0_0),
   .user_rst_180           (user_rst_180_0),
   .user_rst_270           (user_rst_270_0),
   .idelay_ctrl_rdy        (idelay_ctrl_rdy),
   .clk0                   (clk0),
   .clk180                 (clk180),
   .clk270                 (clk270),
   .user_ad_w_n            (c0_user_ad_w_n),
   .user_d_w_n             (c0_user_d_w_n),
   .user_r_n               (c0_user_r_n),
   .user_wr_full           (c0_user_wr_full),
   .user_rd_full           (c0_user_rd_full),
   .user_qr_valid          (c0_user_qr_valid),
   .user_dwl               (c0_user_dwl),
   .user_dwh               (c0_user_dwh),
   .user_qrl               (c0_user_qrl),
   .user_qrh               (c0_user_qrh),
   .user_bwl_n             (c0_user_bwl_n),
   .user_bwh_n             (c0_user_bwh_n),
   .user_ad_wr             (c0_user_ad_wr),
   .user_ad_rd             (c0_user_ad_rd),
   .qdr_cq                 (c0_qdr_cq),
   .qdr_cq_n               (c0_qdr_cq_n),
   .qdr_k                  (c0_qdr_k),
   .qdr_k_n                (c0_qdr_k_n),
   .qdr_c                  (c0_qdr_c),
   .qdr_c_n                (c0_qdr_c_n),

   .dbg_init_count_done    (),
   .dbg_q_cq_init_delay_done  (),
   .dbg_q_cq_n_init_delay_done  (),
   .dbg_q_cq_init_delay_done_tap_count  (),
   .dbg_q_cq_n_init_delay_done_tap_count  (),
   .dbg_cq_cal_done        (),
   .dbg_cq_n_cal_done      (),
   .dbg_cq_cal_tap_count   (),
   .dbg_cq_n_cal_tap_count  (),
   .dbg_we_cal_done_cq     (),
   .dbg_we_cal_done_cq_n   (),
   .dbg_cq_q_data_valid    (),
   .dbg_cq_n_q_data_valid  (),
   .dbg_cal_done           (),
   .dbg_data_valid         (),
   .dbg_idel_up_all        (1'b0),
   .dbg_idel_down_all      (1'b0),
   .dbg_idel_up_q_cq       (1'b0),
   .dbg_idel_down_q_cq     (1'b0),
   .dbg_idel_up_q_cq_n     (1'b0),
   .dbg_idel_down_q_cq_n   (1'b0),
   .dbg_idel_up_cq         (1'b0),
   .dbg_idel_down_cq       (1'b0),
   .dbg_idel_up_cq_n       (1'b0),
   .dbg_idel_down_cq_n     (1'b0),
   .dbg_sel_idel_q_cq      (C0_CQ_ZEROS),
   .dbg_sel_all_idel_q_cq  (1'b0),
   .dbg_sel_idel_q_cq_n    (C0_CQ_ZEROS),
   .dbg_sel_all_idel_q_cq_n  (1'b0),
   .dbg_sel_idel_cq        (C0_CQ_ZEROS),
   .dbg_sel_all_idel_cq    (1'b0),
   .dbg_sel_idel_cq_n      (C0_CQ_ZEROS),
   .dbg_sel_all_idel_cq_n  (1'b0)
   );
qdrii_top #
 (
   .ADDR_WIDTH             (C1_QDRII_ADDR_WIDTH),
   .BURST_LENGTH           (C1_QDRII_BURST_LENGTH),
   .BW_WIDTH               (C1_QDRII_BW_WIDTH),
   .CLK_FREQ               (QDRII_CLK_FREQ),
   .CLK_WIDTH              (C1_QDRII_CLK_WIDTH),
   .CQ_WIDTH               (C1_QDRII_CQ_WIDTH),
   .DATA_WIDTH             (C1_QDRII_DATA_WIDTH),
   .DEBUG_EN               (C1_QDRII_DEBUG_EN),
   .HIGH_PERFORMANCE_MODE  (HIGH_PERFORMANCE_MODE),
   .IODELAY_GRP            (IODELAY_GRP),
   .MEMORY_WIDTH           (C1_QDRII_MEMORY_WIDTH),
   .SIM_ONLY               (C1_QDRII_SIM_ONLY)
   )
u_qdrii_top_1
(
   .qdr_d                  (c1_qdr_d),
   .qdr_q                  (c1_qdr_q),
   .qdr_sa                 (c1_qdr_sa),
   .qdr_w_n                (c1_qdr_w_n),
   .qdr_r_n                (c1_qdr_r_n),
   .qdr_dll_off_n          (c1_qdr_dll_off_n),
   .qdr_bw_n               (c1_qdr_bw_n),
   .cal_done               (c1_cal_done),
   .user_rst_0             (user_rst_0_1),
   .user_rst_180           (user_rst_180_1),
   .user_rst_270           (user_rst_270_1),
   .idelay_ctrl_rdy        (idelay_ctrl_rdy),
   .clk0                   (clk0),
   .clk180                 (clk180),
   .clk270                 (clk270),
   .user_ad_w_n            (c1_user_ad_w_n),
   .user_d_w_n             (c1_user_d_w_n),
   .user_r_n               (c1_user_r_n),
   .user_wr_full           (c1_user_wr_full),
   .user_rd_full           (c1_user_rd_full),
   .user_qr_valid          (c1_user_qr_valid),
   .user_dwl               (c1_user_dwl),
   .user_dwh               (c1_user_dwh),
   .user_qrl               (c1_user_qrl),
   .user_qrh               (c1_user_qrh),
   .user_bwl_n             (c1_user_bwl_n),
   .user_bwh_n             (c1_user_bwh_n),
   .user_ad_wr             (c1_user_ad_wr),
   .user_ad_rd             (c1_user_ad_rd),
   .qdr_cq                 (c1_qdr_cq),
   .qdr_cq_n               (c1_qdr_cq_n),
   .qdr_k                  (c1_qdr_k),
   .qdr_k_n                (c1_qdr_k_n),
   .qdr_c                  (c1_qdr_c),
   .qdr_c_n                (c1_qdr_c_n),

   .dbg_init_count_done    (),
   .dbg_q_cq_init_delay_done  (),
   .dbg_q_cq_n_init_delay_done  (),
   .dbg_q_cq_init_delay_done_tap_count  (),
   .dbg_q_cq_n_init_delay_done_tap_count  (),
   .dbg_cq_cal_done        (),
   .dbg_cq_n_cal_done      (),
   .dbg_cq_cal_tap_count   (),
   .dbg_cq_n_cal_tap_count  (),
   .dbg_we_cal_done_cq     (),
   .dbg_we_cal_done_cq_n   (),
   .dbg_cq_q_data_valid    (),
   .dbg_cq_n_q_data_valid  (),
   .dbg_cal_done           (),
   .dbg_data_valid         (),
   .dbg_idel_up_all        (1'b0),
   .dbg_idel_down_all      (1'b0),
   .dbg_idel_up_q_cq       (1'b0),
   .dbg_idel_down_q_cq     (1'b0),
   .dbg_idel_up_q_cq_n     (1'b0),
   .dbg_idel_down_q_cq_n   (1'b0),
   .dbg_idel_up_cq         (1'b0),
   .dbg_idel_down_cq       (1'b0),
   .dbg_idel_up_cq_n       (1'b0),
   .dbg_idel_down_cq_n     (1'b0),
   .dbg_sel_idel_q_cq      (C1_CQ_ZEROS),
   .dbg_sel_all_idel_q_cq  (1'b0),
   .dbg_sel_idel_q_cq_n    (C1_CQ_ZEROS),
   .dbg_sel_all_idel_q_cq_n  (1'b0),
   .dbg_sel_idel_cq        (C1_CQ_ZEROS),
   .dbg_sel_all_idel_cq    (1'b0),
   .dbg_sel_idel_cq_n      (C1_CQ_ZEROS),
   .dbg_sel_all_idel_cq_n  (1'b0)
   );
qdrii_top #
 (
   .ADDR_WIDTH             (C2_QDRII_ADDR_WIDTH),
   .BURST_LENGTH           (C2_QDRII_BURST_LENGTH),
   .BW_WIDTH               (C2_QDRII_BW_WIDTH),
   .CLK_FREQ               (QDRII_CLK_FREQ),
   .CLK_WIDTH              (C2_QDRII_CLK_WIDTH),
   .CQ_WIDTH               (C2_QDRII_CQ_WIDTH),
   .DATA_WIDTH             (C2_QDRII_DATA_WIDTH),
   .DEBUG_EN               (C2_QDRII_DEBUG_EN),
   .HIGH_PERFORMANCE_MODE  (HIGH_PERFORMANCE_MODE),
   .IODELAY_GRP            (IODELAY_GRP),
   .MEMORY_WIDTH           (C2_QDRII_MEMORY_WIDTH),
   .SIM_ONLY               (C2_QDRII_SIM_ONLY)
   )
u_qdrii_top_2
(
   .qdr_d                  (c2_qdr_d),
   .qdr_q                  (c2_qdr_q),
   .qdr_sa                 (c2_qdr_sa),
   .qdr_w_n                (c2_qdr_w_n),
   .qdr_r_n                (c2_qdr_r_n),
   .qdr_dll_off_n          (c2_qdr_dll_off_n),
   .qdr_bw_n               (c2_qdr_bw_n),
   .cal_done               (c2_cal_done),
   .user_rst_0             (user_rst_0_2),
   .user_rst_180           (user_rst_180_2),
   .user_rst_270           (user_rst_270_2),
   .idelay_ctrl_rdy        (idelay_ctrl_rdy),
   .clk0                   (clk0),
   .clk180                 (clk180),
   .clk270                 (clk270),
   .user_ad_w_n            (c2_user_ad_w_n),
   .user_d_w_n             (c2_user_d_w_n),
   .user_r_n               (c2_user_r_n),
   .user_wr_full           (c2_user_wr_full),
   .user_rd_full           (c2_user_rd_full),
   .user_qr_valid          (c2_user_qr_valid),
   .user_dwl               (c2_user_dwl),
   .user_dwh               (c2_user_dwh),
   .user_qrl               (c2_user_qrl),
   .user_qrh               (c2_user_qrh),
   .user_bwl_n             (c2_user_bwl_n),
   .user_bwh_n             (c2_user_bwh_n),
   .user_ad_wr             (c2_user_ad_wr),
   .user_ad_rd             (c2_user_ad_rd),
   .qdr_cq                 (c2_qdr_cq),
   .qdr_cq_n               (c2_qdr_cq_n),
   .qdr_k                  (c2_qdr_k),
   .qdr_k_n                (c2_qdr_k_n),
   .qdr_c                  (c2_qdr_c),
   .qdr_c_n                (c2_qdr_c_n),

   .dbg_init_count_done    (),
   .dbg_q_cq_init_delay_done  (),
   .dbg_q_cq_n_init_delay_done  (),
   .dbg_q_cq_init_delay_done_tap_count  (),
   .dbg_q_cq_n_init_delay_done_tap_count  (),
   .dbg_cq_cal_done        (),
   .dbg_cq_n_cal_done      (),
   .dbg_cq_cal_tap_count   (),
   .dbg_cq_n_cal_tap_count  (),
   .dbg_we_cal_done_cq     (),
   .dbg_we_cal_done_cq_n   (),
   .dbg_cq_q_data_valid    (),
   .dbg_cq_n_q_data_valid  (),
   .dbg_cal_done           (),
   .dbg_data_valid         (),
   .dbg_idel_up_all        (1'b0),
   .dbg_idel_down_all      (1'b0),
   .dbg_idel_up_q_cq       (1'b0),
   .dbg_idel_down_q_cq     (1'b0),
   .dbg_idel_up_q_cq_n     (1'b0),
   .dbg_idel_down_q_cq_n   (1'b0),
   .dbg_idel_up_cq         (1'b0),
   .dbg_idel_down_cq       (1'b0),
   .dbg_idel_up_cq_n       (1'b0),
   .dbg_idel_down_cq_n     (1'b0),
   .dbg_sel_idel_q_cq      (C2_CQ_ZEROS),
   .dbg_sel_all_idel_q_cq  (1'b0),
   .dbg_sel_idel_q_cq_n    (C2_CQ_ZEROS),
   .dbg_sel_all_idel_q_cq_n  (1'b0),
   .dbg_sel_idel_cq        (C2_CQ_ZEROS),
   .dbg_sel_all_idel_cq    (1'b0),
   .dbg_sel_idel_cq_n      (C2_CQ_ZEROS),
   .dbg_sel_all_idel_cq_n  (1'b0)
   );






endmodule
