###############################################################################
##
## DISCLAIMER OF LIABILITY
##
## This file contains proprietary and confidential information of
## Xilinx, Inc. ("Xilinx"), that is distributed under a license
## from Xilinx, and may be used, copied and/or disclosed only
## pursuant to the terms of a valid license agreement with Xilinx.
##
## XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
## ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
## EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
## LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
## MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
## does not warrant that functions included in the Materials will
## meet the requirements of Licensee, or that the operation of the
## Materials will be uninterrupted or error-free, or that defects
## in the Materials will be corrected. Furthermore, Xilinx does
## not warrant or make any representations regarding use, or the
## results of the use, of the Materials in terms of correctness,
## accuracy, reliability or otherwise.
##
## Xilinx products are not designed or intended to be fail-safe,
## or for use in any application requiring fail-safe performance,
## such as life-support or safety devices or systems, Class III
## medical devices, nuclear facilities, applications related to
## the deployment of airbags, or any other applications that could
## lead to death, personal injury or severe property or
## environmental damage (individually and collectively, "critical
## applications"). Customer assumes the sole risk and liability
## of any use of Xilinx products in critical applications,
## subject only to applicable laws and regulations governing
## limitations on product liability.
##
## Copyright 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Xilinx, Inc.
## All rights reserved.
##
## This disclaimer and copyright notice must be retained as part
## of this file at all times.
##
###############################################################################
##
## lmb_bram_if_cntlr_v2_1_0.tcl
##
###############################################################################


#***--------------------------------***------------------------------------***
#
# 		         SYSLEVEL_DRC_PROC
#
#***--------------------------------***------------------------------------***

#
# lmb_bram_if_cntlr memory controller is connected to a bram block
#
proc check_syslevel_settings { mhsinst } {
    set retval  0

    set instname   [xget_value $mhsinst "parameter" "INSTANCE"]

    if {[bus_is_connected $mhsinst "BRAM_PORT"] == 0 && [bus_is_external $mhsinst "BRAM_PORT"] == 0} {
      error "The BRAM_PORT interface is not correctly connected. To use the interface the bus must be connected to a BRAM or to external ports." "" "mdt_error"
    } else {
      set busif  [xget_value $mhsinst "bus_interface" "BRAM_PORT"]
      if {[string length $busif] == 0} {
	puts  "WARNING: $instname memory controller is not connected to a bram block"
      }
    }

    #########################################################################
    # Warn if connected MicroBlaze is not v5.00a or higher. This is necessary
    # because of different pipelining of writes in the 5 stage pipeline
    #########################################################################
    set mhs_handle [xget_handle $mhsinst "parent"]

    # First find the LMB bus instance...
    set slave_addrstrobe_con [xget_value $mhsinst "port" "LMB_AddrStrobe"] 
    if { [llength $slave_addrstrobe_con] == 0} {
	error "BUS_INTERFACE SLMB is unconnected. The core LMB_BRAM_IF_CNTRL v2.10.b requires that this be connected to an instance of the LMB_V10 bus" "" "mdt_error"
	incr retval
    }
    set slave_addrstrobe_source [xget_connected_ports_handle $mhs_handle $slave_addrstrobe_con "SOURCE"]
    if {[llength $slave_addrstrobe_source] == 0} {
	error "BUS_INTERFACE SLMB is unconnected. The core LMB_BRAM_IF_CNTLR v2.10.b requires that this be connected to an instance of the LMB_V10 bus" "" "mdt_error"
	incr retval
    }

    # ...then find the MicroBlaze instance...
    set bus_handle [xget_handle $slave_addrstrobe_source "PARENT"]
    set master_addrstrobe_con [xget_value $bus_handle "port" "M_AddrStrobe"]
    if { [llength $master_addrstrobe_con] == 0} {
	error "BUS_INTERFACE MLMB is unconnected. The core LMB_V10 v1.00.a requires that this be connected to an instance of the MicroBlaze processor" "" "mdt_error"
	incr retval
    }
    set master_addrstrobe_source [xget_connected_ports_handle $mhs_handle $master_addrstrobe_con "SOURCE"]
    if {[llength $master_addrstrobe_source] == 0} {
	error "BUS_INTERFACE MLMB is unconnected. The core LMB_V10 v1.00.a requires that this be connected to an instance of the MicroBlaze processor" "" "mdt_error"
	incr retval
    }
    set microblaze_handle [xget_handle $master_addrstrobe_source "PARENT"]

    # ...finally check the MicroBlaze version
    set microblaze_version [xget_value $microblaze_handle "parameter" "HW_VER"]
    if {($microblaze_version == "2.10.a") ||
	($microblaze_version == "3.00.a") ||
	([string first "4.00." $microblaze_version] != -1)} {
	puts "WARNING: Version v2.10.b of the LMB_BRAM_IF_CNTLR is only recommended for the MicroBlaze processor version v5.00.a and higher. Please change version of instantiated MicroBlaze processor or LMB BRAM controller."
    }

    return $retval
}

# Determine if bus is connected
proc bus_is_connected { mhsinst bus } {
   set bus_handle [xget_hw_busif_handle $mhsinst $bus]
   if {$bus_handle == ""} {
     return 0
   }
   set bus_name [xget_hw_value $bus_handle]
   if {$bus_name == ""} {
     return 0
   }
   set bus_busip_handle [xget_connected_p2p_busif_handle $bus_handle ]
   if {$bus_busip_handle == ""} {
     return 0
   }
   set bus_busip_name [xget_hw_value $bus_busip_handle]
   if {$bus_busip_name == ""} {
     return 0
   }
   return 1
}

# Determine if signal is connected to external port
proc is_external { mhsinst signal } {
   set mhs_handle [xget_hw_parent_handle $mhsinst]
   set master_cons [xget_hw_port_handle $mhs_handle "*"]
   foreach master_con $master_cons {
     if {[xget_hw_value $master_con] == $signal} {
       return 1
     }
   }
   return 0
}

# Determine if bus is connected to external ports
proc bus_is_external { mhsinst bus } {
   set bus_handle [xget_hw_busif_handle $mhsinst $bus]
   if {$bus_handle == ""} {
     return 0
   }
   set ports [xget_hw_port_handle $mhsinst "*"]
   foreach port $ports {
     set busvalue [xget_hw_subproperty_value $port "BUS"]
     if {$busvalue == $bus} {
       set portvalue [xget_hw_value $port]
       if {! [is_external $mhsinst $portvalue]} {
         return 0
       }
     }
   }
   return 1
}

#***--------------------------------***------------------------------------***
#
#			     IPLEVEL_DRC_PROC
#
#***--------------------------------***------------------------------------***

#
# check C_BASEADDR != 0xFFFFFFFF
#       C_HIGHADDR != 0x00000000
#

proc check_iplevel_settings {mhsinst} {

    set base_param "C_BASEADDR"
    set high_param "C_HIGHADDR"
    set base_addr [xget_value $mhsinst "parameter" $base_param]
    set high_addr [xget_value $mhsinst "parameter" $high_param]

    if {[compare_unsigned_addr_strings $base_addr $base_param $high_addr $high_param] == 1} {

	set ipname [xget_value $mhsinst "option" "ipname"]
        error "Invalid $ipname parameter:\nYou must set the value for $base_param and $high_param" "" "libgen_error"

    }

}

#***--------------------------------***------------------------------------***
#
#                       SYSLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***------------------------------------***

#
# update C_MASK
#
proc update_syslevel_mask { param_handle } {

    # Instance
    set ipinst      [xget_hw_parent_handle $param_handle]
    set ipinst_name [xget_hw_name $ipinst]

    # MicroBlaze
    set mhsinst [connected_lmb_source $param_handle]
    if {$mhsinst == ""} { return 0 }

    ## Assign LMB mask to processor object
    ## - Find minimum set of bits to generate LMB mask

    # Bus
    set busseq {}
    set busif_handles [xget_hw_busif_handle $mhsinst *]
    set mhs_handle [xget_hw_parent_handle $mhsinst]
    foreach busif_handle $busif_handles {
      set bus [xget_hw_value $busif_handle]
      if {$bus != ""} {
        lappend busseq [xget_hw_ipinst_handle $mhs_handle $bus]
      }
    }

    # LMB bus
    set lmbseq [connected_busif $mhsinst "LMB"]

    # External bus (OPB/PLB/AXI)
    set opbseq [connected_busif $mhsinst "OPB"]
    set plbseq [connected_busif $mhsinst "PLB"]
    set axiseq [connected_busif $mhsinst "AXI"]

    set extseq {}
    if {[llength $opbseq] > 0} {
      set extseq $opbseq
    } elseif {[llength $plbseq] > 0} {
      set extseq $plbseq
    } elseif {[llength $axiseq] > 0} {
      set extseq $axiseq
    }

    # Populate Addr lists
    set lmbaddrseq [PopulateAddrSeq $lmbseq $busseq $ipinst]
    set extaddrseq [PopulateAddrSeq $extseq $busseq $ipinst]

    # Set instance address list item
    set ipinst_lmbaddr  [GetInstanceItem $lmbseq $lmbaddrseq $ipinst_name]
    set ipinst_baseaddr [lindex $ipinst_lmbaddr 0]
    set ipinst_highaddr [lindex $ipinst_lmbaddr 1]
    set ipinst_bitwidth [lindex $ipinst_lmbaddr 2]
    set ipinst_lmbname  [xget_hw_name [lindex $ipinst_lmbaddr 4]]

    # DCACHE container
    set c_dcache_baseaddr [xformat_address_string [xget_hw_parameter_value $mhsinst "C_DCACHE_BASEADDR"]]
    set c_dcache_highaddr [xformat_address_string [xget_hw_parameter_value $mhsinst "C_DCACHE_HIGHADDR"]]

    if {[xget_hw_parameter_value $mhsinst "C_USE_DCACHE"] == "1" &&
        [xget_hw_parameter_value $mhsinst "C_DCACHE_USE_FSL"] == "1"} {
      set c_dcache_bitwidth [CalculateBitWidth $c_dcache_baseaddr $c_dcache_highaddr]
      lappend extaddrseq [list $c_dcache_baseaddr $c_dcache_highaddr $c_dcache_bitwidth $mhsinst $mhsinst]
    }

    # ICACHE container
    set c_icache_baseaddr [xformat_address_string [xget_hw_parameter_value $mhsinst "C_ICACHE_BASEADDR"]]
    set c_icache_highaddr [xformat_address_string [xget_hw_parameter_value $mhsinst "C_ICACHE_HIGHADDR"]]

    if {[xget_hw_parameter_value $mhsinst "C_USE_ICACHE"] == "1" &&
        [xget_hw_parameter_value $mhsinst "C_ICACHE_USE_FSL"] == "1"} {
      set c_icache_bitwidth [CalculateBitWidth $c_icache_baseaddr $c_icache_highaddr]
      lappend extaddrseq [list $c_icache_baseaddr $c_icache_highaddr $c_icache_bitwidth $mhsinst $mhsinst]
    }

    # Generate Bit Patterns
    set lmbormask [GenerateOrBitPattern $lmbaddrseq]
    set extormask [GenerateOrBitPattern $extaddrseq]

    set addrseq   [concat $lmbaddrseq $extaddrseq]
    set allormask [GenerateOrBitPattern $addrseq]

    # Check if mask is valid. It can be zero if no external bus addresses are used
    check_error [expr $lmbormask == 0 && $extormask == 0 && [llength $extaddrseq] > 0] \
                $mhsinst $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr

    # Generate optimized mask
    set optmask [GenerateOptMask $allormask $lmbaddrseq $extaddrseq $lmbseq $extseq \
                 $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]

    # Validate final mask
    set compareec [CompareBitMask $optmask $lmbaddrseq $extaddrseq $lmbseq $extseq \
                   $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
    check_error [expr $compareec != 0] $mhsinst $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr

    return [format "0x%08x" $optmask]
}

proc connected_lmb_source { param_handle } {
    set mhsinst    [xget_hw_parent_handle $param_handle]
    set mhs_handle [xget_hw_parent_handle $mhsinst]

    set lmb ""
    set addrstrobe_con [xget_hw_port_value $mhsinst "LMB_AddrStrobe"] 
    if { [llength $addrstrobe_con] > 0} {
      set addrstrobe_source [xget_connected_ports_handle $mhs_handle $addrstrobe_con "SOURCE"]
      if {[llength $addrstrobe_source] != 0} {
        set lmb [xget_hw_parent_handle $addrstrobe_source]
      }
    }

    if {$lmb != ""} {
      set mb ""
      set addrstrobe_con [xget_hw_port_value $lmb "M_AddrStrobe"] 
      if { [llength $addrstrobe_con] > 0} {
        set addrstrobe_source [xget_connected_ports_handle $mhs_handle $addrstrobe_con "SOURCE"]
        if {[llength $addrstrobe_source] != 0} {
          set mb [xget_hw_parent_handle $addrstrobe_source]
        }
      }

      if {$mb != ""} {
        return $mb
      }
    }
    return ""
}

proc connected_busif { mhsinst busname } {
    set result {}
    set seq [xget_hw_busif_handle $mhsinst *]
    set mhs_handle [xget_hw_parent_handle $mhsinst]
    foreach inst $seq {
      set name [xget_hw_name $inst]
      if {[string first $busname $name] != -1} {
        # Found bus
        set value [xget_hw_value $inst]
        set ports [xget_hw_port_handle $mhsinst *]
        foreach port $ports {
          set prop [xget_hw_subproperty_value $port BUS]
          if {$prop == $name} {
            # Found port connected to the bus
            set value [xget_hw_value $port]
            if {$value != ""} {
              # Found signal connected to the port
              set sink [xget_connected_ports_handle $mhs_handle $value "SINK"]
              if {[llength $sink] > 0} {
                # Found sink connected to the signal in the bus
                lappend result $inst
              }
              break
            }
          }
        }
      }
    }
    return $result
}

proc PopulateAddrSeq {busifseq busseq ipinst} {
  set mhsinst [xget_hw_parent_handle $ipinst]

  set addrlist {}
  foreach busifitr $busifseq {
    set busifitr_value [xget_hw_value $busifitr]

    foreach obj_bus $busseq {
      if {$obj_bus != ""} {
        if {[xget_hw_name $obj_bus] == $busifitr_value} {
          break
        }
      }
    }
    if {$obj_bus != ""} {
      # Assumes same order in xget_hw_bus_slave_addrpairs and xget_hw_connected_busifs_handle
      set busaddrseq [xget_hw_bus_slave_addrpairs $obj_bus]

      set busaddrseq_owner {}
      set busaddrseq_busifs [xget_hw_connected_busifs_handle $mhsinst [xget_hw_name $obj_bus] "SLAVE"]
      foreach busaddrseq_busif $busaddrseq_busifs {
        lappend busaddrseq_owner [xget_hw_parent_handle $busaddrseq_busif]
        lappend busaddrseq_owner [xget_hw_parent_handle $busaddrseq_busif]
      }

      set i 0
      while {$i < [llength $busaddrseq]} {
        set baseaddr [lindex $busaddrseq $i]
        set highaddr [lindex $busaddrseq [expr $i + 1]]
        set bitwidth [CalculateBitWidth $baseaddr $highaddr]
        lappend addrlist [list $baseaddr $highaddr $bitwidth [lindex $busaddrseq_owner $i] $busifitr]
        set i [expr $i + 2]
      }
    }
  }

  return $addrlist
}

proc CalculateBitWidth {baseaddr highaddr} {
    set bitwidth 32
    for {set i 0} {$i < 32} {incr i} {
      if {(($baseaddr >> $i) & 1) == (($highaddr >> $i) & 1)} {
        set bitwidth $i
        break
      }
    }
    return $bitwidth
}

proc GetInstanceItem {lmbseq lmbaddrseq ipinst_name} {
  foreach lmb $lmbseq {
    set lmbname [xget_hw_name $lmb]
    foreach lmbaddr $lmbaddrseq {
      set ipname    [xget_hw_name [lindex $lmbaddr 3]]
      set busname   [xget_hw_name [lindex $lmbaddr 4]]
      if {$lmbname == $busname && $ipname == $ipinst_name} {
        return $lmbaddr
      }
    }
  }
}

proc GenerateOrBitPattern {addrseq} {
  set bitmask 0

  foreach addritr $addrseq {
    set bitwidth 32
    set addrand [expr [lindex $addritr 0] & [lindex $addritr 1]]
    set addrxor [expr [lindex $addritr 0] ^ [lindex $addritr 1]]

    set addr_mask 0

    for {set i 0} {$i < $bitwidth} {incr i} {
      set xorbit [expr ($addrxor >> $i) & 1]

      # If bit is 'x', then iterate the next bit
      if {$xorbit == 0} {
        set andbit [expr ($addrand >> $i) & 1]
        if {$andbit == 1} {
          set addr_mask [expr $addr_mask | (1 << $i)]
        }
      }
    }

    set bitmask [expr $bitmask | $addr_mask]
  }
  return $bitmask
}

proc GenerateOptMask {allmask lmbaddrseq extaddrseq lmbseq extseq \
                      ipinst_name ipinst_lmbname ipinst_baseaddr ipinst_highaddr ipinst_bitwidth} {
    # Create list of bit positions (LSB=0, MSB=31) set to 1 in allmask
    set bitposlist {}
    for {set b $ipinst_bitwidth} {$b < 32} {incr b} {
      if {($allmask >> $b) & 1} {
        lappend bitposlist $b
      }
    }

    # Sweep one bit
    foreach bit $bitposlist {
      set mask [expr 1 << $bit]
      set ec [CompareBitMask $mask $lmbaddrseq $extaddrseq $lmbseq $extseq \
              $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
      if {$ec == 0} { return $mask }
    }

    # Sweep two bits
    foreach bit1 $bitposlist {
      set mask1 [expr 1 << $bit1]
      foreach bit2 $bitposlist {
        set mask2 [expr $mask1 | (1 << $bit2)]
        set ec [CompareBitMask $mask2 $lmbaddrseq $extaddrseq $lmbseq $extseq \
                $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
        if {$ec == 0} { return $mask2 }
      }
    }

    # Sweep three bits
    foreach bit1 $bitposlist {
      set mask1 [expr 1 << $bit1]
      foreach bit2 $bitposlist {
        set mask2 [expr $mask1 | (1 << $bit2)]
        foreach bit3 $bitposlist {
          set mask3 [expr $mask2 | (1 << $bit3)]
          set ec [CompareBitMask $mask3 $lmbaddrseq $extaddrseq $lmbseq $extseq \
                  $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
          if {$ec == 0} { return $mask3 }
        }
      }
    }

    # Sweep four bits
    foreach bit1 $bitposlist {
      set mask1 [expr 1 << $bit1]
      foreach bit2 $bitposlist {
        set mask2 [expr $mask1 | (1 << $bit2)]
        foreach bit3 $bitposlist {
          set mask3 [expr $mask2 | (1 << $bit3)]
          foreach bit4 $bitposlist {
            set mask4 [expr $mask3 | (1 << $bit4)]
            set ec [CompareBitMask $mask4 $lmbaddrseq $extaddrseq $lmbseq $extseq \
                    $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
            if {$ec == 0} { return $mask4 }
          }
        }
      }
    }

    # Create sweep mask that only includes more significant bits than ipinst_bitwidth
    set sweepmask [expr $allmask & ~((1 << $ipinst_bitwidth) - 1)]

    # Sweep clear four bits
    foreach bit1 $bitposlist {
      set mask1 [expr $sweepmask & ~(1 << $bit1)]
      foreach bit2 $bitposlist {
        if {$bit2 == $bit1} { continue }
        set mask2 [expr $mask1 & ~(1 << $bit2)]
        foreach bit3 $bitposlist {
          if {$bit3 == $bit2 || $bit3 == $bit1} { continue }
          set mask3 [expr $mask2 & ~(1 << $bit3)]
          foreach bit4 $bitposlist {
            if {$bit4 == $bit3 || $bit4 == $bit2 || $bit4 == $bit1} { continue }
            set mask4 [expr $mask3 & ~(1 << $bit4)]
            set ec [CompareBitMask $mask4 $lmbaddrseq $extaddrseq $lmbseq $extseq \
                    $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
            if {$ec == 0} { return $mask4 }
          }
        }
      }
    }

    # Sweep clear three bits
    foreach bit1 $bitposlist {
      set mask1 [expr $sweepmask & ~(1 << $bit1)]
      foreach bit2 $bitposlist {
        if {$bit2 == $bit1} { continue }
        set mask2 [expr $mask1 & ~(1 << $bit2)]
        foreach bit3 $bitposlist {
          if {$bit3 == $bit2 || $bit3 == $bit1} { continue }
          set mask3 [expr $mask2 & ~(1 << $bit3)]
          set ec [CompareBitMask $mask3 $lmbaddrseq $extaddrseq $lmbseq $extseq \
                  $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
          if {$ec == 0} { return $mask3 }
        }
      }
    }

    # Sweep clear two bits
    foreach bit1 $bitposlist {
      set mask1 [expr $sweepmask & ~(1 << $bit1)]
      foreach bit2 $bitposlist {
        if {$bit2 == $bit1} { continue }
        set mask2 [expr $mask1 & ~(1 << $bit2)]
        set ec [CompareBitMask $mask2 $lmbaddrseq $extaddrseq $lmbseq $extseq \
                $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
        if {$ec == 0} { return $mask2 }
      }
    }

    # Sweep clear one bit
    foreach bit $bitposlist {
      set mask [expr $sweepmask & ~(1 << $bit)]
      set ec [CompareBitMask $mask $lmbaddrseq $extaddrseq $lmbseq $extseq \
              $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth]
      if {$ec == 0} { return $mask }
    }

    return $sweepmask
}

proc CompareBitMask {mask lmbaddrseq extaddrseq lmbseq extseq \
                     ipinst_name ipinst_lmbname ipinst_baseaddr ipinst_highaddr ipinst_bitwidth} {
    set ec 0

    foreach lmbaddr $lmbaddrseq {
      set baseaddr [lindex $lmbaddr 0]
      set highaddr [lindex $lmbaddr 1]
      set bitwidth [lindex $lmbaddr 2]
      set ipname   [xget_hw_name [lindex $lmbaddr 3]]
      set busname  [xget_hw_name [lindex $lmbaddr 4]]
      if {$ipinst_lmbname == $busname && $ipname != $ipinst_name} {
        set unique 0
        for {set i 31} {$i >= $bitwidth} {incr i -1} {
          set maskbit_i [expr $mask & (1 << $i)]
          if {($maskbit_i & $ipinst_baseaddr) != ($maskbit_i & $baseaddr)} {
            set unique 1
          }
        }
        if {(($mask & $ipinst_baseaddr) == ($mask & $baseaddr)) ||
            ((($mask & ($baseaddr ^ $highaddr)) != 0) && ! $unique) || 
            (($mask & ($ipinst_baseaddr ^ $ipinst_highaddr)) != 0) } {
          incr ec
        }
      }
    }

    foreach addritr $extaddrseq {
      set baseaddr [lindex $addritr 0]
      set highaddr [lindex $addritr 1]
      set bitwidth [lindex $addritr 2]

      set comparemask [expr $mask & ~((1 << $bitwidth) - 1)]
      if {($ipinst_baseaddr & $comparemask) == ($baseaddr & $comparemask)} {
        incr ec
      }
    }

    return $ec
}

proc check_error {found_error mhsinst ipinst_lmbname ipinst_baseaddr ipinst_highaddr} {
    if {$found_error} {
        set bus [string index $ipinst_lmbname 0]
        set use_cache [xget_hw_parameter_value $mhsinst "C_USE_${bus}CACHE"]
        set cache_baseaddr [xget_hw_parameter_value $mhsinst "C_${bus}CACHE_BASEADDR"]
        set cache_highaddr [xget_hw_parameter_value $mhsinst "C_${bus}CACHE_HIGHADDR"]
        if {$use_cache &&
            (($ipinst_baseaddr <  $cache_baseaddr && $ipinst_highaddr >= $cache_baseaddr) ||
             ($ipinst_baseaddr >= $cache_baseaddr && $ipinst_baseaddr <= $cache_highaddr))} {
	  error "The ${ipinst_lmbname} address range ([format {0x%X} $ipinst_baseaddr] - [format {0x%X} $ipinst_highaddr]) overlaps with the ${bus}cache address range ([format {0x%X} $cache_baseaddr] - [format {0x%X} $cache_highaddr]). This means that an address decode mask can not be assigned to the ${ipinst_lmbname} peripheral. Please modify the ${bus}cache address range to remove the overlap." "" "mdt_error"
        } else {
            error "Can not generate mask for the LMB peripherals! An address decode mask is assigned to all LMB peripherals connected to the MicroBlaze processor. The address decode mask is based on a set of decode bits that distinguish the LMB address space from the OPB/PLB/AXI address space. The error message indicates that a set of decode bits can not be found to generate a mask. Please modify the address map of the slaves connected to OPB/PLB/AXI to use a common address bit." "" "mdt_error"
        }
    }
}
