/////////////////////////////
// Top module of XAUI tests
/////////////////////////////
module top#(
    // QDR SRAM public parameters -- adjustable
    parameter SRAM_DATA_WIDTH	= 36,
    parameter SRAM_ADDR_WIDTH	= 19,
    parameter SRAM_CQ_WIDTH	= 1,
    parameter SRAM_CLK_WIDTH	= 1,
    parameter SRAM_BW_WIDTH	= 4,
    parameter SRAM_BURST_LENGTH = 4,
    parameter MASTERBANK_PIN_WIDTH = 3,
    
    // DRAM
    parameter SIMULATION_ONLY = 1'b0,
    parameter RL_DQ_WIDTH     = 72,
    parameter DEV_DQ_WIDTH    = 36,
    parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH,
    parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS,
    parameter DEV_AD_WIDTH    = 20,
    parameter DEV_BA_WIDTH    = 3,
    parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH,
    parameter DUPLICATE_CONTROLS = 1'b0,
    parameter RL_MRS_CONF            = 3'b011,
    parameter RL_MRS_BURST_LENGTH    = 2'b01,
    parameter RL_MRS_ADDR_MUX        = 1'b0,
    parameter RL_MRS_DLL_RESET       = 1'b1,
    parameter RL_MRS_IMPEDANCE_MATCH = 1'b1,
    parameter RL_MRS_ODT             = 1'b0,
    parameter RL_IO_TYPE     = 2'b00,
    parameter DEVICE_ARCH    = 2'b01,
    parameter CAPTURE_METHOD = 2'b01

  )
(
    // General clocks
    input         usr_sprclk_p,
    input         usr_sprclk_n,
    input         usr_25mhz,
    output        led0,
    output reg       led1,
    output reg       led2,

    // XAUI Clock
    // We need 2 clocks because of GTX clock constraints
    input         refclk_ABC_p,
    input         refclk_ABC_n,
    input         refclk_D_p,
    input         refclk_D_n,
    
    // XAUI PHY 0 Interface
    output        xaui_0_tx_l0_p,
    output        xaui_0_tx_l0_n,
    output        xaui_0_tx_l1_p,
    output        xaui_0_tx_l1_n,
    output        xaui_0_tx_l2_p,
    output        xaui_0_tx_l2_n,
    output        xaui_0_tx_l3_p,
    output        xaui_0_tx_l3_n,
    input         xaui_0_rx_l0_p,
    input         xaui_0_rx_l0_n,
    input         xaui_0_rx_l1_p,
    input         xaui_0_rx_l1_n,
    input         xaui_0_rx_l2_p,
    input         xaui_0_rx_l2_n,
    input         xaui_0_rx_l3_p,
    input         xaui_0_rx_l3_n,
    // XAUI PHY 1 Interface
    output        xaui_1_tx_l0_p,
    output        xaui_1_tx_l0_n,
    output        xaui_1_tx_l1_p,
    output        xaui_1_tx_l1_n,
    output        xaui_1_tx_l2_p,
    output        xaui_1_tx_l2_n,
    output        xaui_1_tx_l3_p,
    output        xaui_1_tx_l3_n,
    input         xaui_1_rx_l0_p,
    input         xaui_1_rx_l0_n,
    input         xaui_1_rx_l1_p,
    input         xaui_1_rx_l1_n,
    input         xaui_1_rx_l2_p,
    input         xaui_1_rx_l2_n,
    input         xaui_1_rx_l3_p,
    input         xaui_1_rx_l3_n,
    // XAUI PHY 2 Interface
    output        xaui_2_tx_l0_p,
    output        xaui_2_tx_l0_n,
    output        xaui_2_tx_l1_p,
    output        xaui_2_tx_l1_n,
    output        xaui_2_tx_l2_p,
    output        xaui_2_tx_l2_n,
    output        xaui_2_tx_l3_p,
    output        xaui_2_tx_l3_n,
    input         xaui_2_rx_l0_p,
    input         xaui_2_rx_l0_n,
    input         xaui_2_rx_l1_p,
    input         xaui_2_rx_l1_n,
    input         xaui_2_rx_l2_p,
    input         xaui_2_rx_l2_n,
    input         xaui_2_rx_l3_p,
    input         xaui_2_rx_l3_n,
    // XAUI PHY 3 Interface
    output        xaui_3_tx_l0_p,
    output        xaui_3_tx_l0_n,
    output        xaui_3_tx_l1_p,
    output        xaui_3_tx_l1_n,
    output        xaui_3_tx_l2_p,
    output        xaui_3_tx_l2_n,
    output        xaui_3_tx_l3_p,
    output        xaui_3_tx_l3_n,
    input         xaui_3_rx_l0_p,
    input         xaui_3_rx_l0_n,
    input         xaui_3_rx_l1_p,
    input         xaui_3_rx_l1_n,
    input         xaui_3_rx_l2_p,
    input         xaui_3_rx_l2_n,
    input         xaui_3_rx_l3_p,
    input         xaui_3_rx_l3_n,
    
    // Aurora (Samtec)
    input   [0:9]      aurora_rxp_0,
    input   [0:9]      aurora_rxn_0,
    output  [0:9]      aurora_txp_0,
    output  [0:9]      aurora_txn_0,
    
    input   [0:9]      aurora_rxp_1,
    input   [0:9]      aurora_rxn_1,
    output  [0:9]      aurora_txp_1,
    output  [0:9]      aurora_txn_1,    

    input              aurora_clk_0_P,
    input              aurora_clk_0_N,
    
    input              aurora_clk_1_P,
    input              aurora_clk_1_N,
    
    // CPLD
    input   [1:0]      fpga_rs,
    input   [23:0]     fpga_a,
    input   [15:0]     fpga_dq,
    input              fpga_iol9p,
    input              fpga_fwe,
    input              fpga_foe,
    input              fpga_fcs,    input              fpga_clk,
    input              fpga_rst,
    
    // SRAM
    // QDRII SRAM 0
    output [SRAM_DATA_WIDTH-1:0]            c0_qdr_d,
    input  [SRAM_DATA_WIDTH-1:0]            c0_qdr_q,
    output [SRAM_ADDR_WIDTH-1:0]            c0_qdr_sa,
    output                                  c0_qdr_w_n,
    output                                  c0_qdr_r_n,
    output                                  c0_qdr_dll_off_n,
    output [SRAM_BW_WIDTH-1:0]              c0_qdr_bw_n,
    input  [SRAM_CQ_WIDTH-1:0]              c0_qdr_cq,
    input  [SRAM_CQ_WIDTH-1:0]              c0_qdr_cq_n,
    output [SRAM_CLK_WIDTH-1:0]             c0_qdr_k,
    output [SRAM_CLK_WIDTH-1:0]             c0_qdr_k_n,
    output [SRAM_CLK_WIDTH-1:0]             c0_qdr_c,
    output [SRAM_CLK_WIDTH-1:0]             c0_qdr_c_n,

    // QDRII SRAM 0
    output [SRAM_DATA_WIDTH-1:0]            c1_qdr_d,
    input  [SRAM_DATA_WIDTH-1:0]            c1_qdr_q,
    output [SRAM_ADDR_WIDTH-1:0]            c1_qdr_sa,
    output                                  c1_qdr_w_n,
    output                                  c1_qdr_r_n,
    output                                  c1_qdr_dll_off_n,
    output [SRAM_BW_WIDTH-1:0]              c1_qdr_bw_n,
    input  [SRAM_CQ_WIDTH-1:0]              c1_qdr_cq,
    input  [SRAM_CQ_WIDTH-1:0]              c1_qdr_cq_n,
    output [SRAM_CLK_WIDTH-1:0]             c1_qdr_k,
    output [SRAM_CLK_WIDTH-1:0]             c1_qdr_k_n,
    output [SRAM_CLK_WIDTH-1:0]             c1_qdr_c,
    output [SRAM_CLK_WIDTH-1:0]             c1_qdr_c_n,

    // QDRII SRAM 2
    output [SRAM_DATA_WIDTH-1:0]            c2_qdr_d,
    input  [SRAM_DATA_WIDTH-1:0]            c2_qdr_q,
    output [SRAM_ADDR_WIDTH-1:0]            c2_qdr_sa,
    output                                  c2_qdr_w_n,
    output                                  c2_qdr_r_n,
    output                                  c2_qdr_dll_off_n,
    output [SRAM_BW_WIDTH-1:0]              c2_qdr_bw_n,
    input  [SRAM_CQ_WIDTH-1:0]              c2_qdr_cq,
    input  [SRAM_CQ_WIDTH-1:0]              c2_qdr_cq_n,
    output [SRAM_CLK_WIDTH-1:0]             c2_qdr_k,
    output [SRAM_CLK_WIDTH-1:0]             c2_qdr_k_n,
    output [SRAM_CLK_WIDTH-1:0]             c2_qdr_c,
    output [SRAM_CLK_WIDTH-1:0]             c2_qdr_c_n,

    /*synthesis syn_keep = 1 */(* S = "TRUE" *)
    input [MASTERBANK_PIN_WIDTH-1:0] 	    masterbank_sel_pin,

    // DRAM
   output [NUM_OF_DEVS-1:0]    RLD2_A_CK_P,
   output [NUM_OF_DEVS-1:0]    RLD2_A_CK_N,
   output [NUM_OF_DKS-1:0]     RLD2_A_DK_P,
   output [NUM_OF_DKS-1:0]     RLD2_A_DK_N,
   input  [2*NUM_OF_DEVS-1:0]  RLD2_A_QK_P,
   input  [2*NUM_OF_DEVS-1:0]  RLD2_A_QK_N,
   output [DEV_AD_WIDTH-1:0]   RLD2_A_A,
   output [DEV_BA_WIDTH-1:0]   RLD2_A_BA,
   output [NUM_OF_DEVS-1:0]    RLD2_A_CS_N,
   output                      RLD2_A_WE_N,
   output                      RLD2_A_REF_N,
   inout  [63:0]    	          RLD2_A_DQ,		//By James. Use 64bit data width
   input  [NUM_OF_DEVS-1:0]    RLD2_A_QVLD,
   output [NUM_OF_DEVS-1:0]    RLD2_B_CK_P,
   output [NUM_OF_DEVS-1:0]    RLD2_B_CK_N,
   output [NUM_OF_DKS-1:0]     RLD2_B_DK_P,
   output [NUM_OF_DKS-1:0]     RLD2_B_DK_N,
   input  [2*NUM_OF_DEVS-1:0]  RLD2_B_QK_P,
   input  [2*NUM_OF_DEVS-1:0]  RLD2_B_QK_N,
   output [DEV_AD_WIDTH-1:0]   RLD2_B_A,
   output [DEV_BA_WIDTH-1:0]   RLD2_B_BA,
   output [NUM_OF_DEVS-1:0]    RLD2_B_CS_N,
   output                      RLD2_B_WE_N,
   output                      RLD2_B_REF_N,
   inout  [63:0]    	          RLD2_B_DQ,		//By James. Use 64bit data width
   input  [NUM_OF_DEVS-1:0]    RLD2_B_QVLD,
    
    // PCI Express
    input			pci0_clkp,
    input			pci0_clkn,

    // Tx
    output    [(8 - 1):0]       pci_exp_txp,
    output    [(8 - 1):0]       pci_exp_txn,

    // Rx
    input     [(8 - 1):0]       pci_exp_rxp,
    input     [(8 - 1):0]       pci_exp_rxn,
    
    // System
    input fpga_0_RS232_Uart_1_RX_pin,
    output fpga_0_RS232_Uart_1_TX_pin,
    input fpga_0_RS232_Uart_1_CTS_pin,
    output fpga_0_RS232_Uart_1_RTS_pin,
    output reg fpga_0_Ethernet_MAC_PHY_rst_n_pin,
    output fpga_0_Ethernet_MAC_PHY_MDC_pin,
    inout fpga_0_Ethernet_MAC_PHY_MDIO_pin,
    input fpga_0_clk_1_sys_clk_pin,
    input fpga_0_rst_1_sys_rst_pin
);

  reg        xgmii_gen_reset;
  reg        xaui_reset;
  wire [5:0] link_status;
  wire       clk156;
  
  wire    [15:0] rx_count_0;
  wire    [15:0] tx_count_0;
  wire    [15:0] err_count_0;

  wire    [15:0] rx_count_1;
  wire    [15:0] tx_count_1;
  wire    [15:0] err_count_1;

  wire    [15:0] rx_count_2;
  wire    [15:0] tx_count_2;
  wire    [15:0] err_count_2;
  wire    [15:0] rx_count_3;
  wire    [15:0] tx_count_3;
  wire    [15:0] err_count_3;
  
  reg     [3:0]  xaui_ok;	
  
  wire    [7:0]  aurora_err_count_0;
  wire    [7:0]  aurora_err_count_1;
  wire           aurora_locked;
  
  wire           cpld_pwr_ok;
  wire           cpld_if_ok;
  wire           cpld_flash_ok;
  
  wire           clk25_ok;
  wire           supr_ok;
  wire           supr;
  reg            aurora_ok;
  reg            test_passed;
  
  wire           clk200;
  wire           dram_clk;
  wire [9:0]     dram_status;
  
    /////////////////////////////////////////////////////////
    // SRAM Wires
    /////////////////////////////////////////////////////////
   wire				sram_clk;
   wire				sram_clk270;
   wire				sram_reset;
   wire				sram_dcm_locked;

   wire				  c0_user_rst_0;
   wire				  c1_user_rst_0;
   wire				  c2_user_rst_0;
   wire				  sram_idelay_ctrl_rdy;

   wire                               c0_compare_error;
   wire                               c0_cal_done;

   wire                               c1_compare_error;
   wire                               c1_cal_done;

   wire                               c2_compare_error;
   wire                               c2_cal_done;


   wire                           c0_user_ad_w_n;
   wire                           c0_user_d_w_n;
   wire                           c0_user_r_n;
   wire                           c0_user_wr_full;
   wire                           c0_user_rd_full;
   wire                           c0_user_qr_valid;
   wire [SRAM_DATA_WIDTH-1:0]     c0_user_dwl;
   wire [SRAM_DATA_WIDTH-1:0]     c0_user_dwh;
   wire [SRAM_DATA_WIDTH-1:0]     c0_user_qrl;
   wire [SRAM_DATA_WIDTH-1:0]     c0_user_qrh;
   wire [SRAM_BW_WIDTH-1:0]       c0_user_bwl_n;
   wire [SRAM_BW_WIDTH-1:0]       c0_user_bwh_n;
   wire [SRAM_ADDR_WIDTH-1:0]     c0_user_ad_wr;
   wire [SRAM_ADDR_WIDTH-1:0]     c0_user_ad_rd;
    // controller1 Testbench signals declaration
   wire                           c1_user_ad_w_n;
   wire                           c1_user_d_w_n;
   wire                           c1_user_r_n;
   wire                           c1_user_wr_full;
   wire                           c1_user_rd_full;
   wire                           c1_user_qr_valid;
   wire [SRAM_DATA_WIDTH-1:0]     c1_user_dwl;
   wire [SRAM_DATA_WIDTH-1:0]     c1_user_dwh;
   wire [SRAM_DATA_WIDTH-1:0]     c1_user_qrl;
   wire [SRAM_DATA_WIDTH-1:0]     c1_user_qrh;
   wire [SRAM_BW_WIDTH-1:0]       c1_user_bwl_n;
   wire [SRAM_BW_WIDTH-1:0]       c1_user_bwh_n;
   wire [SRAM_ADDR_WIDTH-1:0]     c1_user_ad_wr;
   wire [SRAM_ADDR_WIDTH-1:0]     c1_user_ad_rd;
    // controller2 Testbench signals declaration
   wire                           c2_user_ad_w_n;
   wire                           c2_user_d_w_n;
   wire                           c2_user_r_n;
   wire                           c2_user_wr_full;
   wire                           c2_user_rd_full;
   wire                           c2_user_qr_valid;
   wire [SRAM_DATA_WIDTH-1:0]     c2_user_dwl;
   wire [SRAM_DATA_WIDTH-1:0]     c2_user_dwh;
   wire [SRAM_DATA_WIDTH-1:0]     c2_user_qrl;
   wire [SRAM_DATA_WIDTH-1:0]     c2_user_qrh;
   wire [SRAM_BW_WIDTH-1:0]       c2_user_bwl_n;
   wire [SRAM_BW_WIDTH-1:0]       c2_user_bwh_n;
   wire [SRAM_ADDR_WIDTH-1:0]     c2_user_ad_wr;
   wire [SRAM_ADDR_WIDTH-1:0]     c2_user_ad_rd;

  wire                        slv_clk;
  reg        [31:0]           slv_reg0;
  reg        [31:0]           slv_reg1;
  reg        [31:0]           slv_reg2;
  reg        [31:0]           slv_reg3;
  reg        [31:0]           slv_reg4;
  reg        [31:0]           slv_reg5;
  reg        [31:0]           slv_reg6;
  reg        [31:0]           slv_reg7;
  reg        [31:0]           slv_reg8;
  reg        [31:0]           slv_reg9;
  reg        [31:0]           slv_reg10;
  reg        [31:0]           slv_reg11;
  reg        [31:0]           slv_reg12;
  wire       [31:0]           slv_reg13;  
    
  reg        [31:0]           slv_reg0_r;
  reg        [31:0]           slv_reg1_r;
  reg        [31:0]           slv_reg2_r;
  reg        [31:0]           slv_reg3_r;
  reg        [31:0]           slv_reg4_r;
  reg        [31:0]           slv_reg5_r;
  reg        [31:0]           slv_reg6_r;
  reg        [31:0]           slv_reg7_r;
  reg        [31:0]           slv_reg8_r;
  reg        [31:0]           slv_reg9_r;
  reg        [31:0]           slv_reg10_r;
  reg        [31:0]           slv_reg11_r;
  reg        [31:0]           slv_reg12_r;
  reg        [31:0]           slv_reg13_r;
  
  wire                        fpga_0_Ethernet_MAC_PHY_MDIO_O_pin;
  wire                        fpga_0_Ethernet_MAC_PHY_MDIO_I_pin;
  wire                        fpga_0_Ethernet_MAC_PHY_MDIO_T_pin;

  xaui_if xaui_if
  (
    // XAUI Clock
    // We need 2 clocks because of GTX clock constraints
    .refclk_ABC_p(refclk_ABC_p),
    .refclk_ABC_n(refclk_ABC_n),
    .refclk_D_p(refclk_D_p),
    .refclk_D_n(refclk_D_n),
       
    // XAUI PHY 0 Interface
    .xaui_0_tx_l0_p      (xaui_0_tx_l0_p),
    .xaui_0_tx_l0_n      (xaui_0_tx_l0_n),
    .xaui_0_tx_l1_p      (xaui_0_tx_l1_p),
    .xaui_0_tx_l1_n      (xaui_0_tx_l1_n),
    .xaui_0_tx_l2_p      (xaui_0_tx_l2_p),
    .xaui_0_tx_l2_n      (xaui_0_tx_l2_n),
    .xaui_0_tx_l3_p      (xaui_0_tx_l3_p),
    .xaui_0_tx_l3_n      (xaui_0_tx_l3_n),
    .xaui_0_rx_l0_p      (xaui_0_rx_l0_p),
    .xaui_0_rx_l0_n      (xaui_0_rx_l0_n),
    .xaui_0_rx_l1_p      (xaui_0_rx_l1_p),
    .xaui_0_rx_l1_n      (xaui_0_rx_l1_n),
    .xaui_0_rx_l2_p      (xaui_0_rx_l2_p),
    .xaui_0_rx_l2_n      (xaui_0_rx_l2_n),
    .xaui_0_rx_l3_p      (xaui_0_rx_l3_p),
    .xaui_0_rx_l3_n      (xaui_0_rx_l3_n),
    // XAUI PHY 1 Interface
    .xaui_1_tx_l0_p      (xaui_1_tx_l0_p),
    .xaui_1_tx_l0_n      (xaui_1_tx_l0_n),
    .xaui_1_tx_l1_p      (xaui_1_tx_l1_p),
    .xaui_1_tx_l1_n      (xaui_1_tx_l1_n),
    .xaui_1_tx_l2_p      (xaui_1_tx_l2_p),
    .xaui_1_tx_l2_n      (xaui_1_tx_l2_n),
    .xaui_1_tx_l3_p      (xaui_1_tx_l3_p),
    .xaui_1_tx_l3_n      (xaui_1_tx_l3_n),
    .xaui_1_rx_l0_p      (xaui_1_rx_l0_p),
    .xaui_1_rx_l0_n      (xaui_1_rx_l0_n),
    .xaui_1_rx_l1_p      (xaui_1_rx_l1_p),
    .xaui_1_rx_l1_n      (xaui_1_rx_l1_n),
    .xaui_1_rx_l2_p      (xaui_1_rx_l2_p),
    .xaui_1_rx_l2_n      (xaui_1_rx_l2_n),
    .xaui_1_rx_l3_p      (xaui_1_rx_l3_p),
    .xaui_1_rx_l3_n      (xaui_1_rx_l3_n),
    // XAUI PHY 2 Interface
    .xaui_2_tx_l0_p      (xaui_2_tx_l0_p),
    .xaui_2_tx_l0_n      (xaui_2_tx_l0_n),
    .xaui_2_tx_l1_p      (xaui_2_tx_l1_p),
    .xaui_2_tx_l1_n      (xaui_2_tx_l1_n),
    .xaui_2_tx_l2_p      (xaui_2_tx_l2_p),
    .xaui_2_tx_l2_n      (xaui_2_tx_l2_n),
    .xaui_2_tx_l3_p      (xaui_2_tx_l3_p),
    .xaui_2_tx_l3_n      (xaui_2_tx_l3_n),
    .xaui_2_rx_l0_p      (xaui_2_rx_l0_p),
    .xaui_2_rx_l0_n      (xaui_2_rx_l0_n),
    .xaui_2_rx_l1_p      (xaui_2_rx_l1_p),
    .xaui_2_rx_l1_n      (xaui_2_rx_l1_n),
    .xaui_2_rx_l2_p      (xaui_2_rx_l2_p),
    .xaui_2_rx_l2_n      (xaui_2_rx_l2_n),
    .xaui_2_rx_l3_p      (xaui_2_rx_l3_p),
    .xaui_2_rx_l3_n      (xaui_2_rx_l3_n),
    // XAUI PHY 3 Interface
    .xaui_3_tx_l0_p      (xaui_3_tx_l0_p),
    .xaui_3_tx_l0_n      (xaui_3_tx_l0_n),
    .xaui_3_tx_l1_p      (xaui_3_tx_l1_p),
    .xaui_3_tx_l1_n      (xaui_3_tx_l1_n),
    .xaui_3_tx_l2_p      (xaui_3_tx_l2_p),
    .xaui_3_tx_l2_n      (xaui_3_tx_l2_n),
    .xaui_3_tx_l3_p      (xaui_3_tx_l3_p),
    .xaui_3_tx_l3_n      (xaui_3_tx_l3_n),
    .xaui_3_rx_l0_p      (xaui_3_rx_l0_p),
    .xaui_3_rx_l0_n      (xaui_3_rx_l0_n),
    .xaui_3_rx_l1_p      (xaui_3_rx_l1_p),
    .xaui_3_rx_l1_n      (xaui_3_rx_l1_n),
    .xaui_3_rx_l2_p      (xaui_3_rx_l2_p),
    .xaui_3_rx_l2_n      (xaui_3_rx_l2_n),
    .xaui_3_rx_l3_p      (xaui_3_rx_l3_p),
    .xaui_3_rx_l3_n      (xaui_3_rx_l3_n),
    
    .dclk (fpga_0_clk_1_sys_clk_pin),

    .rx_count_0(rx_count_0),
    .err_count_0(err_count_0),
    .tx_count_0(tx_count_0),
    
    .rx_count_1(rx_count_1),
    .err_count_1(err_count_1),
    .tx_count_1(tx_count_1),
    
    .rx_count_2(rx_count_2),
    .err_count_2(err_count_2),
    .tx_count_2(tx_count_2),
    
    .rx_count_3(rx_count_3),
    .err_count_3(err_count_3),
    .tx_count_3(tx_count_3),
    
    .xaui_reset(xaui_reset),
    .xgmii_gen_reset(xgmii_gen_reset),

    .link_status(link_status[3:0]),	 
    .clk156(clk156)
    );
    
  aurora_if aurora_if (
    .aurora_clk_0_P(aurora_clk_0_P),
    .aurora_clk_0_N(aurora_clk_0_N),
    
    .aurora_clk_1_P(aurora_clk_1_P),
    .aurora_clk_1_N(aurora_clk_1_N),
    
    .RESET(~xgmii_gen_reset),
    .INIT_CLK(fpga_0_clk_1_sys_clk_pin),
    .GT_RESET_IN(xaui_reset),
    
    .ERR_COUNT_0(aurora_err_count_0),
    .ERR_COUNT_1(aurora_err_count_1),
    
    .CHANNEL_UP_0(link_status[4]),
    .CHANNEL_UP_1(link_status[5]),
    
    .RXP_0(aurora_rxp_0),
    .RXN_0(aurora_rxn_0),
    .TXP_0(aurora_txp_0),
    .TXN_0(aurora_txn_0),
    
    .RXP_1(aurora_rxp_1),
    .RXN_1(aurora_rxn_1),
    .TXP_1(aurora_txp_1),
    .TXN_1(aurora_txn_1),
    
    .locked(aurora_locked)    
  );
  
  cpld_test cpld_test(
       .FPGA_RS(fpga_rs),
       .FPGA_A(fpga_a),
       .FPGA_DQ(fpga_dq),
       .FPGA_IOL9P(fpga_iol9p),
       .FPGA_FWE(fpga_fwe),
       .FPGA_FOE(fpga_foe),
       .FPGA_FCS(fpga_fcs),
       .FPGA_CLK(fpga_clk),
       .FPGA_RST(fpga_rst),
       .CPLD_IF_OK(cpld_if_ok),
       .CPLD_PWR_OK(cpld_pwr_ok),
	   .CPLD_FLASH_OK(cpld_flash_ok)
  ) ;
  
  clk_test clk_test(
       .sysclk(supr),//fpga_0_clk_1_sys_clk_pin),
       .clk25(usr_25mhz),
       .osc1(1'b0),
       .osc2(1'b0),
       .supr(supr),
       .clk25_ok(clk25_ok),
       .osc1_ok(), 
       .osc2_ok(),
       .supr_ok(supr_ok),
       .led_sysclk(led0));
       
  nf10_clock_gen nf10_clock_gen
  (
    // User Clock
	.usr_sprclk_p(usr_sprclk_p),
	.usr_sprclk_n(usr_sprclk_n),

    .clk200(clk200),
    .spr_clk(supr),

    .sram_clk(sram_clk),
    .sram_clk270(sram_clk270),
    .sram_dcm_locked(sram_dcm_locked),
    .sram_reset(),
    .sram_idelay_ctrl_rdy(1'b1),

    .dram_clk(dram_clk),
    .dram_clk90(),
    .dram_dcm_locked(),
    .dram_reset(),
    .dram_idelay_ctrl_rdy(1'b1),
    
    .reset(~fpga_0_rst_1_sys_rst_pin)
  );
  
    //-------------------------------------------------------
  // QDRII SRAM Controller
  //-------------------------------------------------------
   sram_controller_top 
	#(.C0_QDRII_SIM_ONLY( SIMULATION_ONLY ),
	  .C1_QDRII_SIM_ONLY( SIMULATION_ONLY ),
	  .C2_QDRII_SIM_ONLY( SIMULATION_ONLY ))
	sram_controller_top
       (
    .c0_qdr_d                  (c0_qdr_d),
    .c0_qdr_q                  (c0_qdr_q),
    .c0_qdr_sa                 (c0_qdr_sa),
    .c0_qdr_w_n                (c0_qdr_w_n),
    .c0_qdr_r_n                (c0_qdr_r_n),
    .c0_qdr_dll_off_n          (c0_qdr_dll_off_n),
    .c0_qdr_bw_n               (c0_qdr_bw_n),
    .clk0		       (sram_clk),
    .clk270		       (sram_clk270),
    .clk200		       (clk200),
    .locked		       (sram_dcm_locked),	
    .sys_rst_n                 (~sram_reset),
    .c0_cal_done               (c0_cal_done),
    .c0_user_ad_w_n            (c0_user_ad_w_n),
    .c0_user_d_w_n             (c0_user_d_w_n),
    .c0_user_r_n               (c0_user_r_n),
    .c0_user_wr_full           (c0_user_wr_full),
    .c0_user_rd_full           (c0_user_rd_full),
    .c0_user_qr_valid          (c0_user_qr_valid),
    .c0_user_dwl               (c0_user_dwl),
    .c0_user_dwh               (c0_user_dwh),
    .c0_user_qrl               (c0_user_qrl),
    .c0_user_qrh               (c0_user_qrh),
    .c0_user_bwl_n             (c0_user_bwl_n),
    .c0_user_bwh_n             (c0_user_bwh_n),
    .c0_user_ad_wr             (c0_user_ad_wr),
    .c0_user_ad_rd             (c0_user_ad_rd),
    .c0_qdr_cq                 (c0_qdr_cq),
    .c0_qdr_cq_n               (c0_qdr_cq_n),
    .c0_qdr_k                  (c0_qdr_k),
    .c0_qdr_k_n                (c0_qdr_k_n),
    .c0_qdr_c                  (c0_qdr_c),
    .c0_qdr_c_n                (c0_qdr_c_n),
    .c1_qdr_d                  (c1_qdr_d),
    .c1_qdr_q                  (c1_qdr_q),
    .c1_qdr_sa                 (c1_qdr_sa),
    .c1_qdr_w_n                (c1_qdr_w_n),
    .c1_qdr_r_n                (c1_qdr_r_n),
    .c1_qdr_dll_off_n          (c1_qdr_dll_off_n),
    .c1_qdr_bw_n               (c1_qdr_bw_n),
    .c1_cal_done               (c1_cal_done),
    .c1_user_ad_w_n            (c1_user_ad_w_n),
    .c1_user_d_w_n             (c1_user_d_w_n),
    .c1_user_r_n               (c1_user_r_n),
    .c1_user_wr_full           (c1_user_wr_full),
    .c1_user_rd_full           (c1_user_rd_full),
    .c1_user_qr_valid          (c1_user_qr_valid),
    .c1_user_dwl               (c1_user_dwl),
    .c1_user_dwh               (c1_user_dwh),
    .c1_user_qrl               (c1_user_qrl),
    .c1_user_qrh               (c1_user_qrh),
    .c1_user_bwl_n             (c1_user_bwl_n),
    .c1_user_bwh_n             (c1_user_bwh_n),
    .c1_user_ad_wr             (c1_user_ad_wr),
    .c1_user_ad_rd             (c1_user_ad_rd),
    .c1_qdr_cq                 (c1_qdr_cq),
    .c1_qdr_cq_n               (c1_qdr_cq_n),
    .c1_qdr_k                  (c1_qdr_k),
    .c1_qdr_k_n                (c1_qdr_k_n),
    .c1_qdr_c                  (c1_qdr_c),
    .c1_qdr_c_n                (c1_qdr_c_n),
    .c2_qdr_d                  (c2_qdr_d),
    .c2_qdr_q                  (c2_qdr_q),
    .c2_qdr_sa                 (c2_qdr_sa),
    .c2_qdr_w_n                (c2_qdr_w_n),
    .c2_qdr_r_n                (c2_qdr_r_n),
    .c2_qdr_dll_off_n          (c2_qdr_dll_off_n),
    .c2_qdr_bw_n               (c2_qdr_bw_n),
    .masterbank_sel_pin        (masterbank_sel_pin),
    .c2_cal_done               (c2_cal_done),
    .c2_user_ad_w_n            (c2_user_ad_w_n),
    .c2_user_d_w_n             (c2_user_d_w_n),
    .c2_user_r_n               (c2_user_r_n),
    .c2_user_wr_full           (c2_user_wr_full),
    .c2_user_rd_full           (c2_user_rd_full),
    .c2_user_qr_valid          (c2_user_qr_valid),
    .c2_user_dwl               (c2_user_dwl),
    .c2_user_dwh               (c2_user_dwh),
    .c2_user_qrl               (c2_user_qrl),
    .c2_user_qrh               (c2_user_qrh),
    .c2_user_bwl_n             (c2_user_bwl_n),
    .c2_user_bwh_n             (c2_user_bwh_n),
    .c2_user_ad_wr             (c2_user_ad_wr),
    .c2_user_ad_rd             (c2_user_ad_rd),
    .c2_qdr_cq                 (c2_qdr_cq),
    .c2_qdr_cq_n               (c2_qdr_cq_n),
    .c2_qdr_k                  (c2_qdr_k),
    .c2_qdr_k_n                (c2_qdr_k_n),
    .c2_qdr_c                  (c2_qdr_c),
    .c2_qdr_c_n                (c2_qdr_c_n),

    .c0_user_rst_0             (c0_user_rst_0),
    .c1_user_rst_0             (c1_user_rst_0),
    .c2_user_rst_0             (c2_user_rst_0),

    .idelay_ctrl_rdy	       (idelay_ctrl_rdy)
    );


  //-------------------------------------------------------
  // QDRII SRAM Testbench
  //-------------------------------------------------------

qdrii_tb_top #
 (
   .ADDR_WIDTH             (SRAM_ADDR_WIDTH),
   .BW_WIDTH               (SRAM_BW_WIDTH),
   .DATA_WIDTH             (SRAM_DATA_WIDTH),
   .BURST_LENGTH	   (SRAM_BURST_LENGTH)
   )
u_qdrii_tb_top_0
(
   .cal_done               (c0_cal_done),
   .compare_error          (c0_compare_error),
   .user_rst_0             (c0_user_rst_0),
   .clk0                   (sram_clk),
   .user_ad_w_n            (c0_user_ad_w_n),
   .user_d_w_n             (c0_user_d_w_n),
   .user_r_n               (c0_user_r_n),
   .user_wr_full           (c0_user_wr_full),
   .user_rd_full           (c0_user_rd_full),
   .user_qr_valid          (c0_user_qr_valid),
   .user_dwl               (c0_user_dwl),
   .user_dwh               (c0_user_dwh),
   .user_qrl               (c0_user_qrl),
   .user_qrh               (c0_user_qrh),
   .user_bwl_n             (c0_user_bwl_n),
   .user_bwh_n             (c0_user_bwh_n),
   .user_ad_wr             (c0_user_ad_wr),
   .user_ad_rd             (c0_user_ad_rd)
   );

qdrii_tb_top #
 (
   .ADDR_WIDTH             (SRAM_ADDR_WIDTH),
   .BW_WIDTH               (SRAM_BW_WIDTH),
   .DATA_WIDTH             (SRAM_DATA_WIDTH),
   .BURST_LENGTH	   (SRAM_BURST_LENGTH)
   )
u_qdrii_tb_top_1
(
   .cal_done               (c1_cal_done),
   .compare_error          (c1_compare_error),
   .user_rst_0             (c1_user_rst_0),
   .clk0                   (sram_clk),
   .user_ad_w_n            (c1_user_ad_w_n),
   .user_d_w_n             (c1_user_d_w_n),
   .user_r_n               (c1_user_r_n),
   .user_wr_full           (c1_user_wr_full),
   .user_rd_full           (c1_user_rd_full),
   .user_qr_valid          (c1_user_qr_valid),
   .user_dwl               (c1_user_dwl),
   .user_dwh               (c1_user_dwh),
   .user_qrl               (c1_user_qrl),
   .user_qrh               (c1_user_qrh),
   .user_bwl_n             (c1_user_bwl_n),
   .user_bwh_n             (c1_user_bwh_n),
   .user_ad_wr             (c1_user_ad_wr),
   .user_ad_rd             (c1_user_ad_rd)
   );

qdrii_tb_top #
 (
   .ADDR_WIDTH             (SRAM_ADDR_WIDTH),
   .BW_WIDTH               (SRAM_BW_WIDTH),
   .DATA_WIDTH             (SRAM_DATA_WIDTH),
   .BURST_LENGTH	   (SRAM_BURST_LENGTH)
   )
u_qdrii_tb_top_2
(
   .cal_done               (c2_cal_done),
   .compare_error          (c2_compare_error),
   .user_rst_0             (c2_user_rst_0),
   .clk0                   (sram_clk),
   .user_ad_w_n            (c2_user_ad_w_n),
   .user_d_w_n             (c2_user_d_w_n),
   .user_r_n               (c2_user_r_n),
   .user_wr_full           (c2_user_wr_full),
   .user_rd_full           (c2_user_rd_full),
   .user_qr_valid          (c2_user_qr_valid),
   .user_dwl               (c2_user_dwl),
   .user_dwh               (c2_user_dwh),
   .user_qrl               (c2_user_qrl),
   .user_qrh               (c2_user_qrh),
   .user_bwl_n             (c2_user_bwl_n),
   .user_bwh_n             (c2_user_bwh_n),
   .user_ad_wr             (c2_user_ad_wr),
   .user_ad_rd             (c2_user_ad_rd)
   );
   
   rldram_if rldram_if  (
   .IDLY_CLK(clk200),
   .RLDRAM_CLK(dram_clk),
   .PB01(fpga_0_rst_1_sys_rst_pin),
   .status(dram_status),
   .RLD2_A_CK_P(RLD2_A_CK_P),
   .RLD2_A_CK_N(RLD2_A_CK_N),
   .RLD2_A_DK_P(RLD2_A_DK_P),
   .RLD2_A_DK_N(RLD2_A_DK_N),
   .RLD2_A_QK_P(RLD2_A_QK_P),
   .RLD2_A_QK_N(RLD2_A_QK_N),
   .RLD2_A_A(RLD2_A_A),
   .RLD2_A_BA(RLD2_A_BA),
   .RLD2_A_CS_N(RLD2_A_CS_N),
   .RLD2_A_WE_N(RLD2_A_WE_N),
   .RLD2_A_REF_N(RLD2_A_REF_N),
   .RLD2_A_DQ(RLD2_A_DQ),
   .RLD2_A_QVLD(RLD2_A_QVLD),
   .RLD2_B_CK_P(RLD2_B_CK_P),
   .RLD2_B_CK_N(RLD2_B_CK_N),
   .RLD2_B_DK_P(RLD2_B_DK_P),
   .RLD2_B_DK_N(RLD2_B_DK_N),
   .RLD2_B_QK_P(RLD2_B_QK_P),
   .RLD2_B_QK_N(RLD2_B_QK_N),
   .RLD2_B_A(RLD2_B_A),
   .RLD2_B_BA(RLD2_B_BA),
   .RLD2_B_CS_N(RLD2_B_CS_N),
   .RLD2_B_WE_N(RLD2_B_WE_N),
   .RLD2_B_REF_N(RLD2_B_REF_N),
   .RLD2_B_DQ(RLD2_B_DQ),
   .RLD2_B_QVLD(RLD2_B_QVLD)
);


  /* Pulled out WCI signals going to/from worker 1 */
  /* Going to worker 1: */
  wire [ 0:0]	wci_worker_1_RST_N;
  wire [ 0:0]	wci_worker_1_CLK;
  wire [19:0]	wci_worker_1_MAddr;
  wire [ 0:0]	wci_worker_1_MAddrSpace;
  wire [ 3:0]	wci_worker_1_MByteEn;
  wire [ 2:0]	wci_worker_1_MCmd;
  wire [31:0]	wci_worker_1_MData;
  wire [ 1:0]	wci_worker_1_MFlag;
			
  /* Coming from worker 1: */
  wire [ 0:0]	wci_worker_1_SThreadBusy;
  wire [ 1:0]	wci_worker_1_SFlag;
  wire [31:0]	wci_worker_1_SData;
  wire [ 1:0]	wci_worker_1_SResp;



// Instance and connect mkFTop...
 mkFTop ftop(
  .sys0_clkp         (clk200),
  .sys0_clkn         (1'b0),
  .pci0_clkp         (pci0_clkp),
  .pci0_clkn         (pci0_clkn),
  .pci0_reset_n      (fpga_0_rst_1_sys_rst_pin),
  .pcie_rxp_i        (pci_exp_rxp),
  .pcie_rxn_i        (pci_exp_rxn),
  .pcie_txp          (pci_exp_txp),
  .pcie_txn          (pci_exp_txn),
  
  /* Pulled out WCI signals going to/from worker 1 */
  /* Outputs going to worker 1: */
  .wci_worker_1_RST_N(wci_worker_1_RST_N),
  .wci_worker_1_MAddr(wci_worker_1_MAddr),
  .wci_worker_1_MAddrSpace(wci_worker_1_MAddrSpace),
  .wci_worker_1_MByteEn(wci_worker_1_MByteEn),
  .wci_worker_1_MCmd(wci_worker_1_MCmd),
  .wci_worker_1_MData(wci_worker_1_MData),
  .wci_worker_1_MFlag(wci_worker_1_MFlag),
  /* Inputs coming from worker 1: */
  .wci_worker_1_SThreadBusy(wci_worker_1_SThreadBusy),
  .wci_worker_1_SFlag(wci_worker_1_SFlag),
  .wci_worker_1_SData(wci_worker_1_SData),
  .wci_worker_1_SResp(wci_worker_1_SResp),
  
  .led               (),
  .gps_ppsSyncIn_x   (1'b0),
  .gps_ppsSyncOut    (),
  .trnClk				(wci_worker_1_CLK)
);
  // Instance and connect mkFTop...

    
  always @( posedge slv_clk ) begin
      slv_reg0 <= slv_reg0_r; slv_reg0_r <= {tx_count_0 , rx_count_0};
      slv_reg1 <= slv_reg1_r; slv_reg1_r <= {tx_count_1 , rx_count_1};
      slv_reg2 <= slv_reg2_r; slv_reg2_r <= {tx_count_2 , rx_count_2};      
      slv_reg3 <= slv_reg3_r; slv_reg3_r <= {tx_count_3 , rx_count_3};
      
      slv_reg4 <= slv_reg4_r; slv_reg4_r <= {err_count_1 , err_count_0};
      slv_reg5 <= slv_reg5_r; slv_reg5_r <= {err_count_3 , err_count_2};   
      slv_reg6 <= slv_reg6_r; slv_reg6_r <= {8'b0, aurora_err_count_1 , 8'b0, aurora_err_count_0};  
      slv_reg7 <= slv_reg7_r; slv_reg7_r <= {4'b0, aurora_locked,
          dram_status,
          c2_compare_error, c2_cal_done, c1_compare_error, c1_cal_done, c0_compare_error, c0_cal_done, 
          supr_ok, clk25_ok, cpld_flash_ok, cpld_if_ok, cpld_pwr_ok, link_status};
  end
  

  always @(posedge clk156) begin
      slv_reg13_r <= slv_reg13;
      xaui_ok <= slv_reg13_r[8:5];
      led2 <= slv_reg13_r[4];
      led1 <= slv_reg13_r[3];
      xgmii_gen_reset <= slv_reg13_r[2];
      xaui_reset  <= slv_reg13_r[1];
      fpga_0_Ethernet_MAC_PHY_rst_n_pin <= ~slv_reg13_r[0];
  end
  
  // synthesis attribute ASYNC_REG of slv_reg0_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg1_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg2_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg3_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg4_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg5_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg6_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg7_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg8_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg9_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg10_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg11_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg12_r is TRUE
  // synthesis attribute ASYNC_REG of slv_reg13_r is TRUE

  // Example of how to use WCI to perform register reads and writes  
  // submodule appW1
  mkWCIExample4B  appW1
                               (.wci_Clk			(wci_worker_1_CLK),
								.wci_MReset_n		(wci_worker_1_RST_N),
								.wci_MAddr			(wci_worker_1_MAddr),
								.wci_MAddrSpace	(wci_worker_1_MAddrSpace),
								.wci_MByteEn		(wci_worker_1_MByteEn),
								.wci_MCmd			(wci_worker_1_MCmd),
								.wci_MData			(wci_worker_1_MData),
								.wci_MFlag			(wci_worker_1_MFlag),
								.wci_SResp			(wci_worker_1_SResp),
								.wci_SData			(wci_worker_1_SData),
								.wci_SThreadBusy	(wci_worker_1_SThreadBusy),
								.wci_SFlag			(wci_worker_1_SFlag),
								
								.hw_version(aurora_locked ? 32'h104 : 32'h100),
								.clk_ok({clk25_ok, 1'b1, supr_ok}),
								.sram_status({c2_compare_error, c2_cal_done, c1_compare_error, c1_cal_done, c0_compare_error, c0_cal_done}),
								.pwr_ok(cpld_pwr_ok),
								.cpld_status({cpld_pwr_ok, cpld_if_ok, cpld_flash_ok}),
								.dram_status(dram_status),
								.xaui_ok_0(xaui_ok[0]),
								.tx_count_0(tx_count_0),
								.rx_count_0(rx_count_0),
								.err_count_0(err_count_0),
								.xaui_ok_1(xaui_ok[1]),
								.tx_count_1(tx_count_1),
								.rx_count_1(rx_count_1),
								.err_count_1(err_count_1),
								.xaui_ok_2(xaui_ok[2]),
								.tx_count_2(tx_count_2),
								.rx_count_2(rx_count_2),
								.err_count_2(err_count_2),
								.xaui_ok_3(xaui_ok[3]),
								.tx_count_3(tx_count_3),
								.rx_count_3(rx_count_3),
								.err_count_3(err_count_3),
								.aurora_err_count_0(aurora_err_count_0),
								.aurora_link_0(link_status[4]),
								.aurora_err_count_1(aurora_err_count_1),
								.aurora_link_1(link_status[5]),
								.led(32'b0)
								);

    // Instantiate the module
    (* BOX_TYPE = "user_black_box" *)
    system microblaze_system (
    .fpga_0_RS232_Uart_1_RX_pin(fpga_0_RS232_Uart_1_RX_pin), 
    .fpga_0_RS232_Uart_1_TX_pin(fpga_0_RS232_Uart_1_TX_pin), 
    .fpga_0_RS232_Uart_1_CTS_pin(fpga_0_RS232_Uart_1_CTS_pin), 
    .fpga_0_RS232_Uart_1_RTS_pin(fpga_0_RS232_Uart_1_RTS_pin), 
    .fpga_0_Ethernet_MAC_PHY_rst_n_pin(), 
    .fpga_0_Ethernet_MAC_PHY_MDC_pin(fpga_0_Ethernet_MAC_PHY_MDC_pin), 
    .fpga_0_MAC_PHY_MDIO_I_pin(fpga_0_Ethernet_MAC_PHY_MDIO_I_pin), 
    .fpga_0_MAC_PHY_MDIO_O_pin(fpga_0_Ethernet_MAC_PHY_MDIO_O_pin), 
    .fpga_0_MAC_PHY_MDIO_T_pin(fpga_0_Ethernet_MAC_PHY_MDIO_T_pin), 
    .fpga_0_clk_1_sys_clk_pin(fpga_0_clk_1_sys_clk_pin), 
    .fpga_0_rst_1_sys_rst_pin(fpga_0_rst_1_sys_rst_pin), 
    .status_slv_clk_pin(slv_clk), 
    .status_slv_reg0_pin(slv_reg0), 
    .status_slv_reg1_pin(slv_reg1), 
    .status_slv_reg2_pin(slv_reg2), 
    .status_slv_reg3_pin(slv_reg3), 
    .status_slv_reg4_pin(slv_reg4), 
    .status_slv_reg5_pin(slv_reg5), 
    .status_slv_reg6_pin(slv_reg6), 
    .status_slv_reg7_pin(slv_reg7), 
    .status_slv_reg13_pin(slv_reg13)
    );
    
    IOBUF IOBUF_inst (
   .O(fpga_0_Ethernet_MAC_PHY_MDIO_I_pin), // Buffer output
   .IO(fpga_0_Ethernet_MAC_PHY_MDIO_pin), // Buffer inout port (connect directly to top-level port)
   .I(fpga_0_Ethernet_MAC_PHY_MDIO_O_pin), // Buffer input
   .T(fpga_0_Ethernet_MAC_PHY_MDIO_T_pin) // 3-state enable input
    );
    
endmodule
