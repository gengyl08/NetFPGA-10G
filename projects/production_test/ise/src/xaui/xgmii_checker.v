// Xilinx, Inc. - Proprietary.  Use pursuant to Company instructions.
//-------------------------------------------------------------------------------
// Michaela Blott
//
// Description:
// Xgmii component that checks packets
//
// Translated into Verilog by James Hongyi Zeng (hyzeng_at_stanford.edu)
// May 27, 2010
//
// May 2010
//-------------------------------------------------------------------------------

module xgmii_checker(
    input clk,
    input reset,
    input[63:0] rxd,
    input[7:0] rxc,
    output[15:0] rx_count,
    output[15:0] err_count
);

  reg [15:0] state;
  reg [63:0] data;
  reg [7:0] ctl;
  reg [15:0] cnt_int;
  reg [15:0] err_cnt_int;
  reg [7:0] errchar;

  assign rx_count = cnt_int;
  assign err_count = err_cnt_int;
  
  integer i;
  
  always @(posedge clk) begin
    if(reset) begin
      errchar <= 8'h00;
      ctl <= rxc;
      data <= rxd;
      cnt_int <= {16{1'b0}};
      err_cnt_int <= {16{1'b0}};
      state <= {16{1'b0}};
    end else begin
      ctl <= rxc;
      data <= rxd;
      for (i=1; i <= 8; i = i + 1) begin 
        if((rxd[8*i-1-:8]  == 8'hFE && rxc[i - 1]  == 1'b1)) begin
          errchar[i - 1]  <= 1'b1;
        end
        else begin
          errchar[i - 1]  <= 1'b0;
        end
      end
      if((data[7:0]  == 8'hFB || data[39:32]  == 8'hFB)) begin
        state <= state + 1;
        if((errchar > 0)) begin
          err_cnt_int <= err_cnt_int + 1;
        end
      end
      else if((state > 8'h00 && state < 16'h002F)) begin
        if((data[7:0]  == 8'hFD || data[39:32]  == 8'hFD)) begin
          state <= 16'h0000;
          cnt_int <= cnt_int + 1;
        end
        else begin
          state <= state + 1;
        end
        if((errchar > 0)) begin
          err_cnt_int <= err_cnt_int + 1;
        end
      end
      else if((state == 16'h0030)) begin
        //give up waiting for end     s
        err_cnt_int <= err_cnt_int + 1;
        state <= 16'h0000;
      end
    end
  end


endmodule
