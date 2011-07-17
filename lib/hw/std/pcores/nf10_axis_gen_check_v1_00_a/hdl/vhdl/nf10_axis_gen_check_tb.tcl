########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_axis_gen_check_tb.tcl
##
##  Description:
##          Mark Grindell- A test bench to verify basic operation of the 
##                         nf10_axis_gen_check_tb module
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
run 2 us
if {[test gen_check_u/tx_count(31:0)  00000003 -radix hex] &
    [test gen_check_u/rx_count(31:0)  00000003 -radix hex] &
    [test gen_check_u/err_count(31:0) 00000000 -radix hex]} {
  puts "Test Passed"

} else {
  puts "Test Failed"
}
quit

