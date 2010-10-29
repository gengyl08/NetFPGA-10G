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
## Copyright 2002-2010 Xilinx, Inc.
## All rights reserved.
##
## This disclaimer and copyright notice must be retained as part
## of this file at all times.
##
###############################################################################
##
## lmb_v10_v2_1_0.tcl
##
###############################################################################

proc check_iplevel_settings {mhsinst} {
    # check bus connectivity will be done in platgen
}

proc connected_lmb_source { mhsinst } {
    set mhs_handle [xget_hw_parent_handle $mhsinst]

    set mb ""
    set addrstrobe_con [xget_hw_port_value $mhsinst "M_AddrStrobe"] 
    if { [llength $addrstrobe_con] > 0} {
      set addrstrobe_source [xget_connected_ports_handle $mhs_handle $addrstrobe_con "SOURCE"]
      if {[llength $addrstrobe_source] != 0} {
        set mb [xget_hw_parent_handle $addrstrobe_source]
      }
    }

    if {$mb != ""} {
      return $mb
    }
    return ""
}

#***--------------------------------***-----------------------------------***
#
#			     CORE_LEVEL_CONSTRAINTS
#
#***--------------------------------***-----------------------------------***

proc generate_corelevel_ucf {mhsinst} {

   set  filePath [xget_ncf_dir $mhsinst]

   file mkdir    $filePath

   # specify file name
   set    instname   [xget_hw_parameter_value $mhsinst "INSTANCE"]
   set    name_lower [string 	  tolower    $instname]
   set    fileName   $name_lower
   append fileName   "_wrapper.ucf"
   append filePath   $fileName

   # Open a file for writing
   set outputFile [open $filePath "w"]

   # Add TIG constraints for SYS_Rst when AXI is used
   set mbmhsinst [connected_lmb_source $mhsinst]
   if {$mbmhsinst != ""} {
      set interconnect [xget_hw_parameter_value $mbmhsinst "C_INTERCONNECT"]
      if {$interconnect == 2} {
        puts "INFO: Setting timing constaints for ${instname}."

        puts $outputFile "INST \"${name_lower}/POR_FF_I\" TNM = \"${name_lower}_POR_FF_I_dst\";"
        puts $outputFile "TIMESPEC \"TS_TIG_${name_lower}_POR_FF_I\" = FROM FFS TO \"${name_lower}_POR_FF_I_dst\" TIG;"
      }
   }

   # Close the file
   close  $outputFile

   puts   [xget_ncf_loc_info $mhsinst]
}
