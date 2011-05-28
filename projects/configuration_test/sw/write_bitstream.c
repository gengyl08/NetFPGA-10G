/////////////////////////////////////////////////////////////////////
// Project: Flash controller
// Author: friederich
// Date: 15. April 2011
/////////////////////////////////////////////////////////////////////



#include "flash_func.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int argc, char **argv)
{

  int i, bit_size, block_adr,lSize, targetAddr=0;
  char **ap = argv+1;      // name of file, that should be written to flash
  FILE * pBitstream;
  unsigned char * buffer ;
  unsigned char byte1, byte2;
  unsigned char * str[2];
  unsigned char buf[16];

  assert(argc >= 2);

  PCIe_Initialize();

  // unlock and erase all blocks of the flash
  // 15 Banks with each containing 8 Blocks, 15*8=120
  printf ("Unlock and Erase all blocks ... \n");
  for(i=0; i < 120 ;i++)
  { 
    block_adr = i * 65536;
    Block_Unlock(block_adr);
    Read_el_signature(block_adr);
    Block_erase(block_adr);
    sleep(2); // because block erase need some time
  }
  printf (" done \n");

  ////////////////////////////////////////////////////////////
  // write bitstream
  ////////////////////////////////////////////////////////////
  printf ("Start writing bitstream to flash ... \n");


  pBitstream = fopen(*ap, "r");
  if (pBitstream== NULL) {printf ("Can't open Bitstream '%s' \n", *ap);}
  
  // obtain bitstream size
  fseek (pBitstream , 0, SEEK_END);  
  lSize = ftell(pBitstream);
  rewind (pBitstream);

  buffer = (char*) malloc (lSize * sizeof(char));

  fread(buffer, lSize, 1, pBitstream);
  fclose(pBitstream);

  for(i=111; i < lSize; i=i+2)  
  { 
    byte1 = buffer[i];
    byte2 = buffer[i+1];
    write_data(targetAddr++, &byte2, &byte1);
  }

free(buffer);

printf ("Bitstream completely written to the Flash \n");

return 0;

}
