/* NetFPGA-10G http://www.netfpga.org
 * 
 * NetFPGA-10G Generic Netlink Definitions
 *
 * Description: 
 *  Set of generic netlink definitions that are specific to NetFPGA-10G.
 *  These definitions are used in setting up generic netlink connections
 *  between userspace software and the linux kernel driver.
 *
 * Revision history: 
 *  2011/07/06 Jonathan Ellithorpe: Created.
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
