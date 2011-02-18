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
#          2011/2/18 hyzeng: Remove system_include.make generation
#
################################################################################


SYSTEM = system
HW = hw
SW = sw/embedded/

all:
	$(MAKE) -C $(HW) exporttosdk
	$(MAKE) -C $(SW)
	mkdir -p bitfiles
	cp $(SW)/result/download.bit bitfiles/

clean:
	$(MAKE) -C $(HW) clean
	$(MAKE) -C $(SW) clean
