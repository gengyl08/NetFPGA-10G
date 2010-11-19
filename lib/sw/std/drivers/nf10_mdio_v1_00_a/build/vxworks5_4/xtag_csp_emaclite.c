/* xtag_csp_emaclite_v1_11_a.c - Xilinx driver inclusion file */

/*
  XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
  AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
  SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
  OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
  APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
  THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
  AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
  FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
  WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
  IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
  REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
  INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
  FOR A PARTICULAR PURPOSE.

  (c) Copyright 2002 Xilinx Inc.
  All rights reserved.

*/

/*

modification history
--------------------
01a,02jun04,ecm  First release.

*/

/*
DESCRIPTION
This file is used to compile the EMAC Lite component of the Xilinx Chip Support
Package (CSP).

INCLUDE FILES:

SEE ALSO:
*/

#include "vxWorks.h"
#include "config.h"

#ifdef INCLUDE_XEMACLITE
#  include "xemaclite.c"
#  include "xemaclite_l.c"
#  include "xemaclite_g.c"
#  include "xemaclite_intr.c"
#  include "xemaclite_selftest.c"
#  include "xemaclite_sinit.c"

#endif

#  ifdef INCLUDE_XEMACLITE_VXWORKS5_4
#    include "xemaclite_end_adapter.c"
#  endif


