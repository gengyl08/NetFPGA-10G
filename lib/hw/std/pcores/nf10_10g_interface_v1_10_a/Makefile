################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          pcore Makefile
#
#  Description:
#          make install : Copy Xilinx files into NetFPGA-10G library
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#             
#  Revision history:
#          2011/3/3 hyzeng: Initial check-in
#          2011/6/13 ericklo: Split Xilinx and Stanford .v, add target "clean"
#
################################################################################
COREGEN_DIR:= coregen

install: hdl/verilog/xaui.v hdl/verilog/xgmac.v

hdl/verilog/xaui.v: xco/xaui.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/xaui.xco
	@cp $(COREGEN_DIR)/xaui.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xaui.ngc netlist/
	@cp $(COREGEN_DIR)/xaui/example_design/tx_sync.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xaui/example_design/chanbond_monitor.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xaui/example_design/cc_2b_1skp.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xaui/example_design/xaui_block.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xaui/example_design/rocketio_wrapper.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xaui/example_design/rocketio_wrapper_tile.v hdl/verilog/xilinx
	@patch hdl/verilog/xilinx/cc_2b_1skp.v hdl/verilog/xilinx/cc_2b_1skp.diff
	@patch hdl/verilog/xilinx/xaui_block.v hdl/verilog/xilinx/xaui_block.diff
	@patch hdl/verilog/xilinx/rocketio_wrapper.v hdl/verilog/xilinx/rocketio_wrapper.diff
	@patch hdl/verilog/xilinx/rocketio_wrapper_tile.v hdl/verilog/xilinx/rocketio_wrapper_tile.diff;	
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx XAUI core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/xgmac.v: xco/xgmac.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b ../xco/xgmac.xco
	@cp $(COREGEN_DIR)/xgmac.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/xgmac.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx 10G Ethernet MAC core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

clean:
	@rm -rf $(COREGEN_DIR);
	@rm -rf netlist;
	@rm -rf hdl/verilog/xilinx/*.v
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx files removed.";
	@echo "/////////////////////////////////////////";
