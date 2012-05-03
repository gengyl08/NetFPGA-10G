################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Description:
#        make cores : Copy Xilinx files into NetFPGA-10G library
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

NF10_SCRIPTS_DIR  = tools/scripts
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores
XILINX_SW_LIB_DIR = $(XILINX_EDK)/sw/XilinxProcessorIPLib/drivers

NF10_HW_LIB_DIR_XILINX   = lib/hw/xilinx/pcores
HW_LIB_DIR_INSTANCES_XILINX := $(shell cd $(NF10_HW_LIB_DIR_XILINX) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES_XILINX := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES_XILINX)))

NF10_HW_LIB_DIR_STD   = lib/hw/std/pcores
HW_LIB_DIR_INSTANCES_STD := $(shell cd $(NF10_HW_LIB_DIR_STD) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES_STD := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES_STD)))

NF10_SW_LIB_DIR_STD   = lib/sw/std/drivers
SW_LIB_DIR_INSTANCES_STD := $(shell cd $(NF10_SW_LIB_DIR_STD) && find . -maxdepth 1 -type d)
SW_LIB_DIR_INSTANCES_STD := $(basename $(patsubst ./%,%,$(SW_LIB_DIR_INSTANCES_STD)))

NF10_HW_LIB_DIR_CONTRIB   = lib/hw/contrib/pcores
HW_LIB_DIR_INSTANCES_CONTRIB := $(shell cd $(NF10_HW_LIB_DIR_CONTRIB) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES_CONTRIB := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES_CONTRIB)))

NF10_SW_LIB_DIR_CONTRIB   = lib/sw/contrib/drivers
SW_LIB_DIR_INSTANCES_CONTRIB := $(shell cd $(NF10_SW_LIB_DIR_CONTRIB) && find . -maxdepth 1 -type d)
SW_LIB_DIR_INSTANCES_CONTRIB := $(basename $(patsubst ./%,%,$(SW_LIB_DIR_INSTANCES_CONTRIB)))

cores: xilinx std contrib scripts
clean: xilinxclean stdclean contribclean scriptsclean

xilinx: check-env
	for lib in $(HW_LIB_DIR_INSTANCES_XILINX) ; do \
		if test -f $(NF10_HW_LIB_DIR_XILINX)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_XILINX)/$$lib; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx EDK cores installed.";
	@echo "/////////////////////////////////////////";


xilinxclean:
	for lib in $(HW_LIB_DIR_INSTANCES_XILINX) ; do \
		if test -f $(NF10_HW_LIB_DIR_XILINX)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_XILINX)/$$lib clean; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx EDK cores cleaned.";
	@echo "/////////////////////////////////////////";

std:
	for lib in $(HW_LIB_DIR_INSTANCES_STD) ; do \
		if test -f $(NF10_HW_LIB_DIR_STD)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_STD)/$$lib; \
		fi; \
	done;
	for lib in $(SW_LIB_DIR_INSTANCES_STD) ; do \
		if test -f $(NF10_SW_LIB_DIR_STD)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_SW_LIB_DIR_STD)/$$lib; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//NF10 standard cores installed.";
	@echo "/////////////////////////////////////////";

stdclean:
	for lib in $(HW_LIB_DIR_INSTANCES_STD) ; do \
		if test -f $(NF10_HW_LIB_DIR_STD)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_STD)/$$lib clean; \
		fi; \
	done;
	for lib in $(SW_LIB_DIR_INSTANCES_STD) ; do \
		if test -f $(NF10_SW_LIB_DIR_STD)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_SW_LIB_DIR_STD)/$$lib clean; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//NF10 standard cores cleaned.";
	@echo "/////////////////////////////////////////";

contrib:
	for lib in $(HW_LIB_DIR_INSTANCES_CONTRIB) ; do \
		if test -f $(NF10_HW_LIB_DIR_CONTRIB)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_CONTRIB)/$$lib; \
		fi; \
	done;
	for lib in $(SW_LIB_DIR_INSTANCES_CONTRIB) ; do \
		if test -f $(NF10_SW_LIB_DIR_CONTRIB)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_SW_LIB_DIR_CONTRIB)/$$lib; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//NF10 contributed cores installed.";
	@echo "/////////////////////////////////////////";

contribclean:
	for lib in $(HW_LIB_DIR_INSTANCES_CONTRIB) ; do \
		if test -f $(NF10_HW_LIB_DIR_CONTRIB)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_CONTRIB)/$$lib clean; \
		fi; \
	done;
	for lib in $(SW_LIB_DIR_INSTANCES_CONTRIB) ; do \
		if test -f $(NF10_SW_LIB_DIR_CONTRIB)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_SW_LIB_DIR_CONTRIB)/$$lib clean; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//NF10 contributed cores cleaned.";
	@echo "/////////////////////////////////////////";

scripts:
	$(MAKE) -C $(NF10_SCRIPTS_DIR)


scriptsclean:
	$(MAKE) -C $(NF10_SCRIPTS_DIR) clean


check-env:
ifndef XILINX_EDK
    $(error XILINX_EDK is undefined)
endif

