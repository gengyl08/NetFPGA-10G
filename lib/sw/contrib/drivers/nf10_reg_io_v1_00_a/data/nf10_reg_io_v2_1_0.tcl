################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_reg_io_v2_1_0.tcl
#
#  Library:
#        contrib/pcores/nf10_reg_io_v1_00_a
#
#  Author:
#        Muhammad Shahbaz
#
#  Description:
#        Driver TCL script
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


proc generate {drv_handle} {
    #---------------------------
    # #defines in xparameters.h
    #---------------------------
    xdefine_include_file $drv_handle "xparameters.h" "NF10_Reg_IO" "C_BAR0_BASEADDR" "C_BAR0_HIGHADDR" "C_BAR1_BASEADDR" "C_BAR1_HIGHADDR"
}

