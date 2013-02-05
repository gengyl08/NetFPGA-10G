///////////////////////////////////////////////////////////////////////////////
// $Id: preprocess_control.v 1887 2007-06-19 21:33:32Z grg $
//
// Module: preprocess_control.v
// Project: NF2.1
// Description: asserts the appropriate signals for parsing the headers
//
///////////////////////////////////////////////////////////////////////////////

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
