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
module datapath_mux_op(

//from user logic input
data_in,t_strb_in, t_valid_in,t_last_in,ACLK,
t_sb_len_in,t_sb_spt_in,t_sb_dpt_in,t_sb_err_in,
t_ready0_in, t_ready1_in,t_ready2_in,t_ready3_in,t_ready4_in,

/// control logic for user logic
t_ready_out,
//output to post processor
t_data0_out,t_data1_out,t_data2_out,t_data3_out,t_data4_out,
t_last0_out,t_last1_out,t_last2_out,t_last3_out,t_last4_out,
t_valid0_out,t_valid1_out,t_valid2_out,t_valid3_out,t_valid4_out,
t_sb_len_valid_in,t_sb_spt_valid_in,t_sb_dpt_valid_in,t_sb_err_valid_in,
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
rst,
t_sb_len4_valid_out,t_sb_spt4_valid_out,t_sb_dpt4_valid_out,t_sb_err4_valid_out
);

// This parameter will get overwritten at instantiation
parameter WIDTH =0;
parameter k = ((WIDTH-1)+(WIDTH/8));

output reg t_last0_out,t_last1_out, t_last2_out,t_last3_out,t_last4_out;
output t_valid0_out,t_valid1_out,t_valid2_out,t_valid3_out,t_valid4_out;
output t_ready_out;

output [WIDTH-1:0] t_data0_out,t_data1_out,t_data2_out,t_data3_out,t_data4_out;
output [(WIDTH/8)-1:0]t_strb0_out,t_strb1_out,t_strb2_out,t_strb3_out,t_strb4_out;
output [15:0] t_sb_len0_out,t_sb_len1_out,t_sb_len2_out,t_sb_len3_out,t_sb_len4_out;
output [7:0] t_sb_spt0_out,t_sb_spt1_out,t_sb_spt2_out,t_sb_spt3_out,t_sb_spt4_out;
output [7:0] t_sb_dpt0_out,t_sb_dpt1_out,t_sb_dpt2_out,t_sb_dpt3_out,t_sb_dpt4_out;
output t_sb_err0_out,t_sb_err1_out,t_sb_err2_out,t_sb_err3_out,t_sb_err4_out;
output t_sb_len0_valid_out,t_sb_spt0_valid_out,t_sb_dpt0_valid_out,t_sb_err0_valid_out;
output t_sb_len1_valid_out,t_sb_spt1_valid_out,t_sb_dpt1_valid_out,t_sb_err1_valid_out;
output t_sb_len2_valid_out,t_sb_spt2_valid_out,t_sb_dpt2_valid_out,t_sb_err2_valid_out;
output t_sb_len3_valid_out,t_sb_spt3_valid_out,t_sb_dpt3_valid_out,t_sb_err3_valid_out;
output t_sb_len4_valid_out,t_sb_spt4_valid_out,t_sb_dpt4_valid_out,t_sb_err4_valid_out;



//////////////
wire [WIDTH-1:0] t_data0_out,t_data1_out,t_data2_out,t_data3_out,t_data4_out;
wire [(WIDTH/8)-1:0]t_strb0_out,t_strb1_out,t_strb2_out,t_strb3_out,t_strb4_out;
wire [15:0] t_sb_len0_out,t_sb_len1_out,t_sb_len2_out,t_sb_len3_out,t_sb_len4_out;
wire [7:0] t_sb_spt0_out,t_sb_spt1_out,t_sb_spt2_out,t_sb_spt3_out,t_sb_spt4_out;
wire [7:0] t_sb_dpt0_out,t_sb_dpt1_out,t_sb_dpt2_out,t_sb_dpt3_out,t_sb_dpt4_out;
wire t_sb_err0_out,t_sb_err1_out,t_sb_err2_out,t_sb_err3_out,t_sb_err4_out;
wire t_valid0_out,t_valid1_out,t_valid2_out,t_valid3_out,t_valid4_out;
wire t_sb_len0_valid_out,t_sb_spt0_valid_out,t_sb_dpt0_valid_out,t_sb_err0_valid_out;
wire t_sb_len1_valid_out,t_sb_spt1_valid_out,t_sb_dpt1_valid_out,t_sb_err1_valid_out;
wire t_sb_len2_valid_out,t_sb_spt2_valid_out,t_sb_dpt2_valid_out,t_sb_err2_valid_out;
wire t_sb_len3_valid_out,t_sb_spt3_valid_out,t_sb_dpt3_valid_out,t_sb_err3_valid_out;
wire t_sb_len4_valid_out,t_sb_spt4_valid_out,t_sb_dpt4_valid_out,t_sb_err4_valid_out;

////////

input [WIDTH-1:0] data_in;
input [(WIDTH/8)-1:0] t_strb_in;
input [15:0] t_sb_len_in;
input [7:0] t_sb_spt_in;
input [7:0] t_sb_dpt_in;
input t_sb_err_in,t_last_in,t_valid_in, ACLK;
input t_sb_len_valid_in,t_sb_spt_valid_in,t_sb_dpt_valid_in,t_sb_err_valid_in;
input t_ready0_in, t_ready1_in,t_ready2_in,t_ready3_in,t_ready4_in;
reg t_ready_out;

wire fifo_full_0,fifo_full_1,fifo_full_2,fifo_full_3,fifo_full_4;

reg [k+39:0] data_comb;
input rst;

reg [k+39:0] mux_out_fifo_data_in0;
reg [k+39:0] mux_out_fifo_data_in1;
reg [k+39:0] mux_out_fifo_data_in2;
reg [k+39:0] mux_out_fifo_data_in3;
reg [k+39:0] mux_out_fifo_data_in4;

wire [k+39:0] fifo_data_out0;
wire [k+39:0] fifo_data_out1;
wire [k+39:0] fifo_data_out2;
wire [k+39:0] fifo_data_out3;
wire [k+39:0] fifo_data_out4;
reg [7:0] dest_reg;

//==============************************=================================
//////////////////////////Loads the dest_reg with destination channel id
// this value is held till the next packet
  always @(posedge ACLK)
    begin
     		
			if (t_sb_dpt_valid_in)
				dest_reg <= t_sb_dpt_in;
			else
				dest_reg <=dest_reg;
    end
//==============************************=================================


//==============************************=================================
///////////////////////this is the signal concatenation block
///////////////////////***************************************

always@(posedge ACLK)
begin

data_comb <= 

{
t_sb_err_in,t_sb_err_valid_in,
t_sb_dpt_in [7:0],t_sb_dpt_valid_in,
t_sb_spt_in [7:0],t_sb_spt_valid_in,
t_sb_len_in [15:0],t_sb_len_valid_in,
t_last_in,
t_valid_in,
data_in [WIDTH-1:0],
t_strb_in [(WIDTH/8)-1:0]

}; 

end
///////////////////////////////////////////////////////////////
//==============*******Main Mux*****************=================================
always@(*)
begin
	case (dest_reg)
	8'b00000001 : 
	begin
		mux_out_fifo_data_in0 = data_comb;
		mux_out_fifo_data_in1 = 0;
		mux_out_fifo_data_in2 = 0;
		mux_out_fifo_data_in3 = 0;
		mux_out_fifo_data_in4 = 0;
	end
	8'b00000010 : 
	begin
		mux_out_fifo_data_in0 = 0;
		mux_out_fifo_data_in1 = data_comb;
		mux_out_fifo_data_in2 = 0;
		mux_out_fifo_data_in3 = 0;
		mux_out_fifo_data_in4 = 0;
	end
	8'b00000100 : 
	begin
		mux_out_fifo_data_in0 = 0;
		mux_out_fifo_data_in1 = 0;
		mux_out_fifo_data_in2 = data_comb;
		mux_out_fifo_data_in3 = 0;
		mux_out_fifo_data_in4 = 0;
	end
   8'b00001000 :
	begin
		mux_out_fifo_data_in0 = 0;
		mux_out_fifo_data_in1 = 0;
		mux_out_fifo_data_in2 = 0;
		mux_out_fifo_data_in3 = data_comb;
		mux_out_fifo_data_in4 = 0;
	end
   default :
	begin
		mux_out_fifo_data_in0 = 0;
		mux_out_fifo_data_in1 = 0;
		mux_out_fifo_data_in2 = 0;
		mux_out_fifo_data_in3 = data_comb;
		mux_out_fifo_data_in4 = 0;
	end
	endcase
end


//====================****************************=======================
//=====****assign data outputs of fifo===================================

//////////////////////////////*********************
///pasted

	assign t_strb0_out = fifo_data_out0[(WIDTH/8)-1:0];
   assign t_data0_out = fifo_data_out0[k:(WIDTH/8)]; // k=71 for 64 bit
//	assign t_valid0_out = fifo_data_out0[72];
   assign t_sb_len0_valid_out = fifo_data_out0[k+3]; //+3
	assign t_sb_len0_out = fifo_data_out0[k+19:k+4]; 
	assign t_sb_spt0_valid_out = fifo_data_out0[k+20];
	assign t_sb_spt0_out = fifo_data_out0[k+28:k+21];
	assign t_sb_dpt0_valid_out = fifo_data_out0[k+29];
	assign t_sb_dpt0_out = fifo_data_out0[k+37:k+30];
	assign t_sb_err0_valid_out = fifo_data_out0[k+38];
	assign t_sb_err0_out = fifo_data_out0[k+39];
	
	assign t_strb1_out = fifo_data_out1[(WIDTH/8)-1:0];
   assign t_data1_out = fifo_data_out1[k:(WIDTH/8)];
//	assign t_valid1_out = fifo_data_out1[72];
   assign t_sb_len1_valid_out = fifo_data_out1[k+3];
	assign t_sb_len1_out = fifo_data_out1[k+19:k+4];
	assign t_sb_spt1_valid_out = fifo_data_out1[k+20];
	assign t_sb_spt1_out = fifo_data_out1[k+28:k+21];
	assign t_sb_dpt1_valid_out = fifo_data_out1[k+29];
	assign t_sb_dpt1_out = fifo_data_out1[k+37:k+30];
	assign t_sb_err1_valid_out = fifo_data_out1[k+38];
	assign t_sb_err1_out = fifo_data_out1[k+39];
	
   assign t_strb2_out = fifo_data_out2[(WIDTH/8)-1:0];
   assign t_data2_out = fifo_data_out2[k:(WIDTH/8)];
//	assign t_valid2_out = fifo_data_out2[72];
	//assign t_last2_out = fifo_data_out2[73];
   assign t_sb_len2_valid_out = fifo_data_out2[k+3];
	assign t_sb_len2_out = fifo_data_out2[k+19:k+4];
	assign t_sb_spt2_valid_out = fifo_data_out2[k+20];
	assign t_sb_spt2_out = fifo_data_out2[k+28:k+21];
	assign t_sb_dpt2_valid_out = fifo_data_out2[k+29];
	assign t_sb_dpt2_out = fifo_data_out2[k+37:k+30];
	assign t_sb_err2_valid_out = fifo_data_out2[k+38];
	assign t_sb_err2_out = fifo_data_out2[k+39];
	
   assign t_strb3_out = fifo_data_out3[(WIDTH/8)-1:0];
   assign t_data3_out = fifo_data_out3[k:(WIDTH/8)];
//	assign t_valid3_out = fifo_data_out3[72];
	//assign t_last3_out = fifo_data_out3[73];
   assign t_sb_len3_valid_out = fifo_data_out3[k+3];
	assign t_sb_len3_out = fifo_data_out3[k+19:k+4];
	assign t_sb_spt3_valid_out = fifo_data_out3[k+20];
	assign t_sb_spt3_out = fifo_data_out3[k+28:k+21];
	assign t_sb_dpt3_valid_out = fifo_data_out3[k+29];
	assign t_sb_dpt3_out = fifo_data_out3[k+37:k+30];
	assign t_sb_err3_valid_out = fifo_data_out3[k+38];
	assign t_sb_err3_out = fifo_data_out3[k+39];
	
   assign t_strb4_out = fifo_data_out4[(WIDTH/8)-1:0];
   assign t_data4_out = fifo_data_out4[k:(WIDTH/8)];
//	assign t_valid4_out = fifo_data_out4[72];
   assign t_sb_len4_valid_out = fifo_data_out4[k+3];
	assign t_sb_len4_out = fifo_data_out4[k+19:k+4];
	assign t_sb_spt4_valid_out = fifo_data_out4[k+20];
	assign t_sb_spt4_out = fifo_data_out4[k+28:k+21];
	assign t_sb_dpt4_valid_out = fifo_data_out4[k+29];
	assign t_sb_dpt4_out = fifo_data_out4[k+37:k+30];
	assign t_sb_err4_valid_out = fifo_data_out4[k+38];
	assign t_sb_err4_out = fifo_data_out4[k+39];
	
	
	always @ *
	begin
	//if(t_valid0_out)
	 t_last0_out = fifo_data_out0[k+2];
	//else	
	//	t_last0_out=0;
	end
	
   always @ *
	begin
	//if(t_valid1_out)
	 t_last1_out = fifo_data_out1[k+2];
	//else	
	//	t_last1_out=0;
	end
	
	always @ *
	begin
	//if(t_valid2_out)
	 t_last2_out = fifo_data_out2[k+2];
	//else	
	//	t_last2_out=0;
	end
	
	always @ *
	begin
	//if(t_valid3_out)
	 t_last3_out = fifo_data_out3[k+2];
	//else	
	//	t_last3_out=0;
	end

	always @ *
	begin
	t_last4_out = fifo_data_out4[k+2];
	end
///////////////////////////////////(((((((((((

//======================*****************************===================


//==============************************=================================
//==============fifo instantiations======================================


// use generate statements

//if (WIDTH == 64)
//begin
generate

if (WIDTH == 64)
begin
fifo fifo_inst0 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in0),  
	.wr_en(mux_out_fifo_data_in0[k+1]),
	.rd_en(t_ready0_in),
	.dout(fifo_data_out0),
	.full(fifo_full_0), 
	.valid(t_valid0_out));
// 
fifo fifo_inst1 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in1), 
	.wr_en(mux_out_fifo_data_in1[k+1]),
	.rd_en(t_ready1_in),
	.dout(fifo_data_out1),
   .full(fifo_full_1),	 
	.valid(t_valid1_out));
	
fifo fifo_inst2 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in2), 
	.wr_en(mux_out_fifo_data_in2[k+1]),
	.rd_en(t_ready2_in),
	.dout(fifo_data_out2),
   .full(fifo_full_2),	
	.valid(t_valid2_out));

fifo fifo_inst3 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in3),  
	.wr_en(mux_out_fifo_data_in3[k+1]),
	.rd_en(t_ready3_in),
	.dout(fifo_data_out3),
   .full(fifo_full_3),	
	.valid(t_valid3_out));

fifo fifo_inst4 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in4), 
	.wr_en(mux_out_fifo_data_in4[k+1]),
	.rd_en(t_ready4_in),
	.dout(fifo_data_out4),
   .full(fifo_full_4),	
	.valid(t_valid4_out));
end

else if (WIDTH == 32)
begin

fifo_32 fifo_inst0 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in0),  
	.wr_en(mux_out_fifo_data_in0[k+1]),
	.rd_en(t_ready0_in),
	.dout(fifo_data_out0),
	.full(fifo_full_0), 
	.valid(t_valid0_out));
// 
fifo_32 fifo_inst1 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in1), 
	.wr_en(mux_out_fifo_data_in1[k+1]),
	.rd_en(t_ready1_in),
	.dout(fifo_data_out1),
   .full(fifo_full_1),	 
	.valid(t_valid1_out));
	
fifo_32 fifo_inst2 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in2), 
	.wr_en(mux_out_fifo_data_in2[k+1]),
	.rd_en(t_ready2_in),
	.dout(fifo_data_out2),
   .full(fifo_full_2),	
	.valid(t_valid2_out));

fifo_32 fifo_inst3 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in3),  
	.wr_en(mux_out_fifo_data_in3[k+1]),
	.rd_en(t_ready3_in),
	.dout(fifo_data_out3),
   .full(fifo_full_3),	
	.valid(t_valid3_out));

fifo_32 fifo_inst4 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in4), 
	.wr_en(mux_out_fifo_data_in4[k+1]),
	.rd_en(t_ready4_in),
	.dout(fifo_data_out4),
   .full(fifo_full_4),	
	.valid(t_valid4_out));

end

else // fifo 256 bit

begin

fifo_256 fifo_inst0 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in0),  
	.wr_en(mux_out_fifo_data_in0[k+1]),
	.rd_en(t_ready0_in),
	.dout(fifo_data_out0),
	.full(fifo_full_0), 
	.valid(t_valid0_out));
// 
fifo_256 fifo_inst1 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in1), 
	.wr_en(mux_out_fifo_data_in1[k+1]),
	.rd_en(t_ready1_in),
	.dout(fifo_data_out1),
   .full(fifo_full_1),	 
	.valid(t_valid1_out));
	
fifo_256 fifo_inst2 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in2), 
	.wr_en(mux_out_fifo_data_in2[k+1]),
	.rd_en(t_ready2_in),
	.dout(fifo_data_out2),
   .full(fifo_full_2),	
	.valid(t_valid2_out));

fifo_256 fifo_inst3 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in3),  
	.wr_en(mux_out_fifo_data_in3[k+1]),
	.rd_en(t_ready3_in),
	.dout(fifo_data_out3),
   .full(fifo_full_3),	
	.valid(t_valid3_out));

fifo_256 fifo_inst4 (
	.clk(ACLK),
	.rst(rst),
	.din(mux_out_fifo_data_in4), 
	.wr_en(mux_out_fifo_data_in4[k+1]),
	.rd_en(t_ready4_in),
	.dout(fifo_data_out4),
   .full(fifo_full_4),	
	.valid(t_valid4_out));

end
endgenerate





///End of Fifo instantiations////////==================================
////////**************************************//////////////////////////
//==========================*****************************================
//=================control of data flow from user logic=================

always@(posedge ACLK)

	if ((fifo_full_0||fifo_full_1||fifo_full_2||fifo_full_3||fifo_full_4) == 1'b1)
		t_ready_out = 1'b0;
	else
		t_ready_out = 1'b1;
//=======================================================================

endmodule
