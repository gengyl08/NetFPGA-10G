/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        axi_lite_regs.v
 *
 *  Library:
 *        osnt/pcores/nf10_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        axi_lite_regs
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        Defines a module for the axi-lite registers
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

module axi_lite_regs
#(
    // Master AXI Stream parameters
    parameter C_S_AXI_DATA_WIDTH=32,
    parameter C_S_AXI_ADDR_WIDTH=32,
    parameter C_USE_WSTRB=0,
    parameter C_DPHASE_TIMEOUT=0,
    parameter C_BAR0_BASEADDR=32'hFFFFFFFF,
    parameter C_BAR0_HIGHADDR=32'h00000000,
    parameter C_S_AXI_ACLK_FREQ_HZ=100,
    // Register parameters
    parameter NUM_RW_REGS = 0,
    parameter NUM_WO_REGS = 0,
    parameter NUM_RO_REGS = 0
)
(
    // Part 1: System side signals
    // AXI Lite control/status interface
    input                                      s_axi_aclk,
    input                                      s_axi_aresetn,
    input  [C_S_AXI_ADDR_WIDTH-1:0]            s_axi_awaddr,
    input                                      s_axi_awvalid,
    output                                     s_axi_awready,
    input  [C_S_AXI_DATA_WIDTH-1:0]            s_axi_wdata,
    input  [((C_S_AXI_DATA_WIDTH / 8)) - 1:0]  s_axi_wstrb,
    input                                      s_axi_wvalid,
    output                                     s_axi_wready,
    output [1:0]                               s_axi_bresp,
    output                                     s_axi_bvalid,
    input                                      s_axi_bready,
    input  [C_S_AXI_ADDR_WIDTH-1:0]            s_axi_araddr,
    input                                      s_axi_arvalid,
    output                                     s_axi_arready,
    output [C_S_AXI_DATA_WIDTH-1:0]            s_axi_rdata,
    output [1:0]                               s_axi_rresp,
    output                                     s_axi_rvalid,
    input                                      s_axi_rready,

    // Part 2: Register side signals
    output [NUM_RW_REGS*C_S_AXI_DATA_WIDTH:0]  rw_regs,
    input  [NUM_RW_REGS*C_S_AXI_DATA_WIDTH:0]  rw_defaults,
    output [NUM_WO_REGS*C_S_AXI_DATA_WIDTH:0]  wo_regs,
    input  [NUM_WO_REGS*C_S_AXI_DATA_WIDTH:0]  wo_defaults,
    output [NUM_RO_REGS*C_S_AXI_DATA_WIDTH:0]  ro_regs
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

   // ------------- Regs/ wires -----------

   wire                             bus2ip_clk;
   wire                             bus2ip_resetn;
   wire [C_S_AXI_ADDR_WIDTH-1:0]    bus2ip_addr;
   wire [0:0]                       bus2ip_cs;
   wire                             bus2ip_rnw;
   wire [C_S_AXI_DATA_WIDTH-1:0]    bus2ip_data;
   wire [C_S_AXI_DATA_WIDTH/8-1:0]  bus2ip_be;
   wire [C_S_AXI_DATA_WIDTH-1:0]    ip2bus_data;
   wire                             ip2bus_rdack;
   wire                             ip2bus_wrack;
   wire                             ip2bus_error;

   // ------------ Modules -------------

   axi_lite_ipif_1bar
   #( .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
      .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),
      .C_USE_WSTRB        (C_USE_WSTRB),
      .C_DPHASE_TIMEOUT   (C_DPHASE_TIMEOUT),
      .C_BAR0_BASEADDR    (C_BAR0_BASEADDR),
      .C_BAR0_HIGHADDR    (C_BAR0_HIGHADDR))
      axi_lite_ipif_inst
        (
         .S_AXI_ACLK      (s_axi_aclk),
         .S_AXI_ARESETN   (s_axi_aresetn),
         .S_AXI_AWADDR    (s_axi_awaddr),
         .S_AXI_AWVALID   (s_axi_awvalid),
         .S_AXI_WDATA     (s_axi_wdata),
         .S_AXI_WSTRB     (s_axi_wstrb),
         .S_AXI_WVALID    (s_axi_wvalid),
         .S_AXI_BREADY    (s_axi_bready),
         .S_AXI_ARADDR    (s_axi_araddr),
         .S_AXI_ARVALID   (s_axi_arvalid),
         .S_AXI_RREADY    (s_axi_rready),
         .S_AXI_ARREADY   (s_axi_arready),
         .S_AXI_RDATA     (s_axi_rdata),
         .S_AXI_RRESP     (s_axi_rresp),
         .S_AXI_RVALID    (s_axi_rvalid),
         .S_AXI_WREADY    (s_axi_wready),
         .S_AXI_BRESP     (s_axi_bresp),
         .S_AXI_BVALID    (s_axi_bvalid),
         .S_AXI_AWREADY   (s_axi_awready),

         // Controls to the IP/IPIF 
         .Bus2IP_Clk      (bus2ip_clk),
         .Bus2IP_Resetn   (bus2ip_resetn),
         .Bus2IP_Addr     (bus2ip_addr),
         .Bus2IP_RNW      (bus2ip_rnw),
         .Bus2IP_BE       (bus2ip_be),
         .Bus2IP_CS       (bus2ip_cs),
         .Bus2IP_Data     (bus2ip_data),
         .IP2Bus_Data     (ip2bus_data),
         .IP2Bus_WrAck    (ip2bus_wrack),
         .IP2Bus_RdAck    (ip2bus_rdack),
         .IP2Bus_Error    (ip2bus_error)
        );

   ipif_regs
   #( .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
      .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),
      .NUM_RW_REGS        (NUM_RW_REGS),
      .NUM_WO_REGS        (NUM_WO_REGS),
      .NUM_RO_REGS        (NUM_RO_REGS))
      ipif_regs_inst
        (
         .Bus2IP_Clk    (bus2ip_clk),
         .Bus2IP_Resetn (bus2ip_resetn),
         .Bus2IP_Addr   (bus2ip_addr),
         .Bus2IP_CS     (bus2ip_cs[0]),
         .Bus2IP_RNW    (bus2ip_rnw),
         .Bus2IP_Data   (bus2ip_data),
         .Bus2IP_BE     (bus2ip_be),
         .IP2Bus_Data   (ip2bus_data),
         .IP2Bus_RdAck  (ip2bus_rdack),
         .IP2Bus_WrAck  (ip2bus_wrack),
         .IP2Bus_Error  (ip2bus_error),

         .rw_regs       (rw_regs),
         .rw_defaults   (rw_defaults),
         .wo_regs       (wo_regs),
         .wo_defaults   (wo_defaults),
         .ro_regs       (ro_regs)
        );

endmodule
