/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_reg_io_lib.c
 *
 *  Project:
 *        reg_io
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

#include "reg_lib.h"
#include "nf10_reg_io_lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*************************************************************
  Function body
 *************************************************************/

void run(int dev)
{
	printf("--- Registers Test ---\r\n\n");
	reg_wr(dev, BAR0_BASE_ADDRESS + WO_REG0, 0xdeed0001);
	printf("Write WO_REG0 \t (%x)\r\n", 0xdeed0001);
	reg_wr(dev, BAR0_BASE_ADDRESS + WO_REG1, 0xdeed0002);
	printf("Write WO_REG1 \t (%x)\r\n\n", 0xdeed0002);
	reg_wr(dev, BAR0_BASE_ADDRESS + RW_REG0, 0xdeed1003);
	printf("Write RW_REG0 \t (%x)\r\n", 0xdeed1003);
	reg_wr(dev, BAR0_BASE_ADDRESS + RW_REG1, 0xdeed1004);
	printf("Write RW_REG1 \t (%x)\r\n\n", 0xdeed1004);

	printf("Read WO_REG0 \t (%x) == 0\r\n", reg_rd(dev, BAR0_BASE_ADDRESS + WO_REG0));
	printf("Read WO_REG1 \t (%x) == 0\r\n\n", reg_rd(dev, BAR0_BASE_ADDRESS + WO_REG1));
	
	printf("Read RW_REG0 \t (%x)\r\n", reg_rd(dev, BAR0_BASE_ADDRESS + RW_REG0));
	printf("Read RW_REG1 \t (%x)\r\n\n", reg_rd(dev, BAR0_BASE_ADDRESS + RW_REG1));

	printf("Read RO_REG0 \t (%x) == RW_REG0 \t (%x)\r\n", reg_rd(dev, BAR0_BASE_ADDRESS + RO_REG0), reg_rd(dev, BAR0_BASE_ADDRESS + RW_REG0));
	printf("Read RO_REG1 \t (%x) == RW_REG1 \t (%x)\r\n", reg_rd(dev, BAR0_BASE_ADDRESS + RO_REG1), reg_rd(dev, BAR0_BASE_ADDRESS + RW_REG1));
	printf("Read RO_REG2 \t (%x) == W0_REG0 \t (0xdeed0001)\r\n", reg_rd(dev, BAR0_BASE_ADDRESS + RO_REG2));
	printf("Read RO_REG3 \t (%x) == W0_REG1 \t (0xdeed0002)\r\n\n", reg_rd(dev, BAR0_BASE_ADDRESS + RO_REG3));

	printf("\n\r");

	printf("--- Table Test ---\r\n");
        // Write Row 0
        printf("------ Row 0 ---\r\n");
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL0, 0xfeed0001);
	printf("Write TBL_COL0 \t (%x)\r\n", 0xfeed0001);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL1, 0xfeed0002);
	printf("Write TBL_COL1 \t (%x)\r\n", 0xfeed0002);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL2, 0xfeed0003);
	printf("Write TBL_COL2 \t (%x)\r\n", 0xfeed0003);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL3, 0xfeed0004);
	printf("Write TBL_COL3 \t (%x)\r\n", 0xfeed0004);
        reg_wr(dev, BAR1_BASE_ADDRESS + TBL_WR_ADDR, 0);
	printf("Write TBL_WR_ADDR (%x)\r\n\n", 0);

	// Read Row 0
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_RD_ADDR, 0);
	printf("Write TBL_RD_ADDR (%x)\r\n", 0);
	printf("Read TBL_COL0 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL0));
	printf("Read TBL_COL1 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL1));
	printf("Read TBL_COL2 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL2));
	printf("Read TBL_COL3 \t (%x)\r\n\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL3));

	// Write Row 1
        printf("------ Row 1 ---\r\n");
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL0, 0xfeed1111);
	printf("Write TBL_COL0 \t (%x)\r\n", 0xfeed1111);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL1, 0xfeed1112);
	printf("Write TBL_COL1 \t (%x)\r\n", 0xfeed1112);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL2, 0xfeed1113);
	printf("Write TBL_COL2 \t (%x)\r\n", 0xfeed1113);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL3, 0xfeed1114);
	printf("Write TBL_COL3 \t (%x)\r\n", 0xfeed1114);
        reg_wr(dev, BAR1_BASE_ADDRESS + TBL_WR_ADDR, 1);
	printf("Write TBL_WR_ADDR (%x)\r\n\n", 1);

	// Read Row 1
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_RD_ADDR, 1);
	printf("Write TBL_RD_ADDR (%x)\r\n", 1);
	printf("Read TBL_COL0 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL0));
	printf("Read TBL_COL1 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL1));
	printf("Read TBL_COL2 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL2));
	printf("Read TBL_COL3 \t (%x)\r\n\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL3));

	// Write Row 2
        printf("------ Row 2 ---\r\n");
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL0, 0xfeed2221);
	printf("Write TBL_COL0 \t (%x)\r\n", 0xfeed2221);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL1, 0xfeed2222);
	printf("Write TBL_COL1 \t (%x)\r\n", 0xfeed2222);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL2, 0xfeed2223);
	printf("Write TBL_COL2 \t (%x)\r\n", 0xfeed2223);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL3, 0xfeed2224);
	printf("Write TBL_COL3 \t (%x)\r\n", 0xfeed2224);
        reg_wr(dev, BAR1_BASE_ADDRESS + TBL_WR_ADDR, 2);
	printf("Write TBL_WR_ADDR (%x)\r\n\n", 2);

	// Read Row 2
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_RD_ADDR, 2);
	printf("Write TBL_RD_ADDR (%x)\r\n", 2);
	printf("Read TBL_COL0 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL0));
	printf("Read TBL_COL1 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL1));
	printf("Read TBL_COL2 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL2));
	printf("Read TBL_COL3 \t (%x)\r\n\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL3));

	// Write Row 3
        printf("------ Row 3 ---\r\n");
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL0, 0xfeed3331);
	printf("Write TBL_COL0 \t (%x)\r\n", 0xfeed3331);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL1, 0xfeed3332);
	printf("Write TBL_COL1 \t (%x)\r\n", 0xfeed3332);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL2, 0xfeed3333);
	printf("Write TBL_COL2 \t (%x)\r\n", 0xfeed3333);
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_COL3, 0xfeed3334);
	printf("Write TBL_COL3 \t (%x)\r\n", 0xfeed3334);
        reg_wr(dev, BAR1_BASE_ADDRESS + TBL_WR_ADDR, 3);
	printf("Write TBL_WR_ADDR (%x)\r\n\n", 3);

	// Read Row 3
	reg_wr(dev, BAR1_BASE_ADDRESS + TBL_RD_ADDR, 3);
	printf("Write TBL_RD_ADDR (%x)\r\n", 3);
	printf("Read TBL_COL0 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL0));
	printf("Read TBL_COL1 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL1));
	printf("Read TBL_COL2 \t (%x)\r\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL2));
	printf("Read TBL_COL3 \t (%x)\r\n\n", reg_rd(dev, BAR1_BASE_ADDRESS + TBL_COL3));
}

