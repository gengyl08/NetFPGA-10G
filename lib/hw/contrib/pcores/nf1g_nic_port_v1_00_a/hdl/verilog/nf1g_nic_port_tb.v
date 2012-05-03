/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf1g_nic_port_tb.v
 *
 *  Library:
 *        hw/contrib/pcores/nf1g_nic_port_v1_00_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Gianni Anitchi, Muhammad Shahbaz
 *
 *  Description:
 *        Testbench 
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

  always #2.5  clk = ~clk; // 200MHz

// Instantiate DUT  

    reg [255:0]  tdata[4:0];
    reg [4:0]  tlast;
    wire[4:0]  tready;

    reg 	       tvalid_0 = 0;
    reg 	       tvalid_1 = 0;
    reg 	       tvalid_2 = 0;
    reg 	       tvalid_3 = 0;
    reg 	       tvalid_4 = 0;

    reg [3:0] random = 0;

    wire [255:0] header_word_0 = 256'hEFBEFECAFECAFECAEFBEFECAFECAFECAEFBEFECAFECAFECAEFBEFECAFECAFECA; // Destination MAC
    wire [255:0] header_word_1 = 256'h00000008EFBEEFBE00000008EFBEEFBE00000008EFBEEFBE00000008EFBEEFBE; // Source MAC + EtherType

    localparam HEADER_0 = 0;
    localparam HEADER_1 = 1;
    localparam PAYLOAD  = 2;
    localparam DEAD     = 3;

    reg [2:0] state, state_next;
    reg [7:0] counter, counter_next;

    wire [63:0] data_1g_axi,data_axi_1g;
    wire [7:0]  ctrl_1g_axi,ctrl_axi_1g;
    wire        wr_1g_axi,wr_axi_1g,rdy_1g_axi,rdy_axi_1g;


    always @(*) begin
       state_next = state;
       tdata[0] = 256'b0;
       tdata[1] = 256'b0;
       tdata[2] = 256'b0;
       tdata[3] = 256'b0;
       tdata[4] = 256'b0;
       tlast[0] = 1'b0;
       tlast[1] = 1'b0;
       tlast[2] = 1'b0;
       tlast[3] = 1'b0;
       tlast[4] = 1'b0;
       counter_next = counter;

        case(state)
            HEADER_0: begin
                tdata[random] = header_word_0;
                if(tready[random]) begin
                    state_next = HEADER_1;
                end
	       if (random == 0)
		 tvalid_0 = 1;
	       else if (random == 1)
		 tvalid_1 = 1;
	       else if (random == 2)
		 tvalid_2 = 1;
	       else if (random == 3)
		 tvalid_3 = 1;
	       else if (random == 4)
		 tvalid_4 = 1;
            end
            HEADER_1: begin
                tdata[random] = header_word_1;
                if(tready[random]) begin
                    state_next = PAYLOAD;
                end
            end
            PAYLOAD: begin
                tdata[random] = {{8{counter}},64'hAAAAAAAABBBBBBBB,{8{counter}},64'hBBBBBBBBCCCCCCCC};
		if(tready[random]) begin
                    counter_next = counter + 1'b1;
                    if(counter == 8'h1F) begin
                        state_next = DEAD;
                        counter_next = 8'b0;
                        tlast[random] = 1'b1;
                    end
                end
            end

            DEAD: begin

                counter_next = counter + 1'b1;
                tlast[random] = 1'b0;
         	tvalid_0 = 0;
	        tvalid_1 = 0;
		tvalid_2 = 0;
		tvalid_3 = 0;
		tvalid_4 = 0;
                if(counter[7]==1'b1) begin
                   counter_next = 8'b0;
		   random = 0;
                   state_next = HEADER_0;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if(reset) begin
            state <= HEADER_0;
            counter <= 8'b0;
        end
        else begin
            state <= state_next;
            counter <= counter_next;
        end
    end


    nf10_axis_pbs_bridge
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(256),
      .C_M_AXIS_TUSER_WIDTH(128),
      .C_S_AXIS_TUSER_WIDTH(128)
     ) nf10_axis_pbs_bridge
    (
    // Global Ports
    .ACLK(clk),
    .ARESETN(~reset),

    // Master Stream Ports
    .M_AXIS_TDATA(),
    .M_AXIS_TSTRB(),
    .M_AXIS_TVALID(),
    .M_AXIS_TREADY(1'b1),
    .M_AXIS_TLAST(),
    .M_AXIS_TUSER(),

    // Slave Stream Ports
    .S_AXIS_TDATA(tdata[0]),
    .S_AXIS_TUSER(128'h0001_AAAA),
    .S_AXIS_TSTRB(32'hFFFF_FFFF),
    .S_AXIS_TVALID(tvalid_0),
    .S_AXIS_TREADY(tready[0]),
    .S_AXIS_TLAST(tlast[0]),

    .S_PBS_DATA(data_1g_axi),
    .S_PBS_CTRL(ctrl_1g_axi),
    .S_PBS_WR(wr_1g_axi),
    .S_PBS_RDY(rdy_1g_axi),

    .M_PBS_DATA(data_axi_1g),
    .M_PBS_CTRL(ctrl_axi_1g),
    .M_PBS_WR(wr_axi_1g),
    .M_PBS_RDY(rdy_axi_1g)
   );

   nf1g_nic_port DUT
   (   
     // Clock and Reset signals
     .CLK (clk),
     .RESET (reset),   
     
     // 1G Packet side signals
     .M_PBS_DATA (data_1g_axi),
     .M_PBS_CTRL (ctrl_1g_axi),
     .M_PBS_WR   (wr_1g_axi),	
     .M_PBS_RDY  (rdy_1g_axi),
     
     .S_PBS_DATA (data_axi_1g),
     .S_PBS_CTRL (ctrl_axi_1g),
     .S_PBS_WR   (wr_axi_1g),
     .S_PBS_RDY  (rdy_axi_1g),
   
     // 1G Register side signals
     .S_RBS_REQ     (),
     .S_RBS_ACK     (),
     .S_RBS_RD_WR_L (),
     .S_RBS_ADDR    (),
     .S_RBS_DATA    (),
     .S_RBS_SRC     (),
   
     .M_RBS_REQ     (),
     .M_RBS_ACK     (),
     .M_RBS_RD_WR_L (),
     .M_RBS_ADDR    (),
     .M_RBS_DATA    (),
     .M_RBS_SRC     ()
   );

endmodule
