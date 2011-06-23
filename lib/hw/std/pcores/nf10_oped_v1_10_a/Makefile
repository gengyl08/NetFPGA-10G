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
#
################################################################################
COREGEN_DIR:= coregen

all: hdl/verilog/xilinx/pcie_top.v

hdl/verilog/xilinx/pcie_top.v: xco/endpoint_blk_plus_v1_14.xco hdl/verilog/xilinx/pcie_gtx_wrapper.v.diff hdl/verilog/xilinx/pcie_blk_plus_ll_rx.v.diff
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/endpoint_blk_plus_v1_14.xco
	@cp $(COREGEN_DIR)/endpoint_blk_plus_v1_14/source/*.v hdl/verilog/xilinx/
	@patch hdl/verilog/xilinx/pcie_gtx_wrapper.v hdl/verilog/xilinx/pcie_gtx_wrapper.v.diff
	@patch hdl/verilog/xilinx/pcie_blk_plus_ll_rx.v hdl/verilog/xilinx/pcie_blk_plus_ll_rx.v.diff
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx PCIe core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);
	
clean:
	rm hdl/verilog/xilinx/*.v
