/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        write_bits_flashA.c
 *
 *  Library:
 *        stdio.h, stdlib.h, string.h
 *
 *  Project:
 *        configuration_test_no_cdc
 *
 *  Module:
 *        write_fast.c
 *
 *  Author:
 *        Stephanie Friederich
 *
 *  Description:
 *        For the Flash Controller Project. Writes the specified .bit file
 *        to the (A) flash; uses a fast method that only writes the initial
 *        address then writes sucessive data bytes, using the address register
 *        auto-increment in the FPGA.
 *
 *  Copyright notice:
 *        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
 *                                Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

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
    if (i == 111)
      write_data(targetAddr++, &byte2, &byte1);
    else
      write_next(&byte2, &byte1);
  }

free(buffer);

printf ("Bitstream completely written to the Flash \n");

return 0;

}
