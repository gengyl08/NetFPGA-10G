##
# generate_corelevel_ucf
# 

proc generate_corelevel_ucf {mhsinst} {

  # Open pcore UCF file for writing
    set  filePath [xget_ncf_dir $mhsinst]
    file mkdir    $filePath
    set    instname   [xget_hw_parameter_value $mhsinst "INSTANCE"]
    set    name_lower [string   tolower   $instname]
    set    fileName   $name_lower
    append fileName   "_wrapper.ucf"
    append filePath   $fileName
    set    outputFile [open $filePath "w"]
    
  # Determine whether there are any async fifos used for clock conversion
    set P_MAX_NUM_SLOTS 16
    set P_ACLK_RATIO_ONE "0x[string repeat "00000001" $P_MAX_NUM_SLOTS]"
    set P_ACLK_ASYNC_ZERO "0b[string repeat "0" $P_MAX_NUM_SLOTS]"
    set s_aclk_ratio [xget_hw_parameter_value $mhsinst "C_S_AXI_ACLK_RATIO"]    
    set m_aclk_ratio [xget_hw_parameter_value $mhsinst "C_M_AXI_ACLK_RATIO"]    
    set s_aclk_async [xget_hw_parameter_value $mhsinst "C_S_AXI_IS_ACLK_ASYNC"]    
    set m_aclk_async [xget_hw_parameter_value $mhsinst "C_M_AXI_IS_ACLK_ASYNC"]    
    set s_ratio_one [string compare -nocase $s_aclk_ratio $P_ACLK_RATIO_ONE]
    set m_ratio_one [string compare -nocase $m_aclk_ratio $P_ACLK_RATIO_ONE]
    set s_async_zero [string compare -nocase $s_aclk_async $P_ACLK_ASYNC_ZERO]
    set m_async_zero [string compare -nocase $m_aclk_async $P_ACLK_ASYNC_ZERO]
    set ict_aclk_port [xget_hw_port_handle $mhsinst "INTERCONNECT_ACLK"]
    set ict_aclk_freq [xget_hw_subproperty_value $ict_aclk_port "CLK_FREQ_HZ"]
    
# DEBUG
#    puts "DEBUG: P_ACLK_RATIO_ONE = ${P_ACLK_RATIO_ONE}"
#    puts "DEBUG: s_aclk_ratio = ${s_aclk_ratio}"
#    puts "DEBUG: m_aclk_ratio = ${m_aclk_ratio}"
#    puts "DEBUG: s_aclk_async = ${s_aclk_async}"
#    puts "DEBUG: m_aclk_async = ${m_aclk_async}"
#    puts "DEBUG: s_ratio_one = ${s_ratio_one}"
#    puts "DEBUG: m_ratio_one = ${m_ratio_one}"
#    puts "DEBUG: s_async_zero = ${s_async_zero}"
#    puts "DEBUG: m_async_zero = ${m_async_zero}"
#    puts "DEBUG: ict_aclk_freq = ${ict_aclk_freq}"
#    puts "DEBUG: ict_aclk_period_ps = ${ict_aclk_period_ps}"
#    

  # Write tspecs for clock conversion only if async fifos instantiated
    puts $outputFile "NET \"${instname}/*INTERCONNECT_ARESETN*\" TIG;"
    if { $s_ratio_one == 0 && $m_ratio_one == 0 && $s_async_zero == 0 && $m_async_zero == 0} {
      puts "INFO: No clock conversions in axi_interconnect ${instname}."
    } else {
      puts "INFO: Generating core-level timing constraints for clock conversions in axi_interconnect ${instname}."
      #puts $outputFile "INST \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*/mem/*dout*\" TNM = ${instname}_FFDEST;"
      if { [llength $ict_aclk_freq ] == 0 } { 
        puts "WARNING: Cannot determine frequency of INTERCONNECT_ACLK; generating TIG constraint for clock-converter pathways."
        #puts $outputFile "TIMESPEC TS_${instname}_CLOCKCONV = FROM RAMS TO \"${instname}_FFDEST\" TIG;"
      } else {
        set ict_aclk_period_ps [expr 1000000000000 / $ict_aclk_freq]
        #puts $outputFile "TIMESPEC TS_${instname}_CLOCKCONV = FROM RAMS TO \"${instname}_FFDEST\" ${ict_aclk_period_ps} PS DATAPATHONLY;"
      }
      #puts $outputFile "NET \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*/wr_pntr_*\" TIG;"
      #puts $outputFile "NET \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*/rd_pntr_*\" TIG;"
      #puts $outputFile "NET \"${instname}/*_converter_bank/*clock_conv_inst/*clock_conv_reset\" TIG;"
    }

    close $outputFile
}
