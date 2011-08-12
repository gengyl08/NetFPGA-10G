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

  int i, bit_size, block_adr, bit_n;

  PCIe_Initialize();



  ////////////////////////////////////////////////////////////
  // read bitstream
  ////////////////////////////////////////////////////////////
  FILE * pBitstream;
  int lSize;


  pBitstream = fopen("system.bit", "r");
  // obtain bitstream size
  fseek (pBitstream , 0, SEEK_END);  
  lSize = ftell(pBitstream);
  
  block_adr = 0;
  for(i=0; i < 200; i=i+2)  
  { 
    bit_n = FLASH_read_data(block_adr++);
    printf ("Data: %04x \n",bit_n); 
  }


return 0;

}
