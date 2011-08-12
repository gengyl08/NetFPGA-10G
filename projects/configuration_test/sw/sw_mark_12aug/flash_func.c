////////////////////////////////////////////////////////////////////////
//
//  NETFPGA-10G www.netfpga.org
//
//  Module:
//          flash_func.c
//
//  Description:
//          For the Flash Controller Project. 
//                 
//  Revision history:
//          15/04/2011 friederich    Initial revision
//          08/07/2011 Mark Grindell Now includes abbreviated routines that 
//                                   do not supply addresses, "write_next", and 
//                                   "Flash_read_next" where only data is actually
//                                   written or read. THis enormously speeds up
//                                   the PCIe transactions...
//          date author description
//
//  Known issues:
//          None
//
//  Library: swctl.h
//
////////////////////////////////////////////////////////////////////////


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
