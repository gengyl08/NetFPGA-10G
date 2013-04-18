/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_rate_limiter_tb.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_rate_limiter_v1_00_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Yilong Geng
 *
 *  Description:
 *        Testbench of nf10_rate_limiter
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
    reg [255:0]  tdata;
    reg   tlast;
    wire  tready;
    reg   tvalid = 0;

    reg [3:0] random = 0;

    integer i;

    wire [255:0] data_0 = 256'h0101A8C066554433221101000506070801020608665544332211FFFFFFFFFFFF; 
    wire [255:0] data_1 = 256'h000000000000000000000000000000000000000000006401A8C0000000000000;

    localparam HEADER_0 = 0;
    localparam HEADER_1 = 1;
    localparam PAYLOAD  = 2;
    localparam DEAD     = 3;
    localparam HEADER_2 = 4;
    localparam HEADER_3 = 5;

    reg [2:0] state, state_next;
    reg [7:0] counter, counter_next;

    always @(*) begin
       state_next = state;
       tdata = 256'b0;
       tlast = 1'b0;
       counter_next = counter;

        case(state)
            HEADER_0: begin
                tdata = data_0;
                if(tready) begin
                    state_next = HEADER_1;
                end
	       
                tvalid = 1;
            end
            HEADER_1: begin
                tdata = data_1;
                tlast = 1;
                if(tready) begin
                    state_next = HEADER_2;
                end
            end

            HEADER_2: begin
                tdata = data_0;
                if(tready) begin
                    state_next = HEADER_3;
                end
	       
                tvalid = 1;
            end
            HEADER_3: begin
                tdata = data_1;
                tlast = 1;
                if(tready) begin
                    state_next = DEAD;
                end
            end

            DEAD: begin
                tlast = 1'b0;
         	tvalid = 0;

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

  nf10_rate_limiter
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(256),
      .C_M_AXIS_TUSER_WIDTH(128),
      .C_S_AXIS_TUSER_WIDTH(128)
     ) opl
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
    .s_axis_tdata(tdata),
    .s_axis_tuser(128'h0004AAAA),
    .s_axis_tstrb(32'hFFFFFFFF),
    .s_axis_tvalid(tvalid),
    .s_axis_tready(tready),
    .s_axis_tlast(tlast),

    .S_AXI_ACLK(clk),
    .S_AXI_ARESETN(~reset)

   );

endmodule
