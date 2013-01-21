/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_switch_output_port_lookup_tb.v
 *
 *  Library:
 *        hw/std/pcores/nf10_switch_output_port_lookup_v1_10_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Gianni Antichi
 *
 *  Description:
 *        Testbench to verify basic functionalities of the learning CAM switch
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
    reg [255:0]  tdata[4:0];
    reg [4:0]  tlast;
    wire[4:0]  tready;

   reg 	       tvalid_0 = 0;
   reg 	       tvalid_1 = 0;
   reg 	       tvalid_2 = 0;
   reg 	       tvalid_3 = 0;
   reg 	       tvalid_4 = 0;

    reg [3:0] random = 0;

    integer i;

    wire [255:0] header_word_0 = 256'hBBBBBBBBBBBBAAAAAAAAAAAA; // Destination MAC
    wire [255:0] header_word_1 = 256'hAAAAAAAAAAAABBBBBBBBBBBB; // Source MAC + EtherType

    wire [255:0] header_word_01 = 256'hAAAAAAAAAAAABBBBBBBBBBBB; // Destination MAC
    wire [255:0] header_word_11 = 256'hBBBBBBBBBBBBAAAAAAAAAAAAA; // Source MAC + EtherType

    localparam WAIT_CAM_INIT = 0;
    localparam HEADER_0 = 1;
    localparam HEADER_1 = 2;
    localparam PAYLOAD  = 3;
    localparam DEAD     = 4;
    localparam HEADER_01 = 5;
    localparam HEADER_11 = 6;
    localparam PAYLOAD1  = 7;
    localparam DEAD1  = 8;

    localparam WAIT = 5;
    localparam REQUEST_READ = 6;
    localparam WAIT_REPLY = 7;
    localparam END = 8;

    reg       request_read = 0;
    reg [31:0]value_read;
    reg [31:0]address_to_read=0;
    reg       request_read_next = 0;
    reg [31:0]address_to_read_next=0;
    reg [6:0] state_reg, state_reg_next;
    reg [14:0] start_reg;
    wire        read_ack;


    reg [3:0] state, state_next;
    reg [7:0] counter, counter_next;
   
    reg [9:0] start,start_next;

    wire [255:0] tdata_m_arb;
    wire 	 tvalid_m_arb;
    wire	 tlast_m_arb;
    wire	 tready_m_arb;
    wire [31:0]	 tstrb_m_arb;
    wire [127:0] tuser_m_arb;

   /* wire [255:0] tdata_s_opl;
    wire         tvalid_s_opl;
    wire         tlast_s_opl;
    wire         tready_s_opl;
    wire [31:0]  tstrb_s_opl;
    wire [128:0] tuser_s_opl;*/

    wire [255:0] tdata_m_opl;
    wire         tvalid_m_opl;
    wire         tlast_m_opl;
    wire         tready_m_opl;
    wire [31:0]  tstrb_m_opl;
    wire [127:0] tuser_m_opl;

   /* wire [255:0] tdata_s_oq;
    wire         tvalid_s_oq;
    wire         tlast_s_oq;
    wire         tready_s_oq;
    wire [31:0]  tstrb_s_opl;
    wire [128:0] tuser_s_opl;*/


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
	    WAIT_CAM_INIT: begin
                if(start>10'h300)
			state_next = HEADER_0;
            end

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
                tdata[random] = {32{counter}};
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
                   state_next = HEADER_01;
      		end
            end


            HEADER_01: begin
                tdata[random] = header_word_01;
                if(tready[random]) begin
                    state_next = HEADER_11;
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

            HEADER_11: begin
                tdata[random] = header_word_11;
                if(tready[random]) begin
                    state_next = PAYLOAD1;
                end
            end
            PAYLOAD1: begin
                tdata[random] = {32{counter}};
                if(tready[random]) begin
                    counter_next = counter + 1'b1;
                    if(counter == 8'h1F) begin
                        state_next = DEAD1;
                        counter_next = 8'b0;
                        tlast[random] = 1'b1;
                    end
                end
            end

            DEAD1: begin
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
            state <= WAIT_CAM_INIT;
            counter <= 8'b0;
            start <= 10'h0;
	    state_reg <= WAIT;
	    start_reg <= 10'h0;
        end
        else begin
            state <= state_next;
            counter <= counter_next;
            start <= start +1;

            state_reg <= state_reg_next;
            address_to_read <= address_to_read_next;
            request_read <= request_read_next;
            start_reg <= start_reg +1;

        end
    end


  always @(*) begin
       state_reg_next = state_reg;
       address_to_read_next = address_to_read;
       request_read_next = 0;

        case(state_reg)
            WAIT: begin
                if(start_reg>15'h4A0)
                        state_reg_next = REQUEST_READ;
            end

            REQUEST_READ: begin
                request_read_next = 1;
                address_to_read_next = 32'h74800004;
                state_reg_next = WAIT_REPLY;
            end

            WAIT_REPLY: begin
                request_read_next = 1;
                address_to_read_next = 32'h74800004;
                if(read_ack)
                        state_reg_next =END;
            end

            END: begin
                if(start_reg > 15'h500)
                        state_reg_next = WAIT;
            end
          endcase
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
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(256),
      .C_M_AXIS_TUSER_WIDTH(128),
      .C_S_AXIS_TUSER_WIDTH(128)
     ) in_arb
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),

    // Master Stream Ports
    .m_axis_tdata(tdata_m_arb),
    .m_axis_tstrb(tstrb_m_arb),
    .m_axis_tvalid(tvalid_m_arb),
    .m_axis_tready(tready_m_arb),
    .m_axis_tlast(tlast_m_arb),
    .m_axis_tuser(tuser_m_arb),

    // Slave Stream Ports
    .s_axis_tdata_0(tdata[0]),
    .s_axis_tuser_0(128'h0001AAAA),
    .s_axis_tstrb_0(32'hFFFFFFFF),
    .s_axis_tvalid_0(tvalid_0),
    .s_axis_tready_0(tready[0]),
    .s_axis_tlast_0(tlast[0]),

    .s_axis_tdata_1(),
    .s_axis_tuser_1(),
    .s_axis_tstrb_1(),
    .s_axis_tvalid_1(),
    .s_axis_tready_1(),
    .s_axis_tlast_1(),

    .s_axis_tdata_2(),
    .s_axis_tuser_2(),
    .s_axis_tstrb_2(),
    .s_axis_tvalid_2(),
    .s_axis_tready_2(),
    .s_axis_tlast_2(),

    .s_axis_tdata_3(),
    .s_axis_tuser_3(),
    .s_axis_tstrb_3(),
    .s_axis_tvalid_3(),
    .s_axis_tready_3(),
    .s_axis_tlast_3(),

    .s_axis_tdata_4(),
    .s_axis_tuser_4(),
    .s_axis_tstrb_4(),
    .s_axis_tvalid_4(),
    .s_axis_tready_4(),
    .s_axis_tlast_4()

   );

  nf10_switch_output_port_lookup
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(256),
      .C_M_AXIS_TUSER_WIDTH(128),
      .C_S_AXIS_TUSER_WIDTH(128)
     ) opl
    (
    // Global Ports
    .S_AXI_ACLK(clk),
    .S_AXI_RESETN(~reset),

    // control path
    .S_AXI_AWADDR(32'h0),
    .S_AXI_AWVALID(1'b0),
    .S_AXI_WDATA(32'h0),
    .S_AXI_WSTRB(4'h0),
    .S_AXI_WVALID(1'b0),
    .S_AXI_BREADY(1'b0),
    .S_AXI_ARADDR(address_to_read),
    .S_AXI_ARVALID(request_read),
    .S_AXI_RREADY(1'b1),
    .S_AXI_ARREADY(read_ack),
    .S_AXI_RDATA(),
    .S_AXI_RRESP(),
    .S_AXI_RVALID(),
    .S_AXI_WREADY(),
    .S_AXI_BRESP(),
    .S_AXI_BVALID(),
    .S_AXI_AWREADY(),

    // data path

    .S_AXIS_TDATA(tdata_m_arb),
    .S_AXIS_TSTRB(tstrb_m_arb),
    .S_AXIS_TUSER(tuser_m_arb),
    .S_AXIS_TVALID(tvalid_m_arb),
    .S_AXIS_TREADY(tready_m_arb),
    .S_AXIS_TLAST(tlast_m_arb),

    .M_AXIS_TDATA(tdata_m_opl),
    .M_AXIS_TSTRB(tstrb_m_opl),
    .M_AXIS_TUSER(tuser_m_opl),
    .M_AXIS_TVALID(tvalid_m_opl),
    .M_AXIS_TREADY(tready_m_opl),
    .M_AXIS_TLAST(tlast_m_opl)
   );


 nf10_bram_output_queues
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(256),
      .C_M_AXIS_TUSER_WIDTH(128),
      .C_S_AXIS_TUSER_WIDTH(128)
     ) dut
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),

    // Master Stream Ports
    .m_axis_tdata_0(),
    .m_axis_tstrb_0(),
    .m_axis_tvalid_0(),
    .m_axis_tready_0(1'b1),
    .m_axis_tlast_0(),
    .m_axis_tuser_0(),

    .m_axis_tdata_1(),
    .m_axis_tstrb_1(),
    .m_axis_tvalid_1(),
    .m_axis_tready_1(1'b1),
    .m_axis_tlast_1(),
    .m_axis_tuser_1(),

    .m_axis_tdata_2(),
    .m_axis_tstrb_2(),
    .m_axis_tvalid_2(),
    .m_axis_tready_2(1'b1),
    .m_axis_tlast_2(),
    .m_axis_tuser_2(),

    .m_axis_tdata_3(),
    .m_axis_tstrb_3(),
    .m_axis_tvalid_3(),
    .m_axis_tready_3(1'b1),
    .m_axis_tlast_3(),
    .m_axis_tuser_3(),

    .m_axis_tdata_4(),
    .m_axis_tstrb_4(),
    .m_axis_tvalid_4(),
    .m_axis_tready_4(1'b1),
    .m_axis_tlast_4(),
    .m_axis_tuser_4(),

     // Slave Stream Ports
    .s_axis_tdata(tdata_m_opl),
    .s_axis_tstrb(tstrb_m_opl),
    .s_axis_tvalid(tvalid_m_opl),
    .s_axis_tready(tready_m_opl),
    .s_axis_tlast(tlast_m_opl),
    .s_axis_tuser(tuser_m_opl)
   );




endmodule
