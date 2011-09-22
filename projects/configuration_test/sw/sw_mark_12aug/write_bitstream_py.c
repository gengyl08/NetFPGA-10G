/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        write_bitstream_py.c
 *
 *  Library:
 *        stdio.h, stdlib.h, string.h
 *
 *  Project:
 *        configuration_test
 *
 *  Author:
 *        Stephanie Friederich
 *
 *  Description:
 *        For the Flash Controller Project. Write a specified .bit file
 *        to the (A) flash.
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

#include <netlink/netlink.h>
#include "nf10_reg_lib.h"
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

//  assert(argc >= 2);

//  PCIe_Initialize();

  // unlock and erase all blocks of the flash
  // 15 Banks with each containing 8 Blocks, 15*8=120
  printf ("Unlock and Erase all blocks ... \n");
  for(i=0; i < 120 ;i++)
  {
    block_adr = i * 65536;
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
