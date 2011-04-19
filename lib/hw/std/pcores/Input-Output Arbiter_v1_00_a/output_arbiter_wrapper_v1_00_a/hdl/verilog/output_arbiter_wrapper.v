`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Algo-Logic Systems
// Engineer: Adwait Gupte/Karthik Swamy
// 
// Create Date:    10:08:46 12/31/2010 
// Design Name: 
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
module output_arbiter_wrapper #(parameter WIDTH = 0)
	
	(

	output [WIDTH-1:0] m_axis_mac0_tdata,
	output [(WIDTH/8)-1:0]  m_axis_mac0_tstrb,
	output   m_axis_mac0_tlast,
	output   m_axis_mac0_tvalid,
	input   m_axis_mac0_tready,
	
	output [WIDTH-1:0] m_axis_mac1_tdata,
	output [(WIDTH/8)-1:0]  m_axis_mac1_tstrb,
	output   m_axis_mac1_tlast,
	output   m_axis_mac1_tvalid,
	input   m_axis_mac1_tready,
	
	output [WIDTH-1:0] m_axis_mac2_tdata,
	output [(WIDTH/8)-1:0]  m_axis_mac2_tstrb,
	output   m_axis_mac2_tlast,
	output   m_axis_mac2_tvalid,
	input   m_axis_mac2_tready,
	
	output [WIDTH-1:0] m_axis_mac3_tdata,
	output [(WIDTH/8)-1:0]  m_axis_mac3_tstrb,
	output   m_axis_mac3_tlast,
	output   m_axis_mac3_tvalid,
	input   m_axis_mac3_tready,
	
	output [WIDTH-1:0] m_axis_mac4_tdata,
	output [(WIDTH/8)-1:0]  m_axis_mac4_tstrb,
	output   m_axis_mac4_tlast,
	output   m_axis_mac4_tvalid,
	input   m_axis_mac4_tready,

	input [WIDTH-1:0] s_axis_udp_tdata,
	input [(WIDTH/8)-1:0]  s_axis_udp_tstrb,
	input   s_axis_udp_tlast,
	input   s_axis_udp_tvalid,
	output   s_axis_udp_tready,
	
	input [7:0] s_axis_spt_tdata,
	input  s_axis_spt_valid,
	
	input [7:0] s_axis_dpt_tdata,
	input  s_axis_dpt_valid,
	
	input s_axis_err_tvalid,
	output m_axis_err_tvalid,
	
	input clk,
	input rst

    );


output_arbiter #(WIDTH) oarbiter(
//user logic to device
.data_in(s_axis_udp_tdata),.t_strb_in(s_axis_udp_tstrb),.t_valid_in(s_axis_udp_tvalid), .t_ready_out(s_axis_udp_tready),.t_last_in(s_axis_udp_tlast),.ACLK(clk),.rst(~rst),
.t_sb_spt_in(s_axis_spt_tdata),.t_sb_dpt_in(s_axis_dpt_tdata),
.t_sb_spt_valid_in( s_axis_spt_valid),.t_sb_dpt_valid_in(s_axis_dpt_valid),
.t_ready0_in(m_axis_mac0_tready), .t_ready1_in(m_axis_mac1_tready),.t_ready2_in(m_axis_mac2_tready),.t_ready3_in(m_axis_mac3_tready),.t_ready4_in(m_axis_mac4_tready),
.t_sb_err_valid_in(s_axis_err_tvalid),

//output of device to connect to AXI post processor
.t_sb_err1_valid_out(m_axis_err_tvalid),
.t_valid0_out(m_axis_mac0_tvalid),.t_valid1_out(m_axis_mac1_tvalid),.t_valid2_out(m_axis_mac2_tvalid),.t_valid3_out(m_axis_mac3_tvalid),.t_valid4_out(m_axis_mac4_tvalid),
.t_data0_out(m_axis_mac0_tdata),.t_data1_out(m_axis_mac1_tdata),.t_data2_out(m_axis_mac2_tdata),.t_data3_out(m_axis_mac3_tdata),.t_data4_out(m_axis_mac4_tdata),
.t_last0_out(m_axis_mac0_tlast),.t_last1_out(m_axis_mac1_tlast),.t_last2_out(m_axis_mac2_tlast),.t_last3_out(m_axis_mac3_tlast),.t_last4_out(m_axis_mac4_tlast),
.t_strb0_out(m_axis_mac0_tstrb),.t_strb1_out(m_axis_mac1_tstrb),.t_strb2_out(m_axis_mac2_tstrb),.t_strb3_out(m_axis_mac3_tstrb),.t_strb4_out(m_axis_mac4_tstrb),

);

endmodule
