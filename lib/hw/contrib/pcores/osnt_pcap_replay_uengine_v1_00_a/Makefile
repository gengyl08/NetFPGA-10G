################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Library:
#        hw/osnt/pcores/osnt_pcap_replay_uengine_v1_00_a
#
#  Author:
#        Sam D'Amico
#        James Hongyi Zeng
#		 Muhammad Shahbaz
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

install: hdl/verilog/controller/qdrii_top.v hdl/verilog/fifo_generator_v8_4_4_to_2_fwft.v hdl/verilog/fifo_generator_v8_4_144_to_288_fwft.v hdl/verilog/fifo_generator_v8_4_9_to_9.v hdl/verilog/fifo_generator_v8_4_288_to_144_fwft.v

hdl/verilog/fifo_generator_v8_4_4_to_2_fwft.v: xco/fifo_generator_v8_4_4_to_2_fwft.xco
	@mkdir -p $(COREGEN_DIR);
	@mkdir -p netlist;
	@cd $(COREGEN_DIR) && coregen -b ../xco/fifo_generator_v8_4_4_to_2_fwft.xco
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_4_to_2_fwft.v hdl/verilog/
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_4_to_2_fwft.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx FIFO core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/fifo_generator_v8_4_144_to_288_fwft.v: xco/fifo_generator_v8_4_144_to_288_fwft.xco
	@mkdir -p $(COREGEN_DIR);
	@mkdir -p netlist;
	@cd $(COREGEN_DIR) && coregen -b ../xco/fifo_generator_v8_4_144_to_288_fwft.xco
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_144_to_288_fwft.v hdl/verilog/
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_144_to_288_fwft.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx FIFO core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/fifo_generator_v8_4_9_to_9.v: xco/fifo_generator_v8_4_9_to_9.xco
	@mkdir -p $(COREGEN_DIR);
	@mkdir -p netlist;
	@cd $(COREGEN_DIR) && coregen -b ../xco/fifo_generator_v8_4_9_to_9.xco
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_9_to_9.v hdl/verilog/
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_9_to_9.ngc netlist/
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx FIFO core installed.";
	@echo "/////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/fifo_generator_v8_4_288_to_144_fwft.v: xco/fifo_generator_v8_4_288_to_144_fwft.xco
	@mkdir -p $(COREGEN_DIR);
	@mkdir -p netlist;
	@cd $(COREGEN_DIR) && coregen -b ../xco/fifo_generator_v8_4_288_to_144_fwft.xco
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_288_to_144_fwft.v hdl/verilog/
	@cp $(COREGEN_DIR)/fifo_generator_v8_4_288_to_144_fwft.ngc netlist/
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
	rm -f hdl/verilog/fifo_generator_v8_4_4_to_2_fwft.v
	rm -f netlist/fifo_generator_v8_4_4_to_2_fwft.ngc
	rm -f hdl/verilog/fifo_generator_v8_4_144_to_288_fwft.v
	rm -f netlist/fifo_generator_v8_4_144_to_288_fwft.ngc
	rm -f hdl/verilog/fifo_generator_v8_4_9_to_9.v
	rm -f netlist/fifo_generator_v8_4_9_to_9.ngc
	rm -f hdl/verilog/fifo_generator_v8_4_288_to_144_fwft.v
	rm -f netlist/fifo_generator_v8_4_288_to_144_fwft.ngc
	rm -rf hdl/verilog/controller/
