////////////////////////////////////////////////////////////////////////
//
//  NETFPGA-10G www.netfpga.org
//
//  Module:
//          nf10_configure.c
//
//  Description:
//          For the Flash Controller Project / FPGA configuration.
//                 
//  Revision history:
//          28/9/2011 shahbaz    Initial revision
//
//  Known issues:
//
//  Library: stdio.h, stdlib.h, string.h ctype.h
//
////////////////////////////////////////////////////////////////////////


#include <netlink/netlink.h>
#include "nf10_reg_lib.h"
#include "nf10_flash_lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>


int main (int argc, char **argv)
{
	char *bit_file = NULL;
	char *flash_id = NULL;
	int init_fpga = 0;
	int c;     	
	int index;

	opterr = 0;
	
	if (argc > 1)
	{
		while ((c = getopt (argc, argv, "b:f:i")) != -1)
		{
			switch (c)
		   	{
		   	case 'b':
		     		bit_file = optarg;
		     	break;
		   	case 'f':
		     		flash_id = optarg;
		     	break;
		   	case 'i':
		     		init_fpga = 1;
		     	break;
		   	case '?':
		     		if (optopt == 'b' || optopt == 'f')
		       			fprintf (stderr, "Option -%c requires an argument.\n", optopt);
		     		else if (isprint (optopt))
		       			fprintf (stderr, "Unknown option `-%c'.\n", optopt);
		     		else
		       			fprintf (stderr, "Unknown option character `\\x%x'.\n", optopt);
		     		return 1;
		   	default:
		     		abort ();
		   	}
		}

		//printf("bit_file=%s, flash_id=%s, init_fpga=%x\r\n", bit_file, flash_id, init_fpga);
	     
	 	// Writing into flash
		if (bit_file != NULL)
		{
			if (flash_id != NULL)
				Flash_Prog(bit_file, *flash_id);
			else
				fprintf (stderr, "Target flash not specified.\nUse -f <flash id> option e.g. -f b.\r\n", optopt);
		}
		
		// Reconfig FPGA from flash B (active low)
		if (init_fpga == 1)
		{
			nf10_reg_wr(CFG_BASE_ADDR, 0x0);
			printf ("FPGA re-initialized with flash 'b' bitstream.\r\n");
		}
	     
	       	for (index = optind; index < argc; index++)
			printf ("Non-option argument %s\n", argv[index]);
	}
	else
	{
		printf("\
Usage: nf10_configure -b BIT_FILE... -f <FLASH>\r\n\
   or: nf10_configure -b BIT_FILE... -f b -i\r\n\
   or: nf10_configure -i\r\n\
Write BIT_FILE into the target FLASH and re-initialize the FPGA.\r\n\
\r\n\
Arguments:\r\n\
-b		Specify bit file (*.bin)\r\n\
-f		Target flash (a or b)\r\n\
-i		Flag to re-initialize the FPGA from flash b\r\n\
");
	}
      	
	return 0;
}
