#////////////////////////////////////////////////////////////////////////
#//
#//  NetFPGA-10G http://www.netfpga.org
#//
#//  Module:
#//          nf10_mdio_v2_1_0.tcl
#//
#//  Description:
#//          Driver TCL script
#//                 
#//  Revision history:
#//          2010/12/8 hyzeng: Initial check-in
#//
#////////////////////////////////////////////////////////////////////////

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "XEmacLite" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" "C_TX_PING_PONG" "C_RX_PING_PONG" "C_INCLUDE_MDIO" "C_INCLUDE_INTERNAL_LOOPBACK"
  xdefine_config_file $drv_handle "xemaclite_g.c" "XEmacLite"  "DEVICE_ID" "C_BASEADDR" "C_TX_PING_PONG" "C_RX_PING_PONG" "C_INCLUDE_MDIO" "C_INCLUDE_INTERNAL_LOOPBACK"

  xdefine_canonical_xpars $drv_handle "xparameters.h" "EmacLite" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" "C_TX_PING_PONG" "C_RX_PING_PONG" "C_INCLUDE_MDIO" "C_INCLUDE_INTERNAL_LOOPBACK"
}
