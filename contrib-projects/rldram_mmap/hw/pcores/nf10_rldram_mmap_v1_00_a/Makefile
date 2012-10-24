################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        rldram_mmap
#
#  Author:
#        Muhammad Shahbaz
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
#        This module was developed by SRI International and the University of
#        Cambridge Computer Laboratory under DARPA/AFRL contract (FA8750-11-C-0249)
#        ("MRC2"), as part of the DARPA MRC research programme.
#
#

COREGEN_DIR:= coregen

install: hdl/verilog/axi hdl/verilog/controller

hdl/verilog/axi: xco/mig_7series_v1_4.xco
	@mkdir -p $(COREGEN_DIR);
	@cp -f xco/* $(COREGEN_DIR);
	@cd $(COREGEN_DIR) &&	coregen -b mig_7series_v1_4.xco -p coregen.cgp;
	@cp -rf $(COREGEN_DIR)/mig_7series_v1_4/user_design/rtl/axi hdl/verilog;
	@patch -d hdl/verilog/axi/ < axi.patch
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx AXI Shim installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/controller: XAPP852
	@cp -f XAPP852/verilog/*.v hdl/verilog/controller;
	@patch -d hdl/verilog/controller/ < controller.patch
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx XAPP852 installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf XAPP852;

clean:
	@rm -rf $(COREGEN_DIR);
	@rm -rf hdl/verilog/axi
	@rm -rf XAPP852;
	@rm -rf hdl/verilog/controller/*.v
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx files removed.";
	@echo "/////////////////////////////////////////";

