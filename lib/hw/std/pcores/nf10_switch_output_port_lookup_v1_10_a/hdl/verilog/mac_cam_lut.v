/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        mac_cam_lut.v
 *
 *  Library:
 *        /hw/contrib/pcores/nf10_switch_output_port_lookup_v1_10_a
 *
 *  Module:
 *        mac_cam_lut
 *
 *  Author:
 *        Gianni Antichi
 *
 *  Description:
 *        learning CAM switch core functionality
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

`timescale 1ns/1ps

module mac_cam_lut
    #(parameter NUM_OUTPUT_QUEUES = 8,
      parameter LUT_DEPTH_BITS = 4,
      parameter LUT_DEPTH = 2**LUT_DEPTH_BITS,
      parameter DEFAULT_MISS_OUTPUT_PORTS = 8'h55) // only send to the MAC txfifos not the cpu

   ( // --- core functionality signals
     input [47:0]                       dst_mac,
     input [47:0]                       src_mac,
     input [NUM_OUTPUT_QUEUES-1:0]      src_port,
     input                              lookup_req,
     output[NUM_OUTPUT_QUEUES-1:0]      dst_ports,
  
     // --- lookup done signal
     output reg                         lookup_done,          // pulses high on lookup done
     output reg				lut_miss,
     output reg				lut_hit,   

     // --- Misc
     input                              clk,
     input                              reset

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
   localparam RESET            = 1;
   localparam IDLE             = 2;
   localparam LATCH_DST_LOOKUP = 4;
   localparam CHECK_SRC_MATCH  = 8;
   localparam UPDATE_ENTRY     = 16;
   localparam ADD_ENTRY        = 32;

   //---------------------- Wires and regs----------------------------

   wire [NUM_OUTPUT_QUEUES-1:0]          rd_oq;            // data read from the LUT at rd_addr
   wire                                  rd_wr_protect;    // wr_protect bit read
   wire [47:0]				 rd_mac;

   wire                                  cam_busy;
   wire                                  cam_match;
   wire [LUT_DEPTH_BITS-1:0]             cam_match_addr;
   reg  [LUT_DEPTH_BITS-1:0]             cam_match_addr_d1;
   reg  [47:0]                           cam_cmp_din;
    
   reg  [47:0]                           cam_din, cam_din_next;
   reg                                   cam_we, cam_we_next;
   reg  [LUT_DEPTH_BITS-1:0]             cam_wr_addr, cam_wr_addr_next;

   reg  [NUM_OUTPUT_QUEUES-1:0]          src_port_latched;
   reg  [47:0]                           src_mac_latched;
   reg                                   latch_src;

   reg  [5:0]                            lookup_state, lookup_state_next;

   reg [LUT_DEPTH_BITS-1:0]              lut_rd_addr, lut_wr_addr, lut_wr_addr_next;
   reg                                   lut_wr_en, lut_wr_en_next;
   reg [NUM_OUTPUT_QUEUES+48:0]          lut_wr_data, lut_wr_data_next;
   reg [NUM_OUTPUT_QUEUES+48:0]          lut_rd_data;
   reg [NUM_OUTPUT_QUEUES+48:0]          lut[LUT_DEPTH-1:0];

   reg                                   reset_count_inc;
   reg [LUT_DEPTH_BITS:0]                reset_count;

   reg                                   lut_miss_next;
   reg    				 lut_hit_next;
   reg					 lookup_done_next;


   //------------------------- Modules-------------------------------

   // 1 cycle read latency, 16 cycles write latency
   cam mac_cam
     (  
      (* box_type = "user_black_box" *)
      // Outputs
      .BUSY                             (cam_busy),
      .MATCH                            (cam_match),
      .MATCH_ADDR                       (cam_match_addr[LUT_DEPTH_BITS-1:0]),
      // Inputs
      .CLK                              (clk),
      .CMP_DIN                          (cam_cmp_din),
      .DIN                              (cam_din[47:0]),
      .WE                               (cam_we),
      .WR_ADDR                          (cam_wr_addr[LUT_DEPTH_BITS-1:0]));

   //------------------------- Logic --------------------------------


   /* assign lut outputs */
   assign rd_oq = lut_rd_data[NUM_OUTPUT_QUEUES+47:48];
   assign rd_wr_protect = lut_rd_data[NUM_OUTPUT_QUEUES+48];
   assign rd_mac = lut_rd_data[47:0];

   /* if we get a miss then set the dst port to the default ports
    * without the source */
   assign dst_ports = (lut_miss) ? (DEFAULT_MISS_OUTPUT_PORTS & ~src_port)
                                           : (rd_oq & ~src_port);

   assign entry_needs_update = ((rd_oq!=src_port) && !rd_wr_protect);

 
   always @(*) begin
      cam_wr_addr_next = cam_match_addr;
      cam_din_next     = src_mac_latched;
      cam_we_next      = 0;
      cam_cmp_din      = 0;
      lut_rd_addr      = cam_match_addr;
      lut_wr_en_next   = 1'b0;
      lut_wr_data_next = {1'b0, src_port_latched, src_mac_latched};
      lut_wr_addr_next = cam_match_addr;
      reset_count_inc  = 0;
      latch_src        = 0;
      lookup_done_next = 0;
      lut_miss_next    = 0;
      lut_hit_next     = 0;

      lookup_state_next = lookup_state;

      case(lookup_state)
        /* write to all locations */
        RESET: begin
           if( !cam_we && !cam_busy && reset_count < LUT_DEPTH-1) begin
              cam_wr_addr_next = reset_count;
              cam_we_next = 1;
              cam_din_next = 0;
              reset_count_inc = 1;
              lut_wr_addr_next = reset_count;
              lut_wr_data_next = 0;
              lut_wr_en_next = 1;
           end
           // write the broadcast
           else if( !cam_we && !cam_busy && reset_count == LUT_DEPTH-1) begin
              cam_wr_addr_next = reset_count;
              cam_we_next = 1;
              cam_din_next = ~48'h0;
              // -- just debug -- cam_din_next = 48'haaaaaaaaaaaa;
              reset_count_inc = 1;
              // write the broadcast address
              lut_wr_addr_next = reset_count;
              lut_wr_data_next = {1'b1, DEFAULT_MISS_OUTPUT_PORTS, ~48'h0};
              // -- just debug-- lut_wr_data_next = {1'b1, 8'hff, 48'haaaaaaaaaaaa};
	      lut_wr_en_next = 1;
           end
           else if(!cam_we && !cam_busy) begin
              lookup_state_next = IDLE;
           end
        end // case: RESET 

        IDLE: begin
           cam_cmp_din = dst_mac;
           if(lookup_req) begin
              lookup_state_next = LATCH_DST_LOOKUP;
              latch_src = 1;
           end
        end // case: IDLE

        LATCH_DST_LOOKUP: begin
           /* latch the info from the lut if we have a match */
            lookup_done_next = 1;
            if(!cam_match)
		lut_miss_next = 1;
	    else
		lut_hit_next = 1;
           /* if the cam is not busy, then see if the source mac is in the table */
           cam_cmp_din = src_mac_latched;
           if(!cam_busy) begin
              lookup_state_next = CHECK_SRC_MATCH;
           end
           else begin
              lookup_state_next = IDLE;
           end
        end // case: LATCH_DST_LOOKUP
        
	CHECK_SRC_MATCH: begin
           /* look for an empty address in case we need it */
           cam_cmp_din = 0;
           /* if we have a match then wait for lut output */
           if(cam_match) begin
              lookup_state_next = UPDATE_ENTRY;
           end
           /* otherwise we need to add the entry */
           else begin
              lookup_state_next = ADD_ENTRY;
           end
        end // case: CHECK_SRC_MATCH

        UPDATE_ENTRY: begin
           if(entry_needs_update) begin
              lut_wr_addr_next = cam_match_addr_d1;
              lut_wr_en_next = 1;
           end
           lookup_state_next = IDLE;
        end

        ADD_ENTRY: begin
           /* if we found an empty spot */
           if(cam_match) begin
              lut_wr_addr_next = cam_match_addr;
              lut_wr_en_next = 1;
              cam_wr_addr_next = cam_match_addr;
              cam_we_next = 1;
           end
           lookup_state_next = IDLE;
        end

        default: begin end
      endcase // case(lookup_state)
   end // always @ (*)

   always @(posedge clk) begin
      if(reset) begin
         lut_rd_data       <= 0;
         reset_count       <= 0;
         src_port_latched  <= 0;
         src_mac_latched   <= 0;
         lookup_done       <= 0;
         lut_miss          <= 0;
         lut_hit	   <= 0;
         cam_match_addr_d1 <= 0;

         cam_wr_addr       <= 0;
         cam_din           <= 0;
         cam_we            <= 0;
         lut_wr_en         <= 0;
         lut_wr_data       <= 0;
         lut_wr_addr       <= 0;

         lookup_state      <= RESET;
      end
      else begin
         reset_count       <= reset_count_inc ? reset_count + 1 : reset_count;
         src_port_latched  <= latch_src ? src_port : src_port_latched;
         src_mac_latched   <= latch_src ? src_mac : src_mac_latched;
         lookup_done       <= lookup_done_next;
         lut_miss          <= lut_miss_next;
         lut_hit	   <= lut_hit_next;

         lut_rd_data       <= lut[lut_rd_addr];
         if(lut_wr_en) begin
            lut[lut_wr_addr] <= lut_wr_data;
         end

         cam_match_addr_d1 <= cam_match_addr;

         cam_wr_addr       <= cam_wr_addr_next;
         cam_din           <= cam_din_next;
         cam_we            <= cam_we_next;
         lut_wr_en         <= lut_wr_en_next;
         lut_wr_data       <= lut_wr_data_next;
         lut_wr_addr       <= lut_wr_addr_next;

         lookup_state      <= lookup_state_next;
      end
   end

   // synthesis translate_off
   always @(posedge clk) begin
      if(lookup_state==LATCH_DST_LOOKUP && cam_busy && src_mac_latched == dst_mac) begin
         $display("%t %m WARNING: requested lookup for addr %012x while CAM is busy writing it. Returning broadcast.", $time, dst_mac);
      end
   end
   // synthesis translate_on

endmodule // mac_lut

