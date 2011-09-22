################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_axi_flash_ctrl_tb.tcl
#
#  Library:
#        library dependencies
#
#  Project:
#        configuration_test_no_cdc
#
#  Module:
#        nf10_axis_converter_v1_00_a.tcl
#
#  Author:
#        Stephanie Friederich
#
#  Description:
#        Mark Grindell- A test bench to verify basic operation of the
#                       nf10_axis_converter_v1_00_a module
#
#  Copyright notice:
#        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
#                                Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This package is free software: you can redistribute it and/or modify
#        it under the terms of the GNU Lesser General Public License as
#        published by the Free Software Foundation, either version 3 of the
#        License, or (at your option) any later version.
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

run 14320 ns
if {[test /testbench/data_register(15:0) 0009 -radix hex]} {
  run 1.950 us
  if {[test /testbench/data_register(15:0) 1234 -radix hex]} {
    run 1290 us
    if {[test /testbench/data_register(15:0) 5432 -radix hex]} {
      puts "Test Passed"
    } else {
      puts "Test Failed" }
  } else {
    puts "Test Failed" }
} else {
  puts "Test Failed" }
quit

