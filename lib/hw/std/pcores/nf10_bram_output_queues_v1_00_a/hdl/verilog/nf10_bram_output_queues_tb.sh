########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_bram_output_queues_tb.bat
##
##  Description:
##          Mark Grindell- batch file to compile the test bench for the 
##                         nf10_bram_output_queues_tb module, and to
##                         check it's basic functionality
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
fuse -incremental -prj nf10_bram_output_queues_tb.prj -o nf10_bram_output_queues_tb.exe testbench
nf10_bram_output_queues_tb.exe -tclbatch nf10_bram_output_queues_tb.tcl
