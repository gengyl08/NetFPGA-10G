
/*******************************************************************************
* EMAC Lite component and parameters
*******************************************************************************/

Folder FOLDER_xtag_csp_EMACLITE {
  NAME       EMAC Lite
  SYNOPSIS   EMAC Lite support
  _CHILDREN  FOLDER_xtag_csp_CSP
}

Component INCLUDE_XEMACLITE {
  NAME       EMAC Lite interface
  SYNOPSIS   EMAC Lite interface
  REQUIRES   
  _CHILDREN  FOLDER_xtag_csp_EMACLITE
}
