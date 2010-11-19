##############################################################################
##
## Copyright (c) 2007-2009 Xilinx, Inc. All Rights Reserved.
## You may copy and modify these files for your own internal use solely with
## Xilinx programmable logic devices and Xilinx EDK system or create IP
## modules solely for Xilinx programmable logic devices and Xilinx EDK system.
## No rights are granted to distribute any files unless they are distributed 
## in Xilinx programmable logic devices.
##
## clock_generator_v2_1_0.tcl
##
##############################################################################


proc xps_ipconfig_init {mhsinst} {

    puts "Clock_generator configuration can be edited in the following configuration dialog.\nUse of direct editing will overwrite the original clock wizard settings.\n\nThe clock wizard can be launched from the Hardware -> Launch Clock Wizard menu."

}

# ----------------------------------------------------------------------------
# load clock generator library according to the operating system running
# ----------------------------------------------------------------------------

proc load_core_libs {} {
  global tcl_platform env tcl_library

  if [ info exists ::env(MY_XILINX_EDK) ]   {
    set basedir $env(MY_XILINX_EDK)
  } elseif [ info exists ::env(XILINX_EDK) ] {
    set basedir $env(XILINX_EDK)
  } else {
    error "Neither MY_XILINX_EDK nor XILINX_EDK defined.\n" "" "mdt_error"
  }

  switch -glob $tcl_platform(os) {
    "Windows*" {
      set libfile libMdtClkGen.dll
    }
    "Linux" {
      set libfile libMdtClkGen.so
    }
    "SunOS" {
      set libfile libMdtClkGen.so
    }
    default {
      error "Unknown platform.\n" "" "mdt_error"
    }
  }
  set plat_os $::xil_edk_platform
 
  if { [file exists $basedir/bin/$plat_os/$libfile] } {
    if { [catch {load $basedir/bin/$plat_os/$libfile} err_msg] } {
      error " $err_msg\n" "" "mdt_error"
    }
  } elseif { [file exists $basedir/lib/$plat_os/$libfile] } {
    if { [catch {load $basedir/lib/$plat_os/$libfile} err_msg] } {
      error " $err_msg\n" "" "mdt_error"
    }
  } else {
    error " Failed to load $libfile.\n" "" "mdt_error"
  }
}

# ----------------------------------------------------------------------------
# clkgen_drc
# ----------------------------------------------------------------------------

proc clkgen_drc {mhsinst} {
}

# ----------------------------------------------------------------------------
# clkgen_elaborate 
# ----------------------------------------------------------------------------

proc clkgen_elaborate {mhsinst} {

  # -----------------------------------
  # syslevel update
  # -----------------------------------

  syslevel_update $mhsinst

  set mpd [xget_hw_mpd_handle $mhsinst]
  # puts "ClkGen default value C_CLK_GEN = [xget_hw_parameter_value $mpd "C_CLK_GEN"]"
  # puts "ClkGen current value C_CLK_GEN = [xget_hw_parameter_value $mhsinst "C_CLK_GEN"]"

  # -----------------------------------
  # write hdl wrapper
  # -----------------------------------

  set clk_gen [xget_hw_parameter_value $mhsinst "C_CLK_GEN"]
  if {$clk_gen == "PASSED"} {

    set caller_name [xget_nameofexecutable]
    set filepath ""
    if { [string match "platgen" $caller_name] == 1 } {
      set filepath [create_hdl_wrapper $mhsinst]
    } 

    if { [string match "simgen" $caller_name] == 1 } {
      set filepath [create_sim_wrapper $mhsinst]
      # cr539889 change to following line, 20100209 change back to above line
      # set filepath [create_hdl_wrapper $mhsinst]
    }

    set param_table [create_param_table $mhsinst]
	  write_hdl_wrapper $filepath $param_table
  }

  return 0
}

# --------------------------------------

proc create_hdl_wrapper { mhsinst } {

	# Create DIR
	set instance_name [xget_hw_parameter_value $mhsinst "INSTANCE"]
  set hdllib $instance_name
	set hw_ver [string map {. _} [xget_hw_parameter_value $mhsinst "HW_VER"]]
	if { [string length $hw_ver] != 0 } {
		append hdllib "_v" $hw_ver
	}
	
  set hdldir "hdl"
  # set elaborate_dir [xget_hw_parameter_value $mhsinst "C_ELABORATE_DIR"]
  # set elaborate_dir "NOT_SET" # 20100210 change to by CR#539889
  set elaborate_dir [xget_tool_output_dir]
  if { $elaborate_dir != "" && 
       $elaborate_dir != "NOT_SET" } {
    set hdldir "$elaborate_dir"
  }
	append hdldir "/elaborate/$hdllib/hdl/vhdl/"

  if {![file exists $hdldir]} {
    file mkdir $hdldir
  }
	# puts "ClkGen created elaborate directory: $hdldir"
	
	set filename "clock_generator.vhd"
	set filepath [file join $hdldir/$filename]
	
	# Update PAO
	# xadd_hw_hdl_srcfile <ipinst_mhsinst> <fileuse> <filename> <hdllang>
	xadd_hw_hdl_srcfile $mhsinst "lib" $filename "VHDL"
	# puts "ClkGen updated PAO file"

  return $filepath
}

# --------------------------------------

proc create_sim_wrapper { mhsinst } {

	# Create DIR
	set instance_name [xget_hw_parameter_value $mhsinst "INSTANCE"]
  set hdllib $instance_name
	set hw_ver [string map {. _} [xget_hw_parameter_value $mhsinst "HW_VER"]]
	if { [string length $hw_ver] != 0 } {
		append hdllib "_v" $hw_ver
	}

  # set sim_model [xget sim_model]
  set sim_model "BEHAVIORAL"

  if { [string match "BEHAVIORAL" $sim_model] == 1 } {
    set sim_model "behavioral"
  }
  if { [string match "STRUCTURAL" $sim_model] == 1 } {
    set sim_model "structural"
  }
  if { [string match "TIMING" $sim_model] == 1 } {
    set sim_model "timing"
  }

  set hdldir "simulation/$sim_model"
  # set elaborate_dir [xget_hw_parameter_value $mhsinst "C_ELABORATE_DIR"]
  # set elaborate_dir "NOT_SET" # 20100210 change to by CR#539889
  set elaborate_dir [xget_tool_output_dir]
  if { $elaborate_dir != "" && 
       $elaborate_dir != "NOT_SET" } {
    set hdldir "$elaborate_dir"
  }
	append hdldir "elaborate/$hdllib/hdl/vhdl/"

  if {![file exists $hdldir]} {
    file mkdir $hdldir
  }
	# puts "ClkGen created elaborate directory: $hdldir"
	
	set filename "clock_generator.vhd"
	set filepath [file join $hdldir/$filename]
	
	# Update PAO
	# xadd_hw_hdl_srcfile <ipinst_mhsinst> <fileuse> <filename> <hdllang>
	xadd_hw_hdl_srcfile $mhsinst "lib" $filename "VHDL"
	# puts "ClkGen updated PAO file"

  return $filepath
}

# ----------------------------------------------------------------------------
# create param table
# ----------------------------------------------------------------------------

proc create_default_param_table {} {

  set default_param_table {}

  # -----------------------------------
  # default_param_table : low level param
  # -----------------------------------

  # PORT Connection

  set port_names { "clkout" "clkfbout" "psdone" }

  foreach port_name $port_names {
	  # puts "$drawline40"
    foreach port [[format "get_clkgen_%s_names" $port_name]] {
      foreach param_name [[format "get_clkgen_%s_params_connection" $port_name]] {
        set param [format "C_%s_%s" $port $param_name]
        set value "NONE"
        # puts "-- $param = $value"
		    lappend default_param_table $param
		    lappend default_param_table $value
      }
    }
  }

  # CORE Connection 

  set core_names { "dcm" "pll" "mmcm" }

  foreach core_name $core_names {
    foreach core [[format "get_clkgen_%s_names" $core_name]] {
	    # puts "$drawline40"
      foreach param_name [[format "get_clkgen_%s_params_connection" $core_name]] {
        set param [format "C_%s_%s" $core $param_name]
        set value "NONE"
        # puts "-- $param = $value"
		    lappend default_param_table $param
		    lappend default_param_table $value
      }
    }
  }  

  # CORE

  set core_names { "dcm" "pll" "mmcm" }

  foreach core_name $core_names {
	  array set default_params [[format "get_clkgen_%s_default_params" $core_name]]  
    foreach core [[format "get_clkgen_%s_names" $core_name]] {
      # puts "$drawline40"
      foreach param_name [[format "get_clkgen_%s_params" $core_name]] {
        set param [format "C_%s_%s" $core $param_name]
        set value $default_params($param_name)
        # puts "-- $param = $value"
       lappend default_param_table $param
       lappend default_param_table $value
      }
    }
  }

  return $default_param_table
}

# --------------------------------------

proc create_param_table { mhsinst } {

  set default_param_table [create_default_param_table]
	array set default_params $default_param_table

 	set param_table {}

  set drawline40 "----------------------------------------";
  set drawline38 "--------------------------------------";
  set drawline78 "$drawline40$drawline38";

  # -----------------------------------
  # param_table : high level param
  # -----------------------------------

  # CLKGEN

  # puts "$drawline40"
	foreach name [get_clkgen_params] {
    # puts "-- $name = [xget_value $mhsinst "PARAMETER" $name]"
		lappend param_table $name
		lappend param_table [xget_value $mhsinst "PARAMETER" $name]
	}

  # PORT

  set port_names { "clkin" "clkout" "clkfbin" "clkfbout" "psdone" }

  foreach port_name $port_names {
	  # puts "$drawline40"
    foreach port [[format "get_clkgen_%s_names" $port_name]] {
      foreach param_name [[format "get_clkgen_%s_params" $port_name]] {
        set param [format "C_%s_%s" $port $param_name]
        set value [xget_hw_parameter_value $mhsinst $param]
        # puts "-- $param = $value"
		    lappend param_table $param
		    lappend param_table $value
      }
    }
  }

  # -----------------------------------
  # param_table : low level param
  # -----------------------------------

  # PORT Connection

  set port_names { "clkout" "clkfbout" "psdone" }

  foreach port_name $port_names {
	  # puts "$drawline40"
    foreach port [[format "get_clkgen_%s_names" $port_name]] {
      foreach param_name [[format "get_clkgen_%s_params_connection" $port_name]] {
        set param [format "C_%s_%s" $port $param_name]
        set value [xget_hw_parameter_value $mhsinst $param]
        if { $value == "" } {
          set value $default_params($param)
        }
        # puts "-- $param = $value"
		    lappend param_table $param
		    lappend param_table $value
      }
    }
  }

  # CORE Connection 

  set core_names { "dcm" "pll" "mmcm" }

  foreach core_name $core_names {
    foreach core [[format "get_clkgen_%s_names" $core_name]] {
	    # puts "$drawline40"
      foreach param_name [[format "get_clkgen_%s_params_connection" $core_name]] {
        set param [format "C_%s_%s" $core $param_name]
        set value [xget_hw_parameter_value $mhsinst $param]
        if { $value == "" } {
          set value $default_params($param)
        }
        # puts "-- $param = $value"
		    lappend param_table $param
		    lappend param_table $value
      }
    }
  }  

  # CORE Parameter : MHS str does not have "" while VHDL str needs ""

  foreach core_name $core_names {  
    foreach core [[format "get_clkgen_%s_names" $core_name]] {
	    # puts "$drawline40"
      foreach param_name [[format "get_clkgen_%s_params" $core_name]] {
        set param [format "C_%s_%s" $core $param_name]
        set value [xget_hw_parameter_value $mhsinst $param]
        if { $value == "" } {
          set value $default_params($param)
        } else {
          if { $core_name == "dcm" } {
            if { $param_name == "DFS_FREQUENCY_MODE" ||
                 $param_name == "DLL_FREQUENCY_MODE" ||
                 $param_name == "CLK_FEEDBACK" ||
                 $param_name == "CLKOUT_PHASE_SHIFT" ||
                 $param_name == "DSS_MODE" ||
                 $param_name == "DESKEW_ADJUST" ||
                 $param_name == "FAMILY" } {
              set value "\"$value\""
            }
          }
          if { $core_name == "pll" } {
            if { $param_name == "BANDWIDTH" ||
                 $param_name == "COMPENSATION" ||
                 $param_name == "RST_DEASSERT_CLK" ||
                 $param_name == "CLKOUT0_DESKEW_ADJUST" ||
                 $param_name == "CLKOUT1_DESKEW_ADJUST" ||
                 $param_name == "CLKOUT2_DESKEW_ADJUST" ||
                 $param_name == "CLKOUT3_DESKEW_ADJUST" ||
                 $param_name == "CLKOUT4_DESKEW_ADJUST" ||
                 $param_name == "CLKOUT5_DESKEW_ADJUST" ||
                 $param_name == "CLKFBOUT_DESKEW_ADJUST" ||
                 $param_name == "FAMILY" } {
              set value "\"$value\""
            }
          }         
          if { $core_name == "mmcm" } {
            if { $param_name == "BANDWIDTH" ||
                 $param_name == "COMPENSATION" ||
                 $param_name == "FAMILY" } {
              set value "\"$value\""
            }
          }
        }
        # puts "-- $param = $value"
		    lappend param_table $param
		    lappend param_table $value
      }
    }
  }

	# puts "$drawline40"

	# will need the following to check for multiple instantiation
  # set $ipname "clock_generator"
	# lappend param_table IPNAME
	# lappend param_table $ipname
	
	# puts "Param values are : $param_table"
	
	# put the PARAMETER name value pairs into an associative array 
	# for easy access Ex: set instance_name $params(INSTANCE)
	# array set params $param_table
	
	# First Create the HDL wrapper to instantiate the VIO core
	# This intermediate wrapper is needed to match the port declaration
	# (no of ports is fixed) in the EDK VIO core and the port declaration
	# in the Chipscope core generated by the Chipscope Core Generator engine

  return $param_table
}


# --------------------------------------
# get parameter proc
# --------------------------------------

proc get_params { core item } {

  # get_clkgen_params -> clkgen param
  # get_clkgen_clkin_names -> clkgen clkin
  # get_clkgen_clkin_params -> clkin param
  # get_clkgen_clkout_names -> clkgen clkout
  # get_clkgen_clkout_params -> clkout param
  # 
  # get_clkgen_clkout_params_connection -> clkout param_connection
  # 
  # get_clkgen_dcm_names -> clkgen dcm
  # get_clkgen_dcm_default_params 
  # get_clkgen_dcm_params -> dcm param
  # get_clkgen_dcm_params_connection dcm param_connection

}

proc get_values { core item } {

  # get_clkgen_values -> clkgen param
}

proc get_default_values { core item } {

  # get_clkgen_default_values -> clkgen param
}

# --------------------------------------
# high level
# --------------------------------------

proc get_clkgen_params {} {
  set params { 
    "C_CLK_GEN" 
    "C_ELABORATE_DIR" 
    "C_ELABORATE_RES" 
    "C_FAMILY" 
    "C_DEVICE" 
    "C_PACKAGE" 
    "C_SPEEDGRADE" 
  }
  return $params
}

# --------------------------------------

proc get_clkgen_clkin_names {} {
  set clkin_names { "CLKIN" }
  return $clkin_names
}

proc get_clkgen_clkin_params {} {
  set clkin_params { "FREQ" }
  return $clkin_params
}

# --------------------------------------

proc get_clkgen_clkout_names {} {
  set clkout_names { 
    "CLKOUT0" 
    "CLKOUT1" 
    "CLKOUT2" 
    "CLKOUT3" 
    "CLKOUT4" 
    "CLKOUT5" 
    "CLKOUT6" 
    "CLKOUT7" 
    "CLKOUT8" 
    "CLKOUT9" 
    "CLKOUT10" 
    "CLKOUT11" 
    "CLKOUT12" 
    "CLKOUT13" 
    "CLKOUT14" 
    "CLKOUT15" 
  }
  return $clkout_names
}

proc get_clkgen_clkout_params {} {
  set clkout_params { 
    "FREQ" 
    "PHASE" 
    "GROUP" 
    "BUF" 
    "VARIABLE_PHASE" 
  }
  return $clkout_params
}

# --------------------------------------

proc get_clkgen_clkfbin_names {} {
  set clkfbin_names { "CLKFBIN" }
  return $clkfbin_names
}

proc get_clkgen_clkfbin_params {} {
  set clkfbin_params { 
    "FREQ" 
    "DESKEW" 
  }
  return $clkfbin_params
}

# --------------------------------------

proc get_clkgen_clkfbout_names {} {
  set clkfbout_names { "CLKFBOUT" }
  return $clkfbout_names
}

proc get_clkgen_clkfbout_params {} {
  set clkfbout_params { 
    "FREQ" 
    "GROUP" 
    "BUF" }
  return $clkfbout_params
}

# --------------------------------------

proc get_clkgen_psdone_names {} {
  set psdone_names { "PSDONE" }
  return $psdone_names
}

proc get_clkgen_psdone_params {} {
  set psdone_params { "GROUP" }
  return $psdone_params
}

# --------------------------------------
# low level
# --------------------------------------

proc get_clkgen_clkout_params_connection {} {
  set clkout_params { 
    "MODULE" 
    "PORT" 
  }
  return $clkout_params
}

# --------------------------------------

proc get_clkgen_clkfbout_params_connection {} {
  set clkfbout_params { 
    "MODULE" 
    "PORT" get_clkgen_dcm_default_params
  }
  return $clkfbout_params
}

# --------------------------------------

proc get_clkgen_psdone_params_connection {} {
  set psdone_params { 
    "MODULE" 
  }
  return $psdone_params
}

# --------------------------------------

proc get_clkgen_dcm_names {} {
  set dcm_names { "DCM0" "DCM1" "DCM2" "DCM3" }
  return $dcm_names
}

proc get_clkgen_dcm_default_params {} {
  set dcm_default_params {
    "DFS_FREQUENCY_MODE"       "\"LOW\""                     
    "DLL_FREQUENCY_MODE"       "\"LOW\""                     
    "DUTY_CYCLE_CORRECTION"    "true"                    
    "CLKIN_DIVIDE_BY_2"        "false"                   
    "CLK_FEEDBACK"             "\"1X\""                      
    "CLKOUT_PHASE_SHIFT"       "\"NONE\""                    
    "DSS_MODE"                 "\"NONE\""                    
    "STARTUP_WAIT"             "false"                   
    "PHASE_SHIFT"              "0"                       
    "CLKFX_MULTIPLY"           "4"                       
    "CLKFX_DIVIDE"             "1"                       
    "CLKDV_DIVIDE"             "2.0"                     
    "CLKIN_PERIOD"             "41.6666666"              
    "DESKEW_ADJUST"            "\"SYSTEM_SYNCHRONOUS\""      
    "CLKIN_BUF"                "false"                   
    "CLKFB_BUF"                "false"                   
    "CLK0_BUF"                 "false"                   
    "CLK90_BUF"                "false"                   
    "CLK180_BUF"               "false"                   
    "CLK270_BUF"               "false"                   
    "CLKDV_BUF"                "false"                   
    "CLK2X_BUF"                "false"                   
    "CLK2X180_BUF"             "false"                   
    "CLKFX_BUF"                "false"                   
    "CLKFX180_BUF"             "false"                   
    "EXT_RESET_HIGH"           "1"                       
    "FAMILY"                   "\"spartan6\""                
  }
  return $dcm_default_params
}

proc get_clkgen_dcm_params {} {
  set dcm_params {}
  set dcm_default_param_table [get_clkgen_dcm_default_params]
	array set dcm_default_params $dcm_default_param_table
  set index 1
  foreach param $dcm_default_param_table {
    if { $index > 0 } {
		  lappend dcm_params $param
    }
    set index [expr 0 - $index]
  }
  return $dcm_params
}

proc get_clkgen_dcm_params_connection {} {
  set dcm_params {
    "CLKIN_MODULE"
    "CLKIN_PORT"
    "CLKFB_MODULE"
    "CLKFB_PORT"
    "RST_MODULE"
  }
  return $dcm_params
}

# --------------------------------------

proc get_clkgen_pll_names {} {
  set pll_names { "PLL0" "PLL1" }
  return $pll_names
}

proc get_clkgen_pll_default_params {} {
    # "CLKIN2_PERIOD"        "0.000"  
    # "EN_REL"               "false"  
    # "PLL_PMCD_MODE"        "false"  
    # "CLKIN2_BUF"           "false"
  set pll_params {
    "BANDWIDTH"              "\"OPTIMIZED\""            
    "CLKFBOUT_MULT"          "1"  
    "CLKFBOUT_PHASE"         "0.0"  
    "CLKIN1_PERIOD"          "0.000"  
    "CLKOUT0_DIVIDE"         "1"  
    "CLKOUT0_DUTY_CYCLE"     "0.5"  
    "CLKOUT0_PHASE"          "0.0"  
    "CLKOUT1_DIVIDE"         "1"  
    "CLKOUT1_DUTY_CYCLE"     "0.5"  
    "CLKOUT1_PHASE"          "0.0"  
    "CLKOUT2_DIVIDE"         "1"  
    "CLKOUT2_DUTY_CYCLE"     "0.5"  
    "CLKOUT2_PHASE"          "0.0"  
    "CLKOUT3_DIVIDE"         "1"  
    "CLKOUT3_DUTY_CYCLE"     "0.5"  
    "CLKOUT3_PHASE"          "0.0"  
    "CLKOUT4_DIVIDE"         "1"  
    "CLKOUT4_DUTY_CYCLE"     "0.5"  
    "CLKOUT4_PHASE"          "0.0"  
    "CLKOUT5_DIVIDE"         "1"  
    "CLKOUT5_DUTY_CYCLE"     "0.5"  
    "CLKOUT5_PHASE"          "0.0"  
    "COMPENSATION"           "\"SYSTEM_SYNCHRONOUS\""  
    "DIVCLK_DIVIDE"          "1"  
    "REF_JITTER"             "0.100"  
    "RESET_ON_LOSS_OF_LOCK"  "false"  
    "RST_DEASSERT_CLK"       "\"CLKIN1\""  
    "CLKOUT0_DESKEW_ADJUST"  "\"NONE\""  
    "CLKOUT1_DESKEW_ADJUST"  "\"NONE\""  
    "CLKOUT2_DESKEW_ADJUST"  "\"PPC\"" 
    "CLKOUT3_DESKEW_ADJUST"  "\"PPC\"" 
    "CLKOUT4_DESKEW_ADJUST"  "\"PPC\"" 
    "CLKOUT5_DESKEW_ADJUST"  "\"PPC\"" 
    "CLKFBOUT_DESKEW_ADJUST" "\"PPC\"" 
    "CLKIN1_BUF"             "false"
    "CLKFBOUT_BUF"           "false"
    "CLKOUT0_BUF"            "false"
    "CLKOUT1_BUF"            "false"
    "CLKOUT2_BUF"            "false"
    "CLKOUT3_BUF"            "false"
    "CLKOUT4_BUF"            "false"
    "CLKOUT5_BUF"            "false"
    "EXT_RESET_HIGH"         "1"
    "FAMILY"                 "\"spartan6\""
  }
  return $pll_params
}

proc get_clkgen_pll_params {} {
  set pll_params {}
  set pll_default_param_table [get_clkgen_pll_default_params]
	array set pll_default_params $pll_default_param_table
  set index 1
  foreach param $pll_default_param_table {
    if { $index > 0 } {
		  lappend pll_params $param
    }
    set index [expr 0 - $index]
  }
  return $pll_params
}

proc get_clkgen_pll_params_connection {} {
  set pll_params {
    "CLKIN1_MODULE"
    "CLKIN1_PORT"
    "CLKFBIN_MODULE"
    "CLKFBIN_PORT"
    "RST_MODULE"
  }
  return $pll_params
}

# --------------------------------------

proc get_clkgen_mmcm_names {} {
  set mmcm_names { "MMCM0" "MMCM1" "MMCM2" "MMCM3" }
  return $mmcm_names
}

proc get_clkgen_mmcm_default_params {} {
  set mmcm_params {
    "BANDWIDTH"                 "\"OPTIMIZED\"" 
    "CLKFBOUT_MULT_F"           "1.0"  
    "CLKFBOUT_PHASE"            "0.0"  
    "CLKFBOUT_USE_FINE_PS"      "false"
    "CLKIN1_PERIOD"             "0.000"  
    "CLKOUT0_DIVIDE_F"          "1.0"  
    "CLKOUT0_DUTY_CYCLE"        "0.5"  
    "CLKOUT0_PHASE"             "0.0"  
    "CLKOUT1_DIVIDE"            "1"  
    "CLKOUT1_DUTY_CYCLE"        "0.5"  
    "CLKOUT1_PHASE"             "0.0"  
    "CLKOUT2_DIVIDE"            "1"  
    "CLKOUT2_DUTY_CYCLE"        "0.5"  
    "CLKOUT2_PHASE"             "0.0"  
    "CLKOUT3_DIVIDE"            "1"  
    "CLKOUT3_DUTY_CYCLE"        "0.5"  
    "CLKOUT3_PHASE"             "0.0"  
    "CLKOUT4_DIVIDE"            "1"  
    "CLKOUT4_DUTY_CYCLE"        "0.5"  
    "CLKOUT4_PHASE"             "0.0"  
    "CLKOUT4_CASCADE"           "false"
    "CLKOUT5_DIVIDE"            "1"  
    "CLKOUT5_DUTY_CYCLE"        "0.5"  
    "CLKOUT5_PHASE"             "0.0"  
    "CLKOUT6_DIVIDE"            "1"  
    "CLKOUT6_DUTY_CYCLE"        "0.5"  
    "CLKOUT6_PHASE"             "0.0"  
    "CLKOUT0_USE_FINE_PS"       "false"
    "CLKOUT1_USE_FINE_PS"       "false"
    "CLKOUT2_USE_FINE_PS"       "false"
    "CLKOUT3_USE_FINE_PS"       "false"
    "CLKOUT4_USE_FINE_PS"       "false"
    "CLKOUT5_USE_FINE_PS"       "false"
    "CLKOUT6_USE_FINE_PS"       "false"
    "COMPENSATION"              "\"ZHOLD\""  
    "DIVCLK_DIVIDE"             "1"  
    "REF_JITTER1"               "0.010"  
    "CLKIN1_BUF"                "false"
    "CLKFBOUT_BUF"              "false"
    "CLKOUT0_BUF"               "false"
    "CLKOUT1_BUF"               "false"
    "CLKOUT2_BUF"               "false"
    "CLKOUT3_BUF"               "false"
    "CLKOUT4_BUF"               "false"
    "CLKOUT5_BUF"               "false"
    "CLKOUT6_BUF"               "false"
    "CLOCK_HOLD"                "false"
    "STARTUP_WAIT"              "false"
    "EXT_RESET_HIGH"            "1"
    "FAMILY"                    "\"virtex6\""
  }
  return $mmcm_params
}

proc get_clkgen_mmcm_params {} {
  set mmcm_params {}
  set mmcm_default_param_table [get_clkgen_mmcm_default_params]
	array set mmcm_default_params $mmcm_default_param_table
  set index 1
  foreach param $mmcm_default_param_table {
    if { $index > 0 } {
		  lappend mmcm_params $param
    }
    set index [expr 0 - $index]
  }
  return $mmcm_params
}

proc get_clkgen_mmcm_params_connection {} {
  set mmcm_names { "MMCM0" "MMCM1" "MMCM2" "MMCM3" }
  set mmcm_params {
    "CLKIN1_MODULE"
    "CLKIN1_PORT"
    "CLKFBIN_MODULE"
    "CLKFBIN_PORT"
    "RST_MODULE"
  }
  return $mmcm_params
}


# ----------------------------------------------------------------------------
# write hdl wrapper
# ----------------------------------------------------------------------------

proc write_hdl_wrapper { filepath param_table } {

	set hdlfile [open $filepath "w"]

	# put the PARAMETER name value pairs into an associative array 
	# for easy access Ex: set instance_name $params(INSTANCE)
	# array set params $param_table
	# set hdllib $params(INSTANCE)

	array set params $param_table

  # -----------------------------------
  # $mhsinst is not used in following
  # -----------------------------------

  # 1.  header
  set drawline40 "----------------------------------------";
  set drawline38 "--------------------------------------";
  set drawline78 "$drawline40$drawline38";
	puts $hdlfile \
"$drawline78
-- $filepath
$drawline78

-- ClkGen Wrapper HDL file generated by ClkGen's TCL generator 
" 

  # -----------------------------------

  # 2. include library
  puts $hdlfile "
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.numeric_std.all;

library Unisim;
use Unisim.vcomponents.all;

library clock_generator_v4_00_a;
use clock_generator_v4_00_a.all;
"

  # -----------------------------------

  # 3. entity
  write_hdl_entity $hdlfile $param_table

  # -----------------------------------

  # 4. architecture is
  puts $hdlfile "
architecture STRUCTURE of clock_generator is
" 

  # -----------------------------------

  # 4.1. components 

  foreach dcm [get_clkgen_dcm_names] {
    if { $params([format "C_%s_CLKIN_MODULE" $dcm]) != "" && 
         $params([format "C_%s_CLKIN_MODULE" $dcm]) != "NONE" } {
      write_hdl_component_dcm_module $hdlfile 
      break;
    }
  }

  foreach pll [get_clkgen_pll_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $pll]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $pll]) != "NONE" } {
      write_hdl_component_pll_module $hdlfile 
      break;
    }
  }

  foreach mmcm [get_clkgen_mmcm_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "NONE" } {
      write_hdl_component_mmcm_module $hdlfile 
      break;
    }
  }

  # -----------------------------------

  # 4.2. functions
  write_hdl_function $hdlfile 

  # -----------------------------------

  # 4.3. signals
  write_hdl_signal_gnd_vcc $hdlfile 

  foreach dcm [get_clkgen_dcm_names] {
    if { $params([format "C_%s_CLKIN_MODULE" $dcm]) != "" && 
         $params([format "C_%s_CLKIN_MODULE" $dcm]) != "NONE" } {
      write_hdl_signal_dcm_module_wrapper $hdlfile $dcm
    }
  }

  foreach pll [get_clkgen_pll_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $pll]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $pll]) != "NONE" } {
      write_hdl_signal_pll_module_wrapper $hdlfile $pll
    }
  }

  foreach mmcm [get_clkgen_mmcm_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "NONE" } {
      write_hdl_signal_mmcm_module_wrapper $hdlfile $mmcm
    }
  }

  # -----------------------------------

  # 5. architecture begin
	puts $hdlfile "
begin
"

  # -----------------------------------

  # 5.1. gnd and vcc signals
	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- GND and VCC signals
  ----------------------------------------------------------------------------

  net_gnd0           <= '0';
  net_gnd1(0 to 0)   <= B\"0\";
  net_gnd16(0 to 15) <= B\"0000000000000000\";

  net_vdd0           <= '1';
"

  # -----------------------------------

  # 5.2. Instances
	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- DCM wrappers
  ----------------------------------------------------------------------------
"
  foreach dcm [get_clkgen_dcm_names] {
    if { $params([format "C_%s_CLKIN_MODULE" $dcm]) != "" && 
         $params([format "C_%s_CLKIN_MODULE" $dcm]) != "NONE" } {
      write_hdl_dcm_module_wrrapper $hdlfile $param_table $dcm
    }
  }

	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- PLL wrappers
  ----------------------------------------------------------------------------
"
  foreach pll [get_clkgen_pll_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $pll]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $pll]) != "NONE" } {
      write_hdl_pll_module_wrrapper $hdlfile $param_table $pll
    }
  }

	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- MMCM wrappers
  ----------------------------------------------------------------------------
"
  foreach mmcm [get_clkgen_mmcm_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "NONE" } {
      write_hdl_mmcm_module_wrrapper $hdlfile $param_table $mmcm
    }
  }

  # -----------------------------------

  # 5.3. Connection
	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- DCMs CLKIN, CLKFB and RST signal connection
  ----------------------------------------------------------------------------
"
  foreach dcm [get_clkgen_dcm_names] {
    if { $params([format "C_%s_CLKIN_MODULE" $dcm]) != "" && 
         $params([format "C_%s_CLKIN_MODULE" $dcm]) != "NONE" } {
      write_hdl_dcm_input_connection $hdlfile $param_table $dcm
    }
  }

	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- PLLs CLKIN1, CLKFBIN and RST signal connection
  ----------------------------------------------------------------------------
"
  foreach pll [get_clkgen_pll_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $pll]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $pll]) != "NONE" } {
      write_hdl_pll_input_connection $hdlfile $param_table $pll
    }
  }

	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- MMCMs CLKIN1, CLKFBIN, RST and Variable_Phase_Control signal connection
  ----------------------------------------------------------------------------
"
  foreach mmcm [get_clkgen_mmcm_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "NONE" } {
      write_hdl_mmcm_input_connection $hdlfile $param_table $mmcm
    }
  }

	puts $hdlfile "
  ----------------------------------------------------------------------------
  -- CLKGEN CLKOUT, CLKFBOUT and LOCKED signal connection
  ----------------------------------------------------------------------------
"
  write_hdl_clkgen_output_connection $hdlfile $param_table

  # -----------------------------------

	if { $params(C_CLK_GEN) == "UPDATE" } {
    # TODO
	}
	
  # c. architecture end
  puts $hdlfile "
end architecture STRUCTURE;
"
  # -----------------------------------
  # optional print out
  # -----------------------------------

  write_hdl_param_table $hdlfile $param_table

  # -----------------------------------

	close $hdlfile

  return 0
}

# --------------------------------------

proc write_hdl_param_table { hdlfile param_table } {
	array set params $param_table

  set drawline40 "----------------------------------------";
  set drawline38 "--------------------------------------";
  set drawline78 "$drawline40$drawline38";

  # ----- High-level -----  
  puts $hdlfile "
$drawline78
-- High level parameters
$drawline78
"

  # CLKGEN
  puts "$drawline40"
	foreach param [get_clkgen_params] {
    puts $hdlfile "-- $param = $params($param)"
	}
  puts $hdlfile "
$drawline40
"
  # CLKIN
  foreach clkin [get_clkgen_clkin_names] {
    foreach param [get_clkgen_clkin_params] {
      set clkin_param [format "C_%s_%s" $clkin $param]
      set clkin_value $params($clkin_param)
      puts $hdlfile "-- $clkin_param = $clkin_value"
    }
  }
  puts $hdlfile ""

  # CLKOUT
  foreach clkout [get_clkgen_clkout_names] {
    foreach param [get_clkgen_clkout_params] {
      set clkout_param [format "C_%s_%s" $clkout $param]
      set clkout_value $params($clkout_param)
      puts $hdlfile "-- $clkout_param = $clkout_value"
    }
  }
  puts $hdlfile "
$drawline40
"
  # CLKFBIN
  foreach clkfbin [get_clkgen_clkfbin_names] {
    foreach param [get_clkgen_clkfbin_params] {
      set clkfbin_param [format "C_%s_%s" $clkfbin $param]
      set clkfbin_value $params($clkfbin_param)
      puts $hdlfile "-- $clkfbin_param = $clkfbin_value"
    }
  }
  puts $hdlfile ""

  # CLKFBOUT
  foreach clkfbout [get_clkgen_clkfbout_names] {
    foreach param [get_clkgen_clkfbout_params] {
      set clkfbout_param [format "C_%s_%s" $clkfbout $param]
      set clkfbout_value $params($clkfbout_param)
      puts $hdlfile "-- $clkfbout_param = $clkfbout_value"
    }
  }
  puts $hdlfile "
$drawline40
"

  # PSDONE
  foreach psdone [get_clkgen_psdone_names] {
    foreach param [get_clkgen_psdone_params] {
      set psdone_param [format "C_%s_%s" $psdone $param]
      set psdone_value $params($psdone_param)
      puts $hdlfile "-- $psdone_param = $psdone_value"
    }
  }

  # ----- Low-level -----
  puts $hdlfile "
$drawline78
-- Low level parameters
$drawline78
"

  # CLKOUT
  foreach clkout [get_clkgen_clkout_names] {
    foreach param [get_clkgen_clkout_params_connection] {
      set clkout_param [format "C_%s_%s" $clkout $param]
      set clkout_value $params($clkout_param)
      puts $hdlfile "-- $clkout_param = $clkout_value"
    }
  }
  puts $hdlfile "
$drawline40
"

  # CLKFBOUT
  foreach clkfbout [get_clkgen_clkfbout_names] {
    foreach param [get_clkgen_clkfbout_params_connection] {
      set clkfbout_param [format "C_%s_%s" $clkfbout $param]
      set clkfbout_value $params($clkfbout_param)
      puts $hdlfile "-- $clkfbout_param = $clkfbout_value"
    }
  }
  puts $hdlfile "
$drawline40
"

  # PSDONE
  foreach psdone [get_clkgen_psdone_names] {
    foreach param [get_clkgen_psdone_params_connection] {
      set psdone_param [format "C_%s_%s" $psdone $param]
      set psdone_value $params($psdone_param)
      puts $hdlfile "-- $psdone_param = $psdone_value"
    }
  }
  puts $hdlfile "
$drawline40
"

  # DCM
  foreach dcm [get_clkgen_dcm_names] {
    foreach param [get_clkgen_dcm_params] {
      set dcm_param [format "C_%s_%s" $dcm $param]
      set dcm_value $params($dcm_param)
      puts $hdlfile "-- $dcm_param = $dcm_value"
    }
    puts $hdlfile ""
    foreach param [get_clkgen_dcm_params_connection] {
      set dcm_param [format "C_%s_%s" $dcm $param]
      set dcm_value $params($dcm_param)
      puts $hdlfile "-- $dcm_param = $dcm_value"
    }
    puts $hdlfile ""
  }
  puts $hdlfile "
$drawline40
"

  # PLL
  foreach pll [get_clkgen_pll_names] {
    foreach param [get_clkgen_pll_params] {
      set pll_param [format "C_%s_%s" $pll $param]
      set pll_value $params($pll_param)
      puts $hdlfile "-- $pll_param = $pll_value"
    }
    puts $hdlfile ""
    foreach param [get_clkgen_pll_params_connection] {
      set pll_param [format "C_%s_%s" $pll $param]
      set pll_value $params($pll_param)
      puts $hdlfile "-- $pll_param = $pll_value"
    }
    puts $hdlfile ""
  }
  puts $hdlfile "
$drawline40
"

  # MMCM
  foreach mmcm [get_clkgen_mmcm_names] {
    foreach param [get_clkgen_mmcm_params] {
      set mmcm_param [format "C_%s_%s" $mmcm $param]
      set mmcm_value $params($mmcm_param)
      puts $hdlfile "-- $mmcm_param = $mmcm_value"
    }
    puts $hdlfile ""
    foreach param [get_clkgen_mmcm_params_connection] {
      set mmcm_param [format "C_%s_%s" $mmcm $param]
      set mmcm_value $params($mmcm_param)
      puts $hdlfile "-- $mmcm_param = $mmcm_value"
    }
    puts $hdlfile ""
  }
  puts $hdlfile "
$drawline40
"

}

# --------------------------------------

proc write_hdl_entity { hdlfile param_table } {
	array set params $param_table

  puts $hdlfile "
entity clock_generator is
  generic (
    C_FAMILY           : string   := \"$params(C_FAMILY)\" ;
    C_DEVICE           : string   := \"$params(C_DEVICE)\";
    C_PACKAGE          : string   := \"$params(C_PACKAGE)\";
    C_SPEEDGRADE       : string   := \"$params(C_SPEEDGRADE)\";
    C_CLK_GEN          : string   := \"$params(C_CLK_GEN)\"
  );
  port (
    -- clock generation
    CLKIN                         : in  std_logic;
    CLKOUT0                       : out std_logic;
    CLKOUT1                       : out std_logic;
    CLKOUT2                       : out std_logic;
    CLKOUT3                       : out std_logic;
    CLKOUT4                       : out std_logic;
    CLKOUT5                       : out std_logic;
    CLKOUT6                       : out std_logic;
    CLKOUT7                       : out std_logic;
    CLKOUT8                       : out std_logic;
    CLKOUT9                       : out std_logic;
    CLKOUT10                      : out std_logic;
    CLKOUT11                      : out std_logic;
    CLKOUT12                      : out std_logic;
    CLKOUT13                      : out std_logic;
    CLKOUT14                      : out std_logic;
    CLKOUT15                      : out std_logic;
    -- external feedback 
    CLKFBIN                       : in  std_logic;
    CLKFBOUT                      : out std_logic;
    -- variable phase shift
    PSCLK                         : in  std_logic;
    PSEN                          : in  std_logic;
    PSINCDEC                      : in  std_logic;
    PSDONE                        : out std_logic;
    -- reset
    RST                           : in  std_logic;
    LOCKED                        : out std_logic
  );
end clock_generator;
"
}

# --------------------------------------

proc write_hdl_component_dcm_module { hdlfile } {
  puts $hdlfile "
  ----------------------------------------------------------------------------
  -- Components ( copy from entity, exact the same in low level parameters )
  ----------------------------------------------------------------------------

  component dcm_module is
    generic (
      C_DFS_FREQUENCY_MODE    : string  := \"LOW\";
      C_DLL_FREQUENCY_MODE    : string  := \"LOW\";
      C_DUTY_CYCLE_CORRECTION : boolean := true;
      C_CLKIN_DIVIDE_BY_2     : boolean := false;
      C_CLK_FEEDBACK          : string  := \"1X\";
      C_CLKOUT_PHASE_SHIFT    : string  := \"NONE\";
      C_DSS_MODE              : string  := \"NONE\";
      C_STARTUP_WAIT          : boolean := false;
      C_PHASE_SHIFT           : integer := 0;
      C_CLKFX_MULTIPLY        : integer := 4;
      C_CLKFX_DIVIDE          : integer := 1;
      C_CLKDV_DIVIDE          : real    := 2.0;
      C_CLKIN_PERIOD          : real    := 41.6666666;
      C_DESKEW_ADJUST         : string  := \"SYSTEM_SYNCHRONOUS\";
      C_CLKIN_BUF             : boolean := false;
      C_CLKFB_BUF             : boolean := false;
      C_CLK0_BUF              : boolean := false;
      C_CLK90_BUF             : boolean := false;
      C_CLK180_BUF            : boolean := false;
      C_CLK270_BUF            : boolean := false;
      C_CLKDV_BUF             : boolean := false;
      C_CLK2X_BUF             : boolean := false;
      C_CLK2X180_BUF          : boolean := false;
      C_CLKFX_BUF             : boolean := false;
      C_CLKFX180_BUF          : boolean := false;
      C_EXT_RESET_HIGH        : integer := 1;
      C_FAMILY                : string  := \"spartan6\"
      );
    port (
      RST      : in  std_logic;
      CLKIN    : in  std_logic;
      CLKFB    : in  std_logic;
      PSEN     : in  std_logic;
      PSINCDEC : in  std_logic;
      PSCLK    : in  std_logic;
      DSSEN    : in  std_logic;
      CLK0     : out std_logic;
      CLK90    : out std_logic;
      CLK180   : out std_logic;
      CLK270   : out std_logic;
      CLKDV    : out std_logic;
      CLK2X    : out std_logic;
      CLK2X180 : out std_logic;
      CLKFX    : out std_logic;
      CLKFX180 : out std_logic;
      STATUS   : out std_logic_vector(7 downto 0);
      LOCKED   : out std_logic;
      PSDONE   : out std_logic
      );
  end component;
"
}

# --------------------------------------

proc write_hdl_component_pll_module { hdlfile } {
  puts $hdlfile "
  ----------------------------------------------------------------------------
  -- Components ( copy from entity, exact the same in low level parameters )
  ----------------------------------------------------------------------------

  component pll_module is
    generic (
      C_BANDWIDTH              : string  := \"OPTIMIZED\";           
      C_CLKFBOUT_MULT          : integer := 1;  
      C_CLKFBOUT_PHASE         : real    := 0.0;  
      C_CLKIN1_PERIOD          : real    := 0.000;  
      -- C_CLKIN2_PERIOD       : real    := 0.000;  
      C_CLKOUT0_DIVIDE         : integer := 1;  
      C_CLKOUT0_DUTY_CYCLE     : real    := 0.5;  
      C_CLKOUT0_PHASE          : real    := 0.0;  
      C_CLKOUT1_DIVIDE         : integer := 1;  
      C_CLKOUT1_DUTY_CYCLE     : real    := 0.5;  
      C_CLKOUT1_PHASE          : real    := 0.0;  
      C_CLKOUT2_DIVIDE         : integer := 1;  
      C_CLKOUT2_DUTY_CYCLE     : real    := 0.5;  
      C_CLKOUT2_PHASE          : real    := 0.0;  
      C_CLKOUT3_DIVIDE         : integer := 1;  
      C_CLKOUT3_DUTY_CYCLE     : real    := 0.5;  
      C_CLKOUT3_PHASE          : real    := 0.0;  
      C_CLKOUT4_DIVIDE         : integer := 1;  
      C_CLKOUT4_DUTY_CYCLE     : real    := 0.5;  
      C_CLKOUT4_PHASE          : real    := 0.0;  
      C_CLKOUT5_DIVIDE         : integer := 1;  
      C_CLKOUT5_DUTY_CYCLE     : real    := 0.5;  
      C_CLKOUT5_PHASE          : real    := 0.0;  
      C_COMPENSATION           : string  := \"SYSTEM_SYNCHRONOUS\";  
      C_DIVCLK_DIVIDE          : integer := 1;  
      -- C_EN_REL              : boolean := false;  
      -- C_PLL_PMCD_MODE       : boolean := false;  
      C_REF_JITTER             : real    := 0.100;  
      C_RESET_ON_LOSS_OF_LOCK  : boolean := false;  
      C_RST_DEASSERT_CLK       : string  := \"CLKIN1\";  
      C_CLKOUT0_DESKEW_ADJUST  : string  := \"NONE\";  
      C_CLKOUT1_DESKEW_ADJUST  : string  := \"NONE\";  
      C_CLKOUT2_DESKEW_ADJUST  : string  := \"PPC\"; 
      C_CLKOUT3_DESKEW_ADJUST  : string  := \"PPC\"; 
      C_CLKOUT4_DESKEW_ADJUST  : string  := \"PPC\"; 
      C_CLKOUT5_DESKEW_ADJUST  : string  := \"PPC\"; 
      C_CLKFBOUT_DESKEW_ADJUST : string  := \"PPC\"; 
      C_CLKIN1_BUF             : boolean := false;
      -- C_CLKIN2_BUF          : boolean := false;
      C_CLKFBOUT_BUF           : boolean := false;
      C_CLKOUT0_BUF            : boolean := false;
      C_CLKOUT1_BUF            : boolean := false;
      C_CLKOUT2_BUF            : boolean := false;
      C_CLKOUT3_BUF            : boolean := false;
      C_CLKOUT4_BUF            : boolean := false;
      C_CLKOUT5_BUF            : boolean := false;
      C_EXT_RESET_HIGH         : integer := 1;
      C_FAMILY                 : string  := \"spartan6\"
      );
    port (
      CLKFBDCM         : out std_logic;
      CLKFBOUT         : out std_logic;
      CLKOUT0          : out std_logic;
      CLKOUT1          : out std_logic;
      CLKOUT2          : out std_logic;
      CLKOUT3          : out std_logic;
      CLKOUT4          : out std_logic;
      CLKOUT5          : out std_logic;
      CLKOUTDCM0       : out std_logic;
      CLKOUTDCM1       : out std_logic;
      CLKOUTDCM2       : out std_logic;
      CLKOUTDCM3       : out std_logic;
      CLKOUTDCM4       : out std_logic;
      CLKOUTDCM5       : out std_logic;
      -- DO               : out std_logic_vector (15 downto 0);
      -- DRDY             : out std_logic;
      LOCKED           : out std_logic;
      CLKFBIN          : in  std_logic;
      CLKIN1           : in  std_logic;
      -- CLKIN2           : in  std_logic;
      -- CLKINSEL         : in  std_logic;
      -- DADDR            : in  std_logic_vector (4 downto 0);
      -- DCLK             : in  std_logic;
      -- DEN              : in  std_logic;
      -- DI               : in  std_logic_vector (15 downto 0);
      -- DWE              : in  std_logic;
      -- REL              : in  std_logic;
      RST              : in  std_logic
      );
  end component;
"
}

# --------------------------------------

proc write_hdl_component_mmcm_module { hdlfile } {
  puts $hdlfile "
  ----------------------------------------------------------------------------
  -- Components ( copy from entity, exact the same in low level parameters )
  ----------------------------------------------------------------------------

  component mmcm_module is
    generic (
      C_BANDWIDTH             : string  := \"OPTIMIZED\"; 
      C_CLKFBOUT_MULT_F       : real    := 1.0;  
      C_CLKFBOUT_PHASE        : real    := 0.0;  
      C_CLKFBOUT_USE_FINE_PS  : boolean := false;
      C_CLKIN1_PERIOD         : real    := 0.000;  
      C_CLKOUT0_DIVIDE_F      : real    := 1.0;  
      C_CLKOUT0_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT0_PHASE         : real    := 0.0;  
      C_CLKOUT1_DIVIDE        : integer := 1;  
      C_CLKOUT1_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT1_PHASE         : real    := 0.0;  
      C_CLKOUT2_DIVIDE        : integer := 1;  
      C_CLKOUT2_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT2_PHASE         : real    := 0.0;  
      C_CLKOUT3_DIVIDE        : integer := 1;  
      C_CLKOUT3_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT3_PHASE         : real    := 0.0;  
      C_CLKOUT4_DIVIDE        : integer := 1;  
      C_CLKOUT4_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT4_PHASE         : real    := 0.0;  
      C_CLKOUT4_CASCADE       : boolean := false;
      C_CLKOUT5_DIVIDE        : integer := 1;  
      C_CLKOUT5_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT5_PHASE         : real    := 0.0;  
      C_CLKOUT6_DIVIDE        : integer := 1;  
      C_CLKOUT6_DUTY_CYCLE    : real    := 0.5;  
      C_CLKOUT6_PHASE         : real    := 0.0;  
      C_CLKOUT0_USE_FINE_PS   : boolean := false;
      C_CLKOUT1_USE_FINE_PS   : boolean := false;
      C_CLKOUT2_USE_FINE_PS   : boolean := false;
      C_CLKOUT3_USE_FINE_PS   : boolean := false;
      C_CLKOUT4_USE_FINE_PS   : boolean := false;
      C_CLKOUT5_USE_FINE_PS   : boolean := false;
      C_CLKOUT6_USE_FINE_PS   : boolean := false;
      C_COMPENSATION          : string  := \"ZHOLD\";  
      C_DIVCLK_DIVIDE         : integer := 1;  
      C_REF_JITTER1           : real    := 0.010;  
      C_CLKIN1_BUF            : boolean := false;
      C_CLKFBOUT_BUF          : boolean := false;
      C_CLKOUT0_BUF           : boolean := false;
      C_CLKOUT1_BUF           : boolean := false;
      C_CLKOUT2_BUF           : boolean := false;
      C_CLKOUT3_BUF           : boolean := false;
      C_CLKOUT4_BUF           : boolean := false;
      C_CLKOUT5_BUF           : boolean := false;
      C_CLKOUT6_BUF           : boolean := false;
      C_CLOCK_HOLD            : boolean := false;
      C_STARTUP_WAIT          : boolean := false;
      C_EXT_RESET_HIGH        : integer := 1;
      C_FAMILY                : string  := \"virtex6\"
      );
    port (
      CLKFBOUT         : out std_logic;
      CLKFBOUTB        : out std_logic;
      CLKOUT0          : out std_logic;
      CLKOUT1          : out std_logic;
      CLKOUT2          : out std_logic;
      CLKOUT3          : out std_logic;
      CLKOUT4          : out std_logic;
      CLKOUT5          : out std_logic;
      CLKOUT6          : out std_logic;
      CLKOUT0B         : out std_logic;
      CLKOUT1B         : out std_logic;
      CLKOUT2B         : out std_logic;
      CLKOUT3B         : out std_logic;
      LOCKED           : out std_logic;
      CLKFBSTOPPED     : out std_logic;
      CLKINSTOPPED     : out std_logic;
      PSDONE           : out std_logic;
      CLKFBIN          : in  std_logic;
      CLKIN1           : in  std_logic;
      PWRDWN           : in  std_logic;
      PSCLK            : in  std_logic;
      PSEN             : in  std_logic;
      PSINCDEC         : in  std_logic;
      RST              : in  std_logic
      );
  end component;
"
}

# --------------------------------------

proc write_hdl_function { hdlfile } {
  puts $hdlfile "
  ----------------------------------------------------------------------------
  -- Functions
  ----------------------------------------------------------------------------

  -- Note : The string functions are put here to remove dependency to other pcore level libraries

  function UpperCase_Char(char : character) return character is
  begin
    -- If char is not an upper case letter then return char
    if char < 'a' or char > 'z' then
      return char;
    end if;
    -- Otherwise map char to its corresponding lower case character and
    -- return that
    case char is
      when 'a'    => return 'A'; when 'b' => return 'B'; when 'c' => return 'C'; when 'd' => return 'D';
      when 'e'    => return 'E'; when 'f' => return 'F'; when 'g' => return 'G'; when 'h' => return 'H';
      when 'i'    => return 'I'; when 'j' => return 'J'; when 'k' => return 'K'; when 'l' => return 'L';
      when 'm'    => return 'M'; when 'n' => return 'N'; when 'o' => return 'O'; when 'p' => return 'P';
      when 'q'    => return 'Q'; when 'r' => return 'R'; when 's' => return 'S'; when 't' => return 'T';
      when 'u'    => return 'U'; when 'v' => return 'V'; when 'w' => return 'W'; when 'x' => return 'X';
      when 'y'    => return 'Y'; when 'z' => return 'Z';
      when others => return char;
    end case;
  end UpperCase_Char;

  function UpperCase_String (s : string) return string is
    variable res               : string(s'range);
  begin  -- function LoweerCase_String
    for I in s'range loop
      res(I) := UpperCase_Char(s(I));
    end loop;  -- I
    return res;
  end function UpperCase_String;

  -- Returns true if case insensitive string comparison determines that
  -- str1 and str2 are equal
  function equalString( str1, str2 : string ) return boolean is
    constant len1                  : integer := str1'length;
    constant len2                  : integer := str2'length;
    variable equal                 : boolean := true;
  begin
    if not (len1 = len2) then
      equal := false;
    else
      for i in str1'range loop
        if not (UpperCase_Char(str1(i)) = UpperCase_Char(str2(i))) then
          equal := false;
        end if;
      end loop;
    end if;

    return equal;
  end equalString;
"
}

# --------------------------------------

proc write_hdl_signal_gnd_vcc { hdlfile } {
  puts $hdlfile "
  ----------------------------------------------------------------------------
  -- Signals
  ----------------------------------------------------------------------------

  -- signals: gnd

  signal net_gnd0  : std_logic;
  signal net_gnd1  : std_logic_vector(0 to 0);
  signal net_gnd16 : std_logic_vector(0 to 15);

  -- signals: vdd

  signal net_vdd0  : std_logic;
"
}

# --------------------------------------

proc write_hdl_signal_dcm_module_wrapper { hdlfile dcmname } {
  puts $hdlfile "
  -- signals : $dcmname wrapper\n 
  signal   SIG_[format "%s" $dcmname]_RST              : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKIN            : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKFB            : std_logic;
  signal   SIG_[format "%s" $dcmname]_PSEN             : std_logic;
  signal   SIG_[format "%s" $dcmname]_PSINCDEC         : std_logic;
  signal   SIG_[format "%s" $dcmname]_PSCLK            : std_logic;
  signal   SIG_[format "%s" $dcmname]_DSSEN            : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK0             : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK90            : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK180           : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK270           : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKDV            : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKDV180         : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK2X            : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK2X180         : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKFX            : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKFX180         : std_logic;
  signal   SIG_[format "%s" $dcmname]_STATUS           : std_logic;
  signal   SIG_[format "%s" $dcmname]_LOCKED           : std_logic;
  signal   SIG_[format "%s" $dcmname]_PSDONE           : std_logic;

  signal   SIG_[format "%s" $dcmname]_CLK0_BUF         : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK90_BUF        : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK180_BUF       : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK270_BUF       : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKDV_BUF        : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKDV180_BUF     : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK2X_BUF        : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLK2X180_BUF     : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKFX_BUF        : std_logic;
  signal   SIG_[format "%s" $dcmname]_CLKFX180_BUF     : std_logic;
"
}

# --------------------------------------

proc write_hdl_signal_pll_module_wrapper { hdlfile pllname } {
  puts $hdlfile "
  -- signals : $pllname wrapper\n 
  signal   SIG_[format "%s" $pllname]_CLKFBDCM         : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKFBOUT         : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT0          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT1          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT2          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT3          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT4          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT5          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUTDCM0       : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUTDCM1       : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUTDCM2       : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUTDCM3       : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUTDCM4       : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUTDCM5       : std_logic;
  signal   SIG_[format "%s" $pllname]_LOCKED           : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKFBIN          : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKIN1           : std_logic;
  signal   SIG_[format "%s" $pllname]_RST              : std_logic;

  signal   SIG_[format "%s" $pllname]_CLKFBOUT_BUF     : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT0_BUF      : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT1_BUF      : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT2_BUF      : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT3_BUF      : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT4_BUF      : std_logic;
  signal   SIG_[format "%s" $pllname]_CLKOUT5_BUF      : std_logic;
"
}

# --------------------------------------

proc write_hdl_signal_mmcm_module_wrapper { hdlfile mmcmname } {
  puts $hdlfile "
  -- signals : $mmcmname wrapper\n 
  signal   SIG_[format "%s" $mmcmname]_CLKFBOUT         : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKFBOUTB        : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT0          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT1          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT2          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT3          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT4          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT5          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT6          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT0B         : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT1B         : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT2B         : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT3B         : std_logic;
  signal   SIG_[format "%s" $mmcmname]_LOCKED           : std_logic;
  signal   SIG_[format "%s" $mmcmname]_PSDONE           : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKFBIN          : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKIN1           : std_logic;
  signal   SIG_[format "%s" $mmcmname]_PSCLK            : std_logic;
  signal   SIG_[format "%s" $mmcmname]_PSEN             : std_logic;
  signal   SIG_[format "%s" $mmcmname]_PSINCDEC         : std_logic;
  signal   SIG_[format "%s" $mmcmname]_RST              : std_logic;

  signal   SIG_[format "%s" $mmcmname]_CLKFBOUT_BUF     : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT0_BUF      : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT1_BUF      : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT2_BUF      : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT3_BUF      : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT4_BUF      : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT5_BUF      : std_logic;
  signal   SIG_[format "%s" $mmcmname]_CLKOUT6_BUF      : std_logic;
"
}

# --------------------------------------

proc write_hdl_dcm_module_wrrapper { hdlfile param_table dcmname } {
	array set params $param_table

  puts $hdlfile "
  -- $dcmname wrapper\n 
  [format "%s_INST" $dcmname] : dcm_module
    generic map ("

  foreach param [get_clkgen_dcm_params] {
    if { $param == "CLKIN_BUF" ||
         $param == "CLKFB_BUF" ||
         $param == "CLK0_BUF" ||
         $param == "CLK90_BUF" ||
         $param == "CLK180_BUF" ||
         $param == "CLK270_BUF" ||
         $param == "CLKDV_BUF" ||
         $param == "CLK2X_BUF" ||
         $param == "CLK2X180_BUF" ||
         $param == "CLKFX_BUF" ||
         $param == "CLKFX180_BUF" } {
      puts $hdlfile "      [format "C_%s" $param] => false,"
    } elseif { $param == "FAMILY" } {
      puts $hdlfile "      [format "C_%s" $param] => $params([format "C_%s_%s" $dcmname $param])"
    } else {
      puts $hdlfile "      [format "C_%s" $param] => $params([format "C_%s_%s" $dcmname $param]),"
    }
  }

  puts $hdlfile "      )
    port map (
      RST                      => SIG_[format "%s" $dcmname]_RST,
      CLKIN                    => SIG_[format "%s" $dcmname]_CLKIN,
      CLKFB                    => SIG_[format "%s" $dcmname]_CLKFB,
      PSEN                     => SIG_[format "%s" $dcmname]_PSEN,
      PSINCDEC                 => SIG_[format "%s" $dcmname]_PSINCDEC,
      PSCLK                    => SIG_[format "%s" $dcmname]_PSCLK,
      DSSEN                    => net_gnd0,
      CLK0                     => SIG_[format "%s" $dcmname]_CLK0,
      CLK90                    => SIG_[format "%s" $dcmname]_CLK90,
      CLK180                   => open,
      CLK270                   => open,
      CLKDV                    => SIG_[format "%s" $dcmname]_CLKDV,
      CLK2X                    => SIG_[format "%s" $dcmname]_CLK2X,
      CLK2X180                 => open,
      CLKFX                    => SIG_[format "%s" $dcmname]_CLKFX,   
      CLKFX180                 => open,
      STATUS                   => open, 
      LOCKED                   => SIG_[format "%s" $dcmname]_LOCKED,
      PSDONE                   => SIG_[format "%s" $dcmname]_PSDONE
      );
"

  set clkout_names { "CLK0" "CLK90" "CLK2X" "CLKDV" "CLKFX" }
  set clkinv_table { "CLK0" "CLK180" "CLK90" "CLK270" "CLK2X" "CLK2X180" "CLKDV" "CLKDV180" "CLKFX" "CLKFX180" }
  array set clkinv $clkinv_table

  foreach clkout $clkout_names {
    puts $hdlfile "
  -- wrapper of clkout : $clkout and clkinv : $clkinv($clkout)
"
    if { $clkout == "CLKDV" } {
      if { $params([format "C_%s_%s_BUF" $dcmname $clkout]) == "TRUE" } {
        puts $hdlfile "
  [format "%s_%s_BUFG_INST" $dcmname $clkout] : BUFG
    port map (
      I => [format "SIG_%s_%s" $dcmname $clkout],
      O => [format "SIG_%s_%s_BUF" $dcmname $clkout]
      );
"
      } else {
        puts $hdlfile "
  [format "SIG_%s_%s_BUF" $dcmname $clkout] <= [format "SIG_%s_%s" $dcmname $clkout];
"
      }
    } else {
      if { $params([format "C_%s_%s_BUF" $dcmname $clkout]) == "TRUE" ||
         $params([format "C_%s_%s_BUF" $dcmname $clkinv($clkout)]) == "TRUE" } {
        puts $hdlfile "
  [format "%s_%s_BUFG_INST" $dcmname $clkout] : BUFG
    port map (
      I => [format "SIG_%s_%s" $dcmname $clkout],
      O => [format "SIG_%s_%s_BUF" $dcmname $clkout]
      );
"
      } else {
        puts $hdlfile "
  [format "SIG_%s_%s_BUF" $dcmname $clkout] <= [format "SIG_%s_%s" $dcmname $clkout];
"
      }
    }

    puts $hdlfile "
  [format "SIG_%s_%s" $dcmname $clkinv($clkout)] <= NOT [format "SIG_%s_%s" $dcmname $clkout];
  [format "SIG_%s_%s_BUF" $dcmname $clkinv($clkout)] <= NOT [format "SIG_%s_%s_BUF" $dcmname $clkout];
" 
  }
}

# --------------------------------------

proc write_hdl_pll_module_wrrapper { hdlfile param_table pllname } {
	array set params $param_table

  puts $hdlfile "
  -- $pllname wrapper\n 
  [format "%s_INST" $pllname] : pll_module
    generic map ("

  foreach param [get_clkgen_pll_params] {
    if { $param == "CLKIN1_BUF" ||
         $param == "CLKFBOUT_BUF" ||
         $param == "CLKOUT0_BUF" ||
         $param == "CLKOUT1_BUF" ||
         $param == "CLKOUT2_BUF" ||
         $param == "CLKOUT3_BUF" ||
         $param == "CLKOUT4_BUF" ||
         $param == "CLKOUT5_BUF" } {
      puts $hdlfile "      [format "C_%s" $param] => false,"
    } elseif { $param == "FAMILY" } {
      puts $hdlfile "      [format "C_%s" $param] => $params([format "C_%s_%s" $pllname $param])"
    } else {
      puts $hdlfile "      [format "C_%s" $param] => $params([format "C_%s_%s" $pllname $param]),"
    }
  }

  puts $hdlfile "      )
    port map (
      CLKFBDCM                 => SIG_[format "%s" $pllname]_CLKFBDCM,
      CLKFBOUT                 => SIG_[format "%s" $pllname]_CLKFBOUT,
      CLKOUT0                  => SIG_[format "%s" $pllname]_CLKOUT0,
      CLKOUT1                  => SIG_[format "%s" $pllname]_CLKOUT1,
      CLKOUT2                  => SIG_[format "%s" $pllname]_CLKOUT2,
      CLKOUT3                  => SIG_[format "%s" $pllname]_CLKOUT3,
      CLKOUT4                  => SIG_[format "%s" $pllname]_CLKOUT4,
      CLKOUT5                  => SIG_[format "%s" $pllname]_CLKOUT5,
      CLKOUTDCM0               => SIG_[format "%s" $pllname]_CLKOUTDCM0,
      CLKOUTDCM1               => SIG_[format "%s" $pllname]_CLKOUTDCM1,
      CLKOUTDCM2               => SIG_[format "%s" $pllname]_CLKOUTDCM2,
      CLKOUTDCM3               => SIG_[format "%s" $pllname]_CLKOUTDCM3,
      CLKOUTDCM4               => SIG_[format "%s" $pllname]_CLKOUTDCM4,
      CLKOUTDCM5               => SIG_[format "%s" $pllname]_CLKOUTDCM5,
      -- DO
      -- DRDY
      LOCKED                   => SIG_[format "%s" $pllname]_LOCKED,
      CLKFBIN                  => SIG_[format "%s" $pllname]_CLKFBIN,
      CLKIN1                   => SIG_[format "%s" $pllname]_CLKIN1,
      -- CLKIN2
      -- CLKINSEL
      -- DADDR
      -- DCLK
      -- DEN
      -- DI
      -- DWE
      -- REL
      RST                      => SIG_[format "%s" $pllname]_RST  
      );
"

  set clkout_names { "CLKOUT0" "CLKOUT1" "CLKOUT2" "CLKOUT3" "CLKOUT4" "CLKOUT5" "CLKFBOUT" }

  foreach clkout $clkout_names {
    puts $hdlfile "
  -- wrapper of clkout : $clkout 
"

    if { ( $params([format "C_%s_%s_BUF" $pllname $clkout]) == "TRUE" ) } {
      puts $hdlfile "
  [format "%s_%s_BUFG_INST" $pllname $clkout] : BUFG
    port map (
      I => [format "SIG_%s_%s" $pllname $clkout],
      O => [format "SIG_%s_%s_BUF" $pllname $clkout]
      );
"
    } else {
      puts $hdlfile "
  [format "SIG_%s_%s_BUF" $pllname $clkout] <= [format "SIG_%s_%s" $pllname $clkout];
"
    }
  }
}

# --------------------------------------

proc write_hdl_mmcm_module_wrrapper { hdlfile param_table mmcmname } {
	array set params $param_table

  puts $hdlfile "
  -- $mmcmname wrapper\n 
  [format "%s_INST" $mmcmname] : mmcm_module
    generic map ("

  foreach param [get_clkgen_mmcm_params] {
    if { $param == "CLKIN1_BUF" ||
         $param == "CLKFBOUT_BUF" ||
         $param == "CLKOUT0_BUF" ||
         $param == "CLKOUT1_BUF" ||
         $param == "CLKOUT2_BUF" ||
         $param == "CLKOUT3_BUF" ||
         $param == "CLKOUT4_BUF" ||
         $param == "CLKOUT5_BUF" ||
         $param == "CLKOUT6_BUF" } {
      puts $hdlfile "      [format "C_%s" $param] => false,"
    } elseif { $param == "FAMILY" } {
      puts $hdlfile "      [format "C_%s" $param] => $params([format "C_%s_%s" $mmcmname $param])"
    } else {
      puts $hdlfile "      [format "C_%s" $param] => $params([format "C_%s_%s" $mmcmname $param]),"
    }
  }

  puts $hdlfile "      )
    port map (
      CLKFBOUT                 => SIG_[format "%s" $mmcmname]_CLKFBOUT,
      CLKFBOUTB                => SIG_[format "%s" $mmcmname]_CLKFBOUTB,
      CLKOUT0                  => SIG_[format "%s" $mmcmname]_CLKOUT0,
      CLKOUT1                  => SIG_[format "%s" $mmcmname]_CLKOUT1,
      CLKOUT2                  => SIG_[format "%s" $mmcmname]_CLKOUT2,
      CLKOUT3                  => SIG_[format "%s" $mmcmname]_CLKOUT3,
      CLKOUT4                  => SIG_[format "%s" $mmcmname]_CLKOUT4,
      CLKOUT5                  => SIG_[format "%s" $mmcmname]_CLKOUT5,
      CLKOUT6                  => SIG_[format "%s" $mmcmname]_CLKOUT6,
      CLKOUT0B                 => SIG_[format "%s" $mmcmname]_CLKOUT0B,
      CLKOUT1B                 => SIG_[format "%s" $mmcmname]_CLKOUT1B,
      CLKOUT2B                 => SIG_[format "%s" $mmcmname]_CLKOUT2B,
      CLKOUT3B                 => SIG_[format "%s" $mmcmname]_CLKOUT3B,
      LOCKED                   => SIG_[format "%s" $mmcmname]_LOCKED,
      -- CLKFBSTOPPED          => 
      -- CLKINSTOPPED          => 
      PSDONE                   => SIG_[format "%s" $mmcmname]_PSDONE,
      CLKFBIN                  => SIG_[format "%s" $mmcmname]_CLKFBIN,
      CLKIN1                   => SIG_[format "%s" $mmcmname]_CLKIN1,
      PWRDWN                   => '0',
      PSCLK                    => SIG_[format "%s" $mmcmname]_PSCLK,
      PSEN                     => SIG_[format "%s" $mmcmname]_PSEN,
      PSINCDEC                 => SIG_[format "%s" $mmcmname]_PSINCDEC,
      RST                      => SIG_[format "%s" $mmcmname]_RST          
      );
"

  set clkout_names { "CLKOUT0" "CLKOUT1" "CLKOUT2" "CLKOUT3" "CLKOUT4" "CLKOUT5" "CLKOUT6" "CLKFBOUT" }

  foreach clkout $clkout_names {
    puts $hdlfile "
  -- wrapper of clkout : $clkout 
"

    if { ( $params([format "C_%s_%s_BUF" $mmcmname $clkout]) == "TRUE" ) } {
      puts $hdlfile "
  [format "%s_%s_BUFG_INST" $mmcmname $clkout] : BUFG
    port map (
      I => [format "SIG_%s_%s" $mmcmname $clkout],
      O => [format "SIG_%s_%s_BUF" $mmcmname $clkout]
      );
"
    } else {
      puts $hdlfile "
  [format "SIG_%s_%s_BUF" $mmcmname $clkout] <= [format "SIG_%s_%s" $mmcmname $clkout];
"
    }
  }
}

# --------------------------------------

proc write_hdl_clock_selection { param_table module port} {
	array set params $param_table

  # return the clock signal name that drives the module's clock input port

  set c_clkin_module ""
  set c_clkin_port ""
  set sig_clkin ""

  if { $module == "CLKGEN" } {
    set c_clkin_module $params([format "C_%s_MODULE" $port])
    set c_clkin_port $params([format "C_%s_PORT" $port])

  } else {
    set c_clkin_module $params([format "C_%s_%s_MODULE" $module $port]) 
    set c_clkin_port $params([format "C_%s_%s_PORT" $module $port])
  }

  # clock selection
  if { ( $c_clkin_module == "CLKGEN" ) } {
    if { ( $c_clkin_port == "CLKIN" ) } {
      set sig_clkin "CLKIN"
    } elseif { ( $c_clkin_port == "CLKFBIN" ) } {
      set sig_clkin "CLKFBIN"
    } else {
      set sig_clkin [format "%s_%s" $c_clkin_module $c_clkin_port]
    }
  } elseif { ( $c_clkin_module == "DCM0" ) ||  
             ( $c_clkin_module == "DCM1" ) || 
             ( $c_clkin_module == "DCM2" ) ||
             ( $c_clkin_module == "DCM3" ) } {
    # NO BUF
    if { ( $c_clkin_port == "CLK0" ) } {
      set sig_clkin [format "SIG_%s_CLK0" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK90" ) } {
      set sig_clkin [format "SIG_%s_CLK90" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK180" ) } {
      set sig_clkin [format "SIG_%s_CLK180" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK270" ) } {
      set sig_clkin [format "SIG_%s_CLK270" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK2X" ) } {
      set sig_clkin [format "SIG_%s_CLK2X" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK2X180" ) } {
      set sig_clkin [format "SIG_%s_CLK2X180" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKDV" ) } {
      set sig_clkin [format "SIG_%s_CLKDV" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKDV180" ) } {
      set sig_clkin [format "SIG_%s_CLKDV180" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFX" ) } {
      set sig_clkin [format "SIG_%s_CLKFX" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFX180" ) } {
      set sig_clkin [format "SIG_%s_CLKFX180" $c_clkin_module]
    # BUF
    } elseif { ( $c_clkin_port == "CLK0B" ) } {
      set sig_clkin [format "SIG_%s_CLK0_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK90B" ) } {
      set sig_clkin [format "SIG_%s_CLK90_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK180B" ) } {
      set sig_clkin [format "SIG_%s_CLK180_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK270B" ) } {
      set sig_clkin [format "SIG_%s_CLK270_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK2XB" ) } {
      set sig_clkin [format "SIG_%s_CLK2X_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLK2X180B" ) } {
      set sig_clkin [format "SIG_%s_CLK2X180_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKDVB" ) } {
      set sig_clkin [format "SIG_%s_CLKDV_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKDV180B" ) } {
      set sig_clkin [format "SIG_%s_CLKDV180_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFXB" ) } {
      set sig_clkin [format "SIG_%s_CLKFX_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFX180B" ) } {
      set sig_clkin [format "SIG_%s_CLKFX180_BUF" $c_clkin_module]
    # NOT_SET
    } else {
      set sig_clkin [format "%s_%s" $c_clkin_module $c_clkin_port]
    }
  } elseif { ( $c_clkin_module == "PLL0" ) ||  
             ( $c_clkin_module == "PLL1" ) } {
    # NO BUF
    if { ( $c_clkin_port == "CLKOUT0" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT0" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT1" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT1" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT2" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT2" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT3" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT3" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT4" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT4" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT5" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT5" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFBOUT" ) } {
      set sig_clkin [format "SIG_%s_CLKFBOUT" $c_clkin_module]
    # BUF
    } elseif { ( $c_clkin_port == "CLKOUT0B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT0_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT1B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT1_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT2B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT2_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT3B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT3_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT4B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT4_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT5B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT5_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFBOUTB" ) } {
      set sig_clkin [format "SIG_%s_CLKFBOUT_BUF" $c_clkin_module]
    # NOT_SET
    } else {
      set sig_clkin [format "%s_%s" $c_clkin_module $c_clkin_port]
    }
  } elseif { ( $c_clkin_module == "MMCM0" ) ||  
             ( $c_clkin_module == "MMCM1" ) || 
             ( $c_clkin_module == "MMCM2" ) ||
             ( $c_clkin_module == "MMCM3" ) } {
    # NO BUF
    if { ( $c_clkin_port == "CLKOUT0" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT0" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT1" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT1" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT2" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT2" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT3" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT3" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT4" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT4" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT5" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT5" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT6" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT6" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFBOUT" ) } {
      set sig_clkin [format "SIG_%s_CLKFBOUT" $c_clkin_module]
    # BUF
    } elseif { ( $c_clkin_port == "CLKOUT0B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT0_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT1B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT1_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT2B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT2_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT3B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT3_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT4B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT4_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT5B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT5_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKOUT6B" ) } {
      set sig_clkin [format "SIG_%s_CLKOUT6_BUF" $c_clkin_module]
    } elseif { ( $c_clkin_port == "CLKFBOUTB" ) } {
      set sig_clkin [format "SIG_%s_CLKFBOUT_BUF" $c_clkin_module]
    # NOT_SET
    } else {
      set sig_clkin [format "%s_%s" $c_clkin_module $c_clkin_port]
    }
  } else {
    set sig_clkin [format "%s_%s" $c_clkin_module $c_clkin_port]
  }

  return $sig_clkin
}

# --------------------------------------

proc write_hdl_reset_selection { param_table module port} {
	array set params $param_table

  # return the reset signal name that drives the module's reset input port

  set c_rstin_module ""
  set sig_rstin ""

  if { $module == "CLKGEN" } {
    set c_rstin_module $params([format "C_%s_MODULE" $port])
  } else {
    set c_rstin_module $params([format "C_%s_%s_MODULE" $module $port]) 
  }

  # clock selection
  if { ( $c_rstin_module == "CLKGEN" ) } {
    set sig_rstin "RST"
  } elseif { ( $c_rstin_module == "DCM0" ) ||  
             ( $c_rstin_module == "DCM1" ) || 
             ( $c_rstin_module == "DCM2" ) ||
             ( $c_rstin_module == "DCM3" ) ||
             ( $c_rstin_module == "PLL0" ) ||
             ( $c_rstin_module == "PLL1" ) ||
             ( $c_rstin_module == "MMCM0" ) ||
             ( $c_rstin_module == "MMCM1" ) ||
             ( $c_rstin_module == "MMCM2" ) ||
             ( $c_rstin_module == "MMCM3" ) } {
    set sig_rstin [format "SIG_%s_LOCKED" $c_rstin_module]
  } else {
    set sig_rstin [format "NOT_SET : %s" $c_rstin_module ]
  }

  return $sig_rstin
}

# --------------------------------------

proc write_hdl_dcm_input_connection { hdlfile param_table dcmname } {
	array set params $param_table

  puts $hdlfile "
  -- $dcmname CLKIN\n 
  [format "SIG_%s_CLKIN" $dcmname] <= [write_hdl_clock_selection $param_table $dcmname "CLKIN"];

  -- $dcmname CLKFB\n 
  [format "SIG_%s_CLKFB" $dcmname] <= [write_hdl_clock_selection $param_table $dcmname "CLKFB"];

  -- $dcmname RST\n 
  [format "SIG_%s_RST" $dcmname] <= [write_hdl_reset_selection $param_table $dcmname "RST"];

"
}

# --------------------------------------

proc write_hdl_pll_input_connection { hdlfile param_table pllname } {
	array set params $param_table

  puts $hdlfile "
  -- $pllname CLKIN1\n 
  [format "SIG_%s_CLKIN1" $pllname] <= [write_hdl_clock_selection $param_table $pllname "CLKIN1"];

  -- $pllname CLKFBIN\n 
  [format "SIG_%s_CLKFBIN" $pllname] <= [write_hdl_clock_selection $param_table $pllname "CLKFBIN"];

  -- $pllname RST\n 
  [format "SIG_%s_RST" $pllname] <= [write_hdl_reset_selection $param_table $pllname "RST"];

"
}

# --------------------------------------

proc write_hdl_mmcm_input_connection { hdlfile param_table mmcmname } {
	array set params $param_table

  puts $hdlfile "
  -- $mmcmname CLKIN1\n 
  [format "SIG_%s_CLKIN1" $mmcmname] <= [write_hdl_clock_selection $param_table $mmcmname "CLKIN1"];

  -- $mmcmname CLKFBIN\n 
  [format "SIG_%s_CLKFBIN" $mmcmname] <= [write_hdl_clock_selection $param_table $mmcmname "CLKFBIN"];

  -- $mmcmname RST\n 
  [format "SIG_%s_RST" $mmcmname] <= [write_hdl_reset_selection $param_table $mmcmname "RST"];
"
  set c_psdone_module $params(C_PSDONE_MODULE)
  if { ( $c_psdone_module == $mmcmname ) } {
    puts $hdlfile "
  [format "SIG_%s_PSEN" $mmcmname] <= PSEN;
  [format "SIG_%s_PSCLK" $mmcmname] <= PSCLK;
  [format "SIG_%s_PSINCDEC" $mmcmname] <= PSINCDEC;
  PSDONE <= [format "SIG_%s_PSDONE" $mmcmname];
"
  } else {
    puts $hdlfile "
  [format "SIG_%s_PSEN" $mmcmname] <= net_gnd0;
  [format "SIG_%s_PSCLK" $mmcmname] <= net_gnd0;
  [format "SIG_%s_PSINCDEC" $mmcmname] <= net_gnd0;
"
  }

}

# --------------------------------------


proc write_hdl_clkgen_output_connection { hdlfile param_table } {
	array set params $param_table

  # CLKOUT

  puts $hdlfile "  
  -- CLKGEN CLKOUT
"
  foreach clkout [get_clkgen_clkout_names] {
    if { $params([format "C_%s_MODULE" $clkout]) != "" && 
         $params([format "C_%s_MODULE" $clkout]) != "NONE" &&
         $params([format "C_%s_MODULE" $clkout]) != "NOT_SET" } {
      puts $hdlfile "  
  $clkout <= [write_hdl_clock_selection $param_table "CLKGEN" $clkout];
"
    }
  }

  # CLKFBOUT

  puts $hdlfile "  
  -- CLKGEN CLKFBOUT
"
  foreach clkfbout [get_clkgen_clkfbout_names] {
    if { $params([format "C_%s_MODULE" $clkfbout]) != "" && 
         $params([format "C_%s_MODULE" $clkfbout]) != "NONE" &&
         $params([format "C_%s_MODULE" $clkfbout]) != "NOT_SET" } {
      puts $hdlfile "  
  $clkfbout <= [write_hdl_clock_selection $param_table "CLKGEN" $clkfbout];
"
    }
  }

  # PSDONE

  #   puts $hdlfile "  
  #   -- CLKGEN PSDONE refer to MMCM connection
  # "

  # LOCKED

  puts $hdlfile "  
  -- CLKGEN LOCKED 
" 

  set sig_locked "NOT_SET"

  foreach dcm [get_clkgen_dcm_names] {
    if { $params([format "C_%s_CLKIN_MODULE" $dcm]) != "" && 
         $params([format "C_%s_CLKIN_MODULE" $dcm]) != "NONE" &&
         $params([format "C_%s_CLKIN_MODULE" $dcm]) != "NOT_SET" } {
      if { $sig_locked == "NOT_SET" } {
        set sig_locked [format "LOCKED <= SIG_%s_LOCKED" $dcm]
      } else {
        set sig_locked [format "%s and SIG_%s_LOCKED" $sig_locked $dcm]
      }
    }
  }

  foreach pll [get_clkgen_pll_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $pll]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $pll]) != "NONE" &&
         $params([format "C_%s_CLKIN1_MODULE" $pll]) != "NOT_SET" } {
      if { $sig_locked == "NOT_SET" } {
        set sig_locked [format "LOCKED <= SIG_%s_LOCKED" $pll]
      } else {
        set sig_locked [format "%s and SIG_%s_LOCKED" $sig_locked $pll]
      }
    }
  }

  foreach mmcm [get_clkgen_mmcm_names] {
    if { $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "" && 
         $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "NONE" &&
         $params([format "C_%s_CLKIN1_MODULE" $mmcm]) != "NOT_SET" } {
      if { $sig_locked == "NOT_SET" } {
        set sig_locked [format "LOCKED <= SIG_%s_LOCKED" $mmcm]
      } else {
        set sig_locked [format "%s and SIG_%s_LOCKED" $sig_locked $mmcm]
      }
    }
  }

  # >>> CR564512 @ 20100614
  if { $params([format "%s" "C_ELABORATE_RES"]) == "RES_SP6_2PLL_CAS" } {
    set sig_locked "LOCKED <= SIG_PLL1_LOCKED"
  } 
  # <<<

  if { $sig_locked != "NOT_SET" } {
    puts $hdlfile "  
  $sig_locked; 
" 
  } else {
    puts $hdlfile "  
  LOCKED <= net_gnd0; 
" 
  }

}


# ----------------------------------------------------------------------------
# sysleve update
# ----------------------------------------------------------------------------

proc syslevel_update {mhsinst} {

  #puts "---------- Update Clock Circuit ----------"

  ## 1
  load_core_libs
  #puts "---------- Clock Libraty loaded ----------"
  #puts "ClkGen load library"

  ## 2
  set caller_name [xget_nameofexecutable]
  if { ! ( [string match "platgen" $caller_name] == 1 || [string match "simgen" $caller_name] == 1 ) } {
    return 0;
  }
  #puts "---------- Check Caller for IP Level update passed ----------"
  #puts "ClkGen flow: $caller_name"

  ## 3
  set clk_gen [xget_hw_parameter_value $mhsinst "C_CLK_GEN"]
  if { ($clk_gen != "UPDATE") && ($clk_gen != "update") } {
    return 0;
  }
  #puts "---------- Check C_CLK_GEN set ----------"
  #puts $clk_gen
  #puts "ClkGen status: $clk_gen"
  
  ## 4
  set family [xget_hw_parameter_value $mhsinst "C_FAMILY"]
  if {$family != ""} {
  } else {
    error " Clock generator requires C_FAMILY to be set.\n" "" "mdt_error"
  }
  #puts "---------- Check C_FAMILY set ----------"
  #puts $family
  #puts "ClkGen family: $family"

  ## 5
  set res [xgen_clock_circuit $mhsinst 6]
  #puts "---------- Run clock generation ----------"
  #puts "ClkGen syslevel update"

  ## 6
  set clk_gen [xget_hw_parameter_value $mhsinst "C_CLK_GEN"]
  if {$clk_gen != "PASSED"} {
  	set instance_name [xget_hw_parameter_value $mhsinst "INSTANCE"]
  	set filename "$instance_name.log"
  	set filepath [file join [pwd]/$filename] 
    error "Clock generator failed to generate a clock circuit for the design $instance_name. For error analysis and hints to successfully generate the clock circuit, please refer to the file $filename in the project directory, $filepath\n" "" "mdt_error"
  }
  #puts "---------- Check C_CLK_GEN set ----------"
  #puts $clk_gen
  puts "ClkGen elaborate status: $clk_gen"

  ## 7
  set caller_name [xget_nameofexecutable]
  if { ! ( [string match "platgen" $caller_name] == 1 ) } {
    return $res;
  }
  #puts "---------- Check Caller for SysLevel update passed ----------"

  ## 8
  set mhs_handle   [xget_hw_parent_handle $mhsinst]  
  #puts "---------- get the MHS handle ----------"

  ## 9
  set res [xgen_system_update $mhs_handle 8]
  #puts "---------- Run system update ----------"
  #puts "ClkGen mhs system update"

  set res 0

  return $res
}
