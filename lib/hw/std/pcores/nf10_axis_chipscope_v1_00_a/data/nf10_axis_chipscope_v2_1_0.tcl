proc core_generate { handle } {

    puts "nf10_axis_chipscope: Core generation of chipscope"
    puts [pwd]    
    set pcore_dir  [xget_hw_pcore_dir $handle]
        
    set icon_xco \
      [file normalize \
            [file join $pcore_dir ".." xco cs_axi_icon.xco]] 
    set ila_xco \
      [file normalize \
            [file join $pcore_dir ".." xco cs_axi_ila.xco]] 
           
    puts $icon_xco
    puts $ila_xco  
    
    cd implementation
    
    if { [file exist nf10_axis_chipscope.ngc] } {
        cd ".."
        return true
    } else {
        file copy -force $icon_xco .
        file copy -force $ila_xco .
    }
    
    execpipe "coregen -b cs_axi_icon.xco"
    execpipe "coregen -b cs_axi_ila.xco"
    
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
