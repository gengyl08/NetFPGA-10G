################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          Project Makefile
#
#  Description:
#          make install : Copy Xilinx files into NetFPGA-10G library
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#             
#  Revision history:
#          2010/12/8 hyzeng: Initial check-in
#          2011/3/3  hyzeng: Improved subdir installation flow
#
################################################################################

NF10_HW_LIB_DIR   = lib/hw/std/pcores
NF10_SW_LIB_DIR   = lib/sw/std/drivers
NF10_SCRIPTS_DIR  = tools/scripts
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores
XILINX_SW_LIB_DIR = $(XILINX_EDK)/sw/XilinxProcessorIPLib/drivers
HW_LIB_DIR_INSTANCES := $(shell cd $(NF10_HW_LIB_DIR) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES)))


install: pcores subdirs

pcores:
	@for lib in $(HW_LIB_DIR_INSTANCES) ; do \
		false | cp -ri $(XILINX_HW_LIB_DIR)/$$lib $(NF10_HW_LIB_DIR) > /dev/null 2>&1; \
	done;
	@patch $(NF10_HW_LIB_DIR)/axi_lite_ipif_v1_00_a/hdl/vhdl/address_decoder.vhd $(NF10_HW_LIB_DIR)/axi_lite_ipif_v1_00_a/hdl/vhdl/address_decoder.diff;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx EDK pcores installed.";
	@echo "/////////////////////////////////////////";
	
subdirs:
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_1g_interface_v1_00_a/
	$(MAKE) -C $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/
	$(MAKE) -C $(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/
	$(MAKE) -C $(NF10_SCRIPTS_DIR)/axitools
