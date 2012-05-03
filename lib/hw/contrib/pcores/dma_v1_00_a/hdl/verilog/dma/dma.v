/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        dma.v
 *
 *  Library:
 *        hw/contrib/pcores/dma_v1_00_a
 *
 *  Module:
 *        dma
 *
 *  Author:
 *        Mario Flajslik
 *
 *  Description:
 *        Top level DMA module that wraps the dma_engine with the PCIe core,
 *        AXI lite master and AXI lite slave test registers.
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
`timescale 1ns / 1ps

module dma
#(
    // Master AXI Stream Data Width
    parameter C_BASEADDR=32'hffffffff,
    parameter C_HIGHADDR=32'h0
)
  (
   input          reset_n,
     
   // PCIe
   input          pcie_clk_p, // 100 MHz
   input          pcie_clk_n, // 100 MHz
   output         pci_exp_0_txp,
   output         pci_exp_0_txn,
   input          pci_exp_0_rxp,
   input          pci_exp_0_rxn,
   output         pci_exp_1_txp,
   output         pci_exp_1_txn,
   input          pci_exp_1_rxp,
   input          pci_exp_1_rxn,
   output         pci_exp_2_txp,
   output         pci_exp_2_txn,
   input          pci_exp_2_rxp,
   input          pci_exp_2_rxn,
   output         pci_exp_3_txp,
   output         pci_exp_3_txn,
   input          pci_exp_3_rxp,
   input          pci_exp_3_rxn,
   output         pci_exp_4_txp,
   output         pci_exp_4_txn,
   input          pci_exp_4_rxp,
   input          pci_exp_4_rxn,
   output         pci_exp_5_txp,
   output         pci_exp_5_txn,
   input          pci_exp_5_rxp,
   input          pci_exp_5_rxn,
   output         pci_exp_6_txp,
   output         pci_exp_6_txn,
   input          pci_exp_6_rxp,
   input          pci_exp_6_rxn,
   output         pci_exp_7_txp,
   output         pci_exp_7_txn,
   input          pci_exp_7_rxp,
   input          pci_exp_7_rxn,


   // axi streaming data interface
   input          M_AXIS_ACLK,
   output [63:0]  M_AXIS_TDATA,
   output [7:0]   M_AXIS_TSTRB,
   output         M_AXIS_TVALID,
   output [127:0] M_AXIS_TUSER,
   input          M_AXIS_TREADY,
   output         M_AXIS_TLAST,
  
   input          S_AXIS_ACLK,
   input [63:0]   S_AXIS_TDATA,
   input [7:0]    S_AXIS_TSTRB,
   input          S_AXIS_TVALID,
   output         S_AXIS_TREADY,
   input [127:0]  S_AXIS_TUSER,
   input          S_AXIS_TLAST,

   // AXI lite master
   input          M_AXI_LITE_ACLK,
   input          M_AXI_LITE_ARESETN,
   output [31:0]  M_AXI_LITE_ARADDR,
   output         M_AXI_LITE_ARVALID,
   input          M_AXI_LITE_ARREADY,
   input [31:0]   M_AXI_LITE_RDATA,
   input [1:0]    M_AXI_LITE_RRESP,
   input          M_AXI_LITE_RVALID,
   output         M_AXI_LITE_RREADY,
   output [31:0]  M_AXI_LITE_AWADDR,
   output         M_AXI_LITE_AWVALID,
   input          M_AXI_LITE_AWREADY,
   output [31:0]  M_AXI_LITE_WDATA,
   output [3:0]   M_AXI_LITE_WSTRB,
   output         M_AXI_LITE_WVALID,
   input          M_AXI_LITE_WREADY,
   input [1:0]    M_AXI_LITE_BRESP,
   input          M_AXI_LITE_BVALID,
   output         M_AXI_LITE_BREADY, 
   
   // axi lite control/status interface
   input          S_AXI_ACLK,
   input          S_AXI_ARESETN,
   input [31:0]   S_AXI_AWADDR,
   input          S_AXI_AWVALID,
   output         S_AXI_AWREADY,
   input [31:0]   S_AXI_WDATA,
   input [3:0]    S_AXI_WSTRB,
   input          S_AXI_WVALID,
   output         S_AXI_WREADY,
   output [1:0]   S_AXI_BRESP,
   output         S_AXI_BVALID,
   input          S_AXI_BREADY,
   input [31:0]   S_AXI_ARADDR,
   input          S_AXI_ARVALID,
   output         S_AXI_ARREADY,
   output [31:0]  S_AXI_RDATA,
   output [1:0]   S_AXI_RRESP,
   output         S_AXI_RVALID,
   input          S_AXI_RREADY    
   );
   
   
   wire           pcie_clk;
   wire [7:0]     pci_exp_txp;
   wire [7:0]     pci_exp_txn;
   wire [7:0]     pci_exp_rxp;
   wire [7:0]     pci_exp_rxn;

   wire           trn_clk_c;
   //synthesis attribute max_fanout of trn_clk_c is "100000"
   wire           trn_reset_n_c;
   wire           trn_lnk_up_n_c;
   wire           trn_tsof_n_c;
   wire           trn_teof_n_c;
   wire           trn_tsrc_rdy_n_c;
   wire           trn_tdst_rdy_n_c;
   wire           trn_tsrc_dsc_n_c;
   wire           trn_terrfwd_n_c;
   wire           trn_tdst_dsc_n_c;
   wire [63:0]    trn_td_c;
   wire [7:0]     trn_trem_n_c;
   wire [3:0]     trn_tbuf_av_c;

   wire           trn_rsof_n_c;
   wire           trn_reof_n_c;
   wire           trn_rsrc_rdy_n_c;
   wire           trn_rsrc_dsc_n_c;
   wire           trn_rdst_rdy_n_c;
   wire           trn_rerrfwd_n_c;
   wire           trn_rnp_ok_n_c;
   wire [63:0]    trn_rd_c;
   wire [7:0]     trn_rrem_n_c;
   wire [6:0]     trn_rbar_hit_n_c;
   wire [7:0]     trn_rfc_nph_av_c;
   wire [11:0]    trn_rfc_npd_av_c;
   wire [7:0]     trn_rfc_ph_av_c;
   wire [11:0]    trn_rfc_pd_av_c;
   wire           trn_rcpl_streaming_n_c;

   wire [31:0]    cfg_do_c;
   wire           cfg_rd_wr_done_n_c;
   wire [31:0]    cfg_di_c;
   wire [3:0]     cfg_byte_en_n_c;
   wire [9:0]     cfg_dwaddr_c;
   wire           cfg_wr_en_n_c;
   wire           cfg_rd_en_n_c;
   wire           cfg_err_cor_n_c;
   wire           cfg_err_ur_n_c;
   wire           cfg_err_ecrc_n_c;
   wire           cfg_err_cpl_timeout_n_c;
   wire           cfg_err_cpl_abort_n_c;
   wire           cfg_err_cpl_unexpect_n_c;
   wire           cfg_err_posted_n_c;
   wire [47:0]    cfg_err_tlp_cpl_header_c;
   
   wire           cfg_err_cpl_rdy_n_c;
   wire           cfg_err_locked_n_c;
   wire           cfg_interrupt_n_c;
   wire           cfg_interrupt_rdy_n_c;
   wire           cfg_interrupt_assert_n_c;
   wire [7:0]     cfg_interrupt_di_c;
   wire [7:0]     cfg_interrupt_do_c;
   wire [2:0]     cfg_interrupt_mmenable_c;
   wire           cfg_interrupt_msienable_c;
   wire           cfg_to_turnoff_n_c;
   wire           cfg_pm_wake_n_c;
   wire [2:0]     cfg_pcie_link_state_n_c;
   wire           cfg_trn_pending_n_c;
   wire [7:0]     cfg_bus_number_c;
   wire [4:0]     cfg_device_number_c;
   wire [2:0]     cfg_function_number_c;
   wire [63:0]    cfg_dsn_c;
   wire [15:0]    cfg_status_c;
   wire [15:0]    cfg_command_c;
   wire [15:0]    cfg_dstatus_c;
   wire [15:0]    cfg_dcommand_c;
   wire [15:0]    cfg_lstatus_c;
   wire [15:0]    cfg_lcommand_c;

   // AXI lite master core interface
   wire           IP2Bus_MstRd_Req;
   wire           IP2Bus_MstWr_Req;
   wire [31:0]    IP2Bus_Mst_Addr;
   wire [3:0]     IP2Bus_Mst_BE;
   wire           IP2Bus_Mst_Lock;
   wire           IP2Bus_Mst_Reset;
   wire           Bus2IP_Mst_CmdAck;
   wire           Bus2IP_Mst_Cmplt;
   wire           Bus2IP_Mst_Error;
   wire           Bus2IP_Mst_Rearbitrate;
   wire           Bus2IP_Mst_Timeout;
   wire [31:0]    Bus2IP_MstRd_d;
   wire           Bus2IP_MstRd_src_rdy_n;
   wire [31:0]    IP2Bus_MstWr_d;
   wire           Bus2IP_MstWr_dst_rdy_n;


   assign {pci_exp_7_txp, pci_exp_6_txp, pci_exp_5_txp, pci_exp_4_txp, pci_exp_3_txp, pci_exp_2_txp, pci_exp_1_txp, pci_exp_0_txp} = pci_exp_txp;
   assign {pci_exp_7_txn, pci_exp_6_txn, pci_exp_5_txn, pci_exp_4_txn, pci_exp_3_txn, pci_exp_2_txn, pci_exp_1_txn, pci_exp_0_txn} = pci_exp_txn;
   assign pci_exp_rxp = {pci_exp_7_rxp, pci_exp_6_rxp, pci_exp_5_rxp, pci_exp_4_rxp, pci_exp_3_rxp, pci_exp_2_rxp, pci_exp_1_rxp, pci_exp_0_rxp};
   assign pci_exp_rxn = {pci_exp_7_rxn, pci_exp_6_rxn, pci_exp_5_rxn, pci_exp_4_rxn, pci_exp_3_rxn, pci_exp_2_rxn, pci_exp_1_rxn, pci_exp_0_rxn};


   IBUFDS #(.DIFF_TERM("TRUE")) pcie_clk_ibuf (.O(pcie_clk), .I(pcie_clk_p), .IB(pcie_clk_n));  // 100 MHz

   reg              dma_rst;
   always @(posedge trn_clk_c)
     dma_rst <= ~trn_reset_n_c | trn_lnk_up_n_c;

   dma_engine u_dma 
     (
      .axi_clk(M_AXI_LITE_ACLK),
      .tx_clk(M_AXIS_ACLK),
      .rx_clk(S_AXIS_ACLK),
      .pcie_clk(trn_clk_c),                   
      .rst(dma_rst),

      // Tx Local-Link
      .trn_td(trn_td_c),                     
      .trn_trem_n(trn_trem_n_c),             
      .trn_tsof_n(trn_tsof_n_c),             
      .trn_teof_n(trn_teof_n_c),             
      .trn_tsrc_rdy_n(trn_tsrc_rdy_n_c),     
      .trn_tsrc_dsc_n(trn_tsrc_dsc_n_c),     
      .trn_tdst_rdy_n(trn_tdst_rdy_n_c),     
      .trn_tdst_dsc_n(trn_tdst_dsc_n_c),     
      .trn_terrfwd_n(trn_terrfwd_n_c),       
      .trn_tbuf_av(trn_tbuf_av_c),           

      // Rx Local-Link
      .trn_rd(trn_rd_c),                     
      .trn_rrem_n(trn_rrem_n_c),             
      .trn_rsof_n(trn_rsof_n_c),             
      .trn_reof_n(trn_reof_n_c),             
      .trn_rsrc_rdy_n(trn_rsrc_rdy_n_c),     
      .trn_rsrc_dsc_n(trn_rsrc_dsc_n_c),     
      .trn_rdst_rdy_n(trn_rdst_rdy_n_c),     
      .trn_rerrfwd_n(trn_rerrfwd_n_c),       
      .trn_rnp_ok_n(trn_rnp_ok_n_c),         
      .trn_rbar_hit_n(trn_rbar_hit_n_c),     
      .trn_rfc_nph_av(trn_rfc_nph_av_c),     
      .trn_rfc_npd_av(trn_rfc_npd_av_c),     
      .trn_rfc_ph_av(trn_rfc_ph_av_c),       
      .trn_rfc_pd_av(trn_rfc_pd_av_c),       
      .trn_rcpl_streaming_n(trn_rcpl_streaming_n_c),          

      // Host ( CFG ) Interface
      .cfg_do(cfg_do_c),                                             
      .cfg_rd_wr_done_n(cfg_rd_wr_done_n_c),                         
      .cfg_di(cfg_di_c),                                 
      .cfg_byte_en_n(cfg_byte_en_n_c),                   
      .cfg_dwaddr(cfg_dwaddr_c),                         
      .cfg_wr_en_n(cfg_wr_en_n_c),                       
      .cfg_rd_en_n(cfg_rd_en_n_c),                       

      .cfg_err_cor_n(cfg_err_cor_n_c),                   
      .cfg_err_ur_n(cfg_err_ur_n_c),                     
      .cfg_err_ecrc_n(cfg_err_ecrc_n_c),                 
      .cfg_err_cpl_timeout_n(cfg_err_cpl_timeout_n_c),   
      .cfg_err_cpl_abort_n(cfg_err_cpl_abort_n_c),       
      .cfg_err_cpl_unexpect_n(cfg_err_cpl_unexpect_n_c), 
      .cfg_err_posted_n(cfg_err_posted_n_c),             
      .cfg_err_tlp_cpl_header(cfg_err_tlp_cpl_header_c), 
      .cfg_err_cpl_rdy_n(cfg_err_cpl_rdy_n_c),           
      .cfg_err_locked_n(cfg_err_locked_n_c),             

      .cfg_interrupt_n(cfg_interrupt_n_c),               
      .cfg_interrupt_rdy_n(cfg_interrupt_rdy_n_c),       
      .cfg_interrupt_assert_n(cfg_interrupt_assert_n_c),                     
      .cfg_interrupt_di(cfg_interrupt_di_c),             
      .cfg_interrupt_do(cfg_interrupt_do_c),             
      .cfg_interrupt_mmenable(cfg_interrupt_mmenable_c),    
      .cfg_interrupt_msienable(cfg_interrupt_msienable_c),  

      .cfg_pm_wake_n(cfg_pm_wake_n_c),                      
      .cfg_pcie_link_state_n(cfg_pcie_link_state_n_c),      
      .cfg_to_turnoff_n(cfg_to_turnoff_n_c),                
      .cfg_trn_pending_n(cfg_trn_pending_n_c),              
      .cfg_dsn(cfg_dsn_c),                       
      .cfg_bus_number(cfg_bus_number_c),                
      .cfg_device_number(cfg_device_number_c),          
      .cfg_function_number(cfg_function_number_c),      
      .cfg_status(cfg_status_c),                        
      .cfg_command(cfg_command_c),                      
      .cfg_dstatus(cfg_dstatus_c),                      
      .cfg_dcommand(cfg_dcommand_c),                    
      .cfg_lstatus(cfg_lstatus_c),                      
      .cfg_lcommand(cfg_lcommand_c),

      // AXI lite master core interface
      .IP2Bus_MstRd_Req(IP2Bus_MstRd_Req),
      .IP2Bus_MstWr_Req(IP2Bus_MstWr_Req),
      .IP2Bus_Mst_Addr(IP2Bus_Mst_Addr),
      .IP2Bus_Mst_BE(IP2Bus_Mst_BE),
      .IP2Bus_Mst_Lock(IP2Bus_Mst_Lock),
      .IP2Bus_Mst_Reset(IP2Bus_Mst_Reset),
      .Bus2IP_Mst_CmdAck(Bus2IP_Mst_CmdAck),
      .Bus2IP_Mst_Cmplt(Bus2IP_Mst_Cmplt),
      .Bus2IP_Mst_Error(Bus2IP_Mst_Error),
      .Bus2IP_Mst_Rearbitrate(Bus2IP_Mst_Rearbitrate),
      .Bus2IP_Mst_Timeout(Bus2IP_Mst_Timeout),
      .Bus2IP_MstRd_d(Bus2IP_MstRd_d),
      .Bus2IP_MstRd_src_rdy_n(Bus2IP_MstRd_src_rdy_n),
      .IP2Bus_MstWr_d(IP2Bus_MstWr_d),
      .Bus2IP_MstWr_dst_rdy_n(Bus2IP_MstWr_dst_rdy_n),

      // MAC tx
      .M_AXIS_TDATA(M_AXIS_TDATA),
      .M_AXIS_TSTRB(M_AXIS_TSTRB),
      .M_AXIS_TVALID(M_AXIS_TVALID),
      .M_AXIS_TREADY(M_AXIS_TREADY),
      .M_AXIS_TLAST(M_AXIS_TLAST),
      .M_AXIS_TUSER(M_AXIS_TUSER),

      // MAC rx
      .S_AXIS_TDATA(S_AXIS_TDATA),
      .S_AXIS_TSTRB(S_AXIS_TSTRB),
      .S_AXIS_TVALID(S_AXIS_TVALID),
      .S_AXIS_TREADY(S_AXIS_TREADY),
      .S_AXIS_TUSER(S_AXIS_TUSER),
      .S_AXIS_TLAST(S_AXIS_TLAST)              
      );


   endpoint_blk_plus_v1_15 ep  
     (
      // System ( SYS ) Interface
      .sys_clk( pcie_clk ),               // I
      .sys_reset_n( reset_n ),            // I
      .refclkout(),                       // O

      // PCI Express Fabric Interface
      .pci_exp_txp( pci_exp_txp ),        // O [7:0]
      .pci_exp_txn( pci_exp_txn ),        // O [7:0]
      .pci_exp_rxp( pci_exp_rxp ),        // I [7:0]
      .pci_exp_rxn( pci_exp_rxn ),        // I [7:0]

      // Transaction ( TRN ) Interface Control
      .trn_clk(trn_clk_c),                // O
      .trn_reset_n(trn_reset_n_c),        // O
      .trn_lnk_up_n(trn_lnk_up_n_c),      // O

      // Tx Local-Link
      .trn_td(trn_td_c),                  // I [63/31:0]
      .trn_trem_n(trn_trem_n_c),          // I [7:0]
      .trn_tsof_n(trn_tsof_n_c),          // I
      .trn_teof_n(trn_teof_n_c),          // I
      .trn_tsrc_rdy_n(trn_tsrc_rdy_n_c),  // I
      .trn_tsrc_dsc_n(trn_tsrc_dsc_n_c),  // I
      .trn_tdst_rdy_n(trn_tdst_rdy_n_c),  // O
      .trn_tdst_dsc_n(trn_tdst_dsc_n_c),  // O
      .trn_terrfwd_n(trn_terrfwd_n_c),    // I
      .trn_tbuf_av(trn_tbuf_av_c),        // O [3:0]

      // Rx Local-Link
      .trn_rd(trn_rd_c),                             // O [63/31:0]
      .trn_rrem_n(trn_rrem_n_c),                     // O [7:0]
      .trn_rsof_n(trn_rsof_n_c),                     // O
      .trn_reof_n(trn_reof_n_c),                     // O
      .trn_rsrc_rdy_n(trn_rsrc_rdy_n_c),             // O
      .trn_rsrc_dsc_n(trn_rsrc_dsc_n_c),             // O
      .trn_rdst_rdy_n(trn_rdst_rdy_n_c),             // I
      .trn_rerrfwd_n(trn_rerrfwd_n_c),               // O
      .trn_rnp_ok_n(trn_rnp_ok_n_c),                 // I
      .trn_rbar_hit_n(trn_rbar_hit_n_c),             // O [6:0]
      .trn_rfc_nph_av(trn_rfc_nph_av_c),             // O [11:0]
      .trn_rfc_npd_av(trn_rfc_npd_av_c),             // O [7:0]
      .trn_rfc_ph_av(trn_rfc_ph_av_c),               // O [11:0]
      .trn_rfc_pd_av(trn_rfc_pd_av_c),               // O [7:0]
      .trn_rcpl_streaming_n(trn_rcpl_streaming_n_c), // I

      // Host ( CFG ) Interface
      .cfg_do(cfg_do_c),                                 // O [31:0]
      .cfg_rd_wr_done_n(cfg_rd_wr_done_n_c),             // O
      .cfg_di(cfg_di_c),                                 // I [31:0]
      .cfg_byte_en_n(cfg_byte_en_n_c),                   // I [3:0]
      .cfg_dwaddr(cfg_dwaddr_c),                         // I [9:0]
      .cfg_wr_en_n(cfg_wr_en_n_c),                       // I
      .cfg_rd_en_n(cfg_rd_en_n_c),                       // I
      .cfg_err_cor_n(cfg_err_cor_n_c),                   // I
      .cfg_err_ur_n(cfg_err_ur_n_c),                     // I
      .cfg_err_ecrc_n(cfg_err_ecrc_n_c),                 // I
      .cfg_err_cpl_timeout_n(cfg_err_cpl_timeout_n_c),   // I
      .cfg_err_cpl_abort_n(cfg_err_cpl_abort_n_c),       // I
      .cfg_err_cpl_unexpect_n(cfg_err_cpl_unexpect_n_c), // I
      .cfg_err_posted_n(cfg_err_posted_n_c),             // I
      .cfg_err_tlp_cpl_header(cfg_err_tlp_cpl_header_c), // I [47:0]
      .cfg_err_cpl_rdy_n(cfg_err_cpl_rdy_n_c),           // O
      .cfg_err_locked_n(cfg_err_locked_n_c),             // I

      .cfg_interrupt_n(cfg_interrupt_n_c),                    // I
      .cfg_interrupt_rdy_n(cfg_interrupt_rdy_n_c),            // O
      .cfg_interrupt_assert_n(cfg_interrupt_assert_n_c),      // I
      .cfg_interrupt_di(cfg_interrupt_di_c),                  // I [7:0]
      .cfg_interrupt_do(cfg_interrupt_do_c),                  // O [7:0]
      .cfg_interrupt_mmenable(cfg_interrupt_mmenable_c),      // O [2:0]
      .cfg_interrupt_msienable(cfg_interrupt_msienable_c),    // O  

      .cfg_pm_wake_n(cfg_pm_wake_n_c),                   // I
      .cfg_pcie_link_state_n(cfg_pcie_link_state_n_c),   // O [2:0]
      .cfg_to_turnoff_n(cfg_to_turnoff_n_c),             // O
      .cfg_trn_pending_n(cfg_trn_pending_n_c),           // I
      .cfg_dsn(cfg_dsn_c),                               // I [63:0]

      .cfg_bus_number(cfg_bus_number_c),                 // O [7:0]
      .cfg_device_number(cfg_device_number_c),           // O [4:0]
      .cfg_function_number(cfg_function_number_c),       // O [2:0]
      .cfg_status(cfg_status_c),                         // O [15:0]
      .cfg_command(cfg_command_c),                       // O [15:0]
      .cfg_dstatus(cfg_dstatus_c),                       // O [15:0]
      .cfg_dcommand(cfg_dcommand_c),                     // O [15:0]
      .cfg_lstatus(cfg_lstatus_c),                       // O [15:0]
      .cfg_lcommand(cfg_lcommand_c),                     // O [15:0]

      // The following is used for simulation only.  Setting
      // the following core input to 1 will result in a fast
      // train simulation to happen.  This bit should not be set
      // during synthesis or the core may not operate properly.
`ifdef SIMULATION
      .fast_train_simulation_only(1'b1)
`else
      .fast_train_simulation_only(1'b0)
`endif
      );

   
   axi_master_lite u_axi_m
     (
      .m_axi_lite_aclk(M_AXI_LITE_ACLK),
      .m_axi_lite_aresetn(M_AXI_LITE_ARESETN),
      .md_error(),
      .m_axi_lite_araddr(M_AXI_LITE_ARADDR),
      .m_axi_lite_arvalid(M_AXI_LITE_ARVALID),
      .m_axi_lite_arready(M_AXI_LITE_ARREADY),
      .m_axi_lite_arprot(),
      .m_axi_lite_rdata(M_AXI_LITE_RDATA),
      .m_axi_lite_rresp(M_AXI_LITE_RRESP),
      .m_axi_lite_rvalid(M_AXI_LITE_RVALID),
      .m_axi_lite_rready(M_AXI_LITE_RREADY),
      .m_axi_lite_awaddr(M_AXI_LITE_AWADDR),
      .m_axi_lite_awvalid(M_AXI_LITE_AWVALID),
      .m_axi_lite_awready(M_AXI_LITE_AWREADY),
      .m_axi_lite_awprot(),
      .m_axi_lite_wdata(M_AXI_LITE_WDATA),
      .m_axi_lite_wstrb(M_AXI_LITE_WSTRB),
      .m_axi_lite_wvalid(M_AXI_LITE_WVALID),
      .m_axi_lite_wready(M_AXI_LITE_WREADY),
      .m_axi_lite_bresp(M_AXI_LITE_BRESP),
      .m_axi_lite_bvalid(M_AXI_LITE_BVALID),
      .m_axi_lite_bready(M_AXI_LITE_BREADY),      
      .ip2bus_mstrd_req(IP2Bus_MstRd_Req),
      .ip2bus_mstwr_req(IP2Bus_MstWr_Req),
      .ip2bus_mst_addr(IP2Bus_Mst_Addr),
      .ip2bus_mst_be(IP2Bus_Mst_BE),
      .ip2bus_mst_lock(IP2Bus_Mst_Lock),
      .ip2bus_mst_reset(IP2Bus_Mst_Reset),
      .bus2ip_mst_cmdack(Bus2IP_Mst_CmdAck),
      .bus2ip_mst_cmplt(Bus2IP_Mst_Cmplt),
      .bus2ip_mst_error(Bus2IP_Mst_Error),
      .bus2ip_mst_rearbitrate(Bus2IP_Mst_Rearbitrate),
      .bus2ip_mst_cmd_timeout(Bus2IP_Mst_Timeout),
      .bus2ip_mstrd_d(Bus2IP_MstRd_d),
      .bus2ip_mstrd_src_rdy_n(Bus2IP_MstRd_src_rdy_n),
      .ip2bus_mstwr_d(IP2Bus_MstWr_d),
      .bus2ip_mstwr_dst_rdy_n(Bus2IP_MstWr_dst_rdy_n)
      );


   axi4_lite_regs_test u_axi_test
     (
      .ACLK(S_AXI_ACLK),
      .ARESETN(S_AXI_ARESETN),
      .AWADDR(S_AXI_AWADDR),
      .AWVALID(S_AXI_AWVALID),
      .AWREADY(S_AXI_AWREADY),
      .WDATA(S_AXI_WDATA),
      .WSTRB(S_AXI_WSTRB),
      .WVALID(S_AXI_WVALID),
      .WREADY(S_AXI_WREADY),
      .BRESP(S_AXI_BRESP),
      .BVALID(S_AXI_BVALID),
      .BREADY(S_AXI_BREADY),
      .ARADDR(S_AXI_ARADDR),
      .ARVALID(S_AXI_ARVALID),
      .ARREADY(S_AXI_ARREADY),
      .RDATA(S_AXI_RDATA),
      .RRESP(S_AXI_RRESP),
      .RVALID(S_AXI_RVALID),
      .RREADY(S_AXI_RREADY)
      );

   
endmodule
