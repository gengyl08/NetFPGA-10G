###############################################################################
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
## Copyright 1995-2010 Xilinx, Inc.
## All rights reserved.
##
## This disclaimer and copyright notice must be retained as part
## of this file at all times.
##
###############################################################################
##
###############################################################################
##  									
##   proc_sys_reset_v2_1_0.tcl						
##									
###############################################################################
#
#***--------------------------------***------------------------------------***
#
#                            IPLEVEL_DRC_PROC
#
#***--------------------------------***------------------------------------***

proc check_iplevel_settings {mhsinst} {
   check_parameter  $mhsinst
}

##########################################################################    
# Procedure to check if C_AUX_RESET_HIGH =0 AND Aux_Reset_In is connected#
##########################################################################
proc check_parameter {mhsinst} {
  set  instname [xget_hw_parameter_value $mhsinst "INSTANCE"]

  set x [xget_hw_name $mhsinst]
  set y $mhsinst
  set AUX_RST_PARM [xget_hw_parameter_value $y "C_AUX_RESET_HIGH"]

  if { $AUX_RST_PARM == 0 } {
        set AUX_RST_PORT [xget_hw_port_value $y "Aux_Reset_In"]
        set x [xget_hw_name $y]
	if { $AUX_RST_PORT != ""} {
		puts "Parameter C_AUX_RESET_HIGH is defined in $instname. Make sure to connect Aux_Reset_In port with valid source.\n"			
	} else {
	        error "In $instname the parameter C_AUX_RESET_HIGH is assigned to logic 0, but Aux_Reset_In port not connected. It is necessary to connect this port when C_AUX_RESET_HIGH assigned to 0\n"
	}
  }
}
##########################################################################
