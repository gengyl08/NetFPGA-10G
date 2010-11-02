//
// XAUI with packet checker and generator
// 
// James Hongyi Zeng (hyzeng_at_stanford.edu)
// May 27, 2010
//

module xaui_with_checker 
#( parameter REVERSE_LANES = 0)
  (
   reset,
   refclk,
   xaui_tx_l0_p,
   xaui_tx_l0_n,
   xaui_tx_l1_p,
   xaui_tx_l1_n,
   xaui_tx_l2_p,
   xaui_tx_l2_n,
   xaui_tx_l3_p,
   xaui_tx_l3_n,
   xaui_rx_l0_p,
   xaui_rx_l0_n,
   xaui_rx_l1_p,
   xaui_rx_l1_n,
   xaui_rx_l2_p,
   xaui_rx_l2_n,
   xaui_rx_l3_p,
   xaui_rx_l3_n,
   
   dclk,
   clk156,
   
   rx_count,
   err_count,
   tx_count,
   init_done,
   
   link_up,
   tx_local_fault,
   rx_local_fault,
   
   xgmii_txd,
   xgmii_txc,
   xgmii_rxd,
   xgmii_rxc,
   xgmii_gen_reset
);


   // Part I: XAUI in/out
   // Port declarations
   input           reset;
   input           refclk;
   output          xaui_tx_l0_p;
   output          xaui_tx_l0_n;
   output          xaui_tx_l1_p;
   output          xaui_tx_l1_n;
   output          xaui_tx_l2_p;
   output          xaui_tx_l2_n;
   output          xaui_tx_l3_p;
   output          xaui_tx_l3_n;
   input           xaui_rx_l0_p;
   input           xaui_rx_l0_n;
   input           xaui_rx_l1_p;
   input           xaui_rx_l1_n;
   input           xaui_rx_l2_p;
   input           xaui_rx_l2_n;
   input           xaui_rx_l3_p;
   input           xaui_rx_l3_n;
   
   output[15:0]    rx_count;
   output[15:0]    tx_count;
   output[15:0]    err_count;
   input           init_done;
   
   output          link_up;
   output          tx_local_fault;
   output          rx_local_fault;
   input           xgmii_gen_reset;
   // The following should be fed into ChipScope
   output 	 clk156;
   wire		 clk156_dcm_lock;
   
   reg            reset_link;
   reg            reset_local_fault;
   wire [3 : 0]   signal_detect = 4'b1111;
   wire           align_status;
   wire [3 : 0]   sync_status;
   wire           mgt_tx_ready;
   wire [6 : 0]   configuration_vector = {3'b0, reset_link, reset_local_fault, 2'b0};
   wire [7 : 0]   status_vector;
   input	      dclk;
   
   output [63 : 0] xgmii_txd;
   output [7 : 0]  xgmii_txc;
   output [63 : 0] xgmii_rxd;
   output [7 : 0]  xgmii_rxc;   
   
   assign link_up = status_vector[7];
   assign tx_local_fault = status_vector[0];
   assign rx_local_fault = status_vector[1];
   
   reg [1:0] count;
   always @(posedge clk156) begin
       if(reset) begin
           count <= 0;
           reset_link <= 0;
           reset_local_fault <= 0;
       end
       else begin
           count <= count + 1'b1;
           if(count == 2'b11) begin
               reset_link <= ~reset_link;
               reset_local_fault <= ~reset_local_fault;
               count <= 0;
           end
       end
   end

   
   xaui_example_design
   #(.REVERSE_LANES(REVERSE_LANES))
     xaui_example_design
     (
       .reset(reset),
       .dclk(dclk),
       .refclk(refclk),
       .xgmii_txd(xgmii_txd),
       .xgmii_txc(xgmii_txc),
       .xgmii_rxd(xgmii_rxd),
       .xgmii_rxc(xgmii_rxc),
       .xaui_tx_l0_p(xaui_tx_l0_p),
       .xaui_tx_l0_n(xaui_tx_l0_n),
       .xaui_tx_l1_p(xaui_tx_l1_p),
       .xaui_tx_l1_n(xaui_tx_l1_n),
       .xaui_tx_l2_p(xaui_tx_l2_p),
       .xaui_tx_l2_n(xaui_tx_l2_n),
       .xaui_tx_l3_p(xaui_tx_l3_p),
       .xaui_tx_l3_n(xaui_tx_l3_n),
       .xaui_rx_l0_p(xaui_rx_l0_p),
       .xaui_rx_l0_n(xaui_rx_l0_n),
       .xaui_rx_l1_p(xaui_rx_l1_p),
       .xaui_rx_l1_n(xaui_rx_l1_n),
       .xaui_rx_l2_p(xaui_rx_l2_p),
       .xaui_rx_l2_n(xaui_rx_l2_n),
       .xaui_rx_l3_p(xaui_rx_l3_p),
       .xaui_rx_l3_n(xaui_rx_l3_n),
       .signal_detect(signal_detect),
       .align_status(align_status),
       .sync_status(sync_status),
       .mgt_tx_ready(mgt_tx_ready),
       .configuration_vector(configuration_vector),
       .status_vector(status_vector),
       .clk156(clk156),
       .clk156_dcm_lock(clk156_dcm_lock)
  );

  reg [7:0] reset_count;
  reg reset156, reset156_r1, reset156_r2;
  // reset logic
  always @(posedge clk156)
  begin
    if (status_vector != 8'b11111100 || ~init_done)begin
        reset_count <= 8'b0;
        reset156    <= 1'b1;
    end
    else begin
        if(&reset_count) begin
            reset156 <= 1'b0;
        end
        else
            reset_count <= reset_count + 1'b1;
    end
  end
      
  xgmii_checker xgmii_checker
  (
       .clk(clk156),
       .reset(xgmii_gen_reset),
       .rxd(xgmii_rxd),
       .rxc(xgmii_rxc),
       .rx_count(rx_count),
       .err_count(err_count)
  );
  
  xgmii_generator xgmii_generator
  (
       .clk(clk156),
       .reset(xgmii_gen_reset),
       .rx_local_fault(rx_local_fault),
       .tx_local_fault(tx_local_fault),
       .link_up(link_up),
       .txd(xgmii_txd),
       .txc(xgmii_txc),
       .tx_count(tx_count)
  );
  
endmodule


