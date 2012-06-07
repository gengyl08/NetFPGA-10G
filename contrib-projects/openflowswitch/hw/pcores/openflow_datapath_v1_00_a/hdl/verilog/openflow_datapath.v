/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        openflow_datapath.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        This module is the top level module and is used as
 *        openflow_datapath pcore
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

module openflow_datapath
#(
   // AXI Stream Data Width
   parameter C_AXIS_DATA_WIDTH=64,
   parameter C_AXIS_TUSER_WIDTH=128,
   parameter C_AXIS_LEN_DATA_WIDTH=16,
   parameter C_AXIS_SPT_DATA_WIDTH=8,
   parameter C_AXIS_DPT_DATA_WIDTH=8,
   // AXI Lite
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
   // Global Ports
   input asclk, // AXI stream
   input aclk, // AXI lite
   input aresetn,

   // Slave AXI Stream Ports #0
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata_0,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb_0,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser_0,
   input  s_axis_tvalid_0,
   input  s_axis_tlast_0,
   output s_axis_tready_0,

   // Slave AXI Stream Ports #1
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata_1,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb_1,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser_1,
   input  s_axis_tvalid_1,
   input  s_axis_tlast_1,
   output s_axis_tready_1,

   // Slave AXI Stream Ports #2
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata_2,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb_2,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser_2,
   input  s_axis_tvalid_2,
   input  s_axis_tlast_2,
   output s_axis_tready_2,

   // Slave AXI Stream Ports #3
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata_3,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb_3,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser_3,
   input  s_axis_tvalid_3,
   input  s_axis_tlast_3,
   output s_axis_tready_3,

   // Slave AXI Stream Ports #4
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata_4,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb_4,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser_4,
   input  s_axis_tvalid_4,
   input  s_axis_tlast_4,
   output s_axis_tready_4,

   // AXI lite ports
   input  [C_S_AXI_ADDR_WIDTH-1:0] awaddr,
   input  awvalid,
   output awready,

   input  [C_S_AXI_DATA_WIDTH-1:0]   wdata,
   input  [C_S_AXI_DATA_WIDTH/8-1:0] wstrb,
   input  wvalid,
   output wready,

   output [1:0] bresp,
   output bvalid,
   input  bready,

   input  [C_S_AXI_ADDR_WIDTH-1:0] araddr,
   input  arvalid,
   output arready,

   output [C_S_AXI_DATA_WIDTH-1:0] rdata,
   output [1:0] rresp,
   output rvalid,
   input  rready,

   // Master AXI Stream Ports #0
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata_0,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb_0,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_0,
   output m_axis_tvalid_0,
   output m_axis_tlast_0,
   input  m_axis_tready_0,

   // Master AXI Stream Ports #1
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata_1,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb_1,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_1,
   output m_axis_tvalid_1,
   output m_axis_tlast_1,
   input  m_axis_tready_1,

   // Master AXI Stream Ports #2
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata_2,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb_2,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_2,
   output m_axis_tvalid_2,
   output m_axis_tlast_2,
   input  m_axis_tready_2,

   // Master AXI Stream Ports #3
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata_3,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb_3,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_3,
   output m_axis_tvalid_3,
   output m_axis_tlast_3,
   input  m_axis_tready_3,

   // Master AXI Stream Ports #4
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata_4,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb_4,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_4,
   output m_axis_tvalid_4,
   output m_axis_tlast_4,
   input  m_axis_tready_4
);

   //------------------------ Wires/Regs -----------------------------

   wire [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata [4:0];
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb [4:0];
   wire [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser [4:0];
   wire [4:0] s_axis_tvalid;
   wire [4:0] s_axis_tlast;
   wire [4:0] s_axis_tready;

   wire [4:0] lu_req;
   wire [OPENFLOW_MATCH_SIZE-1:0] lu_entry [4:0];
   wire [C_AXIS_LEN_DATA_WIDTH-1:0] lu_len [4:0];
   wire [4:0] lu_ack;
   wire [OPENFLOW_ACTION_SIZE-1:0] lu_action;
   wire [4:0] lu_done;

   wire [31:0] ah_num_pkts_processed[4:0];
   wire [C_AXIS_DATA_WIDTH-1:0] ap_axis_tdata [4:0];
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] ap_axis_tstrb [4:0];
   wire [C_AXIS_TUSER_WIDTH-1:0] ap_axis_tuser [4:0];
   wire [4:0] ap_axis_tvalid;
   wire [4:0] ap_axis_tlast;
   wire [4:0] ap_axis_tready;

   wire [C_S_AXI_DATA_WIDTH-1:0] dl_parse_cnt [4:0];
   wire [C_S_AXI_DATA_WIDTH-1:0] mpls_parse_cnt [4:0];
   wire [C_S_AXI_DATA_WIDTH-1:0] arp_parse_cnt [4:0];
   wire [C_S_AXI_DATA_WIDTH-1:0] ip_tp_parse_cnt [4:0];

   wire [TBL_WIDTH-1:0] hi_flow_entry_addr;
   wire [OPENFLOW_MATCH_SIZE-1:0] hi_flow_entry_match_out;
   wire [OPENFLOW_MATCH_SIZE-1:0] hi_flow_entry_mask_out;
   wire [OPENFLOW_ACTION_SIZE-1:0] hi_flow_entry_action_out;
   wire [OPENFLOW_STATS_SIZE-1:0] hi_flow_entry_stats_out;
   wire [OPENFLOW_MATCH_SIZE-1:0] hi_flow_entry_match_in;
   wire [OPENFLOW_ACTION_SIZE-1:0] hi_flow_entry_action_in;
   wire [OPENFLOW_STATS_SIZE-1:0] hi_flow_entry_stats_in;
   wire hi_flow_entry_wr;
   wire hi_flow_entry_stats_en;
   wire hi_flow_entry_req;
   wire hi_flow_entry_ack;
   wire hi_flow_entry_done;

   wire [`OPENFLOW_LAST_SEEN_WIDTH-1:0] openflow_timer;

   wire [C_S_AXI_DATA_WIDTH-1:0] num_pkts_dropped [4:0];
   wire [C_S_AXI_DATA_WIDTH-1:0] exact_hit;
   wire [C_S_AXI_DATA_WIDTH-1:0] exact_miss;
   wire [C_S_AXI_DATA_WIDTH-1:0] wildcard_hit;
   wire [C_S_AXI_DATA_WIDTH-1:0] wildcard_miss;

   wire [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata [4:0];
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb [4:0];
   wire [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser [4:0];
   wire [4:0] m_axis_tvalid;
   wire [4:0] m_axis_tlast;
   wire [4:0] m_axis_tready;

   //------------------------ Assigns -----------------------------

   assign s_axis_tdata[0] = s_axis_tdata_0;
   assign s_axis_tdata[1] = s_axis_tdata_1;
   assign s_axis_tdata[2] = s_axis_tdata_2;
   assign s_axis_tdata[3] = s_axis_tdata_3;
   assign s_axis_tdata[4] = s_axis_tdata_4;
   assign s_axis_tstrb[0] = s_axis_tstrb_0;
   assign s_axis_tstrb[1] = s_axis_tstrb_1;
   assign s_axis_tstrb[2] = s_axis_tstrb_2;
   assign s_axis_tstrb[3] = s_axis_tstrb_3;
   assign s_axis_tstrb[4] = s_axis_tstrb_4;
   assign s_axis_tvalid[0] = s_axis_tvalid_0;
   assign s_axis_tvalid[1] = s_axis_tvalid_1;
   assign s_axis_tvalid[2] = s_axis_tvalid_2;
   assign s_axis_tvalid[3] = s_axis_tvalid_3;
   assign s_axis_tvalid[4] = s_axis_tvalid_4;
   assign s_axis_tlast[0] = s_axis_tlast_0;
   assign s_axis_tlast[1] = s_axis_tlast_1;
   assign s_axis_tlast[2] = s_axis_tlast_2;
   assign s_axis_tlast[3] = s_axis_tlast_3;
   assign s_axis_tlast[4] = s_axis_tlast_4;
   assign s_axis_tuser[0] = s_axis_tuser_0;
   assign s_axis_tuser[1] = s_axis_tuser_1;
   assign s_axis_tuser[2] = s_axis_tuser_2;
   assign s_axis_tuser[3] = s_axis_tuser_3;
   assign s_axis_tuser[4] = s_axis_tuser_4;
   assign s_axis_tready_0 = s_axis_tready[0];
   assign s_axis_tready_1 = s_axis_tready[1];
   assign s_axis_tready_2 = s_axis_tready[2];
   assign s_axis_tready_3 = s_axis_tready[3];
   assign s_axis_tready_4 = s_axis_tready[4];

   assign m_axis_tdata_0 = m_axis_tdata[0];
   assign m_axis_tdata_1 = m_axis_tdata[1];
   assign m_axis_tdata_2 = m_axis_tdata[2];
   assign m_axis_tdata_3 = m_axis_tdata[3];
   assign m_axis_tdata_4 = m_axis_tdata[4];
   assign m_axis_tstrb_0 = m_axis_tstrb[0];
   assign m_axis_tstrb_1 = m_axis_tstrb[1];
   assign m_axis_tstrb_2 = m_axis_tstrb[2];
   assign m_axis_tstrb_3 = m_axis_tstrb[3];
   assign m_axis_tstrb_4 = m_axis_tstrb[4];
   assign m_axis_tvalid_0 = m_axis_tvalid[0];
   assign m_axis_tvalid_1 = m_axis_tvalid[1];
   assign m_axis_tvalid_2 = m_axis_tvalid[2];
   assign m_axis_tvalid_3 = m_axis_tvalid[3];
   assign m_axis_tvalid_4 = m_axis_tvalid[4];
   assign m_axis_tlast_0 = m_axis_tlast[0];
   assign m_axis_tlast_1 = m_axis_tlast[1];
   assign m_axis_tlast_2 = m_axis_tlast[2];
   assign m_axis_tlast_3 = m_axis_tlast[3];
   assign m_axis_tlast_4 = m_axis_tlast[4];
   assign m_axis_tuser_0 = m_axis_tuser[0];
   assign m_axis_tuser_1 = m_axis_tuser[1];
   assign m_axis_tuser_2 = m_axis_tuser[2];
   assign m_axis_tuser_3 = m_axis_tuser[3];
   assign m_axis_tuser_4 = m_axis_tuser[4];
   assign m_axis_tready[0] = m_axis_tready_0;
   assign m_axis_tready[1] = m_axis_tready_1;
   assign m_axis_tready[2] = m_axis_tready_2;
   assign m_axis_tready[3] = m_axis_tready_3;
   assign m_axis_tready[4] = m_axis_tready_4;

   //------------------------ Modules -----------------------------

   generate
      genvar i;
      for (i=0; i<5; i=i+1) begin: pkt_preprocessor_group
         pkt_preprocessor #(
            // AXI Stream Data Width
            .C_AXIS_DATA_WIDTH(C_AXIS_DATA_WIDTH),
            .C_AXIS_TUSER_WIDTH(C_AXIS_TUSER_WIDTH),
            .C_AXIS_LEN_DATA_WIDTH(C_AXIS_LEN_DATA_WIDTH),
            .C_AXIS_SPT_DATA_WIDTH(C_AXIS_SPT_DATA_WIDTH),
            .C_AXIS_DPT_DATA_WIDTH(C_AXIS_DPT_DATA_WIDTH),
            // Flow entry size
            .OPENFLOW_MATCH_SIZE(OPENFLOW_MATCH_SIZE),
            // Register size
            .DATA_WIDTH(C_S_AXI_DATA_WIDTH)
         )
         pkt_preprocessor
           (// generic
            .asclk(asclk),
            .aresetn(aresetn),
            // Slave AXI Stream Ports
            .s_axis_tdata(s_axis_tdata[i]),
            .s_axis_tstrb(s_axis_tstrb[i]),
            .s_axis_tuser(s_axis_tuser[i]),
            .s_axis_tvalid(s_axis_tvalid[i]),
            .s_axis_tlast(s_axis_tlast[i]),
            .s_axis_tready(s_axis_tready[i]),
            // Flow table inquiry
            .lu_req(lu_req[i]),
            .lu_entry(lu_entry[i]),
            .lu_len(lu_len[i]),
            .lu_ack(lu_ack[i]),
            // Master AXI Stream Ports
            .m_axis_tdata(ap_axis_tdata[i]),
            .m_axis_tstrb(ap_axis_tstrb[i]),
            .m_axis_tuser(ap_axis_tuser[i]),
            .m_axis_tvalid(ap_axis_tvalid[i]),
            .m_axis_tlast(ap_axis_tlast[i]),
            .m_axis_tready(ap_axis_tready[i]),
            // Interface to host_inf
            .dl_parse_cnt(dl_parse_cnt[i]),
            .mpls_parse_cnt(mpls_parse_cnt[i]),
            .arp_parse_cnt(arp_parse_cnt[i]),
            .ip_tp_parse_cnt(ip_tp_parse_cnt[i]),
            //TODO To process below in this module
            .pkt_buf_drop()
            );
      end // block: pkt_preprocessor_group
   endgenerate

   generate
      genvar j;
      for (j=0; j<5; j=j+1) begin: action_processor_group
         action_processor #(
            // AXI Stream Data Width
            .C_AXIS_DATA_WIDTH(C_AXIS_DATA_WIDTH),
            .C_AXIS_TUSER_WIDTH(C_AXIS_TUSER_WIDTH),
            .C_AXIS_LEN_DATA_WIDTH(C_AXIS_LEN_DATA_WIDTH),
            .C_AXIS_SPT_DATA_WIDTH(C_AXIS_SPT_DATA_WIDTH),
            .C_AXIS_DPT_DATA_WIDTH(C_AXIS_DPT_DATA_WIDTH),
            .OPENFLOW_ACTION_SIZE(OPENFLOW_ACTION_SIZE)
         )
         action_processor
           (// generic
            .asclk(asclk),
            .aresetn(aresetn),
            .num_pkts_processed(ah_num_pkts_processed[j]),
            // Slave AXI Stream Ports
            .s_axis_tdata(ap_axis_tdata[j]),
            .s_axis_tstrb(ap_axis_tstrb[j]),
            .s_axis_tuser(ap_axis_tuser[j]),
            .s_axis_tvalid(ap_axis_tvalid[j]),
            .s_axis_tlast(ap_axis_tlast[j]),
            .s_axis_tready(ap_axis_tready[j]),
            // Interface with flow table
            .lu_action(lu_action),
            .lu_req(lu_req[j]),
            .lu_done(lu_done[j]),
            // Master AXI Stream Ports
            .m_axis_tdata(m_axis_tdata[j]),
            .m_axis_tstrb(m_axis_tstrb[j]),
            .m_axis_tuser(m_axis_tuser[j]),
            .m_axis_tvalid(m_axis_tvalid[j]),
            .m_axis_tlast(m_axis_tlast[j]),
            .m_axis_tready(m_axis_tready[j])
            );
      end // block: pkt_preprocessor_group
   endgenerate

   host_inf #(
      // AXI Lite Data/Addr Width
      .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
      .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
      .C_S_AXI_BASEADDR(C_S_AXI_BASEADDR),
      .C_S_AXI_HIGHADDR(C_S_AXI_HIGHADDR),
      // Parameters for Flow Table interface
      .TBL_WIDTH(16),
      .OPENFLOW_MATCH_SIZE(OPENFLOW_MATCH_SIZE),
      .OPENFLOW_ACTION_SIZE(OPENFLOW_ACTION_SIZE),
      .OPENFLOW_STATS_SIZE(OPENFLOW_STATS_SIZE)
   ) host_inf
   (// generic
      .aclk(aclk),
      .asclk(asclk),
      .aresetn(aresetn),
      // AXI lite ports (AXI lite CLK domain)
      .awaddr(awaddr),
      .awvalid(awvalid),
      .awready(awready),
      .wdata(wdata),
      .wstrb(wstrb),
      .wvalid(wvalid),
      .wready(wready),
      .bresp(bresp),
      .bvalid(bvalid),
      .bready(bready),
      .araddr(araddr),
      .arvalid(arvalid),
      .arready(arready),
      .rdata(rdata),
      .rresp(rresp),
      .rvalid(rvalid),
      .rready(rready),
      // Flow table interface ports (AXI Stream CLK domain)
      .flow_entry_addr(hi_flow_entry_addr),
      .flow_entry_match_out(hi_flow_entry_match_out),
      .flow_entry_mask_out(hi_flow_entry_mask_out),
      .flow_entry_action_out(hi_flow_entry_action_out),
      .flow_entry_stats_out(hi_flow_entry_stats_out),
//      .flow_entry_match_in(hi_flow_entry_match_in),
//      .flow_entry_action_in(hi_flow_entry_action_in),
      .flow_entry_stats_in(hi_flow_entry_stats_in),
      .flow_entry_wr(hi_flow_entry_wr),
      .flow_entry_stats_en(hi_flow_entry_stats_en),
      .flow_entry_req(hi_flow_entry_req),
      .flow_entry_ack(hi_flow_entry_ack),
      .flow_entry_done(hi_flow_entry_done),
      .num_pkts_dropped_0(num_pkts_dropped[0]),
      .num_pkts_dropped_1(num_pkts_dropped[1]),
      .num_pkts_dropped_2(num_pkts_dropped[2]),
      .num_pkts_dropped_3(num_pkts_dropped[3]),
      .num_pkts_dropped_4(num_pkts_dropped[4]),
      .exact_hit(exact_hit),
      .exact_miss(exact_miss),
      .wildcard_hit(wildcard_hit),
      .wildcard_miss(wildcard_miss),
      .act_num_pkts_processed_0(ah_num_pkts_processed[0]),
      .act_num_pkts_processed_1(ah_num_pkts_processed[1]),
      .act_num_pkts_processed_2(ah_num_pkts_processed[2]),
      .act_num_pkts_processed_3(ah_num_pkts_processed[3]),
      .act_num_pkts_processed_4(ah_num_pkts_processed[4]),
      .dl_parse_cnt_0(dl_parse_cnt[0]),
      .dl_parse_cnt_1(dl_parse_cnt[1]),
      .dl_parse_cnt_2(dl_parse_cnt[2]),
      .dl_parse_cnt_3(dl_parse_cnt[3]),
      .dl_parse_cnt_4(dl_parse_cnt[4]),
      .mpls_parse_cnt_0(mpls_parse_cnt[0]),
      .mpls_parse_cnt_1(mpls_parse_cnt[1]),
      .mpls_parse_cnt_2(mpls_parse_cnt[2]),
      .mpls_parse_cnt_3(mpls_parse_cnt[3]),
      .mpls_parse_cnt_4(mpls_parse_cnt[4]),
      .arp_parse_cnt_0(arp_parse_cnt[0]),
      .arp_parse_cnt_1(arp_parse_cnt[1]),
      .arp_parse_cnt_2(arp_parse_cnt[2]),
      .arp_parse_cnt_3(arp_parse_cnt[3]),
      .arp_parse_cnt_4(arp_parse_cnt[4]),
      .ip_tp_parse_cnt_0(ip_tp_parse_cnt[0]),
      .ip_tp_parse_cnt_1(ip_tp_parse_cnt[1]),
      .ip_tp_parse_cnt_2(ip_tp_parse_cnt[2]),
      .ip_tp_parse_cnt_3(ip_tp_parse_cnt[3]),
      .ip_tp_parse_cnt_4(ip_tp_parse_cnt[4])
   );

   s_counter #(
      // AXI Stream CLK frequency
      .CLOCK_CYCLE_MHZ(160)
   ) s_counter
   (
      .asclk(asclk),
      .aresetn(aresetn),
      .s_counter(openflow_timer),
      .ms_counter(),
      .us_counter()
   );

   flow_tbl_ctrl #(
      // Parameters for Flow Table interface
      .TBL_WIDTH(16),
      .OPENFLOW_MATCH_SIZE(OPENFLOW_MATCH_SIZE),
      .OPENFLOW_ACTION_SIZE(OPENFLOW_ACTION_SIZE),
      .OPENFLOW_STATS_SIZE(OPENFLOW_STATS_SIZE),
      // AXI Lite Data Width
      .DATA_WIDTH(C_S_AXI_DATA_WIDTH)
   ) flow_tbl_ctrl
   (// generic
      .asclk(asclk),
      .aresetn(aresetn),
      // Interface with ports
      // (pkt_preprocessors and action_processors)
      .p0_match(lu_entry[0]),
      .p0_stats(lu_len[0]),
      .p0_req(lu_req[0]),
      .p0_ack(lu_ack[0]),
      .p0_done(lu_done[0]),
      .p1_match(lu_entry[1]),
      .p1_stats(lu_len[1]),
      .p1_req(lu_req[1]),
      .p1_ack(lu_ack[1]),
      .p1_done(lu_done[1]),
      .p2_match(lu_entry[2]),
      .p2_stats(lu_len[2]),
      .p2_req(lu_req[2]),
      .p2_ack(lu_ack[2]),
      .p2_done(lu_done[2]),
      .p3_match(lu_entry[3]),
      .p3_stats(lu_len[3]),
      .p3_req(lu_req[3]),
      .p3_ack(lu_ack[3]),
      .p3_done(lu_done[3]),
      .p4_match(lu_entry[4]),
      .p4_stats(lu_len[4]),
      .p4_req(lu_req[4]),
      .p4_ack(lu_ack[4]),
      .p4_done(lu_done[4]),
      .action_out(lu_action),
      // Interface with host_inf
      .host_addr(hi_flow_entry_addr),
      .host_match_in(hi_flow_entry_match_out),
      .host_mask_in(hi_flow_entry_mask_out),
      .host_action_in(hi_flow_entry_action_out),
      .host_stats_in(hi_flow_entry_stats_out),
      .host_match_out(),
      .host_action_out(),
      .host_stats_out(hi_flow_entry_stats_in),
      .host_wr(hi_flow_entry_wr),
      .host_stats_en(hi_flow_entry_stats_en),
      .host_req(hi_flow_entry_req),
      .host_ack(hi_flow_entry_ack),
      .host_done(hi_flow_entry_done),
      .num_pkts_dropped_0(num_pkts_dropped[0]),
      .num_pkts_dropped_1(num_pkts_dropped[1]),
      .num_pkts_dropped_2(num_pkts_dropped[2]),
      .num_pkts_dropped_3(num_pkts_dropped[3]),
      .num_pkts_dropped_4(num_pkts_dropped[4]),
      .exact_hit(exact_hit),
      .exact_miss(exact_miss),
      .wildcard_hit(wildcard_hit),
      .wildcard_miss(wildcard_miss),

      .openflow_timer(openflow_timer)
   );

endmodule
