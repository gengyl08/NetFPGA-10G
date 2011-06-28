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

install: hdl/verilog/mac.v

hdl/verilog/mac.v: xco/mac.xco
	@mkdir -p coregen;
	@cd coregen &&	coregen -b ../xco/mac.xco
	@cp $(COREGEN_DIR)/mac/example_design/mac.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/mac/example_design/mac_block.v hdl/verilog/xilinx
	@cp $(COREGEN_DIR)/mac/example_design/physical/* hdl/verilog/xilinx
	@patch hdl/verilog/xilinx/mac_block.v hdl/verilog/xilinx/mac_block.diff
	@patch hdl/verilog/xilinx/gtx_dual_1000X.v hdl/verilog/xilinx/gtx_dual_1000X.diff;		
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx Gigabit Ethernet MAC core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

clean:
	@rm -rf $(COREGEN_DIR);
	@rm -rf hdl/verilog/xilinx/*.v
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx files removed.";
	@echo "/////////////////////////////////////////";
