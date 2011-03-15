`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Algo-Logic Systems
// Engineer: Karthik Swamy
// 
// Create Date:    12:01:50 11/26/2010 
// Design Name: 
// Module Name:    controller 
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
module controller( 
t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in, 
ACLK,sel,t_valid_out,t_last,t_ready_in,t_ready_input,t_spt,
t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out,
t_last0_in,t_last1_in,t_last2_in,t_last3_in,t_last4_in ,rst);
input t_valid0_in,t_valid1_in,t_valid2_in,t_valid3_in,t_valid4_in,ACLK,t_last0_in,t_last1_in,t_last2_in,t_last3_in,t_last4_in,t_ready_in;
input rst;
  

output t_valid_out, t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out;
reg t_ready0_out,t_ready1_out,t_ready2_out,t_ready3_out,t_ready4_out;
//output [4:0] t_v_status;

//reg t_v_status;

output t_last,t_ready_input,t_spt;
reg t_last;
output [2:0]sel;
reg [2:0] sel= 3'b000;
wire t_spt;


always @ (posedge ACLK)
begin
t_last <= t_last0_in|t_last1_in|t_last2_in|t_last3_in|t_last4_in;
end

// Start of Arbitration Scheme
wire t_start;
reg t_valid_out_prev;
reg t_ready_input;

always@(posedge ACLK)
begin

t_valid_out_prev <= t_valid_out;

end
assign t_start = (~t_valid_out_prev & t_valid_out);
assign t_spt = (t_last == 1'b1)||(t_start ==1'b1);
//always@(posedge ACLK)
//begin

//t_ready_input <= t_ready_in;

//end








reg [2:0] sel_reg;

always@(*)
  begin
 // if(rst==1)
//	tlast_seen<=1;
	
//	if(t_last==1)
//		tlast_seen<=1;
  
  if ((t_last == 1'b1)||(t_start ==1'b1))
  begin
			$display(t_valid1_in,t_valid0_in);
		//	if(t_valid4_in==1||t_valid3_in==1||t_valid2_in==1||t_valid1_in==1||t_valid0_in==1)
		//		tlast_seen<=0;
			case({t_valid4_in,t_valid3_in,t_valid2_in,t_valid1_in,t_valid0_in})
			5'b00000 : sel = 3'b000; 
			5'b00001 : sel = 3'b000; 
			5'b00010 : sel = 3'b001; 
			
			5'b00011 :
				case (sel_reg)
				3'b000 : sel = 3'b001; 
				default sel = 3'b000;
				endcase

			5'b00100 : sel = 3'b010; 
			
			5'b00101 :
				case (sel_reg)
				3'b000 : sel = 3'b010;
				default sel = 3'b000;
				endcase
				
			5'b00110 :
				case (sel_reg)
				3'b001 : sel = 3'b010; 
				default sel = 3'b001;
				endcase
			5'b00111 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b010;
				default sel = 3'b000;
				endcase
			5'b01000 : sel = 3'b011;
			
			5'b01001 :
				case (sel_reg)
				3'b000 : sel = 3'b011;
				default sel = 3'b000;
				endcase
			5'b01010 :
				case (sel_reg)
				3'b001 : sel = 3'b011;
				default sel = 3'b001;
				endcase
			5'b01011 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b011;
				default sel = 3'b000;
				endcase
			5'b01100 :
				case (sel_reg)
				3'b010 : sel = 3'b011;
				default sel = 3'b010;
				endcase
			5'b01101 :
				case (sel_reg)
				3'b000 : sel = 3'b010;
				3'b010 : sel = 3'b011;
				default sel = 3'b000;
				endcase
			5'b01110 :
				case (sel_reg)
				3'b001 : sel = 3'b010;
				3'b010 : sel = 3'b011;
				default sel = 3'b001;
				endcase
			5'b01111 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b010;
				3'b010 : sel = 3'b011;
				default sel = 3'b000;
				endcase
			5'b10000 : sel = 3'b100;
			
			5'b10001 :
				case (sel_reg)
				3'b000 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b10010 :
				case (sel_reg)
				3'b001 : sel = 3'b100;
				default sel = 3'b001;
				endcase
			5'b10011 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b10100 :
				case (sel_reg)
				3'b010 : sel = 3'b100;
				default sel = 3'b010;
				endcase
			5'b10101 :
				case (sel_reg)
				3'b000 : sel = 3'b010;
				3'b010 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b10110 :
				case (sel_reg)
				3'b001 : sel = 3'b010;
				3'b010 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b10111 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b010;
				3'b010 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b11000 :
				case (sel_reg)
				3'b011 : sel = 3'b100;
				default sel = 3'b011;
				endcase
			5'b11001 :
				case (sel_reg)
				3'b000 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b11010 :
				case (sel_reg)
				3'b001 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b001;
				endcase
			5'b11011 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b11100 :
				case (sel_reg)
				3'b010 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b010;
				endcase
			5'b11101 :
				case (sel_reg)
				3'b000 : sel = 3'b010;
				3'b010 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b000;
				endcase
			5'b11110 :
				case (sel_reg)
				3'b001 : sel = 3'b010;
				3'b010 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b001;
				endcase
			5'b11111 :
				case (sel_reg)
				3'b000 : sel = 3'b001;
				3'b001 : sel = 3'b010;
				3'b010 : sel = 3'b011;
				3'b011 : sel = 3'b100;
				default sel = 3'b000;
				endcase
		endcase
	//end
	
end

/*else

begin sel = 3'b000; end*/

end

always@(posedge ACLK)
sel_reg <= sel;


// End of arbitration scheme
///////////////////////////////  



assign t_valid_out = (t_valid0_in|t_valid1_in|t_valid2_in|t_valid3_in|t_valid4_in);
		
always@(*)
begin
	if ((sel == 3'b000))
		begin

			t_ready0_out = t_ready_in;
			t_ready1_out = 1'b0;
			t_ready2_out = 1'b0;
			t_ready3_out = 1'b0;
			t_ready4_out = 1'b0;

			
		end
	else if ((sel == 3'b001))
		begin
						
			t_ready0_out = 1'b0;
			t_ready1_out = t_ready_in;
			t_ready2_out = 1'b0;
			t_ready3_out = 1'b0;
			t_ready4_out = 1'b0;
			
		end
	else if ((sel == 3'b010))
		begin
	
			t_ready0_out = 1'b0;
			t_ready1_out = 1'b0;
			t_ready2_out = t_ready_in;
			t_ready3_out = 1'b0;
			t_ready4_out = 1'b0;
			
		end
	else if ((sel == 3'b011))
		begin
			
			 t_ready0_out = 1'b0;
			 t_ready1_out = 1'b0;
			 t_ready2_out = 1'b0;
			 t_ready3_out = t_ready_in;
			 t_ready4_out = 1'b0;
			
		end
	else if ((sel == 3'b100))
		begin
	
						
			 t_ready0_out = 1'b0;
			 t_ready1_out = 1'b0;
			 t_ready2_out = 1'b0;
			 t_ready3_out = 1'b0;
			 t_ready4_out = t_ready_in;
			
		end
	else 
		begin
			
			 t_ready0_out = 1'b0;
			 t_ready1_out = 1'b0;
			 t_ready2_out = 1'b0;
			 t_ready3_out = 1'b0;
			 t_ready4_out = 1'b0;
			
		end

end


endmodule
