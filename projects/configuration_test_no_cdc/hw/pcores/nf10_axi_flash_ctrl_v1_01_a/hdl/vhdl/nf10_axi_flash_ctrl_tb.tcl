########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_axis_converter_v1_00_a.tcl
##
##  Description:
##          Mark Grindell- A test bench to verify basic operation of the 
##                         nf10_axis_converter_v1_00_a module
##
##
##  Revision history:
##          13/07/2011 Mark Grindell First Edition
##          date author description
##          date author description
##
##  Known issues:
##          None
##          
##
##  Library: library dependencies
##
########################################################################
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

