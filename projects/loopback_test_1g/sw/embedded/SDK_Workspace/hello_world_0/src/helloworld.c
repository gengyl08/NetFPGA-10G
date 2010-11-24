/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * Xilinx EDK 11.3 EDK_LS3.57
 *
 * This file is a sample test application
 *
 * This application is intended to test and/or illustrate some
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * XPS project when you run the "Generate Libraries" menu item
 * in XPS.
 *
 * Your XPS project directory is at:
 *    /home/phartke/slink/group/xupv5-lx110t/bsb_mdio_ethernetlist/
 */


// Removes the printfs for simulation
// #define SIM 1
#include <stdio.h>
#include "platform.h"
// Located in: microblaze_0/include/xparameters.h
//#include "xparameters.h"
//#include "xutil.h"

#include "xwdttb.h"

#include "xemaclite.h"
#include "xemaclite_l.h"

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define EMAC_DEVICE_ID		XPAR_EMACLITE_0_DEVICE_ID
#define TIMER_DEVICE_ID     XPAR_WDTTB_0_DEVICE_ID
XEmacLite EmacLiteInstance;	/* Instance of the EmacLite */

//====================================================
// Added by James Hongyi Zeng
//====================================================
enum {
	AEL_I2C_CTRL        = 0xc30a,
	AEL_I2C_DATA        = 0xc30b,
	AEL_I2C_STAT        = 0xc30c
};

/* PHY module I2C device address */
enum {
	MODULE_DEV_ADDR	= 0xa0,
	SFF_DEV_ADDR	= 0xa2,
};

    // software reset and magic registers
const u16 reset[] = {
        0x0000, 0x8000,
        };

const u16 regs0[] = {
		0xc01f, 0x0040,
        0xc220, 0x711c
        };

const u16 regs1[] = {
		0xc01f, 0x0040,
        0xc220, 0x744c
        };

int ael2005_read (XEmacLite *InstancePtr, u32 PhyAddress, u32 PhyDev, u16 address, u16 *data);
int ael2005_write(XEmacLite *InstancePtr, u32 PhyAddress, u32 PhyDev, u16 address, u16 data);
// The following functions are commented out to minimize executable size
//int ael2005_i2c_write(XEmacLite *InstancePtr, u32 PhyAddress, u16 dev_addr, u16 word_addr, u16 data);
//int ael2005_i2c_read (XEmacLite *InstancePtr, u32 PhyAddress, u16 dev_addr, u16 word_addr, u16 *data);
int ael2005_sleep(int ms);

int ael2005_initialize(XEmacLite *InstancePtr);
int test_initialize(XEmacLite *InstancePtr);
int test_status(XEmacLite *InstancePtr);

int main (void) {

   init_platform();
   XEmacLite *EmacLiteInstPtr = &EmacLiteInstance;
   XEmacLite_Config *ConfigPtr;

   ConfigPtr = XEmacLite_LookupConfig(EMAC_DEVICE_ID);
   XEmacLite_CfgInitialize(EmacLiteInstPtr, ConfigPtr, ConfigPtr->BaseAddress);
   // Run it at least once

   char s;
   int dev;
   u16 value;

   while(1){
       print("===NetFPGA-10G Test===\r\n");
       print("Press i to initialize, s to start\r\n");
       for( dev = 0; dev < 4; dev++){
            ael2005_read(EmacLiteInstPtr, dev, 1, 0xc220, &value);
            xil_printf("C220 Port %d: %x\r\n", dev, value);
            ael2005_read(EmacLiteInstPtr, dev, 1, 0xc01f, &value);
            xil_printf("C01F Port %d: %x\r\n", dev, value);
       }

       s = inbyte();
       if(s == 'i')
           test_initialize(EmacLiteInstPtr);
       else if (s == 's')
           test_status(EmacLiteInstPtr);
       else
           continue;
   }

   cleanup_platform();
   return 0;
}

int ael2005_read (XEmacLite *EmacLiteInstPtr, u32 PhyAddr, u32 PhyDev, u16 address, u16 *data){
    XEmacLite_PhyWrite(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_ADDRESS, XEL_MDIO_CLAUSE_45, address);
    XEmacLite_PhyRead(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_READ, XEL_MDIO_CLAUSE_45, data);
    ael2005_sleep(20);

	 XEmacLite_PhyWrite(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_ADDRESS, XEL_MDIO_CLAUSE_45, address);
    XEmacLite_PhyRead(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_READ, XEL_MDIO_CLAUSE_45, data);
    ael2005_sleep(20);
    return XST_SUCCESS;
}

int ael2005_write (XEmacLite *EmacLiteInstPtr, u32 PhyAddr, u32 PhyDev, u16 address, u16 data){
    XEmacLite_PhyWrite(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_ADDRESS, XEL_MDIO_CLAUSE_45, address);
    XEmacLite_PhyWrite(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_WRITE, XEL_MDIO_CLAUSE_45, data);
    xil_printf("Port: %d, Addr: %x, Data: %x\r\n", PhyAddr, address, data);
    ael2005_sleep(2);
    return XST_SUCCESS;
}

// The following functions are commented out to minimize executable size
/*int ael2005_i2c_write (XEmacLite *InstancePtr, u32 PhyAddress, u16 dev_addr, u16 word_addr, u16 data){
    u16 stat;
    int i;
    ael2005_write (InstancePtr, PhyAddress, 1, AEL_I2C_DATA, data);
    ael2005_write (InstancePtr, PhyAddress, 1, AEL_I2C_CTRL, (dev_addr << 8) | word_addr);
    for (i < 0; i < 200; i++){
        ael2005_sleep (10);
        ael2005_read  (InstancePtr, PhyAddress, 1, AEL_I2C_STAT, &stat);
        if ((stat & 3) == 1)
			return XST_SUCCESS;
	}
	return XST_DEVICE_BUSY;
}

int ael2005_i2c_read (XEmacLite *InstancePtr, u32 PhyAddress, u16 dev_addr, u16 word_addr, u16 *data){
    u16 stat;
    int i;
    ael2005_write (InstancePtr, PhyAddress, 1, AEL_I2C_CTRL, (dev_addr << 8) | (1 << 8) | word_addr);
    for (i < 0; i < 200; i++){
        ael2005_sleep (10);
        ael2005_read  (InstancePtr, PhyAddress, 1, AEL_I2C_STAT, &stat);
        if ((stat & 3) == 1){
            ael2005_read  (InstancePtr, PhyAddress, 1, AEL_I2C_DATA, &stat);
            *data = stat >> 8;
			return XST_SUCCESS;
	    }
	}
	return XST_DEVICE_BUSY;
}*/


int ael2005_sleep (int ms){

    int result_0 = XWdtTb_ReadReg(XPAR_AXI_TIMEBASE_WDT_0_BASEADDR, XWT_TBR_OFFSET);
    int result_1 = result_0;
    while(result_1 - result_0 < ms * 50000) {
        result_1 = XWdtTb_ReadReg(XPAR_AXI_TIMEBASE_WDT_0_BASEADDR, XWT_TBR_OFFSET);
    }
    return XST_SUCCESS;
}

int ael2005_initialize(XEmacLite *InstancePtr){

        int size, i, dev = 0;
        print("AEL2005 Initialization Start..\r\n");
        print("Step 1: Reset\r\n");
        size = sizeof(reset) / sizeof(u16);
        for(i = 0; i < size; i+=2){
            for( dev = 0; dev < 4; dev++){
                 ael2005_write(InstancePtr, dev, 1, reset[i], reset[i+1]);
            }
        }
        ael2005_sleep(200);

        print("Step 2: Write magic registers\r\n");
        size = sizeof(regs0) / sizeof(u16);
        for(i = 0; i < size; i+=2){
            for( dev = 0; dev < 3; dev++){
                ael2005_write(InstancePtr, dev, 1, regs0[i], regs0[i+1]);
            }
        }

        size = sizeof(regs1) / sizeof(u16);
        dev = 3;
        for(i = 0; i < size; i+=2){
             ael2005_write(InstancePtr, dev, 1, regs1[i], regs1[i+1]);
        }
        ael2005_sleep(50);

        return XST_SUCCESS;
}

int test_initialize(XEmacLite *InstancePtr){

        ael2005_sleep(1000);
        ael2005_initialize(InstancePtr);
        ael2005_sleep(2000);
        return XST_SUCCESS;
}

int test_status(XEmacLite *InstancePtr){

		  int i, dev;

        u16 pma_status, pcs_status, phy_xs_status;

		  for( i = 0; i < 4; i++){
		          switch(i){  // PHY0-3 -> C, B, A, D
                    case 0:
						      dev = 2;
								break;
					     case 1:
						      dev = 1;
								break;
						  case 2:
						      dev = 0;
								break;
						  case 3:
						      dev = 3;
								break;
						  default:;
					 }
					 ael2005_read(InstancePtr, dev, 1, 0x1, &pma_status);
					 ael2005_read(InstancePtr, dev, 3, 0x1, &pcs_status);
					 ael2005_read(InstancePtr, dev, 4, 0x1, &phy_xs_status);
					 xil_printf("DEBUG: %x, %x, %x\r\n", pma_status, pcs_status, phy_xs_status);
					 if(((pma_status>>2) & 0x1) &
					    ((pcs_status>>2) & 0x1) &
						 ((phy_xs_status>>2) & 0x1)){
						    xil_printf("PHY %d OK\r\n", i);
				    }
				    else {
					     xil_printf("PHY %d error: link down\r\n", i);
				    }

        }
        return XST_SUCCESS;
}
