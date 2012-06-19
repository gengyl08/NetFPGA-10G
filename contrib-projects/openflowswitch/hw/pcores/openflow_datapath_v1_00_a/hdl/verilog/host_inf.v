/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        host_inf.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        It stores a set of table entries from CPU and flush them
 *        to the next module as a single access
 *        It has a register interface to the host via
 *        axi_interconnect
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

`timescale 1ns / 1ps
`include "registers.v"

module host_inf
#(
    // AXI Lite Data/Address Width
    parameter C_S_AXI_DATA_WIDTH=32,
    parameter C_S_AXI_ADDR_WIDTH=32,
    parameter C_S_AXI_BASEADDR = 32'h0000_0000,
    parameter C_S_AXI_HIGHADDR = 32'h0000_0FFF,
    // Parameters for Flow Table interface
    // 2^(TBL_WIDTH) will be the total Flow Table area
    // (Split the area into two for EXACT and WILDCARD tables)
    parameter TBL_WIDTH=16,
    parameter OPENFLOW_MATCH_SIZE=256,
    parameter OPENFLOW_ACTION_SIZE=320,
    parameter OPENFLOW_STATS_SIZE=64
)
(
   // Generic
   input  aresetn,

   // AXI lite ports
   input  aclk,

   input  [C_S_AXI_ADDR_WIDTH-1:0] awaddr,
   input  awvalid,
   output reg awready,

   input  [C_S_AXI_DATA_WIDTH-1:0]   wdata,
   input  [C_S_AXI_DATA_WIDTH/8-1:0] wstrb,
   input  wvalid,
   output reg wready,

   output reg [1:0] bresp,
   output reg bvalid,
   input  bready,

   input  [C_S_AXI_ADDR_WIDTH-1:0] araddr,
   input  arvalid,
   output reg arready,

   output reg [C_S_AXI_DATA_WIDTH-1:0] rdata,
   output reg [1:0] rresp,
   output reg rvalid,
   input  rready,

   // Flow table interface ports (AXI stream CLK domain)
   input asclk,

   output reg [TBL_WIDTH-1:0] flow_entry_addr,
   output [OPENFLOW_MATCH_SIZE-1:0] flow_entry_match_out,
   output [OPENFLOW_MATCH_SIZE-1:0] flow_entry_mask_out,
   output [OPENFLOW_ACTION_SIZE-1:0] flow_entry_action_out,
   output [OPENFLOW_STATS_SIZE-1:0] flow_entry_stats_out,

   /* --- Disabled temporarily due to FPGA resource limitation
   input [OPENFLOW_MATCH_SIZE-1:0] flow_entry_match_in,
   input [OPENFLOW_ACTION_SIZE-1:0] flow_entry_action_in,
   --- Disabled temporarily due to FPGA resource limitation */

   input [OPENFLOW_STATS_SIZE-1:0] flow_entry_stats_in,
   output reg flow_entry_wr,
      // pos: write, neg: read
   output reg flow_entry_stats_en,
      // neg: match/mask/action area
      // pos: Above + stats area
   output reg flow_entry_req,
   input flow_entry_ack,
   input flow_entry_done,

   // Registers from other modules

   //--- Pkt_preprocessor
   // Currently we assume we have five fixed modules

   input [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_0,
   input [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_0,
   input [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_0,
   input [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_0,

   input [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_1,
   input [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_1,
   input [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_1,
   input [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_1,

   input [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_2,
   input [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_2,
   input [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_2,
   input [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_2,

   input [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_3,
   input [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_3,
   input [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_3,
   input [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_3,

   input [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_4,
   input [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_4,
   input [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_4,
   input [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_4,

   input [31:0] act_num_pkts_processed_0,
   input [31:0] act_num_pkts_processed_1,
   input [31:0] act_num_pkts_processed_2,
   input [31:0] act_num_pkts_processed_3,
   input [31:0] act_num_pkts_processed_4,


   //--- Flow_tbl_controller
   input [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_0,
   input [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_1,
   input [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_2,
   input [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_3,
   input [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_4,
   input [C_S_AXI_DATA_WIDTH-1:0] exact_hit,
   input [C_S_AXI_DATA_WIDTH-1:0] exact_miss,
   input [C_S_AXI_DATA_WIDTH-1:0] wildcard_hit,
   input [C_S_AXI_DATA_WIDTH-1:0] wildcard_miss
);

   //-------------------- Internal Parameters ------------------------

   localparam NUM_AXI_WR_STATES = 3,
              WRITE_IDLE = 1,
              WRITE_DATA = 2,
              WRITE_RESPONSE = 4;

   localparam NUM_FLOW_TABLE_ACC_STATES = 5,
              FTACC_WAIT_TRIG = 1,
              FTACC_WAIT_WRITE_ACK = 2,
              FTACC_WAIT_READ_ACK = 4,
              FTACC_WAIT_WRITE_ACK_CANCEL = 8,
              FTACC_WAIT_READ_ACK_CANCEL = 16;

   localparam NUM_AXI_RD_STATES = 3,
              READ_IDLE = 1,
              READ_WAIT = 2,
              READ_RESPONSE = 4;

   localparam AXI_RESP_OK = 2'b00;
   localparam AXI_RESP_SLVERR = 2'b10;

   localparam ENTRY_BUF_SIZE = OPENFLOW_MATCH_SIZE*2 +
                               OPENFLOW_ACTION_SIZE +
                               OPENFLOW_STATS_SIZE;

   localparam ENTRY_BUF_SIZE_WORD =
                 ENTRY_BUF_SIZE/C_S_AXI_DATA_WIDTH,
              OPENFLOW_MATCH_SIZE_WORD =
                 OPENFLOW_MATCH_SIZE/C_S_AXI_DATA_WIDTH,
              OPENFLOW_ACTION_SIZE_WORD =
                 OPENFLOW_ACTION_SIZE/C_S_AXI_DATA_WIDTH,
              OPENFLOW_STATS_SIZE_WORD =
                 OPENFLOW_STATS_SIZE/C_S_AXI_DATA_WIDTH;

   localparam LOCAL_ADDR_DEPTH = 8;

   //------------------------ Wires/Regs -----------------------------

   //--- AXI_WRITE
   reg [NUM_AXI_WR_STATES-1:0] axi_wr_state, axi_wr_state_nxt;
   reg [LOCAL_ADDR_DEPTH-1:0] wr_addr, wr_addr_nxt;
   reg [C_S_AXI_DATA_WIDTH-1:0] wr_data;
   reg entry_addr_base_vld, entry_addr_base_vld_nxt;
   reg entry_wr, entry_wr_nxt;
   reg entry_mod_wr, entry_mod_wr_nxt;
   reg entry_rd, entry_rd_nxt;
   reg entry_vld, entry_vld_nxt;
   reg [7:0] entry_offset, entry_offset_nxt;
   wire [7:0] entry_base = `ENTRY_BASE_REG; //temporary
   reg [1:0] bresp_nxt;

   //--- FLOW_TABLE_ACC
   reg [NUM_FLOW_TABLE_ACC_STATES-1:0] flow_table_acc_state,
                                       flow_table_acc_state_nxt;
   reg flow_entry_req_int, flow_entry_req_int_nxt;
   reg flow_entry_wr_int, flow_entry_wr_int_nxt;
   reg flow_entry_stats_en_int, flow_entry_stats_en_int_nxt;
   reg entry_wr_ack, entry_wr_ack_nxt;
   reg entry_rd_ack, entry_rd_ack_nxt;

   //--- AXI_READ
   reg [NUM_AXI_RD_STATES-1:0] axi_rd_state, axi_rd_state_nxt;
   reg [LOCAL_ADDR_DEPTH-1:0] rd_addr, rd_addr_nxt;

   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_out_d1[0:ENTRY_BUF_SIZE_WORD-1];
   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_out_d2[0:ENTRY_BUF_SIZE_WORD-1];
   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_out[0:ENTRY_BUF_SIZE_WORD-1];
//   wire [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in_d1[0:ENTRY_BUF_SIZE_WORD-1];
//   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in_d2[0:ENTRY_BUF_SIZE_WORD-1];
//   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in[0:ENTRY_BUF_SIZE_WORD-1];
   wire [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in_d1[0:OPENFLOW_STATS_SIZE_WORD-1];
   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in_d2[0:OPENFLOW_STATS_SIZE_WORD-1];
   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in[0:OPENFLOW_STATS_SIZE_WORD-1];
   reg [C_S_AXI_DATA_WIDTH-1:0] entry_buf_in_int;

   reg [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_0_int, dl_parse_cnt_0_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_1_int, dl_parse_cnt_1_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_2_int, dl_parse_cnt_2_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_3_int, dl_parse_cnt_3_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt_4_int, dl_parse_cnt_4_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_0_int, mpls_parse_cnt_0_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_1_int, mpls_parse_cnt_1_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_2_int, mpls_parse_cnt_2_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_3_int, mpls_parse_cnt_3_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt_4_int, mpls_parse_cnt_4_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_0_int, arp_parse_cnt_0_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_1_int, arp_parse_cnt_1_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_2_int, arp_parse_cnt_2_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_3_int, arp_parse_cnt_3_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt_4_int, arp_parse_cnt_4_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_0_int, ip_tp_parse_cnt_0_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_1_int, ip_tp_parse_cnt_1_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_2_int, ip_tp_parse_cnt_2_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_3_int, ip_tp_parse_cnt_3_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt_4_int, ip_tp_parse_cnt_4_int_d1;

   reg [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_0_int, num_pkts_dropped_0_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_1_int, num_pkts_dropped_1_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_2_int, num_pkts_dropped_2_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_3_int, num_pkts_dropped_3_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped_4_int, num_pkts_dropped_4_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] exact_hit_int, exact_hit_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] exact_miss_int, exact_miss_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] wildcard_hit_int, wildcard_hit_int_d1;
   reg [C_S_AXI_DATA_WIDTH-1:0] wildcard_miss_int, wildcard_miss_int_d1;

//   reg [OPENFLOW_MATCH_SIZE-1:0] flow_entry_match_in_int;
//   reg [OPENFLOW_ACTION_SIZE-1:0] flow_entry_action_in_int;
   reg [OPENFLOW_STATS_SIZE-1:0] flow_entry_stats_in_int;

   reg flow_entry_req_int_1,
       flow_entry_req_int_2,
       flow_entry_req_int_3;

   reg flow_entry_wr_int_1,
       flow_entry_wr_int_2;

   reg flow_entry_stats_en_int_1,
       flow_entry_stats_en_int_2;

   reg flow_entry_done_1,
       flow_entry_done_2,
       flow_entry_done_int;

   reg rd_acc_rdy,
       wr_acc_rdy;
   wire acc_rdy;

   integer i, j, k;

   //--------------------------- Logic -------------------------------

   //--- AXI_WRITE (AXI lite CLK domain)
   always @(*) begin
      axi_wr_state_nxt = axi_wr_state;
      wr_addr_nxt = wr_addr;
      awready = 1'b1;
      wready = 1'b0;
      bvalid = 1'b0;
      bresp_nxt = bresp;

      entry_addr_base_vld_nxt = 0;
      entry_wr_nxt = 0;
      entry_mod_wr_nxt = 0;
      entry_rd_nxt = 0;
      entry_vld_nxt = 0;
      entry_offset_nxt = entry_offset;

      case(axi_wr_state)
         WRITE_IDLE: begin
            wr_addr_nxt = awaddr[LOCAL_ADDR_DEPTH-1:0];
            if (awvalid) begin
                axi_wr_state_nxt = WRITE_DATA;
            end
         end

         WRITE_DATA: begin
            awready = 1'b0;
            wready = 1'b1;
            if (wvalid) begin
               // Misc register area
               if (wr_addr < `ENTRY_BASE_REG) begin
                  bresp_nxt = AXI_RESP_OK;
                  case(wr_addr)
                     `BASE_ADDR_REG: begin
                        entry_addr_base_vld_nxt = 1;
                     end
                     `WRITE_ORDER_REG: begin
                        entry_wr_nxt = 1;
                     end
                     `MOD_WRITE_ORDER_REG: begin
                        entry_mod_wr_nxt = 1;
                     end
                     `READ_ORDER_REG: begin
                        entry_rd_nxt = 1;
                     end
                  endcase
               end
               // Flow table setting register area
               else if (wr_addr < (`ENTRY_BASE_REG + ENTRY_BUF_SIZE_WORD)) begin
                  bresp_nxt = AXI_RESP_OK;
                  entry_vld_nxt = 1;
                  entry_offset_nxt = wr_addr - entry_base;
               end
               else begin
                  bresp_nxt = AXI_RESP_SLVERR;
               end
               axi_wr_state_nxt = WRITE_RESPONSE;
            end
         end

         WRITE_RESPONSE: begin
            awready = 1'b0;
            bvalid = 1'b1;
            if (bready) begin
               axi_wr_state_nxt = WRITE_IDLE;
            end
         end
      endcase
   end

   always @(posedge aclk) begin
      if (~aresetn) begin
         axi_wr_state <= WRITE_IDLE;
         wr_addr <= 0;
         bresp <= AXI_RESP_OK;

         entry_addr_base_vld <= 0;
         entry_wr <= 0;
         entry_mod_wr <= 0;
         entry_rd <= 0;
         entry_vld <= 0;
         entry_offset <= 0;
      end
      else begin
         axi_wr_state <= axi_wr_state_nxt;
         wr_addr <= wr_addr_nxt;
         bresp <= bresp_nxt;

         entry_addr_base_vld <= entry_addr_base_vld_nxt;
         entry_wr <= entry_wr_nxt;
         entry_mod_wr <= entry_mod_wr_nxt;
         entry_rd <= entry_rd_nxt;
         entry_vld <= entry_vld_nxt;
         entry_offset <= entry_offset_nxt;
      end
   end

   always @(posedge aclk) begin
      if (~aresetn) begin
         wr_data <= 0;
      end
      else begin
         wr_data <= wdata;
      end
   end

   // Store Flow Table's base address
   always @(posedge aclk) begin
      if (~aresetn) begin
         flow_entry_addr <= 0;
      end
      else begin
         if (entry_addr_base_vld) begin
            flow_entry_addr <= wr_data[TBL_WIDTH-1:0];
         end
      end
   end

   // flow_entry_buf
   // Store one set of entry information for writing to the Flow Table
   always @(posedge aclk) begin
      if (~aresetn) begin
         for (i=0; i<ENTRY_BUF_SIZE_WORD; i=i+1) begin
            entry_buf_out_d1[i] <= 0;
         end
      end
      else begin
         if (entry_vld) begin
            entry_buf_out_d1[entry_offset] <= wr_data;
         end
         else if (entry_wr_ack) begin
            for (i=0; i<ENTRY_BUF_SIZE_WORD; i=i+1) begin
               entry_buf_out_d1[i] <= 0;
            end
         end
      end
   end

   // Clock transition
   always @(posedge asclk) begin
      if (~aresetn) begin
         for (j=0; j<ENTRY_BUF_SIZE_WORD; j=j+1) begin
            entry_buf_out_d2[j] <= 0;
            entry_buf_out[j] <= 0;
         end
      end
      else begin
         for (j=0; j<ENTRY_BUF_SIZE_WORD; j=j+1) begin
            entry_buf_out_d2[j] <= entry_buf_out_d1[j];
            entry_buf_out[j] <= entry_buf_out_d2[j];
         end
      end
   end

   // Flatten the entry information
   generate
      genvar a, b, c;
      for (a=0; a<OPENFLOW_MATCH_SIZE_WORD; a=a+1) begin: gen_match
         assign flow_entry_match_out[a*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH] =
                   entry_buf_out[a];
         assign flow_entry_mask_out[a*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH] =
                   entry_buf_out[a+ OPENFLOW_MATCH_SIZE_WORD];
      end
      for (b=0; b<OPENFLOW_ACTION_SIZE_WORD; b=b+1) begin: gen_action
         assign flow_entry_action_out[b*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH] =
                   entry_buf_out[b+ OPENFLOW_MATCH_SIZE_WORD*2];
      end
      for (c=0; c<OPENFLOW_STATS_SIZE_WORD; c=c+1) begin: gen_stats
         assign flow_entry_stats_out[c*C_S_AXI_DATA_WIDTH +: C_S_AXI_DATA_WIDTH] =
                   entry_buf_out[c + OPENFLOW_MATCH_SIZE_WORD*2 +
                                 OPENFLOW_ACTION_SIZE_WORD];
      end
   endgenerate

   //--- FLOW_TABLE_ACCESS (AXI lite CLK domain)
   always @(*) begin
      flow_table_acc_state_nxt = flow_table_acc_state;
      flow_entry_req_int_nxt = flow_entry_req_int;
      flow_entry_wr_int_nxt = flow_entry_wr_int;
      flow_entry_stats_en_int_nxt = flow_entry_stats_en_int;
      entry_wr_ack_nxt = 0;
      entry_rd_ack_nxt = 0;

      case(flow_table_acc_state)
         FTACC_WAIT_TRIG: begin
            if (entry_wr) begin
               flow_entry_req_int_nxt = 1;
               flow_entry_wr_int_nxt = 1;
               flow_entry_stats_en_int_nxt = 1; //overwrite stats
               flow_table_acc_state_nxt = FTACC_WAIT_WRITE_ACK;
            end
            else if (entry_mod_wr) begin
               flow_entry_req_int_nxt = 1;
               flow_entry_wr_int_nxt = 1;
               flow_entry_stats_en_int_nxt = 0; //preserve stats
               flow_table_acc_state_nxt = FTACC_WAIT_WRITE_ACK;
            end
            else if (entry_rd) begin
               flow_entry_req_int_nxt = 1;
               flow_entry_wr_int_nxt = 0;
               flow_entry_stats_en_int_nxt = 1;
               flow_table_acc_state_nxt = FTACC_WAIT_READ_ACK;
            end
            else begin
               flow_entry_req_int_nxt = 0;
            end
         end

         FTACC_WAIT_WRITE_ACK: begin
            if (flow_entry_done_int) begin
               flow_entry_req_int_nxt = 0;
               flow_table_acc_state_nxt = FTACC_WAIT_WRITE_ACK_CANCEL;
            end
         end

         FTACC_WAIT_READ_ACK: begin
            if (flow_entry_done_int) begin
               flow_entry_req_int_nxt = 0;
               flow_table_acc_state_nxt = FTACC_WAIT_READ_ACK_CANCEL;
            end
         end

         FTACC_WAIT_WRITE_ACK_CANCEL: begin
            if (~flow_entry_done_int) begin
               entry_wr_ack_nxt = 1;
               flow_table_acc_state_nxt = FTACC_WAIT_TRIG;
            end
         end

         FTACC_WAIT_READ_ACK_CANCEL: begin
            if (~flow_entry_done_int) begin
               entry_rd_ack_nxt = 1;
               flow_table_acc_state_nxt = FTACC_WAIT_TRIG;
            end
         end
      endcase
   end

   always @(posedge aclk) begin
      if (~aresetn) begin
         flow_table_acc_state <= FTACC_WAIT_TRIG;
         flow_entry_req_int <= 0;
         flow_entry_wr_int <= 0;
         flow_entry_stats_en_int <= 0;
         entry_wr_ack <= 0;
         entry_rd_ack <= 0;
      end
      else begin
         flow_table_acc_state <= flow_table_acc_state_nxt;
         flow_entry_req_int <= flow_entry_req_int_nxt;
         flow_entry_wr_int <= flow_entry_wr_int_nxt;
         flow_entry_stats_en_int <= flow_entry_stats_en_int_nxt;
         entry_wr_ack <= entry_wr_ack_nxt;
         entry_rd_ack <= entry_rd_ack_nxt;
      end
   end

   //--- FLOW_TABLE_ACCESS (AXI Stream CLK domain)
   always @(posedge asclk) begin
      if (~aresetn) begin
         flow_entry_req_int_1 <= 0;
         flow_entry_req_int_2 <= 0;
         flow_entry_wr_int_1 <= 0;
         flow_entry_wr_int_2 <= 0;
         flow_entry_stats_en_int_1 <= 0;
         flow_entry_stats_en_int_2 <= 0;
      end
      else begin
         flow_entry_req_int_1 <= flow_entry_req_int;
         flow_entry_req_int_2 <= flow_entry_req_int_1;
         flow_entry_wr_int_1 <= flow_entry_wr_int;
         flow_entry_wr_int_2 <= flow_entry_wr_int_1;
         flow_entry_stats_en_int_1 <= flow_entry_stats_en_int;
         flow_entry_stats_en_int_2 <= flow_entry_stats_en_int_1;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         flow_entry_req_int_3 <= 0;
         flow_entry_req <= 0;
         flow_entry_wr <= 0;
         flow_entry_stats_en <= 0;
         flow_entry_done_1 <= 0;
      end
      else begin
         flow_entry_req_int_3 <= flow_entry_req_int_2;
         flow_entry_wr <= flow_entry_wr_int_2;
         flow_entry_stats_en <= flow_entry_stats_en_int_2;

         if (flow_entry_ack) begin
            flow_entry_req <= 0;
         end
         else if (flow_entry_req_int_2 && (~flow_entry_req_int_3)) begin
            flow_entry_req <= 1;
         end

         if (flow_entry_done) begin
            flow_entry_done_1 <= 1;
         end
         else if (~flow_entry_req_int_2) begin
            flow_entry_done_1<= 0;
         end
      end
   end

   //--- FLOW_TABLE_ACCESS (AXI lite CLK domain)
   always @(posedge aclk) begin
      if (~aresetn) begin
         flow_entry_done_2 <= 0;
         flow_entry_done_int <= 0;
      end
      else begin
         flow_entry_done_2 <= flow_entry_done_1;
         flow_entry_done_int <= flow_entry_done_2;
      end
   end

   always @(posedge aclk) begin
      if (~aresetn) begin
         rd_acc_rdy <= 1;
         wr_acc_rdy <= 1;
      end
      else begin
         if (entry_wr || entry_mod_wr) begin
            wr_acc_rdy <= 0;
         end
         else if (entry_wr_ack) begin
            wr_acc_rdy <= 1;
         end
         if (entry_rd) begin
            rd_acc_rdy <= 0;
         end
         else if (entry_rd_ack) begin
            rd_acc_rdy <= 1;
         end
      end
   end
   assign acc_rdy = wr_acc_rdy && rd_acc_rdy;

   //--- AXI_READ (AXI Stream CLK domain)
   // flow_entry_buf
   // Latch and store one set of entry information from Flow Table
   always @(posedge asclk) begin
      if (~aresetn) begin
//         flow_entry_match_in_int <= 0;
//         flow_entry_action_in_int <= 0;
         flow_entry_stats_in_int <= 0;
      end
      else begin
         if (flow_entry_done && ~flow_entry_wr) begin
//            flow_entry_match_in_int <= flow_entry_match_in;
//            flow_entry_action_in_int <= flow_entry_action_in;
            flow_entry_stats_in_int <= flow_entry_stats_in;
         end
      end
   end

   // Split the Flow Table information
   generate
//      genvar d, e, f;
      genvar f;
//      for (d=0; d<OPENFLOW_MATCH_SIZE_WORD; d=d+1) begin: gen_match_in
//         assign entry_buf_in_d1[d] =
//                   flow_entry_match_in_int[d*C_S_AXI_DATA_WIDTH
//                      +: C_S_AXI_DATA_WIDTH];
//         assign entry_buf_in_d1[d + OPENFLOW_MATCH_SIZE_WORD] = 0;
//      end
//      for (e=0; e<OPENFLOW_ACTION_SIZE_WORD; e=e+1) begin: gen_action_in
//         assign entry_buf_in_d1[e + OPENFLOW_MATCH_SIZE_WORD*2] =
//                   flow_entry_action_in_int[e*C_S_AXI_DATA_WIDTH
//                      +: C_S_AXI_DATA_WIDTH];
//      end
      for (f=0; f<OPENFLOW_STATS_SIZE_WORD; f=f+1) begin: gen_stats_in
//         assign entry_buf_in_d1[f + OPENFLOW_MATCH_SIZE_WORD*2 +
//                             OPENFLOW_ACTION_SIZE_WORD] =
//                   flow_entry_stats_in_int[f*C_S_AXI_DATA_WIDTH
//                      +: C_S_AXI_DATA_WIDTH];
         assign entry_buf_in_d1[f] =
                   flow_entry_stats_in_int[f*C_S_AXI_DATA_WIDTH
                      +: C_S_AXI_DATA_WIDTH];
      end
   endgenerate


   //--- AXI_READ (AXI lite CLK domain)

   // Clock transition
   // flow table entries
   always @(posedge aclk) begin
      if (~aresetn) begin
//         for (k=0; k<ENTRY_BUF_SIZE_WORD; k=k+1) begin
         for (k=0; k<OPENFLOW_STATS_SIZE_WORD; k=k+1) begin
            entry_buf_in_d2[k] <= 0;
            entry_buf_in[k] <= 0;
         end
      end
      else begin
//         for (k=0; k<ENTRY_BUF_SIZE_WORD; k=k+1) begin
         for (k=0; k<OPENFLOW_STATS_SIZE_WORD; k=k+1) begin
            entry_buf_in_d2[k] <= entry_buf_in_d1[k];
            entry_buf_in[k] <= entry_buf_in_d1[k];
         end
      end
   end

   wire [7:0] entry_rd_base_addr = `ENTRY_BASE_REG + OPENFLOW_MATCH_SIZE_WORD*2 + OPENFLOW_ACTION_SIZE_WORD;

   always @(posedge aclk) begin
      if (~aresetn) begin
         entry_buf_in_int <= 0;
      end
      else begin
         if (rd_addr >= entry_rd_base_addr) begin
            entry_buf_in_int <= entry_buf_in[rd_addr - entry_rd_base_addr];
         end
         else begin
            entry_buf_in_int <= 0;
         end
      end
   end

   // other registers
   always @(posedge aclk) begin
      if (~aresetn) begin
         num_pkts_dropped_0_int <= 0;
         num_pkts_dropped_0_int_d1 <= 0;
         num_pkts_dropped_1_int <= 0;
         num_pkts_dropped_1_int_d1 <= 0;
         num_pkts_dropped_2_int <= 0;
         num_pkts_dropped_2_int_d1 <= 0;
         num_pkts_dropped_3_int <= 0;
         num_pkts_dropped_3_int_d1 <= 0;
         num_pkts_dropped_4_int <= 0;
         num_pkts_dropped_4_int_d1 <= 0;
         exact_hit_int <= 0;
         exact_hit_int_d1 <= 0;
         exact_miss_int <= 0;
         exact_miss_int_d1 <= 0;
         wildcard_hit_int <= 0;
         wildcard_hit_int_d1 <= 0;
         wildcard_miss_int <= 0;
         wildcard_miss_int_d1 <= 0;
         dl_parse_cnt_0_int <= 0;
         dl_parse_cnt_0_int_d1 <= 0;
         dl_parse_cnt_1_int <= 0;
         dl_parse_cnt_1_int_d1 <= 0;
         dl_parse_cnt_2_int <= 0;
         dl_parse_cnt_2_int_d1 <= 0;
         dl_parse_cnt_3_int <= 0;
         dl_parse_cnt_3_int_d1 <= 0;
         dl_parse_cnt_4_int <= 0;
         dl_parse_cnt_4_int_d1 <= 0;
         mpls_parse_cnt_0_int <= 0;
         mpls_parse_cnt_0_int_d1 <= 0;
         mpls_parse_cnt_1_int <= 0;
         mpls_parse_cnt_1_int_d1 <= 0;
         mpls_parse_cnt_2_int <= 0;
         mpls_parse_cnt_2_int_d1 <= 0;
         mpls_parse_cnt_3_int <= 0;
         mpls_parse_cnt_3_int_d1 <= 0;
         mpls_parse_cnt_4_int <= 0;
         mpls_parse_cnt_4_int_d1 <= 0;
         arp_parse_cnt_0_int <= 0;
         arp_parse_cnt_0_int_d1 <= 0;
         arp_parse_cnt_1_int <= 0;
         arp_parse_cnt_1_int_d1 <= 0;
         arp_parse_cnt_2_int <= 0;
         arp_parse_cnt_2_int_d1 <= 0;
         arp_parse_cnt_3_int <= 0;
         arp_parse_cnt_3_int_d1 <= 0;
         arp_parse_cnt_4_int <= 0;
         arp_parse_cnt_4_int_d1 <= 0;
         ip_tp_parse_cnt_0_int <= 0;
         ip_tp_parse_cnt_0_int_d1 <= 0;
         ip_tp_parse_cnt_1_int <= 0;
         ip_tp_parse_cnt_1_int_d1 <= 0;
         ip_tp_parse_cnt_2_int <= 0;
         ip_tp_parse_cnt_2_int_d1 <= 0;
         ip_tp_parse_cnt_3_int <= 0;
         ip_tp_parse_cnt_3_int_d1 <= 0;
         ip_tp_parse_cnt_4_int <= 0;
         ip_tp_parse_cnt_4_int_d1 <= 0;
      end
      else begin
         num_pkts_dropped_0_int_d1 <= num_pkts_dropped_0;
         num_pkts_dropped_0_int <= num_pkts_dropped_0_int_d1;
         num_pkts_dropped_1_int_d1 <= num_pkts_dropped_1;
         num_pkts_dropped_1_int <= num_pkts_dropped_1_int_d1;
         num_pkts_dropped_2_int_d1 <= num_pkts_dropped_2;
         num_pkts_dropped_2_int <= num_pkts_dropped_2_int_d1;
         num_pkts_dropped_3_int_d1 <= num_pkts_dropped_3;
         num_pkts_dropped_3_int <= num_pkts_dropped_3_int_d1;
         num_pkts_dropped_4_int_d1 <= num_pkts_dropped_4;
         num_pkts_dropped_4_int <= num_pkts_dropped_4_int_d1;
         exact_hit_int_d1 <= exact_hit;
         exact_hit_int <= exact_hit_int_d1;
         exact_miss_int_d1 <= exact_miss;
         exact_miss_int <= exact_miss_int_d1;
         wildcard_hit_int_d1 <= wildcard_hit;
         wildcard_hit_int <= wildcard_hit_int_d1;
         wildcard_miss_int_d1 <= wildcard_miss;
         wildcard_miss_int <= wildcard_miss_int_d1;
         dl_parse_cnt_0_int_d1 <= dl_parse_cnt_0;
         dl_parse_cnt_0_int <= dl_parse_cnt_0_int_d1;
         dl_parse_cnt_1_int_d1 <= dl_parse_cnt_1;
         dl_parse_cnt_1_int <= dl_parse_cnt_1_int_d1;
         dl_parse_cnt_2_int_d1 <= dl_parse_cnt_2;
         dl_parse_cnt_2_int <= dl_parse_cnt_2_int_d1;
         dl_parse_cnt_3_int_d1 <= dl_parse_cnt_3;
         dl_parse_cnt_3_int <= dl_parse_cnt_3_int_d1;
         dl_parse_cnt_4_int_d1 <= dl_parse_cnt_4;
         dl_parse_cnt_4_int <= dl_parse_cnt_4_int_d1;
         mpls_parse_cnt_0_int_d1 <= mpls_parse_cnt_0;
         mpls_parse_cnt_0_int <= mpls_parse_cnt_0_int_d1;
         mpls_parse_cnt_1_int_d1 <= mpls_parse_cnt_1;
         mpls_parse_cnt_1_int <= mpls_parse_cnt_1_int_d1;
         mpls_parse_cnt_2_int_d1 <= mpls_parse_cnt_2;
         mpls_parse_cnt_2_int <= mpls_parse_cnt_2_int_d1;
         mpls_parse_cnt_3_int_d1 <= mpls_parse_cnt_3;
         mpls_parse_cnt_3_int <= mpls_parse_cnt_3_int_d1;
         mpls_parse_cnt_4_int_d1 <= mpls_parse_cnt_4;
         mpls_parse_cnt_4_int <= mpls_parse_cnt_4_int_d1;
         arp_parse_cnt_0_int_d1 <= arp_parse_cnt_0;
         arp_parse_cnt_0_int <= arp_parse_cnt_0_int_d1;
         arp_parse_cnt_1_int_d1 <= arp_parse_cnt_1;
         arp_parse_cnt_1_int <= arp_parse_cnt_1_int_d1;
         arp_parse_cnt_2_int_d1 <= arp_parse_cnt_2;
         arp_parse_cnt_2_int <= arp_parse_cnt_2_int_d1;
         arp_parse_cnt_3_int_d1 <= arp_parse_cnt_3;
         arp_parse_cnt_3_int <= arp_parse_cnt_3_int_d1;
         arp_parse_cnt_4_int_d1 <= arp_parse_cnt_4;
         arp_parse_cnt_4_int <= arp_parse_cnt_4_int_d1;
         ip_tp_parse_cnt_0_int_d1 <= ip_tp_parse_cnt_0;
         ip_tp_parse_cnt_0_int <= ip_tp_parse_cnt_0_int_d1;
         ip_tp_parse_cnt_1_int_d1 <= ip_tp_parse_cnt_1;
         ip_tp_parse_cnt_1_int <= ip_tp_parse_cnt_1_int_d1;
         ip_tp_parse_cnt_2_int_d1 <= ip_tp_parse_cnt_2;
         ip_tp_parse_cnt_2_int <= ip_tp_parse_cnt_2_int_d1;
         ip_tp_parse_cnt_3_int_d1 <= ip_tp_parse_cnt_3;
         ip_tp_parse_cnt_3_int <= ip_tp_parse_cnt_3_int_d1;
         ip_tp_parse_cnt_4_int_d1 <= ip_tp_parse_cnt_4;
         ip_tp_parse_cnt_4_int <= ip_tp_parse_cnt_4_int_d1;
      end
   end

   always @(*) begin
      axi_rd_state_nxt = axi_rd_state;
      rd_addr_nxt = rd_addr;
      arready = 1'b1;
      rdata = 0;
      rresp = AXI_RESP_OK;
      rvalid = 1'b0;

      case(axi_rd_state)
         READ_IDLE: begin
            if (arvalid) begin
               rd_addr_nxt = araddr[LOCAL_ADDR_DEPTH-1:0];
               axi_rd_state_nxt = READ_WAIT;
            end
         end

         READ_WAIT: begin
            arready = 1'b0;
            axi_rd_state_nxt = READ_RESPONSE;
         end

         READ_RESPONSE: begin
            arready = 1'b0;
            rvalid = 1'b1;
            // Misc register area
            if (rd_addr < `ENTRY_BASE_REG) begin
               case(rd_addr)
                  `NUM_PKTS_DROPPED_0_REG: begin
                     rdata = num_pkts_dropped_0_int;
                  end
                  `NUM_PKTS_DROPPED_1_REG: begin
                     rdata = num_pkts_dropped_1_int;
                  end
                  `NUM_PKTS_DROPPED_2_REG: begin
                     rdata = num_pkts_dropped_2_int;
                  end
                  `NUM_PKTS_DROPPED_3_REG: begin
                     rdata = num_pkts_dropped_3_int;
                  end
                  `NUM_PKTS_DROPPED_4_REG: begin
                     rdata = num_pkts_dropped_4_int;
                  end
                  `EXACT_HITS_REG: begin
                     rdata = exact_hit_int;
                  end
                  `EXACT_MISSES_REG: begin
                     rdata = exact_miss_int;
                  end
                  `WILDCARD_HITS_REG: begin
                     rdata = wildcard_hit_int;
                  end
                  `WILDCARD_MISSES_REG: begin
                     rdata = wildcard_miss_int;
                  end
                  `ACC_RDY_REG: begin
                     rdata = acc_rdy;
                  end
                  `DL_PARSE_CNT_0_REG: begin
                     rdata = dl_parse_cnt_0_int;
                  end
                  `DL_PARSE_CNT_1_REG: begin
                     rdata = dl_parse_cnt_1_int;
                  end
                  `DL_PARSE_CNT_2_REG: begin
                     rdata = dl_parse_cnt_2_int;
                  end
                  `DL_PARSE_CNT_3_REG: begin
                     rdata = dl_parse_cnt_3_int;
                  end
                  `DL_PARSE_CNT_4_REG: begin
                     rdata = dl_parse_cnt_4_int;
                  end
                  `ACT_NUM_PROC_DONE_0_REG: begin
                     rdata = act_num_pkts_processed_0;
                  end
                  `ACT_NUM_PROC_DONE_1_REG: begin
                     rdata = act_num_pkts_processed_1;
                  end
                  `ACT_NUM_PROC_DONE_2_REG: begin
                     rdata = act_num_pkts_processed_2;
                  end
                  `ACT_NUM_PROC_DONE_3_REG: begin
                     rdata = act_num_pkts_processed_3;
                  end
                  `ACT_NUM_PROC_DONE_4_REG: begin
                     rdata = act_num_pkts_processed_4;
                  end
                  //`MPLS_PARSE_CNT_0_REG: begin
                  //   rdata = mpls_parse_cnt_0_int;
                  //end
                  //`MPLS_PARSE_CNT_1_REG: begin
                  //   rdata = mpls_parse_cnt_1_int;
                  //end
                  //`MPLS_PARSE_CNT_2_REG: begin
                  //   rdata = mpls_parse_cnt_2_int;
                  //end
                  //`MPLS_PARSE_CNT_3_REG: begin
                  //   rdata = mpls_parse_cnt_3_int;
                  //end
                  //`MPLS_PARSE_CNT_4_REG: begin
                  //  rdata = mpls_parse_cnt_4_int;
                  //end
                  //`MPLS_PARSE_CNT_0_REG: begin
                  //   rdata = mpls_parse_cnt_0_int;
                  //end
                  `ARP_PARSE_CNT_0_REG: begin
                     rdata = arp_parse_cnt_0_int;
                  end
                  `ARP_PARSE_CNT_1_REG: begin
                     rdata = arp_parse_cnt_1_int;
                  end
                  `ARP_PARSE_CNT_2_REG: begin
                     rdata = arp_parse_cnt_2_int;
                  end
                  `ARP_PARSE_CNT_3_REG: begin
                     rdata = arp_parse_cnt_3_int;
                  end
                  `ARP_PARSE_CNT_4_REG: begin
                     rdata = arp_parse_cnt_4_int;
                  end
                  `IP_TP_PARSE_CNT_0_REG: begin
                     rdata = ip_tp_parse_cnt_0_int;
                  end
                  `IP_TP_PARSE_CNT_1_REG: begin
                     rdata = ip_tp_parse_cnt_1_int;
                  end
                  `IP_TP_PARSE_CNT_2_REG: begin
                     rdata = ip_tp_parse_cnt_2_int;
                  end
                  `IP_TP_PARSE_CNT_3_REG: begin
                     rdata = ip_tp_parse_cnt_3_int;
                  end
                  `IP_TP_PARSE_CNT_4_REG: begin
                     rdata = ip_tp_parse_cnt_4_int;
                  end
                  `BASE_ADDR_REG: begin
                     rdata = {16'h0, flow_entry_addr};
                  end
                  default: begin
                     rdata = 32'hCAFE_BEEF;
                  end
               endcase
            end
            // Flow table setting register area
            else if (rd_addr < (`ENTRY_BASE_REG + ENTRY_BUF_SIZE_WORD)) begin
               rdata = entry_buf_in_int;
            end
            else begin
               rdata = 32'hBEEF_CAFE;
            end
            if (rready) begin
               axi_rd_state_nxt = READ_IDLE;
            end
         end
      endcase
   end

   always @(posedge aclk) begin
      if (~aresetn) begin
         axi_rd_state <= READ_IDLE;
         rd_addr <= 0;
      end
      else begin
         axi_rd_state <= axi_rd_state_nxt;
         rd_addr <= rd_addr_nxt;
      end
   end

endmodule
