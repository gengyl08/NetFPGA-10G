################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          Project Makefile
#
#  Description:
#          make install : Copy Xilinx pcores into NetFPGA-10G library
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#             
#  Revision history:
#          2010/12/8 hyzeng: Initial check-in
#
################################################################################

NF10_HW_LIB_DIR = lib/hw/std/pcores/
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores/
HW_LIB_DIR_INSTANCES := $(shell cd $(NF10_HW_LIB_DIR) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES)))


install:    
	@for lib in $(HW_LIB_DIR_INSTANCES) ; do \
		false | cp -ri $(XILINX_HW_LIB_DIR)/$$lib $(NF10_HW_LIB_DIR) > /dev/null 2>&1; \
	done;
	@echo "All Xilinx pcores Installed."
