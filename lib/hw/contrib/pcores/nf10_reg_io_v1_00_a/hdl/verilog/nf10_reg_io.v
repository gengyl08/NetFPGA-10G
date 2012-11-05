/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_reg_io.v
 *
 *  Library:
 *        contrib/pcores/nf10_reg_io_v1_00_a
 *
 *  Module:
 *        nf10_reg_io
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

module nf10_reg_io
#(
  parameter C_S_AXI_DATA_WIDTH = 32,          
  parameter C_S_AXI_ADDR_WIDTH = 32,          
  parameter C_USE_WSTRB        = 0,
  parameter C_DPHASE_TIMEOUT   = 0,
  parameter C_BAR0_BASEADDR    = 32'hFFFFFFFF,
  parameter C_BAR0_HIGHADDR    = 32'h00000000,
  parameter C_BAR1_BASEADDR    = 32'hFFFFFFFF,
  parameter C_BAR1_HIGHADDR    = 32'h00000000
)
(
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
  output                                    S_AXI_AWREADY        
);

  wire                                      Bus2IP_Clk;
  wire                                      Bus2IP_Resetn;
  wire     [C_S_AXI_ADDR_WIDTH-1 : 0]       Bus2IP_Addr;
  wire     [1 : 0]                          Bus2IP_CS;
  wire                                      Bus2IP_RNW;
  wire     [C_S_AXI_DATA_WIDTH-1 : 0]       Bus2IP_Data;
  wire     [C_S_AXI_DATA_WIDTH/8-1 : 0]     Bus2IP_BE;
  reg      [C_S_AXI_DATA_WIDTH-1 : 0]       IP2Bus_Data;
  reg                                       IP2Bus_RdAck;
  reg                                       IP2Bus_WrAck;
  reg                                       IP2Bus_Error;
  
  wire     [C_S_AXI_DATA_WIDTH-1 : 0]       l_IP2Bus_Data  [0:1];
  wire     [1:0]                            l_IP2Bus_RdAck;
  wire     [1:0]                            l_IP2Bus_WrAck;
  wire     [1:0]                            l_IP2Bus_Error;
  
  wire    [2*C_S_AXI_DATA_WIDTH-1 : 0]      rw_regs;
  wire    [2*C_S_AXI_DATA_WIDTH-1 : 0]      wo_regs;
  wire    [4*C_S_AXI_DATA_WIDTH-1 : 0]      ro_regs;
  
  reg     [4*C_S_AXI_DATA_WIDTH-1 : 0]      tbl [0:3]; 
  reg     [1:0]                             tbl_sel_addr;
  wire                                      tbl_rd_req;
  wire                                      tbl_rd_ack;
  wire    [1 : 0]                           tbl_rd_addr;
  wire    [4*C_S_AXI_DATA_WIDTH-1 : 0]      tbl_rd_data;
  wire                                      tbl_wr_req;
  wire                                      tbl_wr_ack;
  wire    [1 : 0]                           tbl_wr_addr;
  wire    [4*C_S_AXI_DATA_WIDTH-1 : 0]      tbl_wr_data;
  
  integer                                   j;
 
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
	        2'b01: IP2Bus_Data <= l_IP2Bus_Data[0]; 
	        2'b10: IP2Bus_Data <= l_IP2Bus_Data[1];
	  default: IP2Bus_Data <= {C_S_AXI_DATA_WIDTH{1'b0}};
	endcase
	
	IP2Bus_WrAck <= |l_IP2Bus_WrAck;
	IP2Bus_RdAck <= |l_IP2Bus_RdAck;
	IP2Bus_Error <= |l_IP2Bus_Error;
  end
  
  // IPIF REGS --------------------- EXAMPLE
  ipif_regs #
  (
    .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),          
    .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),   
    .NUM_RW_REGS        (2),
    .NUM_WO_REGS        (2),
    .NUM_RO_REGS        (4)
  ) ipif_regs_inst
  (   
    .Bus2IP_Clk     ( Bus2IP_Clk        ),
    .Bus2IP_Resetn  ( Bus2IP_Resetn     ), 
    .Bus2IP_Addr    ( Bus2IP_Addr       ),
    .Bus2IP_CS      ( Bus2IP_CS[1]      ), // CS[1] = BAR0
    .Bus2IP_RNW     ( Bus2IP_RNW        ),
    .Bus2IP_Data    ( Bus2IP_Data       ),
    .Bus2IP_BE      ( Bus2IP_BE         ),
    .IP2Bus_Data    ( l_IP2Bus_Data[1]  ),
    .IP2Bus_RdAck   ( l_IP2Bus_RdAck[1] ),
    .IP2Bus_WrAck   ( l_IP2Bus_WrAck[1] ),
    .IP2Bus_Error   ( l_IP2Bus_Error[1] ),
   
    .rw_regs        ( rw_regs ),
    .wo_regs        ( wo_regs ),
    .ro_regs        ( ro_regs )
  );

  assign ro_regs = {wo_regs, rw_regs};
  
  // IPIF TABLE REGS --------------------- EXAMPLE
  ipif_table_regs 
  #(
     .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),         
     .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),  
     .TBL_NUM_COLS       (4),
     .TBL_NUM_ROWS       (4)
  ) ipif_table_regs_inst
  (   
   .Bus2IP_Clk     ( Bus2IP_Clk        ),
   .Bus2IP_Resetn  ( Bus2IP_Resetn     ), 
   .Bus2IP_Addr    ( Bus2IP_Addr       ),
   .Bus2IP_CS      ( Bus2IP_CS[0]      ), // CS[0] = BAR1
   .Bus2IP_RNW     ( Bus2IP_RNW        ),
   .Bus2IP_Data    ( Bus2IP_Data       ),
   .Bus2IP_BE      ( Bus2IP_BE         ),
   .IP2Bus_Data    ( l_IP2Bus_Data[0]  ),
   .IP2Bus_RdAck   ( l_IP2Bus_RdAck[0] ),
   .IP2Bus_WrAck   ( l_IP2Bus_WrAck[0] ),
   .IP2Bus_Error   ( l_IP2Bus_Error[0] ),
   
   .tbl_rd_req     ( tbl_rd_req ),    
   .tbl_rd_ack     ( tbl_rd_ack ),    
   .tbl_rd_addr    ( tbl_rd_addr ),   
   .tbl_rd_data    ( tbl_rd_data ),   
   .tbl_wr_req     ( tbl_wr_req ),    
   .tbl_wr_ack     ( tbl_wr_ack ),    
   .tbl_wr_addr    ( tbl_wr_addr ),   
   .tbl_wr_data    ( tbl_wr_data )  
  );
  
  // Emulating table
  always @ (posedge Bus2IP_Clk) begin
    if (~Bus2IP_Resetn) begin
	  for (j=0; j<4; j=j+1) 
	     tbl[j] <= {(4*C_S_AXI_DATA_WIDTH){1'b0}};
	
	  tbl_sel_addr <= 2'b0;
	end
	else begin	  
	  if (tbl_wr_req) begin
	    tbl[tbl_wr_addr] <= tbl_wr_data;
	  end
	  else if (tbl_rd_req) begin
	    tbl_sel_addr <= tbl_rd_addr;
	  end
	end
  end
  
  assign tbl_rd_data = tbl[tbl_sel_addr];
  assign tbl_wr_ack = tbl_wr_req; 
  assign tbl_rd_ack = tbl_rd_req; 
  
endmodule
