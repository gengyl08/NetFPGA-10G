`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Algo-Logic Systems	
// Engineer: Karthik Swamy
// 
// Create Date:    15:25:30 11/27/2010 
// Design Name: 
// Module Name:    datapath_mux 
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
module datapath_mux(
sel, t_data0_in,t_data1_in,t_data2_in,t_data3_in,t_data4_in,t_ready_in,
//data channel and signals
t_last0_in,t_last1_in,t_last2_in,t_last3_in,t_last4_in,t_spt,
t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in,
t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out,
t_strb0_in,t_strb1_in,t_strb2_in,t_strb3_in,t_strb4_in,
//sideband channels and signals
t_sb_len0_in,t_sb_spt0_in,t_sb_dpt0_in,t_sb_err0_in,
t_sb_len1_in,t_sb_spt1_in,t_sb_dpt1_in,t_sb_err1_in,
t_sb_len2_in,t_sb_spt2_in,t_sb_dpt2_in,t_sb_err2_in,
t_sb_len3_in,t_sb_spt3_in,t_sb_dpt3_in,t_sb_err3_in,
t_sb_len4_in,t_sb_spt4_in,t_sb_dpt4_in,t_sb_err4_in,
t_valid_len0_in,t_valid_len1_in,t_valid_len2_in,t_valid_len3_in,t_valid_len4_in,
t_valid_spt0_in,t_valid_spt1_in,t_valid_spt2_in,t_valid_spt3_in,t_valid_spt4_in,
t_valid_dpt0_in,t_valid_dpt1_in,t_valid_dpt2_in,t_valid_dpt3_in,t_valid_dpt4_in,
t_valid_err0_in,t_valid_err1_in,t_valid_err2_in,t_valid_err3_in,t_valid_err4_in,
t_sb_err_out, t_last_out,
t_sb_dpt_out,t_sb_spt_out,t_sb_len_out,t_strb_out,t_data_out,
t_valid_len_out,t_valid_spt_out,t_valid_dpt_out,t_valid_err_out,
t_valid_out,ACLK,rst);

parameter WIDTH = 0;

input ACLK,t_spt;
input rst;
input t_valid_out;
input [WIDTH-1:0] t_data0_in,t_data1_in,t_data2_in,t_data3_in,t_data4_in;
input [2:0] sel;
input t_last0_in,t_last1_in,t_last2_in,t_last3_in,t_last4_in;
input t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in;
input t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out;
input [(WIDTH/8)-1:0]t_strb0_in,t_strb1_in,t_strb2_in,t_strb3_in,t_strb4_in;
input t_valid_len0_in,t_valid_len1_in,t_valid_len2_in,t_valid_len3_in,t_valid_len4_in;
input t_valid_spt0_in,t_valid_spt1_in,t_valid_spt2_in,t_valid_spt3_in,t_valid_spt4_in;
input t_valid_dpt0_in,t_valid_dpt1_in,t_valid_dpt2_in,t_valid_dpt3_in,t_valid_dpt4_in;
input t_valid_err0_in,t_valid_err1_in,t_valid_err2_in,t_valid_err3_in,t_valid_err4_in;

input [15:0] t_sb_len0_in,t_sb_len1_in,t_sb_len2_in,t_sb_len3_in,t_sb_len4_in;
input [7:0] t_sb_spt0_in,t_sb_spt1_in,t_sb_spt2_in,t_sb_spt3_in,t_sb_spt4_in;
input [7:0] t_sb_dpt0_in,t_sb_dpt1_in,t_sb_dpt2_in,t_sb_dpt3_in,t_sb_dpt4_in;
input t_sb_err0_in,t_sb_err1_in,t_sb_err2_in,t_sb_err3_in,t_sb_err4_in,t_ready_in;

//output [(WIDTH*2)+36:0] datapath;
//reg [WIDTH+29:0] datapath;
//reg [(WIDTH*2)+36:0] muxout;
////////////////////////////
output [WIDTH-1:0] t_data_out;
output [(WIDTH/8)-1:0] t_strb_out;
output [15:0] t_sb_len_out;
output [7:0] t_sb_spt_out;
output [7:0] t_sb_dpt_out;
output t_sb_err_out, t_last_out;
output t_valid_len_out,t_valid_spt_out,t_valid_dpt_out,t_valid_err_out;

wire t_valid_spt_out;
reg [WIDTH-1:0] t_data_out_r;
reg [(WIDTH/8)-1:0] t_strb_out_r;
reg [15:0] t_sb_len_out_r;
reg [7:0] t_sb_spt_out_r;
reg [7:0] t_sb_dpt_out_r;
reg t_sb_err_out, t_last_out;
reg t_valid_len_out,t_valid_dpt_out,t_valid_err_out;

/////////////////////////////////////////
always@(*)


begin
//if (t_ready_in == 1'b1)
begin
	case (sel)		
		3'b000 : 
		 t_data_out_r = t_data0_in;
		3'b001 : 
		 t_data_out_r = t_data1_in;
		3'b010 : 
		 t_data_out_r = t_data2_in;
		3'b011 : 
		 t_data_out_r = t_data3_in;
		3'b100 : 
		 t_data_out_r = t_data4_in;
 	default t_data_out_r = 0;
	endcase
end

//else 
//begin
//t_data_out_r = 0;

//end
end

assign t_data_out = t_data_out_r;


//////////////////////////////////
always@(*)
begin

	case (sel)		
		3'b000 : 
		 t_strb_out_r = t_strb0_in;
		3'b001 : 
		 t_strb_out_r = t_strb1_in;
		3'b010 : 
		 t_strb_out_r = t_strb2_in;
		3'b011 : 
		 t_strb_out_r = t_strb3_in;
		3'b100 : 
		 t_strb_out_r = t_strb4_in;
 	default t_strb_out_r = 0;
	endcase

end

assign t_strb_out = t_strb_out_r;
///////////////////////////////////
always@(*)

begin
if (t_ready_in == 1'b1)
begin
	case (sel)		
		3'b000 : 
		 t_sb_len_out_r = t_sb_len0_in;
		3'b001 : 
		 t_sb_len_out_r = t_sb_len1_in;
		3'b010 : 
		 t_sb_len_out_r = t_sb_len2_in;
		3'b011 : 
		 t_sb_len_out_r = t_sb_len3_in;
		3'b100 : 
		 t_sb_len_out_r = t_sb_len4_in;
 	default t_sb_len_out_r = 0;
	endcase
end

else 
begin
t_sb_len_out_r = 0;

end


end

assign t_sb_len_out = t_sb_len_out_r;
////////////////////////////////////
always@(*)

begin
if (t_ready_in == 1'b1)
begin
	case (sel)		
		3'b000 : 
		 t_sb_spt_out_r = 1;
		3'b001 : 
		 t_sb_spt_out_r = 2;
		3'b010 : 
		 t_sb_spt_out_r = 4;
		3'b011 : 
		 t_sb_spt_out_r = 8;
		3'b100 : 
		 t_sb_spt_out_r = 16;
 	default t_sb_spt_out_r = 0;
	endcase
end

else 
begin
t_sb_spt_out_r = 0;

end

end

assign t_sb_spt_out = t_sb_spt_out_r;
/////////////////////////////////////
always@(*)

begin
if (t_ready_in == 1'b1)
begin
	case (sel)		
		3'b000 : 
		 t_sb_dpt_out_r = t_sb_dpt0_in;
		3'b001 : 
		 t_sb_dpt_out_r = t_sb_dpt1_in;
		3'b010 : 
		 t_sb_dpt_out_r = t_sb_dpt2_in;
		3'b011 : 
		 t_sb_dpt_out_r = t_sb_dpt3_in;
		3'b100 : 
		 t_sb_dpt_out_r = t_sb_dpt4_in;
 	default t_sb_dpt_out_r = 0;
	endcase
end

else
begin
t_sb_dpt_out_r=0;

end


end

assign t_sb_dpt_out = t_sb_dpt_out_r;
////////////////////////////////////

always@(*)

begin
if (t_ready_in == 1'b1)
begin
	if (sel == 3'b000)		
		 begin
		 
		 t_sb_err_out = t_sb_err0_in;
		 t_last_out = t_last0_in;
		 t_valid_len_out = t_valid_len0_in;
		 //t_valid_spt_out = t_valid_spt0_in;
		 t_valid_dpt_out = t_valid_dpt0_in;
		 t_valid_err_out = t_valid_err0_in;
		 
		 end
	else if (sel == 3'b001)		
		 begin
		 t_sb_err_out = t_sb_err1_in;
		 t_last_out = t_last1_in;
		 t_valid_len_out = t_valid_len1_in;
		 //t_valid_spt_out = t_valid_spt1_in;
		 t_valid_dpt_out = t_valid_dpt1_in;
		 t_valid_err_out = t_valid_err1_in;
		 end
	else if (sel == 3'b010)		
		 begin
		 t_sb_err_out = t_sb_err2_in;
		 t_last_out = t_last2_in;
		 t_valid_len_out = t_valid_len2_in;
		// t_valid_spt_out = t_valid_spt2_in;
		 t_valid_dpt_out = t_valid_dpt2_in;
		 t_valid_err_out = t_valid_err2_in;
		 end
	else if (sel == 3'b011)		
		 begin
		 t_sb_err_out = t_sb_err3_in;
		 t_last_out = t_last3_in;
		 t_valid_len_out = t_valid_len3_in;
		// t_valid_spt_out = t_valid_spt3_in;
		 t_valid_dpt_out = t_valid_dpt3_in;
		 t_valid_err_out = t_valid_err3_in;
		 end
	else  		
		 begin
		 t_sb_err_out = t_sb_err4_in;
		 t_last_out = t_last4_in;
		 t_valid_len_out = t_valid_len4_in;
		// t_valid_spt_out = t_valid_spt4_in;
		 t_valid_dpt_out = t_valid_dpt4_in;
		 t_valid_err_out = t_valid_err4_in;
		 end
		 	
end

else
begin

		 t_sb_err_out = 0;	
		 t_last_out = 0;
		 t_valid_len_out = 0;
		 //t_valid_spt_out = 0;
		 t_valid_dpt_out = 0;
		 t_valid_err_out = 0;

end


end



assign t_valid_spt_out = t_spt;


endmodule

