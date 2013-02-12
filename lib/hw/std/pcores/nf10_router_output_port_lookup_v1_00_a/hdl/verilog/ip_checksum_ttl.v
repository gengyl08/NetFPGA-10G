/*******************************************************************************
 * 
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        ip_checksum_ttl.v
 *
 *  Library:
 *        std/pcores/nf10_router_output_port_lookup_v1_00_a
 *
 *  Module:
 *        ip_checksum_ttl
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


`timescale 1ns/100ps
module ip_checksum_ttl
  #(parameter C_S_AXIS_DATA_WIDTH=256)
  (
   //--- datapath interface
   input  [C_S_AXIS_DATA_WIDTH-1:0]   tdata,
   input                              valid,

   //--- interface to preprocess
   input                              word_IP_DST_HI,
   input                              word_IP_DST_LO,

   // --- interface to process
   output                             ip_checksum_vld,
   output                             ip_checksum_is_good,
   output                             ip_hdr_has_options,
   output                             ip_ttl_is_good,
   output     [7:0]                   ip_new_ttl,
   output     [15:0]                  ip_new_checksum,     // new checksum assuming decremented TTL
   input                              rd_checksum,

   // misc
   input reset,
   input clk
   );

   //---------------------- Wires and regs---------------------------
   reg [19:0]  checksum, checksum_next;
   reg [16:0]  adjusted_checksum;
   reg         checksum_done;
   wire        empty;
   reg  [7:0]  ttl_new;
   reg         ttl_good;
   reg         hdr_has_options;
   reg         add_carry;
   reg	       add_carry_d1;

   reg [19:0]  cksm_sum_0, cksm_sum_1, cksm_sum_0_next, cksm_sum_1_next, cksm_sum_2, cksm_sum_2_next, cksm_sum_3, cksm_sum_3_next;
   wire [19:0] cksm_temp,cksm_temp2;

   //------------------------- Modules-------------------------------

   fallthrough_small_fifo #(.WIDTH(27), .MAX_DEPTH_BITS(2))
      arp_fifo
        (.din ({&checksum[15:0], adjusted_checksum[15:0], ttl_good, ttl_new, hdr_has_options}), // {IP good, new checksum}
         .wr_en (checksum_done),             // Write enable
         .rd_en (rd_checksum),               // Read the next word
         .dout ({ip_checksum_is_good, ip_new_checksum, ip_ttl_is_good, ip_new_ttl, ip_hdr_has_options}),
         .full (),
         .nearly_full (),
         .prog_full (),
         .empty (empty),
         .reset (reset),
         .clk (clk)
         );

   //------------------------- Logic -------------------------------
   assign ip_checksum_vld = !empty;

   assign cksm_temp = cksm_sum_0 + cksm_sum_1;// + cksm_sum_2;
   assign cksm_temp2 = cksm_sum_2 + cksm_sum_3;

   always @(*) begin
      checksum_next = checksum;
      cksm_sum_0_next = cksm_sum_0;
      cksm_sum_1_next = cksm_sum_1;
      cksm_sum_2_next = cksm_sum_2;
      cksm_sum_3_next = cksm_sum_3;
      if(word_IP_DST_HI) begin
	 cksm_sum_0_next = tdata[127:112]+tdata[143:128]+tdata[159:144];
	 cksm_sum_1_next = tdata[175:160]+tdata[191:176];
	 cksm_sum_2_next = tdata[207:192]+tdata[223:208];
	 cksm_sum_3_next = tdata[239:224]+tdata[255:240];
      end
      if(word_IP_DST_LO) begin
         checksum_next = cksm_temp + cksm_temp2 + tdata[15:0];
      end
      if(add_carry) begin
	 checksum_next = checksum[19:16] + checksum[15:0];
      end
   end // always @ (*)

   // checksum logic. 16bit 1's complement over the IP header.
   // --- see RFC1936 for guidance.
   // If checksum is good then it should be 0xffff
   always @(posedge clk) begin
      if(reset) begin
         adjusted_checksum <= 17'h0; // calculates the new chksum
         checksum_done <= 0;
         ttl_new <= 0;
         ttl_good <= 0;
         hdr_has_options <= 0;
	 checksum <= 20'h0;
         add_carry <= 0;
	 add_carry_d1 <= 0;

         cksm_sum_0 <= 0;
         cksm_sum_1 <= 0;
         cksm_sum_2 <= 0;
         cksm_sum_3 <= 0;
      end
      else begin
	 checksum <= checksum_next;
         cksm_sum_0 <= cksm_sum_0_next;
         cksm_sum_1 <= cksm_sum_1_next;
         cksm_sum_2 <= cksm_sum_2_next;
         cksm_sum_3 <= cksm_sum_3_next;
         /* make sure the version is correct and there are no options */
         if(word_IP_DST_HI) begin
            hdr_has_options <= (tdata[119:112]!=8'h45);
	    ttl_new <= (tdata[183:176]==8'h0) ? 8'h0 : tdata[183:176] - 1'b1;
	    ttl_good <= (tdata[183:176] > 8'h1);
            adjusted_checksum <= {1'h0, tdata[207:192]} + 17'h0001; // adjust for the decrement in TTL (Little Endian)
         end

         if(word_IP_DST_LO) begin
            adjusted_checksum <= {1'h0, adjusted_checksum[15:0]} + adjusted_checksum[16];
            add_carry <= 1;
         end
         else begin
            add_carry <= 0;
         end

         if(add_carry) begin
	    add_carry_d1 <= 1;	
           // checksum_done <= 1;
         end
	 else
            add_carry_d1 <= 0;


	 if(add_carry_d1) begin
	    checksum_done <= 1;
	    add_carry <= 0;		
	 end

         else begin
            checksum_done <= 0;
         end

         // synthesis translate_off
         // If we have any carry left in top 4 bits then algorithm is wrong
         if (checksum_done && checksum[19:16] != 4'h0) begin
            $display("%t %m ERROR: top 4 bits of checksum_word_0 not zero - algo wrong???",
                     $time);
            #100 $stop;
         end
         // synthesis translate_on

      end // else: !if(reset)
   end // always @ (posedge clk)

endmodule // IP_checksum
