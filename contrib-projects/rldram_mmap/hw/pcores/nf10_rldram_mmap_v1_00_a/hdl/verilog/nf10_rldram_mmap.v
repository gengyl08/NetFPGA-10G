/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_rldram_mmap.v
 *
 *  Library:
 *        hw/std/pcores/nf10_rldram_mmap_v1_00_a
 *
 *  Module:
 *        nf10_rldram_mmap
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
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
 *        This module was developed by SRI International and the University of
 *        Cambridge Computer Laboratory under DARPA/AFRL contract (FA8750-11-C-0249)
 *        ("MRC2"), as part of the DARPA MRC research programme.
 *
 */
 
`include "nf10_defs.vh" 

`timescale 1 ns / 100 ps
 
module nf10_rldram_mmap
#(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////

`ifdef SIMULATION
   parameter SIMULATION_ONLY = 1'b1,
`else
   parameter SIMULATION_ONLY = 1'b0,
`endif

   parameter RL_DQ_WIDTH     = 72,
   parameter DEV_DQ_WIDTH    = 36, // data width of the memory device
   parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH, // number of memory devices
   parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS,
   parameter DEV_AD_WIDTH    = 20, // address width of the memory device
   parameter DEV_BA_WIDTH    = 3, // bank address width of the memory device
   parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH,
   parameter DUPLICATE_CONTROLS = 1'b0, // Duplicate the ports for A, BA, WE# and REF#
   parameter RL_CK_PERIOD    = 16'd3003,  // CK clock period of the RLDRAM in ps
   // MRS (Mode Register Set command) parameters   
   //    please check Micron RLDRAM-II datasheet for definitions of these parameters
   parameter RL_MRS_CONF     = 3'b011, // 3'b001: mode1,  3'b010: mode2,  3'b011: mode3
   parameter RL_MRS_BURST_LENGTH = 2'b00, // 2'b00: BL2,  2'b01: BL4,  2'b10: BL8 (BL8 unsupported)
   parameter RL_MRS_ADDR_MUX = 1'b0, // 1'b0: non-muxed addr,  1'b1: muxed addr
   parameter RL_MRS_DLL_RESET = 1'b1, // 1'b0: Memory DLL reset, 1'b1: Memory DLL enabled
   parameter RL_MRS_IMPEDANCE_MATCH = 1'b1, // 1'b0: internal 50ohms output buffer impedance, 1'b1: external 
   parameter RL_MRS_ODT       = 1'b0, // 1'b0: disable term,  1'b1: enable term
   
   // specific to FPGA/memory devices and capture method
   parameter RL_IO_TYPE       = 2'b00, // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
   parameter DEVICE_ARCH      = 2'b01, // Virtex4=2'b00  Virtex5=2'b01
   parameter CAPTURE_METHOD   = 2'b01, // Direct Clocking=2'b00  SerDes=2'b01
   parameter CAL_ADDRESS      = {DEV_AD_WIDTH{1'b0}}, //saved location to perform calibration
   
                    // FPGA Family. Current version: virtex5.
   parameter         C_FAMILY                        = "virtex5",
                    // Width of all master and slave ID signals.
                    // Range: >= 1.
   parameter integer C_S_AXI_ID_WIDTH                = 4,
                    // Width of S_AXI_AWADDR, S_AXI_ARADDR, M_AXI_AWADDR and
                    // M_AXI_ARADDR for all SI/MI slots.
                    // Range: 32.
   parameter integer C_S_AXI_ADDR_WIDTH              = 32 , // 4 word burst x 4 Byte/word = 16 Byte = 2 ^ 4
                    // Width of WDATA and RDATA on SI slot.
                    // Must be <= C_MC_DATA_WIDTH
                    // Range: 32, 64, 128, 256.
   parameter integer C_S_AXI_DATA_WIDTH              = 128,
                    // Number of Memory Controllers
   parameter integer C_MC_NUM_CTRL                   = 1,
                    // Memory controller address width, range 28-32
   parameter integer C_MC_ADDR_WIDTH                 = DEV_AD_WIDTH+DEV_BA_WIDTH,
                    // Width of wr_data and rd_data.
                    // Range: 32, 64, 128, 256.
   parameter integer C_MC_DATA_WIDTH                 = 128,
                    // memory controller burst mode,
                    // values "8", "4" & "OTF"
   parameter         C_MC_BURST_MODE      = "4",
                    // Indicates whether to instatiate upsizer
                    // Range: 0, 1
   parameter integer C_S_AXI_SUPPORTS_NARROW_BURST   = 1,
   parameter         C_S_AXI_REG_EN0                 = 20'h00000,
                    // Instatiates register slices before upsizer.
                    // The type of register is specified for each channel
                    // in a vector. 4 bits per channel are used.
                    // C_S_AXI_REG_EN1[03:00] = AW CHANNEL REGISTER SLICE
                    // C_S_AXI_REG_EN1[07:04] =  W CHANNEL REGISTER SLICE
                    // C_S_AXI_REG_EN1[11:08] =  B CHANNEL REGISTER SLICE
                    // C_S_AXI_REG_EN1[15:12] = AR CHANNEL REGISTER SLICE
                    // C_S_AXI_REG_EN1[20:16] =  R CHANNEL REGISTER SLICE
                    // Possible values for each channel are:
                    //
                    //   0 => BYPASS    = The channel is just wired through the
                    //                    module.
                    //   1 => FWD       = The master VALID and payload signals
                    //                    are registrated.
                    //   2 => REV       = The slave ready signal is registrated
                    //   3 => FWD_REV   = Both FWD and REV
                    //   4 => SLAVE_FWD = All slave side signals and master
                    //                    VALID and payload are registrated.
                    //   5 => SLAVE_RDY = All slave side signals and master
                    //                    READY are registrated.
                    //   6 => INPUTS    = Slave and Master side inputs are
                    //                    registrated.
                    //
                    //                                     A  A
                    //                                    RRBWW
   parameter        C_S_AXI_REG_EN1                  = 20'h00000,

   parameter        C_S_AXI_BASEADDR                 = 32'h0000_0000,
                    // AXI high address to memory
   parameter        C_S_AXI_HIGHADDR                 = 32'hFFFF_FFFF
)
(
///////////////////////////////////////////////////////////////////////////////
// Port Declarations
///////////////////////////////////////////////////////////////////////////////
  // AXI Slave Interface
  // Slave Interface System Signals
  input  wire                               aclk              ,
  input  wire                               aresetn           ,
  
  // Slave Interface Write Address Ports
  input  wire [C_S_AXI_ID_WIDTH-1:0]        s_axi_awid        ,
  input  wire [C_S_AXI_ADDR_WIDTH-1:0]      s_axi_awaddr      ,
  input  wire [7:0]                         s_axi_awlen       ,
  input  wire [2:0]                         s_axi_awsize      ,
  input  wire [1:0]                         s_axi_awburst     ,
  input  wire [0:0]                         s_axi_awlock      ,
  input  wire [3:0]                         s_axi_awcache     ,
  input  wire [2:0]                         s_axi_awprot      ,
  input  wire [3:0]                         s_axi_awqos       ,
  input  wire                               s_axi_awvalid     ,
  output wire                               s_axi_awready     ,
  // Slave Interface Write Data Ports
  input  wire [C_S_AXI_DATA_WIDTH-1:0]      s_axi_wdata       ,
  input  wire [C_S_AXI_DATA_WIDTH/8-1:0]    s_axi_wstrb       ,
  input  wire                               s_axi_wlast       ,
  input  wire                               s_axi_wvalid      ,
  output wire                               s_axi_wready      ,
  // Slave Interface Write Response Ports
  output wire [C_S_AXI_ID_WIDTH-1:0]        s_axi_bid         ,
  output wire [1:0]                         s_axi_bresp       ,
  output wire                               s_axi_bvalid      ,
  input  wire                               s_axi_bready      ,
  // Slave Interface Read Address Ports
  input  wire [C_S_AXI_ID_WIDTH-1:0]        s_axi_arid        ,
  input  wire [C_S_AXI_ADDR_WIDTH-1:0]      s_axi_araddr      ,
  input  wire [7:0]                         s_axi_arlen       ,
  input  wire [2:0]                         s_axi_arsize      ,
  input  wire [1:0]                         s_axi_arburst     ,
  input  wire [0:0]                         s_axi_arlock      ,
  input  wire [3:0]                         s_axi_arcache     ,
  input  wire [2:0]                         s_axi_arprot      ,
  input  wire [3:0]                         s_axi_arqos       ,
  input  wire                               s_axi_arvalid     ,
  output wire                               s_axi_arready     ,
  // Slave Interface Read Data Ports
  output wire [C_S_AXI_ID_WIDTH-1:0]        s_axi_rid         ,
  output wire [C_S_AXI_DATA_WIDTH-1:0]      s_axi_rdata       ,
  output wire [1:0]                         s_axi_rresp       ,
  output wire                               s_axi_rlast       ,
  output wire                               s_axi_rvalid      ,
  input  wire                               s_axi_rready      ,
  
  // RLD2 memory signals
  output [NUM_OF_DEVS-1:0]                  RLD2_CK_P       ,
  output [NUM_OF_DEVS-1:0]                  RLD2_CK_N       ,
  output [NUM_OF_DKS-1:0]                   RLD2_DK_P       ,
  output [NUM_OF_DKS-1:0]                   RLD2_DK_N       ,
  input  [2*NUM_OF_DEVS-1:0]                RLD2_QK_P       ,
  input  [2*NUM_OF_DEVS-1:0]                RLD2_QK_N       ,
  output [DEV_AD_WIDTH-1:0]                 RLD2_A          ,
  output [DEV_BA_WIDTH-1:0]                 RLD2_BA         ,
  output [NUM_OF_DEVS-1:0]                  RLD2_CS_N       ,
  output                                    RLD2_WE_N       ,
  output                                    RLD2_REF_N      ,
  output [NUM_OF_DEVS-1:0]                  RLD2_DM         ,
  inout  [RL_DQ_WIDTH-RL_DQ_WIDTH/9-1:0]    RLD2_DQ         ,
  input  [NUM_OF_DEVS-1:0]                  RLD2_QVLD         
);  

   localparam P_S_AXI_ADDRMASK = C_S_AXI_BASEADDR ^ C_S_AXI_HIGHADDR;
   
   // Internal Signals
   wire                               app_en         ; 
   wire [2:0]                         app_cmd        ; 
   wire [C_MC_ADDR_WIDTH-1:0]         app_addr       ;   
   wire                               app_rdy        ;   
   wire                               app_wdf_wren   ; 
   wire [C_MC_DATA_WIDTH-1:0]         app_wdf_data   ;
   wire [C_MC_DATA_WIDTH/8-1:0]       app_wdf_mask   ;
   wire                               app_wdf_rdy    ;
   wire                               app_rd_valid   ; 
   wire [C_MC_DATA_WIDTH-1:0]         app_rd_data    ;
   
   wire [2:0]                         apCmd          ;
   wire [C_MC_ADDR_WIDTH-1:0]         apAddr         ;   
   wire                               apValid        ;
   wire                               rlafFull       ;
   wire [2*RL_DQ_WIDTH-1:0]           apWriteData    ;
   wire                               apWriteDValid  ;
   wire                               rlWdfFull      ;
   wire [2*RL_DQ_WIDTH-1:0]           rldReadData    ;
   wire                               rldReadDataValid;
   
   wire                               init_complete  ;
   
   wire [RL_DQ_WIDTH/9-1:0]           weak_gnd       ;

   // AXI Memory Controller
   axi_mc 
   #(
    .C_FAMILY                ( "rtl"                   ) ,
    .C_S_AXI_ID_WIDTH        ( C_S_AXI_ID_WIDTH        ) ,
    .C_S_AXI_ADDR_WIDTH      ( C_S_AXI_ADDR_WIDTH      ) ,
    .C_S_AXI_DATA_WIDTH      ( C_S_AXI_DATA_WIDTH      ) ,
    .C_MC_ADDR_WIDTH         ( C_MC_ADDR_WIDTH         ) ,
    .C_MC_DATA_WIDTH         ( C_MC_DATA_WIDTH         ) ,
    .C_MC_BURST_MODE         ( C_MC_BURST_MODE         ) ,
    .C_S_AXI_SUPPORTS_NARROW_BURST ( C_S_AXI_SUPPORTS_NARROW_BURST ) ,
    .C_S_AXI_REG_EN0         ( C_S_AXI_REG_EN0         ) ,
    .C_S_AXI_REG_EN1         ( C_S_AXI_REG_EN1         )
   )
   u_axi_mc
   (
    .aclk                                   ( aclk            ) ,
    .aresetn                                ( aresetn         ) ,
    // Slave Interface Write Address Ports
    .s_axi_awid                             ( s_axi_awid      ) ,
    .s_axi_awaddr                           ( s_axi_awaddr & P_S_AXI_ADDRMASK   ) ,
    .s_axi_awlen                            ( s_axi_awlen     ) ,
    .s_axi_awsize                           ( s_axi_awsize    ) ,
    .s_axi_awburst                          ( s_axi_awburst   ) ,
    .s_axi_awlock                           ( s_axi_awlock    ) ,
    .s_axi_awcache                          ( s_axi_awcache   ) ,
    .s_axi_awprot                           ( s_axi_awprot    ) ,
    .s_axi_awqos                            ( s_axi_awqos     ) ,
    .s_axi_awvalid                          ( s_axi_awvalid   ) ,
    .s_axi_awready                          ( s_axi_awready   ) ,
    // Slave Interface Write Data Ports
    .s_axi_wdata                            ( s_axi_wdata     ) ,
    .s_axi_wstrb                            ( s_axi_wstrb     ) ,
    .s_axi_wlast                            ( s_axi_wlast     ) ,
    .s_axi_wvalid                           ( s_axi_wvalid    ) ,
    .s_axi_wready                           ( s_axi_wready    ) ,
    // Slave Interface Write Response Ports
    .s_axi_bid                              ( s_axi_bid       ) ,
    .s_axi_bresp                            ( s_axi_bresp     ) ,
    .s_axi_bvalid                           ( s_axi_bvalid    ) ,
    .s_axi_bready                           ( s_axi_bready    ) ,
    // Slave Interface Read Address Ports
    .s_axi_arid                             ( s_axi_arid      ) ,
    .s_axi_araddr                           ( s_axi_araddr & P_S_AXI_ADDRMASK  ) ,
    .s_axi_arlen                            ( s_axi_arlen     ) ,
    .s_axi_arsize                           ( s_axi_arsize    ) ,
    .s_axi_arburst                          ( s_axi_arburst   ) ,
    .s_axi_arlock                           ( s_axi_arlock    ) ,
    .s_axi_arcache                          ( s_axi_arcache   ) ,
    .s_axi_arprot                           ( s_axi_arprot    ) ,
    .s_axi_arqos                            ( s_axi_arqos     ) ,
    .s_axi_arvalid                          ( s_axi_arvalid   ) ,
    .s_axi_arready                          ( s_axi_arready   ) ,
    // Slave Interface Read Data Ports
    .s_axi_rid                              ( s_axi_rid       ) ,
    .s_axi_rdata                            ( s_axi_rdata     ) ,
    .s_axi_rresp                            ( s_axi_rresp     ) ,
    .s_axi_rlast                            ( s_axi_rlast     ) ,
    .s_axi_rvalid                           ( s_axi_rvalid    ) ,
    .s_axi_rready                           ( s_axi_rready    ) ,
   
    // MC Master Interface
    //CMD PORT
    .mc_app_en                              ( app_en ) ,
    .mc_app_cmd                             ( app_cmd ) ,
    // .mc_app_sz                              ( ) ,
    .mc_app_addr                            ( app_addr ) ,
    // .mc_app_hi_pri                          ( ) ,
    .mc_app_rdy                             ( app_rdy ) ,
	.mc_init_complete                       ( init_complete ) ,
   
    //DATA PORT
    .mc_app_wdf_wren                        ( app_wdf_wren ) ,
    .mc_app_wdf_mask                        ( app_wdf_mask ) ,
    .mc_app_wdf_data                        ( app_wdf_data ) ,
    // .mc_app_wdf_end                         ( ) ,
    .mc_app_wdf_rdy                         ( app_wdf_rdy ) ,
   
    .mc_app_rd_valid                        ( app_rd_valid ) ,
    .mc_app_rd_data                         ( app_rd_data )
    // ,											   
    // .mc_app_rd_end                          ( ),
	// .mc_app_ecc_multiple_err                ( )
   );
   
   rd_mdfy_wr #
   (
    .ADDR_WIDTH  (C_MC_ADDR_WIDTH),
    .DATA_WIDTH  (C_MC_DATA_WIDTH),
    .RL_DQ_WIDTH (RL_DQ_WIDTH)
   ) 
   u_rd_mdfy_wr ( 
      // Global Ports
      .aclk       ( aclk ),
      .aresetn    ( aresetn ),

      // Master interface
	  .app_en       ( app_en ),
	  .app_cmd      ( app_cmd ),
	  .app_addr     ( app_addr ),
	  .app_rdy      ( app_rdy ),
	  .app_wdf_wren ( app_wdf_wren ),
	  .app_wdf_data ( app_wdf_data ),
	  .app_wdf_mask ( app_wdf_mask ), 
	  .app_wdf_rdy  ( app_wdf_rdy ),
	  .app_rd_valid ( app_rd_valid ),
	  .app_rd_data  ( app_rd_data ), 	
  
      // Slave interface
	  .apCmd         ( apCmd ),
	  .apAddr        ( apAddr ),
	  .apValid       ( apValid ),
	  .rlafFull      ( rlafFull ),
	  .apWriteData   ( apWriteData ),
	  .apWriteDValid ( apWriteDValid ),
	  .rlWdfFull     ( rlWdfFull ),
      .rldReadData   ( rldReadData ),
	  .rldReadDataValid ( rldReadDataValid )   
   );

   // RLDRAM-2 (A) Controller and User Application			     
   rld_mem_interface_top  #(
      .SIMULATION_ONLY    ( SIMULATION_ONLY ),     // if set, it shortens the wait time
      .RL_DQ_WIDTH        ( RL_DQ_WIDTH ),
      .DEV_DQ_WIDTH       ( DEV_DQ_WIDTH ),        // data width of the memory device
	  .NUM_OF_DEVS        ( NUM_OF_DEVS ),
	  .NUM_OF_DKS         ( NUM_OF_DKS ),
      .DEV_AD_WIDTH       ( DEV_AD_WIDTH ),        // address width of the memory device
      .DEV_BA_WIDTH       ( DEV_BA_WIDTH ),        // bank address width of the memory device
	  .APP_AD_WIDTH       ( APP_AD_WIDTH ),
      .DUPLICATE_CONTROLS ( DUPLICATE_CONTROLS ),  // Duplicate the ports for A, BA, WE# and REF#
      .RL_CK_PERIOD         ( RL_CK_PERIOD ),      // CK clock period of the RLDRAM in ps
      // MRS (Mode Register Set command) parameters   
      .RL_MRS_CONF            ( RL_MRS_CONF ),             // 3'b001: mode1;  3'b010: mode2;  3'b011: mode3
      .RL_MRS_BURST_LENGTH    ( RL_MRS_BURST_LENGTH ),     // 2'b00: BL2;  2'b01: BL4;  2'b10: BL8
      .RL_MRS_ADDR_MUX        ( RL_MRS_ADDR_MUX ),         // 1'b0: non-muxed addr;  1'b1: muxed addr
      .RL_MRS_DLL_RESET       ( RL_MRS_DLL_RESET ),        //
      .RL_MRS_IMPEDANCE_MATCH ( RL_MRS_IMPEDANCE_MATCH ),  // internal 50ohms output buffer impedance
      .RL_MRS_ODT             ( RL_MRS_ODT ),              // 1'b0: disable term;  1'b1: enable term
      // specific to FPGA/memory devices and capture method
      .RL_IO_TYPE     ( RL_IO_TYPE ),       // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
      .DEVICE_ARCH    ( DEVICE_ARCH ),      // Virtex4=2'b00  Virtex5=2'b01
      .CAPTURE_METHOD ( CAPTURE_METHOD ),    // Direct Clocking=2'b00  SerDes=2'b01
      .CAL_ADDRESS    ( CAL_ADDRESS )
   )
   u_rld_mem_interface_top  (
      // globals
      .sysReset ( aresetn ),
      .sysClk_p ( aclk  ),
      .refClk_p ( aclk  ),
     
      // RLDRAM interface signals
      .RLD2_CK_P  ( RLD2_CK_P   ),
      .RLD2_CK_N  ( RLD2_CK_N ),      
      .RLD2_CS_N  ( RLD2_CS_N  ),
      .RLD2_REF_N ( RLD2_REF_N ),
      .RLD2_WE_N  ( RLD2_WE_N  ),      
      .RLD2_A     ( RLD2_A  ),
      .RLD2_BA    ( RLD2_BA ),
      .RLD2_DM    ( RLD2_DM ),      
      .RLD2_QK_P  ( RLD2_QK_P ),
      .RLD2_QK_N  ( RLD2_QK_N ),      
      .RLD2_DK_P  ( RLD2_DK_P ),
      .RLD2_DK_N  ( RLD2_DK_N ),      
      .RLD2_QVLD  ( RLD2_QVLD ),      
      .RLD2_DQ    ( {weak_gnd[7], RLD2_DQ[63:56],
					 weak_gnd[6], RLD2_DQ[55:48],
					 weak_gnd[5], RLD2_DQ[47:40],
					 weak_gnd[4], RLD2_DQ[39:32],
					 weak_gnd[3], RLD2_DQ[31:24],
					 weak_gnd[2], RLD2_DQ[23:16],
					 weak_gnd[1], RLD2_DQ[15:8],
					 weak_gnd[0], RLD2_DQ[7:0]} ),
	  
	  // application interface signals
	  
	  .apAddr            ( {1'b0, apCmd[0], 1'b0, apAddr} ),
      .apValid           ( apValid ),
      .rlafFull          ( rlafFull ),
      
	  .rldReadData       ( rldReadData ),
      .rldReadDataValid  ( rldReadDataValid ),
      
	  .apWriteDM         ( 4'b0 ),
      .apWriteData       ( apWriteData ),
      .apWriteDValid     ( apWriteDValid ),
      .rlWdfFull         ( rlWdfFull ),   
	  
	  .Init_Done         ( init_complete ),
	  .issueCalibration  ( 1'b0 )
   );
   
endmodule 
