// ---------------------------------------------------------------------
//
// NETFPGA-10G AXI wrapper for AutoESL generated code for Header Removal example
// Dec 20, 2010
// 
// ---------------------------------------------------------------------


`timescale 1 ns / 1 ps 

module nf10_axis_netwave_core 
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=64,
    parameter C_S_AXIS_DATA_WIDTH=64
)(
            aclk, 
			   aresetn, 
			   s_axis_tvalid, 
			   s_axis_tready,
			   s_axis_tdata, 
			   s_axis_tlast, 
			   s_axis_tstrb,
			   m_axis_tvalid, 
			   m_axis_tready,
			   m_axis_tdata, 
			   m_axis_tlast, 
			   m_axis_tstrb
			   );

input         aclk;
input         aresetn;
input         s_axis_tvalid;
output        s_axis_tready;
input  [63:0] s_axis_tdata; 
input         s_axis_tlast; 
input  [7:0]  s_axis_tstrb; 
output        m_axis_tvalid;
input         m_axis_tready;
output [63:0] m_axis_tdata; 
output        m_axis_tlast; 
output [7:0]  m_axis_tstrb; 

wire aresetn_w;
wire [63:0] m_axis_tdata_ii;
wire m_axis_tvalid_ii;
reg [63:0] m_axis_tdata_i;
reg m_axis_tvalid_i;
reg ap_start_r;
reg start_count;

header_removal UUT(
        .packet_in_data_dout       (s_axis_tdata),
        .packet_in_data_empty_n    (s_axis_tvalid),
        .packet_in_data_read       (s_axis_tready),
        .packet_out_data_aux_din   (),
        .packet_out_data_aux_full_n(1'b1),
        .packet_out_data_aux_write (),
        .packet_out_data_din       (m_axis_tdata_ii),
        .packet_out_data_full_n    (m_axis_tready),
        .packet_out_data_write     (m_axis_tvalid_ii),
        .ap_clk                    (aclk),
        .ap_rst                    (aresetn_w),
        .ap_start                  (ap_start_r),
        .ap_idle                   (ap_idle),
        .ap_done                   (ap_done)
);

assign m_axis_tlast = ap_done;
assign aresetn_w = ~aresetn;
assign m_axis_tstrb = 8'b11111111;

assign m_axis_tdata = m_axis_tdata_i;
assign m_axis_tvalid = m_axis_tvalid_i;

always @(posedge aclk)
begin 
  if (aresetn == 1'b0) 
   begin 
     m_axis_tdata_i <= 64'h0000000000000000;
     m_axis_tvalid_i <= 1'b0;
     ap_start_r <= 1'b0;
     start_count <= 1'b0;
   end
  else 
   begin 
     m_axis_tdata_i <= m_axis_tdata_ii;
     m_axis_tvalid_i <= m_axis_tvalid_ii;
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



endmodule 