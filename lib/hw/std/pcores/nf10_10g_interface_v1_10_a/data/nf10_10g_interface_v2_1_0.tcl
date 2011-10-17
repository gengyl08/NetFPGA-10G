################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_10g_interface_v2_1_0.tcl
#
#  Library:
#        hw/std/pcores/nf10_10g_interface_v1_10_a
#
#  Module:
#        TCL script for 10G interface
#
#  Author:
#        James Hongyi Zeng
#
#  Description:
#        Generate NGC based on XCO
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
#                                 Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This file is free code: you can redistribute it and/or modify it under
#        the terms of the GNU Lesser General Public License version 2.1 as
#        published by the Free Software Foundation.
#
#        This package is distributed in the hope that it will be useful, but
#        WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#        Lesser General Public License for more details.
#
#        You should have received a copy of the GNU Lesser General Public
#        License along with the NetFPGA source package.  If not, see
#        http://www.gnu.org/licenses/.
#
#

proc core_generate { handle } {

    puts "nf10_10g_interface: Core generation of XAUI and 10G MAC"
    puts [pwd]
    set pcore_dir  [xget_hw_pcore_dir $handle]

    set xgmac_xco \
      [file normalize \
            [file join $pcore_dir ".." xco xgmac.xco]]
    set xaui_xco \
      [file normalize \
            [file join $pcore_dir ".." xco xaui.xco]]

    puts $xgmac_xco
    puts $xaui_xco

    cd implementation

    if { [file exist xgmac.ngc] } {
        cd ".."
        return true
    } else {
        file copy -force $xgmac_xco .
        file copy -force $xaui_xco .
    }

#    Superceded by Overall Makefile
#    execpipe "coregen -b xgmac.xco"
#    execpipe "coregen -b xaui.xco"

    cd ".."

    return true
}

#***--------------------------------***-----------------------------------***
# Utility process to call a command and pipe it's output to screen.
# Used instead of Tcl's exec
proc execpipe {COMMAND} {

  if { [catch {open "| $COMMAND 2>@stdout"} FILEHANDLE] } {
    return "Can't open pipe for '$COMMAND'"
  }

  set PIPE $FILEHANDLE
  fconfigure $PIPE -buffering none

  set OUTPUT ""

  while { [gets $PIPE DATA] >= 0 } {
    puts $DATA
    append OUTPUT $DATA "\n"
  }

  if { [catch {close $PIPE} ERRORMSG] } {

    if { [string compare "$ERRORMSG" "child process exited abnormally"] == 0 } {
      # this error means there was nothing on stderr (which makes sense) and
      # there was a non-zero exit code - this is OK as we intentionally send
      # stderr to stdout, so we just do nothing here (and return the output)
    } else {
      return "Error '$ERRORMSG' on closing pipe for '$COMMAND'"
    }

  }

  regsub -all -- "\n$" $OUTPUT "" STRIPPED_STRING
  return "$STRIPPED_STRING"

}
