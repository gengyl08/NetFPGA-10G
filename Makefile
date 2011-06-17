################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          Project Makefile
#
#  Description:
#          make cores : Copy Xilinx files into NetFPGA-10G library
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#             
#  Revision history:
#          2010/12/8 hyzeng: Initial check-in
#          2011/3/3  hyzeng: Improved subdir installation flow
#		   2011/5/5  hyzeng: Main target renamed to "cores"
#		   2011/6/13 ericklo: Restructure Makefiles, add target "clean"
#
################################################################################

NF10_SCRIPTS_DIR  = tools/scripts
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores
XILINX_SW_LIB_DIR = $(XILINX_EDK)/sw/XilinxProcessorIPLib/drivers

NF10_HW_LIB_DIR_XILINX   = lib/hw/xilinx/pcores

NF10_HW_LIB_DIR_STD   = lib/hw/std/pcores
NF10_SW_LIB_DIR_STD   = lib/sw/std/drivers

HW_LIB_DIR_INSTANCES_XILINX := $(shell cd $(NF10_HW_LIB_DIR_XILINX) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES_XILINX := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES_XILINX)))

HW_LIB_DIR_INSTANCES_STD := $(shell cd $(NF10_HW_LIB_DIR_STD) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES_STD := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES_STD)))


cores: xilinx std

xilinx: check-env
	for lib in $(HW_LIB_DIR_INSTANCES_XILINX) ; do \
		if test -f $(NF10_HW_LIB_DIR_XILINX)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_XILINX)/$$lib; \
		fi; \
	done;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx EDK cores installed.";
	@echo "/////////////////////////////////////////";
	
# James: In the public release, we should replace this with
#        similar mechanism used in Xilinx cores.
std:
	$(MAKE) -C $(NF10_HW_LIB_DIR_STD)/nf10_10g_interface_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR_STD)/nf10_1g_interface_v1_00_a/
	$(MAKE) -C $(NF10_SW_LIB_DIR_STD)/nf10_mdio_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR_STD)/nf10_mdio_v1_00_a/
	@echo "/////////////////////////////////////////";
	@echo "//NF10 standard cores installed.";
	@echo "/////////////////////////////////////////";
	
check-env:
ifndef XILINX_EDK
    $(error XILINX_EDK is undefined)
endif

clean:
	for lib in $(HW_LIB_DIR_INSTANCES_XILINX) ; do \
		if test -f $(NF10_HW_LIB_DIR_XILINX)/$$lib/Makefile; \
			then $(MAKE) -C $(NF10_HW_LIB_DIR_XILINX)/$$lib clean; \
		fi; \
	done;
	$(MAKE) -C $(NF10_HW_LIB_DIR_STD)/nf10_10g_interface_v1_00_a/ clean
	$(MAKE) -C $(NF10_HW_LIB_DIR_STD)/nf10_1g_interface_v1_00_a/ clean
	$(MAKE) -C $(NF10_SW_LIB_DIR_STD)/nf10_mdio_v1_00_a/ clean
	$(MAKE) -C $(NF10_HW_LIB_DIR_STD)/nf10_mdio_v1_00_a/ clean
