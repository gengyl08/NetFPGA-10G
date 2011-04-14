////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          nf10_axis_converter
//
//  Description:
//          Convert AXI4-Streams to different data width
//          Add LEN subchannel
//                 
//  Revision history:
//          2011/2/6 hyzeng: Initial check-in
//			2011/4/13 hyzeng: Updated with new NetFPGA-10G AXI spec
//
////////////////////////////////////////////////////////////////////////
module nf10_axis_converter
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=64,
    parameter C_S_AXIS_DATA_WIDTH=256,
    
    parameter C_TUSER_DATA_WIDTH=128,

    parameter C_LEN_DATA_WIDTH=16,
    parameter C_SPT_DATA_WIDTH=8,
    parameter C_DPT_DATA_WIDTH=8,
    
    parameter C_SRC_PORT=0,
    parameter C_DST_PORT=0
)
(
    // Part 1: System side signals
    // Global Ports
    input axi_aclk,
    input axi_resetn,
    
    // Master Stream Ports
    output reg [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output reg [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output [C_TUSER_DATA_WIDTH-1:0] m_axis_tuser,
    output reg m_axis_tvalid,
    input  m_axis_tready,
    output reg m_axis_tlast,
    
    // Slave Stream Ports
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_TUSER_DATA_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
    input  s_axis_tlast
);

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   localparam MAX_PKT_SIZE = 1600; // In bytes	
   localparam LENGTH_COUNTER_WIDTH = log2(C_S_AXIS_DATA_WIDTH / 8);
   localparam IN_FIFO_DEPTH_BIT = log2(MAX_PKT_SIZE/(C_S_AXIS_DATA_WIDTH / 8));   
   localparam M_S_RATIO_COUNT = C_M_AXIS_DATA_WIDTH / C_S_AXIS_DATA_WIDTH;
   localparam S_M_RATIO_COUNT = C_S_AXIS_DATA_WIDTH / C_M_AXIS_DATA_WIDTH;
   
   localparam C_INCLUDE_LEN = 1; // include LEN

   wire in_fifo_nearly_full;
   reg  in_fifo_rd_en;
   wire in_fifo_empty;
   wire [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata_fifo;
   wire [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb_fifo;
   wire s_axis_tlast_fifo;
   
   reg  length_fifo_wr_en;
   reg  length_fifo_rd_en;
   wire length_fifo_empty;
   wire length_fifo_nearly_full;
   reg  [C_LEN_DATA_WIDTH - 1:0] length_in;
   reg  [C_LEN_DATA_WIDTH - 1:0] length_prev, length_prev_next;
   reg  [LENGTH_COUNTER_WIDTH:0] local_sum;
   
   reg  [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_prev, m_axis_tdata_prev_next;
   reg  [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_prev, m_axis_tstrb_prev_next;
   
   reg  [7:0] counter, counter_next;
   reg  first_time, first_time_next;
   
   wire [C_LEN_DATA_WIDTH - 1:0] tuser_len;
   wire [C_SPT_DATA_WIDTH - 1:0] tuser_spt = C_SRC_PORT;
   wire [C_DPT_DATA_WIDTH - 1:0] tuser_dpt = C_DST_PORT;
   
   assign m_axis_tuser = {96'b0, tuser_dpt, tuser_spt, tuser_len}; // According to NetFPGA-10G metadata format.
   
   integer i, j, k;
    
    fallthrough_small_fifo #
    (.WIDTH(C_S_AXIS_DATA_WIDTH+C_S_AXIS_DATA_WIDTH / 8+1), 
     .MAX_DEPTH_BITS(IN_FIFO_DEPTH_BIT)
    )
      input_fifo
        (.din           ({s_axis_tlast, s_axis_tstrb, s_axis_tdata}),  // Data in
         .wr_en         (s_axis_tvalid & ~in_fifo_nearly_full),             // Write enable
         .rd_en         (in_fifo_rd_en),    // Read the next word
         .dout          ({s_axis_tlast_fifo, s_axis_tstrb_fifo, s_axis_tdata_fifo}),
         .full          (),
         .nearly_full   (in_fifo_nearly_full),
         .prog_full     (),
         .empty         (in_fifo_empty),
         .reset         (~axi_resetn),
         .clk           (axi_aclk)
         );

    generate
    if(C_INCLUDE_LEN) begin: ENABLE_LEN    
    fallthrough_small_fifo #
    (.WIDTH(C_LEN_DATA_WIDTH), 
     .MAX_DEPTH_BITS(5))
      length_fifo
        (.din           (length_in),  // Data in
         .wr_en         (length_fifo_wr_en),             // Write enable
         .rd_en         (length_fifo_rd_en),    // Read the next word
         .dout          (tuser_len),
         .full          (),
         .nearly_full   (length_fifo_nearly_full),
         .prog_full     (),
         .empty         (length_fifo_empty),
         .reset         (~axi_resetn),
         .clk           (axi_aclk)
         );
         
    assign s_axis_tready = ~in_fifo_nearly_full & ~length_fifo_nearly_full;

	always @(*) begin
	local_sum = 0;
	for ( i=0; i< C_S_AXIS_DATA_WIDTH / 8; i=i+1 ) begin
		if ( s_axis_tstrb[i] ) begin
			local_sum = i+1;
		end
	end
    end
    
    always @(*) begin	    
        length_fifo_wr_en = 1'b0;
        length_prev_next = length_prev;
        length_in = length_prev + local_sum;
        if(s_axis_tvalid & s_axis_tready) begin
        	length_prev_next = length_prev + local_sum;
        	if(s_axis_tlast) begin
        	   length_fifo_wr_en = 1'b1; 
        	   length_prev_next = 0;
        	end
        end
    end
    
    end
    else begin: DISABLE_LEN
        assign s_axis_tready = ~in_fifo_nearly_full;
        assign length_fifo_empty = 1'b0;
    end
    endgenerate
    
    // Generate metadata at the first beat of data
    assign tuser_spt  = C_SRC_PORT;
    assign tuser_dpt  = C_DST_PORT;
    
    generate
    if(C_M_AXIS_DATA_WIDTH >= C_S_AXIS_DATA_WIDTH) begin: MASTER_WIDER    
    always @(*) begin
        in_fifo_rd_en = 1'b0;
        length_fifo_rd_en = 1'b0;
        
        m_axis_tdata = m_axis_tdata_prev;
        m_axis_tstrb = m_axis_tstrb_prev;       
        m_axis_tlast = s_axis_tlast_fifo;
        
        counter_next = counter;  
        first_time_next = first_time;    
        m_axis_tvalid = 1'b0;
        
        if(~in_fifo_empty) begin
            for(j=0;j<C_S_AXIS_DATA_WIDTH;j=j+1) m_axis_tdata[C_S_AXIS_DATA_WIDTH*counter+j] = s_axis_tdata_fifo[j];
        	for(k=0;k<C_S_AXIS_DATA_WIDTH/8;k=k+1) m_axis_tstrb[C_S_AXIS_DATA_WIDTH/8*counter+k] = s_axis_tstrb_fifo[k];
        	        	
            if(counter == M_S_RATIO_COUNT - 1) begin
				if(first_time) begin
					if(~length_fifo_empty) begin
                        m_axis_tvalid = 1'b1;
                        if(m_axis_tready) begin
                            in_fifo_rd_en = 1'b1;
                            length_fifo_rd_en = 1'b1;
                        	counter_next = 0;
                        	first_time_next = 1'b0;
                        	m_axis_tdata_prev_next = {C_M_AXIS_DATA_WIDTH{1'b0}};
                            m_axis_tstrb_prev_next = {C_M_AXIS_DATA_WIDTH/8{1'b0}};
                        end
                    end
                end
                else begin
                    m_axis_tvalid = 1'b1;
                    if(m_axis_tready) begin
                    	counter_next = 0;
                    	m_axis_tdata_prev_next = {C_M_AXIS_DATA_WIDTH{1'b0}};
                        m_axis_tstrb_prev_next = {C_M_AXIS_DATA_WIDTH/8{1'b0}};
                    	in_fifo_rd_en = 1'b1;
                    	if(s_axis_tlast_fifo) begin
                    	    first_time_next = 1'b1;
                    	end
                    end
                end
            end
			else begin
			    in_fifo_rd_en = 1'b1;
			    if(s_axis_tlast_fifo) begin
			        m_axis_tvalid = 1'b1;
                    if(m_axis_tready) begin
                        in_fifo_rd_en = 1'b1;
                        counter_next = 0;
                        m_axis_tdata_prev_next = {C_M_AXIS_DATA_WIDTH{1'b0}};
                        m_axis_tstrb_prev_next = {C_M_AXIS_DATA_WIDTH/8{1'b0}};
                        first_time_next = 1'b1;
                    end
			    end
			    else begin
				    counter_next = counter + 1'b1;
				    m_axis_tdata_prev_next = m_axis_tdata;
        			m_axis_tstrb_prev_next = m_axis_tstrb;
				end
			end
		end
    end
    
    always @(posedge axi_aclk) begin
        if (~axi_resetn) begin
            counter <= 0;
            first_time <= 1'b1;
            length_prev <= 1'b0;
            m_axis_tdata_prev <= {C_M_AXIS_DATA_WIDTH{1'b0}};
            m_axis_tstrb_prev <= {C_M_AXIS_DATA_WIDTH/8{1'b0}};
        end
        else begin
            counter <= counter_next;
            first_time <= first_time_next;
            length_prev <= length_prev_next;
            m_axis_tdata_prev <= m_axis_tdata_prev_next;
            m_axis_tstrb_prev <= m_axis_tstrb_prev_next;
        end           
    end    
    end
    else begin: SLAVE_WIDER
    always @(*) begin
        in_fifo_rd_en = 1'b0;
        length_fifo_rd_en = 1'b0;
        
        m_axis_tdata = s_axis_tdata_fifo[C_M_AXIS_DATA_WIDTH * (counter) +: C_M_AXIS_DATA_WIDTH];
        m_axis_tstrb = s_axis_tstrb_fifo[C_M_AXIS_DATA_WIDTH/8 * (counter) +: C_M_AXIS_DATA_WIDTH/8];
        m_axis_tlast = 1'b0;
        
        counter_next = counter;  
        first_time_next = first_time;    
        m_axis_tvalid = 1'b0;
        
        if(~in_fifo_empty) begin
        	if(first_time) begin
				if(~length_fifo_empty) begin
                    m_axis_tvalid = 1'b1;
                    if(m_axis_tready) begin
                        length_fifo_rd_en = 1'b1;
                        first_time_next = 1'b0;
                        counter_next = counter + 1'b1;
                    end
                end
            end
            else if(counter == S_M_RATIO_COUNT - 1) begin
                m_axis_tlast = s_axis_tlast_fifo;
                m_axis_tvalid = 1'b1;
                if(m_axis_tready) begin
                    counter_next = 0;
                    in_fifo_rd_en = 1'b1;
                    if(s_axis_tlast_fifo) first_time_next = 1'b1;
                end
            end
			else begin
			    m_axis_tvalid = 1'b1;
			    counter_next = counter + 1'b1;
			    if(m_axis_tready) begin
			        if(s_axis_tlast_fifo) begin // Last SLAVE word
			            if(|s_axis_tstrb_fifo[C_M_AXIS_DATA_WIDTH/8 * (counter+1) +: C_M_AXIS_DATA_WIDTH/8]) begin
			            // Next MASTER strobe is empty == This master word is the last
			            // Clean up the current word
			                m_axis_tlast = 1'b1;
			                counter_next = 0;
			                first_time_next = 1'b1;
			                in_fifo_rd_en = 1'b1;
			            end
			        end
				end
			end
		end
    end
    
    always @(posedge axi_aclk) begin
        if (~axi_resetn) begin
            counter <= 0;
            first_time <= 1'b1;
            length_prev <= 1'b0;
        end
        else begin
            counter <= counter_next;
            first_time <= first_time_next;
            length_prev <= length_prev_next;
        end           
    end   
    end  
    endgenerate

endmodule
