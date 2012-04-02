/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        ipif_rbs_bridge.v
 *
 *  Library:
 *        contrib/pisa/pcores/nf10_axilite_rbs_bridge_v1_00_a
 *
 *  Module:
 *        ipif_rbs_bridge
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shahbaz
 *
 *  Description:
 *        IPIF to RBS (Register Bus Streaming - NetFPGA 1G reference pipeline) conversion library.
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

module ipif_rbs_bridge
#(
	// IPIF settings
	parameter C_S_IPIF_DATA_WIDTH = 32,
	parameter C_S_IPIF_ADDR_WIDTH = 32,
	parameter C_S_IPIF_CS_WIDTH = 1,
	parameter C_S_IPIF_RdCE_WIDTH = 1,
	parameter C_S_IPIF_WrCE_WIDTH = 1,
        parameter C_RBS_SRC_WIDTH = 2,
	parameter C_RBS_RING_SIZE = 16,
	parameter C_RBS_SRC_ID = 0
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
	output [C_S_IPIF_DATA_WIDTH-1:0]	IP2Bus_Data,
	output					IP2Bus_WrAck,
	output					IP2Bus_RdAck,
	output					IP2Bus_Error,

	// 1G Register side signals
        input                                   S_RBS_REQ,
        input                                   S_RBS_ACK,
        input                                   S_RBS_RD_WR_L,
        input [(C_S_IPIF_ADDR_WIDTH-2)-1:0]     S_RBS_ADDR,
        input [C_S_IPIF_DATA_WIDTH-1:0]         S_RBS_DATA,
        input [C_RBS_SRC_WIDTH-1:0]             S_RBS_SRC,

        output                                  M_RBS_REQ,
        output                                  M_RBS_ACK,
        output                                  M_RBS_RD_WR_L,
        output [(C_S_IPIF_ADDR_WIDTH-2)-1:0]    M_RBS_ADDR,
        output [C_S_IPIF_DATA_WIDTH-1:0]        M_RBS_DATA,
        output [C_RBS_SRC_WIDTH-1:0]            M_RBS_SRC
);
	
    // Internal signals	
    wire					core_reg_req;
    wire					core_reg_ack;
    wire					core_reg_rd_wr_L;
    wire [(C_S_IPIF_ADDR_WIDTH-2)-1:0]		core_reg_addr;
    wire [C_S_IPIF_DATA_WIDTH-1:0]		core_reg_rd_data;
    wire [C_S_IPIF_DATA_WIDTH-1:0]		core_reg_wr_data;

    
    // Internal connections
    assign IP2Bus_WrAck = core_reg_ack && !Bus2IP_RNW;
    assign IP2Bus_RdAck = core_reg_ack && Bus2IP_RNW;
    assign IP2Bus_Data = core_reg_rd_data; 
    assign IP2Bus_Error = 0; // Not implemented

    assign core_reg_req = Bus2IP_CS;
    assign core_reg_rd_wr_L = Bus2IP_RNW; 
    assign core_reg_addr = Bus2IP_Addr[C_S_IPIF_ADDR_WIDTH-1:2];
    assign core_reg_wr_data = Bus2IP_Data;
    
    
    // udp_reg_master (udp <-> rbs)
    udp_reg_master
    #(.SRC_ADDR(C_RBS_SRC_ID),
      .TIMEOUT(C_RBS_RING_SIZE*2),
      .TIMEOUT_RESULT('hdead_beef),
      .UDP_REG_SRC_WIDTH(C_RBS_SRC_WIDTH),
      .CPCI_NF2_DATA_WIDTH(C_S_IPIF_DATA_WIDTH),
      .UDP_REG_ADDR_WIDTH(C_S_IPIF_ADDR_WIDTH-2) // Word aligned
    ) udp_reg_master_inst
    (
        // Global Ports
        .clk(Bus2IP_Clk),
        .reset(Bus2IP_Reset),
        
        // Interface to Register_Converter
        .core_reg_req(core_reg_req),
        .core_reg_ack(core_reg_ack),
        .core_reg_rd_wr_L(core_reg_rd_wr_L),
        .core_reg_addr(core_reg_addr),
        .core_reg_rd_data(core_reg_rd_data),
        .core_reg_wr_data(core_reg_wr_data),
        
        // Interface to 1G Reference Pipeline
    	.reg_req_out(M_RBS_REQ),
        .reg_ack_out(M_RBS_ACK),
        .reg_rd_wr_L_out(M_RBS_RD_WR_L),
        .reg_addr_out(M_RBS_ADDR),
        .reg_data_out(M_RBS_DATA),
        .reg_src_out(M_RBS_SRC),

        .reg_req_in(S_RBS_REQ),
        .reg_ack_in(S_RBS_ACK),
        .reg_rd_wr_L_in(S_RBS_RD_WR_L),
        .reg_addr_in(S_RBS_ADDR),
        .reg_data_in(S_RBS_DATA),
        .reg_src_in(S_RBS_SRC)
    );

endmodule
