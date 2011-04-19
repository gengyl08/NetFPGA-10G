`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Algo-Logic Systems		
// Engineer: Karthik Swamy
// 
// Create Date:    15:37:07 11/27/2010 
// Design Name: 
// Module Name:    input_arbiter 
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
module input_arbiter(


//data channel signals 
t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in,
t_last0_in,t_last1_in,t_last2_in,t_last3_in,t_last4_in,
t_strb0_in,t_strb1_in,t_strb2_in,t_strb3_in,t_strb4_in,
t_data0_in,t_data1_in,t_data2_in,t_data3_in,t_data4_in,
//sideband channel signals
t_valid_len0_in,t_valid_len1_in,t_valid_len2_in,t_valid_len3_in,t_valid_len4_in,
t_valid_spt0_in,t_valid_spt1_in,t_valid_spt2_in,t_valid_spt3_in,t_valid_spt4_in,
t_valid_dpt0_in,t_valid_dpt1_in,t_valid_dpt2_in,t_valid_dpt3_in,t_valid_dpt4_in,
t_valid_err0_in,t_valid_err1_in,t_valid_err2_in,t_valid_err3_in,t_valid_err4_in, 
//sideband data signals
t_sb_len0_in,t_sb_spt0_in,t_sb_dpt0_in,t_sb_err0_in,
t_sb_len1_in,t_sb_spt1_in,t_sb_dpt1_in,t_sb_err1_in,
t_sb_len2_in,t_sb_spt2_in,t_sb_dpt2_in,t_sb_err2_in,
t_sb_len3_in,t_sb_spt3_in,t_sb_dpt3_in,t_sb_err3_in,
t_sb_len4_in,t_sb_spt4_in,t_sb_dpt4_in,t_sb_err4_in,
//arbiter to user logic signals
t_ready_in,
//ariber to preprocessor signals
t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out,
//common signals
ACLK,
//simulation signals
sel,t_last,
//axi-lite statistics registers
statout0,statout1,statout2,statout3,statout4,statout5,
//output signals to user logic
t_data_out,
t_strb_out,
t_sb_len_out,
t_sb_spt_out,
t_sb_dpt_out,
t_sb_err_out, t_last_out,t_valid_out,
rst,
t_valid_len_out,t_valid_spt_out,t_valid_dpt_out,t_valid_err_out


);

//This parameter will take the value of the top-level mpd file width selection
parameter WIDTH = 0;

input t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in,ACLK,t_ready_in;
input t_last0_in,t_last1_in,t_last2_in,t_last3_in,t_last4_in;
input [WIDTH-1:0]t_data0_in,t_data1_in,t_data2_in,t_data3_in,t_data4_in;  
input [(WIDTH/8)-1:0]t_strb0_in,t_strb1_in,t_strb2_in,t_strb3_in,t_strb4_in;
input rst;

// all sideband channel data and signals
input t_valid_len0_in,t_valid_len1_in,t_valid_len2_in,t_valid_len3_in,t_valid_len4_in;
input t_valid_spt0_in,t_valid_spt1_in,t_valid_spt2_in,t_valid_spt3_in,t_valid_spt4_in;
input t_valid_dpt0_in,t_valid_dpt1_in,t_valid_dpt2_in,t_valid_dpt3_in,t_valid_dpt4_in;
input t_valid_err0_in,t_valid_err1_in,t_valid_err2_in,t_valid_err3_in,t_valid_err4_in; 
input [15:0] t_sb_len0_in,t_sb_len1_in,t_sb_len2_in,t_sb_len3_in,t_sb_len4_in;
input [7:0] t_sb_spt0_in,t_sb_spt1_in,t_sb_spt2_in,t_sb_spt3_in,t_sb_spt4_in;
input [7:0] t_sb_dpt0_in,t_sb_dpt1_in,t_sb_dpt2_in,t_sb_dpt3_in,t_sb_dpt4_in;
input t_sb_err0_in,t_sb_err1_in,t_sb_err2_in,t_sb_err3_in,t_sb_err4_in;

output t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out,t_last;
//output [(WIDTH*2)+36:0] datapath;
//output [4:0] t_v_status;
output [2:0] sel;
output [31:0] statout0,statout1,statout2,statout3,statout4,statout5;

output [WIDTH-1:0] t_data_out;
output [7:0] t_strb_out;
output [15:0] t_sb_len_out;
output [7:0] t_sb_spt_out;
output [7:0] t_sb_dpt_out;
output t_sb_err_out, t_last_out;
output t_valid_out;
output t_valid_len_out,t_valid_spt_out,t_valid_dpt_out,t_valid_err_out;


controller inst0 (

.t_valid0_in(t_valid0_in),
.t_valid1_in(t_valid1_in),
.t_valid2_in(t_valid2_in),
.t_valid3_in(t_valid3_in),
.t_valid4_in(t_valid4_in),
.t_last0_in(t_last0_in),
.t_last1_in(t_last1_in),
.t_last2_in(t_last2_in),
.t_last3_in(t_last3_in),
.t_last4_in(t_last4_in),
.t_ready0_out(t_ready0_out),
.t_ready1_out(t_ready1_out),
.t_ready2_out(t_ready2_out),
.t_ready3_out(t_ready3_out),
.t_ready4_out(t_ready4_out),
.sel(sel [2:0]),
//.t_v_status(t_v_status [4:0] ),
.t_valid_out(t_valid_out),
.ACLK(ACLK),
.t_last(t_last),
.rst(rst),
.t_ready_in(t_ready_in),
.t_ready_input(t_ready_input),
.t_spt(t_spt));


datapath_mux #WIDTH inst1 (

//main data channel associated
.t_data0_in(t_data0_in ),
.t_data1_in(t_data1_in ),
.t_data2_in(t_data2_in ),
.t_data3_in(t_data3_in ),
.t_data4_in(t_data4_in ),
.t_valid0_in(t_valid0_in),
.t_valid1_in(t_valid1_in),
.t_valid2_in(t_valid2_in),
.t_valid3_in(t_valid3_in),
.t_valid4_in(t_valid4_in),
.t_last0_in(t_last0_in),
.t_last1_in(t_last1_in),
.t_last2_in(t_last2_in),
.t_last3_in(t_last3_in),
.t_last4_in(t_last4_in),
.t_ready0_out(t_ready0_out),
.t_ready1_out(t_ready1_out),
.t_ready2_out(t_ready2_out),
.t_ready3_out(t_ready3_out),
.t_ready4_out(t_ready4_out),
.t_strb0_in(t_strb0_in),
.t_strb1_in(t_strb1_in),
.t_strb2_in(t_strb2_in),
.t_strb3_in(t_strb3_in),
.t_strb4_in(t_strb4_in),
.sel(sel),
.t_spt(t_spt),
//sideband data and signals
.t_valid_len0_in(t_valid_len0_in),
.t_valid_len1_in(t_valid_len1_in),
.t_valid_len2_in(t_valid_len2_in),
.t_valid_len3_in(t_valid_len3_in),
.t_valid_len4_in(t_valid_len4_in),
.t_valid_spt0_in(t_valid_spt0_in),
.t_valid_spt1_in(t_valid_spt1_in),
.t_valid_spt2_in(t_valid_spt2_in),
.t_valid_spt3_in(t_valid_spt3_in),
.t_valid_spt4_in(t_valid_spt4_in),
.t_valid_dpt0_in(t_valid_dpt0_in),
.t_valid_dpt1_in(t_valid_dpt1_in),
.t_valid_dpt2_in(t_valid_dpt2_in),
.t_valid_dpt3_in(t_valid_dpt3_in),
.t_valid_dpt4_in(t_valid_dpt4_in),
.t_valid_err0_in(t_valid_err0_in),
.t_valid_err1_in(t_valid_err1_in),
.t_valid_err2_in(t_valid_err2_in),
.t_valid_err3_in(t_valid_err3_in),
.t_valid_err4_in(t_valid_err4_in),
.t_sb_len0_in(t_sb_len0_in),
.t_sb_spt0_in(t_sb_spt0_in),
.t_sb_dpt0_in(t_sb_dpt0_in),
.t_sb_err0_in(t_sb_err0_in),
.t_sb_len1_in(t_sb_len1_in),
.t_sb_spt1_in(t_sb_spt1_in),
.t_sb_dpt1_in(t_sb_dpt1_in),
.t_sb_err1_in(t_sb_err1_in),
.t_sb_len2_in(t_sb_len2_in),
.t_sb_spt2_in(t_sb_spt2_in),
.t_sb_dpt2_in(t_sb_dpt2_in),
.t_sb_err2_in(t_sb_err2_in),
.t_sb_len3_in(t_sb_len3_in),
.t_sb_spt3_in(t_sb_spt3_in),
.t_sb_dpt3_in(t_sb_dpt3_in),
.t_sb_err3_in(t_sb_err3_in),
.t_sb_len4_in(t_sb_len4_in),
.t_sb_spt4_in(t_sb_spt4_in),
.t_sb_dpt4_in(t_sb_dpt4_in),
.t_sb_err4_in(t_sb_err4_in),
.t_ready_in(t_ready_in),
.t_data_out(t_data_out),
.t_strb_out(t_strb_out),
.t_sb_len_out(t_sb_len_out),
.t_sb_spt_out(t_sb_spt_out),
.t_sb_dpt_out(t_sb_dpt_out),
.t_sb_err_out(t_sb_err_out), 
.t_last_out(t_last_out),
.t_valid_len_out(t_valid_len_out),
.t_valid_spt_out(t_valid_spt_out),
.t_valid_dpt_out(t_valid_dpt_out),
.t_valid_err_out(t_valid_err_out),
.t_valid_out(t_valid_out),
.ACLK(ACLK),
.rst(rst)
);

packet_stats inst2 (

.ACLK(ACLK),
.statout0(statout0 ),
.statout1(statout1 ),
.statout2(statout2 ),
.statout3(statout3 ),
.statout4(statout4 ),
.statout5(statout5 ),
.t_last0_in(t_last0_in),
.t_last1_in(t_last1_in),
.t_last2_in(t_last2_in),
.t_last3_in(t_last3_in),
.t_last4_in(t_last4_in));

endmodule
