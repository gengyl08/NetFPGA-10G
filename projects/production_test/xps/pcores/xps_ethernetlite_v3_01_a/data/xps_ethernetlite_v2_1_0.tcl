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
##    Copyright 2005, 2008, 2009 Xilinx, Inc.                                
##    All rights reserved.                     
##                                 
##    This disclaimer and copyright notice must be retained as part       
##    of this file at all times.                  
##  
###############################################################################
##
## xps_ethernetlite_v2_1_0.tcl
##
###############################################################################


#***--------------------------------***-----------------------------------***
#
#             CORE_LEVEL_CONSTRAINTS
#
#***--------------------------------***-----------------------------------***

proc generate_corelevel_ucf {mhsinst} {


    puts "***************************************"
    puts " xps_ethernetlite ucf constraints removed to only use mdio"
    puts "***************************************"

    return

    set  filePath [xget_ncf_dir $mhsinst]

    file mkdir    $filePath

    # specify file name
    set    instname   [xget_hw_parameter_value $mhsinst "INSTANCE"]
    set    name_lower [string      tolower    $instname]
    set    fileName   $name_lower
    append fileName   "_wrapper.ucf"
    append filePath   $fileName

    set    duplex     [xget_value $mhsinst   "parameter" "C_DUPLEX"]

    # Open a file for writing
    set    outputFile [open $filePath "w"]

    # Send a line to the output file
  #  puts   $outputFile "NET \"PHY_rx_clk\" TNM_NET = \"RXCLK_GRP_$instname\";"
     puts   $outputFile "NET \"PHY_tx_clk\" TNM_NET = \"TXCLK_GRP_$instname\";"
     puts   $outputFile "TIMESPEC \"TSTXOUT_$instname\" = FROM \"TXCLK_GRP_$instname\" TO \"PADS\" 10 ns;"
  #  puts   $outputFile "TIMESPEC \"TSRXIN_$instname\" = FROM \"PADS\" TO \"RXCLK_GRP_$instname\" 6 ns;"

     ########################################################
     ### OFFSET IN and OFFSET OUT constraints on PHY Clocks
     ########################################################
      set tx_clk         [ xget_connected_global_ports $mhsinst "PHY_tx_clk"]
      set rx_clk         [ xget_connected_global_ports $mhsinst "PHY_rx_clk"]

      set global_tx_clk_name [ xget_hw_name [lindex $tx_clk 0] ]
      set global_rx_clk_name [ xget_hw_name [lindex $rx_clk 0] ]

      #puts   $outputFile "OFFSET = OUT 10.000 AFTER  \"$global_tx_clk_name\";"
      puts   $outputFile "OFFSET = IN 6.000 BEFORE  \"$global_rx_clk_name\";"

     #########################################################
 
 

    set target_family [ xget_hw_parameter_value $mhsinst "C_FAMILY" ]

    # family based constraints
    # if virtex family
    if { [xcheck_virtex_device $target_family] == 1 } {

      puts   $outputFile "NET \"PHY_rx_clk\" USELOWSKEWLINES;"
      puts   $outputFile "NET \"PHY_tx_clk\" USELOWSKEWLINES;"

    }

    # for devices V4
    if { [xcheck_virtex4_device $target_family] == 1 } {

      puts   $outputFile "NET \"PHY_tx_clk\" MAXSKEW= 5.0 ns;"
      puts   $outputFile "NET \"PHY_rx_clk\" MAXSKEW= 5.0 ns;"

    } else {
    
      puts   $outputFile "NET \"PHY_tx_clk\" MAXSKEW= 5.0 ns;"
      puts   $outputFile "NET \"PHY_rx_clk\" MAXSKEW= 5.0 ns;"
    
    }

    puts   $outputFile "NET \"PHY_rx_clk\" PERIOD = 40 ns HIGH 14 ns;"
    puts   $outputFile "NET \"PHY_tx_clk\" PERIOD = 40 ns HIGH 14 ns;"

    # if C_FAMILY == V4, V5 or SPARTAN3E, use IOBDELAY=NONE and 
    # NODELAY for everything else
    ## set delay "NODELAY"
    set delay "IOBDELAY=NONE"

    if { [string compare -nocase $target_family "virtex"] == 0 } {
      set delay "NODELAY"
    } 

    puts   $outputFile "NET \"PHY_rx_data<3>\" $delay;"
    puts   $outputFile "NET \"PHY_rx_data<2>\" $delay;"
    puts   $outputFile "NET \"PHY_rx_data<1>\" $delay;"
    puts   $outputFile "NET \"PHY_rx_data<0>\" $delay;"
    puts   $outputFile "NET \"PHY_dv\" $delay;"
    puts   $outputFile "NET \"PHY_rx_er\" $delay;"
    puts   $outputFile "NET \"PHY_crs\" $delay;"

    if { $duplex == 0 } {

        puts   $outputFile "NET \"PHY_col\" $delay;"
    }

    # Close the file
    close  $outputFile

    puts   [xget_ncf_loc_info $mhsinst]

}

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