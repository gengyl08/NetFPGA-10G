/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        reg_lib.c
 *
 *  Project:
 *        flash_configuration
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        Set of definitions for the NF10 register access library.
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
#include "nf10_reg_lib.h"
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <netlink/netlink.h>

inline uint32_t reg_rd(int dev, uint64_t addr)
{
    uint32_t val;  
    int err = nf10_reg_rd(addr, &val);
    
    if(err)
    {
       printf("ERROR: %s\n", nl_geterror(err));
       abort();
    } 

    return val;
}

inline int reg_wr(int dev, uint64_t addr, uint32_t val)
{
    int err = nf10_reg_wr(addr, val);
    
    if(err)
    {
       printf("ERROR: %s\n", nl_geterror(err));
       abort();
    }

    return 0; 
}
