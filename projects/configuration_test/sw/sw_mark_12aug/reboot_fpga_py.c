/////////////////////////////////////////////////////////////////////
// Project: Flash controller
// Author: friederich
// Date: 15. April 2011
/////////////////////////////////////////////////////////////////////




#include <netlink/netlink.h>
#include "nf10_reg_lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main ()
{


  PCIe_Initialize();

  //Set_Reboot_Sig();
  nf10_reg_wr (0x00, 0x08); // Reset reboot signal


return 0;

}
