// ---------------------------------------------------------------------
//
// AXI wrapper for AutoESL generated code for Header Removal example
// Dec 20, 2010
// 
// ---------------------------------------------------------------------


`timescale 1 ns / 1 ps 

module header_removal_axi (aclk, 
			   aresetn, 
			   
			   packet_in_data_tvalid, 
			   packet_in_data_tready,
			   packet_in_data_tdata, 
			   packet_in_data_tlast, 
			   packet_in_data_tstrb, 
			   packet_in_data_tkeep,
			   packet_in_data_tid, 
			   packet_in_data_tdest, 
			   packet_in_data_tuser, 

			   packet_out_data_aux_tvalid, 
			   packet_out_data_aux_tready,
			   packet_out_data_aux_tdata, 
			   packet_out_data_aux_tlast, 
			   packet_out_data_aux_tstrb, 
			   packet_out_data_aux_tkeep,
			   packet_out_data_aux_tid, 
			   packet_out_data_aux_tdest, 
			   packet_out_data_aux_tuser, 

			   packet_out_data_tvalid, 
			   packet_out_data_tready,
			   packet_out_data_tdata, 
			   packet_out_data_tlast, 
			   packet_out_data_tstrb, 
			   packet_out_data_tkeep,
			   packet_out_data_tid, 
			   packet_out_data_tdest, 
			   packet_out_data_tuser
			   );


input aclk;
input aresetn;

input  packet_in_data_tvalid;
output  packet_in_data_tready;
input [63:0] packet_in_data_tdata; 
input packet_in_data_tlast; 
input packet_in_data_tstrb; 
input packet_in_data_tkeep;
input packet_in_data_tid; 
input packet_in_data_tdest; 
input packet_in_data_tuser; 

output  packet_out_data_aux_tvalid;
input packet_out_data_aux_tready;
output [63:0] packet_out_data_aux_tdata; 
output  packet_out_data_aux_tlast; 
output  packet_out_data_aux_tstrb; 
output  packet_out_data_aux_tkeep;
output  packet_out_data_aux_tid; 
output  packet_out_data_aux_tdest; 
output  packet_out_data_aux_tuser; 

output  packet_out_data_tvalid;
input packet_out_data_tready;
output [63:0]  packet_out_data_tdata; 
output  packet_out_data_tlast; 
output  packet_out_data_tstrb; 
output  packet_out_data_tkeep;
output  packet_out_data_tid; 
output  packet_out_data_tdest; 
output  packet_out_data_tuser; 

wire aresetn_w;
reg ap_start_r;
reg start_count;


header_removal UUT(
        .packet_in_data_dout(packet_in_data_tdata),
        .packet_in_data_empty_n(packet_in_data_tvalid),
        .packet_in_data_read(packet_in_data_tready),
        .packet_out_data_aux_din(packet_out_data_aux_tdata),
        .packet_out_data_aux_full_n(packet_out_data_aux_tready),
        .packet_out_data_aux_write(packet_out_data_aux_tvalid),
        .packet_out_data_din(packet_out_data_tdata),
        .packet_out_data_full_n(packet_out_data_tready),
        .packet_out_data_write(packet_out_data_tvalid),
        .ap_clk(aclk),
        .ap_rst(aresetn_w),
        .ap_start(ap_start_r),
        .ap_idle(ap_idle),
        .ap_done(ap_done)
);


assign packet_out_data_tlast = ap_done;
assign packet_out_data_aux_tlast = ap_done;
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
     if (start_count == 1'b0) begin  
       ap_start_r <= 1'b1;
       start_count <= 1'b1;
     end
     else 
       ap_start_r <= 1'b0;

     if (ap_done == 1'b1) 
         start_count <= 1'b0;
   end

end

endmodule  // header_removal_axi