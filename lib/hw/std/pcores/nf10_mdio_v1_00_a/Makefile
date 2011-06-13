################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          pcore Makefile
#
#  Description:
#          make install : Copy Xilinx files into NetFPGA-10G library
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#             
#  Revision history:
#          2011/3/3 hyzeng: Initial check-in
#          2011/6/13 ericklo: Add target "clean"
#
################################################################################
XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores

install: hdl/vhdl/axi_interface.vhd

hdl/vhdl/axi_interface.vhd: $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/axi_interface.vhd \
																hdl/vhdl/mdio_if.diff
	@cp -f $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/axi_interface.vhd hdl/vhdl/axi_interface.vhd;
	@cp -f $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/mdio_if.vhd hdl/vhdl/mdio_if.vhd;
	@cp -f $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/axi_ethernetlite.vhd hdl/vhdl/nf10_mdio.vhd;
	@cp -f $(XILINX_HW_LIB_DIR)/axi_ethernetlite_v1_00_a/hdl/vhdl/emac.vhd hdl/vhdl/mdio_ipif.vhd;
	@patch hdl/vhdl/mdio_if.vhd hdl/vhdl/mdio_if.diff;
	@patch hdl/vhdl/nf10_mdio.vhd hdl/vhdl/nf10_mdio.diff;
	@patch hdl/vhdl/mdio_ipif.vhd hdl/vhdl/mdio_ipif.diff;
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx MDIO interface - Hardware installed.";
	@echo "/////////////////////////////////////////";

clean:
	@rm -rf hdl/vhdl/*.vhd
	@echo "/////////////////////////////////////////";
	@echo "//Xilinx files removed.";
	@echo "/////////////////////////////////////////";

