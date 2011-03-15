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
module output_arbiter(
//user logic to device
data_in,t_strb_in,t_valid_in, t_ready_out,t_last_in,ACLK,rst,
t_sb_len_in,t_sb_spt_in,t_sb_dpt_in,t_sb_err_in,
t_sb_len_valid_in,t_sb_spt_valid_in,t_sb_dpt_valid_in,t_sb_err_valid_in,
t_ready0_in, t_ready1_in,t_ready2_in,t_ready3_in,t_ready4_in,

//output of device to connect to AXI post processor
t_valid0_out,t_valid1_out,t_valid2_out,t_valid3_out,t_valid4_out,
t_data0_out,t_data1_out,t_data2_out,t_data3_out,t_data4_out, 
statout0,statout1,statout2,statout3,statout4,statout5,
t_last0_out,t_last1_out,t_last2_out,t_last3_out,t_last4_out,
t_strb0_out,t_strb1_out,t_strb2_out,t_strb3_out,t_strb4_out,
t_sb_len0_out,t_sb_spt0_out,t_sb_dpt0_out,t_sb_err0_out,
t_sb_len1_out,t_sb_spt1_out,t_sb_dpt1_out,t_sb_err1_out,
t_sb_len2_out,t_sb_spt2_out,t_sb_dpt2_out,t_sb_err2_out,
t_sb_len3_out,t_sb_spt3_out,t_sb_dpt3_out,t_sb_err3_out,
t_sb_len4_out,t_sb_spt4_out,t_sb_dpt4_out,t_sb_err4_out,
t_sb_len0_valid_out,t_sb_spt0_valid_out,t_sb_dpt0_valid_out,t_sb_err0_valid_out,
t_sb_len1_valid_out,t_sb_spt1_valid_out,t_sb_dpt1_valid_out,t_sb_err1_valid_out,
t_sb_len2_valid_out,t_sb_spt2_valid_out,t_sb_dpt2_valid_out,t_sb_err2_valid_out,
t_sb_len3_valid_out,t_sb_spt3_valid_out,t_sb_dpt3_valid_out,t_sb_err3_valid_out,
t_sb_len4_valid_out,t_sb_spt4_valid_out,t_sb_dpt4_valid_out,t_sb_err4_valid_out
);

// Set bit width here...32 | 64 | 256
parameter WIDTH = 32;

//input t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in,ACLK;
input [WIDTH-1:0]data_in;
input [(WIDTH/8)-1:0] t_strb_in;
input [15:0] t_sb_len_in;
input [7:0] t_sb_spt_in, t_sb_dpt_in;
input t_sb_err_in,t_valid_in,t_last_in,ACLK;
input t_sb_len_valid_in,t_sb_spt_valid_in,t_sb_dpt_valid_in,t_sb_err_valid_in;
input t_ready0_in, t_ready1_in,t_ready2_in,t_ready3_in,t_ready4_in;
input rst;
output [15:0] t_sb_len0_out,t_sb_len1_out,t_sb_len2_out,t_sb_len3_out,t_sb_len4_out;
output [7:0] t_sb_spt0_out,t_sb_spt1_out,t_sb_spt2_out,t_sb_spt3_out,t_sb_spt4_out;
output [7:0] t_sb_dpt0_out,t_sb_dpt1_out,t_sb_dpt2_out,t_sb_dpt3_out,t_sb_dpt4_out;
output t_sb_err0_out,t_sb_err1_out,t_sb_err2_out,t_sb_err3_out,t_sb_err4_out;
output t_sb_len0_valid_out,t_sb_spt0_valid_out,t_sb_dpt0_valid_out,t_sb_err0_valid_out;
output t_sb_len1_valid_out,t_sb_spt1_valid_out,t_sb_dpt1_valid_out,t_sb_err1_valid_out;
output t_sb_len2_valid_out,t_sb_spt2_valid_out,t_sb_dpt2_valid_out,t_sb_err2_valid_out;
output t_sb_len3_valid_out,t_sb_spt3_valid_out,t_sb_dpt3_valid_out,t_sb_err3_valid_out;
output t_sb_len4_valid_out,t_sb_spt4_valid_out,t_sb_dpt4_valid_out,t_sb_err4_valid_out;
output t_ready_out;
output [WIDTH -1:0] t_data0_out,t_data1_out,t_data2_out,t_data3_out,t_data4_out;

output t_last0_out,t_last1_out,t_last2_out,t_last3_out,t_last4_out;
//output [2:0] sel;
output [31:0] statout0,statout1,statout2,statout3,statout4,statout5;
output [(WIDTH/8)-1:0] t_strb0_out,t_strb1_out,t_strb2_out,t_strb3_out,t_strb4_out;
output t_valid0_out,t_valid1_out,t_valid2_out,t_valid3_out,t_valid4_out;



/*controller inst0 (

.t_valid0_out(t_valid0_out),
.t_valid1_out(t_valid1_out),
.t_valid2_out(t_valid2_out),
.t_valid3_out(t_valid3_out),
.t_valid4_out(t_valid4_out),
.t_last0_out(t_last0_out),
.t_last1_out(t_last1_out),
.t_last2_out(t_last2_out),
.t_last3_out(t_last3_out),
.t_last4_out(t_last4_out),
.sel(sel),
.ACLK(ACLK),
.t_last_in(t_last_in),
.t_ready_in(t_ready_in));*/


datapath_mux_op #WIDTH inst1 (

.ACLK(ACLK),
.rst(rst),
.data_in(data_in),
.t_strb_in(t_strb_in),
.t_valid_in(t_valid_in),
.t_last_in(t_last_in),
.t_ready_out(t_ready_out),
.t_sb_len_in(t_sb_len_in),
.t_sb_spt_in(t_sb_spt_in),
.t_sb_dpt_in(t_sb_dpt_in),
.t_sb_err_in(t_sb_err_in),
.t_data0_out(t_data0_out ),
.t_data1_out(t_data1_out ),
.t_data2_out(t_data2_out ),
.t_data3_out(t_data3_out ),
.t_data4_out(t_data4_out ),
.t_sb_len0_out(t_sb_len0_out),
.t_sb_spt0_out(t_sb_spt0_out),
.t_sb_dpt0_out(t_sb_dpt0_out),
.t_sb_err0_out(t_sb_err0_out),
.t_sb_len1_out(t_sb_len1_out),
.t_sb_spt1_out(t_sb_spt1_out),
.t_sb_dpt1_out(t_sb_dpt1_out),
.t_sb_err1_out(t_sb_err1_out),
.t_sb_len2_out(t_sb_len2_out),
.t_sb_spt2_out(t_sb_spt2_out),
.t_sb_dpt2_out(t_sb_dpt2_out),
.t_sb_err2_out(t_sb_err2_out),
.t_sb_len3_out(t_sb_len3_out),
.t_sb_spt3_out(t_sb_spt3_out),
.t_sb_dpt3_out(t_sb_dpt3_out),
.t_sb_err3_out(t_sb_err3_out),
.t_sb_len4_out(t_sb_len4_out),
.t_sb_spt4_out(t_sb_spt4_out),
.t_sb_dpt4_out(t_sb_dpt4_out),
.t_sb_err4_out(t_sb_err4_out),
.t_strb0_out(t_strb0_out),
.t_strb1_out(t_strb1_out),
.t_strb2_out(t_strb2_out),
.t_strb3_out(t_strb3_out),
.t_strb4_out(t_strb4_out),
.t_last0_out(t_last0_out),
.t_last1_out(t_last1_out),
.t_last2_out(t_last2_out),
.t_last3_out(t_last3_out),
.t_last4_out(t_last4_out),
.t_valid0_out(t_valid0_out),
.t_valid1_out(t_valid1_out),
.t_valid2_out(t_valid2_out),
.t_valid3_out(t_valid3_out),
.t_valid4_out(t_valid4_out),
.t_sb_len_valid_in(t_sb_len_valid_in),
.t_sb_spt_valid_in(t_sb_spt_valid_in),
.t_sb_dpt_valid_in(t_sb_dpt_valid_in),
.t_sb_err_valid_in(t_sb_err_valid_in),
.t_sb_len0_valid_out(t_sb_len0_valid_out),
.t_sb_spt0_valid_out(t_sb_spt0_valid_out),
.t_sb_dpt0_valid_out(t_sb_dpt0_valid_out),
.t_sb_err0_valid_out(t_sb_err0_valid_out),
.t_sb_len1_valid_out(t_sb_len1_valid_out),
.t_sb_spt1_valid_out(t_sb_spt1_valid_out),
.t_sb_dpt1_valid_out(t_sb_dpt1_valid_out),
.t_sb_err1_valid_out(t_sb_err1_valid_out),
.t_sb_len2_valid_out(t_sb_len2_valid_out),
.t_sb_spt2_valid_out(t_sb_spt2_valid_out),
.t_sb_dpt2_valid_out(t_sb_dpt2_valid_out),
.t_sb_err2_valid_out(t_sb_err2_valid_out),
.t_sb_len3_valid_out(t_sb_len3_valid_out),
.t_sb_spt3_valid_out(t_sb_spt3_valid_out),
.t_sb_dpt3_valid_out(t_sb_dpt3_valid_out),
.t_sb_err3_valid_out(t_sb_err3_valid_out),
.t_sb_len4_valid_out(t_sb_len4_valid_out),
.t_sb_spt4_valid_out(t_sb_spt4_valid_out),
.t_sb_dpt4_valid_out(t_sb_dpt4_valid_out),
.t_sb_err4_valid_out(t_sb_err4_valid_out),
.t_ready0_in(t_ready0_in), 
.t_ready1_in(t_ready1_in),
.t_ready2_in(t_ready2_in),
.t_ready3_in(t_ready3_in),
.t_ready4_in(t_ready4_in)
);

/*packet_stats inst2 (

.ACLK(ACLK),
.statout0(statout0 ),
.statout1(statout1 ),
.statout2(statout2 ),
.statout3(statout3 ),
.statout4(statout4 ),
.statout5(statout5 ));*/
//.t_last0_out(t_last0_out),
//.t_last1_out(t_last1_out),
//.t_last2_out(t_last2_out),
//.t_last3_out(t_last3_out),
//.t_last4_out(t_last4_out));

endmodule
