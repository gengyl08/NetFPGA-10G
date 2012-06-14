/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        action_processor.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        It receives packets as AXI stream,
 *        updates header fields depending on input actions
 *        then forwards them to the next module as AXI stream
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland
 *                                 Stanford Junior University
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
 */

`timescale 1ns/1ps
`include "registers.v"

module action_processor
#(
   // AXI Stream Data Width
   parameter C_AXIS_DATA_WIDTH = 64,
   parameter C_AXIS_TUSER_WIDTH=128,
   parameter C_AXIS_LEN_DATA_WIDTH=16,
   parameter C_AXIS_SPT_DATA_WIDTH=8,
   parameter C_AXIS_DPT_DATA_WIDTH=8,
   // Parameters for Flow Table interface
   parameter OPENFLOW_ACTION_SIZE = 320
)
(
   // AXI ports
   input asclk,
   input aresetn,

   // Slave AXI Stream Ports
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
   input  s_axis_tvalid,
   input  s_axis_tlast,
   output s_axis_tready,

   // interface with flow table
   input [OPENFLOW_ACTION_SIZE -1: 0] lu_action,
   input lu_req,
   input lu_done,

   // Master AXI Stream Ports
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
   output m_axis_tvalid,
   output reg  m_axis_tlast,
   input  m_axis_tready,

   // Debug register
   output reg [31:0] num_pkts_processed
);

   //-------------------- Internal Parameters ------------------------

   localparam FIFO_CTRL_WIDTH = 2;
   localparam FIFO_DATA_WIDTH = C_AXIS_DATA_WIDTH +
                                C_AXIS_DATA_WIDTH/8 +
                                FIFO_CTRL_WIDTH;

   localparam TUSER_LEN_POS = 0;
   localparam TUSER_SPT_POS = TUSER_LEN_POS
                            + C_AXIS_LEN_DATA_WIDTH;
   localparam TUSER_DPT_POS = TUSER_SPT_POS
                            + C_AXIS_SPT_DATA_WIDTH;

   localparam FLAG_START_MSB = 2'b10,
              FLAG_START_LSB = 2'b01;

   // Data read state machine
   localparam NUM_DT_RD_STATES = 3;
   localparam DT_RD_1ST = 1,
              DT_RD_REST = 2,
              DT_RD_WAIT = 4;

   // DL state machine
   localparam NUM_DL_STATES = 8;
   localparam DL_HDR_1ST = 1,
              DL_HDR_2ND = 2,
              DL_THRU_CHK = 4,
              DL_THRU = 8,
              DL_HDR_3RD_POP = 16,
              DL_SFT_CHK = 32,
              DL_SFT = 64,
              DL_SFT_LAST = 128;

   // NW/TP state machines
   localparam NUM_NW_STATES = 12;
   localparam NW_HDR_1ST = 1,
              NW_HDR_2ND_PTN1 = 2,
              NW_HDR_2ND_PTN2 = 4,
              NW_HDR_3RD_PTN1 = 8,
              NW_HDR_3RD_PTN2 = 16,
              NW_HDR_4TH_PTN1 = 32,
              NW_OPT_PASS = 64,
              TP_HDR_2ND_PTN1 = 128,
              TP_HDR_2ND_PTN2 = 256,
              TP_HDR_3RD_PTN1 = 512,
              TP_HDR_3RD_PTN2 = 1024,
              NW_THRU = 2048;

   localparam NUM_NWCS_STATES = 17;
   localparam NWCS_1ST = 1,
              NWCS_2ND = 2,
              NWCS_3RD = 4,
              NWCS_4TH = 8,
              NWCS_4TH_A = 16,
              NWCS_5TH = 32,
              NWCS_5TH_A = 64,
              NWCS_5TH_B = 128,
              NWCS_6TH = 256,
              NWCS_6TH_A = 512,
              NWCS_6TH_B = 1024,
              NWCS_6TH_C = 2048,
              NWCS_7TH = 4096,
              NWCS_7TH_A = 8192,
              NWCS_7TH_B = 16384,
              NWCS_7TH_C = 32768,
              NWCS_7TH_D = 65536;

   localparam NUM_TPCS_STATES = 13;
   localparam TPCS_1ST = 1,
              TPCS_2ND = 2,
              TPCS_3RD = 4,
              TPCS_3RD_A = 8,
              TPCS_4TH = 16,
              TPCS_4TH_A = 32,
              TPCS_4TH_B = 64,
              TPCS_5TH = 128,
              TPCS_5TH_A = 256,
              TPCS_5TH_B = 512,
              TPCS_6TH = 1024,
              TPCS_6TH_A = 2048,
              TPCS_6TH_B = 4096;

   // Packet forwarding state machines
   localparam NUM_SHIFT_STATES = 2;
   localparam PKT_EXIST = 1,
              PKT_PUSH = 2;

   localparam NUM_TU_STATES = 2;
   localparam TU_WAIT_TVALID = 1,
              TU_WAIT_TLAST = 2;

   //------------------------ Wires/Regs -----------------------------

   // Endian Conversion
   wire [C_AXIS_DATA_WIDTH-1:0] be_tx_data_infifo;
   reg [C_AXIS_DATA_WIDTH-1:0] be_tx_data;
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] be_tx_strb_infifo;
   reg [(C_AXIS_DATA_WIDTH/8)-1:0] be_tx_strb;

   // Action Buffering
   reg [OPENFLOW_ACTION_SIZE-1:0] result_reg;
   reg [OPENFLOW_ACTION_SIZE -1: 0] lu_action_d;
   reg lu_done_d;
   reg lu_done_int;

   // Action fields
   wire [`OPENFLOW_FORWARD_BITMASK_WIDTH-1:0] forward_bitmask;
   wire [`OPENFLOW_NF2_ACTION_FLAG_WIDTH-1:0] nf2_action_flag;
   wire [`OPENFLOW_SET_VLAN_VID_WIDTH-1:0] set_vlan_vid;
   wire [`OPENFLOW_SET_VLAN_PCP_WIDTH-1:0] set_vlan_pcp;
   wire [`OPENFLOW_SET_DL_SRC_WIDTH-1:0] set_dl_src;
   wire [`OPENFLOW_SET_DL_DST_WIDTH-1:0] set_dl_dst;
   wire [`OPENFLOW_SET_NW_SRC_WIDTH-1:0] set_nw_src;
   wire [`OPENFLOW_SET_NW_DST_WIDTH-1:0] set_nw_dst;
   wire [`OPENFLOW_SET_NW_TOS_WIDTH-1:0] set_nw_tos;
   wire [`OPENFLOW_SET_TP_SRC_WIDTH-1:0] set_tp_src;
   wire [`OPENFLOW_SET_TP_DST_WIDTH-1:0] set_tp_dst;
   // 1.1
   wire [`OPENFLOW_SET_NW_ECN_WIDTH-1:0] set_nw_ecn;
   // 1.1 Currently modifications below are not supported
   wire [15:0] set_vlan_type;
   wire [7:0] set_nw_ttl;

   // Input buffer and peripheral
   reg fifo_rd_en;
   wire fifo_nearly_full;
   wire fifo_empty;

   reg tready_int;

   wire tx_valid_infifo;
   reg tx_valid, tx_valid_nxt;
   wire tx_last_infifo;
   reg tx_last, tx_last_nxt;
   wire [C_AXIS_DATA_WIDTH-1:0] tx_data;
   wire [C_AXIS_DATA_WIDTH/8-1:0] tx_strb;

   // VLAN tag handling
   reg vlan_msb, vlan_lsb, vlan_lsb_or_msb, vlan_lsb_msb, vlan_lsb_not_msb;
   wire vlan_msb_nxt, vlan_lsb_nxt;

   // DATA read state machine
   reg [NUM_DT_RD_STATES-1:0] dt_rd_state, dt_rd_state_nxt;
   reg dt_rd_onemore, dt_rd_onemore_nxt;

   // DL state machine
   reg [NUM_DL_STATES-1:0]  dl_state, dl_state_nxt;
   reg dl_out_wr, dl_out_wr_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] dl_out_data, dl_out_data_nxt;
   reg [C_AXIS_DATA_WIDTH/2-1:0] dl_out_data_buf, dl_out_data_buf_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] dl_out_strb, dl_out_strb_nxt;
   reg [C_AXIS_DATA_WIDTH/16-1:0] dl_out_strb_buf, dl_out_strb_buf_nxt;
   reg dl_out_last, dl_out_last_nxt;
   reg dl_proc_start, dl_proc_start_nxt;
   reg [1:0] dl_proc_done, dl_proc_done_nxt;

   reg dl_out_wr_sft;
   reg dl_proc_done_sft;
   reg [C_AXIS_DATA_WIDTH-1:0] dl_out_data_sft;
   reg [NUM_NW_STATES-1:0] nw_diff_state;

   // NW/TP state machine
   reg is_ip, is_ip_nxt, is_ip_1st, is_ip_2nd;
   reg is_udp, is_udp_nxt, is_udp_1st, is_udp_2nd;
   reg is_tcp, is_tcp_nxt, is_tcp_1st, is_tcp_2nd;
   reg is_sctp, is_sctp_nxt, is_sctp_1st, is_sctp_2nd;
   reg [4:0] ip_hlen, ip_hlen_nxt, ip_hlen_1st, ip_hlen_2nd;

   reg [NUM_NW_STATES-1:0]  nw_state, nw_state_nxt;
   reg nw_out_wr, nw_out_wr_nxt, nw_out_wr_1st, nw_out_wr_2nd;
   reg [C_AXIS_DATA_WIDTH-1:0] nw_out_data, nw_out_data_nxt, nw_out_data_1st, nw_out_data_2nd;
   reg [C_AXIS_DATA_WIDTH/8-1:0] nw_out_strb, nw_out_strb_nxt, nw_out_strb_1st, nw_out_strb_2nd;
   reg nw_out_last, nw_out_last_nxt, nw_out_last_1st, nw_out_last_2nd;
   reg [1:0] nw_dl_proc_done, nw_dl_proc_done_nxt, nw_dl_proc_done_1st, nw_dl_proc_done_2nd;
   reg [1:0] nw_proc_done, nw_proc_done_nxt, nw_proc_done_1st, nw_proc_done_2nd;

   reg [16:0] nw_tos_diff, nw_tos_diff_nxt, nw_tos_diff_2nd;
   reg [16:0] nw_ttl_diff, nw_ttl_diff_nxt, nw_ttl_diff_2nd;
   reg [16:0] nw_src_h_diff, nw_src_h_diff_nxt, nw_src_h_diff_2nd;
   reg [16:0] nw_src_l_diff, nw_src_l_diff_nxt, nw_src_l_diff_2nd;
   reg [16:0] nw_dst_h_diff, nw_dst_h_diff_nxt, nw_dst_h_diff_2nd;
   reg [16:0] nw_dst_l_diff, nw_dst_l_diff_nxt, nw_dst_l_diff_2nd;
   reg [16:0] nw_cs_inv, nw_cs_inv_nxt, nw_cs_inv_2nd;

   reg [16:0] tp_src_diff, tp_src_diff_nxt, tp_src_diff_2nd;
   reg [16:0] tp_dst_diff, tp_dst_diff_nxt, tp_dst_diff_2nd;
   reg [16:0] tp_cs_inv, tp_cs_inv_nxt, tp_cs_inv_2nd;

   // IP checksum recalc state machine
   reg [16:0] nw_diff1, nw_diff1_nxt;
   reg [16:0] nw_diff2, nw_diff2_nxt;
   reg [16:0] nw_pseudo_diff, nw_pseudo_diff_nxt;
   reg nw_cs_done, nw_cs_done_nxt;
   reg [NUM_NWCS_STATES-1:0] nwcs_state, nwcs_state_nxt;
   reg [1:0] nw_proc_flag, nw_proc_flag_nxt;
   reg [1:0] nw_nxt_proc_flag, nw_nxt_proc_flag_nxt;

   // TP checksum recalc state machine
   reg tp_proto, tp_proto_nxt;
   reg [16:0] tp_diff, tp_diff_nxt;
   reg tp_cs_done, tp_cs_done_nxt;
   reg [NUM_TPCS_STATES-1:0] tpcs_state, tpcs_state_nxt;
   reg [1:0] tp_proc_flag, tp_proc_flag_nxt;

   // Update checksum state machine
   reg [C_AXIS_DATA_WIDTH-1:0] nw_out_data_1, nw_out_data_1_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] nw_out_strb_1, nw_out_strb_1_nxt;
   reg nw_out_last_1, nw_out_last_1_nxt;
   reg nw_out_wr_1, nw_out_wr_1_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] nw_out_data_2, nw_out_data_2_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] nw_out_strb_2, nw_out_strb_2_nxt;
   reg nw_out_last_2, nw_out_last_2_nxt;
   reg nw_out_wr_2, nw_out_wr_2_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] nw_out_data_3, nw_out_data_3_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] nw_out_strb_3, nw_out_strb_3_nxt;
   reg nw_out_last_3, nw_out_last_3_nxt;
   reg nw_out_wr_3, nw_out_wr_3_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] nw_out_data_4, nw_out_data_4_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] nw_out_strb_4, nw_out_strb_4_nxt;
   reg nw_out_last_4, nw_out_last_4_nxt;
   reg nw_out_wr_4, nw_out_wr_4_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] nw_out_data_5, nw_out_data_5_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] nw_out_strb_5, nw_out_strb_5_nxt;
   reg nw_out_last_5, nw_out_last_5_nxt;
   reg nw_out_wr_5, nw_out_wr_5_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] tp_out_data, tp_out_data_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] tp_out_strb, tp_out_strb_nxt;
   reg tp_out_last, tp_out_last_nxt;
   reg tp_out_wr, tp_out_wr_nxt;
   reg [2:0] shift_cnt, shift_cnt_nxt;
   reg [NUM_SHIFT_STATES-1:0] shift_state, shift_state_nxt;

   // Endian conversion and output
   wire [C_AXIS_DATA_WIDTH-1:0] le_tp_out_data;
   wire [C_AXIS_DATA_WIDTH/8-1:0] le_tp_out_strb;
   wire m_axis_tlast_int;
   wire m_axis_tvalid_dummy;
   wire pkt_buf_empty;
   reg m_tdata_rd_en;

   // Metadata handling
   reg s_tuser_valid, s_tuser_valid_nxt;
   wire s_tuser_wr_en;
   wire [C_AXIS_TUSER_WIDTH-1:0] tx_user;
   reg [C_AXIS_TUSER_WIDTH-1:0] tx_user_1, tx_user_1_nxt;
   reg tx_user_rd_en;
   reg [NUM_TU_STATES-1:0] s_tuser_state, s_tuser_state_nxt;

   reg mi_tuser_valid, mi_tuser_valid_nxt;
   wire m_tuser_wr_en;
   reg m_tuser_rd_en;
   reg [NUM_TU_STATES-1:0] mi_tuser_state, mi_tuser_state_nxt;

   // Outgoing DATA read state machine
   reg [NUM_DT_RD_STATES-1:0] out_dt_rd_state, out_dt_rd_state_nxt;

   // Debug register
   reg [31:0] num_pkts_processed_nxt;

   //--------------------------- Logic -------------------------------

   // Pkt/Tuser input_buf
   // May take up 11clk max from receiving data to start reading it
   // Need at least 11bit depth.

   always @(*) begin
      s_tuser_valid_nxt = s_tuser_valid;
      s_tuser_state_nxt = s_tuser_state;
      case (s_tuser_state)
         TU_WAIT_TVALID: begin
            if (s_axis_tvalid) begin
               s_tuser_valid_nxt = 0;
               s_tuser_state_nxt = TU_WAIT_TLAST;
            end
         end
         TU_WAIT_TLAST: begin
            if (s_axis_tlast) begin
               s_tuser_valid_nxt = 1;
               s_tuser_state_nxt = TU_WAIT_TVALID;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         s_tuser_valid <= 1;
         s_tuser_state <= TU_WAIT_TVALID;
      end
      else begin
         s_tuser_valid <= s_tuser_valid_nxt;
         s_tuser_state <= s_tuser_state_nxt;
      end
   end

   assign s_tuser_wr_en = s_axis_tvalid && s_tuser_valid;

   fallthrough_small_fifo
     #(.WIDTH(C_AXIS_TUSER_WIDTH), .MAX_DEPTH_BITS(4))
     input_metadata_buf
       (.din           (s_axis_tuser),
        .wr_en         (s_tuser_wr_en),
        .rd_en         (tx_user_rd_en),
        .dout          (tx_user),
        .full          (),
        .prog_full     (),
        .nearly_full   (tx_user_nearly_full),
        .empty         (tx_user_empty),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   fallthrough_small_fifo
     #(.WIDTH(FIFO_DATA_WIDTH), .MAX_DEPTH_BITS(4))
     input_buf
       (.din           ({s_axis_tvalid, s_axis_tlast,
                         s_axis_tstrb,
                         s_axis_tdata}),  // Data in
        .wr_en         ((s_axis_tvalid && s_axis_tready)),   // Write enable
        .rd_en         (fifo_rd_en),      // Read the next word
        .dout          ({tx_valid_infifo, tx_last_infifo,
                        tx_strb,
                        tx_data}), // tx_valid should always be 1
        .full          (),
        .prog_full     (),
        .nearly_full   (fifo_nearly_full),
        .empty         (fifo_empty),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   // Endian conversion from AXI little endian to
   // network order
   // Assumption: Data is always 64bit width
   generate
      genvar i;
      for (i=0; i<8; i=i+1) begin:gen_network_order_data
         assign be_tx_strb_infifo[7-i] = tx_strb[i];
         assign be_tx_data_infifo[((56-i*8)+7):(56-i*8)]  = tx_data[(i*8+7):(i*8)];
      end
   endgenerate

   // Start reading data into FIFO after getting
   // request from pkt_preprocess module
   always @(posedge asclk) begin
      if (~aresetn) begin
         tready_int <= 0;
      end
      else begin
         if (lu_req) begin
            tready_int <= 1;
         end
         else if (s_axis_tlast) begin
            tready_int <= 0;
         end
      end
   end

   assign s_axis_tready = (~fifo_nearly_full) && tready_int;

   always @(posedge asclk) begin
      if (~aresetn) begin
         lu_done_d <= 0;
         lu_action_d <= 0;
      end
      else begin
         lu_done_d <= lu_done;
         lu_action_d <= lu_action;
      end
   end

   // Start processing pkt after receiving
   // flowtable_lookup is done in flow_tbl module
   always @(posedge asclk) begin
      if (~aresetn) begin
         lu_done_int <= 0;
      end
      else begin
         if (lu_done_d) begin
            lu_done_int <= 1;
         end
         else if (dl_proc_start) begin
            lu_done_int <= 0;
         end
      end
   end

   // Latch Action Info
   always @(posedge asclk) begin
      if (~aresetn) begin
         result_reg <= 0;
      end
      else begin
         if (lu_done_d) begin
            result_reg <= lu_action_d;
         end
      end
   end

   // Parse actions
   assign forward_bitmask = (result_reg[`OPENFLOW_FORWARD_BITMASK_POS +:
                             `OPENFLOW_FORWARD_BITMASK_WIDTH]);
   assign nf2_action_flag = (result_reg[`OPENFLOW_NF2_ACTION_FLAG_POS +:
                             `OPENFLOW_NF2_ACTION_FLAG_WIDTH]);
   assign set_vlan_vid = (result_reg[`OPENFLOW_SET_VLAN_VID_POS +:
                          `OPENFLOW_SET_VLAN_VID_WIDTH]);
   assign set_vlan_pcp = (result_reg[`OPENFLOW_SET_VLAN_PCP_POS +:
                          `OPENFLOW_SET_VLAN_PCP_WIDTH]);
   assign set_dl_src   = (result_reg[`OPENFLOW_SET_DL_SRC_POS +:
                          `OPENFLOW_SET_DL_SRC_WIDTH]);
   assign set_dl_dst   = (result_reg[`OPENFLOW_SET_DL_DST_POS +:
                          `OPENFLOW_SET_DL_DST_WIDTH]);
   assign set_nw_src   = (result_reg[`OPENFLOW_SET_NW_SRC_POS +:
                          `OPENFLOW_SET_NW_SRC_WIDTH]);
   assign set_nw_dst   = (result_reg[`OPENFLOW_SET_NW_DST_POS +:
                          `OPENFLOW_SET_NW_DST_WIDTH]);
   assign set_nw_tos   = (result_reg[`OPENFLOW_SET_NW_TOS_POS +:
                          `OPENFLOW_SET_NW_TOS_WIDTH]);
   assign set_tp_src   = (result_reg[`OPENFLOW_SET_TP_SRC_POS +:
                          `OPENFLOW_SET_TP_SRC_WIDTH]);
   assign set_tp_dst   = (result_reg[`OPENFLOW_SET_TP_DST_POS +:
                          `OPENFLOW_SET_TP_DST_WIDTH]);
   // 1.1. Temporary bitmap position
   assign set_nw_ecn   = (result_reg[`OPENFLOW_SET_NW_ECN_POS +:
                          `OPENFLOW_SET_NW_ECN_WIDTH]);
   // 1.1. Temporarily set the fixed value
   assign set_vlan_type = 16'h8100;
   assign set_nw_ttl = 8'h0;

   // Data reading
   always @(*) begin
      fifo_rd_en = 0;
      tx_valid_nxt = 0;
      tx_last_nxt = 0;
      dt_rd_onemore_nxt = 0;
      dt_rd_state_nxt = dt_rd_state;
      case (dt_rd_state)
         DT_RD_1ST: begin
            if (lu_done_int) begin
               if (~fifo_empty) begin
                  fifo_rd_en = 1;
                  tx_valid_nxt = tx_valid_infifo;
                  dt_rd_state_nxt = DT_RD_REST;
               end
            end
         end
         DT_RD_REST: begin
            if (~fifo_empty) begin
               fifo_rd_en = 1;
               tx_valid_nxt = tx_valid_infifo;
               tx_last_nxt = tx_last_infifo;
               if (tx_last_infifo) begin
                  if (|be_tx_strb_infifo[3:0]) begin
                     dt_rd_onemore_nxt = 1;
                     dt_rd_state_nxt = DT_RD_WAIT;
                  end
                  else begin
                     dt_rd_state_nxt = DT_RD_1ST;
                  end
               end
            end
         end
         DT_RD_WAIT: begin
            dt_rd_state_nxt = DT_RD_1ST;
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         tx_valid <= 0;
         tx_last <= 0;
         dt_rd_onemore <= 0;
         dt_rd_state <= DT_RD_1ST;
      end
      else begin
         tx_valid <= tx_valid_nxt;
         tx_last <= tx_last_nxt;
         dt_rd_onemore <= dt_rd_onemore_nxt;
         dt_rd_state <= dt_rd_state_nxt;
      end
   end

   assign vlan_msb_nxt = ((be_tx_data_infifo[63:48] == `TYPE_VLAN) || (be_tx_data_infifo[63:48] == `TYPE_VLAN_QINQ)) ? 1 : 0;
   assign vlan_lsb_nxt = ((be_tx_data_infifo[31:16] == `TYPE_VLAN) || (be_tx_data_infifo[31:16] == `TYPE_VLAN_QINQ)) ? 1 : 0;

   always @(posedge asclk) begin
      if (~aresetn) begin
         be_tx_data <= 0;
         be_tx_strb <= 0;
         vlan_msb <= 0;
         vlan_lsb <= 0;
         vlan_lsb_or_msb <= 0;
         vlan_lsb_msb <= 0;
         vlan_lsb_not_msb <= 0;
      end
      else begin
         be_tx_data <= be_tx_data_infifo;
         be_tx_strb <= be_tx_strb_infifo;
         vlan_lsb <= vlan_lsb_nxt;
         vlan_msb <= vlan_msb_nxt;
         vlan_lsb_or_msb <= (vlan_lsb_nxt || vlan_msb_nxt);
         vlan_lsb_msb <= (vlan_lsb_nxt && vlan_msb_nxt);
         vlan_lsb_not_msb <= (vlan_lsb_nxt && ~vlan_msb_nxt);
      end
   end

   //--- DL header handlilng
   // It processes each header with reading data from input FIFO
   // Overwrite new values if requested
   always @(*) begin
      tx_user_rd_en = 0;
      dl_out_wr_nxt = 0;
      tx_user_1_nxt = tx_user_1;
      dl_out_data_nxt = be_tx_data;
      dl_out_strb_nxt = be_tx_strb;
      dl_out_data_buf_nxt = dl_out_data_buf;
      dl_out_strb_buf_nxt = dl_out_strb_buf;
      dl_out_last_nxt = tx_last;
      dl_proc_start_nxt = 0;
      dl_proc_done_nxt = 0;
      dl_state_nxt = dl_state;
      case (dl_state)
         DL_HDR_1ST: begin
            tx_user_1_nxt[C_AXIS_TUSER_WIDTH-1:
                          (TUSER_DPT_POS+C_AXIS_DPT_DATA_WIDTH)] =
               tx_user[C_AXIS_TUSER_WIDTH-1:
                       (TUSER_DPT_POS+C_AXIS_DPT_DATA_WIDTH)];
            tx_user_1_nxt[TUSER_DPT_POS +: C_AXIS_DPT_DATA_WIDTH] =
               forward_bitmask[C_AXIS_DPT_DATA_WIDTH-1:0];
            tx_user_1_nxt[TUSER_DPT_POS-1:0] = tx_user[TUSER_DPT_POS-1:0];
            if (tx_valid) begin
               tx_user_rd_en = 1;
               dl_out_wr_nxt = 1;
               if (nf2_action_flag & `NF2_OFPAT_SET_DL_DST) begin
                  dl_out_data_nxt[63:16] = set_dl_dst;
               end
               if (nf2_action_flag & `NF2_OFPAT_SET_DL_SRC) begin
                  dl_out_data_nxt[15:0] = set_dl_src[47:32];
               end
               dl_proc_start_nxt = 1;
               dl_state_nxt = DL_HDR_2ND;
            end
         end

         DL_HDR_2ND: begin
            if (tx_valid) begin
               if (nf2_action_flag & `NF2_OFPAT_SET_DL_SRC) begin
                  dl_out_data_nxt[63:32] = set_dl_src[31:0];
               end

               // POP VLAN
               if (nf2_action_flag & `NF2_OFPAT_POP_VLAN) begin
                  if (vlan_lsb) begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_DL_SRC) begin
                        dl_out_data_buf_nxt = set_dl_src[31:0];
                     end
                     else begin
                        dl_out_data_buf_nxt = be_tx_data[63:32];
                     end
                     dl_out_strb_buf_nxt = be_tx_strb[7:4];
                     tx_user_1_nxt = tx_user_1;
                     tx_user_1_nxt[TUSER_LEN_POS +: C_AXIS_LEN_DATA_WIDTH] =
                        tx_user_1[TUSER_LEN_POS +: C_AXIS_LEN_DATA_WIDTH]-4;
                     dl_state_nxt = DL_HDR_3RD_POP;
                  end
                  // Can't pop VLAN so do nothing and finish the process
                  else begin
                     dl_out_wr_nxt = 1;
                     dl_proc_done_nxt = FLAG_START_LSB;
                     dl_state_nxt = DL_THRU;
                  end
               end

               // PUSH action
               else if (nf2_action_flag & `NF2_OFPAT_PUSH_VLAN) begin
                  dl_out_wr_nxt = 1;
                  dl_out_data_nxt[31:16] = set_vlan_type;
                  dl_out_data_nxt[12] = 0;
                  dl_out_strb_nxt[3:0] = 4'b1111;
                  dl_out_data_buf_nxt = be_tx_data[31:0];
                  dl_out_strb_buf_nxt = be_tx_strb[3:0];
                  tx_user_1_nxt = tx_user_1;
                  tx_user_1_nxt[TUSER_LEN_POS +: C_AXIS_LEN_DATA_WIDTH] =
                     tx_user_1[TUSER_LEN_POS +: C_AXIS_LEN_DATA_WIDTH]+4;
                  dl_state_nxt = DL_SFT_CHK;
                  // tag already exists
                  if (vlan_lsb_or_msb) begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_VLAN_VID) begin
                        dl_out_data_nxt[11:0] = set_vlan_vid[11:0];
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_VLAN_PCP) begin
                        dl_out_data_nxt[15:13] = set_vlan_pcp[2:0];
                     end
                  end
                  // tag not exist
                  else begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_VLAN_VID) begin
                        dl_out_data_nxt[11:0] = set_vlan_vid[11:0];
                     end
                     else begin
                        dl_out_data_nxt[11:0] = 0;
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_VLAN_PCP) begin
                        dl_out_data_nxt[15:13] = set_vlan_pcp[2:0];
                     end
                     else begin
                        dl_out_data_nxt[15:13] = 0;
                     end
                  end
               end

               // Modify action or NO VLAN actions
               // (no tag addition or deletion)
               else begin
                  dl_out_wr_nxt = 1;
                  if (vlan_lsb) begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_VLAN_VID) begin
                        dl_out_data_nxt[11:0] = set_vlan_vid[11:0];
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_VLAN_PCP) begin
                        dl_out_data_nxt[15:13] = set_vlan_pcp[2:0];
                     end
                     dl_state_nxt = DL_THRU_CHK;
                  end
                  else begin
                     dl_proc_done_nxt = FLAG_START_LSB;
                     dl_state_nxt = DL_THRU;
                  end
               end
            end
         end

         // Wait until there's no more tags
         DL_THRU_CHK: begin
            if (tx_valid) begin
               dl_out_wr_nxt = 1;
               if (vlan_lsb_msb) begin
                  dl_state_nxt = DL_THRU_CHK;
               end
               if (vlan_lsb_not_msb) begin
                  dl_proc_done_nxt = FLAG_START_LSB;
                  dl_state_nxt = DL_THRU;
               end
               if (~vlan_lsb) begin
                  dl_proc_done_nxt = FLAG_START_MSB;
                  dl_state_nxt = DL_THRU;
               end
            end
         end

         DL_THRU: begin
            if (tx_valid) begin
               dl_out_wr_nxt = 1;
               if (tx_last) begin
                  dl_state_nxt = DL_HDR_1ST;
               end
            end
         end

         DL_HDR_3RD_POP: begin
            if (tx_valid) begin
               dl_out_wr_nxt = 1;
               dl_out_data_nxt[63:32] = dl_out_data_buf;
               dl_out_data_nxt[31:0] = be_tx_data[63:32];
               dl_out_data_buf_nxt = be_tx_data[31:0];
               dl_out_strb_nxt[7:4] = dl_out_strb_buf;
               dl_out_strb_nxt[3:0] = be_tx_strb[7:4];
               dl_out_strb_buf_nxt = be_tx_strb[3:0];
               if (vlan_msb) begin
                  dl_state_nxt = DL_SFT_CHK;
               end
               else begin
                  dl_proc_done_nxt = FLAG_START_LSB;
                  dl_state_nxt = DL_SFT;
               end
            end
         end

         // Wait until there's no more tags
         DL_SFT_CHK: begin
            if (tx_valid) begin
               dl_out_wr_nxt = 1;
               dl_out_data_nxt[63:32] = dl_out_data_buf;
               dl_out_data_nxt[31:0] = be_tx_data[63:32];
               dl_out_data_buf_nxt = be_tx_data[31:0];
               dl_out_strb_nxt[7:4] = dl_out_strb_buf;
               dl_out_strb_nxt[3:0] = be_tx_strb[7:4];
               dl_out_strb_buf_nxt = be_tx_strb[3:0];

               if (vlan_lsb_msb) begin
                  dl_state_nxt = DL_SFT_CHK;
               end
               if (vlan_lsb_not_msb) begin
                  dl_proc_done_nxt = FLAG_START_LSB;
                  dl_state_nxt = DL_SFT;
               end
               if (~vlan_lsb) begin
                  dl_proc_done_nxt = FLAG_START_MSB;
                  dl_state_nxt = DL_SFT;
               end
            end
         end

         DL_SFT: begin
            if (tx_valid) begin
               dl_out_wr_nxt = 1;
               dl_out_data_nxt[63:32] = dl_out_data_buf;
               dl_out_data_nxt[31:0] = be_tx_data[63:32];
               dl_out_data_buf_nxt = be_tx_data[31:0];
               dl_out_strb_nxt[7:4] = dl_out_strb_buf;
               dl_out_strb_nxt[3:0] = be_tx_strb[7:4];
               dl_out_strb_buf_nxt = be_tx_strb[3:0];

               if (tx_last) begin
                  // LSBs still have valid data
                  // Need to flush the final half-word
                  if (dt_rd_onemore) begin
                     dl_out_last_nxt = 0;
                     dl_state_nxt = DL_SFT_LAST;
                  end
                  // No more valid data
                  else begin
                     dl_state_nxt = DL_HDR_1ST;
                  end
               end
            end
         end

         DL_SFT_LAST: begin
            dl_out_wr_nxt = 1;
            dl_out_data_nxt[63:32] = dl_out_data_buf;
            dl_out_data_nxt[31:0] = 32'hCAFE_F00D;
            dl_out_strb_nxt[7:4] = dl_out_strb_buf;
            dl_out_strb_nxt[3:0] = 0;
            dl_out_last_nxt = 1;
            dl_state_nxt = DL_HDR_1ST;
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         tx_user_1 <= 0;
         dl_out_wr <= 0;
         dl_out_data <= 0;
         dl_out_data_buf <= 0;
         dl_out_strb <= 0;
         dl_out_strb_buf <= 0;
         dl_out_last <= 0;
         dl_proc_start <= 0;
         dl_proc_done <= 0;
         dl_state <= DL_HDR_1ST;
      end
      else begin
         tx_user_1 <= tx_user_1_nxt;
         dl_out_wr <= dl_out_wr_nxt;
         dl_out_data <= dl_out_data_nxt;
         dl_out_data_buf <= dl_out_data_buf_nxt;
         dl_out_strb <= dl_out_strb_nxt;
         dl_out_strb_buf <= dl_out_strb_buf_nxt;
         dl_out_last <= dl_out_last_nxt;
         dl_proc_start <= dl_proc_start_nxt;
         dl_proc_done <= dl_proc_done_nxt;
         dl_state <= dl_state_nxt;
      end
   end

   //--- NW/TP header handlilng
   // Overwrite new values if requested
   always @(*) begin
      nw_out_data_nxt = nw_out_data_1st;
      nw_out_strb_nxt = nw_out_strb_1st;
      nw_out_last_nxt = dl_out_last;
      nw_out_wr_nxt = dl_out_wr;
      nw_dl_proc_done_nxt = dl_proc_done;
      nw_proc_done_nxt = 0;
      is_ip_nxt = is_ip_1st;
      is_udp_nxt = is_udp_1st;
      is_tcp_nxt = is_tcp_1st;
      is_sctp_nxt = is_sctp_1st;
      ip_hlen_nxt = ip_hlen_1st;
      nw_state_nxt = nw_state;

      case (nw_state)
         NW_HDR_1ST: begin
            is_udp_nxt = 0;
            is_tcp_nxt = 0;
            is_sctp_nxt = 0;
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (dl_proc_done == FLAG_START_MSB) begin
                  if (dl_out_data[63:48] == `TYPE_IP) begin
                     is_ip_nxt = 1;
                     ip_hlen_nxt = dl_out_data[43:40] *2-3;
                     if (nf2_action_flag & `NF2_OFPAT_SET_NW_TOS) begin
                        nw_out_data_nxt[39:34] = set_nw_tos;
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_NW_ECN) begin
                        nw_out_data_nxt[33:32] = set_nw_ecn;
                     end
                     nw_state_nxt = NW_HDR_2ND_PTN2;
                  end
                  // Not IP. No more actions needed
                  else begin
                     is_ip_nxt = 0;
                     nw_state_nxt = NW_THRU;
                  end
               end
               else if (dl_proc_done == FLAG_START_LSB) begin
                  if (dl_out_data[31:16] == `TYPE_IP) begin
                     is_ip_nxt = 1;
                     ip_hlen_nxt = dl_out_data[11:8] *2-1;
                     if (nf2_action_flag & `NF2_OFPAT_SET_NW_TOS) begin
                        nw_out_data_nxt[7:2] = set_nw_tos;
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_NW_ECN) begin
                        nw_out_data_nxt[1:0] = set_nw_ecn;
                     end
                     nw_state_nxt = NW_HDR_2ND_PTN1;
                  end
                  // Not IP. No more actions needed
                  else begin
                     is_ip_nxt = 0;
                     nw_state_nxt = NW_THRU;
                  end
               end
            end
         end

         NW_HDR_2ND_PTN1: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               ip_hlen_nxt = ip_hlen_1st-4;
               // TTL mod/dec
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_TTL) begin
                  nw_out_data_nxt[15:8] = set_nw_ttl;
               end
               else if (nf2_action_flag & `NF2_OFPAT_DEC_NW_TTL) begin
                  nw_out_data_nxt[15:8] = dl_out_data[15:8] - 1;
               end
               // Proto chk
               if (dl_out_data[7:0] == `PROTO_TCP) begin
                  is_tcp_nxt = 1;
               end
               else if (dl_out_data[7:0] == `PROTO_UDP) begin
                  is_udp_nxt = 1;
               end
               else if (dl_out_data[7:0] == `PROTO_SCTP) begin
                  is_sctp_nxt = 1;
               end
               nw_state_nxt = NW_HDR_3RD_PTN1;
            end
         end

         NW_HDR_2ND_PTN2: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               ip_hlen_nxt = ip_hlen_1st-4;
               // TTL mod/dec
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_TTL) begin
                  nw_out_data_nxt[47:40] = set_nw_ttl;
               end
               else if (nf2_action_flag & `NF2_OFPAT_DEC_NW_TTL) begin
                  nw_out_data_nxt[47:40] = dl_out_data[47:40] - 1;
               end
               // Proto chk
               if (dl_out_data[39:32] == `PROTO_TCP) begin
                  is_tcp_nxt = 1;
               end
               else if (dl_out_data[39:32] == `PROTO_UDP) begin
                  is_udp_nxt = 1;
               end
               else if (dl_out_data[39:32] == `PROTO_SCTP) begin
                  is_sctp_nxt = 1;
               end

               if (nf2_action_flag & `NF2_OFPAT_SET_NW_SRC) begin
                  nw_out_data_nxt[15:0] = set_nw_src[31:16];
               end
               nw_state_nxt = NW_HDR_3RD_PTN2;
            end
         end

         NW_HDR_3RD_PTN1: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               ip_hlen_nxt = ip_hlen_1st-4;
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_SRC) begin
                  nw_out_data_nxt[47:16] = set_nw_src;
               end
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_DST) begin
                  nw_out_data_nxt[15:0] = set_nw_dst[31:16];
               end
               nw_state_nxt = NW_HDR_4TH_PTN1;
            end
         end

         NW_HDR_3RD_PTN2: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_SRC) begin
                  nw_out_data_nxt[63:48] = set_nw_src[15:0];
               end
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_DST) begin
                  nw_out_data_nxt[47:16] = set_nw_dst;
               end
               if (ip_hlen_1st == 3) begin
                  if (is_udp_1st || is_tcp_1st) begin
                  // currently SCTP chksum update not supported
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_SRC) begin
                        nw_out_data_nxt[15:0] = set_tp_src;
                     end
                     nw_state_nxt = TP_HDR_2ND_PTN1;
                  end
                  else begin
                     nw_state_nxt = NW_THRU;
                  end
                  nw_proc_done_nxt = FLAG_START_LSB;
               end
               //TODO: Error handling when illegal hlen value
               else begin
                  ip_hlen_nxt = ip_hlen_1st-4;
                  nw_state_nxt = NW_OPT_PASS;
               end
            end
         end

         NW_HDR_4TH_PTN1: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (nf2_action_flag & `NF2_OFPAT_SET_NW_DST) begin
                  nw_out_data_nxt[63:48] = set_nw_dst[15:0];
               end
               if (ip_hlen_1st == 1) begin
                  if (is_udp_1st || is_tcp_1st) begin
                  // currently SCTP chksum update not supported
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_SRC) begin
                        nw_out_data_nxt[47:32] = set_tp_src;
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_DST) begin
                        nw_out_data_nxt[31:16] = set_tp_dst;
                     end
                     nw_state_nxt = TP_HDR_2ND_PTN2;
                  end
                  else begin
                     nw_state_nxt = NW_THRU;
                  end
                  nw_proc_done_nxt = FLAG_START_MSB;
               end
               else if (ip_hlen_1st == 3) begin
                  if (is_udp_1st || is_tcp_1st) begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_SRC) begin
                        nw_out_data_nxt[15:0] = set_tp_src;
                     end
                     nw_state_nxt = TP_HDR_2ND_PTN1;
                  end
                  else begin
                     nw_state_nxt = NW_THRU;
                  end
                  nw_proc_done_nxt = FLAG_START_LSB;
               end
               //TODO: Error handling when illegal hlen value
               else begin
                  ip_hlen_nxt = ip_hlen_1st - 4;
                  nw_state_nxt = NW_OPT_PASS;
               end
            end
         end

         NW_OPT_PASS: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (ip_hlen_1st == 1) begin
                  if (is_udp_1st || is_tcp_1st) begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_SRC) begin
                        nw_out_data_nxt[48:32] = set_tp_src;
                     end
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_DST) begin
                        nw_out_data_nxt[31:16] = set_tp_dst;
                     end
                     nw_state_nxt = TP_HDR_2ND_PTN2;
                  end
                  else begin
                     nw_state_nxt = NW_THRU;
                  end
                  nw_proc_done_nxt = FLAG_START_MSB;
               end
               else if (ip_hlen_1st == 3) begin
                  if (is_udp_1st || is_tcp_1st) begin
                     if (nf2_action_flag & `NF2_OFPAT_SET_TP_SRC) begin
                        nw_out_data_nxt[15:0] = set_tp_src;
                     end
                     nw_state_nxt = TP_HDR_2ND_PTN1;
                  end
                  else begin
                     nw_state_nxt = NW_THRU;
                  end
                  nw_proc_done_nxt = FLAG_START_LSB;
               end
               //TODO: Error handling when illegal hlen value
               else begin
                  ip_hlen_nxt = ip_hlen_1st-4;
               end
            end
         end

         TP_HDR_2ND_PTN1: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (nf2_action_flag & `NF2_OFPAT_SET_TP_DST) begin
                  nw_out_data_nxt[63:48] = set_tp_dst;
               end
               if (is_tcp_1st) begin
                  nw_state_nxt = TP_HDR_3RD_PTN1;
               end
               else begin
                  nw_state_nxt = NW_THRU;
               end
            end
         end

         TP_HDR_2ND_PTN2: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (is_tcp_1st) begin
                  nw_state_nxt = TP_HDR_3RD_PTN2;
               end
               else begin
                  nw_state_nxt = NW_THRU;
               end
            end
         end

         TP_HDR_3RD_PTN1: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               nw_state_nxt = NW_THRU;
            end
         end

         TP_HDR_3RD_PTN2: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               nw_state_nxt = NW_THRU;
            end
         end

         NW_THRU: begin
            if (dl_out_wr) begin
               nw_out_data_nxt = dl_out_data;
               nw_out_strb_nxt = dl_out_strb;
               if (dl_out_last) begin
                  nw_state_nxt = NW_HDR_1ST;
               end
            end
         end
      endcase
   end

   //--- NW/TP header handlilng
   // Overwrite new values if requested
   always @(*) begin
      nw_tos_diff_nxt = nw_tos_diff_2nd;
      nw_ttl_diff_nxt = nw_ttl_diff_2nd;
      nw_src_h_diff_nxt = nw_src_h_diff_2nd;
      nw_src_l_diff_nxt = nw_src_l_diff_2nd;
      nw_dst_h_diff_nxt = nw_dst_h_diff_2nd;
      nw_dst_l_diff_nxt = nw_dst_l_diff_2nd;
      nw_cs_inv_nxt = nw_cs_inv_2nd;
      tp_src_diff_nxt = tp_src_diff_2nd;
      tp_dst_diff_nxt = tp_dst_diff_2nd;
      tp_cs_inv_nxt = tp_cs_inv_2nd;

      case (nw_diff_state)
         NW_HDR_1ST: begin
            if (dl_out_wr_sft) begin
               if (dl_proc_done_sft == FLAG_START_MSB) begin
                  if (dl_out_data_sft[63:48] == `TYPE_IP) begin
                     // Checksum recalc prep
                     nw_tos_diff_nxt = {9'h00, nw_out_data_1st[39:32]} +
                                       {9'hFF, ~dl_out_data_sft[39:32]};
                  end
                  // Not IP. No more actions needed
                  else begin
                     nw_tos_diff_nxt = 0;
                     nw_ttl_diff_nxt = 0;
                     nw_src_h_diff_nxt = 0;
                     nw_src_l_diff_nxt = 0;
                     nw_dst_h_diff_nxt = 0;
                     nw_dst_l_diff_nxt = 0;
                     nw_cs_inv_nxt = 0;
                  end
               end
               else if (dl_proc_done_sft == FLAG_START_LSB) begin
                  if (dl_out_data_sft[31:16] == `TYPE_IP) begin
                     // Checksum recalc prep
                     nw_tos_diff_nxt = {9'h00, nw_out_data_1st[7:0]} +
                                       {9'hFF, ~dl_out_data_sft[7:0]};
                  end
                  // Not IP. No more actions needed
                  else begin
                     nw_tos_diff_nxt = 0;
                     nw_ttl_diff_nxt = 0;
                     nw_src_h_diff_nxt = 0;
                     nw_src_l_diff_nxt = 0;
                     nw_dst_h_diff_nxt = 0;
                     nw_dst_l_diff_nxt = 0;
                     nw_cs_inv_nxt = 0;
                  end
               end
            end
         end

         NW_HDR_2ND_PTN1: begin
            if (dl_out_wr_sft) begin
               // Checksum recalc prep
               nw_ttl_diff_nxt = {1'b0, nw_out_data_1st[15:8], 8'h00} +
                                 {1'b0, ~dl_out_data_sft[15:8], 8'hFF};
            end
         end

         NW_HDR_2ND_PTN2: begin
            if (dl_out_wr_sft) begin
               // Checksum recalc prep
               nw_ttl_diff_nxt = {1'b0, nw_out_data_1st[47:40], 8'h00} +
                                 {1'b0, ~dl_out_data_sft[47:40], 8'hFF};
               nw_src_h_diff_nxt = {1'b0, nw_out_data_1st[15:0]} +
                                   {1'b0, ~dl_out_data_sft[15:0]};
               nw_cs_inv_nxt = {1'b0, ~dl_out_data_sft[31:16]};
            end
         end

         NW_HDR_3RD_PTN1: begin
            if (dl_out_wr_sft) begin
               // Checksum recalc prep
               nw_src_h_diff_nxt = {1'b0, nw_out_data_1st[47:32]} +
                                   {1'b0, ~dl_out_data_sft[47:32]};
               nw_src_l_diff_nxt = {1'b0, nw_out_data_1st[31:16]} +
                                   {1'b0,~dl_out_data_sft[31:16]};
               nw_dst_h_diff_nxt = {1'b0, nw_out_data_1st[15:0]} +
                                   {1'b0, ~dl_out_data_sft[15:0]};
               nw_cs_inv_nxt = {1'b0, ~dl_out_data_sft[63:48]};
            end
         end

         NW_HDR_3RD_PTN2: begin
            if (dl_out_wr_sft) begin
               // Checksum recalc prep
               nw_src_l_diff_nxt = {1'b0, nw_out_data_1st[63:48]} +
                                   {1'b0,~dl_out_data_sft[63:48]};
               nw_dst_h_diff_nxt = {1'b0, nw_out_data_1st[47:32]} +
                                   {1'b0, ~dl_out_data_sft[47:32]};
               nw_dst_l_diff_nxt = {1'b0, nw_out_data_1st[31:16]} +
                                   {1'b0, ~dl_out_data_sft[31:16]};
               tp_src_diff_nxt = {1'b0, nw_out_data_1st[15:0]} +
                                 {1'b0, ~dl_out_data_sft[15:0]};
            end
         end

         NW_HDR_4TH_PTN1: begin
            if (dl_out_wr_sft) begin
               if (ip_hlen_2nd == 1) begin
                  if (is_udp_2nd || is_tcp_2nd) begin
                     // TP checksum recalc prep
                     tp_src_diff_nxt = {1'b0, nw_out_data_1st[47:32]} +
                                       {1'b0, ~dl_out_data_sft[47:32]};
                     tp_dst_diff_nxt = {1'b0, nw_out_data_1st[31:16]} +
                                       {1'b0, ~dl_out_data_sft[31:16]};
                  end
                  else begin
                     tp_src_diff_nxt = 0;
                     tp_dst_diff_nxt = 0;
                  end
               end
               else if (ip_hlen_2nd == 3) begin
                  if (is_udp_2nd || is_tcp_2nd) begin
                     // TP checksum recalc prep
                     tp_src_diff_nxt = {1'b0, nw_out_data_1st[15:0]} +
                                       {1'b0, ~dl_out_data_sft[15:0]};
                  end
                  else begin
                     tp_src_diff_nxt = 0;
                     tp_dst_diff_nxt = 0;
                  end
               end
               // Checksum recalc prep
               nw_dst_l_diff_nxt = {1'b0, nw_out_data_1st[63:48]} +
                                   {1'b0, ~dl_out_data_sft[63:48]};
            end
         end

         NW_OPT_PASS: begin
            if (dl_out_wr_sft) begin
               if (ip_hlen_2nd == 1) begin
                  if (is_udp_2nd || is_tcp_2nd) begin
                     // TP checksum recalc prep
                     tp_src_diff_nxt = {1'b0, nw_out_data_1st[47:32]} +
                                       {1'b0, ~dl_out_data_sft[47:32]};
                     tp_dst_diff_nxt = {1'b0, nw_out_data_1st[31:16]} +
                                       {1'b0, ~dl_out_data_sft[31:16]};
                  end
                  else begin
                     tp_src_diff_nxt = 0;
                     tp_dst_diff_nxt = 0;
                  end
               end
               else if (ip_hlen_2nd == 3) begin
                  if (is_udp_2nd || is_tcp_2nd) begin
                     // TP checksum recalc prep
                     tp_src_diff_nxt = {1'b0, nw_out_data_1st[15:0]} +
                                       {1'b0, ~dl_out_data_sft[15:0]};
                  end
                  else begin
                     tp_src_diff_nxt = 0;
                     tp_dst_diff_nxt = 0;
                  end
               end
            end
         end

         TP_HDR_2ND_PTN1: begin
            if (dl_out_wr_sft) begin
               // TP checksum recalc prep
               tp_dst_diff_nxt = {1'b0, nw_out_data_1st[63:48]} +
                                 {1'b0, ~dl_out_data_sft[63:48]};
               if (is_udp_2nd) begin
                  tp_cs_inv_nxt = {1'b0, ~dl_out_data_sft[31:16]};
               end
            end
         end

         TP_HDR_2ND_PTN2: begin
            if (dl_out_wr_sft) begin
               if (is_udp_2nd) begin
                  tp_cs_inv_nxt = {1'b0, ~dl_out_data_sft[63:48]};
               end
            end
         end

         TP_HDR_3RD_PTN1: begin
            if (dl_out_wr_sft) begin
               if (is_tcp_2nd) begin
                  tp_cs_inv_nxt = {1'b0, ~dl_out_data_sft[15:0]};
               end
            end
         end

         TP_HDR_3RD_PTN2: begin
            if (dl_out_wr_sft) begin
               if (is_tcp_2nd) begin
                  tp_cs_inv_nxt = {1'b0, ~dl_out_data_sft[47:32]};
               end
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_tos_diff_2nd <= 0;
         nw_ttl_diff_2nd <= 0;
         nw_src_h_diff_2nd <= 0;
         nw_src_l_diff_2nd <= 0;
         nw_dst_h_diff_2nd <= 0;
         nw_dst_l_diff_2nd <= 0;
         nw_cs_inv_2nd <= 0;
         tp_src_diff_2nd <= 0;
         tp_dst_diff_2nd <= 0;
         tp_cs_inv_2nd <= 0;
      end
      else begin
         nw_tos_diff_2nd <= nw_tos_diff_nxt;
         nw_ttl_diff_2nd <= nw_ttl_diff_nxt;
         nw_src_h_diff_2nd <= nw_src_h_diff_nxt;
         nw_src_l_diff_2nd <= nw_src_l_diff_nxt;
         nw_dst_h_diff_2nd <= nw_dst_h_diff_nxt;
         nw_dst_l_diff_2nd <= nw_dst_l_diff_nxt;
         nw_cs_inv_2nd <= nw_cs_inv_nxt;
         tp_src_diff_2nd <= tp_src_diff_nxt;
         tp_dst_diff_2nd <= tp_dst_diff_nxt;
         tp_cs_inv_2nd <= tp_cs_inv_nxt;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         dl_out_wr_sft <= 0;
         dl_proc_done_sft <= 0;
         dl_out_data_sft <= 0;
         nw_diff_state <= NW_HDR_1ST;
      end
      else begin
         dl_out_wr_sft <= dl_out_wr;
         dl_proc_done_sft <= dl_proc_done;
         dl_out_data_sft <= dl_out_data;
         nw_diff_state <= nw_state;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_out_data_1st <= 0;
         nw_out_strb_1st <= 0;
         nw_out_last_1st <= 0;
         nw_out_wr_1st <= 0;
         nw_dl_proc_done_1st <= 0;
         nw_proc_done_1st <= 0;
         is_ip_1st <= 0;
         is_udp_1st <= 0;
         is_tcp_1st <= 0;
         is_sctp_1st <= 0;
         ip_hlen_1st <= 0;
         nw_state <= NW_HDR_1ST;
      end
      else begin
         nw_out_data_1st <= nw_out_data_nxt;
         nw_out_strb_1st <= nw_out_strb_nxt;
         nw_out_last_1st <= nw_out_last_nxt;
         nw_out_wr_1st <= nw_out_wr_nxt;
         nw_dl_proc_done_1st <= nw_dl_proc_done_nxt;
         nw_proc_done_1st <= nw_proc_done_nxt;
         is_ip_1st <= is_ip_nxt;
         is_udp_1st <= is_udp_nxt;
         is_tcp_1st <= is_tcp_nxt;
         is_sctp_1st <= is_sctp_nxt;
         ip_hlen_1st <= ip_hlen_nxt;
         nw_state <= nw_state_nxt;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_out_data_2nd <= 0;
         nw_out_strb_2nd <= 0;
         nw_out_last_2nd <= 0;
         nw_out_wr_2nd <= 0;
         nw_dl_proc_done_2nd <= 0;
         nw_proc_done_2nd <= 0;
         is_ip_2nd <= 0;
         is_udp_2nd <= 0;
         is_tcp_2nd <= 0;
         is_sctp_2nd <= 0;
         ip_hlen_2nd <= 0;
      end
      else begin
         nw_out_data_2nd <= nw_out_data_1st;
         nw_out_strb_2nd <= nw_out_strb_1st;
         nw_out_last_2nd <= nw_out_last_1st;
         nw_out_wr_2nd <= nw_out_wr_1st;
         nw_dl_proc_done_2nd <= nw_dl_proc_done_1st;
         nw_proc_done_2nd <= nw_proc_done_1st;
         is_ip_2nd <= is_ip_1st;
         is_udp_2nd <= is_udp_1st;
         is_tcp_2nd <= is_tcp_1st;
         is_sctp_2nd <= is_sctp_1st;
         ip_hlen_2nd <= ip_hlen_1st;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_out_data <= 0;
         nw_out_strb <= 0;
         nw_out_last <= 0;
         nw_out_wr <= 0;
         nw_dl_proc_done <= 0;
         nw_proc_done <= 0;
         is_ip <= 0;
         is_udp <= 0;
         is_tcp <= 0;
         is_sctp <= 0;
         ip_hlen <= 0;
      end
      else begin
         nw_out_data <= nw_out_data_2nd;
         nw_out_strb <= nw_out_strb_2nd;
         nw_out_last <= nw_out_last_2nd;
         nw_out_wr <= nw_out_wr_2nd;
         nw_dl_proc_done <= nw_dl_proc_done_2nd;
         nw_proc_done <= nw_proc_done_2nd;
         is_ip <= is_ip_2nd;
         is_udp <= is_udp_2nd;
         is_tcp <= is_tcp_2nd;
         is_sctp <= is_sctp_2nd;
         ip_hlen <= ip_hlen_2nd;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_tos_diff <= 0;
         nw_ttl_diff <= 0;
         nw_src_h_diff <= 0;
         nw_src_l_diff <= 0;
         nw_dst_h_diff <= 0;
         nw_dst_l_diff <= 0;
         nw_cs_inv <= 0;
         tp_src_diff <= 0;
         tp_dst_diff <= 0;
         tp_cs_inv <= 0;
      end
      else begin
         if (nw_tos_diff_2nd[16] == 1) begin
            nw_tos_diff <= nw_tos_diff_2nd[15:0] + 1;
         end
         else begin
            nw_tos_diff <= nw_tos_diff_2nd;
         end
         if (nw_ttl_diff_2nd[16] == 1) begin
            nw_ttl_diff <= nw_ttl_diff_2nd[15:0] + 1;
         end
         else begin
            nw_ttl_diff <= nw_ttl_diff_2nd;
         end
         if (nw_src_h_diff_2nd[16] == 1) begin
            nw_src_h_diff <= nw_src_h_diff_2nd[15:0] + 1;
         end
         else begin
            nw_src_h_diff <= nw_src_h_diff_2nd;
         end
         if (nw_src_l_diff_2nd[16] == 1) begin
            nw_src_l_diff <= nw_src_l_diff_2nd[15:0] + 1;
         end
         else begin
            nw_src_l_diff <= nw_src_l_diff_2nd;
         end
         if (nw_dst_h_diff_2nd[16] == 1) begin
            nw_dst_h_diff <= nw_dst_h_diff_2nd[15:0] + 1;
         end
         else begin
            nw_dst_h_diff <= nw_dst_h_diff_2nd;
         end
         if (nw_dst_l_diff_2nd[16] == 1) begin
            nw_dst_l_diff <= nw_dst_l_diff_2nd[15:0] + 1;
         end
         else begin
            nw_dst_l_diff <= nw_dst_l_diff_2nd;
         end
         nw_cs_inv <= nw_cs_inv_2nd;

         if (tp_src_diff_2nd[16] == 1) begin
            tp_src_diff <= tp_src_diff_2nd[15:0] + 1;
         end
         else begin
            tp_src_diff <= tp_src_diff_2nd;
         end
         if (tp_dst_diff_2nd[16] == 1) begin
            tp_dst_diff <= tp_dst_diff_2nd[15:0] + 1;
         end
         else begin
            tp_dst_diff <= tp_dst_diff_2nd;
         end
         tp_cs_inv <= tp_cs_inv_2nd;
      end
   end

   // IP checksum calculation
   always @(*) begin
      nw_diff1_nxt = nw_diff1;
      nw_diff2_nxt = nw_diff2;
      nw_pseudo_diff_nxt = nw_pseudo_diff;
      nw_cs_done_nxt = 0;

      case (nwcs_state)
         NWCS_3RD: begin
            nw_diff1_nxt = nw_tos_diff + nw_ttl_diff;
            nw_diff1_nxt = {1'b0, nw_diff1_nxt[15:0]} +
                           {16'h0000, nw_diff1_nxt[16]};
         end

         NWCS_4TH, NWCS_4TH_A: begin
            nw_diff2_nxt = nw_src_h_diff + nw_src_l_diff;
            nw_diff2_nxt = {1'b0, nw_diff2_nxt[15:0]} +
                           {16'h0000, nw_diff2_nxt[16]};
            nw_diff1_nxt = nw_diff1 + nw_cs_inv;
            nw_diff1_nxt = {1'b0, nw_diff1_nxt[15:0]} +
                           {16'h0000, nw_diff1_nxt[16]};
         end

         NWCS_5TH, NWCS_5TH_A, NWCS_5TH_B: begin
            nw_diff1_nxt = nw_diff1 + nw_diff2;
            nw_diff1_nxt = {1'b0, nw_diff1_nxt[15:0]} +
                           {16'h0000, nw_diff1_nxt[16]};
            nw_diff2_nxt = nw_dst_h_diff + nw_dst_l_diff;
            nw_diff2_nxt = {1'b0, nw_diff2_nxt[15:0]} +
                           {16'h0000, nw_diff2_nxt[16]};
            nw_pseudo_diff_nxt = nw_diff2;
         end

         NWCS_6TH, NWCS_6TH_A, NWCS_6TH_B, NWCS_6TH_C: begin
            nw_diff1_nxt = nw_diff1 + nw_diff2;
            nw_diff1_nxt = {1'b0, nw_diff1_nxt[15:0]} +
                           {16'h0000, nw_diff1_nxt[16]};
            nw_pseudo_diff_nxt = nw_pseudo_diff + nw_diff2;
            nw_pseudo_diff_nxt = {1'b0, nw_pseudo_diff_nxt[15:0]} +
                           {16'h0000, nw_pseudo_diff_nxt[16]};
            nw_cs_done_nxt = 1;
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_diff1 <= 0;
         nw_diff2 <= 0;
         nw_pseudo_diff <= 0;
         nw_cs_done <= 0;
      end
      else begin
         nw_diff1 <= nw_diff1_nxt;
         nw_diff2 <= nw_diff2_nxt;
         nw_pseudo_diff <= nw_pseudo_diff_nxt;
         nw_cs_done <= nw_cs_done_nxt;
      end
   end

   always @(*) begin
      nw_proc_flag_nxt = nw_proc_flag;
      nw_nxt_proc_flag_nxt = nw_nxt_proc_flag;
      nwcs_state_nxt = nwcs_state;

      case (nwcs_state)
         NWCS_1ST: begin
            if (nw_out_wr) begin
               if (((nw_dl_proc_done == FLAG_START_MSB) && is_ip)||
                  ((nw_dl_proc_done == FLAG_START_LSB) && is_ip)) begin
                  nw_proc_flag_nxt = nw_dl_proc_done;
                  nwcs_state_nxt = NWCS_2ND;
               end
               else begin
                  nw_proc_flag_nxt = 0;
               end
            end
         end

         NWCS_2ND: begin
            if (nw_out_wr) begin
               nwcs_state_nxt = NWCS_3RD;
            end
         end

         NWCS_3RD: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  nwcs_state_nxt = NWCS_4TH_A;
               end
               else begin
                  nwcs_state_nxt = NWCS_4TH;
               end
            end
         end

         NWCS_4TH: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  nwcs_state_nxt = NWCS_5TH_A;
               end
               else begin
                  nwcs_state_nxt = NWCS_5TH;
               end
            end
         end

         NWCS_4TH_A: begin
            if (nw_out_wr) begin
               nwcs_state_nxt = NWCS_5TH_B;
            end
            else begin
               nwcs_state_nxt = NWCS_5TH_A;
            end
         end

         NWCS_5TH: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  nwcs_state_nxt = NWCS_6TH_A;
               end
               else begin
                  nwcs_state_nxt = NWCS_6TH;
               end
            end
         end

         NWCS_5TH_A: begin
            if (nw_out_wr) begin
               nwcs_state_nxt = NWCS_6TH_B;
            end
            else begin
               nwcs_state_nxt = NWCS_6TH_A;
            end
         end

         NWCS_5TH_B: begin
            if (nw_out_wr) begin
               if ((nw_dl_proc_done == FLAG_START_MSB) ||
                  (nw_dl_proc_done == FLAG_START_LSB)) begin
                  nw_nxt_proc_flag_nxt = nw_dl_proc_done;
                  nwcs_state_nxt = NWCS_6TH_C;
               end
               else begin
                  nwcs_state_nxt = NWCS_6TH_B;
               end
            end
         end

         NWCS_6TH: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  nwcs_state_nxt = NWCS_7TH_A;
               end
               else begin
                  nwcs_state_nxt = NWCS_7TH;
               end
            end
         end

         NWCS_6TH_A: begin
            if (nw_out_wr) begin
               nwcs_state_nxt = NWCS_7TH_B;
            end
            else begin
               nwcs_state_nxt = NWCS_7TH_A;
            end
         end

         NWCS_6TH_B: begin
            if (nw_out_wr) begin
               if ((nw_dl_proc_done == FLAG_START_MSB) ||
                  (nw_dl_proc_done == FLAG_START_LSB)) begin
                  nw_nxt_proc_flag_nxt = nw_dl_proc_done;
                  nwcs_state_nxt = NWCS_7TH_C;
               end
               else begin
                  nwcs_state_nxt = NWCS_7TH_B;
               end
            end
         end

         NWCS_6TH_C: begin
            if (nw_out_wr) begin
               nwcs_state_nxt = NWCS_7TH_D;
            end
         end

         NWCS_7TH: begin
            if (nw_out_wr) begin
               nwcs_state_nxt = NWCS_1ST;
            end
         end

         NWCS_7TH_A: begin
            nwcs_state_nxt = NWCS_1ST;
         end

         NWCS_7TH_B: begin
            if (nw_out_wr) begin
               if ((nw_dl_proc_done == FLAG_START_MSB) ||
                  (nw_dl_proc_done == FLAG_START_LSB)) begin
                  nw_proc_flag_nxt = nw_dl_proc_done;
                  nw_nxt_proc_flag_nxt = 0;
                  nwcs_state_nxt = NWCS_2ND;
               end
               else begin
                  nw_proc_flag_nxt = 0;
                  nw_nxt_proc_flag_nxt = 0;
                  nwcs_state_nxt = NWCS_1ST;
               end
            end
         end

         NWCS_7TH_C: begin
            if (nw_out_wr) begin
               nw_proc_flag_nxt = nw_dl_proc_done;
               nw_nxt_proc_flag_nxt = 0;
               nwcs_state_nxt = NWCS_3RD;
            end
         end

         NWCS_7TH_D: begin
            if (nw_out_wr) begin
               nw_proc_flag_nxt = nw_dl_proc_done;
               nw_nxt_proc_flag_nxt = 0;
               if (nw_out_last) begin
                  nwcs_state_nxt = NWCS_4TH_A;
               end
               else begin
                  nwcs_state_nxt = NWCS_4TH;
               end
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_proc_flag <= 0;
         nw_nxt_proc_flag <= 0;
         nwcs_state <= NWCS_1ST;
      end
      else begin
         nw_proc_flag <= nw_proc_flag_nxt;
         nw_nxt_proc_flag <= nw_nxt_proc_flag_nxt;
         nwcs_state <= nwcs_state_nxt;
      end
   end

   // UDP/TCP checksum calculation
   always @(*) begin
      tp_diff_nxt = tp_diff;
      tp_cs_done_nxt = 0;

      case (tpcs_state)
         TPCS_3RD, TPCS_3RD_A: begin
            tp_diff_nxt = tp_src_diff + tp_dst_diff;
            tp_diff_nxt = {1'b0, tp_diff_nxt[15:0]} +
                           {16'h0000, tp_diff_nxt[16]};
         end

         TPCS_4TH, TPCS_4TH_A, TPCS_4TH_B: begin
            tp_diff_nxt = tp_diff + tp_cs_inv;
            tp_diff_nxt = {1'b0, tp_diff_nxt[15:0]} +
                           {16'h0000, tp_diff_nxt[16]};
         end

         TPCS_5TH, TPCS_5TH_A, TPCS_5TH_B: begin
            tp_diff_nxt = tp_diff + nw_pseudo_diff;
            tp_diff_nxt = {1'b0, tp_diff_nxt[15:0]} +
                           {16'h0000, tp_diff_nxt[16]};
            tp_cs_done_nxt = 1;
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         tp_diff <= 0;
         tp_cs_done <= 0;
      end
      else begin
         tp_diff <= tp_diff_nxt;
         tp_cs_done <= tp_cs_done_nxt;
      end
   end

   always @(*) begin
      tp_proto_nxt = tp_proto;
      tp_proc_flag_nxt = tp_proc_flag;
      tpcs_state_nxt = tpcs_state;
      case (tpcs_state)
         TPCS_1ST: begin
            //TODO: if TYPE not IP?
            if (nw_out_wr) begin
               if (((nw_proc_done == FLAG_START_MSB) ||
                  (nw_proc_done == FLAG_START_LSB)) &&
                  (is_tcp || is_udp)) begin
                  tp_proto_nxt = (is_tcp ? 0 : 1);
                  tp_proc_flag_nxt = nw_proc_done;
                  tpcs_state_nxt = TPCS_2ND;
               end
               else begin
                  tp_proc_flag_nxt = 0;
               end
            end
         end

         TPCS_2ND: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  tpcs_state_nxt = TPCS_3RD_A;
               end
               else begin
                  tpcs_state_nxt = TPCS_3RD;
               end
            end
         end

         TPCS_3RD: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  tpcs_state_nxt = TPCS_4TH_A;
               end
               else begin
                  tpcs_state_nxt = TPCS_4TH;
               end
            end
         end

         TPCS_3RD_A: begin
            if (nw_out_wr) begin
               tpcs_state_nxt = TPCS_4TH_B;
            end
            else begin
               tpcs_state_nxt = TPCS_4TH_A;
            end
         end

         TPCS_4TH: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  tpcs_state_nxt = TPCS_5TH_A;
               end
               else begin
                  tpcs_state_nxt = TPCS_5TH;
               end
            end
         end

         TPCS_4TH_A: begin
            if (nw_out_wr) begin
               tpcs_state_nxt = TPCS_5TH_B;
            end
            else begin
               tpcs_state_nxt = TPCS_5TH_A;
            end
         end

         TPCS_4TH_B: begin
            if (nw_out_wr) begin
               tpcs_state_nxt = TPCS_5TH_B;
            end
         end

         TPCS_5TH: begin
            if (nw_out_wr) begin
               if (nw_out_last) begin
                  tpcs_state_nxt = TPCS_6TH_A;
               end
               else begin
                  tpcs_state_nxt = TPCS_6TH;
               end
            end
         end

         TPCS_5TH_A: begin
            if (nw_out_wr) begin
               tpcs_state_nxt = TPCS_6TH;
            end
            else begin
               tpcs_state_nxt = TPCS_6TH_A;
            end
         end

         TPCS_5TH_B: begin
            if (nw_out_wr) begin
               tpcs_state_nxt = TPCS_6TH;
            end
         end

         TPCS_6TH: begin
            if (nw_out_wr) begin
               tpcs_state_nxt = TPCS_1ST;
            end
         end

         TPCS_6TH_A: begin
            tpcs_state_nxt = TPCS_1ST;
         end

      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         tp_proto <= 0;
         tp_proc_flag <= 0;
         tpcs_state <= TPCS_1ST;
      end
      else begin
         tp_proto <= tp_proto_nxt;
         tp_proc_flag <= tp_proc_flag_nxt;
         tpcs_state <= tpcs_state_nxt;
      end
   end

   // Update the checksum
   always @(*) begin
      nw_out_data_1_nxt = nw_out_data_1;
      nw_out_strb_1_nxt = nw_out_strb_1;
      nw_out_last_1_nxt = nw_out_last_1;
      nw_out_wr_1_nxt = nw_out_wr_1;
      nw_out_data_2_nxt = nw_out_data_2;
      nw_out_strb_2_nxt = nw_out_strb_2;
      nw_out_last_2_nxt = nw_out_last_2;
      nw_out_wr_2_nxt = nw_out_wr_2;
      nw_out_data_3_nxt = nw_out_data_3;
      nw_out_strb_3_nxt = nw_out_strb_3;
      nw_out_last_3_nxt = nw_out_last_3;
      nw_out_wr_3_nxt = nw_out_wr_3;
      nw_out_data_4_nxt = nw_out_data_4;
      nw_out_strb_4_nxt = nw_out_strb_4;
      nw_out_last_4_nxt = nw_out_last_4;
      nw_out_wr_4_nxt = nw_out_wr_4;
      nw_out_data_5_nxt = nw_out_data_5;
      nw_out_strb_5_nxt = nw_out_strb_5;
      nw_out_last_5_nxt = nw_out_last_5;
      nw_out_wr_5_nxt = nw_out_wr_5;
      tp_out_data_nxt = tp_out_data;
      tp_out_strb_nxt = tp_out_strb;
      tp_out_last_nxt = tp_out_last;
      tp_out_wr_nxt = 0;
      shift_cnt_nxt = shift_cnt;
      shift_state_nxt = shift_state;

      case (shift_state)
         PKT_EXIST: begin
            if (nw_out_wr) begin
               nw_out_data_1_nxt = nw_out_data;
               nw_out_strb_1_nxt = nw_out_strb;
               nw_out_last_1_nxt = nw_out_last;
               nw_out_wr_1_nxt = nw_out_wr;

               nw_out_data_2_nxt = nw_out_data_1;
               nw_out_strb_2_nxt = nw_out_strb_1;
               nw_out_last_2_nxt = nw_out_last_1;
               nw_out_wr_2_nxt = nw_out_wr_1;

               nw_out_data_3_nxt = nw_out_data_2;
               nw_out_strb_3_nxt = nw_out_strb_2;
               nw_out_last_3_nxt = nw_out_last_2;
               nw_out_wr_3_nxt = nw_out_wr_2;

               nw_out_data_4_nxt = nw_out_data_3;
               if (tp_cs_done && (tp_proto == 0)) begin
                  if (tp_proc_flag == FLAG_START_MSB) begin
                     nw_out_data_4_nxt[47:32] = ~tp_diff;
                  end
                  else begin
                     nw_out_data_4_nxt[15:0] = ~tp_diff;
                  end
               end
               nw_out_strb_4_nxt = nw_out_strb_3;
               nw_out_last_4_nxt = nw_out_last_3;
               nw_out_wr_4_nxt = nw_out_wr_3;

               nw_out_data_5_nxt = nw_out_data_4;
               if (nw_cs_done && (nw_proc_flag == FLAG_START_LSB)) begin
                  nw_out_data_5_nxt[63:48] = ~nw_diff1;
               end
               else if (tp_cs_done && (tp_proto == 1)) begin
                  if (tp_proc_flag == FLAG_START_MSB) begin
                     nw_out_data_5_nxt[63:48] = ~tp_diff;
                  end
                  else begin
                     nw_out_data_5_nxt[31:16] = ~tp_diff;
                  end
               end
               nw_out_strb_5_nxt = nw_out_strb_4;
               nw_out_last_5_nxt = nw_out_last_4;
               nw_out_wr_5_nxt = nw_out_wr_4;

               tp_out_data_nxt = nw_out_data_5;
               if (nw_cs_done && (nw_proc_flag == FLAG_START_MSB)) begin
                  tp_out_data_nxt[31:16] = ~nw_diff1;
               end
               tp_out_strb_nxt = nw_out_strb_5;
               tp_out_last_nxt = nw_out_last_5;
               tp_out_wr_nxt = nw_out_wr_5;

               if (nw_out_last) begin
                  shift_cnt_nxt = 5;
                  shift_state_nxt = PKT_PUSH;
               end
            end
         end
         PKT_PUSH: begin
            nw_out_data_1_nxt = nw_out_data;
            nw_out_strb_1_nxt = nw_out_strb;
            nw_out_last_1_nxt = nw_out_last;
            nw_out_wr_1_nxt = nw_out_wr;

            nw_out_data_2_nxt = nw_out_data_1;
            nw_out_strb_2_nxt = nw_out_strb_1;
            nw_out_last_2_nxt = nw_out_last_1;
            nw_out_wr_2_nxt = nw_out_wr_1;

            nw_out_data_3_nxt = nw_out_data_2;
            nw_out_strb_3_nxt = nw_out_strb_2;
            nw_out_last_3_nxt = nw_out_last_2;
            nw_out_wr_3_nxt = nw_out_wr_2;

            nw_out_data_4_nxt = nw_out_data_3;
            if (tp_cs_done && (tp_proto == 0)) begin
               if (tp_proc_flag == FLAG_START_MSB) begin
                  nw_out_data_4_nxt[47:32] = ~tp_diff;
               end
               else begin
                  nw_out_data_4_nxt[15:0] = ~tp_diff;
               end
            end
            nw_out_strb_4_nxt = nw_out_strb_3;
            nw_out_last_4_nxt = nw_out_last_3;
            nw_out_wr_4_nxt = nw_out_wr_3;

            nw_out_data_5_nxt = nw_out_data_4;
            if (nw_cs_done && (nw_proc_flag == FLAG_START_LSB)) begin
               nw_out_data_5_nxt[63:48] = ~nw_diff1;
            end
            else if (tp_cs_done && (tp_proto == 1)) begin
               if (tp_proc_flag == FLAG_START_MSB) begin
                  nw_out_data_5_nxt[63:48] = ~tp_diff;
               end
               else begin
                  nw_out_data_5_nxt[31:16] = ~tp_diff;
               end
            end
            nw_out_strb_5_nxt = nw_out_strb_4;
            nw_out_last_5_nxt = nw_out_last_4;
            nw_out_wr_5_nxt = nw_out_wr_4;

            tp_out_data_nxt = nw_out_data_5;
            if (nw_cs_done && (nw_proc_flag == FLAG_START_MSB)) begin
               tp_out_data_nxt[31:16] = ~nw_diff1;
            end
            tp_out_strb_nxt = nw_out_strb_5;
            tp_out_last_nxt = nw_out_last_5;
            tp_out_wr_nxt = nw_out_wr_5;

            shift_cnt_nxt = shift_cnt -1;
            if (nw_out_wr || (shift_cnt == 0)) begin
               shift_state_nxt = PKT_EXIST;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         nw_out_data_1 <= 0;
         nw_out_strb_1 <= 0;
         nw_out_last_1 <= 0;
         nw_out_wr_1 <= 0;
         nw_out_data_2 <= 0;
         nw_out_strb_2 <= 0;
         nw_out_last_2 <= 0;
         nw_out_wr_2 <= 0;
         nw_out_data_3 <= 0;
         nw_out_strb_3 <= 0;
         nw_out_last_3 <= 0;
         nw_out_wr_3 <= 0;
         nw_out_data_4 <= 0;
         nw_out_strb_4 <= 0;
         nw_out_last_4 <= 0;
         nw_out_wr_4 <= 0;
         nw_out_data_5 <= 0;
         nw_out_strb_5 <= 0;
         nw_out_last_5 <= 0;
         nw_out_wr_5 <= 0;
         tp_out_data <= 0;
         tp_out_strb <= 0;
         tp_out_last <= 0;
         tp_out_wr <= 0;
         shift_cnt <= 0;
         shift_state <= PKT_EXIST;
      end
      else begin
         nw_out_data_1 <= nw_out_data_1_nxt;
         nw_out_strb_1 <= nw_out_strb_1_nxt;
         nw_out_last_1 <= nw_out_last_1_nxt;
         nw_out_wr_1 <= nw_out_wr_1_nxt;
         nw_out_data_2 <= nw_out_data_2_nxt;
         nw_out_strb_2 <= nw_out_strb_2_nxt;
         nw_out_last_2 <= nw_out_last_2_nxt;
         nw_out_wr_2 <= nw_out_wr_2_nxt;
         nw_out_data_3 <= nw_out_data_3_nxt;
         nw_out_strb_3 <= nw_out_strb_3_nxt;
         nw_out_last_3 <= nw_out_last_3_nxt;
         nw_out_wr_3 <= nw_out_wr_3_nxt;
         nw_out_data_4 <= nw_out_data_4_nxt;
         nw_out_strb_4 <= nw_out_strb_4_nxt;
         nw_out_last_4 <= nw_out_last_4_nxt;
         nw_out_wr_4 <= nw_out_wr_4_nxt;
         nw_out_data_5 <= nw_out_data_5_nxt;
         nw_out_strb_5 <= nw_out_strb_5_nxt;
         nw_out_last_5 <= nw_out_last_5_nxt;
         nw_out_wr_5 <= nw_out_wr_5_nxt;
         tp_out_data <= tp_out_data_nxt;
         tp_out_strb <= tp_out_strb_nxt;
         tp_out_last <= tp_out_last_nxt;
         tp_out_wr <= tp_out_wr_nxt;
         shift_cnt <= shift_cnt_nxt;
         shift_state <= shift_state_nxt;
      end
   end

   // ---- Prepare to send pkt out

   // Endian conversion again
   // Assumption: Data is always 64bit width
   generate
      genvar j;
      for (j=0; j<8; j=j+1) begin:gen_little_endian_data
         assign le_tp_out_strb[7-j] = tp_out_strb[j];
         assign le_tp_out_data[((56-j*8)+7):(56-j*8)]  =
            tp_out_data[(j*8+7):(j*8)];
      end
   endgenerate

   // output buffer
   fallthrough_small_fifo
     #(.WIDTH(FIFO_DATA_WIDTH), .MAX_DEPTH_BITS(4))
     output_fifo
       (.din           ({1'b1, // tx_valid, always be 1
                         tp_out_last,
                         le_tp_out_strb,
                         le_tp_out_data}),  // Data in
        .wr_en         (tp_out_wr),   // Write enable
        .rd_en         (m_tdata_rd_en),
        .dout          ({m_axis_tvalid_dummy, // Should always be 1
                         m_axis_tlast_int,
                         m_axis_tstrb,
                         m_axis_tdata}),
        .full          (pkt_buf_drop),
        .prog_full     (),
        .nearly_full   (),
        .empty         (pkt_buf_empty),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   // Data available means data is 'valid'
   assign m_axis_tvalid = ~pkt_buf_empty;

   // Output buffer for TUSER
   always @(*) begin
      mi_tuser_valid_nxt = mi_tuser_valid;
      mi_tuser_state_nxt = mi_tuser_state;
      case (mi_tuser_state)
         TU_WAIT_TVALID: begin
            if (tp_out_wr) begin
               mi_tuser_valid_nxt = 0;
               mi_tuser_state_nxt = TU_WAIT_TLAST;
            end
         end
         TU_WAIT_TLAST: begin
            if (tp_out_wr && tp_out_last) begin
               mi_tuser_valid_nxt = 1;
               mi_tuser_state_nxt = TU_WAIT_TVALID;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         mi_tuser_valid <= 1;
         mi_tuser_state <= TU_WAIT_TVALID;
      end
      else begin
         mi_tuser_valid <= mi_tuser_valid_nxt;
         mi_tuser_state <= mi_tuser_state_nxt;
      end
   end

   assign m_tuser_wr_en = tp_out_wr && mi_tuser_valid;

   fallthrough_small_fifo
     #(.WIDTH(C_AXIS_TUSER_WIDTH), .MAX_DEPTH_BITS(4))
     output_metadata_fifo
       (.din           (tx_user_1),
        .wr_en         (m_tuser_wr_en),
        .rd_en         (m_tuser_rd_en),
        .dout          (m_axis_tuser),
        .full          (),
        .prog_full     (),
        .nearly_full   (),
        .empty         (),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   // Output fifo handling
   always @(*) begin
      num_pkts_processed_nxt = num_pkts_processed;
      m_tdata_rd_en = 0;
      m_tuser_rd_en = 0;
      m_axis_tlast = 0;
      out_dt_rd_state_nxt = out_dt_rd_state;
      case (out_dt_rd_state)
         DT_RD_1ST: begin
            if (~pkt_buf_empty && m_axis_tready) begin
               m_tdata_rd_en = 1;
               m_tuser_rd_en = 1;
               out_dt_rd_state_nxt = DT_RD_REST;
            end
         end
         DT_RD_REST: begin
            if (~pkt_buf_empty && m_axis_tready) begin
               m_tdata_rd_en = 1;
               if (m_axis_tlast_int) begin
                  num_pkts_processed_nxt = num_pkts_processed+1;
                  m_axis_tlast = 1; 
                  out_dt_rd_state_nxt = DT_RD_1ST;
               end
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         out_dt_rd_state <= DT_RD_1ST;
         num_pkts_processed <= 0;
      end
      else begin
         out_dt_rd_state <= out_dt_rd_state_nxt;
         num_pkts_processed <= num_pkts_processed_nxt;
      end
   end
endmodule
