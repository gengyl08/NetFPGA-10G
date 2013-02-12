/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_router_output_port_lookup.v
 *
 *  Library:
 *        std/pcores/nf10_router_output_port_lookup_v1_00_a
 *
 *  Module:
 *        nf10_router_output_port_lookup
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

`uselib lib=unisims_ver
`uselib lib=proc_common_v3_00_a

module nf10_router_output_port_lookup
#(
  parameter C_FAMILY              = "virtex5",
  parameter C_S_AXI_DATA_WIDTH    = 32,          
  parameter C_S_AXI_ADDR_WIDTH    = 32,          
  parameter C_USE_WSTRB           = 0,
  parameter C_DPHASE_TIMEOUT      = 0,
  parameter C_BAR0_BASEADDR       = 32'h76800000,
  parameter C_BAR0_HIGHADDR       = 32'h7680FFFF,
  parameter C_BAR1_BASEADDR       = 32'h74800000,
  parameter C_BAR1_HIGHADDR       = 32'h7480FFFF,
  parameter C_S_AXI_ACLK_FREQ_HZ  = 100,
  parameter C_M_AXIS_DATA_WIDTH	  = 256,
  parameter C_S_AXIS_DATA_WIDTH	  = 256,
  parameter C_M_AXIS_TUSER_WIDTH  = 128,
  parameter C_S_AXIS_TUSER_WIDTH  = 128
)
(
  // Slave AXI Ports
  input                                     S_AXI_ACLK,
  input                                     S_AXI_ARESETN,
  input      [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_AWADDR,
  input                                     S_AXI_AWVALID,
  input      [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_WDATA,
  input      [C_S_AXI_DATA_WIDTH/8-1 : 0]   S_AXI_WSTRB,
  input                                     S_AXI_WVALID,
  input                                     S_AXI_BREADY,
  input      [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_ARADDR,
  input                                     S_AXI_ARVALID,
  input                                     S_AXI_RREADY,
  output                                    S_AXI_ARREADY,
  output     [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_RDATA,
  output     [1 : 0]                        S_AXI_RRESP,
  output                                    S_AXI_RVALID,
  output                                    S_AXI_WREADY,
  output     [1 :0]                         S_AXI_BRESP,
  output                                    S_AXI_BVALID,
  output                                    S_AXI_AWREADY,
  
  // Master Stream Ports (interface to data path)
  output     [C_M_AXIS_DATA_WIDTH - 1:0]    M_AXIS_TDATA,
  output     [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] M_AXIS_TSTRB,
  output     [C_M_AXIS_TUSER_WIDTH-1:0]     M_AXIS_TUSER,
  output                                    M_AXIS_TVALID,
  input                                     M_AXIS_TREADY,
  output                                    M_AXIS_TLAST,

  // Slave Stream Ports (interface to RX queues)
  input      [C_S_AXIS_DATA_WIDTH - 1:0]    S_AXIS_TDATA,
  input      [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] S_AXIS_TSTRB,
  input      [C_S_AXIS_TUSER_WIDTH-1:0]     S_AXIS_TUSER,
  input                                     S_AXIS_TVALID,
  output                                    S_AXIS_TREADY,
  input                                     S_AXIS_TLAST
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
 
  // -- Internal Parameters  
  localparam NUM_RW_REGS       = 9;
  localparam NUM_RO_REGS       = 10;

  localparam NUM_QUEUES        = 8;
  localparam NUM_QUEUES_WIDTH  = log2(NUM_QUEUES);
  localparam LPM_LUT_ROWS      = 16;
  localparam LPM_LUT_ROWS_BITS = log2(LPM_LUT_ROWS);
  localparam LPM_LUT_COLS      = 4;
  localparam ARP_LUT_ROWS      = 16;
  localparam ARP_LUT_ROWS_BITS = log2(ARP_LUT_ROWS);
  localparam ARP_LUT_COLS      = 3;
  localparam FILTER_ROWS       = 16;
  localparam FILTER_ROWS_BITS  = log2(FILTER_ROWS);
  localparam FILTER_COLS       = 1;
  
  localparam TBL_COUNT         = 3 /* LPM, ARP and FILTER */;
  localparam MAX_TBL_ROWS      = ((LPM_LUT_COLS >= ARP_LUT_COLS && LPM_LUT_COLS >= FILTER_COLS) ? LPM_LUT_COLS : 
                                  (ARP_LUT_COLS >= FILTER_COLS)                                 ? ARP_LUT_COLS : FILTER_COLS);
  
  // -- Signals

  wire                                            Bus2IP_Clk;
  wire                                            Bus2IP_Resetn;
  wire     [C_S_AXI_ADDR_WIDTH-1 : 0]             Bus2IP_Addr;
  wire     [1 : 0]                                Bus2IP_CS;
  wire                                            Bus2IP_RNW;
  wire     [C_S_AXI_DATA_WIDTH-1 : 0]             Bus2IP_Data;
  wire     [C_S_AXI_DATA_WIDTH/8-1 : 0]           Bus2IP_BE;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             IP2Bus_Data;
  reg                                             IP2Bus_RdAck;
  reg                                             IP2Bus_WrAck;
  reg                                             IP2Bus_Error;

  wire     [C_S_AXI_DATA_WIDTH-1 : 0]             l_IP2Bus_Data  [0:3];
  wire     [3:0]                                  l_IP2Bus_RdAck;
  wire     [3:0]                                  l_IP2Bus_WrAck;
  wire     [3:0]                                  l_IP2Bus_Error;
  
  wire     [NUM_RW_REGS*C_S_AXI_DATA_WIDTH-1 : 0] rw_regs;
  wire     [NUM_RO_REGS*C_S_AXI_DATA_WIDTH-1 : 0] ro_regs;
  

  wire                                            rst_cntrs;
 
  wire                                            pkt_sent_from_cpu;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_from_cpu_cntr;
  wire                                            pkt_sent_to_cpu_options_ver;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_to_cpu_options_ver_cntr;
  wire                                            pkt_sent_to_cpu_bad_ttl;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_to_cpu_bad_ttl_cntr;
  wire                                            pkt_sent_to_cpu_dest_ip_hit;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_to_cpu_dest_ip_hit_cntr;
  wire                                            pkt_forwarded;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_forwarded_cntr;
  wire                                            pkt_dropped_checksum;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_dropped_checksum_cntr;
  wire                                            pkt_sent_to_cpu_non_ip;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_to_cpu_non_ip_cntr;
  wire                                            pkt_sent_to_cpu_arp_miss;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_to_cpu_arp_miss_cntr;
  wire                                            pkt_sent_to_cpu_lpm_miss;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_sent_to_cpu_lpm_miss_cntr;
  wire                                            pkt_dropped_wrong_dst_mac;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]             pkt_dropped_wrong_dst_mac_cntr;

  wire [LPM_LUT_ROWS_BITS-1:0]                   lpm_rd_addr;
  wire                                            lpm_rd_req;
  wire [31:0]                                     lpm_rd_ip;
  wire [31:0]                                     lpm_rd_mask;
  wire [NUM_QUEUES-1:0]                           lpm_rd_oq;
  wire [31:0]                                     lpm_rd_next_hop_ip;
  wire                                            lpm_rd_ack;
  wire [LPM_LUT_ROWS_BITS-1:0]                   lpm_wr_addr;
  wire                                            lpm_wr_req;
  wire [NUM_QUEUES-1:0]                           lpm_wr_oq;
  wire [31:0]                                     lpm_wr_next_hop_ip;
  wire [31:0]                                     lpm_wr_ip;
  wire [31:0]                                     lpm_wr_mask;
  wire                                            lpm_wr_ack;

  wire [ARP_LUT_ROWS_BITS-1:0]                   arp_rd_addr;
  wire                                            arp_rd_req;
  wire  [47:0]                                    arp_rd_mac;
  wire  [31:0]                                    arp_rd_ip;
  wire                                            arp_rd_ack;
  wire [ARP_LUT_ROWS_BITS-1:0]                   arp_wr_addr;
  wire                                            arp_wr_req;
  wire [47:0]                                     arp_wr_mac;
  wire [31:0]                                     arp_wr_ip;
  wire                                            arp_wr_ack;

  wire [FILTER_ROWS_BITS-1:0]                    dest_ip_filter_rd_addr;
  wire                                            dest_ip_filter_rd_req;
  wire [31:0]                                     dest_ip_filter_rd_ip;
  wire                                            dest_ip_filter_rd_ack;
  wire [FILTER_ROWS_BITS-1:0]                    dest_ip_filter_wr_addr;
  wire                                            dest_ip_filter_wr_req;
  wire [31:0]                                     dest_ip_filter_wr_ip;
  wire                                            dest_ip_filter_wr_ack;

  wire [47:0]                                     mac_0;
  wire [47:0]                                     mac_1;
  wire [47:0]                                     mac_2;
  wire [47:0]                                     mac_3;

  // -- AXILITE IPIF
  axi_lite_ipif_2bars #
  (
    .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),
    .C_USE_WSTRB        (C_USE_WSTRB),
    .C_DPHASE_TIMEOUT   (C_DPHASE_TIMEOUT),
    .C_BAR0_BASEADDR    (C_BAR0_BASEADDR),
    .C_BAR0_HIGHADDR    (C_BAR0_HIGHADDR),
    .C_BAR1_BASEADDR    (C_BAR1_BASEADDR),
    .C_BAR1_HIGHADDR    (C_BAR1_HIGHADDR)
  ) axi_lite_ipif_inst
  (
    .S_AXI_ACLK          ( S_AXI_ACLK     ),
    .S_AXI_ARESETN       ( S_AXI_ARESETN  ),
    .S_AXI_AWADDR        ( S_AXI_AWADDR   ),
    .S_AXI_AWVALID       ( S_AXI_AWVALID  ),
    .S_AXI_WDATA         ( S_AXI_WDATA    ),
    .S_AXI_WSTRB         ( S_AXI_WSTRB    ),
    .S_AXI_WVALID        ( S_AXI_WVALID   ),
    .S_AXI_BREADY        ( S_AXI_BREADY   ),
    .S_AXI_ARADDR        ( S_AXI_ARADDR   ),
    .S_AXI_ARVALID       ( S_AXI_ARVALID  ),
    .S_AXI_RREADY        ( S_AXI_RREADY   ),
    .S_AXI_ARREADY       ( S_AXI_ARREADY  ),
    .S_AXI_RDATA         ( S_AXI_RDATA    ),
    .S_AXI_RRESP         ( S_AXI_RRESP    ),
    .S_AXI_RVALID        ( S_AXI_RVALID   ),
    .S_AXI_WREADY        ( S_AXI_WREADY   ),
    .S_AXI_BRESP         ( S_AXI_BRESP    ),
    .S_AXI_BVALID        ( S_AXI_BVALID   ),
    .S_AXI_AWREADY       ( S_AXI_AWREADY  ),
	
    // Controls to the IP/IPIF modules
    .Bus2IP_Clk          ( Bus2IP_Clk     ),
    .Bus2IP_Resetn       ( Bus2IP_Resetn  ),
    .Bus2IP_Addr         ( Bus2IP_Addr    ),
    .Bus2IP_RNW          ( Bus2IP_RNW     ),
    .Bus2IP_BE           ( Bus2IP_BE      ),
    .Bus2IP_CS           ( Bus2IP_CS      ),
    .Bus2IP_Data         ( Bus2IP_Data    ),
    .IP2Bus_Data         ( IP2Bus_Data    ),
    .IP2Bus_WrAck        ( IP2Bus_WrAck   ),
    .IP2Bus_RdAck        ( IP2Bus_RdAck   ),
    .IP2Bus_Error        ( IP2Bus_Error   )
  );

  always @ (posedge Bus2IP_Clk) begin
    case (l_IP2Bus_RdAck)
       4'b0001: IP2Bus_Data <= l_IP2Bus_Data[0]; 
       4'b0010: IP2Bus_Data <= l_IP2Bus_Data[1];
       4'b0100: IP2Bus_Data <= l_IP2Bus_Data[2];
       4'b1000: IP2Bus_Data <= l_IP2Bus_Data[3];
       default: IP2Bus_Data <= {C_S_AXI_DATA_WIDTH{1'b0}};
     endcase
	
     IP2Bus_WrAck <= |l_IP2Bus_WrAck;
     IP2Bus_RdAck <= |l_IP2Bus_RdAck;
     IP2Bus_Error <= |l_IP2Bus_Error;
  end
  
  // -- IPIF REGS
  ipif_regs #
  (
    .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),          
    .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),   
    .NUM_RW_REGS        (NUM_RW_REGS),
    .NUM_RO_REGS        (NUM_RO_REGS)
  ) ipif_regs_inst
  (   
    .Bus2IP_Clk     ( Bus2IP_Clk        ),
    .Bus2IP_Resetn  ( Bus2IP_Resetn     ), 
    .Bus2IP_Addr    ( Bus2IP_Addr       ),
    .Bus2IP_CS      ( Bus2IP_CS[1]      ), // CS[1] = BAR0
    .Bus2IP_RNW     ( Bus2IP_RNW        ),
    .Bus2IP_Data    ( Bus2IP_Data       ),
    .Bus2IP_BE      ( Bus2IP_BE         ),
    .IP2Bus_Data    ( l_IP2Bus_Data[0]  ),
    .IP2Bus_RdAck   ( l_IP2Bus_RdAck[0] ),
    .IP2Bus_WrAck   ( l_IP2Bus_WrAck[0] ),
    .IP2Bus_Error   ( l_IP2Bus_Error[0] ),
	
    .rw_regs        ( rw_regs ),
    .ro_regs        ( ro_regs )
  );
  
  // -- Register assignments
  
  assign rst_cntrs = rw_regs[C_S_AXI_DATA_WIDTH*0];
  assign mac_0     = rw_regs[47+C_S_AXI_DATA_WIDTH*1:C_S_AXI_DATA_WIDTH*1];
  assign mac_1     = rw_regs[47+C_S_AXI_DATA_WIDTH*3:C_S_AXI_DATA_WIDTH*3]; 
  assign mac_2     = rw_regs[47+C_S_AXI_DATA_WIDTH*5:C_S_AXI_DATA_WIDTH*5];
  assign mac_3     = rw_regs[47+C_S_AXI_DATA_WIDTH*7:C_S_AXI_DATA_WIDTH*7];

  assign ro_regs = {pkt_sent_from_cpu_cntr, 
                    pkt_sent_to_cpu_options_ver_cntr, 
                    pkt_sent_to_cpu_bad_ttl_cntr,
                    pkt_sent_to_cpu_dest_ip_hit_cntr,
                    pkt_forwarded_cntr,
                    pkt_dropped_checksum_cntr,
                    pkt_sent_to_cpu_non_ip_cntr,
                    pkt_sent_to_cpu_arp_miss_cntr,
                    pkt_sent_to_cpu_lpm_miss_cntr,
                    pkt_dropped_wrong_dst_mac_cntr};

  // IPIF IP_LPM TABLE REGS
  ipif_table_regs 
  #(
     .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),         
     .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),  
     .TBL_NUM_COLS       (LPM_LUT_COLS),
     .TBL_NUM_ROWS       (LPM_LUT_ROWS)
  ) ipif_ip_lpm_table_regs_inst
  (   
   .Bus2IP_Clk     ( Bus2IP_Clk        ),
   .Bus2IP_Resetn  ( Bus2IP_Resetn     ), 
   .Bus2IP_Addr    ( Bus2IP_Addr       ),                           
   .Bus2IP_CS      ( Bus2IP_CS[0] & (Bus2IP_Addr[log2(TBL_COUNT)+log2(2+MAX_TBL_ROWS)+2-1:log2(2+MAX_TBL_ROWS)+2] == 0)), // CS[0] = BAR1
   .Bus2IP_RNW     ( Bus2IP_RNW        ),
   .Bus2IP_Data    ( Bus2IP_Data       ),
   .Bus2IP_BE      ( Bus2IP_BE         ),
   .IP2Bus_Data    ( l_IP2Bus_Data[1]  ),
   .IP2Bus_RdAck   ( l_IP2Bus_RdAck[1] ),
   .IP2Bus_WrAck   ( l_IP2Bus_WrAck[1] ),
   .IP2Bus_Error   ( l_IP2Bus_Error[1] ),
   
   .tbl_rd_req     ( lpm_rd_req ),    
   .tbl_rd_ack     ( lpm_rd_ack ),    
   .tbl_rd_addr    ( lpm_rd_addr ),   
   .tbl_rd_data    ( {lpm_rd_oq,
                      lpm_rd_next_hop_ip,
                      lpm_rd_mask,
                      lpm_rd_ip} ),   
   .tbl_wr_req     ( lpm_wr_req ),    
   .tbl_wr_ack     ( lpm_wr_ack ),    
   .tbl_wr_addr    ( lpm_wr_addr ),   
   .tbl_wr_data    ( {lpm_wr_oq, 
                      lpm_wr_next_hop_ip,
                      lpm_wr_mask,
                      lpm_wr_ip} )  
  );

  // IPIF IP_ARP TABLE REGS
  ipif_table_regs 
  #(
     .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),         
     .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),  
     .TBL_NUM_COLS       (ARP_LUT_COLS),
     .TBL_NUM_ROWS       (ARP_LUT_ROWS)
  ) ipif_ip_arp_table_regs_inst
  (   
   .Bus2IP_Clk     ( Bus2IP_Clk        ),
   .Bus2IP_Resetn  ( Bus2IP_Resetn     ), 
   .Bus2IP_Addr    ( Bus2IP_Addr       ),
   .Bus2IP_CS      ( Bus2IP_CS[0] & (Bus2IP_Addr[log2(TBL_COUNT)+log2(2+MAX_TBL_ROWS)+2-1:log2(2+MAX_TBL_ROWS)+2] == 1)), // CS[0] = BAR1
   .Bus2IP_RNW     ( Bus2IP_RNW        ),
   .Bus2IP_Data    ( Bus2IP_Data       ),
   .Bus2IP_BE      ( Bus2IP_BE         ),
   .IP2Bus_Data    ( l_IP2Bus_Data[2]  ),
   .IP2Bus_RdAck   ( l_IP2Bus_RdAck[2] ),
   .IP2Bus_WrAck   ( l_IP2Bus_WrAck[2] ),
   .IP2Bus_Error   ( l_IP2Bus_Error[2] ),
   
   .tbl_rd_req     ( arp_rd_req ),    
   .tbl_rd_ack     ( arp_rd_ack ),    
   .tbl_rd_addr    ( arp_rd_addr ),   
   .tbl_rd_data    ( {arp_rd_mac,
                      arp_rd_ip} ),   
   .tbl_wr_req     ( arp_wr_req ),    
   .tbl_wr_ack     ( arp_wr_ack ),    
   .tbl_wr_addr    ( arp_wr_addr ),   
   .tbl_wr_data    ( {arp_wr_mac,
                      arp_wr_ip} )  
  );


  // IPIF DEST_IP_FILTER TABLE REGS
  ipif_table_regs 
  #(
     .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),         
     .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),  
     .TBL_NUM_COLS       (FILTER_COLS),
     .TBL_NUM_ROWS       (FILTER_ROWS)
  ) ipif_dest_ip_filter_table_regs_inst
  (   
   .Bus2IP_Clk     ( Bus2IP_Clk        ),
   .Bus2IP_Resetn  ( Bus2IP_Resetn     ), 
   .Bus2IP_Addr    ( Bus2IP_Addr       ),
   .Bus2IP_CS      ( Bus2IP_CS[0] & (Bus2IP_Addr[log2(TBL_COUNT)+log2(2+MAX_TBL_ROWS)+2-1:log2(2+MAX_TBL_ROWS)+2] == 2)), // CS[0] = BAR1
   .Bus2IP_RNW     ( Bus2IP_RNW        ),
   .Bus2IP_Data    ( Bus2IP_Data       ),
   .Bus2IP_BE      ( Bus2IP_BE         ),
   .IP2Bus_Data    ( l_IP2Bus_Data[3]  ),
   .IP2Bus_RdAck   ( l_IP2Bus_RdAck[3] ),
   .IP2Bus_WrAck   ( l_IP2Bus_WrAck[3] ),
   .IP2Bus_Error   ( l_IP2Bus_Error[3] ),
   
   .tbl_rd_req     ( dest_ip_filter_rd_req ),    
   .tbl_rd_ack     ( dest_ip_filter_rd_ack ),    
   .tbl_rd_addr    ( dest_ip_filter_rd_addr ),   
   .tbl_rd_data    ( dest_ip_filter_rd_ip ),   
   .tbl_wr_req     ( dest_ip_filter_wr_req ),    
   .tbl_wr_ack     ( dest_ip_filter_wr_ack ),    
   .tbl_wr_addr    ( dest_ip_filter_wr_addr ),   
   .tbl_wr_data    ( dest_ip_filter_wr_ip )  
  );
  
  // -- Router
  output_port_lookup #
  (
    .C_M_AXIS_DATA_WIDTH  (C_M_AXIS_DATA_WIDTH),
    .C_S_AXIS_DATA_WIDTH  (C_S_AXIS_DATA_WIDTH),
    .C_M_AXIS_TUSER_WIDTH (C_M_AXIS_TUSER_WIDTH),
    .C_S_AXIS_TUSER_WIDTH (C_S_AXIS_TUSER_WIDTH),
    .NUM_QUEUES           (NUM_QUEUES),
    .LPM_LUT_DEPTH        (LPM_LUT_ROWS),
    .ARP_LUT_DEPTH        (ARP_LUT_ROWS),
    .FILTER_DEPTH         (FILTER_ROWS)
   ) output_port_lookup
  (
    // Global Ports
    .axi_aclk      (S_AXI_ACLK),
    .axi_resetn    (S_AXI_ARESETN),

    // Master Stream Ports (interface to data path)
    .m_axis_tdata  (M_AXIS_TDATA),
    .m_axis_tstrb  (M_AXIS_TSTRB),
    .m_axis_tuser  (M_AXIS_TUSER),
    .m_axis_tvalid (M_AXIS_TVALID), 
    .m_axis_tready (M_AXIS_TREADY),
    .m_axis_tlast  (M_AXIS_TLAST),

    // Slave Stream Ports (interface to RX queues)
    .s_axis_tdata  (S_AXIS_TDATA),
    .s_axis_tstrb  (S_AXIS_TSTRB),
    .s_axis_tuser  (S_AXIS_TUSER),
    .s_axis_tvalid (S_AXIS_TVALID),
    .s_axis_tready (S_AXIS_TREADY),
    .s_axis_tlast  (S_AXIS_TLAST),

    // --- interface to op_lut_process_sm
    .pkt_sent_from_cpu            (pkt_sent_from_cpu),
    .pkt_sent_to_cpu_options_ver  (pkt_sent_to_cpu_options_ver), 
    .pkt_sent_to_cpu_bad_ttl      (pkt_sent_to_cpu_bad_ttl),     
    .pkt_sent_to_cpu_dest_ip_hit  (pkt_sent_to_cpu_dest_ip_hit), 
    .pkt_forwarded                (pkt_forwarded),          
    .pkt_dropped_checksum         (pkt_dropped_checksum),        
    .pkt_sent_to_cpu_non_ip       (pkt_sent_to_cpu_non_ip),      
    .pkt_sent_to_cpu_arp_miss     (pkt_sent_to_cpu_arp_miss),    
    .pkt_sent_to_cpu_lpm_miss     (pkt_sent_to_cpu_lpm_miss),    
    .pkt_dropped_wrong_dst_mac    (pkt_dropped_wrong_dst_mac),

    // --- interface to ip_lpm
    .lpm_rd_addr                  (lpm_rd_addr),          
    .lpm_rd_req                   (lpm_rd_req),           
    .lpm_rd_ip                    (lpm_rd_ip),            
    .lpm_rd_mask                  (lpm_rd_mask),          
    .lpm_rd_oq                    (lpm_rd_oq),            
    .lpm_rd_next_hop_ip           (lpm_rd_next_hop_ip),   
    .lpm_rd_ack                   (lpm_rd_ack),           
    .lpm_wr_addr                  (lpm_wr_addr),
    .lpm_wr_req                   (lpm_wr_req),
    .lpm_wr_oq                    (lpm_wr_oq),
    .lpm_wr_next_hop_ip           (lpm_wr_next_hop_ip),   
    .lpm_wr_ip                    (lpm_wr_ip),            
    .lpm_wr_mask                  (lpm_wr_mask),
    .lpm_wr_ack                   (lpm_wr_ack),

    // --- ip_arp
    .arp_rd_addr                  (arp_rd_addr),        
    .arp_rd_req                   (arp_rd_req),         
    .arp_rd_mac                   (arp_rd_mac),         
    .arp_rd_ip                    (arp_rd_ip),          
    .arp_rd_ack                   (arp_rd_ack),         
    .arp_wr_addr                  (arp_wr_addr),
    .arp_wr_req                   (arp_wr_req),
    .arp_wr_mac                   (arp_wr_mac),
    .arp_wr_ip                    (arp_wr_ip),          
    .arp_wr_ack                   (arp_wr_ack),

    // --- interface to dest_ip_filter
    .dest_ip_filter_rd_addr       (dest_ip_filter_rd_addr),  
    .dest_ip_filter_rd_req        (dest_ip_filter_rd_req),   
    .dest_ip_filter_rd_ip         (dest_ip_filter_rd_ip),    
    .dest_ip_filter_rd_ack        (dest_ip_filter_rd_ack),   
    .dest_ip_filter_wr_addr       (dest_ip_filter_wr_addr),
    .dest_ip_filter_wr_req        (dest_ip_filter_wr_req),
    .dest_ip_filter_wr_ip         (dest_ip_filter_wr_ip),    
    .dest_ip_filter_wr_ack        (dest_ip_filter_wr_ack),

    // --- eth_parser
    .mac_0                        (mac_0),
    .mac_1                        (mac_1),
    .mac_2                        (mac_2),
    .mac_3                        (mac_3) 
  );
  
  // Counters
  always @ (posedge S_AXI_ACLK) begin
    if (~S_AXI_ARESETN) begin
	  pkt_sent_from_cpu_cntr  <= {C_S_AXI_DATA_WIDTH{1'b0}};
	  pkt_sent_to_cpu_options_ver_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_bad_ttl_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_dest_ip_hit_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_forwarded_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_dropped_checksum_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_non_ip_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_arp_miss_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_lpm_miss_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_dropped_wrong_dst_mac_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
     end
     else if (rst_cntrs) begin
	  pkt_sent_from_cpu_cntr  <= {C_S_AXI_DATA_WIDTH{1'b0}};
	  pkt_sent_to_cpu_options_ver_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_bad_ttl_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_dest_ip_hit_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_forwarded_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_dropped_checksum_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_non_ip_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_arp_miss_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_sent_to_cpu_lpm_miss_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
          pkt_dropped_wrong_dst_mac_cntr <= {C_S_AXI_DATA_WIDTH{1'b0}};
      end
      else begin
	  if (pkt_sent_from_cpu)           pkt_sent_from_cpu_cntr  <= pkt_sent_from_cpu_cntr + 1;
	  if (pkt_sent_to_cpu_options_ver) pkt_sent_to_cpu_options_ver_cntr <= pkt_sent_to_cpu_options_ver_cntr + 1;
	  if (pkt_sent_to_cpu_bad_ttl)     pkt_sent_to_cpu_bad_ttl_cntr  <= pkt_sent_to_cpu_bad_ttl_cntr + 1;
	  if (pkt_sent_to_cpu_dest_ip_hit) pkt_sent_to_cpu_dest_ip_hit_cntr  <= pkt_sent_to_cpu_dest_ip_hit_cntr + 1;
	  if (pkt_forwarded)               pkt_forwarded_cntr  <= pkt_forwarded_cntr + 1;
	  if (pkt_dropped_checksum)        pkt_dropped_checksum_cntr  <= pkt_dropped_checksum_cntr + 1;
	  if (pkt_sent_to_cpu_non_ip)      pkt_sent_to_cpu_non_ip_cntr  <= pkt_sent_to_cpu_non_ip_cntr + 1;
	  if (pkt_sent_to_cpu_arp_miss)    pkt_sent_to_cpu_arp_miss_cntr  <= pkt_sent_to_cpu_arp_miss_cntr + 1;
	  if (pkt_sent_to_cpu_lpm_miss)    pkt_sent_to_cpu_lpm_miss_cntr  <= pkt_sent_to_cpu_lpm_miss_cntr + 1;
	  if (pkt_dropped_wrong_dst_mac)   pkt_dropped_wrong_dst_mac_cntr  <= pkt_dropped_wrong_dst_mac_cntr + 1;
      end
  end

endmodule
