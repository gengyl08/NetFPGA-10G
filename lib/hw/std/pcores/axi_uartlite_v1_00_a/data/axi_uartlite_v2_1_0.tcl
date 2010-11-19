proc nf10_uart { handle } {
    set scriptdir  [xget_hw_pcore_dir $handle]
    set instancename [xget_hw_name $handle]
    
    set scrFileIn \
      [file normalize \
            [file join $scriptdir nf10_uart.scr]] 
    set scrFileOut \
      [file normalize \
            [file join synthesis [string tolower [join "$instancename _wrapper_xst.scr" ""]]]]  
            
    puts $scrFileIn
    puts $scrFileOut      
    file copy -force $scrFileIn $scrFileOut
    return true
}
