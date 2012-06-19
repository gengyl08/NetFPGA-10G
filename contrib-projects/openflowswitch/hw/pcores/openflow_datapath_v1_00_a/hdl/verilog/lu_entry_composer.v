/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        lu_entry_composer.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        Compose parsed fields into one bitmap
 *        and send it to flow table as a matching entry
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

module lu_entry_composer
#(
    parameter OPENFLOW_MATCH_SIZE=256,
    parameter C_AXIS_LEN_DATA_WIDTH=16,
    parameter C_AXIS_SPT_DATA_WIDTH=8,
    parameter MPLS_ENABLE=0
)
(
   // Global Ports
   input asclk,
   input aresetn,

   // header parser
   input dl_start,

   input dl_done,
   input [C_AXIS_LEN_DATA_WIDTH-1:0] pkt_len,
   input [C_AXIS_SPT_DATA_WIDTH-1:0] src_port,
   input [47:0] dl_dst,
   input [47:0] dl_src,
   input [15:0] dl_ethtype,
   input [15:0] dl_vlantag,

   input mpls_done,
   input [19:0] mplslabel,
   input [2:0] mplstc,

   input arp_done,
   input [7:0] arp_op,
   input [31:0] arp_ip_src,
   input [31:0] arp_ip_dst,

   input ip_tp_done,
   input [5:0] ip_tos,
   input [7:0] ip_proto,
   input [31:0] ip_src,
   input [31:0] ip_dst,

   input [15:0] tp_src,
   input [15:0] tp_dst,

   output reg compose_done,

   input lu_ack,
   output reg [OPENFLOW_MATCH_SIZE-1:0] lu_entry,
   output reg [C_AXIS_LEN_DATA_WIDTH-1:0] lu_len,
   output reg lu_req
);

   //-------------------- Internal Parameters ------------------------

   localparam NUM_START_CHECK_STATES = 2;
   localparam SC_WAIT_PARSE_START = 1,
              SC_WAIT_CMP_DONE = 2;

   localparam NUM_REQ_LATCH_STATES = 2;
   localparam RL_WAIT_PARSE_DONE = 1,
              RL_WAIT_REQ = 2;

   localparam NUM_LU_INF_STATES = 2;
   localparam LU_WAIT_INT_REQ = 1,
              LU_WAIT_ACK = 2;

   localparam ENTRY_DL = 4'b1 << 0,
              ENTRY_MPLS = 4'b1 << 1,
              ENTRY_ARP = 4'b1 << 2,
              ENTRY_IP_TP = 4'b1 << 3;

   //------------------------ Wires/Regs -----------------------------

   // Parsing-status check state machine
   reg parse_started, parse_started_nxt;
   reg [NUM_START_CHECK_STATES-1:0] sc_state, sc_state_nxt;

   // Request latch state machine
   wire [3:0] parse_result;
   reg [OPENFLOW_MATCH_SIZE-1:0] int_entry, int_entry_nxt;
   reg [C_AXIS_LEN_DATA_WIDTH-1:0] int_len, int_len_nxt;
   reg [C_AXIS_SPT_DATA_WIDTH-1:0] int_src_port, int_src_port_nxt;
   reg compose_done_nxt;
   reg int_req, int_req_nxt;
   reg lu_req_prev;
   reg [NUM_REQ_LATCH_STATES-1:0] req_latch_state, req_latch_state_nxt;

   // Flowtable interface state machine
   reg lu_req_nxt;
   reg [OPENFLOW_MATCH_SIZE-1:0] lu_entry_nxt;
   reg [C_AXIS_LEN_DATA_WIDTH-1:0] lu_len_nxt;
   reg [NUM_LU_INF_STATES-1:0] lookup_inf_state, lookup_inf_state_nxt;

   //--------------------------- Logic -------------------------------

   // Parsing-status Check
   always @(*) begin
      parse_started_nxt = parse_started;
      sc_state_nxt = sc_state;
      case (sc_state)
         SC_WAIT_PARSE_START: begin
            if (dl_start == 1) begin
               parse_started_nxt = 1;
               sc_state_nxt = SC_WAIT_CMP_DONE;
            end
         end

         SC_WAIT_CMP_DONE: begin
            if (compose_done == 1) begin
               parse_started_nxt = 0;
               sc_state_nxt = SC_WAIT_PARSE_START;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         parse_started <= 0;
         sc_state <= SC_WAIT_PARSE_START;
      end
      else begin
         parse_started <= parse_started_nxt;
         sc_state <= sc_state_nxt;
      end
   end

   // Request-latch state machine

   // Only one state machine will reply during one packet parsing process
   assign parse_result[0] = dl_done;
   assign parse_result[1] = mpls_done;
   assign parse_result[2] = arp_done;
   assign parse_result[3] = ip_tp_done;

   always @(posedge asclk) begin
      if (~aresetn) begin
         lu_req_prev <= 0;
      end
      else begin
         lu_req_prev <= lu_req;
      end
   end

   always @(*) begin
      int_req_nxt = int_req;
      int_entry_nxt = int_entry;
      int_len_nxt = int_len;
      int_src_port_nxt = int_src_port;
      compose_done_nxt = 0;
      req_latch_state_nxt = req_latch_state;

      case (req_latch_state)
         RL_WAIT_PARSE_DONE: begin
            int_len_nxt = pkt_len;
            int_src_port_nxt = src_port;
            if (parse_started == 1) begin
               case (parse_result)
                  ENTRY_DL: begin  // ether frame
                     if (MPLS_ENABLE) begin
                        int_entry_nxt = {
                           9'h000, //pad
                           3'h0, //mpls_tc
                           20'h00000, //mpls label
                           8'h00, //pad
                           dl_vlantag,
                           8'h00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           32'h0000_0000, //nw_src
                           32'h0000_0000, //nw_dst
                           8'h00, //nw_proto
                           16'h0000, //tp_src
                           16'h0000 //tp_dst
                        };
                     end
                     else begin
                        int_entry_nxt = {
                           8'h00, //pad
                           dl_vlantag,
                           8'h00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           32'h0000_0000, //nw_src
                           32'h0000_0000, //nw_dst
                           8'h00, //nw_proto
                           16'h0000, //tp_src
                           16'h0000 //tp_dst
                        };
                     end
                     compose_done_nxt = 1;
                     int_req_nxt = 1;
                     req_latch_state_nxt = RL_WAIT_REQ;
                  end
                  ENTRY_MPLS: begin //MPLS
                     if (MPLS_ENABLE) begin
                        int_entry_nxt = {
                           9'h000, //pad
                           mplstc, //mpls tc
                           mplslabel, //mpls label
                           8'h00, //pad
                           dl_vlantag,
                           8'h00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           32'h0000_0000, //nw_src
                           32'h0000_0000, //nw_dst
                           8'h00, //nw_proto
                           16'h0000, //tp_src
                           16'h0000 //tp_dst
                        };
                     end
                     else begin
                        // DL only
                        int_entry_nxt = {
                           8'h00, //pad
                           dl_vlantag,
                           8'h00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           32'h0000_0000, //nw_src
                           32'h0000_0000, //nw_dst
                           8'h00, //nw_proto
                           16'h0000, //tp_src
                           16'h0000 //tp_dst
                        };
                     end
                     compose_done_nxt = 1;
                     int_req_nxt = 1;
                     req_latch_state_nxt = RL_WAIT_REQ;
                  end
                  ENTRY_ARP: begin //ARP
                     if (MPLS_ENABLE) begin
                        int_entry_nxt = {
                           9'h000, //pad
                           3'h0, //mpls_tc
                           20'h00000, //mpls label
                           8'h00, //pad
                           dl_vlantag,
                           8'h00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           arp_ip_src, //arp_send_ip
                           arp_ip_dst, //arp_target_ip
                           arp_op, // arp_op_code
                           16'h0000, //tp_src
                           16'h0000 //tp_dst
                        };
                     end
                     else begin
                        int_entry_nxt = {
                           8'h00, //pad
                           dl_vlantag,
                           8'h00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           arp_ip_src, //arp_send_ip
                           arp_ip_dst, //arp_target_ip
                           arp_op, // arp_op_code
                           16'h0000, //tp_src
                           16'h0000 //tp_dst
                        };
                     end
                     compose_done_nxt = 1;
                     int_req_nxt = 1;
                     req_latch_state_nxt = RL_WAIT_REQ;
                  end
                  ENTRY_IP_TP: begin //IP, UDP, TCP, SCTP, ICMP
                     if (MPLS_ENABLE) begin
                        int_entry_nxt = {
                           9'h000, //pad
                           3'h0, //mpls_tc
                           20'h00000, //mpls label
                           8'h00, //pad
                           dl_vlantag,
                           ip_tos, 2'b00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           ip_src, //nw_src
                           ip_dst, //nw_dst
                           ip_proto, //nw_proto
                           tp_src, //tp_src
                           tp_dst //tp_dst
                        };
                     end
                     else begin
                        int_entry_nxt = {
                           8'h00, //pad
                           dl_vlantag,
                           ip_tos, 2'b00, //nw_tos
                           src_port,
                           dl_src,
                           dl_dst,
                           dl_ethtype,
                           ip_src, //nw_src
                           ip_dst, //nw_dst
                           ip_proto, //nw_proto
                           tp_src, //tp_src
                           tp_dst //tp_dst
                        };
                     end
                     compose_done_nxt = 1;
                     int_req_nxt = 1;
                     req_latch_state_nxt = RL_WAIT_REQ;
                  end
               endcase
            end
         end

         RL_WAIT_REQ: begin
            // Wait for another request
            if ((lu_req == 1) && (lu_req_prev == 0)) begin
               int_req_nxt = 0;
               req_latch_state_nxt = RL_WAIT_PARSE_DONE;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
        int_req <= 0;
        int_entry <= 0;
        int_len <= 0;
        int_src_port <= 0;
        compose_done <= 0;
        req_latch_state <= RL_WAIT_PARSE_DONE;
      end
      else begin
        int_req <= int_req_nxt;
        int_entry <= int_entry_nxt;
        int_len <= int_len_nxt;
        int_src_port <= int_src_port_nxt;
        compose_done <= compose_done_nxt;
        req_latch_state <= req_latch_state_nxt;
      end
   end

   // Flow_table module Interface
   always @(*) begin
      lu_req_nxt = lu_req;
      lu_entry_nxt = lu_entry;
      lu_len_nxt = lu_len;
      lookup_inf_state_nxt = lookup_inf_state;
      case (lookup_inf_state)
         LU_WAIT_INT_REQ: begin
            if (int_req == 1) begin
               lu_req_nxt = 1;
               lu_entry_nxt = int_entry;
               lu_len_nxt = int_len;
               lookup_inf_state_nxt = LU_WAIT_ACK;
            end
         end

         LU_WAIT_ACK: begin
            if (lu_ack == 1) begin
               lu_req_nxt = 0;
               lookup_inf_state_nxt = LU_WAIT_INT_REQ;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         lu_req <= 0;
         lu_entry <= 0;
         lu_len <= 0;
         lookup_inf_state <= LU_WAIT_INT_REQ;
      end
      else begin
         lu_req <= lu_req_nxt;
         lu_entry <= lu_entry_nxt;
         lu_len <= lu_len_nxt;
         lookup_inf_state <= lookup_inf_state_nxt;
      end
   end

endmodule
