#
# Update value of C_BASEFAMILY

proc iplevel_update_basefamily { param_handle } { 
    set mhsinst     [xget_hw_parent_handle   $param_handle]
    set family      [xget_hw_parameter_value $mhsinst "C_FAMILY"]
    if {[string match -nocase "*virtex6*" $family]} {return "virtex6"}
    if {[string match -nocase "*spartan6*" $family]} {return "spartan6"}
    puts "\nINTERNAL ERROR: C_FAMILY value $family not supported by axi_interconnect."
    puts "All data-path FIFOs (if any) are implemented as LUT RAM."
    return "rtl"
}

#
# Update value of C_RANGE_CHECK
#   This proc is called only if C_RANGE_CHECK is not set in MHS.
#
proc syslevel_update_range_check {param_handle} {
    set ON 1
    set OFF 0
    set MAX_NUM_SLOTS 16
    set MAX_NUM_RANGES 16
    set AXILITE "2"
    set ZERO_B1 "0b[string repeat "0" $MAX_NUM_SLOTS]"
    set mhsinst [xget_hw_parent_handle $param_handle]
    set instname [xget_hw_parameter_value $mhsinst "INSTANCE"]
    
    set secure_val [xget_hw_parameter_value $mhsinst "C_M_AXI_SECURE"]
    set secure_len [string length $secure_val]
    set secure_none [string equal -nocase -length $secure_len $secure_val $ZERO_B1]
    
    set high_addr_val [xget_hw_parameter_value $mhsinst "C_M_AXI_HIGH_ADDR"]
    set high_addr_upper [string range $high_addr_val 0 end-16]
    set upper_len [string length $high_addr_upper]
    set ZERO_RANGES "0x[string repeat "0" $upper_len]"
    set upper_ranges_null [string equal -nocase -length $upper_len $high_addr_upper $ZERO_RANGES]
    
    set num_s [xget_hw_parameter_value $mhsinst "C_NUM_SLAVE_SLOTS"]
    set s_protocol_val [xget_hw_parameter_value $mhsinst "C_S_AXI_PROTOCOL"]
    set any_s_full 0
    for {set i 0} {$i<$num_s} {incr i} {
      set low_val [string range $s_protocol_val end end]
      if {[string equal $low_val $AXILITE] == 0} {
        set any_s_full 1
      }
      set s_protocol_val [string range $s_protocol_val 0 end-8]
    }

    set num_m [xget_hw_parameter_value $mhsinst "C_NUM_MASTER_SLOTS"]
    set m_protocol_val [xget_hw_parameter_value $mhsinst "C_M_AXI_PROTOCOL"]
    set any_m_lite 0
    for {set i 0} {$i<$num_m} {incr i} {
      set low_val [string range $m_protocol_val end end]
      if {[string equal $low_val $AXILITE] != 0} {
        set any_m_lite 1
      }
      set m_protocol_val [string range $m_protocol_val 0 end-8]
    }
    
    if {$secure_none == 0 || $upper_ranges_null == 0 || ($any_s_full != 0 && $any_m_lite != 0)} {
      puts "\nINFO: Setting C_RANGE_CHECK = ON for axi_interconnect ${instname}."
      return $ON
    } else {
      puts "\nINFO: Setting C_RANGE_CHECK = OFF for axi_interconnect ${instname}; no DECERR checking will be performed."
      return $OFF
    }
}

#
# Entry point for PLATGEN_SYSLEVEL_UPDATE_PROC
#
proc platgen_update  {mhsinst} {
    sys_drc_range_check $mhsinst
    generate_corelevel_ucf $mhsinst
}

#
# DRC for C_RANGE_CHECK (post-PLATGEN)
#
proc sys_drc_range_check {mhsinst} {
    set ON 1
    set OFF 0
    set MAX_NUM_SLOTS 16
    set MAX_NUM_RANGES 16
    set AXILITE "2"
    set ZERO_B1 "0b[string repeat "0" $MAX_NUM_SLOTS]"
    set instname [xget_hw_parameter_value $mhsinst "INSTANCE"]
    set range_chk_val [xget_hw_parameter_value $mhsinst "C_RANGE_CHECK"]
    
    if {[llength $range_chk_val] != 0} {
      if {$range_chk_val == $OFF} {
        set secure_val [xget_hw_parameter_value $mhsinst "C_M_AXI_SECURE"]
        set secure_len [string length $secure_val]
        set secure_none [string equal -nocase -length $secure_len $secure_val $ZERO_B1]
    
        set high_addr_val [xget_hw_parameter_value $mhsinst "C_M_AXI_HIGH_ADDR"]
        set high_addr_upper [string range $high_addr_val 0 end-16]
        set upper_len [string length $high_addr_upper]
        set ZERO_RANGES "0x[string repeat "0" $upper_len]"
        set upper_ranges_null [string equal -nocase -length $upper_len $high_addr_upper $ZERO_RANGES]
    
        set num_s [xget_hw_parameter_value $mhsinst "C_NUM_SLAVE_SLOTS"]
        set s_protocol_val [xget_hw_parameter_value $mhsinst "C_S_AXI_PROTOCOL"]
        set any_s_full 0
        for {set i 0} {$i<$num_s} {incr i} {
          set low_val [string range $s_protocol_val end end]
          if {[string equal $low_val $AXILITE] == 0} {
            set any_s_full 1
          }
          set s_protocol_val [string range $s_protocol_val 0 end-8]
        }

        set num_m [xget_hw_parameter_value $mhsinst "C_NUM_MASTER_SLOTS"]
        set m_protocol_val [xget_hw_parameter_value $mhsinst "C_M_AXI_PROTOCOL"]
        set any_m_lite 0
        for {set i 0} {$i<$num_m} {incr i} {
          set low_val [string range $m_protocol_val end end]
          if {[string equal $low_val $AXILITE] != 0} {
            set any_m_lite 1
          }
          set m_protocol_val [string range $m_protocol_val 0 end-8]
        }
    
        if {$secure_none == 0} {
          error "\nParameter C_RANGE_CHECK may not be forced OFF (C_RANGE_CHECK = $OFF) if any slaves are configured as secure (C_M_AXI_SECURE != 0).\n" "" "mdt_error"
          return
        }
        if {$num_m > 1} {
          puts "\nWARNING: C_RANGE_CHECK is forced OFF and there are more than one slave connected to axi_interconnect ${instname}."
          puts   "         Any transaction with an illegal ADDR may produce unpredictable results."
        }
        if {$any_s_full != 0 && $any_m_lite != 0} {
          puts "\nWARNING: C_RANGE_CHECK is forced OFF and there are AXI4LITE slaves and non-AXI4LITE masters connected to axi_interconnect ${instname}."
          puts   "         Any transaction with burst-length > 1 beat or wider than 32-bits targeting an AXI4LITE slave may produce unpredictable results."
        }
      }
    }
}

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
    set s_ratio_one [string equal -nocase $s_aclk_ratio $P_ACLK_RATIO_ONE]
    set m_ratio_one [string equal -nocase $m_aclk_ratio $P_ACLK_RATIO_ONE]
    set s_async_zero [string equal -nocase $s_aclk_async $P_ACLK_ASYNC_ZERO]
    set m_async_zero [string equal -nocase $m_aclk_async $P_ACLK_ASYNC_ZERO]
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

  # Write tspecs for clock conversion only if async fifos instantiated
    puts $outputFile "NET \"${instname}/*INTERCONNECT_ARESETN*\" TIG;"
    if { $s_ratio_one == 1 && $m_ratio_one == 1 && $s_async_zero == 1 && $m_async_zero == 1} {
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
