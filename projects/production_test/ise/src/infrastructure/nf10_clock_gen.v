//////////////////////////////////////////////////////////////////////////////
// vim:set shiftwidth=3 softtabstop=3 expandtab:
//
// File       : nf10_top.v
// Project    : NetFPGA 10G
// Description: This module generates all clocks needed for RAM/XAUI/PCI etc.
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module nf10_clock_gen
  (
    // User Clock
	input	usr_sprclk_p,
	input	usr_sprclk_n,

    output	clk200,
    output  spr_clk,

    output	sram_clk,
    output	sram_clk270,
    output	sram_dcm_locked,
    output reg	sram_reset,
    input	sram_idelay_ctrl_rdy,

    output	dram_clk,
    output	dram_clk90,
    output	dram_dcm_locked,
    output reg	dram_reset,
    input	dram_idelay_ctrl_rdy,
    
    input   reset
  );

  // Prepare CLKIN
  wire spr_clk_i;  
  // Differential Clock Module
  IBUFDS usr_sprclk_ibufds(
      .I(usr_sprclk_p),
      .IB(usr_sprclk_n),
      .O(spr_clk_i)
  );
  
  wire CLKFBOUT, clk200_inst, clk_out, clk0_inst, clk270_inst, clk90_inst, dcm_locked;
  wire clk0, clk90, clk270;
  PLL_BASE #(
    .CLKIN_PERIOD(10),
    .CLKFBOUT_MULT(10),
    .CLKOUT0_DIVIDE(4),
    .CLKOUT1_DIVIDE(4),
    .CLKOUT1_PHASE(270),
    .CLKOUT2_DIVIDE(5)
  )  PLL (
  	.CLKFBOUT(CLKFBOUT),
  	.CLKOUT0(clk0_inst),   //250MHz
  	.CLKOUT1(clk270_inst),
  	.CLKOUT2(clk200_inst),
  	.CLKOUT3(),
  	.CLKOUT4(),
  	.CLKOUT5(),
  	.LOCKED(dcm_locked),
  	.CLKFBIN(CLKFBOUT),
  	.CLKIN(spr_clk_i), //100MHz
  	.RST(reset)
  );    

  assign spr_clk = spr_clk_i;
  
  BUFG clk0_bufg    (.O(clk0),    .I(clk0_inst));  
  BUFG clk270_bufg  (.O(clk270),    .I(clk270_inst)); 
  //BUFG clk90_bufg   (.O(clk90),    .I(clk90_inst));   
  BUFG clk200_bufg  (.O(clk200),    .I(clk200_inst)); 
    
  reg sram_reset_r1, sram_reset_r2;
  always @(posedge sram_clk) begin
    if(~sram_dcm_locked) begin
      sram_reset_r1 <= 1'b1;
      sram_reset_r2 <= 1'b1;
      sram_reset    <= 1'b1;
    end
    else begin
      sram_reset_r1 <= 1'b0;
      sram_reset_r2 <= sram_reset_r1;
      sram_reset    <= sram_reset_r2;
    end
  end  
  // synthesis attribute max_fanout of sram_reset is 10
  
  assign sram_clk = clk0;
  assign sram_clk270 = clk270;
  assign sram_dcm_locked = dcm_locked;
  
  assign dram_clk = clk200;
  //assign dram_clk90 = clk90;
  //assign dram_dcm_locked = dcm_locked;

endmodule



