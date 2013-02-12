/*******************************************************************************
 * 
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        preprocess_control.v
 *
 *  Library:
 *        std/pcores/nf10_router_output_port_lookup_v1_00_a
 *
 *  Module:
 *        preprocess_control
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


  module preprocess_control
    #(parameter C_S_AXIS_DATA_WIDTH=256
      )
   (// --- Interface to the previous stage
    
    input [C_S_AXIS_DATA_WIDTH-1:0]    tdata,
    input			       valid,
    input			       tlast,

    // --- Interface to other preprocess blocks
    output reg                         word_IP_DST_HI,
    output reg                         word_IP_DST_LO,

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

   //------------------ Internal Parameter ---------------------------

   localparam WORD_1           = 1;
   localparam WORD_2           = 2;
   localparam WAIT_EOP         = 4;

   //---------------------- Wires/Regs -------------------------------
   reg [2:0]                            state, state_next;

   //------------------------ Logic ----------------------------------

   always @(*) begin
      state_next = state;
      word_IP_DST_HI = 0;
      word_IP_DST_LO = 0;

      case(state)
        WORD_1: begin
           if(valid) begin
              word_IP_DST_HI = 1;
              state_next     = WORD_2;
           end
        end

        WORD_2: begin
           if(valid) begin
              word_IP_DST_LO = 1;
              state_next = WAIT_EOP;
           end
        end

        WAIT_EOP: begin
           if(valid && tlast) begin
              state_next = WORD_1;
           end
        end
      endcase // case(state)
   end // always @ (*)

   always@(posedge clk) begin
      if(reset) begin
         state <= WORD_1;
      end
      else begin
         state <= state_next;
      end
   end

endmodule // op_lut_hdr_parser
