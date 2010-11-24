###############################################################################
##    DISCLAIMER OF LIABILITY                     
##                                 
##    This file contains proprietary and confidential information of      
##    Xilinx, Inc. ("Xilinx"), that is distributed under a license        
##    from Xilinx, and may be used, copied and/or disclosed only       
##    pursuant to the terms of a valid license agreement with Xilinx.        
##                                 
##    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION         
##    ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER       
##    EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT           
##    LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,        
##    MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx       
##    does not warrant that functions included in the Materials will      
##    meet the requirements of Licensee, or that the operation of the        
##    Materials will be uninterrupted or error-free, or that defects      
##    in the Materials will be corrected. Furthermore, Xilinx does        
##    not warrant or make any representations regarding use, or the       
##    results of the use, of the Materials in terms of correctness,       
##    accuracy, reliability or otherwise.               
##                                 
##    Xilinx products are not designed or intended to be fail-safe,       
##    or for use in any application requiring fail-safe performance,      
##    such as life-support or safety devices or systems, Class III        
##    medical devices, nuclear facilities, applications related to        
##    the deployment of airbags, or any other applications that could        
##    lead to death, personal injury or severe property or          
##    environmental damage (individually and collectively, "critical      
##    applications"). Customer assumes the sole risk and liability        
##    of any use of Xilinx products in critical applications,          
##    subject only to applicable laws and regulations governing        
##    limitations on product liability.                 
##                                 
##    Copyright 2005, 2008, 2009, 2010 Xilinx, Inc.                                
##    All rights reserved.                     
##                                 
##    This disclaimer and copyright notice must be retained as part       
##    of this file at all times.                  
##  
###############################################################################
##
## nf10_mdio_v2_1_0.tcl
##
###############################################################################

#***--------------------------------***-----------------------------------***
#
#                          SYSLEVEL_DRC_PROC (IP)
#
#***--------------------------------***-----------------------------------***

proc check_syslevel_drcs {mhsinst} {
   set  instname           [xget_hw_parameter_value $mhsinst "INSTANCE"]
   set  include_mdio  [xget_hw_parameter_value $mhsinst "C_INCLUDE_MDIO"]
   set  nhandle [xget_hw_parameter_value $mhsinst PHY_MDIO]
   #puts "this is handle :$nhandle ,"

   if { $include_mdio == 1 } {

   if {[xget_hw_port_value $mhsinst PHY_MDIO] != ""} {
     puts "Port present in $instname"
   } elseif {[xget_hw_port_value $mhsinst PHY_MDIO_I] != "" && [xget_hw_port_value $mhsinst PHY_MDIO_O] != "" && [xget_hw_port_value $mhsinst PHY_MDIO_T] != ""} {
     puts "Port present MDIO_MDIO (I,O,T) in $instname"

   } else {
     error "Port PHY_MDIO or PHY_MDIO_I/_O/_T not present in $instname; User must specify a connection to this port in the MHS when MDIO interface is included in the design." "" "mdt_error"
     

   }
   }

}
