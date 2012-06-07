################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        openflowswitch
#
#  Author:
#        Tatsuya Yabe
#
#  Description:
#        pcore makefile
#
#  Copyright notice:
#        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland
#                                 Stanford Junior University
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

install: hdl/verilog/dp_bram_1024x256.v hdl/verilog/dp_bram_1024x64.v hdl/verilog/dp_bram_32x64.v hdl/verilog/dp_bram_1024x384.v hdl/verilog/dp_bram_32x384.v

hdl/verilog/dp_bram_1024x256.v: xco/dp_bram_1024x256.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b ../xco/dp_bram_1024x256.xco
	@cp $(COREGEN_DIR)/dp_bram_1024x256.v hdl/verilog
	@cp $(COREGEN_DIR)/dp_bram_1024x256.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (1024x256) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_1024x384.v: xco/dp_bram_1024x384.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b ../xco/dp_bram_1024x384.xco
	@cp $(COREGEN_DIR)/dp_bram_1024x384.v hdl/verilog
	@cp $(COREGEN_DIR)/dp_bram_1024x384.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (1024x384) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_1024x64.v: xco/dp_bram_1024x64.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b ../xco/dp_bram_1024x64.xco
	@cp $(COREGEN_DIR)/dp_bram_1024x64.v hdl/verilog
	@cp $(COREGEN_DIR)/dp_bram_1024x64.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (1024x64) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_32x384.v: xco/dp_bram_32x384.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b ../xco/dp_bram_32x384.xco
	@cp $(COREGEN_DIR)/dp_bram_32x384.v hdl/verilog
	@cp $(COREGEN_DIR)/dp_bram_32x384.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (32x384) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_32x64.v: xco/dp_bram_32x64.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b ../xco/dp_bram_32x64.xco
	@cp $(COREGEN_DIR)/dp_bram_32x64.v hdl/verilog
	@cp $(COREGEN_DIR)/dp_bram_32x64.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (32x64) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);
