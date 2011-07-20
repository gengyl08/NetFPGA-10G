########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_input_arbiter_tb.bat
##
##  Description:
##          Mark Grindell- batch file to compile the test bench for the 
##                         nf10_input_arbiter module, and to
##                         check it's basic functionality
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
fuse -incremental -prj nf10_input_arbiter_tb.prj -o nf10_input_arbiter_tb.exe testbench
nf10_input_arbiter_tb.exe -tclbatch nf10_input_arbiter_tb.tcl
