/////////////////
// Aurora Interface for Samtec Connector Test
//
// James Hongyi Zeng (hyzeng_at_stanford.edu)
// 9/22/2010
/////////////////

module aurora_if
(
    // Clocks
    input              aurora_clk_0_P,
    input              aurora_clk_0_N,
    
    input              aurora_clk_1_P,
    input              aurora_clk_1_N,
    
    input              RESET,
    input              INIT_CLK,
    input              GT_RESET_IN,
    
    output  [0:7]      ERR_COUNT_0,
    output  [0:7]      ERR_COUNT_1,
    
    output             CHANNEL_UP_0,
    output             CHANNEL_UP_1,
    
    input   [0:9]      RXP_0,
    input   [0:9]      RXN_0,
    output  [0:9]      TXP_0,
    output  [0:9]      TXN_0,
    
    input   [0:9]      RXP_1,
    input   [0:9]      RXN_1,
    output  [0:9]      TXP_1,
    output  [0:9]      TXN_1,
    
    output             locked    
);

    wire locked_0;
    wire locked_1;
    
    assign locked = locked_0 & locked_1;
    
    aurora_example_design aurora_0 (
        .RESET(RESET),
        .INIT_CLK(INIT_CLK),
        .GT_RESET_IN(GT_RESET_IN),
        
        .RXP(RXP_0),
        .RXN(RXN_0),
        .TXP(TXP_0),
        .TXN(TXN_0),
        
        .GTXD1_P(aurora_clk_0_P),
        .GTXD1_N(aurora_clk_0_N),
        
        .ERR_COUNT(ERR_COUNT_0),
        .CHANNEL_UP(CHANNEL_UP_0),
        
        .locked(locked_0)
    );
   
    aurora_example_design aurora_1 (
        .RESET(RESET),
        .INIT_CLK(INIT_CLK),
        .GT_RESET_IN(GT_RESET_IN),
        
        .RXP(RXP_1),
        .RXN(RXN_1),
        .TXP(TXP_1),
        .TXN(TXN_1),
        
        .GTXD1_P(aurora_clk_1_P),
        .GTXD1_N(aurora_clk_1_N),
        
        .ERR_COUNT(ERR_COUNT_1),
        .CHANNEL_UP(CHANNEL_UP_1),
        
        .locked(locked_1)
    );
endmodule
    
       
