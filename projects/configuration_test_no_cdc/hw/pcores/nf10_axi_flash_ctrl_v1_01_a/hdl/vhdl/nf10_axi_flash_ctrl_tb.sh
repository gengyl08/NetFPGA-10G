########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_axi_flash.bat
##
##  Description:
##          Mark Grindell- batch file to compile the test bench for the 
##                         nf10_axis_flash_tb module, and to
##                         check it's basic functionality
##
##
##  Revision history:
##          18/07/2011 Mark Grindell First Edition
##
##  Known issues:
##          None
##          
##
##  Library: library dependencies
##
########################################################################
fuse -incremental -prj nf10_axi_flash_ctrl_tb.prj -o nf10_axi_flash_ctrl_tb.exe work.testbench

nf10_axi_flash_ctrl_tb.exe -tclbatch nf10_axi_flash_ctrl_tb.tcl
