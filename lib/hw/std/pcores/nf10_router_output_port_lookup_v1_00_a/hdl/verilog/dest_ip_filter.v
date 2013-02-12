/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        dest_ip_filter.v
 *
 *  Library:
 *        std/pcores/nf10_router_output_port_lookup_v1_00_a
 *
 *  Module:
 *        dest_ip_filter
 *
 *  Author:
 *        grg, Gianni Antichi
 *
 *  Description:
 *        
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


  module dest_ip_filter
    #(parameter C_S_AXIS_DATA_WIDTH=256,
      parameter LUT_DEPTH = 16,
      parameter LUT_DEPTH_BITS = log2(LUT_DEPTH)
      )
   (// --- Interface to the previous stage
    input  [C_S_AXIS_DATA_WIDTH-1:0]   tdata,

    // --- Interface to process block
    output                             dest_ip_hit,
    output                             dest_ip_filter_vld,
    input                              rd_dest_ip_filter_result,

    // --- Interface to preprocess block
    input                              word_IP_DST_HI,
    input                              word_IP_DST_LO,

    // --- Interface to registers
    // --- Read port
    input  [LUT_DEPTH_BITS-1:0]        dest_ip_filter_rd_addr,          // address in table to read
    input                              dest_ip_filter_rd_req,           // request a read
    output [31:0]                      dest_ip_filter_rd_ip,            // ip to match in the CAM
    output                             dest_ip_filter_rd_ack,           // pulses high

    // --- Write port
    input [LUT_DEPTH_BITS-1:0]         dest_ip_filter_wr_addr,
    input                              dest_ip_filter_wr_req,
    input [31:0]                       dest_ip_filter_wr_ip,            // data to match in the CAM
    output                             dest_ip_filter_wr_ack,

    // --- Misc
    input                              reset,
    input                              clk
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

   //---------------------- Wires and regs----------------------------

   wire                                  cam_busy;
   wire                                  cam_match;
   wire [LUT_DEPTH-1:0]                  cam_match_addr;
   wire [31:0]                           cam_cmp_din, cam_cmp_data_mask;
   wire [31:0]                           cam_din, cam_data_mask;
   wire                                  cam_we;
   wire [LUT_DEPTH_BITS-1:0]             cam_wr_addr;

   reg                                   dst_ip_vld;
   reg [31:0]                            dst_ip;

   //------------------------- Modules-------------------------------

   // 1 cycle read latency, 2 cycles write latency
   // priority encoded for the smallest address.
   cam dest_ip_cam
     (
      // Outputs
      .BUSY                             (cam_busy),
      .MATCH                            (cam_match),
      .MATCH_ADDR                       (cam_match_addr),
      // Inputs
      .CLK                              (clk),
      .CMP_DIN                          (cam_cmp_din),
      .DIN                              (cam_din),
      .WE                               (cam_we),
      .WR_ADDR                          (cam_wr_addr));

   unencoded_cam_lut_sm
     #(.CMP_WIDTH(32),                  // IPv4 addr width
       .DATA_WIDTH(1),                  // no data
       .LUT_DEPTH(LUT_DEPTH),
       .DEFAULT_DATA(0)
      ) cam_lut_sm
       (// --- Interface for lookups
        .lookup_req          (dst_ip_vld),
        .lookup_cmp_data     (dst_ip),
        .lookup_cmp_dmask    (32'h0),
        .lookup_ack          (lookup_ack),
        .lookup_hit          (lookup_hit),
        .lookup_data         (),

        // --- Interface to registers
        // --- Read port
        .rd_addr             (dest_ip_filter_rd_addr),    // address in table to read
        .rd_req              (dest_ip_filter_rd_req),     // request a read
        .rd_data             (),                          // data found for the entry
        .rd_cmp_data         (dest_ip_filter_rd_ip),      // matching data for the entry
        .rd_cmp_dmask        (),                          // don't cares entry
        .rd_ack              (dest_ip_filter_rd_ack),     // pulses high

        // --- Write port
        .wr_addr             (dest_ip_filter_wr_addr),
        .wr_req              (dest_ip_filter_wr_req),
        .wr_data             (1'b0),                    // data found for the entry
        .wr_cmp_data         (dest_ip_filter_wr_ip),    // matching data for the entry
        .wr_cmp_dmask        (32'h0),                   // don't cares for the entry
        .wr_ack              (dest_ip_filter_wr_ack),

        // --- CAM interface
        .cam_busy            (cam_busy),
        .cam_match           (cam_match),
        .cam_match_addr      (cam_match_addr),
        .cam_cmp_din         (cam_cmp_din),
        .cam_din             (cam_din),
        .cam_we              (cam_we),
        .cam_wr_addr         (cam_wr_addr),
        .cam_cmp_data_mask   (cam_cmp_data_mask),
        .cam_data_mask       (cam_data_mask),

        // --- Misc
        .reset               (reset),
        .clk                 (clk));

   fallthrough_small_fifo #(.WIDTH(1), .MAX_DEPTH_BITS(2))
      dest_ip_filter_fifo
        (.din           (lookup_hit), // Data in
         .wr_en         (lookup_ack),             // Write enable
         .rd_en         (rd_dest_ip_filter_result),       // Read the next word
         .dout          (dest_ip_hit),
         .full          (),
         .nearly_full   (),
         .prog_full     (),
         .empty         (empty),
         .reset         (reset),
         .clk           (clk)
         );

   //------------------------- Logic --------------------------------

   assign dest_ip_filter_vld = !empty;

   /*****************************************************************
    * find the dst IP address and do the lookup
    *****************************************************************/
   always @(posedge clk) begin
      if(reset) begin
         dst_ip <= 0;
         dst_ip_vld <= 0;
      end
      else begin
         if(word_IP_DST_HI) begin
            dst_ip[15:0] <= tdata[255:240];
            dst_ip_vld <= 0;
         end
         if(word_IP_DST_LO) begin
            dst_ip[31:16]  <= tdata[15:0];
            dst_ip_vld <= 1;
         end
         else begin
            dst_ip_vld <= 0;
         end
      end // else: !if(reset)
   end // always @ (posedge clk)

endmodule // dest_ip_filter



