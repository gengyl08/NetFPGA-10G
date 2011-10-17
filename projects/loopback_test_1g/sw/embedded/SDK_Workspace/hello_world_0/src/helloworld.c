/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        helloworld.c
 *
 *  Project:
 *        loopback_test_1g
 *
 *  Author:
 *        James Hongyi Zeng
 *
 *  Description:
 *        Example C file to initialize AEL2005 to 1G mode through
 *        MDIO and dump PHY chip status
 *
 *        Currently SGMII is supported. The PHY type (1000BASE-T
 *        or 1000BASE-X) depends on the SFP module plugged in.
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

#include <stdio.h>
#include "platform.h"
#include "xwdttb.h"
#include "xemaclite.h"
#include "xemaclite_l.h"

#define EMAC_DEVICE_ID		XPAR_EMACLITE_0_DEVICE_ID
#define TIMER_DEVICE_ID     XPAR_WDTTB_0_DEVICE_ID
XEmacLite EmacLiteInstance;	/* Instance of the EmacLite */

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
        0x0000, 0xa040,
        0xc001, 0x0428,
        0xc017, 0xfeb0,
        0xc013, 0xf341,
        0xc210, 0x8000,
        0xc210, 0x8100,
        0xc210, 0x8000,
        0xc210, 0x0000
        };

const u16 regs0[] = {
        0xc220, 0x711C
        };

const u16 regs1[] = {
        0xc220, 0x744C
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

   // Hold AXI4-Stream Packet Generator/Checker
   Xil_Out32(XPAR_NF10_AXIS_GEN_CHECK_0_BASEADDR+0x3, 0x1);
   Xil_Out32(XPAR_NF10_AXIS_GEN_CHECK_1_BASEADDR+0x3, 0x1);

   char s;
   int dev;
   int value;
   goto INIT;

   while(1){
       print("==NetFPGA-10G==\r\n");
       print("i : Initialize AEL2005\r\n");
       print("s : Dump status\r\n");
       print("t : Run AXI4-Stream Gen/Check\r\n");
       print("r : Stop AXI4-Stream Gen/Check\r\n");
       s = inbyte();
       if(s == 'i')
INIT:      test_initialize(EmacLiteInstPtr);
       else if (s == 'r'){
           Xil_Out32(XPAR_NF10_AXIS_GEN_CHECK_0_BASEADDR+0x3, 0x1);
           Xil_Out32(XPAR_NF10_AXIS_GEN_CHECK_1_BASEADDR+0x3, 0x1);
           print("AXI4-Stream Gen/Check Stopped\r\n");
       }
       else if (s == 't'){
           Xil_Out32(XPAR_NF10_AXIS_GEN_CHECK_0_BASEADDR+0x3, 0x0);
           Xil_Out32(XPAR_NF10_AXIS_GEN_CHECK_1_BASEADDR+0x3, 0x0);
           print("AXI4-Stream Gen/Check Started\r\n");
       }
       else if (s == 's'){
           //test_status(EmacLiteInstPtr); //No PHY status in 1G mode
           value = Xil_In32(XPAR_NF10_AXIS_GEN_CHECK_0_BASEADDR+0x0);
		   xil_printf("AXI4-Stream Gen/Check 0\r\nTX\t0x%x\t", value);
		   value = Xil_In32(XPAR_NF10_AXIS_GEN_CHECK_0_BASEADDR+0x1);
		   xil_printf("RX\t0x%x\t", value);
		   value = Xil_In32(XPAR_NF10_AXIS_GEN_CHECK_0_BASEADDR+0x2);
		   xil_printf("ERR\t0x%x\r\n", value);
		   value = Xil_In32(XPAR_NF10_AXIS_GEN_CHECK_1_BASEADDR+0x0);
		   xil_printf("AXI4-Stream Gen/Check 1\r\nTX\t0x%x\t", value);
		   value = Xil_In32(XPAR_NF10_AXIS_GEN_CHECK_1_BASEADDR+0x1);
		   xil_printf("RX\t0x%x\t", value);
		   value = Xil_In32(XPAR_NF10_AXIS_GEN_CHECK_1_BASEADDR+0x2);
		   xil_printf("ERR\t0x%x\r\n", value);
       }
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
    ael2005_sleep(20);
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
            for( dev = 3; dev >= 0; dev--){
                 ael2005_write(InstancePtr, dev, 1, reset[i], reset[i+1]);
            }
        }
        ael2005_sleep(200);

        print("Step 2: Write magic registers\r\n");
        size = sizeof(regs0) / sizeof(u16);
        for(i = 0; i < size; i+=2){
        	for( dev = 2; dev >= 0; dev--){
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

/*int test_status(XEmacLite *InstancePtr){

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
					 //xil_printf("DEBUG: %x, %x, %x\r\n", pma_status, pcs_status, phy_xs_status);
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
}*/
