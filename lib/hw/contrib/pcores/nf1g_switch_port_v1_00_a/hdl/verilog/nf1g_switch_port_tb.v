/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf1g_switch_port_tb.v
 *
 *  Library:
 *        hw/contrib/pcores/nf1g_switch_port_v1_00_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shabaz
 *
 *  Description:
 *        Testbench of AXI - 1G reference pipeline conversion library 
 *        The axi_1g module is the library while output_port_lookup_1g module
 *        is the old 1G output port lookup module from the reference nic. 
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

    reg tvalid_0 = 0;
    reg tvalid_1 = 0;
    reg tvalid_2 = 0;
    reg tvalid_3 = 0;
    reg	tvalid_4 = 0;

    reg [3:0] random = 0;

    integer i;

    wire [255:0] header_word_0 = 256'hBBBBBBBBBBBBAAAAAAAAAAAA; // Destination MAC
    wire [255:0] header_word_1 = 256'hAAAAAAAAAAAABBBBBBBBBBBB; // Source MAC + EtherType

    localparam WAIT_CAM_INIT = 0;
    localparam HEADER_0 = 1;
    localparam HEADER_1 = 2;
    localparam PAYLOAD  = 3;
    localparam DEAD     = 4;

    localparam WAIT = 5;
    localparam REQUEST_READ = 6;
    localparam WAIT_REPLY = 7;
    localparam END = 8;

    reg       request_read = 0;
    reg [31:0]value_read;
    reg [31:0]address_to_read=0;
    reg       request_read_next = 0;
    reg [31:0]address_to_read_next=0;

    reg [3:0] state, state_next;
    reg [6:0] state_reg, state_reg_next;
    reg [7:0] counter, counter_next;
   
    reg [9:0] start;
    reg [14:0] start_reg;

    wire [63:0] data_1g_axi;
    wire [7:0] ctrl_1g_axi;

    wire [63:0] data_axi_1g;
    wire [7:0] ctrl_axi_1g;

    wire 	reg_req_in;
    wire 	reg_ack_in;
    wire	reg_rd_wr_L_in;
    wire [29:0]	reg_addr_in;
    wire [31:0]	reg_data_in;
    wire [1:0]	reg_src_in;

    wire        reg_req_out;
    wire        reg_ack_out;
    wire        reg_rd_wr_L_out;
    wire [29:0] reg_addr_out;
    wire [31:0] reg_data_out;
    wire [1:0]  reg_src_out;

    wire	read_ack;


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
		address_to_read_next = 32'h76c0000c;
		state_reg_next = WAIT_REPLY;
            end
            
	    WAIT_REPLY: begin
		request_read_next = 1;
                address_to_read_next = 32'h76c0000c;
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
    .S_AXIS_TUSER(128'h0001AAAA),
    .S_AXIS_TSTRB(32'h007FFFFF),
    .S_AXIS_TVALID(tvalid_0),
    .S_AXIS_TREADY(tready[0]),
    .S_AXIS_TLAST(tlast[0]),

    .M_PBS_DATA(data_axi_1g),
    .M_PBS_CTRL(ctrl_axi_1g),
    .M_PBS_WR(wr_axi_1g),
    .M_PBS_RDY(rdy_1g_axi),

    .S_PBS_DATA(data_1g_axi),
    .S_PBS_CTRL(ctrl_1g_axi),
    .S_PBS_WR(wr_1g_axi),
    .S_PBS_RDY(rdy_1g_axi)
   );

 nf1g_switch_port  DUT
    (
    .CLK(clk),
    .RESET(reset),

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
     .S_RBS_REQ     (reg_req_out),
     .S_RBS_ACK     (reg_ack_out),
     .S_RBS_RD_WR_L (reg_rd_wr_L_out),
     .S_RBS_ADDR    (reg_addr_out),
     .S_RBS_DATA    (reg_data_out),
     .S_RBS_SRC     (reg_src_out),

     .M_RBS_REQ     (reg_req_in),
     .M_RBS_ACK     (reg_ack_in),
     .M_RBS_RD_WR_L (reg_rd_wr_L_in),
     .M_RBS_ADDR    (reg_addr_in),
     .M_RBS_DATA    (reg_data_in),
     .M_RBS_SRC     (reg_src_in)
   );

nf10_axilite_rbs_bridge 
	nf10_axilite_rbs_bridge
    (

    .S_AXI_ACLK(clk),
    .S_AXI_ARESETN(~reset),
    
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

    .S_RBS_REQ(reg_req_in),
    .S_RBS_ACK(reg_ack_in),
    .S_RBS_RD_WR_L(reg_rd_wr_L_in),
    .S_RBS_ADDR(reg_addr_in),
    .S_RBS_DATA(reg_data_in),
    .S_RBS_SRC(reg_src_in),

    .M_RBS_REQ(reg_req_out),
    .M_RBS_ACK(reg_ack_out),
    .M_RBS_RD_WR_L(reg_rd_wr_L_out),
    .M_RBS_ADDR(reg_addr_out),
    .M_RBS_DATA(reg_data_out),
    .M_RBS_SRC(reg_src_out)
   );

endmodule
