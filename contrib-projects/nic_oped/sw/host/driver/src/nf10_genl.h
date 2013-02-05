/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_genl.h
 *
 *  Project:
 *        reference_nic
 *
 *  Author:
 *        Jonathan Ellithorpe
 *
 *  Description:
 *        Set of generic netlink definitions that are specific to NetFPGA-10G.
 *        These definitions are used in setting up generic netlink connections
 *        between userspace software and the linux kernel driver.
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
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

#ifndef NF10_GENL_H
#define NF10_GENL_H

/* NF10's Generic Netlink family settings. */
#define NF10_GENL_FAMILY_NAME           "NF10_ETH_DRIVER"
#define NF10_GENL_FAMILY_VERSION        1

/* Attributes that can be attached to our netlink messages. */
enum {
    NF10_GENL_A_UNSPEC,
    NF10_GENL_A_MSG,
    NF10_GENL_A_DMA_BUF,
    NF10_GENL_A_ADDR32,
    NF10_GENL_A_REGVAL32,
    NF10_GENL_A_OPCODE,
    NF10_GENL_A_ERRNO,

    __NF10_GENL_A_MAX,
};

#define NF10_GENL_A_MAX (__NF10_GENL_A_MAX - 1)

/* Commands defined for our generic netlink interface. */
enum {
    NF10_GENL_C_UNSPEC,
    NF10_GENL_C_ECHO,
    NF10_GENL_C_DMA_TX,
    NF10_GENL_C_DMA_RX,
    NF10_GENL_C_REG_RD,
    NF10_GENL_C_REG_WR,
    NF10_GENL_C_NAPI_ENABLE,
    NF10_GENL_C_NAPI_DISABLE,

    __NF10_GENL_C_MAX,
};

#define NF10_GENL_C_MAX (__NF10_GENL_C_MAX - 1)

#endif /* NF10_GENL_H */
