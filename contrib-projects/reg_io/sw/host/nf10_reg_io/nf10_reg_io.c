/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_reg_io.c
 *
 *  Library:
 *        stdio.h, stdlib.h, string.h ctype.h
 *
 *  Project:
 *        reg_io
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        For the Register IO Project
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

#include "reg_lib.h"
#include "nf10_reg_io_lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>

int main (int argc, char **argv)
{
	int dev = -1;

	// Open device handle
	dev = open("/dev/nf10", O_RDWR);
    	if(dev < 0){
       		perror("/dev/nf10");
       		return 0;
    	}

	run(dev);

	// Close device handle
	close(dev);

	return 0;
}
