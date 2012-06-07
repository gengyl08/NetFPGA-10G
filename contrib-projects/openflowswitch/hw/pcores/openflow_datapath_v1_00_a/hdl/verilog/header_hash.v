///////////////////////////////////////////////////////////////////////////////
// $Id: header_hash.v 3582 2008-04-10 19:53:37Z jnaous $
//
// Module: header_hash.v
// Project: NF2.1 OpenFlow Switch
// Author: Jad Naous <jnaous@stanford.edu>
// Description: uses two hashing functions on a 256-bit input to produce two
//              hash indices. Hashing function 0 is the ethernet CRC.
//
//              In terms of timing, the inidces are valid the next cycle.
//
// Licensing: In addition to the NetFPGA license, the following license applies
//            to the source code in the OpenFlow Switch implementation on NetFPGA.
//
// Copyright (c) 2008 The Board of Trustees of The Leland Stanford Junior University
//
// We are making the OpenFlow specification and associated documentation (Software)
// available for public use and benefit with the expectation that others will use,
// modify and enhance the Software and contribute those enhancements back to the
// community. However, since we would like to make the Software available for
// broadest use, with as few restrictions as possible permission is hereby granted,
// free of charge, to any person obtaining a copy of this Software to deal in the
// Software under the copyrights without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// The name and trademarks of copyright holder(s) may NOT be used in advertising
// or publicity pertaining to the Software or any derivatives without specific,
// written prior permission.
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 1ps

`include "crc_func_0_d256.v"
`include "crc_func_1_d256.v"
  module header_hash
    #(parameter INPUT_WIDTH = 240,
      parameter OUTPUT_WIDTH = 19)
    (input [INPUT_WIDTH-1:0]       data,
     output reg [OUTPUT_WIDTH-1:0] hash_0,
     output reg [OUTPUT_WIDTH-1:0] hash_1,
     input                         clk,
     input                         reset);

   /* These macros contain the definitions
    * of the hashing functions */
   `CRC_FUNC_0
   `CRC_FUNC_1

   wire [255:0] data_rev;
   wire [255:0] data_padded = {{(256-INPUT_WIDTH){1'b0}}, data};

   generate
      genvar 	i;
      for (i=0; i<32; i=i+1) begin: test
	 assign data_rev[(31-i)*8 + 7 : (31-i)*8] = data_padded[i*8 + 7 : i*8];
      end
   endgenerate

   always @(posedge clk) begin
      if (reset) begin
	 hash_0        <= 0;
	 hash_1        <= 0;
      end
      else begin
	 hash_0        <= crc_func_0(data_rev, 256'h0);
	 hash_1        <= crc_func_1(data_rev, 256'h0);
      end // else: !if (reset)
   end
endmodule // header_hash

/*
module header_hash_tester ();
   wire [255:0] data;
   wire [255:0] data_rev;
   reg 		clk = 0;

   wire [31:0] 	hash_0_rev;

   always #4 clk = !clk;

   generate
      genvar 	i;
      for (i=0; i<32; i=i+1) begin: test
	 assign data_rev[(31-i)*8 + 7: (31-i)*8] = i + 'h31;
	 assign data[i*8 + 7: i*8] = i + 'h31;
      end
   endgenerate

   header_hash
     #(.INPUT_WIDTH(256), .OUTPUT_WIDTH (32))
       header_hash_rev
	 (.data (data_rev),
	  .hash_0 (hash_0_rev),
	  .hash_1 (),
	  .clk (clk),
	  .reset (1'b0));

endmodule // header_hash_tester
*/
