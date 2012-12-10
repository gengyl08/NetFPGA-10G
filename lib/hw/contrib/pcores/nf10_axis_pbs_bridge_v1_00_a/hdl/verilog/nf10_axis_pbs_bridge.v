/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_axis_pbs_bridge.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_axis_pbs_bridge_v1_00_a
 *
 *  Module:
 *        nf10_axis_pbs_bridge
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shahbaz
 *
 *  Description:
 *        AXIS to PBS (Packet Bus Streaming - NetFPGA 1G reference pipeline) conversion library.
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

`uselib lib=nf10_axis_converter_v1_00_a

module nf10_axis_pbs_bridge
#(
        parameter       C_S_AXIS_TDATA_WIDTH = 256,
        parameter       C_M_AXIS_TDATA_WIDTH = 256,
        parameter       C_M_AXIS_TUSER_WIDTH = 128,
        parameter       C_S_AXIS_TUSER_WIDTH = 128,
	parameter       C_S_PBS_DATA_WIDTH = 64,
	parameter	C_M_PBS_DATA_WIDTH = 64
)
(
	input                                         ACLK,
	input                                         ARESETN,

	output     [(C_M_AXIS_TDATA_WIDTH/8)-1:0]     M_AXIS_TSTRB,
	output     [C_M_AXIS_TUSER_WIDTH-1:0]         M_AXIS_TUSER,
	input      [(C_S_AXIS_TDATA_WIDTH/8)-1:0]     S_AXIS_TSTRB,
	input      [C_S_AXIS_TUSER_WIDTH-1:0]         S_AXIS_TUSER,
	
        output                                        S_AXIS_TREADY,
	input      [C_S_AXIS_TDATA_WIDTH-1:0]         S_AXIS_TDATA,
	input                                         S_AXIS_TLAST,
	input                                         S_AXIS_TVALID,

	output                                        M_AXIS_TVALID,
	output     [C_M_AXIS_TDATA_WIDTH-1:0]         M_AXIS_TDATA,
	output                                        M_AXIS_TLAST,
	input                                         M_AXIS_TREADY,

	output	   [C_M_PBS_DATA_WIDTH-1:0]           M_PBS_DATA,
	output     [C_M_PBS_DATA_WIDTH/8-1:0]         M_PBS_CTRL,
	output					      M_PBS_WR,	
	input					      M_PBS_RDY,

	input      [C_S_PBS_DATA_WIDTH-1:0]           S_PBS_DATA,
	input      [C_S_PBS_DATA_WIDTH/8-1:0]         S_PBS_CTRL,
	input                                         S_PBS_WR,
	output                                        S_PBS_RDY

);

        localparam C_M_AXIS_DATA_WIDTH_INTERNAL     = C_S_PBS_DATA_WIDTH;
        localparam C_S_AXIS_DATA_WIDTH_INTERNAL     = C_M_PBS_DATA_WIDTH;

	wire [C_M_AXIS_DATA_WIDTH_INTERNAL-1:0] 	m_axis_tdata;
	wire [((C_M_AXIS_DATA_WIDTH_INTERNAL/8))-1:0] 	m_axis_tstrb;
	wire [C_M_AXIS_TUSER_WIDTH-1:0] 		m_axis_tuser; // Dummy AXI TUSER
	wire 						m_axis_tvalid;
        wire  						m_axis_tready;
        wire 						m_axis_tlast;
	wire [C_S_AXIS_DATA_WIDTH_INTERNAL-1:0]		s_axis_tdata;
	wire [((C_S_AXIS_DATA_WIDTH_INTERNAL/8))-1:0] 	s_axis_tstrb;
	wire [C_S_AXIS_TUSER_WIDTH-1:0]			s_axis_tuser;
	wire  						s_axis_tvalid;
	wire						s_axis_tready;
	wire						s_axis_tlast;

  /* ------------------------------------------
   *  S_PBS ---> M_AXIS 
   *  ----------------------------------------- */

  pbs_axis_bridge
  #(
     .C_AXIS_DATA_WIDTH (C_M_AXIS_DATA_WIDTH_INTERNAL),
     .C_AXIS_USER_WIDTH (C_M_AXIS_TUSER_WIDTH)
   ) pbs_axis_bridge
   (
   // Global Ports
   	.clk(ACLK),
        .reset(~ARESETN),
   // PBS Ports
        .pbs_data(S_PBS_DATA),
        .pbs_ctrl(S_PBS_CTRL),
        .pbs_wr(S_PBS_WR),
        .pbs_rdy(S_PBS_RDY),
   // AXIS Ports
	.axis_tready(m_axis_tready),
        .axis_tdata(m_axis_tdata),
        .axis_tlast(m_axis_tlast),
        .axis_tvalid(m_axis_tvalid),
        .axis_tuser(m_axis_tuser),
        .axis_tstrb(m_axis_tstrb)
   );

  nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
      .C_S_AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH_INTERNAL)
     ) converter_master
    (
    // Global Ports
        .axi_aclk(ACLK),
        .axi_resetn(ARESETN),
    // Master Stream Ports
        .m_axis_tdata(M_AXIS_TDATA),
        .m_axis_tstrb(M_AXIS_TSTRB),
        .m_axis_tvalid(M_AXIS_TVALID),
        .m_axis_tready(M_AXIS_TREADY),
        .m_axis_tlast(M_AXIS_TLAST),
        .m_axis_tuser(M_AXIS_TUSER),
    // Slave Stream Ports
        .s_axis_tdata(m_axis_tdata),
        .s_axis_tstrb(m_axis_tstrb),
        .s_axis_tvalid(m_axis_tvalid),
        .s_axis_tready(m_axis_tready),
        .s_axis_tlast(m_axis_tlast),
        .s_axis_tuser(m_axis_tuser)
    );

  
  /* ------------------------------------------
   *  S_AXIS ---> M_PBS 
   *  ----------------------------------------- */

  nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH_INTERNAL),
      .C_S_AXIS_DATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
     ) converter_slave
    (
    // Global Ports
        .axi_aclk(ACLK),
        .axi_resetn(ARESETN),
    // Master Stream Ports
        .m_axis_tdata(s_axis_tdata),
        .m_axis_tstrb(s_axis_tstrb),
        .m_axis_tvalid(s_axis_tvalid),
        .m_axis_tready(s_axis_tready),
        .m_axis_tlast(s_axis_tlast),
        .m_axis_tuser(s_axis_tuser),
    // Slave Stream  Ports
        .s_axis_tdata(S_AXIS_TDATA),
        .s_axis_tstrb(S_AXIS_TSTRB),
        .s_axis_tvalid(S_AXIS_TVALID),
        .s_axis_tready(S_AXIS_TREADY),
        .s_axis_tlast(S_AXIS_TLAST),
        .s_axis_tuser(S_AXIS_TUSER)
    );

  axis_pbs_bridge
  #(
    .C_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH_INTERNAL),
    .C_AXIS_USER_WIDTH (C_S_AXIS_TUSER_WIDTH)
  ) axis_pbs_bridge
   (
     // Global Ports
	.clk(ACLK),
        .reset(~ARESETN),
     // AXIS Ports
	.axis_tready(s_axis_tready),
        .axis_tdata(s_axis_tdata),
        .axis_tlast(s_axis_tlast),
        .axis_tvalid(s_axis_tvalid),
        .axis_tuser(s_axis_tuser),
        .axis_tstrb(s_axis_tstrb),
     // PBS Ports
        .pbs_data(M_PBS_DATA),
        .pbs_ctrl(M_PBS_CTRL),
        .pbs_wr(M_PBS_WR),
        .pbs_rdy(M_PBS_RDY)
    );
   
endmodule
