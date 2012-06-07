/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        flow_table_controller.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *          Interface among lookup modules, host interface and
 *          action processor modules.
 *          It recieves matching entries and outputs corresponding
 *          'actions' if matched.
 *          In this version, this module includes BRAM flow tables
 *          inside.
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

`timescale 1 ns / 1ps
`include "registers.v"

module flow_tbl_ctrl
#(
    // Parameters for Flow Table interface
    // 2^(TBL_WIDTH) will be the total Flow Table area
    // (Split the area into two for EXACT and WILDCARD tables)
    parameter TBL_WIDTH=16,
    parameter OPENFLOW_MATCH_SIZE=256,
    parameter OPENFLOW_ACTION_SIZE=320,
    parameter OPENFLOW_STATS_SIZE=64,

    parameter PKT_LEN_SIZE=16,
    // AXI Lite Data Width
    parameter DATA_WIDTH=32
)
(
   // AXI ports
   input asclk,
   input aresetn,

   // Host access
   input [TBL_WIDTH-1:0] host_addr,
   input [OPENFLOW_MATCH_SIZE-1:0] host_match_in,
   input [OPENFLOW_MATCH_SIZE-1:0] host_mask_in,
   input [OPENFLOW_ACTION_SIZE-1:0] host_action_in,
   input [OPENFLOW_STATS_SIZE-1:0] host_stats_in,
   output reg  [OPENFLOW_MATCH_SIZE-1:0] host_match_out,
   output reg [OPENFLOW_ACTION_SIZE-1:0] host_action_out,
   output reg [OPENFLOW_STATS_SIZE-1:0] host_stats_out,
   input host_wr, // pos: write, neg: read
   input host_stats_en,
      // pos: enable writing to stats area along with match/mask/action
      // neg: stats not written
   input host_req,
   output host_ack,
   output reg host_done,

   // Interface to/from lookups
   // PHY ports
   input [OPENFLOW_MATCH_SIZE-1:0] p0_match,
   input [PKT_LEN_SIZE-1:0] p0_stats,
   input p0_req,
   output p0_ack,
   output p0_done,

   input [OPENFLOW_MATCH_SIZE-1:0] p1_match,
   input [PKT_LEN_SIZE-1:0] p1_stats,
   input p1_req,
   output p1_ack,
   output p1_done,

   input [OPENFLOW_MATCH_SIZE-1:0] p2_match,
   input [PKT_LEN_SIZE-1:0] p2_stats,
   input p2_req,
   output p2_ack,
   output p2_done,

   input [OPENFLOW_MATCH_SIZE-1:0] p3_match,
   input [PKT_LEN_SIZE-1:0] p3_stats,
   input p3_req,
   output p3_ack,
   output p3_done,

   // DMA port
   input [OPENFLOW_MATCH_SIZE-1:0] p4_match,
   input [PKT_LEN_SIZE-1:0] p4_stats,
   input p4_req,
   output p4_ack,
   output p4_done,

   // To all ports
   output reg [OPENFLOW_ACTION_SIZE-1:0] action_out,

   input [`OPENFLOW_LAST_SEEN_WIDTH-1:0] openflow_timer,

   // Registers
   output [DATA_WIDTH-1:0] num_pkts_dropped_0,
   output [DATA_WIDTH-1:0] num_pkts_dropped_1,
   output [DATA_WIDTH-1:0] num_pkts_dropped_2,
   output [DATA_WIDTH-1:0] num_pkts_dropped_3,
   output [DATA_WIDTH-1:0] num_pkts_dropped_4,
   output reg [DATA_WIDTH-1:0] exact_hit,
   output reg [DATA_WIDTH-1:0] exact_miss,
   output reg [DATA_WIDTH-1:0] wildcard_hit,
   output reg [DATA_WIDTH-1:0] wildcard_miss
   );

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   //-------------------- Internal Parameters ------------------------

   localparam REQ_FROM_HOST = 5;
   localparam REQ_NONE = 6;
   localparam NUM_MAX_PORT = 6;
   localparam EX_ENTRY_WIDTH = 10; // 1024 entries
   localparam LUT_DEPTH = 32; // num of WC entries
   localparam LUT_DEPTH_BITS = log2(LUT_DEPTH);

   //------------------------ Wires/Regs -----------------------------

   //--- Processing port selection
   // They can take upto seven ports (+ NONE condition)
   // Currently six ports are used for
   // - 4ports: phy ports, 1port: CPU port, 1port: Host reg access
   reg [2:0] proc_port_2nd;
   reg [2:0] proc_port_3rd;
   reg [2:0] proc_port_4th;
   reg [2:0] proc_port_5th;
   reg [2:0] proc_port_6th;
   reg [2:0] proc_port_7th;
   reg [2:0] rr_cntr;
   wire [2:0] pri_pre0, pri_pre1, pri_pre2, pri_pre3, pri_pre4, pri_pre5;
   reg [2:0] pri0, pri1, pri2, pri3, pri4, pri5;

   //--- Host_inf signals
   reg host_wr_2nd;
   reg host_stats_en_2nd;

   reg host_ex_acc_3rd, host_ex_acc_4th, host_ex_acc_5th,
       host_ex_acc_6th, host_ex_acc_7th, host_ex_acc_8th;
   reg host_ex_wr_3rd, host_ex_wr_4th, host_ex_wr_5th, host_ex_wr_6th;
   reg host_wc_wr_3rd, host_wc_wr_4th, host_wc_wr_5th, host_wc_wr_6th;
   reg host_wc_wr_cam;
   reg host_wc_stats_wr_7th, host_wc_stats_wr_8th;
   reg host_stats_en_3rd, host_stats_en_4th, host_stats_en_5th,
       host_stats_en_6th;
   reg host_ex_stats_wr_7th, host_ex_stats_wr_8th;

   reg [OPENFLOW_MATCH_SIZE-1:0] host_match_out_8th;
   reg [OPENFLOW_ACTION_SIZE-1:0] host_action_out_8th;
   reg host_done_8th;

   //--- Other signals for pipeline processes
   wire [OPENFLOW_MATCH_SIZE-1:0] match_int [0:NUM_MAX_PORT-1];
   wire [PKT_LEN_SIZE-1:0] stats_int [0:NUM_MAX_PORT-1];

   reg [OPENFLOW_MATCH_SIZE-1:0] match_int_2nd [0:NUM_MAX_PORT-1];
   reg [PKT_LEN_SIZE-1:0] stats_int_2nd [0:NUM_MAX_PORT-1];

   wire [NUM_MAX_PORT-1:0] req_int;
   reg [NUM_MAX_PORT-1:0] ack_int;
   reg [NUM_MAX_PORT-1-1:0] done_int; // Reg acc port has separate done sig

   reg [OPENFLOW_MATCH_SIZE-1:0] match_3rd, match_4th, match_5th;
   reg [PKT_LEN_SIZE-1:0] stats_3rd, stats_4th, stats_5th,
                          stats_6th, stats_7th, stats_8th;

   wire [EX_ENTRY_WIDTH-1:0] ex_flow_index0_4th, ex_flow_index1_4th;
   reg [EX_ENTRY_WIDTH-1:0] ex_flow_index0_5th, ex_flow_index1_5th;
   reg [EX_ENTRY_WIDTH-1:0] ex_flow_index0_6th, ex_flow_index1_6th;
   reg [EX_ENTRY_WIDTH-1:0] ex_addr_7th;

   wire wc_exist_4th;
   reg wc_exist_5th, wc_exist_6th;
   wire [LUT_DEPTH-1:0] wc_unenc_addr_4th;
   reg [LUT_DEPTH-1:0] wc_unenc_addr_latch;
   reg [LUT_DEPTH_BITS-1:0] wc_addr_5th, wc_addr_6th, wc_addr_7th, wc_addr_8th, wc_addr_9th, wc_addr;

   wire [15:0] ex_entry0_match_comp, ex_entry1_match_comp;
   reg [15:0] ex_entry0_match, ex_entry1_match;

   reg use_ex_7th;
   reg use_wc_7th;
   reg ex_we_8th, ex_we_9th;
   reg wc_we_8th, wc_we_9th;

   reg [EX_ENTRY_WIDTH-1:0] ex_addr0;
   wire [EX_ENTRY_WIDTH-1:0] ex_addr1;
   reg [EX_ENTRY_WIDTH-1:0] ex_addr_8th, ex_addr_9th;

   wire [OPENFLOW_MATCH_SIZE-1:0] ex_entry0_5th, ex_entry1_5th;
   reg [OPENFLOW_MATCH_SIZE-1:0] ex_entry0_6th, ex_entry1_6th;
   reg [OPENFLOW_MATCH_SIZE-1:0] ex_entry_7th;
   wire [OPENFLOW_ACTION_SIZE-1:0] ex_action0_5th, ex_action1_5th;
   reg [OPENFLOW_ACTION_SIZE-1:0] ex_action0_6th, ex_action1_6th;
   reg [OPENFLOW_ACTION_SIZE-1:0] ex_action_7th;
   wire [OPENFLOW_ACTION_SIZE-1:0] wc_action_7th;

   reg [63:0] ex_update_stats;
   reg [63:0] wc_update_stats;
   wire [63:0] ex_current_stats;
   wire [63:0] wc_current_stats;

   //--- Registers
   reg [DATA_WIDTH-1:0] num_pkts_dropped[0:NUM_MAX_PORT-1-1];

   //--- Dummy
   wire [63:0] dummy_64b_0, dummy_64b_1, dummy_64b_2;

   integer i,j;

   //--------------------------- Logic -------------------------------

   assign req_int[0] = p0_req;
   assign req_int[1] = p1_req;
   assign req_int[2] = p2_req;
   assign req_int[3] = p3_req;
   assign req_int[4] = p4_req;
   assign req_int[5] = host_req;

   assign p0_ack = ack_int[0];
   assign p1_ack = ack_int[1];
   assign p2_ack = ack_int[2];
   assign p3_ack = ack_int[3];
   assign p4_ack = ack_int[4];
   assign host_ack = ack_int[5];

   assign p0_done = done_int[0];
   assign p1_done = done_int[1];
   assign p2_done = done_int[2];
   assign p3_done = done_int[3];
   assign p4_done = done_int[4];

   assign match_int[0] = p0_match;
   assign match_int[1] = p1_match;
   assign match_int[2] = p2_match;
   assign match_int[3] = p3_match;
   assign match_int[4] = p4_match;
   assign match_int[5] = host_match_in; //dummy

   assign stats_int[0] = p0_stats;
   assign stats_int[1] = p1_stats;
   assign stats_int[2] = p2_stats;
   assign stats_int[3] = p3_stats;
   assign stats_int[4] = p4_stats;
   assign stats_int[5] = host_stats_in; //dummy

   assign num_pkts_dropped_0 = num_pkts_dropped[0];
   assign num_pkts_dropped_1 = num_pkts_dropped[1];
   assign num_pkts_dropped_2 = num_pkts_dropped[2];
   assign num_pkts_dropped_3 = num_pkts_dropped[3];
   assign num_pkts_dropped_4 = num_pkts_dropped[4];

   // -------------------------------------------------------------
   // 1st stage (CLK-1)
   // Select one requested_port per clk in a round robin fashion

   // Counter
   always @(posedge asclk) begin
      if (~aresetn) begin
         rr_cntr <= 0;
      end
      else begin
         if (rr_cntr >= NUM_MAX_PORT-1) begin
            rr_cntr <= 0;
         end
         else begin
            rr_cntr <= rr_cntr + 1;
         end
      end
   end

   assign pri_pre0 = rr_cntr;
   assign pri_pre1 = (rr_cntr<5) ? rr_cntr+1 : rr_cntr-5;
   assign pri_pre2 = (rr_cntr<4) ? rr_cntr+2 : rr_cntr-4;
   assign pri_pre3 = (rr_cntr<3) ? rr_cntr+3 : rr_cntr-3;
   assign pri_pre4 = (rr_cntr<2) ? rr_cntr+4 : rr_cntr-2;
   assign pri_pre5 = (rr_cntr<1) ? rr_cntr+5 : rr_cntr-1;

   always @(posedge asclk) begin
      if (~aresetn) begin
         pri0 <= 0;
         pri1 <= 0;
         pri2 <= 0;
         pri3 <= 0;
         pri4 <= 0;
         pri5 <= 0;
      end
      else begin
         pri0 <= pri_pre0;
         pri1 <= pri_pre1;
         pri2 <= pri_pre2;
         pri3 <= pri_pre3;
         pri4 <= pri_pre4;
         pri5 <= pri_pre5;
      end
   end

   // Processing port selector
   always @(posedge asclk) begin
      if (~aresetn) begin
         ack_int <= 0;
         proc_port_2nd <= REQ_NONE;
      end
      else begin
         if (req_int[pri0] && ~(ack_int[pri0])) begin
            ack_int <= (1<<pri0);
            proc_port_2nd <= pri0;
         end
         else if (req_int[pri1] && ~(ack_int[pri1])) begin
            ack_int <= (1<<pri1);
            proc_port_2nd <= pri1;
         end
         else if (req_int[pri2] && ~(ack_int[pri2])) begin
            ack_int <= (1<<pri2);
            proc_port_2nd <= pri2;
         end
         else if (req_int[pri3] && ~(ack_int[pri3])) begin
            ack_int <= (1<<pri3);
            proc_port_2nd <= pri3;
         end
         else if (req_int[pri4] && ~(ack_int[pri4])) begin
            ack_int <= (1<<pri4);
            proc_port_2nd <= pri4;
         end
         else if (req_int[pri5] && ~(ack_int[pri5])) begin
            ack_int <= (1<<pri5);
            proc_port_2nd <= pri5;
         end
         else begin
            ack_int <= 0;
            proc_port_2nd <= REQ_NONE;
         end
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         match_int_2nd[0] <= 0;
         match_int_2nd[1] <= 0;
         match_int_2nd[2] <= 0;
         match_int_2nd[3] <= 0;
         match_int_2nd[4] <= 0;
         match_int_2nd[5] <= 0;
         stats_int_2nd[0] <= 0;
         stats_int_2nd[1] <= 0;
         stats_int_2nd[2] <= 0;
         stats_int_2nd[3] <= 0;
         stats_int_2nd[4] <= 0;
         stats_int_2nd[5] <= 0;
      end
      else begin
         match_int_2nd[0] <= match_int[0];
         match_int_2nd[1] <= match_int[1];
         match_int_2nd[2] <= match_int[2];
         match_int_2nd[3] <= match_int[3];
         match_int_2nd[4] <= match_int[4];
         match_int_2nd[5] <= match_int[5];
         stats_int_2nd[0] <= stats_int[0];
         stats_int_2nd[1] <= stats_int[1];
         stats_int_2nd[2] <= stats_int[2];
         stats_int_2nd[3] <= stats_int[3];
         stats_int_2nd[4] <= stats_int[4];
         stats_int_2nd[5] <= stats_int[5];
      end
   end

   // host inf
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_wr_2nd <= 0;
         host_stats_en_2nd <= 0;
      end
      else begin
         host_wr_2nd <= host_wr;
         host_stats_en_2nd <= host_stats_en;
      end
   end

 
   // -------------------------------------------------------------
   // 2nd stage (CLK-2)
   // Choose and pass info of selected port

   always @(posedge asclk) begin
      if (~aresetn) begin
         proc_port_3rd <= REQ_NONE;
         match_3rd <= 0;
         stats_3rd <= 0;
      end
      else begin
         proc_port_3rd <= proc_port_2nd;
         if (proc_port_2nd == REQ_NONE) begin
            match_3rd <= 0;
            stats_3rd <= 0;
         end
         else begin
            match_3rd <= match_int_2nd[proc_port_2nd];
            stats_3rd <= stats_int_2nd[proc_port_2nd];
         end
      end
   end

   // host inf
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_ex_acc_3rd <= 0;
         host_ex_wr_3rd <= 0;
         host_wc_wr_3rd <= 0;
         host_stats_en_3rd <= 0;
      end
      else begin
         if (host_addr[TBL_WIDTH-1] == 0) begin // acc to exact table
            host_ex_acc_3rd <= 1;
            if (host_wr_2nd) begin
               host_ex_wr_3rd <= 1;
            end
            else begin
               host_ex_wr_3rd <= 0;
            end
            host_wc_wr_3rd <= 0;
         end
         else begin // acc to wildcard table
            host_ex_acc_3rd <= 0;
            host_ex_wr_3rd <= 0;
            if (host_wr_2nd) begin
               host_wc_wr_3rd <= 1;
            end
            else begin
               host_wc_wr_3rd <= 0;
            end
         end
         host_stats_en_3rd <= host_stats_en_2nd;
      end
   end

   // Wildcard
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_wc_wr_cam <= 0;
      end
      else begin
         if ((host_addr[TBL_WIDTH-1] == 1) && host_wr_2nd && (proc_port_2nd == REQ_FROM_HOST)) begin
            host_wc_wr_cam <= 1;
         end
         else begin
            host_wc_wr_cam <= 0;
         end
      end
   end


   // -------------------------------------------------------------
   // 3rd stage(CLK-3)
   // exact match:
   //  hash an entry and get two addresses
   // wildcard match:
   //  Input entry to CAM and get unencoded hit row

   // exact match
   header_hash
     #(.INPUT_WIDTH   (OPENFLOW_MATCH_SIZE),
       .OUTPUT_WIDTH  (EX_ENTRY_WIDTH))
       header_hash
         (.data (match_3rd),
          .hash_0 (ex_flow_index0_4th),
          .hash_1 (ex_flow_index1_4th),
          .clk (asclk),
          .reset (~aresetn));

   // wildcard match
   openflow_cam
   #(.OPENFLOW_WILDCARD_TABLE_SIZE (LUT_DEPTH),
     .OPENFLOW_MATCH_SIZE (OPENFLOW_MATCH_SIZE),
     .LUT_DEPTH_BITS(LUT_DEPTH_BITS))
     openflow_cam
      (.din (host_match_in),
       .data_mask (host_mask_in),
       .cmp_din (match_3rd),
       .cmp_data_mask ({OPENFLOW_MATCH_SIZE{1'b0}}),
       .wr_addr (host_addr[LUT_DEPTH_BITS-1:0]),
       .we (host_wc_wr_cam),
       .match_addr (wc_unenc_addr_4th),
       .match (wc_exist_4th),
       .busy (),
       .aresetn (aresetn),
       .clk (asclk));

   // host inf
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_ex_acc_4th <= 0;
         host_ex_wr_4th <= 0;
         host_wc_wr_4th <= 0;
         host_stats_en_4th <= 0;
      end
      else begin
         if (proc_port_3rd == REQ_FROM_HOST) begin
            host_ex_acc_4th <= host_ex_acc_3rd;
            host_ex_wr_4th <= host_ex_wr_3rd;
            host_wc_wr_4th <= host_wc_wr_3rd;
         end
         else begin
            host_ex_acc_4th <= 0;
            host_ex_wr_4th <= 0;
            host_wc_wr_4th <= 0;
         end
         host_stats_en_4th <= host_stats_en_3rd;
      end
   end

   // Shift signals
   always @(posedge asclk) begin
      if (~aresetn) begin
         proc_port_4th <= REQ_NONE;
         match_4th <= 0;
         stats_4th <= 0;
      end
      else begin
         proc_port_4th <= proc_port_3rd;
         match_4th <= match_3rd;
         stats_4th <= stats_3rd;
      end
   end

   // -------------------------------------------------------------
   // 4th stage(CLK-4)
   // exact match: Find entries
   // wildcard match: Decode addresses

   // exact match
   // Share BRAM port with host reg access
   always @(*) begin
      if (proc_port_4th == REQ_FROM_HOST) begin
         ex_addr0 = host_addr;
      end
      else begin
         ex_addr0 = ex_flow_index0_4th;
      end
   end
   assign ex_addr1 = ex_flow_index1_4th;

   // BRAM for match
   dp_bram_1024x256 ex_match_bram
   (
   .clka (asclk),
   .addra (ex_addr0), // also used by host
   .dina (host_match_in), // used only by host
   .douta (ex_entry0_5th),
   .wea (host_ex_wr_4th),
   .rsta (~aresetn),
   .clkb (asclk),
   .addrb (ex_addr1),
   .dinb (256'b0),
   .doutb (ex_entry1_5th),
   .web (1'b0),
   .rstb (~aresetn)
   );

   // BRAM for action
   dp_bram_1024x384 ex_action_bram
   (
   .clka (asclk),
   .addra (ex_addr0), // also used by host
   .dina ({64'b0, host_action_in}), //used only by host
   .douta ({dummy_64b_0, ex_action0_5th}),
   .wea (host_ex_wr_4th),
   .rsta (~aresetn),
   .clkb (asclk),
   .addrb (ex_addr1),
   .dinb (384'b0),
   .doutb ({dummy_64b_1, ex_action1_5th}),
   .web (1'b0),
   .rstb (~aresetn)
   );

   // wildcard match
   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_exist_5th <= 0;
         wc_unenc_addr_latch <= 0;
      end
      else begin
         if ((proc_port_4th != REQ_NONE) && (proc_port_4th != REQ_FROM_HOST))begin
            wc_exist_5th <= wc_exist_4th;
         end
         else begin
            wc_exist_5th <= 0;
         end
         wc_unenc_addr_latch <= wc_unenc_addr_4th;
      end
   end

   always @(*) begin
      wc_addr_5th = LUT_DEPTH[LUT_DEPTH_BITS-1:0] - 1'b1;
      for (i = LUT_DEPTH-2; i >= 0; i = i-1) begin
         if (wc_unenc_addr_latch[i]) begin
            wc_addr_5th = i[LUT_DEPTH_BITS-1:0];
         end
      end
   end

   // Shift signals
   always @(posedge asclk) begin
      if (~aresetn) begin
         proc_port_5th <= REQ_NONE;
         ex_flow_index0_5th <= 0;
         ex_flow_index1_5th <= 0;
         match_5th <= 0;
         stats_5th <= 0;
      end
      else begin
         proc_port_5th <= proc_port_4th;
         ex_flow_index0_5th <= ex_flow_index0_4th;
         ex_flow_index1_5th <= ex_flow_index1_4th;
         match_5th <= match_4th;
         stats_5th <= stats_4th;
      end
   end

   // host inf
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_ex_acc_5th <= 0;
         host_ex_wr_5th <= 0;
         host_wc_wr_5th <= 0;
         host_stats_en_5th <= 0;
      end
      else begin
         host_ex_acc_5th <= host_ex_acc_4th;
         host_ex_wr_5th <= host_ex_wr_4th;
         host_wc_wr_5th <= host_wc_wr_4th;
         host_stats_en_5th <= host_stats_en_4th;
      end
   end


   // -------------------------------------------------------------
   // 5th stage(CLK-5)
   // Check if we have a matching entry somewhere (step1)

   generate
      genvar ii;
      for (ii=0; ii<15; ii=ii+1) begin: gen_ex_match_comp
         assign ex_entry0_match_comp[ii] = (ex_entry0_5th[((ii+1)*16-1) : (ii*16)] == match_5th[((ii+1)*16-1) : (ii*16)]) ? 1:0;
         assign ex_entry1_match_comp[ii] = (ex_entry1_5th[((ii+1)*16-1) : (ii*16)] == match_5th[((ii+1)*16-1) : (ii*16)]) ? 1:0;
      end
   endgenerate
   // MSB (bit255) is used for different purpose
   assign ex_entry0_match_comp[15] = (ex_entry0_5th[254:240] == match_5th[254:240]) ? 1:0;
   assign ex_entry1_match_comp[15] = (ex_entry1_5th[254:240] == match_5th[254:240]) ? 1:0;


   always @(posedge asclk) begin
      if (~aresetn) begin
         ex_entry0_match <= 0;
         ex_entry1_match <= 0;
      end
      else begin
         ex_entry0_match <= ex_entry0_match_comp;
         ex_entry1_match <= ex_entry1_match_comp;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         ex_entry0_6th <= 0;
         ex_action0_6th <= 0;
         ex_entry1_6th <= 0;
         ex_action1_6th <= 0;
         ex_flow_index0_6th <= 0;
         ex_flow_index1_6th <= 0;
      end
      else begin
         ex_entry0_6th <= ex_entry0_5th;
         ex_action0_6th <= ex_action0_5th;
         ex_entry1_6th <= ex_entry1_5th;
         ex_action1_6th <= ex_action1_5th;
         ex_flow_index0_6th <= ex_flow_index0_5th;
         ex_flow_index1_6th <= ex_flow_index1_5th;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_exist_6th <= 0;
      end
      else begin
         wc_exist_6th <= wc_exist_5th;
      end
   end

   // wildcard match
   // Share BRAM port
   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_addr <= 0;
      end
      else begin
         if (proc_port_5th == REQ_FROM_HOST) begin
            wc_addr <= host_addr;
         end
         else begin
            wc_addr <= wc_addr_5th;
         end
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_addr_6th <= 0;
      end
      else begin
         if (proc_port_5th == REQ_FROM_HOST) begin
            wc_addr_6th <= host_addr;
         end
         else begin
            wc_addr_6th <= wc_addr_5th;
         end
      end
   end

   // host inf
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_ex_acc_6th <= 0;
         host_ex_wr_6th <= 0;
         host_wc_wr_6th <= 0;
         host_stats_en_6th <= 0;
      end
      else begin
         host_ex_acc_6th <= host_ex_acc_5th;
         host_ex_wr_6th <= host_ex_wr_5th;
         host_wc_wr_6th <= host_wc_wr_5th;
         host_stats_en_6th <= host_stats_en_5th;
      end
   end

   // Shift signals
   always @(posedge asclk) begin
      if (~aresetn) begin
         proc_port_6th <= REQ_NONE;
         stats_6th <= 0;
      end
      else begin
         proc_port_6th <= proc_port_5th;
         stats_6th <= stats_5th;
      end
   end


   // -------------------------------------------------------------
   // 6th stage(CLK-6)
   // Check if we have a matching entry somewhere (step2)

   // Comparator
   always @(posedge asclk) begin
      if (~aresetn) begin
         use_ex_7th <= 0;
         use_wc_7th <= 0;
      end
      else begin
         if ((proc_port_6th != REQ_NONE) &&
             (proc_port_6th != REQ_FROM_HOST) &&
             (&(ex_entry0_match) ||
              &(ex_entry1_match))) begin
            use_ex_7th <= 1;
            use_wc_7th <= 0;
         end
         else if (wc_exist_6th) begin
            use_ex_7th <= 0;
            use_wc_7th <= 1;
         end
         else begin
         // drop
            use_ex_7th <= 0;
            use_wc_7th <= 0;
         end
      end
   end

   // Registers
   always @(posedge asclk) begin
      if (~aresetn) begin
         for (j=0; j<REQ_FROM_HOST; j=j+1) begin
            num_pkts_dropped[j] <= 0;
         end
         exact_hit <= 0;
         exact_miss <= 0;
         wildcard_hit <= 0;
         wildcard_miss <= 0;
      end
      else begin
         if (proc_port_6th < REQ_FROM_HOST) begin
            if (&(ex_entry0_match) ||
                &(ex_entry1_match)) begin
               exact_hit <= exact_hit + 1;
            end
            else begin
               exact_miss <= exact_miss + 1;
            end
            if (wc_exist_6th) begin
               wildcard_hit <= wildcard_hit + 1;
            end
            else begin
               wildcard_miss <= wildcard_miss + 1;
            end
            if (~(&(ex_entry0_match) ||
                  &(ex_entry1_match) ||
                  wc_exist_6th)) begin
               num_pkts_dropped[proc_port_6th] <=
                  num_pkts_dropped[proc_port_6th] + 1;
            end
         end
      end
   end

   // exact match action sel
   always @(posedge asclk) begin
      if (~aresetn) begin
         ex_entry_7th <= 0;
         ex_action_7th <= 0;
         ex_addr_7th <= 0;
      end
      else begin
         if (proc_port_6th == REQ_FROM_HOST) begin
            // entry and action for output
            ex_entry_7th <= ex_entry0_6th;
            ex_action_7th <= ex_action0_6th;
            ex_addr_7th <= host_addr;
         end
         else if (&(ex_entry0_match)) begin
            ex_entry_7th <= ex_entry0_6th;
            ex_action_7th <= ex_action0_6th;
            ex_addr_7th <= ex_flow_index0_6th;
         end
         else begin //(ex_entry1_match) and other conditions
            ex_entry_7th <= ex_entry1_6th;
            ex_action_7th <= ex_action1_6th;
            ex_addr_7th <= ex_flow_index1_6th;
         end
      end
   end

   dp_bram_32x384 wc_action_bram
   (
   .clka (asclk),
   .addra (wc_addr[LUT_DEPTH_BITS-1:0]),
   .dina ({64'b0, host_action_in}),
   .douta ({dummy_64b_2, wc_action_7th}),
   .wea (host_wc_wr_6th),
   .rsta (~aresetn),
   .clkb (asclk),
   .addrb (5'b0),
   .dinb (384'b0),
   .doutb (),
   .web (1'b0),
   .rstb (~aresetn)
   );

   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_addr_7th <= 0;
      end
      else begin
         wc_addr_7th <= wc_addr_6th;
      end
   end

   // host inf
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_ex_acc_7th <= 0;
         host_ex_stats_wr_7th <= 0;
         host_wc_stats_wr_7th <= 0;
      end
      else begin
         host_ex_acc_7th <= host_ex_acc_6th;
         host_ex_stats_wr_7th <= (host_ex_wr_6th && host_stats_en_6th);
         host_wc_stats_wr_7th <= (host_wc_wr_6th && host_stats_en_6th);
      end
   end

   // Shift signals
   always @(posedge asclk) begin
      if (~aresetn) begin
         proc_port_7th <= REQ_NONE;
         stats_7th <= 0;
      end
      else begin
         proc_port_7th <= proc_port_6th;
         stats_7th <= stats_6th;
      end
   end


   // -------------------------------------------------------------
   //  7th stage (CLK-7)
   //  Select actions from EX and WC, then send it out

   // Action selecter
   always @(posedge asclk) begin
      if (~aresetn) begin
         action_out <= 0;
         done_int <= 0;
      end
      else begin
         if (use_ex_7th) begin // exact match hits
            action_out <= ex_action_7th;
         end
         else if (use_wc_7th) begin // wildcard match hits
            action_out <= wc_action_7th;
         end
         else begin // nothing hits
            action_out <= 0;
         end
         if (proc_port_7th < REQ_FROM_HOST) begin
            done_int <= 1<<proc_port_7th;
         end
         else begin
            done_int <= 0;
         end
      end
   end

   // -------------------------------------------------------------
   // 7th stage(CLK-7), 8th stage(CLK-8) and 9th stage(CLK-9)
   // Statistics

   // exact match
   dp_bram_1024x64 ex_stats_bram
   (
   //side-a: clk9, side-b: clk7
   .clka (asclk),
   .addra (ex_addr_9th), // also used by host
   .dina (ex_update_stats), // also used by host
   .douta (),
   .wea (ex_we_9th), // also used by host
   .rsta (~aresetn),
   .clkb (asclk),
   .addrb (ex_addr_7th),  // clk7
   .dinb (64'b0),
   .doutb (ex_current_stats),
   .web (1'b0),
   .rstb (~aresetn)
   );

   always @(posedge asclk) begin
      if (~aresetn) begin
         stats_8th <= 0;
      end
      else begin
         stats_8th <= stats_7th;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         ex_addr_8th <= 0;
         ex_we_8th <= 0;
         host_ex_stats_wr_8th <= 0;
      end
      else begin
         ex_addr_8th <= ex_addr_7th;
         ex_we_8th <= (use_ex_7th || host_ex_stats_wr_7th);
         host_ex_stats_wr_8th <= host_ex_stats_wr_7th;
      end
   end
   always @(posedge asclk) begin
      if (~aresetn) begin
         ex_addr_9th <= 0;
         ex_we_9th <= 0;
      end
      else begin
         ex_addr_9th <= ex_addr_8th;
         ex_we_9th <= ex_we_8th;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         ex_update_stats <= 0;
      end
      else begin
         if (host_ex_stats_wr_8th) begin
            ex_update_stats <= host_stats_in;
         end
         else begin
            // byte count
            ex_update_stats[`OPENFLOW_BYTE_COUNTER_POS +:
                            `OPENFLOW_BYTE_COUNTER_WIDTH] <=
               ex_current_stats[`OPENFLOW_BYTE_COUNTER_POS +:
                                `OPENFLOW_BYTE_COUNTER_WIDTH] + stats_8th;
            // last seen
            ex_update_stats[`OPENFLOW_LAST_SEEN_POS +:
                            `OPENFLOW_LAST_SEEN_WIDTH] <= openflow_timer;
            // pkt count
            ex_update_stats[`OPENFLOW_PKT_COUNTER_POS +:
                            `OPENFLOW_PKT_COUNTER_WIDTH] <=
               ex_current_stats[`OPENFLOW_PKT_COUNTER_POS +:
                                `OPENFLOW_PKT_COUNTER_WIDTH] + 1;
         end
      end
   end

   // wildcard match
   dp_bram_32x64 wc_stats_bram
   (
   //side-a: clk9, side-b: clk7
   .clka (asclk),
   .addra (wc_addr_9th[LUT_DEPTH_BITS-1:0]), // also used by host
   .dina (wc_update_stats), // also used by host
   .douta (),
   .wea (wc_we_9th),
   .rsta (~aresetn),
   .clkb (asclk),
   .addrb (wc_addr_7th[LUT_DEPTH_BITS-1:0]),
   .dinb (64'b0),
   .doutb (wc_current_stats),
   .web (1'b0),
   .rstb (~aresetn)
   );

   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_addr_8th <= 0;
         wc_we_8th <= 0;
         host_wc_stats_wr_8th <= 0;
      end
      else begin
         wc_addr_8th <= wc_addr_7th;
         wc_we_8th <= (use_wc_7th || host_wc_stats_wr_7th);
         host_wc_stats_wr_8th <= host_wc_stats_wr_7th;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_addr_9th <= 0;
         wc_we_9th <= 0;
      end
      else begin
         wc_addr_9th <= wc_addr_8th;
         wc_we_9th <= wc_we_8th;
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         wc_update_stats <= 0;
      end
      else begin
         if (host_wc_stats_wr_8th) begin
            wc_update_stats <= host_stats_in;
         end
         else begin
            // byte count
            wc_update_stats[`OPENFLOW_BYTE_COUNTER_POS +:
                            `OPENFLOW_BYTE_COUNTER_WIDTH] <=
               wc_current_stats[`OPENFLOW_BYTE_COUNTER_POS +:
                                `OPENFLOW_BYTE_COUNTER_WIDTH] + stats_8th;
            // last seen
            wc_update_stats[`OPENFLOW_LAST_SEEN_POS +:
                            `OPENFLOW_LAST_SEEN_WIDTH] <= openflow_timer;
            // pkt count
            wc_update_stats[`OPENFLOW_PKT_COUNTER_POS +:
                            `OPENFLOW_PKT_COUNTER_WIDTH] <=
               wc_current_stats[`OPENFLOW_PKT_COUNTER_POS +:
                                `OPENFLOW_PKT_COUNTER_WIDTH] + 1;
         end
      end
   end

   // host access
   // Whichever write or read, it will send out data with done signal
   // CLK-7
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_match_out_8th <= 0;
         host_action_out_8th <= 0;
         host_done_8th <= 0;
      end
      else begin
         // Send them out anyway
         if (host_ex_acc_7th == 1) begin // exact
            host_match_out_8th <= ex_entry_7th;
            host_action_out_8th <= ex_action_7th;
         end
         else begin
            host_match_out_8th <= 0;
            host_action_out_8th <= wc_action_7th;
         end
         if (proc_port_7th == REQ_FROM_HOST) begin
            host_done_8th <= 1;
         end
         else begin
            host_done_8th <= 0;
         end
      end
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         host_ex_acc_8th <= 0;
      end
      else begin
         host_ex_acc_8th <= host_ex_acc_7th;
      end
   end

   // CLK-8
   // Send out everything
   always @(posedge asclk) begin
      if (~aresetn) begin
         host_match_out <= 0;
         host_action_out <= 0;
         host_stats_out <= 0;
         host_done <= 0;
      end
      else begin
         // Send them out anyway
         host_match_out <= host_match_out_8th;
         host_action_out <= host_action_out_8th;
         if (host_ex_acc_8th == 1) begin
            host_stats_out <= ex_current_stats;
         end
         else begin
            host_stats_out <= wc_current_stats;
         end
         host_done <= host_done_8th;
      end
   end

endmodule
