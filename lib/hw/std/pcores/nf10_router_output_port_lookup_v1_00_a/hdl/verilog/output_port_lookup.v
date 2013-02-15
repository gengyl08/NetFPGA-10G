/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        output_port_lookup.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_router_output_port_lookup_v1_10_a
 *
 *  Module:
 *        output_port_lookup
 *
 *  Author:
 *        Gianni Antichi
 *
 *  Description:
 *        Hardwire the hardware interfaces to CPU and vice versa
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
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

module output_port_lookup
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter NUM_QUEUES=8,
    parameter NUM_QUEUES_WIDTH = log2(NUM_QUEUES),
    parameter LPM_LUT_DEPTH = 16,
    parameter LPM_LUT_DEPTH_BITS = log2(LPM_LUT_DEPTH),
    parameter ARP_LUT_DEPTH = 16,
    parameter ARP_LUT_DEPTH_BITS = log2(ARP_LUT_DEPTH),
    parameter FILTER_DEPTH = 16,
    parameter FILTER_DEPTH_BITS = log2(FILTER_DEPTH)
)
(
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Master Stream Ports (interface to data path)
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
    output m_axis_tvalid,
    input  m_axis_tready,
    output m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
    input  s_axis_tlast,

    // --- interface to op_lut_process_sm
    output                               pkt_sent_from_cpu,              // pulsed: we've sent a pkt from the CPU
    output                               pkt_sent_to_cpu_options_ver,    // pulsed: we've sent a pkt to the CPU coz it has options/bad version
    output                               pkt_sent_to_cpu_bad_ttl,        // pulsed: sent a pkt to the CPU coz the TTL is 1 or 0
    output                               pkt_sent_to_cpu_dest_ip_hit,    // pulsed: sent a pkt to the CPU coz it has hit in the destination ip filter list
    output                               pkt_forwarded     ,             // pulsed: forwarded pkt to the destination port
    output                               pkt_dropped_checksum,           // pulsed: dropped pkt coz bad checksum
    output                               pkt_sent_to_cpu_non_ip,         // pulsed: sent pkt to cpu coz it's not IP
    output                               pkt_sent_to_cpu_arp_miss,       // pulsed: sent pkt to cpu coz we didn't find arp entry for next hop ip
    output                               pkt_sent_to_cpu_lpm_miss,       // pulsed: sent pkt to cpu coz we didn't find lpm entry for destination ip
    output                               pkt_dropped_wrong_dst_mac,      // pulsed: dropped pkt not destined to us

    // --- interface to ip_lpm
    input [LPM_LUT_DEPTH_BITS-1:0]       lpm_rd_addr,          // address in table to read
    input                                lpm_rd_req,           // request a read
    output [31:0]                        lpm_rd_ip,            // ip to match in the CAM
    output [31:0]                        lpm_rd_mask,          // subnet mask
    output [NUM_QUEUES-1:0]              lpm_rd_oq,            // input queue
    output [31:0]                        lpm_rd_next_hop_ip,   // ip addr of next hop
    output                               lpm_rd_ack,           // pulses high
    input [LPM_LUT_DEPTH_BITS-1:0]       lpm_wr_addr,
    input                                lpm_wr_req,
    input [NUM_QUEUES-1:0]               lpm_wr_oq,
    input [31:0]                         lpm_wr_next_hop_ip,   // ip addr of next hop
    input [31:0]                         lpm_wr_ip,            // data to match in the CAM
    input [31:0]                         lpm_wr_mask,
    output                               lpm_wr_ack,

    // --- ip_arp
    input [ARP_LUT_DEPTH_BITS-1:0]       arp_rd_addr,          // address in table to read
    input                                arp_rd_req,           // request a read
    output  [47:0]                       arp_rd_mac,           // data read from the LUT at rd_addr
    output  [31:0]                       arp_rd_ip,            // ip to match in the CAM
    output                               arp_rd_ack,           // pulses high
    input [ARP_LUT_DEPTH_BITS-1:0]       arp_wr_addr,
    input                                arp_wr_req,
    input [47:0]                         arp_wr_mac,
    input [31:0]                         arp_wr_ip,            // data to match in the CAM
    output                               arp_wr_ack,

    // --- interface to dest_ip_filter
    input [FILTER_DEPTH_BITS-1:0]        dest_ip_filter_rd_addr,          // address in table to read
    input                                dest_ip_filter_rd_req,           // request a read
    output [31:0]                        dest_ip_filter_rd_ip,            // ip to match in the CAM
    output                               dest_ip_filter_rd_ack,           // pulses high
    input [FILTER_DEPTH_BITS-1:0]        dest_ip_filter_wr_addr,
    input                                dest_ip_filter_wr_req,
    input [31:0]                         dest_ip_filter_wr_ip,            // data to match in the CAM
    output                               dest_ip_filter_wr_ack,

    // --- eth_parser
    input [47:0]                         mac_0,    // address of rx queue 0
    input [47:0]                         mac_1,    // address of rx queue 1
    input [47:0]                         mac_2,    // address of rx queue 2
    input [47:0]                         mac_3    // address of rx queue 3

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

   //--------------------- Internal Parameter-------------------------

  // localparam LPM_LUT_DEPTH = 16;
  // localparam LPM_LUT_DEPTH_BITS = log2(LPM_LUT_DEPTH);
  // localparam ARP_LUT_DEPTH = 16;
  // localparam ARP_LUT_DEPTH_BITS = log2(ARP_LUT_DEPTH);
  // localparam FILTER_DEPTH = 16;
  // localparam FILTER_DEPTH_BITS = log2(FILTER_DEPTH);
  // localparam NUM_QUEUES_WIDTH = log2(NUM_QUEUES);

   //---------------------- Wires and regs----------------------------

   wire [NUM_QUEUES_WIDTH-1:0] mac_dst_port_num;
   wire [31:0]                 next_hop_ip;

   wire [NUM_QUEUES-1:0]       lpm_output_port;

   wire [47:0]                 next_hop_mac;
   wire [NUM_QUEUES-1:0]       output_port;
   
   wire [7:0]                  ip_new_ttl;
   wire [15:0]                 ip_new_checksum;

   wire [NUM_QUEUES-1:0]       to_cpu_output_port;
   wire [NUM_QUEUES-1:0]       from_cpu_output_port;
   wire [NUM_QUEUES_WIDTH-1:0] input_port_num;

   wire [C_M_AXIS_DATA_WIDTH-1:0]	in_fifo_tdata;
   wire [C_M_AXIS_TUSER_WIDTH-1:0]	in_fifo_tuser;
   wire [C_M_AXIS_DATA_WIDTH/8-1:0]	in_fifo_tstrb;
   wire					in_fifo_tlast;

   wire                        in_fifo_nearly_full;

  
   //----------------------- Modules ---------------------------------

   assign s_axis_tready = !in_fifo_nearly_full;

   //------------------------- Modules-------------------------------

   /* The size of this fifo has to be large enough to fit the previous modules' headers
    * and the ethernet header */
   fallthrough_small_fifo #(.WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1), .MAX_DEPTH_BITS(4))
      input_fifo
        (.din ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),     // Data in
         .wr_en (s_axis_tvalid & ~in_fifo_nearly_full),               // Write enable
         .rd_en (in_fifo_rd_en),       // Read the next word
         .dout ({in_fifo_tlast, in_fifo_tuser, in_fifo_tstrb, in_fifo_tdata}),
         .full (),
         .prog_full (),
         .nearly_full (in_fifo_nearly_full),
         .empty (in_fifo_empty),
         .reset (~axi_resetn),
         .clk (axi_aclk)
         );

   preprocess_control
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH)
       ) preprocess_control
       ( // --- Interface to the previous stage
	  .tdata		    (s_axis_tdata),
          .valid		    (s_axis_tvalid & ~in_fifo_nearly_full),
	  .tlast		    (s_axis_tlast),

         // --- Interface to other preprocess blocks
         .word_IP_DST_HI            (word_IP_DST_HI),
         .word_IP_DST_LO            (word_IP_DST_LO),

         // --- Misc
         .reset                     (~axi_resetn),
         .clk                       (axi_aclk)
         );

   eth_parser
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH),
       .NUM_QUEUES(NUM_QUEUES)
       ) eth_parser
       ( // --- Interface to the previous stage
	 .tdata			(s_axis_tdata),

         // --- Interface to process block
         .is_arp_pkt            (is_arp_pkt),
         .is_ip_pkt             (is_ip_pkt),
         .is_for_us             (is_for_us),
         .is_broadcast          (is_broadcast),
         .mac_dst_port_num      (mac_dst_port_num),
         .eth_parser_rd_info    (rd_preprocess_info),
         .eth_parser_info_vld   (eth_parser_info_vld),

         // --- Interface to preprocess block
         .word_IP_DST_HI        (word_IP_DST_HI),

         // --- Interface to registers
         .mac_0                 (mac_0),    // address of rx queue 0
         .mac_1                 (mac_1),    // address of rx queue 1
         .mac_2                 (mac_2),    // address of rx queue 2
         .mac_3                 (mac_3),    // address of rx queue 3

         // --- Misc
         .reset                 (~axi_resetn),
         .clk                   (axi_aclk)
         );


   ip_lpm
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH),
       .NUM_QUEUES(NUM_QUEUES)
       ) ip_lpm
       ( // --- Interface to the previous stage
	 .tdata		       (s_axis_tdata),

         // --- Interface to arp_lut
         .next_hop_ip          (next_hop_ip),
         .lpm_output_port      (lpm_output_port),
         .lpm_vld              (lpm_vld),
         .lpm_hit              (lpm_hit),

         // --- Interface to preprocess block
         .word_IP_DST_HI       (word_IP_DST_HI),
         .word_IP_DST_LO       (word_IP_DST_LO),

         // --- Interface to registers
         // --- Read port
         .lpm_rd_addr          (lpm_rd_addr),          // address in table to read
         .lpm_rd_req           (lpm_rd_req),           // request a read
         .lpm_rd_ip            (lpm_rd_ip),            // ip to match in the CAM
         .lpm_rd_mask          (lpm_rd_mask),          // subnet mask
         .lpm_rd_oq            (lpm_rd_oq),            // output queue
         .lpm_rd_next_hop_ip   (lpm_rd_next_hop_ip),   // ip addr of next hop
         .lpm_rd_ack           (lpm_rd_ack),           // pulses high

         // --- Write port
         .lpm_wr_addr          (lpm_wr_addr),
         .lpm_wr_req           (lpm_wr_req),
         .lpm_wr_oq            (lpm_wr_oq),
         .lpm_wr_next_hop_ip   (lpm_wr_next_hop_ip),   // ip addr of next hop
         .lpm_wr_ip            (lpm_wr_ip),            // data to match in the CAM
         .lpm_wr_mask          (lpm_wr_mask),
         .lpm_wr_ack           (lpm_wr_ack),

         // --- Misc
         .reset                (~axi_resetn),
         .clk                  (axi_aclk)
         );


   ip_arp
     #(.NUM_QUEUES(NUM_QUEUES)
       ) ip_arp
       ( // --- Interface to ip_arp
         .next_hop_ip       (next_hop_ip),
         .lpm_output_port   (lpm_output_port),
         .lpm_vld           (lpm_vld),
         .lpm_hit           (lpm_hit),

         // --- interface to process block
         .next_hop_mac      (next_hop_mac),
         .output_port       (output_port),
         .arp_mac_vld       (arp_mac_vld),
         .rd_arp_result     (rd_preprocess_info),
         .arp_lookup_hit    (arp_lookup_hit),
         .lpm_lookup_hit    (lpm_lookup_hit),

         // --- Interface to registers
         // --- Read port
         .arp_rd_addr       (arp_rd_addr),          // address in table to read
         .arp_rd_req        (arp_rd_req),           // request a read
         .arp_rd_mac        (arp_rd_mac),           // data read from the LUT at rd_addr
         .arp_rd_ip         (arp_rd_ip),            // ip to match in the CAM
         .arp_rd_ack        (arp_rd_ack),           // pulses high

         // --- Write port
         .arp_wr_addr       (arp_wr_addr),
         .arp_wr_req        (arp_wr_req),
         .arp_wr_mac        (arp_wr_mac),
         .arp_wr_ip         (arp_wr_ip),            // data to match in the CAM
         .arp_wr_ack        (arp_wr_ack),

         // --- Misc
         .reset             (~axi_resetn),
         .clk               (axi_aclk)
         );

   dest_ip_filter
     dest_ip_filter
       ( // --- Interface to the previous stage
	 .tdata		       	   (s_axis_tdata),

         // --- Interface to preprocess block
         .word_IP_DST_HI           (word_IP_DST_HI),
         .word_IP_DST_LO           (word_IP_DST_LO),

         // --- interface to process block
         .dest_ip_hit              (dest_ip_hit),
         .dest_ip_filter_vld       (dest_ip_filter_vld),
         .rd_dest_ip_filter_result (rd_preprocess_info),

         // --- Interface to registers
         // --- Read port
         .dest_ip_filter_rd_addr   (dest_ip_filter_rd_addr),
         .dest_ip_filter_rd_req    (dest_ip_filter_rd_req),
         .dest_ip_filter_rd_ip     (dest_ip_filter_rd_ip), // ip to match in the cam
         .dest_ip_filter_rd_ack    (dest_ip_filter_rd_ack),

         // --- Write port
         .dest_ip_filter_wr_addr   (dest_ip_filter_wr_addr),
         .dest_ip_filter_wr_req    (dest_ip_filter_wr_req),
         .dest_ip_filter_wr_ip     (dest_ip_filter_wr_ip),
         .dest_ip_filter_wr_ack    (dest_ip_filter_wr_ack),

         // --- Misc
         .reset                    (~axi_resetn),
         .clk                      (axi_aclk)
         );


   ip_checksum_ttl
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH)
       ) ip_checksum_ttl
       ( //--- datapath interface
	 .tdata		       	    (s_axis_tdata),
         .valid		    	    (s_axis_tvalid & ~in_fifo_nearly_full),

         //--- interface to preprocess
         .word_IP_DST_HI            (word_IP_DST_HI),
         .word_IP_DST_LO            (word_IP_DST_LO),

         // --- interface to process
         .ip_checksum_vld           (ip_checksum_vld),
         .ip_checksum_is_good       (ip_checksum_is_good),
         .ip_hdr_has_options        (ip_hdr_has_options),
         .ip_ttl_is_good            (ip_ttl_is_good),
         .ip_new_ttl                (ip_new_ttl),
         .ip_new_checksum           (ip_new_checksum),     // new checksum assuming decremented TTL
         .rd_checksum               (rd_preprocess_info),

         // misc
         .reset                     (~axi_resetn),
         .clk                       (axi_aclk)
         );


   op_lut_hdr_parser
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH),
       .C_S_AXIS_TUSER_WIDTH (C_S_AXIS_TUSER_WIDTH),
       .NUM_QUEUES(NUM_QUEUES)
       ) op_lut_hdr_parser
       ( // --- Interface to the previous stage
	  .tdata		(s_axis_tdata),
          .tuser		(s_axis_tuser),
          .valid		(s_axis_tvalid & ~in_fifo_nearly_full),
	  .tlast		(s_axis_tlast),

         // --- Interface to process block
         .is_from_cpu           (is_from_cpu),
         .to_cpu_output_port    (to_cpu_output_port),
         .from_cpu_output_port  (from_cpu_output_port),
         .input_port_num        (input_port_num),
         .rd_hdr_parser         (rd_preprocess_info),
         .is_from_cpu_vld       (is_from_cpu_vld),

         // --- Misc
         .reset                 (~axi_resetn),
         .clk                   (axi_aclk)
         );


   op_lut_process_sm
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH),
       .C_S_AXIS_TUSER_WIDTH (C_S_AXIS_TUSER_WIDTH),
       .NUM_QUEUES(NUM_QUEUES)
       ) op_lut_process_sm
       ( // --- interface to input fifo - fallthrough
         .in_fifo_vld                   (!in_fifo_empty),
         .in_fifo_tdata                 (in_fifo_tdata),
	 .in_fifo_tlast			(in_fifo_tlast),
	 .in_fifo_tuser			(in_fifo_tuser),
	 .in_fifo_tstrb			(in_fifo_tstrb),
         .in_fifo_rd_en                 (in_fifo_rd_en),

         // --- interface to eth_parser
         .is_arp_pkt                    (is_arp_pkt),
         .is_ip_pkt                     (is_ip_pkt),
         .is_for_us                     (is_for_us),
         .is_broadcast                  (is_broadcast),
         .mac_dst_port_num              (mac_dst_port_num),
         .eth_parser_info_vld           (eth_parser_info_vld),

         // --- interface to ip_arp
         .next_hop_mac                  (next_hop_mac),
         .output_port                   (output_port),
         .arp_mac_vld                   (arp_mac_vld),
         .arp_lookup_hit                (arp_lookup_hit),
         .lpm_lookup_hit                (lpm_lookup_hit),

         // --- interface to op_lut_hdr_parser
         .is_from_cpu                   (is_from_cpu),
         .to_cpu_output_port            (to_cpu_output_port),
         .from_cpu_output_port          (from_cpu_output_port),
         .is_from_cpu_vld               (is_from_cpu_vld),
         .input_port_num                (input_port_num),

         // --- interface to dest_ip_filter
         .dest_ip_hit                   (dest_ip_hit),
         .dest_ip_filter_vld            (dest_ip_filter_vld),

         // --- interface to IP_checksum
         .ip_checksum_vld               (ip_checksum_vld),
         .ip_checksum_is_good           (ip_checksum_is_good),
         .ip_new_checksum               (ip_new_checksum),     // new checksum assuming decremented TTL
         .ip_ttl_is_good                (ip_ttl_is_good),
         .ip_new_ttl                    (ip_new_ttl),
         .ip_hdr_has_options            (ip_hdr_has_options),

         // -- connected to all preprocess blocks
         .rd_preprocess_info            (rd_preprocess_info),

         // --- interface to next module
         .out_tvalid                    (m_axis_tvalid),
         .out_tlast 	                (m_axis_tlast),
         .out_tdata                     (m_axis_tdata),
         .out_tuser                     (m_axis_tuser),     // new checksum assuming decremented TTL
         .out_tready                    (m_axis_tready),
	 .out_tstrb			(m_axis_tstrb),

         // --- interface to registers
         .pkt_sent_from_cpu             (pkt_sent_from_cpu),              // pulsed: we've sent a pkt from the CPU
         .pkt_sent_to_cpu_options_ver   (pkt_sent_to_cpu_options_ver),    // pulsed: we've sent a pkt to the CPU coz it has options/bad version
         .pkt_sent_to_cpu_bad_ttl       (pkt_sent_to_cpu_bad_ttl),        // pulsed: sent a pkt to the CPU coz the TTL is 1 or 0
         .pkt_sent_to_cpu_dest_ip_hit   (pkt_sent_to_cpu_dest_ip_hit),    // pulsed: sent a pkt to the CPU coz it has hit in the destination ip filter list
         .pkt_forwarded                 (pkt_forwarded),             	  // pulsed: forwarded pkt to the destination port
         .pkt_dropped_checksum          (pkt_dropped_checksum),           // pulsed: dropped pkt coz bad checksum
         .pkt_sent_to_cpu_non_ip        (pkt_sent_to_cpu_non_ip),         // pulsed: sent pkt to cpu coz it's not IP
         .pkt_sent_to_cpu_arp_miss      (pkt_sent_to_cpu_arp_miss),       // pulsed: sent pkt to cpu coz no entry in arp table
         .pkt_sent_to_cpu_lpm_miss      (pkt_sent_to_cpu_lpm_miss),       // pulsed: sent pkt to cpu coz no entry in lpm table
         .pkt_dropped_wrong_dst_mac     (pkt_dropped_wrong_dst_mac),      // pulsed: dropped pkt not destined to us
         .mac_0                         (mac_0),    // address of rx queue 0
         .mac_1                         (mac_1),    // address of rx queue 1
         .mac_2                         (mac_2),    // address of rx queue 2
         .mac_3                         (mac_3),    // address of rx queue 3

         // misc
         .reset                         (~axi_resetn),
         .clk                           (axi_aclk)
         );


// remember: assert tvalid with the right output port...then wait for tready signal and send data.

endmodule // output_port_lookup

