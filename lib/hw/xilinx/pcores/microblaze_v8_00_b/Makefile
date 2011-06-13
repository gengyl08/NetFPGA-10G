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
#          2011/6/13 ericklo: Initial check-in
#          
###############################################################################

XILINX_HW_LIB_DIR = $(XILINX_EDK)/hw/XilinxProcessorIPLib/pcores
HW_LIB_INSTANCE = $(shell basename $(shell pwd))

all: install

install:
	false | cp -ri $(XILINX_HW_LIB_DIR)/$(HW_LIB_INSTANCE)/* . > /dev/null 2>&1

clean:
	rm -rf doc hdl simmodels
	rm -f data/*.pao data/*.mui data/*.png data/*.ui data/*.xml data/*.dtd
