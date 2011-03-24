# -- (c) Copyright 2010 - 2011 Xilinx, Inc. All rights reserved.
# --
# -- This file contains confidential and proprietary information
# -- of Xilinx, Inc. and is protected under U.S. and 
# -- international copyright and other intellectual property
# -- laws.
# --
# -- DISCLAIMER
# -- This disclaimer is not a license and does not grant any
# -- rights to the materials distributed herewith. Except as
# -- otherwise provided in a valid license issued to you by
# -- Xilinx, and to the maximum extent permitted by applicable
# -- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
# -- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
# -- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
# -- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
# -- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
# -- (2) Xilinx shall not be liable (whether in contract or tort,
# -- including negligence, or under any other theory of
# -- liability) for any loss or damage of any kind or nature
# -- related to, arising under or in connection with these
# -- materials, including for any direct, or any indirect,
# -- special, incidental, or consequential loss or damage
# -- (including loss of data, profits, goodwill, or any type of
# -- loss or damage suffered as a result of any action brought
# -- by a third party) even if such damage or loss was
# -- reasonably foreseeable or Xilinx had been advised of the
# -- possibility of the same.
# --
# -- CRITICAL APPLICATIONS
# -- Xilinx products are not designed or intended to be fail-
# -- safe, or for use in any application requiring fail-safe
# -- performance, such as life-support or safety devices or
# -- systems, Class III medical devices, nuclear facilities,
# -- applications related to the deployment of airbags, or any
# -- other applications that could lead to death, personal
# -- injury, or severe property or environmental damage
# -- (individually and collectively, "Critical
# -- Applications"). Customer assumes the sole risk and
# -- liability of any use of Xilinx products in Critical
# -- Applications, subject only to applicable laws and
# -- regulations governing limitations on product liability.
# --
# -- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
# -- PART OF THIS FILE AT ALL TIMES.
# --------------------------------------------------------------------

#
# Update value of C_BASEFAMILY

proc iplevel_update_basefamily { param_handle } { 
    set mhsinst     [xget_hw_parent_handle   $param_handle]
    set family      [xget_hw_parameter_value $mhsinst "C_FAMILY"]
    if {[string match -nocase "*virtex7*" $family]} {return "virtex7"}
    if {[string match -nocase "*kintex7*" $family]} {return "kintex7"}
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
    sys_drc_downsize_ratio $mhsinst
    generate_corelevel_ucf $mhsinst
}

#
# DRC for C_RANGE_CHECK (post-PLATGEN)
#
proc sys_drc_range_check {mhsinst} {
    set ON 1
    set OFF 0
    set MAX_NUM_SLOTS 16
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

#
# DRC for downsize ratio >= 1024:32 (post-PLATGEN)
#
proc sys_drc_downsize_ratio {mhsinst} {
    set instname [xget_hw_parameter_value $mhsinst "INSTANCE"]
    set num_s [xget_hw_parameter_value $mhsinst "C_NUM_SLAVE_SLOTS"]
    set num_m [xget_hw_parameter_value $mhsinst "C_NUM_MASTER_SLOTS"]
    set s_width_param [xget_hw_parameter_value $mhsinst "C_S_AXI_DATA_WIDTH"]
    set m_width_param [xget_hw_parameter_value $mhsinst "C_M_AXI_DATA_WIDTH"]
    set ict_width_param [xget_hw_parameter_value $mhsinst "C_INTERCONNECT_DATA_WIDTH"]
    
    if {[llength $ict_width_param] != 0} {
      if {$ict_width_param == 32 && [llength $s_width_param] != 0 && [llength $num_s] != 0} {
        for {set i 0} {$i<$num_s} {incr i} {
          set low_val [string range $s_width_param end-7 end]
          set hex_val "0x${low_val}"
          if {$hex_val >= 0x400} {
            error "\nInterconnect does not support downsizing directly from 1024-bit (SI slot $i) to 32-bit (interconnect native width).\n" "" "mdt_error"
            return
          }
          set s_width_param [string range $s_width_param 0 end-8]
        }
      }
      if {$ict_width_param >= 1024 && [llength $m_width_param] != 0 && [llength $num_m] != 0} {
        for {set i 0} {$i<$num_m} {incr i} {
          set low_val [string range $m_width_param end-7 end]
          set hex_val "0x${low_val}"
          if {$hex_val == 0x20} {
            error "\nInterconnect does not support downsizing directly from 1024-bit (interconnect native width) to 32-bit (MI slot $i).\n" "" "mdt_error"
            return
          }
          set m_width_param [string range $m_width_param 0 end-8]
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
    
  # Clock frequency related parameters
    set P_MAX_NUM_SLOTS 16
    set num_s [xget_hw_parameter_value $mhsinst "C_NUM_SLAVE_SLOTS"]
    set num_m [xget_hw_parameter_value $mhsinst "C_NUM_MASTER_SLOTS"]
    set P_ACLK_ASYNC_ZERO "0b[string repeat "0" ${P_MAX_NUM_SLOTS}]"
    set s_aclk_async [xget_hw_parameter_value $mhsinst "C_S_AXI_IS_ACLK_ASYNC"]    
    set m_aclk_async [xget_hw_parameter_value $mhsinst "C_M_AXI_IS_ACLK_ASYNC"]    
    set s_async_zero [string equal -nocase $s_aclk_async $P_ACLK_ASYNC_ZERO]
    set m_async_zero [string equal -nocase $m_aclk_async $P_ACLK_ASYNC_ZERO]
    set s_aclk_ratio [xget_hw_parameter_value $mhsinst "C_S_AXI_ACLK_RATIO"]    
    set m_aclk_ratio [xget_hw_parameter_value $mhsinst "C_M_AXI_ACLK_RATIO"]    
    set ict_aclk_ratio [xget_hw_parameter_value $mhsinst "C_INTERCONNECT_ACLK_RATIO"]    
    set ict_aclk_port [xget_hw_port_handle $mhsinst "INTERCONNECT_ACLK"]
    set ict_aclk_freq [xget_hw_subproperty_value $ict_aclk_port "CLK_FREQ_HZ"]
    set ict_aclk_period_ps [expr 1000000000000 / $ict_aclk_freq]
    set any_sync_conv 0
    set s_temp_async $s_aclk_async
    set m_temp_async $m_aclk_async
    set s_temp_ratio $s_aclk_ratio
    set m_temp_ratio $m_aclk_ratio
    
  # INTERCONNECT_ARESETN input is resynchronized and is excluded from timing analysis.
    #puts $outputFile "INST \"${instname}/*_reset_resync*\" TNM = FFS \"${instname}_reset_resync\";"
    #puts $outputFile "TIMEGRP \"${instname}_reset_source\" = FFS PADS CPUS;"
    #puts $outputFile "TIMESPEC \"TS_${instname}_reset_resync\" = FROM \"${instname}_reset_source\" TO \"${instname}_reset_resync\" TIG;"
    
    for {set i 0} {$i<$num_s} {incr i} {
      if {[string range $s_temp_async end end] == 0} {
        set low_val [string range $s_temp_ratio end-7 end]
        set hex_val "0x${low_val}"
        if {$hex_val != $ict_aclk_ratio} {
          set any_sync_conv 1
        }
      }
      set s_temp_ratio [string range $s_temp_ratio 0 end-8]
      set s_temp_async [string range $s_temp_async 0 end-1]
    }

    for {set i 0} {$i<$num_m} {incr i} {
      if {[string range $m_temp_async end end] == 0} {
        set low_val [string range $m_temp_ratio end-7 end]
        set hex_val "0x${low_val}"
        if {$hex_val != $ict_aclk_ratio} {
          set any_sync_conv 1
        }
      }
      set m_temp_ratio [string range $m_temp_ratio 0 end-8]
      set m_temp_async [string range $m_temp_async 0 end-1]
    }

    if {$any_sync_conv} {
      puts "INFO: Generating core-level timing constraints for synchronous clock conversions in axi_interconnect ${instname}."
      #puts $outputFile "INST \"${instname}/*_converter_bank/*slow_div2\" TNM = \"${instname}_clock_conv_slow_div2\";"
      #puts $outputFile "TIMEGRP \"${instname}_local_flops\" = FFS(\"${instname}/*\") RAMS(\"${instname}/*\") EXCEPT \"${instname}_clock_conv_slow_div2\";"
    } else {
      puts "INFO: No synchronous clock conversions in axi_interconnect ${instname}."
    }

    for {set i 0} {$i<$num_s} {incr i} {
      if {[string range $s_aclk_async end end] == 0} {
        set low_val [string range $s_aclk_ratio end-7 end]
        set hex_val "0x${low_val}"
        if {$hex_val != $ict_aclk_ratio} {
          if {$hex_val >= $ict_aclk_ratio} {
            set path_delay $ict_aclk_period_ps
          } else {
            set path_delay [ expr int((1000000000000.0 / $ict_aclk_freq) * $ict_aclk_ratio / $hex_val) ]
          }
          #puts $outputFile "NET \"${instname}/*si_converter_bank/gen_conv_slot\[${i}\]*S_AXI_ACLK\" TNM_NET = \"${instname}_SI${i}_clock_conv_ACLK_temp\";"
          #puts $outputFile "TIMEGRP \"${instname}_SI${i}_clock_conv_ACLK_global\" = \"${instname}_SI${i}_clock_conv_ACLK_temp\" EXCEPT \"${instname}_clock_conv_slow_div2\";"
          #puts $outputFile "TIMEGRP \"${instname}_SI${i}_clock_conv_otherclk_global\" = FFS RAMS CPUS EXCEPT \"${instname}_SI${i}_clock_conv_ACLK_temp\" \"${instname}_clock_conv_slow_div2\";"
          #puts $outputFile "TIMEGRP \"${instname}_SI${i}_clock_conv_otherclk_local\" = \"${instname}_local_flops\" EXCEPT \"${instname}_SI${i}_clock_conv_ACLK_global\";"
          #puts $outputFile "TIMEGRP \"${instname}_SI${i}_clock_conv_ACLK_local\" = \"${instname}_local_flops\" EXCEPT \"${instname}_SI${i}_clock_conv_otherclk_local\";"
          #puts $outputFile "TIMESPEC \"TS_${instname}_SI${i}_sync_clock_conv_outbound\" = FROM \"${instname}_SI${i}_clock_conv_otherclk_local\" TO \"${instname}_SI${i}_clock_conv_ACLK_global\" ${path_delay} PS;"
          #puts $outputFile "TIMESPEC \"TS_${instname}_SI${i}_sync_clock_conv_inbound\" = FROM \"${instname}_SI${i}_clock_conv_ACLK_global\" TO \"${instname}_SI${i}_clock_conv_otherclk_local\" ${path_delay} PS;"
          #puts $outputFile "TIMESPEC \"TS_${instname}_SI${i}_sync_clock_conv_intrans\" = FROM \"${instname}_SI${i}_clock_conv_otherclk_global\" TO \"${instname}_SI${i}_clock_conv_ACLK_local\" ${path_delay} PS;"
          #puts $outputFile "TIMESPEC \"TS_${instname}_SI${i}_sync_clock_conv_outtrans\" = FROM \"${instname}_SI${i}_clock_conv_ACLK_local\" TO \"${instname}_SI${i}_clock_conv_otherclk_global\" ${path_delay} PS;"
        }
      }
      set s_aclk_ratio [string range $s_aclk_ratio 0 end-8]
      set s_aclk_async [string range $s_aclk_async 0 end-1]
    }

    for {set i 0} {$i<$num_m} {incr i} {
      if {[string range $m_aclk_async end end] == 0} {
        set low_val [string range $m_aclk_ratio end-7 end]
        set hex_val "0x${low_val}"
        if {$hex_val != $ict_aclk_ratio} {
          if {$hex_val >= $ict_aclk_ratio} {
            set path_delay $ict_aclk_period_ps
          } else {
            set path_delay [ expr int((1000000000000.0 / $ict_aclk_freq) * $ict_aclk_ratio / $hex_val) ]
          }
          #puts $outputFile "NET \"${instname}/*mi_converter_bank/gen_conv_slot\[${i}\]*M_AXI_ACLK\" TNM_NET = \"${instname}_MI${i}_clock_conv_ACLK_temp\";"
          #puts $outputFile "TIMEGRP \"${instname}_MI${i}_clock_conv_ACLK_global\" = \"${instname}_MI${i}_clock_conv_ACLK_temp\" EXCEPT \"${instname}_clock_conv_slow_div2\";"
          #puts $outputFile "TIMEGRP \"${instname}_MI${i}_clock_conv_otherclk_global\" = FFS RAMS CPUS EXCEPT \"${instname}_MI${i}_clock_conv_ACLK_temp\" \"${instname}_clock_conv_slow_div2\";"
          #puts $outputFile "TIMEGRP \"${instname}_MI${i}_clock_conv_otherclk_local\" = \"${instname}_local_flops\" EXCEPT \"${instname}_MI${i}_clock_conv_ACLK_global\";"
          #puts $outputFile "TIMEGRP \"${instname}_MI${i}_clock_conv_ACLK_local\" = \"${instname}_local_flops\" EXCEPT \"${instname}_MI${i}_clock_conv_otherclk_local\";"
          #puts $outputFile "TIMESPEC \"TS_${instname}_MI${i}_sync_clock_conv_outbound\" = FROM \"${instname}_MI${i}_clock_conv_otherclk_local\" TO \"${instname}_MI${i}_clock_conv_ACLK_global\" ${path_delay} PS;"
          #puts $outputFile "TIMESPEC \"TS_${instname}_MI${i}_sync_clock_conv_inbound\" = FROM \"${instname}_MI${i}_clock_conv_ACLK_global\" TO \"${instname}_MI${i}_clock_conv_otherclk_local\" ${path_delay} PS;"
          #puts $outputFile "TIMESPEC \"TS_${instname}_MI${i}_sync_clock_conv_intrans\" = FROM \"${instname}_MI${i}_clock_conv_otherclk_global\" TO \"${instname}_MI${i}_clock_conv_ACLK_local\" ${path_delay} PS;"
          #puts $outputFile "TIMESPEC \"TS_${instname}_MI${i}_sync_clock_conv_outtrans\" = FROM \"${instname}_MI${i}_clock_conv_ACLK_local\" TO \"${instname}_MI${i}_clock_conv_otherclk_global\" ${path_delay} PS;"
        }
      }
      set m_aclk_ratio [string range $m_aclk_ratio 0 end-8]
      set m_aclk_async [string range $m_aclk_async 0 end-1]
    }
  # Write tspecs for async clock conversion only if async fifos instantiated
    if { $s_async_zero == 1 && $m_async_zero == 1} {
      puts "INFO: No asynchronous clock conversions in axi_interconnect ${instname}."
    } else {
      puts "INFO: Generating core-level timing constraints for asynchronous clock conversions in axi_interconnect ${instname}."
      #puts $outputFile "INST \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*mem/*dout_i_?\" TNM = \"${instname}_async_clock_conv_FFDEST\";"
      #puts $outputFile "INST \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*mem/*dout_i_??\" TNM = \"${instname}_async_clock_conv_FFDEST\";"
      #puts $outputFile "INST \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*mem/*dout_i_???\" TNM = \"${instname}_async_clock_conv_FFDEST\";"
      #puts $outputFile "INST \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*mem/*dout_i_????\" TNM = \"${instname}_async_clock_conv_FFDEST\";"
      if { [llength $ict_aclk_freq ] == 0 } { 
        puts "WARNING: Cannot determine frequency of INTERCONNECT_ACLK; generating TIG constraint for clock-converter pathways."
        #puts $outputFile "TIMESPEC \"TS_${instname}_async_clock_conv\" = FROM RAMS TO \"${instname}_async_clock_conv_FFDEST\" TIG;"
      } else {
        #puts $outputFile "TIMESPEC \"TS_${instname}_async_clock_conv\" = FROM RAMS TO \"${instname}_async_clock_conv_FFDEST\" ${ict_aclk_period_ps} PS DATAPATHONLY;"
      }
      #puts $outputFile "NET \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*/wr_pntr_*\" TIG;"
      #puts $outputFile "NET \"${instname}/*_converter_bank/*clock_conv_inst/*asyncfifo_*/rd_pntr_*\" TIG;"
      #puts $outputFile "NET \"${instname}/*_converter_bank/*clock_conv_inst/*async_conv_reset\" TIG;"
    }

    close $outputFile
}
