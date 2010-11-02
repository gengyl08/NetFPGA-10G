// Xilinx, Inc. - Proprietary.  Use pursuant to Company instructions.
//-------------------------------------------------------------------------------
// Michaela Blott
//
// Description:
// Xgmii component that generates fixed packets,
// payload changing in one byte, no hdr
//
// May 2010
//
// Translated into Verilog by James Hongyi Zeng (hyzeng_at_stanford.edu)
// May 27, 2010
//-------------------------------------------------------------------------------

module xgmii_generator(
    input      clk,
    input      reset,
    input      rx_local_fault,
    input      tx_local_fault,
    input      link_up,
    output reg [63:0] txd,
    output reg [7:0]  txc,
    output     [15:0] tx_count
);

  reg [9:0] state;
  wire [63:0] data;
  reg [15:0] cnt_int;

  assign tx_count = cnt_int;
  
  always @(posedge clk) begin
    if(reset) begin
      state <= 10'b0000000000;
      txd <= 64'h0707070707070707;
      txc <= 8'hFF;
      cnt_int <= {16{1'b0}};
    end 
    else if(rx_local_fault) begin
      state <= 10'b0000000000;
      txd <= 64'h0200009C0200009C;
      txc <= 8'hFF;
      cnt_int <= {16{1'b0}};
    end
    else if(link_up) begin
      if((state == 10'b0000101001)) begin
        state <= 10'b0000000000;
      end
      else begin
        state <= state + 1;
      end
      if((state == 10'b0000000000)) begin
        txd <= 64'h112233FB07070707;
        txc <= 8'h1F;
        cnt_int <= cnt_int + 1;
      end
      else if((state < 10'b0000100001)) begin
        txd <= {state[7:0] ,state[7:0] ,state[7:0] ,state[7:0] ,state[7:0] ,state[7:0] ,state[7:0] ,state[7:0] };
        txc <= 8'h00;
      end
      else if((state == 10'b0000100001)) begin
        txd <= 64'h07070707070707FD;
        txc <= 8'hFF;
      end
      else begin
        txd <= 64'h0707070707070707;
        txc <= 8'hFF;
      end
    end
    else begin
      state <= 10'b0000000000;
      txd <= 64'h0707070707070707;
      txc <= 8'hFF;
      cnt_int <= {16{1'b0}};
    end
  end
endmodule
