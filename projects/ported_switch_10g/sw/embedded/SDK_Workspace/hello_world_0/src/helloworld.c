/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        helloworld.c
 *
 *  Project:
 *        reference_nic
 *
 *  Author:
 *        James Hongyi Zeng
 *
 *  Description:
 *        Example C file to initialize AEL2005 in 10G mode through
 *        MDIO and dump PHY chip status.
 *
 *        Currently only 10GBASE-SR and Direct Attach are supported.
 *        This firmware will detect port mode according to SFF-8472.
 *        The default mode is Direct Attach.
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

////////////////////////////////////////////////////////////////////////
//Our experiment shows that the Direct Attach EDC also applies
//to 10GBASE-SR modules. To save the BRAM resource and minimize
//the program size, both 10GBASE-SR and Direct Attach use the
//same EDC code. If you have problems getting 10GBASE-SR running
//please enable 10GBASE-SR EDC by setting AEL2005_SR marco to 1.
////////////////////////////////////////////////////////////////////////
#define AEL2005_SR 0
#include "helloworld.h"

#define EMAC_DEVICE_ID		XPAR_EMACLITE_0_DEVICE_ID
#define TIMER_DEVICE_ID     XPAR_WDTTB_0_DEVICE_ID


XEmacLite EmacLiteInstance;	/* Instance of the EmacLite */

int main (void) {

   init_platform();
   XEmacLite *EmacLiteInstPtr = &EmacLiteInstance;
   XEmacLite_Config *ConfigPtr;

   ConfigPtr = XEmacLite_LookupConfig(EMAC_DEVICE_ID);
   XEmacLite_CfgInitialize(EmacLiteInstPtr, ConfigPtr, ConfigPtr->BaseAddress);

   char s;
   int port, dev;
   unsigned int value;

#if AEL2005_SR
   char port_mode_new[4] = {-1,-1,-1,-1};
   char port_mode[4] = {-1,-1,-1,-1};
#endif

   goto INIT;

   while(1){
       print("==NetFPGA-10G==\r\n");
       print("i : Initialize AEL2005\r\n");

       s = inbyte();
       if(s == 'i'){
INIT:      for(port = 0; port < 4; port ++){
               if(port == 0) dev = 2;
    		   if(port == 1) dev = 1;
    		   if(port == 2) dev = 0;
    		   if(port == 3) dev = 3;

    		   xil_printf("Port %d: ", port);
    		   ael2005_read (EmacLiteInstPtr, dev, 1, 0xa, &value);
    		   /*if(value == 0) {
    		       	print("No Signal.\r\n");
    		       	continue;
    		   }*/
    		   for(s = 20; s < 36; s++){
    		       	ael2005_i2c_read (EmacLiteInstPtr, dev, MODULE_DEV_ADDR, s, &value);
    		       	xil_printf("%c", value);
    		   }
    		   for(s = 40; s < 56; s++){
    		       	ael2005_i2c_read (EmacLiteInstPtr, dev, MODULE_DEV_ADDR, s, &value);
    		       	xil_printf("%c", value);
    		   }
    		   print("\r\n");

#if AEL2005_SR
    		   // Check if we have a 10GBASE-SR cable
    		   ael2005_i2c_read (EmacLiteInstPtr, dev, MODULE_DEV_ADDR, 0x3, &value);
    		   if((value >> 4) == 1) port_mode_new[port] = MODE_SR;
    		   else port_mode_new[port] = MODE_TWINAX;

    		   if(port_mode_new[port] != port_mode[port]){
    		       xil_printf("Port %d Detected new mode %x\r\n", port, port_mode_new[port]);
                   test_initialize(EmacLiteInstPtr, dev, port_mode_new[port]);
                   port_mode[port] = port_mode_new[port];
               }
#else
               test_initialize(EmacLiteInstPtr, dev, MODE_TWINAX);
#endif
           }
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
    ael2005_sleep(2);
    return XST_SUCCESS;
}

int ael2005_write (XEmacLite *EmacLiteInstPtr, u32 PhyAddr, u32 PhyDev, u16 address, u16 data){
    XEmacLite_PhyWrite(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_ADDRESS, XEL_MDIO_CLAUSE_45, address);
    XEmacLite_PhyWrite(EmacLiteInstPtr, PhyAddr, PhyDev, XEL_MDIO_OP_45_WRITE, XEL_MDIO_CLAUSE_45, data);
    ael2005_sleep(2);
    return XST_SUCCESS;
}

// The following functions are commented out to minimize executable size
int ael2005_i2c_write (XEmacLite *InstancePtr, u32 PhyAddress, u16 dev_addr, u16 word_addr, u16 data){
    u16 stat;
    int i;
    ael2005_write (InstancePtr, PhyAddress, 1, AEL_I2C_DATA, data);
    ael2005_write (InstancePtr, PhyAddress, 1, AEL_I2C_CTRL, (dev_addr << 8) | word_addr);
    for (i = 0; i < 20; i++){
        ael2005_sleep (2);
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
    for (i = 0; i < 20; i++){
        ael2005_sleep (2);
        ael2005_read  (InstancePtr, PhyAddress, 1, AEL_I2C_STAT, &stat);
        if ((stat & 3) == 1){
            ael2005_read  (InstancePtr, PhyAddress, 1, AEL_I2C_DATA, &stat);
            *data = stat >> 8;
			return XST_SUCCESS;
	    }
	}
	return XST_DEVICE_BUSY;
}

int ael2005_sleep (int ms){

    int result_0 = XWdtTb_ReadReg(XPAR_AXI_TIMEBASE_WDT_0_BASEADDR, XWT_TBR_OFFSET);
    int result_1 = result_0;
    while(result_1 - result_0 < ms * 50000) {
        result_1 = XWdtTb_ReadReg(XPAR_AXI_TIMEBASE_WDT_0_BASEADDR, XWT_TBR_OFFSET);
    }
    return XST_SUCCESS;
}

int ael2005_initialize(XEmacLite *InstancePtr, u32 dev, int mode){

        int size, i;

        print("AEL2005 Initialization Start..\r\n");
        // Step 1
        print("Step 1..\r\n");
        size = sizeof(regs0) / sizeof(u16);
        for(i = 0; i < size; i+=2) ael2005_write(InstancePtr, dev, 1, regs0[i], regs0[i+1]);
        ael2005_sleep(50);

        // Step 2
        print("Step 2..\r\n");
        #if AEL2005_SR
        if(mode == MODE_SR){
            size = sizeof(sr_edc) / sizeof(u16);
            for(i = 0; i < size; i+=2) ael2005_write(InstancePtr, dev, 1, sr_edc[i], sr_edc[i+1]);
        }
        else {
            size = sizeof(twinax_edc) / sizeof(u16);
            for(i = 0; i < size; i+=2) ael2005_write(InstancePtr, dev, 1, twinax_edc[i], twinax_edc[i+1]);
        }
        #else
        size = sizeof(twinax_edc) / sizeof(u16);
        for(i = 0; i < size; i+=2) ael2005_write(InstancePtr, dev, 1, twinax_edc[i], twinax_edc[i+1]);
        #endif

        // Step 3
        print("Step 3..\r\n");
        size = sizeof(regs1) / sizeof(u16);
        for(i = 0; i < size; i+=2) ael2005_write(InstancePtr, dev, 1, regs1[i], regs1[i+1]);
        ael2005_sleep(50);
        return XST_SUCCESS;
}

int test_initialize(XEmacLite *InstancePtr, u32 PhyAddress, int mode){
        ael2005_sleep(100);
        ael2005_initialize(InstancePtr, PhyAddress, mode);
        ael2005_sleep(200);
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
}
