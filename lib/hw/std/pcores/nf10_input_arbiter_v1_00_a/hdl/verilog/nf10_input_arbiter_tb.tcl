################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_input_arbiter_tb.tcl
#
#  Library:
#        hw/std/pcores/nf10_input_arbiter_v1_00_a
#
#  Author:
#        Adam Covington
#
#  Description:
#        Mark Grindell- A test bench to verify basic operation of the
#                       nf10_input_arbiter_tb module
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

run 440 ns
if {[test /testbench/in_arb/m_axis_tlast 1] & [test /testbench/in_arb/m_axis_tvalid 1] & [test /testbench/in_arb/m_axis_tdata(63:0) 1f1f1f1f1f1f1f1f -radix hex]} {
  run 788 ns
  if {[test /testbench/in_arb/s_axis_tlast_3 1] & [test /testbench/in_arb/s_axis_tvalid_3 1] & [test /testbench/in_arb/s_axis_tdata_3(63:0) 1f1f1f1f1f1f1f1f -radix hex]} {
    puts "Test Passed"
  } else {
    puts "Test Failed"
  }
} else {
  puts "Test Failed"
}
quit


