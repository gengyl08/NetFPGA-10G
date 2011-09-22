/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        read_bits_flashA.c
 *
 *  Library:
 *        stdio.h, stdlib.h, string.h
 *
 *  Project:
 *        configuration_test
 *
 *  Module:
 *        read_bitstream.c
 *
 *  Author:
 *        Stephanie Friederich
 *
 *  Description:
 *        For the Flash Controller Project. Reads back the contents of
 *        The (A) flash and compares it to the contents of the specified
 *        .bit file.
 *
 *  Copyright notice:
 *        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
 *                                Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This package is free software: you can redistribute it and/or modify
 *        it under the terms of the GNU Lesser General Public License as
 *        published by the Free Software Foundation, either version 3 of the
 *        License, or (at your option) any later version.
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

  int i, j, bit_size, block_adr, bit_n, lSize;
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

  block_adr = 0x00000;
  printf ("Read bitstream with new method and compare ... \n");
  for(i=0; i < lSize-111; i=i+2)
  { byte1 = buffer[i+111];
    byte2 = buffer[i+112];
    sprintf(temp3, "%02x%02x", byte2, byte1 );

    if (i == 0)
      bit_n = FLASH_read_data(block_adr++);
    else
      bit_n = FLASH_read_next();

      sprintf(temp2, "%04x",bit_n);
      fwrite (temp2, 1,4, flash_data);

      if (strcmp(temp2, temp3) != 0 )
      {
        printf ("Error at position 0x%08x, Flash is %s, file is %s \n", i, temp2, temp3);
       // return 0;
      }
  }

  printf ("Bitstreams completely compared \n");

  free(buffer);
  fclose(flash_data);

return 0;

}
