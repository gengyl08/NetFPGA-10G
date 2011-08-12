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

  int i, bit_size, block_adr;

  PCIe_Initialize();


  // unlock and erase all blocks of the flash
  // 15 Banks with each containing 8 Blocks, 15*8=120
  printf ("Unlock and Erase all blocks ... \t");
  for(i=0; i < 1 ;i++)
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
  FILE * pBitstream;
  int lSize, targetAddr=0;
  unsigned char * buffer ;
  unsigned char byte1 ;
  unsigned char byte2 ;
  unsigned char * str[2];

  unsigned char buf[16];


  pBitstream = fopen("prod_test.bit", "r");
  if (pBitstream== NULL) {printf ("Can't open Bitstream \n");}
  
  // obtain bitstream size
  fseek (pBitstream , 0, SEEK_END);  
  lSize = ftell(pBitstream);
  rewind (pBitstream);

  buffer = (char*) malloc (lSize * sizeof(char));

  fread(buffer, lSize, 1, pBitstream);
  fclose(pBitstream);

  for(i=111; i < 600; i=i+2)  
  { 
    byte1 = buffer[i];
    byte2 = buffer[i+1];
    write_data(targetAddr++, &byte2, &byte1);
  }

free(buffer);

printf ("Bitstream completely written to the Flash \n");


return 0;

}
