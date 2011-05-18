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
#          2011 March mblott: Initial check-in
#          2011 May   ssiegel TUSER added
#
################################################################################
COREGEN_DIR:= coregen

install: netlist/async_fifo_138.ngc netlist/async_fifo_165.ngc netlist/async_fifo_201.ngc netlist/async_fifo_417.ngc

netlist/async_fifo_138.ngc: xco/async_fifo_138.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_138.xco
	@cp $(COREGEN_DIR)/async_fifo_138.ngc netlist/
	@cp $(COREGEN_DIR)/async_fifo_138.vhd hdl/vhdl/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 138 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

netlist/async_fifo_165.ngc: xco/async_fifo_165.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_165.xco
	@cp $(COREGEN_DIR)/async_fifo_165.ngc netlist/
	@cp $(COREGEN_DIR)/async_fifo_165.vhd hdl/vhdl/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 165 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

netlist/async_fifo_201.ngc: xco/async_fifo_201.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_201.xco
	@cp $(COREGEN_DIR)/async_fifo_201.ngc netlist/
	@cp $(COREGEN_DIR)/async_fifo_201.vhd hdl/vhdl/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 201 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

netlist/async_fifo_417.ngc: xco/async_fifo_417.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_417.xco
	@cp $(COREGEN_DIR)/async_fifo_417.ngc netlist/
	@cp $(COREGEN_DIR)/async_fifo_417.vhd hdl/vhdl/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 417 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);
