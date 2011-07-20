########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_bram_output_queues_tb.tcl
##
##  Description:
##          Mark Grindell- A test bench to verify basic operation of the 
##                         nf10_bram_output_queues_tb module
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
run 1240 ns
if {[test /testbench/dut/s_axis_tlast 1] & [test /testbench/dut/s_axis_tvalid 1] & [test /testbench/dut/s_axis_tdata(255:0) 0000000000000000000000000000000000000000000000001f1f1f1f1f1f1f1f -radix hex]} { 
    puts "Test Passed"
  } else {
    puts "Test Failed"
} 
quit
