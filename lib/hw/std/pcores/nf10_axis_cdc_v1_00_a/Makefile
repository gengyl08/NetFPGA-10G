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
#
################################################################################
COREGEN_DIR:= coregen

install: netlist/async_fifo_10.ngc netlist/async_fifo_37.ngc netlist/async_fifo_73.ngc netlist/async_fifo_289.ngc

netlist/async_fifo_10.ngc: xco/async_fifo_10.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_10.xco
	@cp $(COREGEN_DIR)/async_fifo_10.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 10 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

netlist/async_fifo_37.ngc: xco/async_fifo_37.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_37.xco
	@cp $(COREGEN_DIR)/async_fifo_37.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 37 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

netlist/async_fifo_73.ngc: xco/async_fifo_73.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_73.xco
	@cp $(COREGEN_DIR)/async_fifo_73.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 73 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

netlist/async_fifo_289.ngc: xco/async_fifo_289.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo_289.xco
	@cp $(COREGEN_DIR)/async_fifo_289.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx async fifo 289 core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);
