################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Library:
#        hw/std/pcores/nf10_1g_interface_v1_10_a
#
#  Author:
#        Adam Covington
#
#  Description:
#        make install : Copy Xilinx files into NetFPGA-10G library
#
#        For more information about how Xilinx EDK works, please visit
#        http://www.xilinx.com/support/documentation/dt_edk.htm
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
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
