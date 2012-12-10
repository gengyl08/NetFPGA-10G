################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        ported_switch_10g
#
#  Author:
#        Muhammad Shahbaz, Gianni Anitchi
#
#  Description:
#        make all : Make BRAM initialized bitfile to bitfiles/
#
#        For more information about how Xilinx EDK works, please visit
#        http://www.xilinx.com/support/documentation/dt_edk.htm
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
#                                 Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This file is free code: you can redistribute it and/or modify it under
#        the terms of the GNU Lesser General Public License version 2.1 as
#        published by the Free Software Foundation.
#
#        This package is distributed in the hope that it will be useful, but
#        WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#        Lesser General Public License for more details.
#
#        You should have received a copy of the GNU Lesser General Public
#        License along with the NetFPGA source package.  If not, see
#        http://www.gnu.org/licenses/.
#
#

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
