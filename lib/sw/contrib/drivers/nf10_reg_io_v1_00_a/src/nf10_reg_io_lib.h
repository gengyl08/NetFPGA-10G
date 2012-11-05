/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_reg_io_lib.h
 *
 *  Project:
 *        Register IO Library
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        For the Register IO Project.
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

#ifndef _NF10_REG_IO_LIB_H_
#define _NF10_REG_IO_LIB_H_

#include "xparameters.h"

enum {
	BAR0_BASE_ADDRESS = XPAR_NF10_REG_IO_0_BAR0_BASEADDR,
	BAR1_BASE_ADDRESS = XPAR_NF10_REG_IO_0_BAR1_BASEADDR,
};

enum {
	WO_REG0 = 0x00,
	WO_REG1 = 0x04,
	RW_REG0 = 0x08,
	RW_REG1 = 0x0C,
	RO_REG0 = 0x10, // Mapped to RW_REG0 
	RO_REG1 = 0x14, // Mapped to RW_REG1
	RO_REG2 = 0x18, // Mapped to WO_REG0
	RO_REG3 = 0x1C, // Mapped to WO_REG1
};

enum {
	TBL_COL0    = 0x00,
	TBL_COL1    = 0x04,
	TBL_COL2    = 0x08,
	TBL_COL3    = 0x0C,
	TBL_WR_ADDR = 0x10,
	TBL_RD_ADDR = 0x14,
};

/*************************************************************
  Function prototypes
 *************************************************************/
void run(int dev);

#endif
