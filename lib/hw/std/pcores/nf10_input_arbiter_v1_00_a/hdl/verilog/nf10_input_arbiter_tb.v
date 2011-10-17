/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_input_arbiter_tb.v
 *
 *  Library:
 *        hw/std/pcores/nf10_input_arbiter_v1_00_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Adam Covington
 *
 *  Description:
 *        Testbench of nf10_input_arbiter
 *        Send in packets on all ports
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
    reg [63:0]  tdata[4:0];
    reg [4:0]  tlast;
    wire[4:0]  tready;

   reg 	       tvalid_0 = 0;
   reg 	       tvalid_1 = 0;
   reg 	       tvalid_2 = 0;
   reg 	       tvalid_3 = 0;
   reg 	       tvalid_4 = 0;

    reg [3:0] random = 0;

    integer i;

    wire [63:0] header_word_0 = 64'hEFBEFECAFECAFECA; // Destination MAC
    wire [63:0] header_word_1 = 64'h00000008EFBEEFBE; // Source MAC + EtherType

    localparam HEADER_0 = 0;
    localparam HEADER_1 = 1;
    localparam PAYLOAD  = 2;
    localparam DEAD     = 3;

    reg [2:0] state, state_next;
    reg [7:0] counter, counter_next;

    always @(*) begin
       state_next = state;
       tdata[0] = 64'b0;
       tdata[1] = 64'b0;
       tdata[2] = 64'b0;
       tdata[3] = 64'b0;
       tdata[4] = 64'b0;
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
                tdata[random] = {8{counter}};
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
		   random = $random % 5;
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

  nf10_input_arbiter
    #(.C_M_AXIS_DATA_WIDTH(64),
      .C_S_AXIS_DATA_WIDTH(64),
      .C_M_AXIS_TUSER_WIDTH(128),
      .C_S_AXIS_TUSER_WIDTH(128)
     ) in_arb
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),

    // Master Stream Ports
    .m_axis_tdata(),
    .m_axis_tstrb(),
    .m_axis_tvalid(),
    .m_axis_tready(1'b1),
    .m_axis_tlast(),

    // Slave Stream Ports
    .s_axis_tdata_0(tdata[0]),
    .s_axis_tuser_0(128'hAA),
    .s_axis_tstrb_0(8'hFF),
    .s_axis_tvalid_0(tvalid_0),
    .s_axis_tready_0(tready[0]),
    .s_axis_tlast_0(tlast[0]),

    .s_axis_tdata_1(tdata[1]),
    .s_axis_tuser_1(128'hAA),
    .s_axis_tstrb_1(8'hFF),
    .s_axis_tvalid_1(tvalid_1),
    .s_axis_tready_1(tready[1]),
    .s_axis_tlast_1(tlast[1]),

    .s_axis_tdata_2(tdata[2]),
    .s_axis_tuser_2(128'hAA),
    .s_axis_tstrb_2(8'hFF),
    .s_axis_tvalid_2(tvalid_2),
    .s_axis_tready_2(tready[2]),
    .s_axis_tlast_2(tlast[2]),

    .s_axis_tdata_3(tdata[3]),
    .s_axis_tuser_3(128'hAA),
    .s_axis_tstrb_3(8'hFF),
    .s_axis_tvalid_3(tvalid_3),
    .s_axis_tready_3(tready[3]),
    .s_axis_tlast_3(tlast[3]),

    .s_axis_tdata_4(tdata[4]),
    .s_axis_tuser_4(128'hAA),
    .s_axis_tstrb_4(8'hFF),
    .s_axis_tvalid_4(tvalid_4),
    .s_axis_tready_4(tready[4]),
    .s_axis_tlast_4(tlast[4])

   );

endmodule
