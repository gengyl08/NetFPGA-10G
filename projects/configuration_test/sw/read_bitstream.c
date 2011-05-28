/////////////////////////////////////////////////////////////////////
// Project: Flash controller
// Author: friederich
// Date: 15. April 2011
// Read back complete bitstream stored in the Flash device and 
//  compares it with the original bitstream
/////////////////////////////////////////////////////////////////////




#include "flash_func.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int argc, char **argv)
{

  int i, bit_size, block_adr, bit_n, lSize;
  char **ap = argv+1;  // name of bitstream which should be compared with the one read from flash
  FILE * pBitstream;
  FILE * flash_data;
  unsigned char temp2[16];
  unsigned char temp3[16];
  unsigned char * buffer ;
  unsigned char byte1 ;
  unsigned char byte2 ;

  assert(argc >= 2);


  PCIe_Initialize();



  ////////////////////////////////////////////////////////////
  // read bitstream
  ////////////////////////////////////////////////////////////


  flash_data = fopen("read_system.bit", "wb");

  


  pBitstream = fopen(*ap, "r");;
  if (pBitstream== NULL) {printf ("Can't open Bitstream '%s' \n", *ap);}
  

  // obtain bitstream size
  fseek (pBitstream , 0, SEEK_END);  
  lSize = ftell(pBitstream);
  rewind (pBitstream);

  buffer = (char*) malloc (lSize * sizeof(char));
  fread(buffer, lSize, 1, pBitstream);
  fclose(pBitstream);
  
  block_adr = 0;
  printf ("Read bitstream and compare ... \n");
  for(i=0; i < lSize-111; i=i+2)  
  { byte1 = buffer[i+111];
    byte2 = buffer[i+112];
    sprintf(temp3, "%02x%02x", byte2, byte1 ); 

    bit_n = FLASH_read_data(block_adr++); 
    sprintf(temp2, "%04x",bit_n); 
    fwrite (temp2, 1,4, flash_data);

    if (strcmp(temp2, temp3) != 0 ) {
      printf ("Error at position 0x%08x \n", i); 
      return 0;
    }
  }
  
  printf ("Bitstreams completely compared \n"); 
  
  free(buffer);
  fclose(flash_data);

return 0;

}
