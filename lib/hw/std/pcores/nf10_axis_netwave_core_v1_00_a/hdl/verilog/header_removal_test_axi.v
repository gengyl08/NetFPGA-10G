// ==============================================================
// Test bench for AXI-fied header_removal
// Dec 20, 2010
// 
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module header_removal_test_axi;

wire [63:0] tb_packet_in_data_tdata;
reg 	    tb_packet_in_data_tvalid;
wire        tb_packet_in_data_tready;
wire        tb_packet_in_data_tlast;
wire [63:0] tb_packet_out_data_tdata;
wire 	    tb_packet_out_data_tvalid;
reg        tb_packet_out_data_tready;
wire        tb_packet_out_data_tlast;
wire [63:0] tb_packet_out_data_aux_tdata;
wire 	    tb_packet_out_data_aux_tvalid;
reg        tb_packet_out_data_aux_tready;
wire        tb_packet_out_data_aux_tlast;

reg tb_aclk;
reg tb_aresetn;

integer i=0;

reg [63:0] input_data[0:15];

header_removal_axi UUT(
			   .aclk  (tb_aclk), 
			   .aresetn  (tb_aresetn), 
			   
			   .packet_in_data_tvalid (tb_packet_in_data_tvalid), 
			   .packet_in_data_tready (tb_packet_in_data_tready),
			   .packet_in_data_tdata  (tb_packet_in_data_tdata), 
			   .packet_in_data_tlast  (tb_packet_in_data_tlast), 
			   .packet_in_data_tstrb  (1'b0), 
			   .packet_in_data_tkeep  (1'b0),
			   .packet_in_data_tid   (1'b0), 
			   .packet_in_data_tdest  (1'b0), 
			   .packet_in_data_tuser  (1'b0), 

			   .packet_out_data_aux_tvalid (tb_packet_out_data_aux_tvalid), 
			   .packet_out_data_aux_tready (tb_packet_out_data_aux_tready),
			   .packet_out_data_aux_tdata  (tb_packet_out_data_aux_tdata), 
			   .packet_out_data_aux_tlast  (tb_packet_out_data_aux_tlast), 
			   .packet_out_data_aux_tstrb  (), 
			   .packet_out_data_aux_tkeep  (),
			   .packet_out_data_aux_tid   (), 
			   .packet_out_data_aux_tdest  (), 
			   .packet_out_data_aux_tuser  (), 

			   .packet_out_data_tvalid  (tb_packet_out_data_tvalid), 
			   .packet_out_data_tready  (tb_packet_out_data_tready),
			   .packet_out_data_tdata   (tb_packet_out_data_tdata), 
			   .packet_out_data_tlast   (tb_packet_out_data_tlast), 
			   .packet_out_data_tstrb   (), 
			   .packet_out_data_tkeep   (),
			   .packet_out_data_tid    (), 
			   .packet_out_data_tdest   (), 
			   .packet_out_data_tuser   ()
			);


initial
begin
	input_data[0] = 64'h0000000000784567;
	input_data[1] = 64'h00000000327b23c6;
	input_data[2] = 64'h00000000643c9869;
	input_data[3] = 64'h0000002066334873;
	input_data[4] = 64'h0000000074b0dc51;
	input_data[5] = 64'h0000000019495cff;
	input_data[6] = 64'h000000000004944a;
	input_data[7] = 64'h00000000abcd58ec;
	input_data[8] = 64'h00000000238e1f29;
	input_data[9] = 64'h0000000046e87ccd;
	input_data[10] = 64'h000000003d1b58ba;
	input_data[11] = 64'h00000000507ed7ab;
	input_data[12] = 64'h000000002eb141f2;
	input_data[13] = 64'h0000000041b71efb;
	input_data[14] = 64'h0000000079e2a9e3;
	input_data[15] = 64'h000000003d1b58ba;
end

initial
	tb_aclk = 0;
	
always 
	#10 tb_aclk = ~tb_aclk;


initial
begin 
	
	#5 tb_aresetn = 0;
	   tb_packet_out_data_tready = 0;
	   tb_packet_out_data_aux_tready = 0;
	   tb_packet_in_data_tvalid = 0;

	#15 tb_aresetn = 1;
	    tb_packet_out_data_tready = 1;
 	    tb_packet_out_data_aux_tready = 1;
            tb_packet_in_data_tvalid = 1;
		
	#5000 $finish;
end

assign tb_packet_in_data_tdata = (tb_packet_in_data_tready)? input_data[i] : 64'bx;

always @ (posedge tb_aclk)
begin
	if (i<16)
	begin
		if (tb_packet_in_data_tready == 1'b1)
		begin
			i = i+1;
		end
	end
end


endmodule //header_removal_test_axi

