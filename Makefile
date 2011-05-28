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
#
################################################################################

NF10_HW_LIB_DIR   = lib/hw/std/pcores
NF10_SW_LIB_DIR   = lib/sw/std/drivers
NF10_HW_LIB_DIR_XILINX   = lib/hw/xilinx/pcores
NF10_SCRIPTS_DIR  = tools/scripts
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores
XILINX_SW_LIB_DIR = $(XILINX_EDK)/sw/XilinxProcessorIPLib/drivers
HW_LIB_DIR_INSTANCES := $(shell cd $(NF10_HW_LIB_DIR_XILINX) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES)))


cores: pcores subdirs

pcores: check-env
	for lib in $(HW_LIB_DIR_INSTANCES) ; do \
		if test -d $(XILINX_HW_LIB_DIR)/$$lib; \
			then false | cp -ri $(XILINX_HW_LIB_DIR)/$$lib $(NF10_HW_LIB_DIR_XILINX) > /dev/null 2>&1; \
		fi; \
	done;
	patch $(NF10_HW_LIB_DIR_XILINX)/axi_lite_ipif_v1_00_a/hdl/vhdl/address_decoder.vhd $(NF10_HW_LIB_DIR_XILINX)/axi_lite_ipif_v1_00_a/hdl/vhdl/address_decoder.diff;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx EDK pcores installed.";
	@echo "/////////////////////////////////////////";
	
subdirs:
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_1g_interface_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_axis_cdc_v1_00_a/
	$(MAKE) -C $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/
	#$(MAKE) -C $(NF10_SCRIPTS_DIR)/axitools
	
check-env:
ifndef XILINX_EDK
    $(error XILINX_EDK is undefined)
endif
