########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_input_arbiter_tb.tcl
##
##  Description:
##          Mark Grindell- A test bench to verify basic operation of the 
##                         nf10_input_arbiter_tb module
##
##
##  Revision history:
##          13/07/2011 Mark Grindell First Edition
##
##  Known issues:
##          None
##          
##
##  Library: library dependencies
##
########################################################################
run 440 ns
if {[test /testbench/in_arb/m_axis_tlast 1] & [test /testbench/in_arb/m_axis_tvalid 1] & [test /testbench/in_arb/m_axis_tdata(63:0) 1f1f1f1f1f1f1f1f -radix hex]} { 
  run 810 ns
  if {[test /testbench/in_arb/s_axis_tlast_3 1] & [test /testbench/in_arb/s_axis_tvalid_3 1] & [test /testbench/in_arb/s_axis_tdata_3(63:0) 1f1f1f1f1f1f1f1f -radix hex]} { 
    puts "Test Passed"
  } else {
    puts "Test Failed"
  } 
} else {
  puts "Test Failed"
}
quit


