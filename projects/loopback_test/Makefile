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
#
################################################################################


SYSTEM = system
HW = hw
SW = sw/embedded/
DUMMY_TCL = /tmp/dummy.tcl


all: $HW/$(SYSTEM)_incl.make
	cd $(HW) && $(MAKE) exporttosdk
	cd $(SW) && $(MAKE)
	mkdir -p bitfiles
	cp $(SW)/result/download.bit bitfiles/

clean:
	cd $(HW) && $(MAKE) clean
	cd $(SW) && $(MAKE) clean

$HW/$(SYSTEM)_incl.make:
	echo exit > $(DUMMY_TCL)
	cd $(HW) && xps -nw -scr $(DUMMY_TCL) $(SYSTEM).xmp 
