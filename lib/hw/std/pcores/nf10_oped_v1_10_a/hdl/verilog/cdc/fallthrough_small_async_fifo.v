///////////////////////////////////////////////////////////////////////////////
// $Id: small_fifo.v 1998 2007-07-21 01:22:57Z grg $
//
// Module: fallthrough_small_fifo.v
// Project: utils
// Description: small fifo with fallthrough i.e. data valid when rd is high
//
// Change history: 
//   7/20/07 -- Set nearly full to 2^MAX_DEPTH_BITS - 1 by default so that it 
//              goes high a clock cycle early.
//   2/11/09 -- jnaous: Rewrote to make much more efficient.
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

  module fallthrough_small_async_fifo
    #(parameter WIDTH = 72,
      parameter MAX_DEPTH_BITS = 3)
    (
                   
     input [WIDTH-1:0] din,     // Data in
     input          wr_en,   // Write enable
     
     input          rd_en,   // Read the next word 
     
     output [WIDTH-1:0]  dout,    // Data out
     output         full,
     output         nearly_full,
     output         empty,
     
     input          reset,
     input          rd_clk,
     input          wr_clk
     );

   small_async_fifo
     #(.DSIZE (WIDTH),
       .ASIZE (MAX_DEPTH_BITS))
       fifo
        (.wdata           (din),
         .winc         (wr_en),
         .rinc         (rd_en),
         .rdata          (dout),
         .wfull          (full),
         .w_almost_full   (nearly_full),
         .rempty         (empty),
         .rrst_n         (~reset),
         .rclk        (rd_clk),
	     .wclk		  (wr_clk),
	     .wrst_n         (~reset)
         );
   
endmodule

/* vim:set shiftwidth=3 softtabstop=3 expandtab: */
