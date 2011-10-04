/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        flash_func.c
 *
 *  Library:
 *        swctl.h
 *
 *  Project:
 *        configuration_test
 *
 *  Author:
 *        Stephanie Friederich
 *
 *  Description:
 *        For the Flash Controller Project.
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

#include "swctl.c"



//  CMD_REG_OFFSET      = "0x00000000";
//  DATA_IN_REG_OFFSET  = "0x00000004";
//  ADDR_REG_OFFSET     = "0x00000008";
//  DATA_OUT_REG_OFFSET = "0x0000000C";

  char *  arg_str[7];
  unsigned char temp[23];



int PCIe_Initialize ()
{

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wunreset";
  arg_str[3] = "0";
  main_swctl(4, arg_str);
  arg_str[2] = "wop";
  arg_str[3] = "0";
  arg_str[4] = "initialize";
  main_swctl(5, arg_str);
  arg_str[2] = "wop";
  arg_str[3] = "0";
  arg_str[4] = "start";
  main_swctl(5, arg_str);

  return 0;
}


int PCIe_reset ()
{
  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";
  arg_str[2] = "wreset";
  arg_str[3] = "0";
  main_swctl(4, arg_str);

  return 0;
}




int Read_el_signature( int block_adr)
{
  sprintf(temp, "0x%06x", block_adr);
  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x1";             // command "0001"
  main_swctl(6, arg_str);

  return 0;
}


int Block_Unlock(int block_adr)
{
  sprintf(temp, "0x%06x", block_adr);

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0xC";            // command "1100"
  main_swctl(6, arg_str);
  return 0;
}

int read_status(int block_adr)
{
  sprintf(temp, "0x%06x", block_adr);

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0xA";
  main_swctl(6, arg_str);

  return 0;
}

int Block_erase(int block_adr)
{
  sprintf(temp, "0x%06x", block_adr);

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x2";
  main_swctl(6, arg_str);

  return 0;
}


char write_data(int block_adr, unsigned char * write_data, unsigned char * write_data2)
{
  unsigned char temp2[16];
  sprintf(temp2, "0x%02x%02x", *write_data, *write_data2 );

  sprintf(temp, "0x%06x", block_adr);

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000004";
  arg_str[5] = temp2;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x4";
  main_swctl(6, arg_str);

  return 0;
}

char write_next(unsigned char * write_data, unsigned char * write_data2)
{
  unsigned char temp2[16];
  sprintf(temp2, "0x%02x%02x", *write_data, *write_data2 );


  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000004";
  arg_str[5] = temp2;
  main_swctl(6, arg_str);
//  arg_str[2] = "wwrite";
//  arg_str[3] = "0";
//  arg_str[4] = "0x00000000";
//  arg_str[5] = "0x4";
//  main_swctl(6, arg_str);

  return 0;
}

char write_mcs(int block_adr, unsigned char * write_data, unsigned char * write_data2, unsigned char * write_data3, unsigned char * write_data4)
{
  unsigned char temp2[16];
  sprintf(temp2, "0x%c%c%c%c", *write_data, *write_data2, *write_data3, *write_data4 );

  sprintf(temp, "0x%06x", block_adr);

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000004";
  arg_str[5] = temp2;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x4";
  main_swctl(6, arg_str);

  return 0;
}



int FLASH_read_data(int block_adr)
{
  int read_data;
  char * data;
  sprintf(temp, "0x%06x", block_adr);

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000008";
  arg_str[5] = temp;
  main_swctl(6, arg_str);
  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x5";
  main_swctl(6, arg_str);
  arg_str[2] = "wread";
  arg_str[3] = "0";
  arg_str[4] = "0x0000000C";
  arg_str[5] = "1";

  read_data = main_swctl(6, arg_str);
  return read_data;
  //return data;
}

int FLASH_read_next(void)
{
  int read_data;
  char * data;

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

//  arg_str[2] = "wwrite";
//  arg_str[3] = "0";
//  arg_str[4] = "0x00000000";
//  arg_str[5] = "0x5";
//  main_swctl(6, arg_str);
  arg_str[2] = "wread";
  arg_str[3] = "0";
  arg_str[4] = "0x0000000C";
  arg_str[5] = "1";

  read_data = main_swctl(6, arg_str);
  return read_data;
  //return data;
}

// enable configuration
int Set_Reboot_Sig()
{
  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x7";
  main_swctl(6, arg_str);

  return 0;
}


int Reset_Reboot_Sig()
{

  arg_str[0] = "0xDE000000";
  arg_str[1] = "0xDFFF0000";

  arg_str[2] = "wwrite";
  arg_str[3] = "0";
  arg_str[4] = "0x00000000";
  arg_str[5] = "0x8";
  main_swctl(6, arg_str);

  return 0;
}
