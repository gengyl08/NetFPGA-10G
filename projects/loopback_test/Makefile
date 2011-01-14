################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          Project Makefile
#
#  Description:
#          make all : Make BRAM initialized bitfile to bitfiles/
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#             
#  Revision history:
#          2010/12/1 hyzeng: Initial check-in
#          2011/1/14 hyzeng: Move xps call to hw Makefile
#
################################################################################


SYSTEM = system
HW = hw
SW = sw/embedded/


all:
	cd $(HW) && $(MAKE) exporttosdk
	cd $(SW) && $(MAKE)
	mkdir -p bitfiles
	cp $(SW)/result/download.bit bitfiles/

clean:
	cd $(HW) && $(MAKE) clean
	cd $(SW) && $(MAKE) clean
