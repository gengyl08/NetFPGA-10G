#////////////////////////////////////////////////////////////////////////
#//
#//  NetFPGA-10G http://www.netfpga.org
#//
#//  Module:
#//          TCL script for AXI stream CDC
#//
#//  Description:
#//          Generate NGC based on XCO
#//                 
#//  Revision history:
#//          2011 March: mblott - initial check-in
#//
#////////////////////////////////////////////////////////////////////////

proc core_generate { handle } {

    puts "nf10_axis_cdc_interface: Core generation of asynchronous FIFOs"
    puts [pwd]    
    set pcore_dir  [xget_hw_pcore_dir $handle]
        
    set async_fifo_10 \
      [file normalize \
            [file join $pcore_dir ".." xco async_fifo_10.xco]] 
    set async_fifo_37 \
      [file normalize \
            [file join $pcore_dir ".." xco async_fifo_37.xco]] 
    set async_fifo_73 \
      [file normalize \
            [file join $pcore_dir ".." xco async_fifo_73.xco]] 
    set async_fifo_289 \
      [file normalize \
            [file join $pcore_dir ".." xco async_fifo_289.xco]] 
           
    puts $async_fifo_10_xco
    puts $async_fifo_37_xco
    puts $async_fifo_73_xco
    puts $async_fifo_289_xco
    
    cd implementation
    
    if { [file exist async_fifo_10.ngc] } {
        cd ".."
        return true
    } else {
        file copy -force $async_fifo_10_xco .
        file copy -force $async_fifo_37_xco .
        file copy -force $async_fifo_73_xco .
        file copy -force $async_fifo_289_xco .
    }
    
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
