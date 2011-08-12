/*
 * flash_controller.c
 *  Date: 12 April 2011
 *  Author: Stephanie Friederich
 */

#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include <swctl.h>


#define Flash_BaseAddress   0x00000000
#define CMD_REG_OFFSET      0x00000000
#define DATA_IN_REG_OFFSET  0x00000004
#define ADDR_REG_OFFSET     0x00000008
#define DATA_OUT_REG_OFFSET 0x0000000C

#define address1            0xDE000000
#define address2            0xDFFF0000


 int swctl(int argc, char **argv);


int main() {


	uint32_t Data;
	uint32_t read_data;
	int flash_adr, i;

	Data = 0x589F;
	flash_adr = 0x600000;


	/* Initialisation */
	swctl(address1, address2, 'wunreset', 0 );
	swctl(address1, address2, 'wop', 0, 'initialize');
	swctl(address1, address2, 'wop', 0, 'start');



	/* Test cycle */
	Read_el_signature( Flash_BaseAddress, flash_adr);
	for( i=1; i < 400; i++)
	{}
	Block_Unlock(Flash_BaseAddress, flash_adr);
	for(i=1; i < 100; i++)
	{}
	Block_erase(Flash_BaseAddress, flash_adr);
	for(i=1; i < 1000; i++)
	{}
	write_data(Flash_BaseAddress, flash_adr, Data);
	for(i=1; i < 100; i++)
	{}


	return 0;
}




int Read_el_signature( uint32_t BaseAdr, uint32_t block_adr)
{
	swctl(address1, address2, 'wwrite', 0, ADDR_REG_OFFSET, block_adr);
	swctl(address1, address2, 'wwrite', 0, CMD_REG_OFFSET, 0x1);             // command "0001"
	return 0;
}

/*
 *
 */
int Block_Unlock( uint32_t BaseAdr, uint32_t block_adr)
{
	swctl(address1, address2, 'wwrite', 0, ADDR_REG_OFFSET, block_adr);
	swctl(address1, address2, 'wwrite', 0, CMD_REG_OFFSET, 0xC);            // command "1100"
	return 0;
}


/*
 *
 */
int Block_erase(uint32_t BaseAdr, uint32_t block_adr)
{
	swctl(address1, address2, 'wwrite', 0, ADDR_REG_OFFSET, block_adr);
	swctl(address1, address2, 'wwrite', 0, CMD_REG_OFFSET, 0x2);
	return 0;
}

/*
 *
 */
int write_data(uint32_t BaseAdr, uint32_t block_adr, uint32_t write_data)
{
	swctl(address1, address2, 'wwrite', 0, ADDR_REG_OFFSET, block_adr);
	swctl(address1, address2, 'wwrite', 0, DATA_IN_REG_OFFSET, write_data);
	swctl(address1, address2, 'wwrite', 0, CMD_REG_OFFSET, 0x4);
	return 0;
}


/*
 *
 */
uint32_t FLASH_read_data(uint32_t BaseAdr, uint32_t block_adr)
{
	uint32_t data;
	swctl(address1, address2, 'wwrite', 0, ADDR_REG_OFFSET, block_adr);
	swctl(address1, address2, 'wwrite', 0, CMD_REG_OFFSET, 0x5);

	swctl(address1, address2, 'wread', 0, DATA_OUT_REG_OFFSET, 1);
	return 0;
}





