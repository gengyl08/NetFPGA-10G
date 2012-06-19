/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        header_parser.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *          This module parses header in packets
 *  Note:
 *          AXI stream data structure is Little Endian
 *          In this header_parser module, we firstly convert
 *          everything to Network Order (Big Endian)
 *  Conditions:
 *          Data: must be 64bit width
 *          Strb: must be 8bit width
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

module header_parser
#(
   // AXI Stream Data Width
   parameter C_AXIS_DATA_WIDTH=64,
   parameter C_AXIS_LEN_DATA_WIDTH=16,
   parameter C_AXIS_SPT_DATA_WIDTH=8
)
(
   // Global Ports
   input asclk,
   input aresetn,

   // Input_fifo
   input [C_AXIS_DATA_WIDTH-1:0] tx_data,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] tx_strb,
   input tx_valid,
   input tx_last,
   input [C_AXIS_LEN_DATA_WIDTH-1:0] tx_len_data,
   input [C_AXIS_SPT_DATA_WIDTH-1:0] tx_spt_data,
   input fifo_empty,
   output reg fifo_rd_en,
   output reg tx_user_rd_en,

   // Lu_entry_composer
   output reg dl_start,

   output reg dl_done,
   output reg [C_AXIS_LEN_DATA_WIDTH-1:0] pkt_len,
   output reg [C_AXIS_SPT_DATA_WIDTH-1:0] src_port,
   output reg [47:0] dl_dst,
   output reg [47:0] dl_src,
   output reg [15:0] dl_ethtype,
   output reg [15:0] dl_vlantag,

   output reg mpls_done,
   output reg [19:0] mplslabel,
   output reg [2:0] mplstc,

   output reg arp_done,
   output reg [7:0] arp_op,
   output reg [31:0] arp_ip_src,
   output reg [31:0] arp_ip_dst,

   output reg ip_tp_done,
   output reg [5:0] ip_tos,
   output reg [7:0] ip_proto,
   output reg [31:0] ip_src,
   output reg [31:0] ip_dst,

   output reg [15:0] tp_src,
   output reg [15:0] tp_dst,

   input compose_done,

   // Registers
   output reg [31:0] dl_parse_cnt,
   output reg [31:0] mpls_parse_cnt,
   output reg [31:0] arp_parse_cnt,
   output reg [31:0] ip_tp_parse_cnt
);

   //-------------------- Internal Parameters ------------------------

   // Data read State Machine
   localparam NUM_DT_RD_STATES = 3;
   localparam DT_RD_1ST = 1,
              DT_RD_REST = 2,
              DT_RD_WAIT = 4;

   // DL State Machine
   localparam NUM_DL_STATES = 9;
   localparam DL_WAIT_TVALID = 1,
              DL_PARSE_2ND = 2,
              DL_PARSE_MORE = 4,
              DL_SFT16_1ST = 8,
              DL_SFT16_MORE = 16,
              DL_SFT16_LAST = 32,
              DL_SFT48_1ST = 64,
              DL_SFT48_MORE = 128,
              DL_SFT48_LAST = 256;

   // MPLS State Machine
   localparam NUM_MPLS_STATES = 2;
   localparam MPLS_WAIT_START = 1,
              MPLS_WAIT_DONE = 2;

   // ARP State Machine
   localparam NUM_ARP_STATES = 5;
   localparam ARP_WAIT_START = 1,
              ARP_PARSE_2ND = 2,
              ARP_PARSE_3RD = 4,
              ARP_PARSE_4TH = 8,
              ARP_WAIT_PARSE_DONE = 16;

   // IP_TP_and_above State Machine
   localparam NUM_IP_TP_STATES = 5;
   localparam IP_TP_WAIT_START = 1,
              IP_TP_PARSE_2ND = 2,
              IP_TP_PARSE_3RD = 4,
              IP_TP_PARSE_MORE = 8,
              IP_TP_WAIT_DONE = 16;

   //------------------------ Wires/Regs -----------------------------

   // Endian Conversion
   wire [C_AXIS_DATA_WIDTH-1:0] be_tx_data_infifo;
   reg [C_AXIS_DATA_WIDTH-1:0] be_tx_data;
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] be_tx_strb_infifo;
   reg [(C_AXIS_DATA_WIDTH/8)-1:0] be_tx_strb;

   reg [C_AXIS_LEN_DATA_WIDTH-1:0] tx_len_data_int;
   reg [C_AXIS_SPT_DATA_WIDTH-1:0] tx_spt_data_int;

   // Data read state machine
   reg [NUM_DT_RD_STATES-1:0] dt_rd_state, dt_rd_state_nxt;
   reg tx_valid_int, tx_valid_int_nxt;
   reg tx_last_int, tx_last_int_nxt;
   reg vlan_msb, vlan_lsb;
   wire vlan_msb_nxt, vlan_lsb_nxt;

   // DL State Machine
   reg  dl_start_nxt;
   reg [C_AXIS_LEN_DATA_WIDTH-1:0] pkt_len_nxt;
   reg [C_AXIS_SPT_DATA_WIDTH-1:0] src_port_nxt;
   reg [47:0] dl_dst_nxt;
   reg [47:0] dl_src_nxt;
   reg [15:0] dl_ethtype_nxt;
   reg [15:0] dl_vlantag_nxt;
   reg [C_AXIS_DATA_WIDTH-1:0] dl_tdata, dl_tdata_nxt;
   reg [15:0] dl_tdata16_buf, dl_tdata16_buf_nxt;
   reg [47:0] dl_tdata48_buf, dl_tdata48_buf_nxt;
   reg dl_done_nxt;
   reg ip_start, ip_start_nxt;
   reg arp_start, arp_start_nxt;
   reg mpls_start, mpls_start_nxt;
   reg dl_valid, dl_valid_nxt;
   reg [NUM_DL_STATES-1:0] dl_state, dl_state_nxt;

   // MPLS State Machine
   reg [19:0] mplslabel_nxt;
   reg [2:0] mplstc_nxt;
   reg mpls_done_nxt;
   reg [NUM_MPLS_STATES-1:0] mpls_state, mpls_state_nxt;

   // ARP State Machine
   reg [7:0] arp_op_nxt;
   reg [31:0] arp_ip_src_nxt;
   reg [31:0] arp_ip_dst_nxt;
   reg arp_done_nxt;
   reg [NUM_ARP_STATES-1:0] arp_state, arp_state_nxt;

   // IP_and_above State Machine
   reg [7:0] ip_hlen, ip_hlen_nxt;
   reg [5:0] ip_tos_nxt;
   reg ip_flag, ip_flag_nxt;
   reg [12:0] ip_frg, ip_frg_nxt;
   reg [7:0] ip_proto_nxt;
   reg [31:0] ip_src_nxt;
   reg [31:0] ip_dst_nxt;
   reg [15:0] tp_src_nxt;
   reg [15:0] tp_dst_nxt;
   reg ip_tp_done_nxt;
   reg [NUM_IP_TP_STATES-1:0] ip_state, ip_state_nxt;

   //--------------------------- Logic -------------------------------

   // Endian conversion
   // Assumption: Data is always 64bit width
   generate
      genvar i;
      for (i=0; i<8; i=i+1) begin:gen_network_order_data
         assign be_tx_strb_infifo[7-i] = tx_strb[i];
         assign be_tx_data_infifo[((56-i*8)+7):(56-i*8)] = tx_data[(i*8+7):(i*8)];
      end
   endgenerate

   // Data reading
   always @(*) begin
      fifo_rd_en = 0;
      tx_user_rd_en = 0;
      tx_valid_int_nxt = 0;
      tx_last_int_nxt = 0;
      dt_rd_state_nxt = dt_rd_state;
      case (dt_rd_state)
         DT_RD_1ST: begin
            if (~fifo_empty) begin
               fifo_rd_en = 1;
               tx_user_rd_en = 1;
               tx_valid_int_nxt = tx_valid;
               dt_rd_state_nxt = DT_RD_REST;
            end
         end
         DT_RD_REST: begin
            if (~fifo_empty) begin
               fifo_rd_en = 1;
               tx_valid_int_nxt = tx_valid;
               tx_last_int_nxt = tx_last;
               if (tx_last) begin
                  dt_rd_state_nxt = DT_RD_WAIT;
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
         tx_valid_int <= 0;
         tx_last_int <= 0;
         dt_rd_state <= DT_RD_1ST;
      end
      else begin
         tx_valid_int <= tx_valid_int_nxt;
         tx_last_int <= tx_last_int_nxt;
         dt_rd_state <= dt_rd_state_nxt;
      end
   end

   assign vlan_msb_nxt = ((be_tx_data_infifo[63:48] == `TYPE_VLAN) || (be_tx_data_infifo[63:48] == `TYPE_VLAN_QINQ)) ? 1 : 0;
   assign vlan_lsb_nxt = ((be_tx_data_infifo[31:16] == `TYPE_VLAN) || (be_tx_data_infifo[31:16] == `TYPE_VLAN_QINQ)) ? 1 : 0;

   always @(posedge asclk) begin
      if (~aresetn) begin
         be_tx_data <= 0;
         be_tx_strb <= 0;
         tx_len_data_int <= 0;
         tx_spt_data_int <= 0;
         vlan_msb <= 0;
         vlan_lsb <= 0;
      end
      else begin
         be_tx_data <= be_tx_data_infifo;
         be_tx_strb <= be_tx_strb_infifo;
         tx_len_data_int <= tx_len_data;
         tx_spt_data_int <= tx_spt_data;
         vlan_lsb <= vlan_lsb_nxt;
         vlan_msb <= vlan_msb_nxt;
      end
   end

   // DL parsing
   always @(*) begin
      dl_start_nxt = 0;
      pkt_len_nxt = pkt_len;
      src_port_nxt = src_port;
      dl_dst_nxt = dl_dst;
      dl_src_nxt = dl_src;
      dl_ethtype_nxt = dl_ethtype;
      dl_vlantag_nxt = dl_vlantag;

      dl_tdata_nxt = be_tx_data;
      dl_tdata16_buf_nxt = dl_tdata16_buf;
      dl_tdata48_buf_nxt = dl_tdata48_buf;

      dl_done_nxt = 0;
      ip_start_nxt = 0;
      arp_start_nxt = 0;
      mpls_start_nxt = 0;
      dl_valid_nxt = 0;
      dl_state_nxt = dl_state;

      case (dl_state)
         DL_WAIT_TVALID: begin
            pkt_len_nxt = tx_len_data_int;
            src_port_nxt = tx_spt_data_int;
            // Wait for the first word of pkt
            if (tx_valid_int) begin
               // L2 DST address
               dl_dst_nxt = be_tx_data[63:16];
               // L2 SRC address
               dl_src_nxt[47:32] = be_tx_data[15:0];

               dl_start_nxt = 1;
               dl_state_nxt = DL_PARSE_2ND;
            end
         end

         DL_PARSE_2ND: begin
            if (tx_valid_int) begin
               // L2 SRC address
               dl_src_nxt[31:0] = be_tx_data[63:32];
               dl_ethtype_nxt = be_tx_data[31:16];

               // Check if it has a VLAN tag
               // We get only the first tag info
               if (vlan_lsb) begin
                  dl_vlantag_nxt = be_tx_data[15:0];
                  dl_state_nxt = DL_PARSE_MORE;
               end
               else begin
                  dl_tdata16_buf_nxt = be_tx_data[15:0];
                  dl_vlantag_nxt = `NO_VLAN;
                  dl_state_nxt = DL_SFT16_1ST;
               end
            end
         end

         DL_PARSE_MORE: begin
            // Stay while it still has vlan tags
            if (tx_valid_int) begin
               // Check if MSB portion DOES NOT have a VLAN tag
               if (~vlan_msb) begin
                  dl_ethtype_nxt = be_tx_data[63:48];
                  dl_tdata48_buf_nxt = be_tx_data[47:0];
                  dl_state_nxt = DL_SFT48_1ST;
               end
               // Check if LSB portion DOES NOT have a VLAN tag
               // (Otherwise stay in this state for another cycle)
               else if (~vlan_lsb) begin
                  dl_ethtype_nxt = be_tx_data[31:16];
                  dl_tdata16_buf_nxt = be_tx_data[15:0];
                  dl_state_nxt = DL_SFT16_1ST;
               end
            end
         end

         DL_SFT16_1ST: begin
            if (tx_valid_int) begin
               dl_tdata_nxt = {dl_tdata16_buf, be_tx_data[63:16]};
               dl_tdata16_buf_nxt = be_tx_data[15:0];
               dl_valid_nxt = 1;
               case (dl_ethtype)
                  `TYPE_IP: ip_start_nxt = 1;
                  `TYPE_ARP: arp_start_nxt = 1;
                  `TYPE_MPLS: mpls_start_nxt = 1;
                  `TYPE_MPLS_MC: mpls_start_nxt = 1;
                  default: dl_done_nxt = 1;
               endcase

               if (tx_last_int)  begin
                  if (|be_tx_strb[1:0]) begin
                     dl_state_nxt = DL_SFT16_LAST;
                  end
                  else begin
                     dl_state_nxt = DL_WAIT_TVALID;
                  end
               end
               else begin
                  dl_state_nxt = DL_SFT16_MORE;
               end
            end
         end

         DL_SFT16_MORE: begin
            if (tx_valid_int) begin
               dl_tdata_nxt = {dl_tdata16_buf, be_tx_data[63:16]};
               dl_tdata16_buf_nxt = be_tx_data[15:0];
               dl_valid_nxt = 1;

               if (tx_last_int)  begin
                  if (|be_tx_strb[1:0]) begin
                     dl_state_nxt = DL_SFT16_LAST;
                  end
                  else begin
                     dl_state_nxt = DL_WAIT_TVALID;
                  end
               end
            end
         end

         DL_SFT16_LAST: begin
            dl_tdata_nxt = {dl_tdata16_buf, 48'hCA_FE_BE_EF_F0_0D}; //DUMMY
            dl_valid_nxt = 1;
            dl_state_nxt = DL_WAIT_TVALID;
         end

         DL_SFT48_1ST: begin
            if (tx_valid_int) begin
               dl_tdata_nxt = {dl_tdata48_buf, be_tx_data[63:48]};
               dl_tdata48_buf_nxt = be_tx_data[47:0];
               dl_valid_nxt = 1;
               case (dl_ethtype)
                  `TYPE_IP: ip_start_nxt = 1;
                  `TYPE_ARP: arp_start_nxt = 1;
                  `TYPE_MPLS: mpls_start_nxt = 1;
                  `TYPE_MPLS_MC: mpls_start_nxt = 1;
                  default: dl_done_nxt = 1;
               endcase

               if (tx_last_int)  begin
                  if (|be_tx_strb[5:0]) begin
                     dl_state_nxt = DL_SFT48_LAST;
                  end
                  else begin
                     dl_state_nxt = DL_WAIT_TVALID;
                  end
               end
               else begin
                  dl_state_nxt = DL_SFT48_MORE;
               end
            end
         end

         DL_SFT48_MORE: begin
            if (tx_valid_int) begin
               dl_tdata_nxt = {dl_tdata48_buf, be_tx_data[63:48]};
               dl_tdata48_buf_nxt = be_tx_data[47:0];
               dl_valid_nxt = 1;

               if (tx_last_int)  begin
                  if (|be_tx_strb[5:0]) begin
                     dl_state_nxt = DL_SFT48_LAST;
                  end
                  else begin
                     dl_state_nxt = DL_WAIT_TVALID;
                  end
               end
            end
         end

         DL_SFT48_LAST: begin
            dl_tdata_nxt = {dl_tdata48_buf, 16'h90_0D}; //DUMMY
            dl_valid_nxt = 1;
            dl_state_nxt = DL_WAIT_TVALID;
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         dl_start <= 0;
         pkt_len <= 0;
         src_port <= 0;
         dl_dst <= 0;
         dl_src <= 0;
         dl_ethtype <= 0;
         dl_vlantag <= 0;
         dl_tdata <= 0;
         dl_tdata16_buf <= 0;
         dl_tdata48_buf <= 0;
         dl_done <= 0;
         ip_start <= 0;
         arp_start <= 0;
         mpls_start <= 0;
         dl_valid <= 0;
         dl_state <= DL_WAIT_TVALID;
      end
      else begin
         dl_start <= dl_start_nxt;
         pkt_len <= pkt_len_nxt;
         src_port <= src_port_nxt;
         dl_dst <= dl_dst_nxt;
         dl_src <= dl_src_nxt;
         dl_ethtype <= dl_ethtype_nxt;
         dl_vlantag <= dl_vlantag_nxt;
         dl_tdata <= dl_tdata_nxt;
         dl_tdata16_buf <= dl_tdata16_buf_nxt;
         dl_tdata48_buf <= dl_tdata48_buf_nxt;
         dl_done <= dl_done_nxt;
         ip_start <= ip_start_nxt;
         arp_start <= arp_start_nxt;
         mpls_start <= mpls_start_nxt;
         dl_valid <= dl_valid_nxt;
         dl_state <= dl_state_nxt;
      end
   end

   // MPLS parsing
   always @(*) begin
      mplslabel_nxt = mplslabel;
      mplstc_nxt = mplstc;
      mpls_done_nxt = 0;
      mpls_state_nxt = mpls_state;

      case (mpls_state)
         MPLS_WAIT_START: begin
            if (mpls_start) begin
               mplslabel_nxt = dl_tdata[51:32];
               mplstc_nxt = dl_tdata[54:52];
               mpls_done_nxt = 1;
               mpls_state_nxt = MPLS_WAIT_DONE;
            end
         end

         MPLS_WAIT_DONE: begin
            if (compose_done) begin
               mpls_state_nxt = MPLS_WAIT_START;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         mplslabel <= 0;
         mplstc <= 0;
         mpls_done <= 0;
         mpls_state <= MPLS_WAIT_START;
      end
      else begin
         mplslabel <= mplslabel_nxt;
         mplstc <= mplstc_nxt;
         mpls_done <= mpls_done_nxt;
         mpls_state <= mpls_state_nxt;
      end
   end

   // ARP parsing
   always @(*) begin
      arp_op_nxt = arp_op;
      arp_ip_src_nxt = arp_ip_src;
      arp_ip_dst_nxt = arp_ip_dst;
      arp_done_nxt = 0;
      arp_state_nxt = arp_state;

      case (arp_state)
         ARP_WAIT_START: begin
            if (arp_start) begin
               // Lower 8bits are used for matching
               arp_op_nxt = dl_tdata[7:0];
               arp_state_nxt = ARP_PARSE_2ND;
            end
         end

         ARP_PARSE_2ND: begin
            if (dl_valid) begin
               arp_ip_src_nxt[31:16] = dl_tdata[15:0];
               arp_state_nxt = ARP_PARSE_3RD;
            end
         end

         ARP_PARSE_3RD: begin
            if (dl_valid) begin
               arp_ip_src_nxt[15:0] = dl_tdata[63:48];
               arp_state_nxt = ARP_PARSE_4TH;
            end
         end

         ARP_PARSE_4TH: begin
            if (dl_valid) begin
               arp_ip_dst_nxt = dl_tdata[63:32];
               arp_done_nxt = 1;
               arp_state_nxt = ARP_WAIT_PARSE_DONE;
            end
         end

         ARP_WAIT_PARSE_DONE: begin
            if (compose_done) begin
               arp_state_nxt = ARP_WAIT_START;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         arp_op <= 0;
         arp_ip_src <= 0;
         arp_ip_dst <= 0;
         arp_done <= 0;
         arp_state <= ARP_WAIT_START;
      end
      else begin
         arp_op <= arp_op_nxt;
         arp_ip_src <= arp_ip_src_nxt;
         arp_ip_dst <= arp_ip_dst_nxt;
         arp_done <= arp_done_nxt;
         arp_state <= arp_state_nxt;
      end
   end

   // IP and above layer parsing
   always @(*) begin
      ip_hlen_nxt = ip_hlen;
      ip_tos_nxt = ip_tos;
      ip_flag_nxt = ip_flag;
      ip_frg_nxt = ip_frg;
      ip_proto_nxt = ip_proto;
      ip_src_nxt = ip_src;
      ip_dst_nxt = ip_dst;
      tp_src_nxt = tp_src;
      tp_dst_nxt = tp_dst;
      ip_state_nxt = ip_state;
      ip_tp_done_nxt = 0;

      case (ip_state)
         IP_TP_WAIT_START: begin
            if (ip_start) begin
               // Subtract two words (processed in this state)
               ip_hlen_nxt = dl_tdata[59:56] - 2;
               // Upper 6bits are used for matching
               ip_tos_nxt = dl_tdata[55:50];
               ip_flag_nxt = dl_tdata[15] || (|dl_tdata[12:0]);
               ip_frg_nxt = dl_tdata[12:0];
               ip_state_nxt = IP_TP_PARSE_2ND;
            end
         end

         IP_TP_PARSE_2ND: begin
            if (dl_valid) begin
               ip_hlen_nxt = ip_hlen - 2;
               ip_proto_nxt = dl_tdata[55:48];
               ip_src_nxt = dl_tdata[31:0];
               ip_state_nxt = IP_TP_PARSE_3RD;
            end
         end

         IP_TP_PARSE_3RD: begin
            if (dl_valid) begin
               ip_dst_nxt = dl_tdata[63:32];
               // TP layer not parsed for fragmented packet
               if (ip_flag) begin
                  ip_tp_done_nxt = 1;
                  tp_src_nxt = 0;
                  tp_dst_nxt = 0;
                  ip_state_nxt = IP_TP_WAIT_DONE;
               end
               else if (ip_hlen == 0) begin
                  // This means something is strange
                  // Invalidate IP field
                  ip_tp_done_nxt = 1;
                  ip_tos_nxt = 0;
                  ip_proto_nxt = 0;
                  ip_src_nxt = 0;
                  ip_dst_nxt = 0;
                  ip_state_nxt = IP_TP_WAIT_DONE;
               end
               else if (ip_hlen == 1) begin
                  ip_tp_done_nxt = 1;
                  // TP parsing
                  case (ip_proto)
                     `PROTO_ICMP: begin
                        tp_src_nxt = {8'h0, dl_tdata[31:24]}; // TYPE
                        tp_dst_nxt = {8'h0, dl_tdata[23:16]}; // CODE
                     end
                     `PROTO_UDP, `PROTO_TCP, `PROTO_SCTP: begin
                        tp_src_nxt = dl_tdata[31:16];
                        tp_dst_nxt = dl_tdata[15:0];
                     end
                     default: begin
                        tp_src_nxt = 0;
                        tp_dst_nxt = 0;
                     end
                  endcase
                  ip_state_nxt = IP_TP_WAIT_DONE;
               end
               else begin
                  ip_hlen_nxt = ip_hlen - 2;
                  ip_state_nxt = IP_TP_PARSE_MORE;
               end
            end
         end

         IP_TP_PARSE_MORE: begin
            if (dl_valid) begin
               if (ip_hlen == 0) begin
                  ip_tp_done_nxt = 1;
                  // TP parsing
                  case (ip_proto)
                     `PROTO_ICMP: begin
                        tp_src_nxt = {8'h0, dl_tdata[63:56]}; // TYPE
                        tp_dst_nxt = {8'h0, dl_tdata[55:48]}; // CODE
                     end
                     `PROTO_UDP, `PROTO_TCP, `PROTO_SCTP: begin
                        tp_src_nxt = dl_tdata[63:48];
                        tp_dst_nxt = dl_tdata[47:32];
                     end
                     default: begin
                        tp_src_nxt = 0;
                        tp_dst_nxt = 0;
                     end
                  endcase
                  ip_state_nxt = IP_TP_WAIT_DONE;
               end
               else if (ip_hlen == 1) begin
                  ip_tp_done_nxt = 1;
                  // TP parsing
                  case (ip_proto)
                     `PROTO_ICMP: begin
                        tp_src_nxt = {8'h0, dl_tdata[31:24]}; // TYPE
                        tp_dst_nxt = {8'h0, dl_tdata[23:16]}; // CODE
                     end
                     `PROTO_UDP, `PROTO_TCP, `PROTO_SCTP: begin
                        tp_src_nxt = dl_tdata[31:16];
                        tp_dst_nxt = dl_tdata[15:0];
                     end
                     default: begin
                        tp_src_nxt = 0;
                        tp_dst_nxt = 0;
                     end
                  endcase
                  ip_state_nxt = IP_TP_WAIT_DONE;
               end
               else begin
                  ip_hlen_nxt = ip_hlen - 2;
                  ip_state_nxt = IP_TP_PARSE_MORE;
               end
            end
         end

         IP_TP_WAIT_DONE: begin
            if (compose_done) begin
               ip_state_nxt = IP_TP_WAIT_START;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         ip_hlen <= 0;
         ip_tos <= 0;
         ip_flag <= 0;
         ip_frg <= 0;
         ip_proto <= 0;
         ip_src <= 0;
         ip_dst <= 0;
         tp_src <= 0;
         tp_dst <= 0;
         ip_state <= IP_TP_WAIT_START;
         ip_tp_done <= 0;
      end
      else begin
         ip_hlen <= ip_hlen_nxt;
         ip_tos <= ip_tos_nxt;
         ip_flag <= ip_flag_nxt;
         ip_frg <= ip_frg_nxt;
         ip_proto <= ip_proto_nxt;
         ip_src <= ip_src_nxt;
         ip_dst <= ip_dst_nxt;
         tp_src <= tp_src_nxt;
         tp_dst <= tp_dst_nxt;
         ip_state <= ip_state_nxt;
         ip_tp_done <= ip_tp_done_nxt;
      end
   end

   // Counters
   always @(posedge asclk) begin
      if (~aresetn) begin
         dl_parse_cnt <= 0;
         mpls_parse_cnt <= 0;
         arp_parse_cnt <= 0;
         ip_tp_parse_cnt <= 0;
      end
      else begin
         // Roll over when they have reached maximum values
         if (dl_done) begin
             dl_parse_cnt <= dl_parse_cnt + 1;
         end
         if (mpls_done) begin
            mpls_parse_cnt <= mpls_parse_cnt + 1;
         end
         if (arp_done) begin
            arp_parse_cnt <= arp_parse_cnt + 1;
         end
         if (ip_tp_done) begin
            ip_tp_parse_cnt <= ip_tp_parse_cnt + 1;
         end
      end
   end

endmodule
