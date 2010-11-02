// fpgaTop_v5.v - ssiegel 2009-03-17

module fpgaTop(
  input  wire        sys0_clkp,     // sys0 Clock +
  input  wire        sys0_clkn,     // sys0 Clock -
  input  wire        pci0_clkp,     // PCIe Clock +
  input  wire        pci0_clkn,     // PCIe Clock -
  input  wire        pci0_reset_n,  // PCIe Reset
  output wire [7:0]  pci_exp_txp,   // PCIe lanes...
  output wire [7:0]  pci_exp_txn,
  input  wire [7:0]  pci_exp_rxp,
  input  wire [7:0]  pci_exp_rxn,
  output wire [2:0]  led,            // LEDs ml555
  input  wire        ppsExtIn,       // PPS in
  output wire        ppsOut          // PPS out
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

  // Example of how to use WCI to perform register reads and writes  
  // submodule appW1
  mkWCIExample4B  appW1(.wci_Clk				(wci_worker_1_CLK),
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
								.wci_SFlag			(wci_worker_1_SFlag) );

// Instance and connect mkFTop...
 mkFTop ftop(
  .sys0_clkp         (sys0_clkp),
  .sys0_clkn         (sys0_clkn),
  .pci0_clkp         (pci0_clkp),
  .pci0_clkn         (pci0_clkn),
  .pci0_reset_n      (pci0_reset_n),
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
  
  .led               (led),
  .gps_ppsSyncIn_x   (ppsExtIn),
  .gps_ppsSyncOut    (ppsOut),
  .trnClk				(wci_worker_1_CLK)
);

endmodule
