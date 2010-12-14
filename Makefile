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
#
################################################################################

NF10_HW_LIB_DIR = lib/hw/std/pcores
NF10_SW_LIB_DIR = lib/sw/std/drivers
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores
XILINX_SW_LIB_DIR = $(XILINX_EDK)/sw/XilinxProcessorIPLib/drivers
HW_LIB_DIR_INSTANCES := $(shell cd $(NF10_HW_LIB_DIR) && find . -maxdepth 1 -type d)
HW_LIB_DIR_INSTANCES := $(basename $(patsubst ./%,%,$(HW_LIB_DIR_INSTANCES)))


install: pcores \
		$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/xgmac.v \
		$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/xaui.v \
		$(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/axi_interface.vhd \
		$(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/data/emaclite_header.h

pcores:
	@for lib in $(HW_LIB_DIR_INSTANCES) ; do \
		false | cp -ri $(XILINX_HW_LIB_DIR)/$$lib $(NF10_HW_LIB_DIR) > /dev/null 2>&1; \
	done;
	@patch $(NF10_HW_LIB_DIR)/axi_lite_ipif_v1_00_a/hdl/vhdl/address_decoder.vhd $(NF10_HW_LIB_DIR)/axi_lite_ipif_v1_00_a/hdl/vhdl/address_decoder.diff;
	@echo "Xilinx EDK pcores installed.";
	
$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/xaui.v: $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/xco/xaui.xco
	@mkdir -p $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx
	@mkdir -p $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/netlist
	@mkdir -p coregen;
	@cd coregen && coregen -b ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/xco/xaui.xco\
		&& cp xaui.v ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/ \
		&& cp xaui.ngc ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/netlist/ \
		&& cp xaui/example_design/tx_sync.v ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/ \
		&& cp xaui/example_design/cc_2b_1skp.v ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/ \
		&& patch ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/cc_2b_1skp.v ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/cc_2b_1skp.diff \
		&& cp xaui/example_design/chanbond_monitor.v ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/;
	@echo "Xilinx XAUI core installed.";
	@rm -rf coregen;

$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/xgmac.v: $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/xco/xgmac.xco
	@mkdir -p $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx;
	@mkdir -p $(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/netlist;
	@mkdir -p coregen;
	@cd coregen &&	coregen -b ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/xco/xgmac.xco \
		&& cp xgmac.v ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/hdl/verilog/xilinx/ \
		&& cp xgmac.ngc ../$(NF10_HW_LIB_DIR)/nf10_10g_interface_v1_00_a/netlist/;
	@echo "Xilinx 10G Ethernet MAC core installed.";
	@rm -rf coregen;
	
$(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/axi_interface.vhd: $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/axi_interface.vhd \
																$(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/mdio_if.diff
	@cp -f $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/axi_interface.vhd $(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/axi_interface.vhd;
	@cp -f $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/mdio_if.vhd $(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/mdio_if.vhd;
	@patch $(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/mdio_if.vhd $(NF10_HW_LIB_DIR)/nf10_mdio_v1_00_a/hdl/vhdl/mdio_if.diff;
	@echo "Xilinx MDIO interface - Hardware installed.";

$(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/data/emaclite_header.h: $(XILINX_SW_LIB_DIR)/emaclite_v3_01_a/data/emaclite_header.h
	@false | cp -ri $(XILINX_SW_LIB_DIR)/emaclite_v3_01_a/* $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/ > /dev/null 2>&1;
	@rm -f $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/data/emaclite_v2_1_0.*;
	@patch $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/src/xemaclite.h $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/src/xemaclite.h.diff;
	@patch $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/src/xemaclite_l.h $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/src/xemaclite_l.h.diff;
	@patch $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/src/xemaclite.c $(NF10_SW_LIB_DIR)/nf10_mdio_v1_00_a/src/xemaclite.c.diff;
	@echo "Xilinx MDIO interface - Software installed.";
