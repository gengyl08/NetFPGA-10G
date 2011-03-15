
////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Algo-Logic Systems
// Engineer: Karthik Swamy
// 
// Create Date:    19:28:35 11/27/2010 
// Design Name: 
// Module Name:    packet_stats 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: THIS CODE IS NOT COMPLETE!!!
//
//////////////////////////////////////////////////////////////////////////////////
module packet_stats(ACLK,statout0,statout1,statout2,statout3,statout4,statout5,
t_last0_in, t_last1_in,t_last2_in,t_last3_in,t_last4_in);

input ACLK,t_last0_in, t_last1_in,t_last2_in,t_last3_in,t_last4_in;
output [31:0] statout0,statout1,statout2,statout3,statout4,statout5;

//reg [31:0] statout0, statout1, statout2,statout3,statout4, statout5;
reg [31:0] tmp0,tmp1,tmp2,tmp3,tmp4,tmp5;

always@(posedge ACLK)
begin

	if (t_last0_in == 1'b1) begin
		tmp0 <= tmp0 + 1'b1;
		end
	else 
		tmp0 <= tmp0 + 1'b0;
end
	assign statout0 = tmp0;



/*always@(t_last4_in or t_last3_in or t_last2_in or t_last1_in or t_last0_in)
begin
		case ({t_last4_in, t_last3_in,t_last2_in,t_last1_in,t_last0_in})
		5'b00001 : tmp0 <= tmp0 + 1'b1;
		5'b00010 : tmp1 <= tmp1 + 1'b1;
		5'b00100 : tmp2 <= tmp2 + 1'b1;
		5'b01000 : tmp3 <= tmp3 + 1'b1;
		5'b10000 : tmp4 <= tmp4 + 1'b1;
		endcase
		
end
		assign statout0 = tmp0;
		assign statout1 = tmp1;
		assign statout2 = tmp2;
		assign statout3 = tmp3;
		assign statout4 = tmp4;
		assign statout5 = tmp0 + tmp1 + tmp2 + tmp3 + tmp4;
	*/	
endmodule


