// ---------------------------------------------------------------------
//
// NETFPGA-10G AXI wrapper for AutoESL generated code for L2 switch
// March, 2011
// 
// ---------------------------------------------------------------------


`timescale 1 ns / 1 ps 

module nf10_axis_netwave_l2switch 
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=8,
    parameter C_S_AXIS_DATA_WIDTH=8
)(
            aclk, 
			   aresetn, 
			   s_axis0_tvalid, 
			   s_axis0_tready,
			   s_axis0_tdata, 
			   s_axis0_tlast, 
			   s_axis0_tstrb,
			   m_axis0_tvalid, 
			   m_axis0_tready,
			   m_axis0_tdata, 
			   m_axis0_tlast, 
			   m_axis0_tstrb,
			   s_axis1_tvalid, 
			   s_axis1_tready,
			   s_axis1_tdata, 
			   s_axis1_tlast, 
			   s_axis1_tstrb,
			   m_axis1_tvalid, 
			   m_axis1_tready,
			   m_axis1_tdata, 
			   m_axis1_tlast, 
			   m_axis1_tstrb,
			   s_axis2_tvalid, 
			   s_axis2_tready,
			   s_axis2_tdata, 
			   s_axis2_tlast, 
			   s_axis2_tstrb,
			   m_axis2_tvalid, 
			   m_axis2_tready,
			   m_axis2_tdata, 
			   m_axis2_tlast, 
			   m_axis2_tstrb,
			   s_axis3_tvalid, 
			   s_axis3_tready,
			   s_axis3_tdata, 
			   s_axis3_tlast, 
			   s_axis3_tstrb,
			   m_axis3_tvalid, 
			   m_axis3_tready,
			   m_axis3_tdata, 
			   m_axis3_tlast, 
			   m_axis3_tstrb
			   );

input         aclk;
input         aresetn;
input         s_axis_tvalid;
output        s_axis_tready;
input  [7:0]  s_axis_tdata; 
input         s_axis_tlast; 
input         s_axis_tstrb; 
output        m_axis_tvalid;
input         m_axis_tready;
output [7:0]  m_axis_tdata; 
output        m_axis_tlast; 
output        m_axis_tstrb; 

wire aresetn_w;
wire [7:0] m_axis0_tdata_ii;
wire m_axis0_tvalid_ii;
reg [7:0] m_axis0_tdata_i;
reg m_axis0_tvalid_i;
wire [7:0] m_axis1_tdata_ii;
wire m_axis1_tvalid_ii;
reg [7:0] m_axis1_tdata_i;
reg m_axis1_tvalid_i;
wire [7:0] m_axis2_tdata_ii;
wire m_axis2_tvalid_ii;
reg [7:0] m_axis2_tdata_i;
reg m_axis2_tvalid_i;
wire [7:0] m_axis3_tdata_ii;
wire m_axis3_tvalid_ii;
reg [7:0] m_axis3_tdata_i;
reg m_axis3_tvalid_i;
reg ap_start_r;
reg start_count;

// header_removal UUT(
        // .packet_in_data_dout       (s_axis_tdata),
        // .packet_in_data_empty_n    (s_axis_tvalid),
        // .packet_in_data_read       (s_axis_tready),
        // .packet_out_data_aux_din   (),
        // .packet_out_data_aux_full_n(1'b1),
        // .packet_out_data_aux_write (),
        // .packet_out_data_din       (m_axis_tdata_ii),
        // .packet_out_data_full_n    (m_axis_tready),
        // .packet_out_data_write     (m_axis_tvalid_ii),
        // .ap_clk                    (aclk),
        // .ap_rst                    (aresetn_w),
        // .ap_start                  (ap_start_r),
        // .ap_idle                   (ap_idle),
        // .ap_done                   (ap_done)
// );

layer2_switch UUT (
        	.ap_clk  (aclk),
        	.ap_rst  (aresetn_w),
        	.ap_start (ap_start_r),
        	.ap_done  (ap_done),
        	.ap_idle   (ap_idle),

        	.packet_in_data0_dout     (s_axis0_tdata),
        	.packet_in_data0_empty_n  (s_axis0_tvalid),
        	.packet_in_data0_read     (s_axis0_tready),

        	.packet_in_data1_dout     (s_axis1_tdata),
        	.packet_in_data1_empty_n  (s_axis1_tvalid),
        	.packet_in_data1_read     (s_axis1_tready),

        	.packet_in_data2_dout     (s_axis2_tdata),
        	.packet_in_data2_empty_n  (s_axis2_tvalid),
        	.packet_in_data2_read     (s_axis2_tready),

        	.packet_in_data3_dout     (s_axis3_tdata),
        	.packet_in_data3_empty_n  (s_axis3_tvalid),
        	.packet_in_data3_read     (s_axis3_tready),

        	.packet_out_data0_din     (m_axis0_tdata_ii),
        	.packet_out_data0_full_n  (m_axis0_tready),
        	.packet_out_data0_write   (m_axis0_tvalid_ii),

        	.packet_out_data1_din     (m_axis1_tdata_ii),
        	.packet_out_data1_full_n  (m_axis1_tready),
        	.packet_out_data1_write   (m_axis1_tvalid_ii),

        	.packet_out_data2_din     (m_axis2_tdata_ii),
        	.packet_out_data2_full_n  (m_axis2_tready),
        	.packet_out_data2_write   (m_axis2_tvalid_ii),

        	.packet_out_data3_din     (m_axis3_tdata_ii),
        	.packet_out_data3_full_n  (m_axis3_tready),
        	.packet_out_data3_write   (m_axis3_tvalid_ii)
);


assign m_axis0_tlast = ap_done;
assign m_axis1_tlast = ap_done;
assign m_axis2_tlast = ap_done;
assign m_axis3_tlast = ap_done;

assign aresetn_w = ~aresetn;
assign m_axis0_tstrb = 1'b1;
assign m_axis1_tstrb = 1'b1;
assign m_axis2_tstrb = 1'b1;
assign m_axis3_tstrb = 1'b1;

assign m_axis0_tdata = m_axis0_tdata_i;
assign m_axis0_tvalid = m_axis0_tvalid_i;
assign m_axis1_tdata = m_axis0_tdata_i;
assign m_axis1_tvalid = m_axis0_tvalid_i;
assign m_axis2_tdata = m_axis0_tdata_i;
assign m_axis2_tvalid = m_axis0_tvalid_i;
assign m_axis3_tdata = m_axis0_tdata_i;
assign m_axis3_tvalid = m_axis0_tvalid_i;


always @(posedge aclk)
begin 
  if (aresetn == 1'b0) 
   begin 
     m_axis0_tdata_i <= 8'h00;
     m_axis0_tvalid_i <= 1'b0;
     m_axis1_tdata_i <= 8'h00;
     m_axis1_tvalid_i <= 1'b0;
     m_axis2_tdata_i <= 8'h00;
     m_axis2_tvalid_i <= 1'b0;
     m_axis3_tdata_i <= 8'h00;
     m_axis3_tvalid_i <= 1'b0;
     ap_start_r <= 1'b0;
     start_count <= 1'b0;
   end
  else 
   begin 
     m_axis0_tdata_i <= m_axis0_tdata_ii;
     m_axis0_tvalid_i <= m_axis0_tvalid_ii;
     m_axis1_tdata_i <= m_axis1_tdata_ii;
     m_axis1_tvalid_i <= m_axis1_tvalid_ii;
     m_axis2_tdata_i <= m_axis2_tdata_ii;
     m_axis2_tvalid_i <= m_axis2_tvalid_ii;
     m_axis3_tdata_i <= m_axis3_tdata_ii;
     m_axis3_tvalid_i <= m_axis3_tvalid_ii;
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