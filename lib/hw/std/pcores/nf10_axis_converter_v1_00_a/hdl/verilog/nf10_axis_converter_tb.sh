########################################################################
##
##  NETFPGA-10G www.netfpga.org
##
##  Module:
##          nf10_axis_converter_v1_00_a.bat
##
##  Description:
##          Mark Grindell- batch file to compile the test bench for the 
##                         nf10_axis_converter_v1_00_a module, and to
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
fuse -incremental -prj nf10_axis_converter_v1_00_a.prj -o nf10_axis_converter_v1_00_a.exe work.testbench

nf10_axis_converter_v1_00_a.exe -tclbatch nf10_axis_converter_v1_00_a.tcl
