/////////////////////////////////////////////////////////////////////
// Project: Flash controller
// Author: friederich
// Date: 15. April 2011
/////////////////////////////////////////////////////////////////////




#include "flash_func.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main ()
{


  PCIe_Initialize();

  //Set_Reboot_Sig();
  Reset_Reboot_Sig();


return 0;

}
