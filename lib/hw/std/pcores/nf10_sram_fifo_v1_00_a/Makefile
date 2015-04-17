################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Library:
#        hw/std/pcores/nf10_sram_fifo_v1_00_a
#
#  Author:
#        Sam D'Amico
#        James Hongyi Zeng
#
#  Description:
#        make install : Copy Xilinx files into NetFPGA-10G library
#
#        For more information about how Xilinx EDK works, please visit
#        http://www.xilinx.com/support/documentation/dt_edk.htm
#
#  Copyright notice:
#        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland Stanford
#                                 Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This file is free code: you can redistribute it and/or modify it under
#        the terms of the GNU Lesser General Public License version 2.1 as
#        published by the Free Software Foundation.
#
#        This package is distributed in the hope that it will be useful, but
#        WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#        Lesser General Public License for more details.
#
#        You should have received a copy of the GNU Lesser General Public
#        License along with the NetFPGA source package.  If not, see
#        http://www.gnu.org/licenses/.
#
#

COREGEN_DIR:= coregen

install: hdl/verilog/async_fifo.v hdl/verilog/controller/qdrii_top.v

hdl/verilog/async_fifo.v: xco/async_fifo.xco
	@mkdir -p $(COREGEN_DIR);
	@mkdir -p netlist;
	@cd $(COREGEN_DIR) && coregen -b ../xco/async_fifo.xco
	@cp $(COREGEN_DIR)/async_fifo.v hdl/verilog/
	@cp $(COREGEN_DIR)/async_fifo.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx FIFO core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);
	
hdl/verilog/controller/qdrii_top.v: xco/mig.xco xco/mig.prj
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) && coregen -b ../xco/mig.xco
	@cp -r $(COREGEN_DIR)/controller/user_design/rtl hdl/verilog/controller
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx memory controller core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

clean:
	rm -f hdl/verilog/async_fifo.v
	rm -f netlist/async_fifo.ngc
	rm -rf hdl/verilog/controller/
