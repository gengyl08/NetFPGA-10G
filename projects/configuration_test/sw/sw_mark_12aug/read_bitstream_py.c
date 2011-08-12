////////////////////////////////////////////////////////////////////////
//
//  NETFPGA-10G www.netfpga.org
//
//  Module:
//          read_bitstream_py.c
//
//  Description:
//          For the Flash Controller Project. Reads back the contents of
//          The (A) flash and compares it to the contents of the specified
//          .bit file using the new driver
//                 
//  Revision history:
//          15/04/2011 friederich    Initial revision
//          08/07/2011 Mark Grindell Now uses a fast method of reading the flash,
//                                   where the starting address is supplied once
//                                   and, taking advantage of new features in the
//                                   FPGA, just reads sucessive bytes.
//          12/08/2011 Mark Grindell Removed bias of 111, uses new driver.
//
//  Known issues:
//          Pretends that no errors have occured (commented out the "return"
//          Statement) so we can see what exactly has gone wrong. Can still
//          tell if teh comparison works or not!
//
//  Library: stdio.h, stdlib.h, string.h
//
////////////////////////////////////////////////////////////////////////




#include <netlink/netlink.h>
#include "nf10_reg_lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int argc, char **argv)
{

  int i, j, bit_size, block_adr, bit_n, lSize;
  char **ap = argv+1;  // name of bitstream which should be compared with the one read from flash
  FILE * pBitstream;
  FILE * flash_data;
  unsigned char temp2[16];
  unsigned char temp3[16];
  unsigned char * buffer ;
  unsigned char byte1 ;
  unsigned char byte2 ;

//  assert(argc >= 2);


//  PCIe_Initialize();



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
  
  block_adr = 0x00000;
  printf ("Read bitstream with the python library and compare ... \n");
  for(i=0; i < lSize; i=i+2)  
  { 
    byte1 = buffer[i];
    byte2 = buffer[i+1];
    sprintf(temp3, "%02x%02x", byte2, byte1 ); 

    if (i == 0)
    {
      nf10_reg_wr (0x08, block_adr++);     //FLASH_read_data(block_adr++);
      nf10_reg_wr (0x00, 0x05);
    }

    nf10_reg_rd (0x0c, &bit_n);//FLASH_read_next();
    
    sprintf(temp2, "%04x",bit_n); 
    fwrite (temp2, 1,4, flash_data);

    if (strcmp(temp2, temp3) != 0 )
      printf ("Error at position 0x%08x, Flash is %s, file is %s \n", i, temp2, temp3); 
  }
  
  printf ("Bitstreams completely compared \n"); 
  
  free(buffer);
  fclose(flash_data);

return 0;

}
