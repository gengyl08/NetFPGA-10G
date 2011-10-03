////////////////////////////////////////////////////////////////////////
//
//  NETFPGA-10G www.netfpga.org
//
//  Module:
//          nf10_flash_lib.c
//
//  Description:
//          For the Flash Controller Project.
//                 
//  Revision history:
//          28/9/2011 shahbaz    Initial revision
//
//  Known issues:
//
//
////////////////////////////////////////////////////////////////////////

#include <netlink/netlink.h>
#include "nf10_reg_lib.h"
#include "nf10_flash_lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*************************************************************
  Function body
 *************************************************************/

void Flash_Prog(char* bin_file, char flash_id)
{
	unsigned int addr;
	unsigned int base_addr;
	int i;
	
	if (flash_id == 'a' || flash_id == 'A')
		base_addr = XFL_CONFIG_BASE_ADDR_A;
	else if (flash_id == 'b' || flash_id == 'B')
		base_addr = XFL_CONFIG_BASE_ADDR_B;

	Clr_Status_Reg(base_addr);

	printf("Bitsteam: %s\r\n", bin_file);
	printf("Manufacturer ID: %x\r\n\r\n", Rd_Elec_Sig(base_addr));

	Clr_Status_Reg(base_addr);

	printf("Programming flash '%c'.\r\n", flash_id);
	printf("Started", flash_id);
	
	for (i = 0; i < XFL_CONFIG_TOTAL_BLKS; i++)
	{
		addr = base_addr + (XFL_CONFIG_BLOCK_SIZE * i);
		printf("."); fflush(stdout);
		Unlock_Single_Block(addr);
		Erase_Single_Block(addr);
	}

	Clr_Status_Reg(base_addr);
	
	Flash_Wr_Binfile_B(base_addr, bin_file);
	
	printf("Finished\r\n", flash_id);
}

void Flash_Wr_Binfile_B(unsigned int base_addr, char* bin_file)
{
	FILE *file;
	char *buffer;
	unsigned long fileLen;
	int i;

	//Open binfile
	file = fopen(bin_file, "rb");
	if (!file)
	{
		fprintf(stderr, "Unable to open file %s\r\n", bin_file);
		return;
	}

	//Get file length
	fseek(file, 0, SEEK_END);
	fileLen=ftell(file);
	fseek(file, 0, SEEK_SET);

	//Allocate memory
	buffer=(char *)malloc(fileLen+1);
	if (!buffer)
	{
		fprintf(stderr, "Memory error!\r\n");
		fclose(file);
		return;
	}

	//Read file contents into buffer
	fread(buffer, fileLen, 1, file);
	fclose(file);

	// Program Flash
	for (i = 0; i < fileLen; i++)
	{
		if (Wr_Data_B((base_addr + i), buffer[i]) != 0)
		{
			printf("Writing bin_file failed!\r\n");
			return;
		}
		
		if ((i%XFL_CONFIG_BLOCK_SIZE) == 0)
		{
			printf("."); fflush(stdout);
		}
	}

	free(buffer);
}

void Unlock_Single_Block(unsigned int addr)
{
	char status;

	do
	{
		Wr_Cmd(addr, XFL_CMD_BLOCK_LOCK_SETUP);
		Wr_Cmd(addr, XFL_CMD_CONFIRM);
		status = Rd_Cmd(addr + 2, XFL_CMD_READ_ELEC_SIG);
	}
	while (status == 1);
}

unsigned int Erase_Single_Block(unsigned int addr)
{
	Wr_Cmd(addr, XFL_CMD_BLOCK_ERASE_SETUP);
	Wr_Cmd(addr, XFL_CMD_CONFIRM);

	return Flash_Wt_Rdy(addr);
}

void Lock_Single_Block(unsigned int addr)
{
	char status;

	do
	{
		Wr_Cmd(addr, XFL_CMD_BLOCK_LOCK_SETUP);
		Wr_Cmd(addr, XFL_CMD_BLOCK_LOCK_CONFIRM);
		status = Rd_Cmd(addr + 2, XFL_CMD_READ_ELEC_SIG);
	}
	while (status == 0);
}

unsigned int Wr_Data_B(unsigned int addr, char data)
{
	Wr_Cmd(addr, XFL_CMD_PROGRAM_SETUP);
	Wr_Byte(addr, data);

	return Flash_Wt_Rdy(addr);
}

unsigned int Rd_Elec_Sig(unsigned int addr)
{
	return Rd_Cmd(addr, XFL_CMD_READ_ELEC_SIG);
}

void Clr_Status_Reg(unsigned int addr)
{
	char status;

	Wr_Cmd(addr, XFL_CMD_CLEAR_STATUS_REG);	

	do
	{
		status = Rd_Cmd(addr, XFL_CMD_READ_STATUS_REG);
	}
	while ((status & (char)XFL_STATUS_READY) != (char)XFL_STATUS_READY);
}

void Set_Read_Array_Mode(unsigned int addr)
{
	Wr_Cmd(addr, XFL_CMD_READ_ARRAY);
}

unsigned int Flash_Wt_Rdy(unsigned int addr)
{
	char status;

	// Query the device until its status indicates that it is ready
	do
	{		
		status = Rd_Cmd(addr, XFL_CMD_READ_STATUS_REG);
	}
	while (status != (char)XFL_STATUS_READY);

	return 0;
}

char Rd_Cmd(unsigned int addr, char cmd_code)
{
	Wr_Cmd(addr, cmd_code);
	return Rd_Byte(addr);
}

void Wr_Cmd(unsigned int addr, char cmd_code)
{
	Wr_Byte(addr, cmd_code);
}

void Wr_Byte(unsigned int addr, char data)
{
	nf10_reg_wr(XFL_BASE_ADDR + (addr << 2), data & 0x000000FF);
}

char Rd_Byte(unsigned int addr)
{
	unsigned int val;
	nf10_reg_rd(XFL_BASE_ADDR + (addr << 2), &val);

    	return (char)(val & 0x000000FF);
}

