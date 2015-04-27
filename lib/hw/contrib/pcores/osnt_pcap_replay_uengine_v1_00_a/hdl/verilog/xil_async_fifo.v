/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        xil_async_fifo.v
 *
 *  Library:
 *        hw/osnt/pcores/nf10_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        xil_async_fifo
 *
 *  Author:
 *        Muhammad Shahbaz
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

module xil_async_fifo
#(
    parameter DIN_WIDTH  = 288,
    parameter DOUT_WIDTH = 144
)
(
    input                      rst,
    input                      wr_clk,
    input                      wr_en,
    input [DIN_WIDTH-1:0]  		 din,
    input                      rd_clk,
    input                      rd_en,
    output [DOUT_WIDTH-1:0]		 dout,
    output                     full,
    output                     prog_full,
    output                     empty
);

  // -- Modules and Logic
	
  generate 
	  if (DIN_WIDTH==288 && DOUT_WIDTH==144) begin: _fifo_288_to_144_fwft
			fifo_generator_v8_4_288_to_144_fwft _inst (
		  	.rst(rst), // input rst
		 	 	.wr_clk(wr_clk), // input wr_clk
		  	.rd_clk(rd_clk), // input rd_clk
		  	.din(din), // input [287 : 0] din
		  	.wr_en(wr_en), // input wr_en
		  	.rd_en(rd_en), // input rd_en
		  	.dout(dout), // output [287 : 0] dout
		  	.full(full), // output full
		  	.empty(empty) // output empty
			);
		end
		else if (DIN_WIDTH==4 && DOUT_WIDTH==2) begin: _fifo_4_to_2_fwft
			fifo_generator_v8_4_4_to_2_fwft _inst (
		  	.rst(rst), // input rst
		 	 	.wr_clk(wr_clk), // input wr_clk
		  	.rd_clk(rd_clk), // input rd_clk
		  	.din(din), // input [287 : 0] din
		  	.wr_en(wr_en), // input wr_en
		  	.rd_en(rd_en), // input rd_en
		  	.dout(dout), // output [287 : 0] dout
		  	.full(full), // output full
		  	.empty(empty) // output empty
			);
		end
		else if (DIN_WIDTH==144 && DOUT_WIDTH==288) begin: _fifo_144_to_288_fwft
			fifo_generator_v8_4_144_to_288_fwft _inst (
	  		.rst(rst), // input rst
	 	 		.wr_clk(wr_clk), // input wr_clk
	  		.rd_clk(rd_clk), // input rd_clk
	  		.din(din), // input [287 : 0] din
	  		.wr_en(wr_en), // input wr_en
	  		.rd_en(rd_en), // input rd_en
	  		.dout(dout), // output [287 : 0] dout
	  		.full(full), // output full
		  	.prog_full(prog_full), // output prog_full
	  		.empty(empty) // output empty
			);
		end
		else if (DIN_WIDTH==9 && DOUT_WIDTH==9) begin: _fifo_9_to_9
			fifo_generator_v8_4_9_to_9 _inst (
	  		.rst(rst), // input rst
	 	 		.wr_clk(wr_clk), // input wr_clk
	  		.rd_clk(rd_clk), // input rd_clk
	  		.din(din), // input [287 : 0] din
	  		.wr_en(wr_en), // input wr_en
	  		.rd_en(rd_en), // input rd_en
	  		.dout(dout), // output [287 : 0] dout
	  		.empty(empty) // output empty
			);
		end
	endgenerate
	
endmodule
