/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        register_manager.v
 *
 *  Library:
 *        contrib/pisa/pcores/nf10_switch_output_port_lookup_v1_10_a
 *
 *  Module:
 *        register_manager
 *
 *  Author:
 *        Gianni Antichi
 *
 *  Description:
 *        Register handler.
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
`define REG_END(addr_num)               32*((addr_num)+1)-1
`define REG_START(addr_num)             32*(addr_num)


module register_manager
#(
	// IPIF settings
	parameter C_S_IPIF_DATA_WIDTH = 32,
	parameter C_S_IPIF_ADDR_WIDTH = 32,
	parameter C_S_IPIF_CS_WIDTH = 1,
	parameter C_S_IPIF_RdCE_WIDTH = 1,
	parameter C_S_IPIF_WrCE_WIDTH = 1
)
(
	// IPIF signals
	input					Bus2IP_Clk,
	input					Bus2IP_Reset,
	input [C_S_IPIF_ADDR_WIDTH-1:0]		Bus2IP_Addr,
	input					Bus2IP_RNW,
	input [(C_S_IPIF_DATA_WIDTH/8)-1:0] 	Bus2IP_BE,
	input [C_S_IPIF_CS_WIDTH-1:0]		Bus2IP_CS,
	input [C_S_IPIF_RdCE_WIDTH-1:0]		Bus2IP_RdCE,
	input [C_S_IPIF_WrCE_WIDTH-1:0]		Bus2IP_WrCE,
	input [C_S_IPIF_DATA_WIDTH-1:0]		Bus2IP_Data,
	output reg [C_S_IPIF_DATA_WIDTH-1:0]	IP2Bus_Data,
	output reg				IP2Bus_WrAck,
	output reg				IP2Bus_RdAck,
	output reg				IP2Bus_Error,

	// Signals from Datapath
        input         				lut_miss,
        input          				lut_hit
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

   
   	localparam NUM_REGS_USED = 2;
   	localparam REG_ADDR_WIDTH_USED = log2(NUM_REGS_USED);
        localparam LUT_NUM_HITS = 0;
        localparam LUT_NUM_MISSES = 1;


   	wire [C_S_IPIF_DATA_WIDTH-1:0]      reg_file [0:NUM_REGS_USED-1];
   	reg  [C_S_IPIF_DATA_WIDTH-1:0]      reg_file_next [0:NUM_REGS_USED-1];

	reg  [NUM_REGS_USED*C_S_IPIF_DATA_WIDTH-1:0]   reg_file_linear;
        wire [NUM_REGS_USED*C_S_IPIF_DATA_WIDTH-1:0]   reg_file_linear_next;

	wire [C_S_IPIF_DATA_WIDTH-1:0]      reg_file_selected;

   	wire                                addr_good;



	wire [C_S_IPIF_DATA_WIDTH-1:0]      num_hits;
  	wire [C_S_IPIF_DATA_WIDTH-1:0]      num_misses;

	reg                                 reg_wrack_out_next;
        reg                                 reg_rdack_out_next;
        reg [C_S_IPIF_DATA_WIDTH-1:0]       reg_data_out_next;
	reg				    reg_error_next;


	assign num_hits = reg_file[LUT_NUM_HITS];
        assign num_misses = reg_file[LUT_NUM_MISSES];
	assign addr_good = (Bus2IP_Addr[C_S_IPIF_ADDR_WIDTH-1:2]<NUM_REGS_USED);
	assign reg_file_selected = reg_file[Bus2IP_Addr[C_S_IPIF_ADDR_WIDTH-1:2]];


	/* select the correct words from the registers */
	generate
	genvar j;
	for(j=0; j<NUM_REGS_USED; j=j+1) begin:linear_reg
		assign reg_file_linear_next[`REG_END(j):`REG_START(j)] = reg_file_next[j];
      		assign reg_file[j] = reg_file_linear[`REG_END(j):`REG_START(j)];
   	end
   	endgenerate


	always @(*) begin
		reg_file_next[LUT_NUM_HITS]   = num_hits + lut_hit;
      		reg_file_next[LUT_NUM_MISSES] = num_misses + lut_miss;
		reg_wrack_out_next = 0;
                reg_rdack_out_next = 0;
      		reg_data_out_next = 0;
		reg_error_next = 0;
		if(Bus2IP_CS) begin
			if(!Bus2IP_RNW) begin
		        	if(addr_good) begin
                                        reg_file_next[Bus2IP_Addr[C_S_IPIF_ADDR_WIDTH-1:2]] = Bus2IP_Data;
                                        reg_wrack_out_next = 1;
				end
				else begin
					reg_file_next[Bus2IP_Addr[C_S_IPIF_ADDR_WIDTH-1:2]] = 0;
                                        reg_wrack_out_next = 1;
					reg_error_next = 1;
				end
			end
			else begin
				if(addr_good) begin
                                        reg_data_out_next = reg_file_selected;
                                        reg_rdack_out_next = 1;

                                end
				else begin
					reg_data_out_next = 32'hdeadbeef;
                                        reg_rdack_out_next = 1;
					reg_error_next = 1;
				end
			end
		end
	end
		
   always @(posedge Bus2IP_Clk) begin
      if(~Bus2IP_Reset) begin
      	IP2Bus_Data <= 0;
        IP2Bus_WrAck <= 0;
        IP2Bus_RdAck <= 0;
        IP2Bus_Error <= 0;
	// zero out the registers being used
        reg_file_linear <= {(C_S_IPIF_DATA_WIDTH*NUM_REGS_USED){1'b0}};
      end
      else begin
	IP2Bus_Data <= reg_data_out_next;
        IP2Bus_WrAck <= reg_wrack_out_next;
        IP2Bus_RdAck <= reg_rdack_out_next;
        IP2Bus_Error <= reg_error_next;
	
	reg_file_linear <= reg_file_linear_next;
      end
    end

endmodule
