/* NetFPGA-10G http://www.netfpga.org
 * 
 * NetFPGA-10G Reference NIC Ethernet Driver Header File
 *
 * Description:
 *  Set of definitions for the NF10 reference NIC driver.
 * 
 * Revision history:
 *  2011/07/07 Jonathan Ellithorpe: Created.
 */

#ifndef NF10_ETH_DRIVER_H
#define NF10_ETH_DRIVER_H

/* Useful debug print macro. Turned on/off with DRIVER_DEBUG macro fed to gcc. */
#undef PDEBUG
#ifdef DRIVER_DEBUG
#    ifdef __KERNEL__
#        define PDEBUG(fmt, args...) printk(KERN_DEBUG "nf10_eth_driver: DEBUG: " fmt, ## args)
#    else
#        define PDEBUG(fmt, args...) fprintf(stderr, fmt, ## args)
#    endif
#else
#    define PDEBUG(fmt, args...)
#endif

/* PCI device IDs for the NetFPGA-10G platform and related designs. */
#define PCI_VENDOR_ID_NF10          0x10ee    /* Vendor ID used for all NetFPGA-10G designs. */
#define PCI_DEVICE_ID_NF10_REF_NIC  0x4243    /* Device ID used for the NetFPGA-10G reference NIC design. */

#define BAR_0    0

/* Interfaces Bitmasks. */
#define OPCODE_CPU0     0x00000002
#define OPCODE_CPU1     0x00000008
#define OPCODE_CPU2     0x00000020
#define OPCODE_CPU3     0x00000080
#define OPCODE_CPU_ALL  0x000000AA

#define OPCODE_MAC0     0x00000001
#define OPCODE_MAC1     0x00000004
#define OPCODE_MAC2     0x00000010
#define OPCODE_MAC3     0x00000040
#define OPCODE_MAC_ALL  0x00000055

/* Hardware state flags. */
#define HW_FOUND        0x00000001
#define HW_INIT         0x00000002

#endif /* NF10_ETH_DRIVER_H */
