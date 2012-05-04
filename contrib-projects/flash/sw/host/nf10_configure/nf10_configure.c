/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_configure.c
 *
 *  Library:
 *        stdio.h, stdlib.h, string.h ctype.h
 *
 *  Project:
 *        flash_configuration
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        For the Flash Controller Project / FPGA configuration.
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
                        int dev = nf10_dev_open();
			nf10_reg_wr(dev, CFG_BASE_ADDR, 0x0);
			//printf ("%x", nf10_reg_rd(dev, CFG_BASE_ADDR));
			printf ("FPGA re-initialized with flash 'b' image.\r\n");
                        close(dev);
		}

	       	for (index = optind; index < argc; index++)
			printf ("Non-option argument %s\n", argv[index]);
	}
	else
	{
		printf("\
Usage: nf10_configure -b image... -f <FLASH>\r\n\
   or: nf10_configure -b image... -f b -i\r\n\
   or: nf10_configure -i\r\n\
Write image into the target FLASH and re-initialize the FPGA.\r\n\
\r\n\
Arguments:\r\n\
-b		Specify flash image (*.bin)\r\n\
-f		Target flash (a or b)\r\n\
-i		Re-initialize FPGA from flash b\r\n\
");
	}

	return 0;
}
