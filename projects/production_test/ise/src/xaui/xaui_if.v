//
// XAUI Stress Test
//
// Top level module
// 
// James Hongyi Zeng (hyzeng_at_stanford.edu)
// May 27, 2010
//

module xaui_if
  (
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
    
    input         dclk,

    output [15:0] rx_count_0,
    output [15:0] tx_count_0,
    output [15:0] err_count_0,

    output [15:0] rx_count_1,
    output [15:0] tx_count_1,
    output [15:0] err_count_1,

    output [15:0] rx_count_2,
    output [15:0] tx_count_2,
    output [15:0] err_count_2,

	output [15:0] rx_count_3,
    output [15:0] tx_count_3,
    output [15:0] err_count_3,	

    output [3:0] link_status,	 
    output           clk156,
    
    input xgmii_gen_reset,
    input xaui_reset
);

    wire           refclk_ABC;
    wire           refclk_D;
    wire           init_done = 1'b1;

    
    // Differential Clock Module
    IBUFDS refclk_ABC_ibufds(
      .I(refclk_ABC_p),
      .IB(refclk_ABC_n),
      .O(refclk_ABC));

    // Differential Clock Module
    IBUFDS refclk_D_ibufds(
      .I(refclk_D_p),
      .IB(refclk_D_n),
      .O(refclk_D));

    // XAUI 0
    xaui_with_checker
    #(.REVERSE_LANES (1))
     xaui_0
    (
      .reset(xaui_reset),
      .refclk(refclk_ABC),
      .xaui_tx_l0_p(xaui_0_tx_l0_p),
      .xaui_tx_l0_n(xaui_0_tx_l0_n),
      .xaui_tx_l1_p(xaui_0_tx_l1_p),
      .xaui_tx_l1_n(xaui_0_tx_l1_n),
      .xaui_tx_l2_p(xaui_0_tx_l2_p),
      .xaui_tx_l2_n(xaui_0_tx_l2_n),
      .xaui_tx_l3_p(xaui_0_tx_l3_p),
      .xaui_tx_l3_n(xaui_0_tx_l3_n),
      .xaui_rx_l0_p(xaui_0_rx_l0_p),
      .xaui_rx_l0_n(xaui_0_rx_l0_n),
      .xaui_rx_l1_p(xaui_0_rx_l1_p),
      .xaui_rx_l1_n(xaui_0_rx_l1_n),
      .xaui_rx_l2_p(xaui_0_rx_l2_p),
      .xaui_rx_l2_n(xaui_0_rx_l2_n),
      .xaui_rx_l3_p(xaui_0_rx_l3_p),
      .xaui_rx_l3_n(xaui_0_rx_l3_n),
   
      .dclk(dclk),
      .clk156(clk156),
   
      .rx_count(rx_count_0),
      .err_count(err_count_0),
      .tx_count(tx_count_0),
      .init_done(init_done),
      
      .tx_local_fault(),
      .rx_local_fault(),
      .link_up(link_status[0]),
      
      .xgmii_txd(),
      .xgmii_txc(),
      .xgmii_rxd(),
      .xgmii_rxc(),
	  .xgmii_gen_reset(xgmii_gen_reset) 
    );

    // XAUI 1
    xaui_with_checker
    #(.REVERSE_LANES (1))
     xaui_1
    (
      .reset(xaui_reset),
      .refclk(refclk_ABC),
      .xaui_tx_l0_p(xaui_1_tx_l0_p),
      .xaui_tx_l0_n(xaui_1_tx_l0_n),
      .xaui_tx_l1_p(xaui_1_tx_l1_p),
      .xaui_tx_l1_n(xaui_1_tx_l1_n),
      .xaui_tx_l2_p(xaui_1_tx_l2_p),
      .xaui_tx_l2_n(xaui_1_tx_l2_n),
      .xaui_tx_l3_p(xaui_1_tx_l3_p),
      .xaui_tx_l3_n(xaui_1_tx_l3_n),
      .xaui_rx_l0_p(xaui_1_rx_l0_p),
      .xaui_rx_l0_n(xaui_1_rx_l0_n),
      .xaui_rx_l1_p(xaui_1_rx_l1_p),
      .xaui_rx_l1_n(xaui_1_rx_l1_n),
      .xaui_rx_l2_p(xaui_1_rx_l2_p),
      .xaui_rx_l2_n(xaui_1_rx_l2_n),
      .xaui_rx_l3_p(xaui_1_rx_l3_p),
      .xaui_rx_l3_n(xaui_1_rx_l3_n),
   
      .dclk(dclk),
      .clk156(),
   
      .rx_count(rx_count_1),
      .err_count(err_count_1),
      .tx_count(tx_count_1),
      .init_done(init_done),

      .tx_local_fault(),
      .rx_local_fault(),
      .link_up(link_status[1]),
      
      .xgmii_txd(),
      .xgmii_txc(),
      .xgmii_rxd(),
      .xgmii_rxc(),
	  .xgmii_gen_reset(xgmii_gen_reset)         
    );
    
    // XAUI 2
    xaui_with_checker
    #(.REVERSE_LANES (1))
     xaui_2
    (
      .reset(xaui_reset),
      .refclk(refclk_ABC),
      .xaui_tx_l0_p(xaui_2_tx_l0_p),
      .xaui_tx_l0_n(xaui_2_tx_l0_n),
      .xaui_tx_l1_p(xaui_2_tx_l1_p),
      .xaui_tx_l1_n(xaui_2_tx_l1_n),
      .xaui_tx_l2_p(xaui_2_tx_l2_p),
      .xaui_tx_l2_n(xaui_2_tx_l2_n),
      .xaui_tx_l3_p(xaui_2_tx_l3_p),
      .xaui_tx_l3_n(xaui_2_tx_l3_n),
      .xaui_rx_l0_p(xaui_2_rx_l0_p),
      .xaui_rx_l0_n(xaui_2_rx_l0_n),
      .xaui_rx_l1_p(xaui_2_rx_l1_p),
      .xaui_rx_l1_n(xaui_2_rx_l1_n),
      .xaui_rx_l2_p(xaui_2_rx_l2_p),
      .xaui_rx_l2_n(xaui_2_rx_l2_n),
      .xaui_rx_l3_p(xaui_2_rx_l3_p),
      .xaui_rx_l3_n(xaui_2_rx_l3_n),
   
      .dclk(dclk),
      .clk156(),
   
      .rx_count(rx_count_2),
      .err_count(err_count_2),
      .tx_count(tx_count_2),
      .init_done(init_done),

      .tx_local_fault(),
      .rx_local_fault(),
      .link_up(link_status[2]),
	        
      .xgmii_txd(),
      .xgmii_txc(),
      .xgmii_rxd(),
      .xgmii_rxc(),
	  .xgmii_gen_reset(xgmii_gen_reset)   
    );
    
    // XAUI 3
    xaui_with_checker
    #(.REVERSE_LANES (0))
     xaui_3
    (
      .reset(xaui_reset),
      .refclk(refclk_D),
      .xaui_tx_l0_p(xaui_3_tx_l0_p),
      .xaui_tx_l0_n(xaui_3_tx_l0_n),
      .xaui_tx_l1_p(xaui_3_tx_l1_p),
      .xaui_tx_l1_n(xaui_3_tx_l1_n),
      .xaui_tx_l2_p(xaui_3_tx_l2_p),
      .xaui_tx_l2_n(xaui_3_tx_l2_n),
      .xaui_tx_l3_p(xaui_3_tx_l3_p),
      .xaui_tx_l3_n(xaui_3_tx_l3_n),
      .xaui_rx_l0_p(xaui_3_rx_l0_p),
      .xaui_rx_l0_n(xaui_3_rx_l0_n),
      .xaui_rx_l1_p(xaui_3_rx_l1_p),
      .xaui_rx_l1_n(xaui_3_rx_l1_n),
      .xaui_rx_l2_p(xaui_3_rx_l2_p),
      .xaui_rx_l2_n(xaui_3_rx_l2_n),
      .xaui_rx_l3_p(xaui_3_rx_l3_p),
      .xaui_rx_l3_n(xaui_3_rx_l3_n),
   
      .dclk(dclk),
      .clk156(),
   
      .rx_count(rx_count_3),
      .err_count(err_count_3),
      .tx_count(tx_count_3),
      .init_done(init_done),

      .tx_local_fault(),
      .rx_local_fault(),
      .link_up(link_status[3]),
           
      .xgmii_txd(),
      .xgmii_txc(),
      .xgmii_rxd(),
      .xgmii_rxc(),
      .xgmii_gen_reset(xgmii_gen_reset)      
    );

endmodule
