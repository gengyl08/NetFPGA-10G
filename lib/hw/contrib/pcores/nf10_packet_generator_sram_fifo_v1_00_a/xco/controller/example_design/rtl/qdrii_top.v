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
// \   \   \/     Version            : 3.6.1
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_top.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Serves as the top level memory interface module that interfaces to
//      the user backend.
//       2. Instantiates the user interface module, the controller statemachine
//      and the phy layer.
//
//Revision History:
//   Rev 1.1 - Parameter IODELAY_GRP added. PK. 11/27/08
//*****************************************************************************


`timescale 1ns/1ps

module qdrii_top #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter ADDR_WIDTH            = 19,
   parameter BURST_LENGTH          = 4,
   parameter BW_WIDTH              = 8,
   parameter CLK_PERIOD            = 3333,
   parameter CLK_WIDTH             = 2,
   parameter CQ_WIDTH              = 2,
   parameter DATA_WIDTH            = 72,
   parameter DEBUG_EN              = 0,
   parameter HIGH_PERFORMANCE_MODE = "TRUE",
   parameter IODELAY_GRP           = "IODELAY_MIG",
   // this parameter can be set to FALSE only for Burst2 designs where the user interface fifos are not required.
   // By DEFAULT, FIFOs are used in Burst2 designs and hence this parameter is set to TRUE.
   // Burst4 designs always use FIFOs and do not have the option to remove FIFOs
   parameter BURST2_FIFO_INTERFACE = "TRUE",  
   parameter MEMORY_WIDTH          = 36,
   parameter SIM_ONLY              = 0
   )
  (
   input                   clk0,
   input                   clk180,
   input                   clk270,
   input                   user_rst_0,
   input                   user_rst_180,
   input                   user_rst_270,
   input                   user_ad_w_n,
   input                   user_d_w_n,
   input [ADDR_WIDTH-1:0]  user_ad_wr,
   input [BW_WIDTH-1:0]    user_bwh_n,
   input [BW_WIDTH-1:0]    user_bwl_n,
   input [DATA_WIDTH-1:0]  user_dwl,
   input [DATA_WIDTH-1:0]  user_dwh,
   input                   user_r_n,
   input [ADDR_WIDTH-1:0]  user_ad_rd,
   input                   idelay_ctrl_rdy,
   input [DATA_WIDTH-1:0]  qdr_q,
   input [CQ_WIDTH-1:0]    qdr_cq,
   input [CQ_WIDTH-1:0]    qdr_cq_n,
   output                  user_wr_full,
   output                  user_rd_full,
   output [DATA_WIDTH-1:0] user_qrl,
   output [DATA_WIDTH-1:0] user_qrh,
   output                  user_qr_valid,
   output                  cal_done,
   output [CLK_WIDTH-1:0]  qdr_c,
   output [CLK_WIDTH-1:0]  qdr_c_n,
   output                  qdr_dll_off_n,
   output [CLK_WIDTH-1:0]  qdr_k,
   output [CLK_WIDTH-1:0]  qdr_k_n,
   output [ADDR_WIDTH-1:0] qdr_sa,
   output [BW_WIDTH-1:0]   qdr_bw_n,
   output                  qdr_w_n,
   output [DATA_WIDTH-1:0] qdr_d,
   output                  qdr_r_n,

   // Debug signals
   input                     dbg_idel_up_all,
   input                     dbg_idel_down_all,
   input                     dbg_idel_up_q_cq,
   input                     dbg_idel_down_q_cq,
   input                     dbg_idel_up_q_cq_n,
   input                     dbg_idel_down_q_cq_n,
   input                     dbg_idel_up_cq,
   input                     dbg_idel_down_cq,
   input                     dbg_idel_up_cq_n,
   input                     dbg_idel_down_cq_n,
   input [CQ_WIDTH-1:0]      dbg_sel_idel_q_cq,
   input                     dbg_sel_all_idel_q_cq,
   input [CQ_WIDTH-1:0]      dbg_sel_idel_q_cq_n,
   input                     dbg_sel_all_idel_q_cq_n,
   input [CQ_WIDTH-1:0]      dbg_sel_idel_cq,
   input                     dbg_sel_all_idel_cq,
   input [CQ_WIDTH-1:0]      dbg_sel_idel_cq_n,
   input                     dbg_sel_all_idel_cq_n,
   output                    dbg_init_count_done,
   output [CQ_WIDTH-1:0]     dbg_q_cq_init_delay_done,
   output [CQ_WIDTH-1:0]     dbg_q_cq_n_init_delay_done,
   output [(6*CQ_WIDTH)-1:0] dbg_q_cq_init_delay_done_tap_count,
   output [(6*CQ_WIDTH)-1:0] dbg_q_cq_n_init_delay_done_tap_count,
   output [CQ_WIDTH-1:0]     dbg_cq_cal_done,
   output [CQ_WIDTH-1:0]     dbg_cq_n_cal_done,
   output [(6*CQ_WIDTH)-1:0] dbg_cq_cal_tap_count,
   output [(6*CQ_WIDTH)-1:0] dbg_cq_n_cal_tap_count,
   output [CQ_WIDTH-1:0]     dbg_we_cal_done_cq,
   output [CQ_WIDTH-1:0]     dbg_we_cal_done_cq_n,
   output [CQ_WIDTH-1:0]     dbg_cq_q_data_valid,
   output [CQ_WIDTH-1:0]     dbg_cq_n_q_data_valid,
   output                    dbg_cal_done,
   output                    dbg_data_valid
   );

   localparam Q_PER_CQ = DATA_WIDTH/((CQ_WIDTH*(MEMORY_WIDTH/36))+CQ_WIDTH);
   // Number of read data bits associated with a single read strobe.
   // For a 36 bit component the value is always 18 because it is defined as
   // number of read data bits associated with CQ and CQ#.
   // For 18 bit components the value is always DATA_WIDTH/CQ_WIDTH, because it
   // is defined as number of read data bits associated with CQ.

   wire                  wr_init_n;
   wire                  rd_init_n;
   wire                  wr_init2_n;
   wire [ADDR_WIDTH-1:0] fifo_ad_wr;
   wire [ADDR_WIDTH-1:0] fifo_ad_rd;
   wire [BW_WIDTH-1:0]   fifo_bw_h;
   wire [BW_WIDTH-1:0]   fifo_bw_l;
   wire [DATA_WIDTH-1:0] fifo_dwl;
   wire [DATA_WIDTH-1:0] fifo_dwh;
   wire                  fifo_wr_empty;
   wire                  fifo_rd_empty;
   wire [DATA_WIDTH-1:0] rd_qrl;
   wire [DATA_WIDTH-1:0] rd_qrh;
   wire                  data_valid;
   wire [DATA_WIDTH-1:0] dummy_wrl;
   wire [DATA_WIDTH-1:0] dummy_wrh;
   wire                  dummy_wren;
   wire                  cal_done_r;
   
   //added for burst2 non-fifo case
   
   wire [DATA_WIDTH-1:0] fifo_dwl_cal;
   wire [DATA_WIDTH-1:0] fifo_dwh_cal;
   reg [DATA_WIDTH-1:0]  user_dwl_r_270; 
   reg [DATA_WIDTH-1:0]  user_dwh_r_270; 
   reg [DATA_WIDTH-1:0]  user_dwl_2r_270; 
   reg [DATA_WIDTH-1:0]  user_dwh_2r_270;    
   reg [BW_WIDTH-1:0]    user_bwl_r_270; 
   reg [BW_WIDTH-1:0]    user_bwh_r_270; 
   reg [BW_WIDTH-1:0]    user_bwl_2r_270;
   reg [BW_WIDTH-1:0]    user_bwh_2r_270;
   reg [DATA_WIDTH-1:0]  user_dwl_r;
   reg [DATA_WIDTH-1:0]  user_dwh_r;   
   reg [BW_WIDTH-1:0]    user_bwl_r;
   reg [BW_WIDTH-1:0]    user_bwh_r;
   reg                   user_ad_w_n_r;
   reg                   user_d_w_n_r;
   reg [ADDR_WIDTH-1:0]  user_ad_wr_r;
   reg [BW_WIDTH-1:0]    user_bwh_n_r;
   reg [BW_WIDTH-1:0]    user_bwl_n_r;
   reg                   user_r_n_r;  
   reg [ADDR_WIDTH-1:0]  user_ad_rd_r;
   
   wire                  wrfifo_wren_r1;
   wire                  user_w_n_stretch;
   wire                  wrfifo_wren;

   FDRSE #
     (
      .INIT(1'b0)
      )
     CAL_DONE_FF
       (
        .Q  ( cal_done_r ),
        .C  ( clk0 ),
        .CE ( 1'b1 ),
        .D  ( cal_done ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   assign user_qrl      = rd_qrl;
   assign user_qrh      = rd_qrh;
   assign user_qr_valid = (cal_done_r) ? data_valid : 1'b0;

   assign dbg_data_valid = (cal_done_r) ? data_valid : 1'b0;

   generate  
         
    if (BURST2_FIFO_INTERFACE == "FALSE" && BURST_LENGTH == 2) begin : NO_FIFO_BURST2_INST                      

       // pipeline incoming write data and move this to clk270 domain.
         always @ (posedge clk0) begin
            if (user_rst_0) begin
                 user_ad_w_n_r <= 'b0;
                 user_d_w_n_r  <= 'b0; 
                 user_ad_wr_r  <= 'b0;
                 user_bwh_n_r  <= 'b0;
                 user_bwl_n_r  <= 'b0;
                 user_dwl_r    <= 'b0;
                 user_dwh_r    <= 'b0;
                 user_r_n_r    <= 'b0;
                 user_ad_rd_r  <= 'b0;
            end else begin
                 user_ad_w_n_r <=  user_ad_w_n;
                 user_d_w_n_r  <=  user_d_w_n;  
                 user_ad_wr_r  <=  user_ad_wr;  
                 user_bwh_n_r  <=  user_bwh_n;  
                 user_bwl_n_r  <=  user_bwl_n;  
                 user_dwl_r    <=  user_dwl;    
                 user_dwh_r    <=  user_dwh;    
                 user_r_n_r    <=  user_r_n;    
                 user_ad_rd_r  <=  user_ad_rd;  
            end 
         end
      
   
       // for the user backend. There is no write address or read address FIFO now and the user can continue to provide commands as long as cal_done is high
        assign user_wr_full = 1'b0;    
        assign user_rd_full = 1'b0;
         
       // tie user write and read commands directly to wr_init_n and rd_init_n
       assign wr_init_n = user_ad_w_n_r;
       assign rd_init_n = user_r_n_r;
       
       // tie input address to fifo address input to phy_addr_io.v         
       assign fifo_ad_wr = user_ad_wr_r;
       assign fifo_ad_rd = user_ad_rd_r;         
       
       // move incoming write data  to clk270 domain.
       always @ (posedge clk270) begin
          if (user_rst_270) begin
             user_dwl_r_270 <= 'b0;
             user_dwh_r_270 <= 'b0;
             user_dwl_2r_270 <= 'b0;
             user_dwh_2r_270 <= 'b0;
             user_bwl_r_270 <= 'b0;
             user_bwh_r_270 <= 'b0;
             user_bwl_2r_270 <= 'b0;
             user_bwh_2r_270 <= 'b0;
          end else begin
             user_dwl_r_270 <= user_dwl_r;
             user_dwh_r_270 <= user_dwh_r;
             user_dwl_2r_270 <= user_dwl_r_270;
             user_dwh_2r_270 <= user_dwh_r_270;
             user_bwl_r_270  <= user_bwl_n_r;
             user_bwh_r_270  <= user_bwh_n_r;
             user_bwl_2r_270 <= user_bwl_r_270;
             user_bwh_2r_270 <= user_bwh_r_270;
          end
       end  
       
     //modified wr_data_interface to be used only for dummy write data
     assign wrfifo_wren     =  ~dummy_wren;
     
     FDRSE #
     (
      .INIT(1'b1)
      )
     U_EN_FF
       (
        .Q  ( wrfifo_wren_r1 ),
        .C  ( clk0 ),
        .CE ( 1'b1 ),
        .D  ( wrfifo_wren ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   assign user_w_n_stretch = (BURST_LENGTH == 4) ? (wrfifo_wren  & wrfifo_wren_r1) :
                                                    wrfifo_wren;
     
     
     qdrii_top_wrdata_fifo #
      (
       .DATA_WIDTH (DATA_WIDTH)
       )
      U_QDRII_TOP_CALDATA_FIFO
        (
         .clk0         ( clk0 ),
         .clk270       ( clk270 ),
         .user_rst_270 ( user_rst_270 ),
         .idata_lsb    ( dummy_wrl), 
         .idata_msb    ( dummy_wrh), 
         .rdenb        ( ~wr_init2_n ),
         .wrenb        ( ~user_w_n_stretch ),
         .odata_lsb    ( fifo_dwl_cal ),
         .odata_msb    ( fifo_dwh_cal )
         );
         
       // assign input write data and byte writes to phy_write module.
        assign fifo_dwh = (cal_done)?  user_dwh_2r_270 : fifo_dwh_cal;
        assign fifo_dwl = (cal_done)?  user_dwl_2r_270 : fifo_dwl_cal;  
        
        assign fifo_bw_l = (cal_done)? user_bwl_2r_270 : 0 ;
        assign fifo_bw_h = (cal_done)? user_bwh_2r_270 : 0 ;  
 
           
   end else  begin : CMD_FIFO_INST
   
      qdrii_top_user_interface #
         (
          .ADDR_WIDTH   ( ADDR_WIDTH ),
          .BURST_LENGTH ( BURST_LENGTH ),
          .BW_WIDTH     ( BW_WIDTH ),
          .DATA_WIDTH   ( DATA_WIDTH )
          )
         U_QDRII_TOP_USER_INTERFACE
           (
            .clk0          ( clk0 ),
            .user_rst_0    ( user_rst_0 ),
            .clk270        ( clk270 ),
            .user_rst_270  ( user_rst_270 ),
            .cal_done      ( cal_done_r ),
            .user_ad_w_n   ( user_ad_w_n ),
            .user_d_w_n    ( user_d_w_n ),
            .user_ad_wr    ( user_ad_wr ),
            .user_bw_h     ( user_bwh_n ),
            .user_bw_l     ( user_bwl_n ),
            .user_dwl      ( user_dwl ),
            .user_dwh      ( user_dwh ),
            .wr_init_n     ( wr_init_n ),
            .wr_init2_n    ( wr_init2_n ),
            .user_r_n      ( user_r_n ),
            .user_ad_rd    ( user_ad_rd ),
            .rd_init_n     ( rd_init_n ),
            .dummy_wrl     ( dummy_wrl),
            .dummy_wrh     ( dummy_wrh),
            .dummy_wren    ( dummy_wren),
            .user_wr_full  ( user_wr_full ),
            .fifo_ad_wr    ( fifo_ad_wr ),
            .fifo_bw_h     ( fifo_bw_h ),
            .fifo_bw_l     ( fifo_bw_l ),
            .fifo_dwl      ( fifo_dwl ),
            .fifo_dwh      ( fifo_dwh ),
            .fifo_wr_empty ( fifo_wr_empty ),
            .user_rd_full  ( user_rd_full ),
            .fifo_ad_rd    ( fifo_ad_rd ),
            .fifo_rd_empty ( fifo_rd_empty )
            );   
            
          qdrii_top_ctrl_sm  #
         (
          .BURST_LENGTH ( BURST_LENGTH )
          )
         U_QDRII_TOP_CTRL_SM
           (
            .clk0       ( clk0 ),
            .user_rst_0 ( user_rst_0 ),
            .wr_empty   ( fifo_wr_empty ),
            .rd_empty   ( fifo_rd_empty ),
            .cal_done   ( cal_done ),
            .wr_init_n  ( wr_init_n ),
            .rd_init_n  ( rd_init_n )
            );  
        
       end 
    endgenerate  

   qdrii_top_phy #
      (
       .ADDR_WIDTH            ( ADDR_WIDTH ),
       .BURST_LENGTH          ( BURST_LENGTH ),
       .DATA_WIDTH            ( DATA_WIDTH ),
       .DEBUG_EN              ( DEBUG_EN ),
       .CLK_WIDTH             ( CLK_WIDTH ),
       .BW_WIDTH              ( BW_WIDTH ),
       .CQ_WIDTH              ( CQ_WIDTH ),
       .HIGH_PERFORMANCE_MODE ( HIGH_PERFORMANCE_MODE ),
       .IODELAY_GRP           ( IODELAY_GRP ),
       .MEMORY_WIDTH          ( MEMORY_WIDTH ),
       .Q_PER_CQ              ( Q_PER_CQ ),
       .SIM_ONLY              ( SIM_ONLY ),
       .CLK_PERIOD            ( CLK_PERIOD )
       )
      U_QDRII_TOP_PHY
         (
          .clk0            ( clk0 ),
          .clk180          ( clk180 ),
          .clk270          ( clk270 ),
          .user_rst_0      ( user_rst_0 ),
          .user_rst_180    ( user_rst_180 ),
          .user_rst_270    ( user_rst_270 ),
          .cal_done        ( cal_done ),
          .wr_init_n       ( wr_init_n ),
          .rd_init_n       ( rd_init_n ),
          .fifo_ad_wr      ( fifo_ad_wr ),
          .fifo_ad_rd      ( fifo_ad_rd ),
          .fifo_bw_h       ( fifo_bw_h ),
          .fifo_bw_l       ( fifo_bw_l ),
          .fifo_dwl        ( fifo_dwl ),
          .fifo_dwh        ( fifo_dwh ),
          .idelay_ctrl_rdy ( idelay_ctrl_rdy ),
          .rd_qrl          ( rd_qrl ),
          .rd_qrh          ( rd_qrh ),
          .data_valid      ( data_valid ),
          .wr_init2_n      ( wr_init2_n ),
          .qdr_c           ( qdr_c ),
          .qdr_c_n         ( qdr_c_n ),
          .qdr_dll_off_n   ( qdr_dll_off_n ),
          .qdr_k           ( qdr_k ),
          .qdr_k_n         ( qdr_k_n ),
          .qdr_sa          ( qdr_sa ),
          .qdr_bw_n        ( qdr_bw_n ),
          .qdr_w_n         ( qdr_w_n ),
          .qdr_d           ( qdr_d ),
          .qdr_r_n         ( qdr_r_n ),
          .qdr_q           ( qdr_q ),
          .qdr_cq          ( qdr_cq ),
          .qdr_cq_n        ( qdr_cq_n ),
          .dummy_wrl       ( dummy_wrl ),
          .dummy_wrh       ( dummy_wrh ),
          .dummy_wren      ( dummy_wren ),

          //Debug Signals
          .dbg_idel_up_all                      ( dbg_idel_up_all ),
          .dbg_idel_down_all                    ( dbg_idel_down_all ),
          .dbg_idel_up_q_cq                     ( dbg_idel_up_q_cq ),
          .dbg_idel_down_q_cq                   ( dbg_idel_down_q_cq ),
          .dbg_idel_up_q_cq_n                   ( dbg_idel_up_q_cq_n ),
          .dbg_idel_down_q_cq_n                 ( dbg_idel_down_q_cq_n ),
          .dbg_idel_up_cq                       ( dbg_idel_up_cq ),
          .dbg_idel_down_cq                     ( dbg_idel_down_cq ),
          .dbg_idel_up_cq_n                     ( dbg_idel_up_cq_n ),
          .dbg_idel_down_cq_n                   ( dbg_idel_down_cq_n ),
          .dbg_sel_idel_q_cq                    ( dbg_sel_idel_q_cq ),
          .dbg_sel_all_idel_q_cq                ( dbg_sel_all_idel_q_cq ),
          .dbg_sel_idel_q_cq_n                  ( dbg_sel_idel_q_cq_n ),
          .dbg_sel_all_idel_q_cq_n              ( dbg_sel_all_idel_q_cq_n ),
          .dbg_sel_idel_cq                      ( dbg_sel_idel_cq ),
          .dbg_sel_all_idel_cq                  ( dbg_sel_all_idel_cq ),
          .dbg_sel_idel_cq_n                    ( dbg_sel_idel_cq_n ),
          .dbg_sel_all_idel_cq_n                ( dbg_sel_all_idel_cq_n ),
          .dbg_init_count_done                  ( dbg_init_count_done ),
          .dbg_q_cq_init_delay_done             ( dbg_q_cq_init_delay_done ),
          .dbg_q_cq_n_init_delay_done           ( dbg_q_cq_n_init_delay_done ),
          .dbg_q_cq_init_delay_done_tap_count   ( dbg_q_cq_init_delay_done_tap_count ),
          .dbg_q_cq_n_init_delay_done_tap_count ( dbg_q_cq_n_init_delay_done_tap_count ),
          .dbg_cq_cal_done                      ( dbg_cq_cal_done ),
          .dbg_cq_n_cal_done                    ( dbg_cq_n_cal_done ),
          .dbg_cq_cal_tap_count                 ( dbg_cq_cal_tap_count ),
          .dbg_cq_n_cal_tap_count               ( dbg_cq_n_cal_tap_count ),
          .dbg_we_cal_done_cq                   ( dbg_we_cal_done_cq ),
          .dbg_we_cal_done_cq_n                 ( dbg_we_cal_done_cq_n ),
          .dbg_cq_q_data_valid                  ( dbg_cq_q_data_valid ),
          .dbg_cq_n_q_data_valid                ( dbg_cq_n_q_data_valid ),
          .dbg_cal_done                         ( dbg_cal_done )
          );

endmodule