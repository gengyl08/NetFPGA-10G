/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_flash_lib.c
 *
 *  Project:
 *        flash_configuration
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        For the Flash Controller Project.
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 University of Cambridge
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
        int dev;
	FILE *file;
	unsigned int addr;
	unsigned int base_addr;
	unsigned int elec_sig = 0;
	int i;


        //Open dev_file
        dev = nf10_dev_open();
	//Open bin_file
	file = fopen(bin_file, "rb");
	if (!file)
	{
		fprintf(stderr, "Unable to open file %s.\r\n", bin_file);
		return;
	}

	//Select flash
	if (flash_id == 'a' || flash_id == 'A')
		base_addr = XFL_CONFIG_BASE_ADDR_A;
	else if (flash_id == 'b' || flash_id == 'B')
		base_addr = XFL_CONFIG_BASE_ADDR_B;
	else
	{
		fprintf(stderr, "Invalid target flash '%c'!\r\n", flash_id);
		return;
	}

	Clr_Status_Reg(dev, base_addr);

	printf("Flash image: %s\r\n", bin_file);

	elec_sig = Rd_Elec_Sig(dev, base_addr);
	printf("Manufacturer ID: %x\r\n", elec_sig);

	if (elec_sig != 0x49)
	{
		fprintf(stderr, "Invalid electronic signature! Please verify that the CPLD is configured properly.\r\n");
		return;
	}

	Clr_Status_Reg(dev, base_addr);

	printf("Programming flash '%c'.\r\n", flash_id);
	printf("[", flash_id);

	for (i = 0; i < XFL_CONFIG_TOTAL_BLKS; i++)
	{
		addr = base_addr + (XFL_CONFIG_BLOCK_SIZE * i);
		printf("."); fflush(stdout);
		Unlock_Single_Block(dev, addr);
		Erase_Single_Block(dev, addr);
	}

	Clr_Status_Reg(dev, base_addr);

	Flash_Wr_Binfile_B(dev, base_addr, file);

	printf("]\r\n", flash_id);
	
        //Close bin_file
        fclose(file);
        //Close dev_file
        close(dev);
}

void Flash_Wr_Binfile_B(int dev, unsigned int base_addr, FILE* file)
{
	char *buffer;
	unsigned long fileLen;
	int i;

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

	// Program Flash
	for (i = 0; i < fileLen; i++)
	{
		if (Wr_Data_B(dev, (base_addr + i), buffer[i]) != 0)
		{
			printf("Writing flash image failed!\r\n");
			return;
		}

		if ((i%XFL_CONFIG_BLOCK_SIZE) == 0)
		{
			printf("."); fflush(stdout);
		}
	}

	free(buffer);
}

void Unlock_Single_Block(int dev, unsigned int addr)
{
	char status;

	do
	{
		Wr_Cmd(dev, addr, XFL_CMD_BLOCK_LOCK_SETUP);
		Wr_Cmd(dev, addr, XFL_CMD_CONFIRM);
		status = Rd_Cmd(dev, addr + 2, XFL_CMD_READ_ELEC_SIG);
	}
	while (status == 1);
}

unsigned int Erase_Single_Block(int dev, unsigned int addr)
{
	Wr_Cmd(dev, addr, XFL_CMD_BLOCK_ERASE_SETUP);
	Wr_Cmd(dev, addr, XFL_CMD_CONFIRM);

	return Flash_Wt_Rdy(dev, addr);
}

void Lock_Single_Block(int dev, unsigned int addr)
{
	char status;

	do
	{
		Wr_Cmd(dev, addr, XFL_CMD_BLOCK_LOCK_SETUP);
		Wr_Cmd(dev, addr, XFL_CMD_BLOCK_LOCK_CONFIRM);
		status = Rd_Cmd(dev, addr + 2, XFL_CMD_READ_ELEC_SIG);
	}
	while (status == 0);
}

unsigned int Wr_Data_B(int dev, unsigned int addr, char data)
{
	Wr_Cmd(dev, addr, XFL_CMD_PROGRAM_SETUP);
	Wr_Byte(dev, addr, data);

	return Flash_Wt_Rdy(dev, addr);
}

unsigned int Rd_Elec_Sig(int dev, unsigned int addr)
{
	return Rd_Cmd(dev, addr, XFL_CMD_READ_ELEC_SIG);
}

void Clr_Status_Reg(int dev, unsigned int addr)
{
	char status;

	Wr_Cmd(dev, addr, XFL_CMD_CLEAR_STATUS_REG);

	do
	{
		status = Rd_Cmd(dev, addr, XFL_CMD_READ_STATUS_REG);
	}
	while ((status & (char)XFL_STATUS_READY) != (char)XFL_STATUS_READY);
}

void Set_Read_Array_Mode(int dev, unsigned int addr)
{
	Wr_Cmd(dev, addr, XFL_CMD_READ_ARRAY);
}

unsigned int Flash_Wt_Rdy(int dev, unsigned int addr)
{
	char status;

	// Query the device until its status indicates that it is ready
	do
	{
		status = Rd_Cmd(dev, addr, XFL_CMD_READ_STATUS_REG);
	}
	while (status != (char)XFL_STATUS_READY);

	return 0;
}

char Rd_Cmd(int dev, unsigned int addr, char cmd_code)
{
	Wr_Cmd(dev, addr, cmd_code);
	return Rd_Byte(dev, addr);
}

void Wr_Cmd(int dev, unsigned int addr, char cmd_code)
{
	Wr_Byte(dev, addr, cmd_code);
}

void Wr_Byte(int dev, unsigned int addr, char data)
{
	nf10_reg_wr(dev, XFL_BASE_ADDR + (addr << 2), data & 0x000000FF);
}

char Rd_Byte(int dev, unsigned int addr)
{
	unsigned int val;
	val = nf10_reg_rd(dev, XFL_BASE_ADDR + (addr << 2));

    	return (char)(val & 0x000000FF);
}

