////////////////////////////////////////////////////////////////////////
//
//  NETFPGA-10G www.netfpga.org
//
//  Module:
//          write_bitstream_py.c
//
//  Description:
//          For the Flash Controller Project. Write a specified .bit file
//          to the (B) flash. 
//                 
//  Revision history:
//          15/04/2011 friederich    Initial revision
//          08/07/2011 Mark Grindell Added this header
//          12/08/2011 Mark Grindell Removed bias of 111, uses new driver.
//
//  Known issues:
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

  int i, bit_size, block_adr,lSize, targetAddr=0x800000;
  char **ap = argv+1;      // name of file, that should be written to flash
  FILE * pBitstream;
  unsigned char * buffer ;
  unsigned char byte1, byte2;
  unsigned char * str[2];
  unsigned char buf[16];

//  assert(argc >= 2);

//  PCIe_Initialize();

  // unlock and erase all blocks of the flash
  // 15 Banks with each containing 8 Blocks, 15*8=120
  printf ("Unlock and Erase all blocks ... \n");
  for(i=0; i < 120 ;i++)
  { 
    block_adr = i * 65536 + 0x800000;
    nf10_reg_wr (0x08, block_adr++);     // Block_Unlock(block_adr);
    nf10_reg_wr (0x00, 0x0c);
    nf10_reg_wr (0x08, block_adr++);     // Read_el_signature(block_adr);
    nf10_reg_wr (0x00, 0x01);
    nf10_reg_wr (0x08, block_adr++);     // Block_erase(block_adr);
    nf10_reg_wr (0x00, 0x02);
    sleep(2); // because block erase need some time
  }
  printf (" done \n");

  ////////////////////////////////////////////////////////////
  // write bitstream
  ////////////////////////////////////////////////////////////
  printf ("Start writing bitstream to flash using the Python driver... \n");

  pBitstream = fopen(*ap, "r");
  if (pBitstream== NULL)
    printf ("Can't open Bitstream '%s' \n", *ap);
  
  // obtain bitstream size
  fseek (pBitstream , 0, SEEK_END);  
  lSize = ftell(pBitstream);
  rewind (pBitstream);

  buffer = (char*) malloc (lSize * sizeof(char));

  fread(buffer, lSize, 1, pBitstream);
  fclose(pBitstream);

  for(i = 0; i < lSize; i = i + 2)  
  { 
    byte1 = buffer[i];
    byte2 = buffer[i+1];
    if (i == 0)
    {
      nf10_reg_wr (0x08, targetAddr++);
      nf10_reg_wr (0x04, ((byte2 << 8) & 0xff00) + (byte1 & 0xff));
      nf10_reg_wr (0x00, 4);
    }
    else
      nf10_reg_wr (0x04, ((byte2 << 8) & 0xff00) + (byte1 & 0xff));
  }

  free(buffer);

  printf ("Bitstream completely written to the Flash \n");

  return 0;
}
