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
 *        ** Function is limitted in this version of the module.
 *           It supports output action only **
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

   // Data read state machine
   localparam NUM_DT_RD_STATES = 2;
   localparam DT_RD_1ST = 1,
              DT_RD_REST = 2;

   // DL state machine
   localparam NUM_DL_STATES = 2;
   localparam DL_HDR_1ST = 1,
              DL_THRU = 2;

   localparam NUM_TU_STATES = 2;
   localparam TU_WAIT_TVALID = 1,
              TU_WAIT_TLAST = 2;

   //------------------------ Wires/Regs -----------------------------

   reg [OPENFLOW_ACTION_SIZE -1: 0] lu_action_d;
   reg lu_done_d;
   reg [OPENFLOW_ACTION_SIZE-1:0] result_reg;

   // Endian Conversion
   wire [C_AXIS_DATA_WIDTH-1:0] be_tx_data_infifo;
   reg [C_AXIS_DATA_WIDTH-1:0] be_tx_data, be_tx_data_1st;
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] be_tx_strb_infifo;
   reg [(C_AXIS_DATA_WIDTH/8)-1:0] be_tx_strb, be_tx_strb_1st;

   // Action fields
   // Only forward_bitmask is used in this version of module
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
   wire [15:0] set_vlan_type;
   wire [7:0] set_nw_ttl;

   // Input buffer and peripheral
   reg fifo_rd_en;
   wire fifo_nearly_full;
   wire fifo_empty;

   reg tready_int;
   reg lu_done_int;

   wire tx_valid_infifo;
   reg tx_valid, tx_valid_nxt;
   reg tx_valid_1st;
   wire tx_last_infifo;
   reg tx_last, tx_last_nxt;
   reg tx_last_1st;
   wire [C_AXIS_DATA_WIDTH-1:0] tx_data;
   wire [C_AXIS_DATA_WIDTH/8-1:0] tx_strb;

   // DATA read state machine
   reg [NUM_DT_RD_STATES-1:0] dt_rd_state, dt_rd_state_nxt;

   // DL state machine
   reg [NUM_DL_STATES-1:0]  dl_state, dl_state_nxt;
   reg dl_out_wr, dl_out_wr_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] dl_out_data, dl_out_data_nxt;
   reg [C_AXIS_DATA_WIDTH/8-1:0] dl_out_strb, dl_out_strb_nxt;
   reg dl_out_last, dl_out_last_nxt;
   reg dl_proc_start, dl_proc_start_nxt;
   reg [1:0] dl_proc_done, dl_proc_done_nxt;

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
   wire m_fifo_empty;
   wire m_tuser_wr_en;
   reg m_tuser_rd_en;
   reg [NUM_TU_STATES-1:0] mi_tuser_state, mi_tuser_state_nxt;

   // Outgoing DATA read state machine
   reg [NUM_DT_RD_STATES-1:0] out_dt_rd_state, out_dt_rd_state_nxt;

   // Debug register
   reg [31:0] num_pkts_processed_nxt;

   //--------------------------- Logic -------------------------------

   //---Pkt/Tuser input_buf
   // May take up to 11clk max from receiving data to start reading it
   // So at least 11bit depth is needed

   // Generate TUSER latching signal
   // TUSER is valid only at the first cycle of pkt reception
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

   // Input FIFO for TUSER
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

   // Input FIFO for pkt
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
         assign be_tx_data_infifo[((56-i*8)+7):(56-i*8)] = tx_data[(i*8+7):(i*8)];
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
   // Only forward(output) action is valid in this version of the module
   // Other actions are assigned but not used
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
   // 1.1. Temporarily set to the fixed value
   assign set_vlan_type = 16'h8100;
   assign set_nw_ttl = 8'h0;

   // Data reading
   always @(*) begin
      fifo_rd_en = 0;
      tx_valid_nxt = 0;
      tx_last_nxt = 0;
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
                  dt_rd_state_nxt = DT_RD_1ST;
               end
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         tx_valid_1st <= 0;
         tx_last_1st <= 0;
         dt_rd_state <= DT_RD_1ST;
      end
      else begin
         tx_valid_1st <= tx_valid_nxt;
         tx_last_1st <= tx_last_nxt;
         dt_rd_state <= dt_rd_state_nxt;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         be_tx_data_1st <= 0;
         be_tx_strb_1st <= 0;
      end
      else begin
         be_tx_data_1st <= be_tx_data_infifo;
         be_tx_strb_1st <= be_tx_strb_infifo;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         be_tx_data <= 0;
         be_tx_strb <= 0;
         tx_valid <= 0;
         tx_last <= 0;
      end
      else begin
         be_tx_data <= be_tx_data_1st;
         be_tx_strb <= be_tx_strb_1st;
         tx_valid <= tx_valid_1st;
         tx_last <= tx_last_1st;
      end
   end

   //--- DL header handlilng
   // It processes each header with reading data from input FIFO
   // Overwrite new values if requested
   // Only forward(output) action is supported in this version
   // that is done by TUSER update
   always @(*) begin
      tx_user_rd_en = 0;
      dl_out_wr_nxt = 0;
      tx_user_1_nxt = tx_user_1;
      dl_out_data_nxt = be_tx_data;
      dl_out_strb_nxt = be_tx_strb;
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
            tx_user_1_nxt[TUSER_DPT_POS-1:0] =
               tx_user[TUSER_DPT_POS-1:0];
            if (tx_valid) begin
               tx_user_rd_en = 1;
               dl_out_wr_nxt = 1;
               dl_proc_start_nxt = 1;
               dl_state_nxt = DL_THRU;
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
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         tx_user_1 <= 0;
         dl_out_wr <= 0;
         dl_out_data <= 0;
         dl_out_strb <= 0;
         dl_out_last <= 0;
         dl_proc_start <= 0;
         dl_proc_done <= 0;
         dl_state <= DL_HDR_1ST;
      end
      else begin
         tx_user_1 <= tx_user_1_nxt;
         dl_out_wr <= dl_out_wr_nxt;
         dl_out_data <= dl_out_data_nxt;
         dl_out_strb <= dl_out_strb_nxt;
         dl_out_last <= dl_out_last_nxt;
         dl_proc_start <= dl_proc_start_nxt;
         dl_proc_done <= dl_proc_done_nxt;
         dl_state <= dl_state_nxt;
      end
   end

   //---- Prepare to send pkt out

   // Endian conversion again
   // Assumption: Data is always 64bit width
   generate
      genvar j;
      for (j=0; j<8; j=j+1) begin:gen_little_endian_data
         assign le_tp_out_strb[7-j] = dl_out_strb[j];
         assign le_tp_out_data[((56-j*8)+7):(56-j*8)]  =
            dl_out_data[(j*8+7):(j*8)];
      end
   endgenerate

   // Output buffer for pkt
   fallthrough_small_fifo
     #(.WIDTH(FIFO_DATA_WIDTH), .MAX_DEPTH_BITS(4))
     output_fifo
       (.din           ({1'b1, // tx_valid, always be 1
                         dl_out_last,
                         le_tp_out_strb,
                         le_tp_out_data}),  // Data in
        .wr_en         (dl_out_wr),   // Write enable
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
            if (dl_out_wr) begin
               mi_tuser_valid_nxt = 0;
               mi_tuser_state_nxt = TU_WAIT_TLAST;
            end
         end
         TU_WAIT_TLAST: begin
            if (dl_out_wr && dl_out_last) begin
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

   assign m_tuser_wr_en = dl_out_wr && mi_tuser_valid;

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
        .empty         (m_fifo_empty),
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
