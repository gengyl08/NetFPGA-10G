// ---------------------------------------------------------------------
//
// AXI wrapper for AutoESL generated code for Layer2 Switch example
// Mar 1, 2011
// 
// ---------------------------------------------------------------------


`timescale 1 ns / 1 ps 

module layer2_switch_axi  (aclk, 
			   aresetn, 
			   
			   packet_in_data0_tvalid, 
			   packet_in_data0_tready,
			   packet_in_data0_tdata, 
			   packet_in_data0_tlast, 
			   packet_in_data0_tstrb, 
			   packet_in_data0_tkeep,
			   packet_in_data0_tid, 
			   packet_in_data0_tdest, 
			   packet_in_data0_tuser, 

			   packet_in_data1_tvalid, 
			   packet_in_data1_tready,
			   packet_in_data1_tdata, 
			   packet_in_data1_tlast, 
			   packet_in_data1_tstrb, 
			   packet_in_data1_tkeep,
			   packet_in_data1_tid, 
			   packet_in_data1_tdest, 
			   packet_in_data1_tuser, 

			   packet_in_data2_tvalid, 
			   packet_in_data2_tready,
			   packet_in_data2_tdata, 
			   packet_in_data2_tlast, 
			   packet_in_data2_tstrb, 
			   packet_in_data2_tkeep,
			   packet_in_data2_tid, 
			   packet_in_data2_tdest, 
			   packet_in_data2_tuser, 

			   packet_in_data3_tvalid, 
			   packet_in_data3_tready,
			   packet_in_data3_tdata, 
			   packet_in_data3_tlast, 
			   packet_in_data3_tstrb, 
			   packet_in_data3_tkeep,
			   packet_in_data3_tid, 
			   packet_in_data3_tdest, 
			   packet_in_data3_tuser, 

			   packet_out_data0_tvalid, 
			   packet_out_data0_tready,
			   packet_out_data0_tdata, 
			   packet_out_data0_tlast, 
			   packet_out_data0_tstrb, 
			   packet_out_data0_tkeep,
			   packet_out_data0_tid, 
			   packet_out_data0_tdest, 
			   packet_out_data0_tuser, 

			   packet_out_data1_tvalid, 
			   packet_out_data1_tready,
			   packet_out_data1_tdata, 
			   packet_out_data1_tlast, 
			   packet_out_data1_tstrb, 
			   packet_out_data1_tkeep,
			   packet_out_data1_tid, 
			   packet_out_data1_tdest, 
			   packet_out_data1_tuser, 

			   packet_out_data2_tvalid, 
			   packet_out_data2_tready,
			   packet_out_data2_tdata, 
			   packet_out_data2_tlast, 
			   packet_out_data2_tstrb, 
			   packet_out_data2_tkeep,
			   packet_out_data2_tid, 
			   packet_out_data2_tdest, 
			   packet_out_data2_tuser,

			   packet_out_data3_tvalid, 
			   packet_out_data3_tready,
			   packet_out_data3_tdata, 
			   packet_out_data3_tlast, 
			   packet_out_data3_tstrb, 
			   packet_out_data3_tkeep,
			   packet_out_data3_tid, 
			   packet_out_data3_tdest, 
			   packet_out_data3_tuser

			   );


input aclk;
input aresetn;

input  packet_in_data0_tvalid;
output  packet_in_data0_tready;
input [7:0] packet_in_data0_tdata; 
input packet_in_data0_tlast; 
input packet_in_data0_tstrb; 
input packet_in_data0_tkeep;
input packet_in_data0_tid; 
input packet_in_data0_tdest; 
input packet_in_data0_tuser; 

input  packet_in_data1_tvalid;
output  packet_in_data1_tready;
input [7:0] packet_in_data1_tdata; 
input packet_in_data1_tlast; 
input packet_in_data1_tstrb; 
input packet_in_data1_tkeep;
input packet_in_data1_tid; 
input packet_in_data1_tdest; 
input packet_in_data1_tuser;

input  packet_in_data2_tvalid;
output  packet_in_data2_tready;
input [7:0] packet_in_data2_tdata; 
input packet_in_data2_tlast; 
input packet_in_data2_tstrb; 
input packet_in_data2_tkeep;
input packet_in_data2_tid; 
input packet_in_data2_tdest; 
input packet_in_data2_tuser;

input  packet_in_data3_tvalid;
output  packet_in_data3_tready;
input [7:0] packet_in_data3_tdata; 
input packet_in_data3_tlast; 
input packet_in_data3_tstrb; 
input packet_in_data3_tkeep;
input packet_in_data3_tid; 
input packet_in_data3_tdest; 
input packet_in_data3_tuser;

output  packet_out_data0_tvalid;
input packet_out_data0_tready;
output [7:0] packet_out_data0_tdata; 
output  packet_out_data0_tlast; 
output  packet_out_data0_tstrb; 
output  packet_out_data0_tkeep;
output  packet_out_data0_tid; 
output  packet_out_data0_tdest; 
output  packet_out_data0_tuser; 

output  packet_out_data1_tvalid;
input packet_out_data1_tready;
output [7:0]  packet_out_data1_tdata; 
output  packet_out_data1_tlast; 
output  packet_out_data1_tstrb; 
output  packet_out_data1_tkeep;
output  packet_out_data1_tid; 
output  packet_out_data1_tdest; 
output  packet_out_data1_tuser; 

output  packet_out_data2_tvalid;
input packet_out_data2_tready;
output [7:0]  packet_out_data2_tdata; 
output  packet_out_data2_tlast; 
output  packet_out_data2_tstrb; 
output  packet_out_data2_tkeep;
output  packet_out_data2_tid; 
output  packet_out_data2_tdest; 
output  packet_out_data2_tuser; 

output  packet_out_data3_tvalid;
input packet_out_data3_tready;
output [7:0]  packet_out_data3_tdata; 
output  packet_out_data3_tlast; 
output  packet_out_data3_tstrb; 
output  packet_out_data3_tkeep;
output  packet_out_data3_tid; 
output  packet_out_data3_tdest; 
output  packet_out_data3_tuser; 

wire aresetn_w;
reg ap_start_r;
reg start_count;

layer2_switch UUT (
        	.ap_clk  (aclk),
        	.ap_rst  (aresetn_w),
        	.ap_start (ap_start_r),
        	.ap_done  (ap_done),
        	.ap_idle   (ap_idle),

        	.packet_in_data0_dout     (packet_in_data0_tdata),
        	.packet_in_data0_empty_n  (packet_in_data0_tvalid),
        	.packet_in_data0_read     (packet_in_data0_tready),

        	.packet_in_data1_dout     (packet_in_data1_tdata),
        	.packet_in_data1_empty_n  (packet_in_data1_tvalid),
        	.packet_in_data1_read     (packet_in_data1_tready),

        	.packet_in_data2_dout     (packet_in_data2_tdata),
        	.packet_in_data2_empty_n  (packet_in_data2_tvalid),
        	.packet_in_data2_read     (packet_in_data2_tready),

        	.packet_in_data3_dout     (packet_in_data3_tdata),
        	.packet_in_data3_empty_n  (packet_in_data3_tvalid),
        	.packet_in_data3_read     (packet_in_data3_tready),

        	.packet_out_data0_din     (packet_out_data0_tdata),
        	.packet_out_data0_full_n  (packet_out_data0_tready),
        	.packet_out_data0_write   (packet_out_data0_tvalid),

        	.packet_out_data1_din     (packet_out_data1_tdata),
        	.packet_out_data1_full_n  (packet_out_data1_tready),
        	.packet_out_data1_write   (packet_out_data1_tvalid),

        	.packet_out_data2_din     (packet_out_data2_tdata),
        	.packet_out_data2_full_n  (packet_out_data2_tready),
        	.packet_out_data2_write   (packet_out_data2_tvalid),

        	.packet_out_data3_din     (packet_out_data3_tdata),
        	.packet_out_data3_full_n  (packet_out_data3_tready),
        	.packet_out_data3_write   (packet_out_data3_tvalid)
);


assign packet_out_data0_tlast = ap_done;
assign packet_out_data1_tlast = ap_done;
assign packet_out_data2_tlast = ap_done;
assign packet_out_data3_tlast = ap_done;

assign aresetn_w = ~aresetn;


	always @(posedge aclk)
	begin 
  	 if (aresetn == 1'b0) 
   	 begin 
     		ap_start_r <= 1'b0;
     		start_count <= 1'b0;
   	 end
  	 else 
   	 begin 
     		if (start_count == 1'b0) 
		begin  
       			ap_start_r <= 1'b1;
       			start_count <= 1'b1;
     		end
     		else 
       			ap_start_r <= 1'b0;

     		if (ap_done == 1'b1) 
         		start_count <= 1'b0;
   	 end
	end

endmodule  // layer2_switch_axi