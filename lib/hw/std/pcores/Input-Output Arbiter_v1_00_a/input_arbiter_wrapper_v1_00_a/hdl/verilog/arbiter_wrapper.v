`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Algo-Logic Systems
// Engineer: Adwait Gupte/Karthik Swamy
// 
// Create Date:    10:08:46 12/31/2010 
// Design Name:    Input Arbiter
// Module Name:    arbiter_wrapper 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module input_arbiter_wrapper #(parameter WIDTH = 256)
	
	(
	input [WIDTH -1:0] s_axis_mac0_tdata,
	input [(WIDTH/8)-1:0]  s_axis_mac0_tstrb,
	input   s_axis_mac0_tlast,
	input   s_axis_mac0_tvalid,
	output   s_axis_mac0_tready,
	
	input [WIDTH -1:0] s_axis_mac1_tdata,
	input [(WIDTH/8)-1:0]  s_axis_mac1_tstrb,
	input   s_axis_mac1_tlast,
	input   s_axis_mac1_tvalid,
	output   s_axis_mac1_tready,
	
	input [WIDTH -1:0] s_axis_mac2_tdata,
	input [(WIDTH/8)-1:0]  s_axis_mac2_tstrb,
	input   s_axis_mac2_tlast,
	input   s_axis_mac2_tvalid,
	output   s_axis_mac2_tready,
	
	input [WIDTH -1:0] s_axis_mac3_tdata,
	input [(WIDTH/8)-1:0]  s_axis_mac3_tstrb,
	input   s_axis_mac3_tlast,
	input   s_axis_mac3_tvalid,
	output   s_axis_mac3_tready,
	
	output [WIDTH -1:0] m_axis_udp_tdata,
	output [(WIDTH/8)-1:0]  m_axis_udp_tstrb,
	output   m_axis_udp_tlast,
	output   m_axis_udp_tvalid,
	input   m_axis_udp_tready,
	
	output [7:0] m_axis_spt_tdata,
	output  m_axis_spt_valid,
	
	output [7:0] m_axis_dpt_tdata,
	output  m_axis_dpt_valid,
	
	input clk,
	input rst

    );



input_arbiter #(WIDTH) iarbiter(


//data channel signals 
.t_valid0_in(s_axis_mac0_tvalid),.t_valid1_in(s_axis_mac1_tvalid),.t_valid2_in(s_axis_mac2_tvalid),.t_valid3_in(s_axis_mac3_tvalid),.t_valid4_in(0),
.t_last0_in(s_axis_mac0_tlast),.t_last1_in(s_axis_mac1_tlast),.t_last2_in(s_axis_mac2_tlast),.t_last3_in(s_axis_mac3_tlast),.t_last4_in(0),
.t_strb0_in(s_axis_mac0_tstrb),.t_strb1_in(s_axis_mac1_tstrb),.t_strb2_in(s_axis_mac2_tstrb),.t_strb3_in(s_axis_mac3_tstrb),.t_strb4_in(0),
.t_data0_in(s_axis_mac0_tdata),.t_data1_in(s_axis_mac1_tdata),.t_data2_in(s_axis_mac2_tdata),.t_data3_in(s_axis_mac3_tdata),.t_data4_in(0),
//arbiter to user logic signals
.t_ready_in(m_axis_udp_tready),
//ariber to preprocessor signals
.t_ready0_out(s_axis_mac0_tready),.t_ready1_out(s_axis_mac1_tready),.t_ready2_out(s_axis_mac2_tready),.t_ready3_out(s_axis_mac3_tready),
//common signals
.ACLK(clk),
//output signals to user logic
.t_data_out(m_axis_udp_tdata),
.t_strb_out(m_axis_udp_tstrb),
.t_sb_spt_out(m_axis_spt_tdata),
.t_sb_dpt_out(m_axis_dpt_tdata),
.t_last_out(m_axis_udp_tlast),.t_valid_out(m_axis_udp_tvalid),
.rst(~rst),
.t_valid_spt_out(m_axis_spt_valid),
.t_valid_dpt_out(m_axis_dpt_valid)


);

endmodule
