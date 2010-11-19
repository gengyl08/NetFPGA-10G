/* $Id: xemaclite_selftest_example.c,v 1.1.2.1 2010/07/12 08:34:25 svemula Exp $ */
/******************************************************************************
*
* (c) Copyright 2005-2009 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
******************************************************************************/
/****************************************************************************/
/**
*
* @file xemaclite_selftest_example.c
*
* This file contains a design example using the EmacLite driver.
*
* @note
*
* None.
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.00a ecm  01/25/05 Initial release for TestApp integration.
* 1.00a sv   06/06/05 Minor changes to comply to Doxygen and coding guidelines
* 2.00a ktn  04/14/09 Removed support for TestApp
*
******************************************************************************/
/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xemaclite.h"

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define EMAC_DEVICE_ID			XPAR_EMACLITE_0_DEVICE_ID

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

int EMACLiteSelfTestExample(u16 DeviceId);

/************************** Variable Definitions *****************************/

/*
 * Instance of the driver
 */
static XEmacLite EmacLite;

/****************************************************************************/
/**
*
* This function is the main function of the EmacLite selftest example.
*
* @param	None
*
* @return	XST_SUCCESS to indicate success, else XST_FAILURE.
*
* @note		None
*
*****************************************************************************/
int main(void)
{
	int Status;

	/*
	 * Run the EmacLite Self test example, specify the Device ID that is
	 * generated in xparameters.h
	 */
	Status = EMACLiteSelfTestExample(EMAC_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;

}

/*****************************************************************************/
/**
*
* The main entry point for the EmacLite driver selftest example.
*
* @param	DeviceId is the XPAR_<xemaclite_instance>_DEVICE_ID value from
*		xparameters.h
*
* @return	XST_SUCCESS to indicate success, else XST_FAILURE.
*
* @note		None.
*
******************************************************************************/
int EMACLiteSelfTestExample(u16 DeviceId)
{
	int Status;
	XEmacLite_Config *ConfigPtr;
	XEmacLite *InstancePtr = &EmacLite;

	/*
	 * Initialize the EmacLite device.
	 */
	ConfigPtr = XEmacLite_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		return XST_FAILURE;
	}
	Status = XEmacLite_CfgInitialize(InstancePtr,
					ConfigPtr,
					ConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Run the Self Test
	 */
	Status = XEmacLite_SelfTest(InstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}
