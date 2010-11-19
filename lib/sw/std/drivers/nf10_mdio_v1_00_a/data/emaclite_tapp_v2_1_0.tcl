##############################################################################
#
# (c) Copyright 2005-2009 Xilinx, Inc. All rights reserved.
#
# This file contains confidential and proprietary information of Xilinx, Inc.
# and is protected under U.S. and international copyright and other
# intellectual property laws.
#
# DISCLAIMER
# This disclaimer is not a license and does not grant any rights to the
# materials distributed herewith. Except as otherwise provided in a valid
# license issued to you by Xilinx, and to the maximum extent permitted by
# applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
# FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
# IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
# MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
# and (2) Xilinx shall not be liable (whether in contract or tort, including
# negligence, or under any other theory of liability) for any loss or damage
# of any kind or nature related to, arising under or in connection with these
# materials, including for any direct, or any indirect, special, incidental,
# or consequential loss or damage (including loss of data, profits, goodwill,
# or any type of loss or damage suffered as a result of any action brought by
# a third party) even if such damage or loss was reasonably foreseeable or
# Xilinx had been advised of the possibility of the same.
#
# CRITICAL APPLICATIONS
# Xilinx products are not designed or intended to be fail-safe, or for use in
# any application requiring fail-safe performance, such as life-support or
# safety devices or systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any other applications
# that could lead to death, personal injury, or severe property or
# environmental damage (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and liability of any use of
# Xilinx products in Critical Applications, subject only to applicable laws
# and regulations governing limitations on product liability.
#
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
# AT ALL TIMES.
#
##############################################################################

## @BEGIN_CHANGELOG EDK_I
##
##  - include header files
##
## @END_CHANGELOG

## @BEGIN_CHANGELOG EDK_H
##
##  - Initial Revision
##    
## @END_CHANGELOG

## @BEGIN_CHANGELOG EDK_LS2
##
##  - Updated the tcl to use additional files provided with the examples
##    
## @END_CHANGELOG

# Uses $XILINX_EDK/bin/lib/xillib_sw.tcl

# -----------------------------------------------------------------
# Software Project Types (swproj):
#   0 : MemoryTest - Calls basic  memorytest routines from common driver dir
#   1 : PeripheralTest - Calls any existing polled_example and/or selftest
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# TCL Procedures:
# -----------------------------------------------------------------

proc gen_include_files {swproj mhsinst} {
  if {$swproj == 0} {
    return ""
  }
  if {$swproj == 1} {
        set ifemacliteintr [get_intr $mhsinst]
        if {$ifemacliteintr == 1} {
            set inc_file_lines {xemaclite.h xemaclite_example.h emaclite_header.h emaclite_intr_header.h}
        } else {
            set inc_file_lines {xemaclite.h xemaclite_example.h emaclite_header.h}    
        }    
        return $inc_file_lines
  }
}

proc gen_src_files {swproj mhsinst} {
  if {$swproj == 0} {
    return ""
  }
  if {$swproj == 1} {
        set ifemacliteintr [get_intr $mhsinst]
        if {$ifemacliteintr == 1} {
            set inc_file_lines {examples/xemaclite_example.h examples/xemaclite_polled_example.c examples/xemaclite_intr_example.c examples/xemaclite_example_util.c data/emaclite_header.h data/emaclite_intr_header.h}
        } else {
            set inc_file_lines {examples/xemaclite_example.h examples/xemaclite_polled_example.c examples/xemaclite_example_util.c data/emaclite_header.h}
        }    
    return $inc_file_lines
  }
}

proc gen_testfunc_def {swproj mhsinst} {
  return ""
}

proc gen_init_code {swproj mhsinst} {
    if {$swproj == 0} {
        return ""
    }
    if {$swproj == 1} {
        
      set ipname [xget_value $mhsinst "NAME"]
      set ifemacliteintr [get_intr $mhsinst]
      if {$ifemacliteintr == 1} {
          set decl "   static XEmacLite ${ipname}_EmacLite;"
          set inc_file_lines $decl
          return $inc_file_lines
      } else {
          return ""
      }
  }

}

proc gen_testfunc_call {swproj mhsinst} {

  if {$swproj == 0} {
    return ""
  }

  set ifemacliteintr [get_intr $mhsinst] 
  set ipname [xget_value $mhsinst "NAME"] 
  set deviceid [xget_name $mhsinst "DEVICE_ID"]
  set hasStdout [xhas_stdout $mhsinst]


  if {$ifemacliteintr == 1} {
      set mhsHandle [xget_hw_parent_handle $mhsinst]
      set retMhsInst [xget_intc $mhsHandle] 
      set intcname [xget_value $retMhsInst "NAME"]
      set intcvar [xget_intc_drv_var]
  }
  
  set testfunc_call ""

  if {${hasStdout} == 0} {

      append testfunc_call "

   {
      int status;
      
      status = EmacLitePolledExample(${deviceid});
   }"

      if {$ifemacliteintr == 1} {
          
          set intr_id "XPAR_${intcname}_${ipname}_IP2INTC_IRPT_INTR"
          set intr_id [string toupper $intr_id]
          
          append testfunc_call "
        
   {
      int Status;
      Status = EmacLiteIntrExample(&${intcvar}, &${ipname}_EmacLite, \\
                               ${deviceid}, \\
                               ${intr_id});
   }"

      }

  } else {

      append testfunc_call "

   {
      int status;
      
      print(\"\\r\\nRunning EmacLitePolledExample() for ${ipname}...\\r\\n\");
      status = EmacLitePolledExample(${deviceid});
      if (status == 0) {
         print(\"EmacLite Polled Example PASSED\\r\\n\");
      }
      else {
         print(\"EmacLite Polled Example FAILED\\r\\n\");
      }
   }"

  if {$ifemacliteintr == 1} {

        set intr_id "XPAR_${intcname}_${ipname}_IP2INTC_IRPT_INTR"
	set intr_id [string toupper $intr_id]
	
      append testfunc_call "
   {
      int Status;

      print(\"\\r\\n Running Interrupt Test  for ${ipname}...\\r\\n\");
      
      Status = EmacLiteIntrExample(&${intcvar}, &${ipname}_EmacLite, \\
                               ${deviceid}, \\
                               ${intr_id});
	
      if (Status == 0) {
         print(\"EmacLite Interrupt Test PASSED\\r\\n\");
      } 
      else {
         print(\"EmacLite Interrupt Test FAILED\\r\\n\");
      }

   }"

    }
  }
  return $testfunc_call
}

proc get_intr {mhsinst} {
    set ipname [xget_value $mhsinst "NAME"]
    set port_intr [xget_value $mhsinst "PORT" "IP2INTC_Irpt"]
    set emaclite_intr [string match "${ipname}_IP2INTC_Irpt" $port_intr]
    
    if {$emaclite_intr == 1} {
        set mhsHandle [xget_hw_parent_handle $mhsinst]
        set sinkHandle [xget_hw_connected_ports_handle $mhsHandle "${ipname}_IP2INTC_Irpt" "sink"]
        if {$sinkHandle != ""} {
            set intcHandle [xget_hw_parent_handle $sinkHandle]
            set irqValue [xget_hw_port_value $intcHandle "Irq"] 
            if {$irqValue != ""} {
                set procSinkHandle [xget_hw_connected_ports_handle $mhsHandle $irqValue "sink"]
                if {$procSinkHandle != ""} {
                    set procSinkName [xget_hw_name $procSinkHandle]
                    set procVisiblePPC440 [string match $procSinkName "EICC440EXTIRQ"]
                    set procVisiblePPC [string match $procSinkName "EICC405EXTINPUTIRQ"]
                    set procVisibleMB [string match $procSinkName "INTERRUPT"]                        
                    set procVisible [expr $procVisiblePPC || $procVisibleMB || $procVisiblePPC440]
                    if {$procVisible == 1} {
                        set emaclite_intr 1
                        return $emaclite_intr
                    }
                }
            }
        }
    }
    set emaclite_intr 0
    return $emaclite_intr       
}
