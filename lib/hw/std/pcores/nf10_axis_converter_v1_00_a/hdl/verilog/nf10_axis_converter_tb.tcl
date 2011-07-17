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
run 340 ns
if {[test /testbench/dut_0/m_axis_tlast 1] & [test /testbench/dut_0/m_axis_tdata(255:0) 0d0d0d0d0c0c0c0c0b0b0b0b0a0a0a0a09090909080808080707070706060606 -radix hex]} { 
  run 710 ns
  if {[test /testbench/dut_0/s_axis_tlast 1] & [test /testbench/dut_0/s_axis_tdata(31:0) 0d0d0d0d -radix hex]} { 
    puts "Test Passed"
  } else {
    puts "Test Failed"
  } 
} else {
  puts "Test Failed"
}
quit

