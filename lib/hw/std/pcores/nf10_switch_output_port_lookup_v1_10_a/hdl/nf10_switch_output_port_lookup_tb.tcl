################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_switch_output_port_lookup_tb.tcl
#
#  Library:
#        hw/contrib/pcores/nf10_switch_output_port_lookup_v1_10_a
#
#  Module:
#        nf10_switch_output_port_lookup.tcl
#
#  Author:
#        Gianni Antichi
#
#  Description:
#       A test bench to verify basic operation of the nf10_switch_output_port_lookup module
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

run 4320 ns
if {[test /testbench/opl/m_axis_tlast 1] & [test /testbench/opl/m_axis_tvalid 1] & [test /testbench/opl/m_axis_tdata(255:0) 1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f -radix hex] & [test /testbench/opl/m_axis_tuser(127:0) 0000000000000000000000000001aaaa -radix hex] } {
  run 5 ns
  if {[test /testbench/opl/m_axis_tlast 1] &[test /testbench/opl/m_axis_tvalid 0] } {
    puts "Test Passed"
  } else {
    puts "Test Failed"
  }
} else {
  puts "Test Failed"
}
quit

