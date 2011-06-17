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
