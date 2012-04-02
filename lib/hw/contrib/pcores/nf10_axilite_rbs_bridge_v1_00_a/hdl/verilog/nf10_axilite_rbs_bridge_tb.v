/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_axilite_rbs_bridge_tb.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_axilite_rbs_bridge_v1_00_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Muhammad Shahbaz, Gianni Anitchi
 *
 *  Description:
 *        Testbench of nf10_axilite_rbs_bridge
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

`timescale 1 ns / 1ps
module testbench();

  reg clk, reset;
  integer i;

  initial begin
      clk   = 1'b0;

      $display("[%t] : System Reset Asserted...", $realtime);
      reset = 1'b1;
      for (i = 0; i < 50; i = i + 1) begin
                 @(posedge clk);
      end
      $display("[%t] : System Reset De-asserted...", $realtime);
      reset = 1'b0;
  end

  always #2.5  clk = ~clk;      // 200MHz

  parameter RING_SIZE = 16;

  wire                 RBS_REQ;
  wire                 RBS_ACK;
  wire                 RBS_RD_WR_L;
  wire [30-1:0]        RBS_ADDR;
  wire [32-1:0]        RBS_DATA;
  wire [2-1:0]         RBS_SRC;

  reg                  RBS_REQ_r     [0:RING_SIZE-1];
  reg                  RBS_ACK_r     [0:RING_SIZE-1];
  reg                  RBS_RD_WR_L_r [0:RING_SIZE-1];
  reg [30-1:0]         RBS_ADDR_r    [0:RING_SIZE-1];
  reg [32-1:0]         RBS_DATA_r    [0:RING_SIZE-1];
  reg [2-1:0]          RBS_SRC_r     [0:RING_SIZE-1];

  // Register Bus loopback
  generate
  genvar j;
  for (j=0; j<RING_SIZE; j=j+1)
  begin : RING
    if (j == 0)
    begin: _0
      always @ (posedge clk)
      begin
         RBS_REQ_r[0] <= RBS_REQ;
         RBS_ACK_r[0] <= RBS_ACK;
         RBS_RD_WR_L_r[0] <= RBS_RD_WR_L;
         RBS_ADDR_r[0] <= RBS_ADDR;
         RBS_DATA_r[0] <= RBS_DATA;
         RBS_SRC_r[0] <= RBS_SRC;
      end
    end
    else 
    begin: _N
      always @ (posedge clk)
      begin
         RBS_REQ_r[j] <= RBS_REQ_r[j-1];
         RBS_ACK_r[j] <= RBS_ACK_r[j-1];
         RBS_RD_WR_L_r[j] <= RBS_RD_WR_L_r[j-1];
         RBS_ADDR_r[j] <= RBS_ADDR_r[j-1];
         RBS_DATA_r[j] <= RBS_DATA_r[j-1];
         RBS_SRC_r[j] <= RBS_SRC_r[j-1];
      end
    end
  end
 endgenerate
  

  nf10_axilite_rbs_bridge
  #(
    .C_S_AXI_DATA_WIDTH   (32),
    .C_S_AXI_ADDR_WIDTH   (32),
    .C_BASEADDR           ('h76c00000),
    .C_HIGHADDR           ('h76c0ffff),
    .C_FAMILY             ("virtex5"),
    .C_S_AXI_ACLK_FREQ_HZ (100),
    .C_RBS_SRC_WIDTH      (2),
    .C_RBS_RING_SIZE      (RING_SIZE+1),
    .C_RBS_SRC_ID         (0)
  ) nf10_axilite_rbs_bridge_dut
  (
   .S_AXI_ACLK            (clk), 
   .S_AXI_ARESETN         (~reset),
   .S_AXI_AWADDR          (32'h76c00003), 
   .S_AXI_AWVALID         (1'b1), 
   .S_AXI_AWREADY         (),
   .S_AXI_WDATA           (32'hf00dface), 
   .S_AXI_WSTRB           (4'hF),
   .S_AXI_WVALID          (1'b1), 
   .S_AXI_WREADY          (),
   .S_AXI_BRESP           (),
   .S_AXI_BVALID          (),
   .S_AXI_BREADY          (1'b1), 
   .S_AXI_ARADDR          (32'h0), 
   .S_AXI_ARVALID         (1'b0), 
   .S_AXI_RREADY          (1'b0), 
   .S_AXI_ARREADY         (), 
   .S_AXI_RDATA           (), 
   .S_AXI_RRESP           (),
   .S_AXI_RVALID          (),
  
   // NetFPGA 1G register pipeline signals
   .S_RBS_REQ	          (RBS_REQ_r[RING_SIZE-1]),	
   .S_RBS_ACK	          (RBS_ACK_r[RING_SIZE-1]),	
   .S_RBS_RD_WR_L         (RBS_RD_WR_L_r[RING_SIZE-1]),      	
   .S_RBS_ADDR	          (RBS_ADDR_r[RING_SIZE-1]),     
   .S_RBS_DATA	          (RBS_DATA_r[RING_SIZE-1]),     
   .S_RBS_SRC	          (RBS_SRC_r[RING_SIZE-1]),   
   
   .M_RBS_REQ	          (RBS_REQ),   
   .M_RBS_ACK	          (RBS_ACK),  
   .M_RBS_RD_WR_L         (RBS_RD_WR_L),  
   .M_RBS_ADDR	          (RBS_ADDR), 
   .M_RBS_DATA	          (RBS_DATA),    
   .M_RBS_SRC	          (RBS_SRC)  
  );

endmodule
