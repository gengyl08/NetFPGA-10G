################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_axis_gen_check_tb.tcl
#
#  Library:
#        hw/std/pcores/nf10_axis_gen_check_v1_00_a
#
#  Author:
#        Michaela Blott
#
#  Description:
#        Mark Grindell- A test bench to verify basic operation of the
#                       nf10_axis_gen_check_tb module
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 Xilinx, Inc.
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

run 2 us
if {[test gen_check_u/tx_count(31:0)  00000003 -radix hex] &
    [test gen_check_u/rx_count(31:0)  00000003 -radix hex] &
    [test gen_check_u/err_count(31:0) 00000000 -radix hex]} {
  puts "Test Passed"

} else {
  puts "Test Failed"
}
quit

