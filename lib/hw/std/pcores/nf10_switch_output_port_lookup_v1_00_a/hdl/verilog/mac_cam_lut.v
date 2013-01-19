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
 *        Muhammad Shahbaz
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
 #(
   parameter NUM_OUTPUT_QUEUES = 8,
   parameter LUT_DEPTH_BITS    = 4,
   parameter LUT_DEPTH         = 2**LUT_DEPTH_BITS,
   parameter DEFAULT_MISS_OUTPUT_PORTS = 8'h55     // only send to the MAC txfifos not the cpu
 )
 (
   // --- core functionality signals
   input  [47:0]                       dst_mac,
   input  [47:0]                       src_mac,
   input  [NUM_OUTPUT_QUEUES-1:0]      src_port,
   input                               lookup_req,
   output reg [NUM_OUTPUT_QUEUES-1:0]  dst_ports,
   
   // --- lookup done signal
   output reg                          lookup_done,   // pulses high on lookup done
   output reg                          lut_miss,
   output reg                          lut_hit,
   
   // --- Misc
   input                               clk,
   input                               reset
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
 
  //---------------------- Wires and regs----------------------------
  
  genvar i;
  //integer j;
   
  reg [NUM_OUTPUT_QUEUES+48-1:0]    lut [0:LUT_DEPTH-1];
  reg [LUT_DEPTH_BITS-1:0]		    lut_wr_addr;
  
  //------------------------- Logic --------------------------------
  
  generate
    // LUT Lookup
    for (i=0; i<LUT_DEPTH; i=i+1)
	begin: LUT_LOOKUP
	  wire [NUM_OUTPUT_QUEUES-1:0]    rd_oq;
      wire                            hit;
  
	  if (i == 0) begin: _0
	    assign LUT_LOOKUP[i].rd_oq = (lut[i][47:0] == dst_mac) ? lut[i][NUM_OUTPUT_QUEUES+48-1:48] 
		                                                       : {(NUM_OUTPUT_QUEUES){1'b0}};
		assign LUT_LOOKUP[i].hit   = (lut[i][47:0] == dst_mac) ? 1                                 
		                                                       : 0;
      end
	  else begin: _N
	    assign LUT_LOOKUP[i].rd_oq = (lut[i][47:0] == dst_mac) ? lut[i][NUM_OUTPUT_QUEUES+48-1:48] 
		                                                       : LUT_LOOKUP[i-1].rd_oq;
		assign LUT_LOOKUP[i].hit   = (lut[i][47:0] == dst_mac) ? 1                                 
		                                                       : LUT_LOOKUP[i-1].hit;
	  end
	end
	
	// LUT Learn
	for (i=0; i<LUT_DEPTH; i=i+1)
	begin: LUT_LEARN
	  wire                           hit;
	  
	  if (i == 0) begin: _0
		assign LUT_LEARN[i].hit     = (lut[i][47:0] == src_mac) ? 1      
		                                                        : 0;
      end
	  else begin: _N
		assign LUT_LEARN[i].hit     = (lut[i][47:0] == src_mac) ? 1      
		                                                        : LUT_LEARN[i-1].hit;
	  end
	  
	  always @ (posedge clk) begin: _A
	    if (reset)
		  lut[i] <= {(NUM_OUTPUT_QUEUES+48-1){1'b0}};
		else if (lookup_req) begin
		  if ((lut[i][47:0] == src_mac) ||                         // if src_mac         matches in the LUT
		      (~LUT_LEARN[LUT_DEPTH-1].hit && (lut_wr_addr == i))) // if src_mac doesn't matches in the LUT 
	        lut[i] <= {src_port, src_mac};
		end
	  end
	end
  endgenerate
  
  always @ (posedge clk) begin
    if(reset) begin
      lut_hit  <= 0;
	  lut_miss <= 0;
	  
	  lookup_done <= 0;
	  dst_ports   <= {NUM_OUTPUT_QUEUES{1'b0}};
	  
	  lut_wr_addr <= {LUT_DEPTH_BITS{1'b0}};
	end
	else begin
	  lut_hit     <= 0;
	  lut_miss    <= 0;
	  lookup_done <= 0;
	  
	  if (lookup_req) begin
	    lut_hit  <= LUT_LOOKUP[LUT_DEPTH-1].hit;
		lut_miss <= ~LUT_LOOKUP[LUT_DEPTH-1].hit;
		
	    /* if we get a miss then set the dst port to the default ports
         * without the source */
        dst_ports <= (LUT_LOOKUP[LUT_DEPTH-1].hit) ? (LUT_LOOKUP[LUT_DEPTH-1].rd_oq & ~src_port)
                                                   : (DEFAULT_MISS_OUTPUT_PORTS     & ~src_port);
	    lookup_done <= 1;
		
		if (~LUT_LEARN[LUT_DEPTH-1].hit)
		  lut_wr_addr <= lut_wr_addr + 1;
	  end
	end
  end
  
endmodule  
