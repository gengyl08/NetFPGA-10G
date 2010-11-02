##############################################################################
## Filename:          /hpn/home/hyzeng/sandbox/selftest/xps/drivers/xaui_status_v1_00_a/data/xaui_status_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Sep 19 15:37:39 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "xaui_status" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
