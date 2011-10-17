################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Library:
#        sw/std/drivers/nf10_mdio_v1_00_a
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

XILINX_SW_LIB_DIR = $(XILINX_EDK)/sw/XilinxProcessorIPLib/drivers

install: data/emaclite_header.h

data/emaclite_header.h: $(XILINX_SW_LIB_DIR)/emaclite_v3_01_a/data/emaclite_header.h
	false | cp -ri $(XILINX_SW_LIB_DIR)/emaclite_v3_01_a/* . > /dev/null 2>&1;
	rm -f data/emaclite_v2_1_0.*;
	@patch src/xemaclite.h src/xemaclite.h.diff;
	@patch src/xemaclite_l.h src/xemaclite_l.h.diff;
	@patch src/xemaclite.c src/xemaclite.c.diff;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx MDIO interface - Software installed.";
	@echo "/////////////////////////////////////////";

clean:
	rm -rf build doc examples
	rm -f data/emaclite*
	if test -f src/Makefile; \
		then $(MAKE) -C src/ clean; \
	fi; \
	rm -f src/Makefile src/*.h src/*.c
