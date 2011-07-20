########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_nic_output_port_lookup.tcl
##
##  Description:
##          Mark Grindell- A test bench to verify basic operation of the 
##                         nf10_nic_output_port_lookup module
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
run 430 ns
if {[test /testbench/opl/m_axis_tlast 1] & [test /testbench/opl/m_axis_tvalid 1] & [test /testbench/opl/m_axis_tdata(63:0) 1f1f1f1f1f1f1f1f -radix hex]} { 
  run 5 ns
  if {[test /testbench/opl/m_axis_tlast 1] &[test /testbench/opl/m_axis_tvalid 0] & [test /testbench/opl/m_axis_tuser(127:0) 0000000000000000000000000004aaaa -radix hex]} { 
    puts "Test Passed"
  } else {
    puts "Test Failed"
  } 
} else {
  puts "Test Failed"
}
quit

