/*****************************************************************************
* Filename:          /hpn/home/hyzeng/sandbox/selftest/xps/drivers/xaui_status_v1_00_a/src/xaui_status.h
* Version:           1.00.a
* Description:       xaui_status Driver Header File
* Date:              Sun Sep 19 15:37:39 2010 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef XAUI_STATUS_H
#define XAUI_STATUS_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 * -- SLV_REG8 : user logic slave module register 8
 * -- SLV_REG9 : user logic slave module register 9
 * -- SLV_REG10 : user logic slave module register 10
 * -- SLV_REG11 : user logic slave module register 11
 * -- SLV_REG12 : user logic slave module register 12
 * -- SLV_REG13 : user logic slave module register 13
 */
#define XAUI_STATUS_USER_SLV_SPACE_OFFSET (0x00000000)
#define XAUI_STATUS_SLV_REG0_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000000)
#define XAUI_STATUS_SLV_REG1_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000004)
#define XAUI_STATUS_SLV_REG2_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000008)
#define XAUI_STATUS_SLV_REG3_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define XAUI_STATUS_SLV_REG4_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000010)
#define XAUI_STATUS_SLV_REG5_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000014)
#define XAUI_STATUS_SLV_REG6_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000018)
#define XAUI_STATUS_SLV_REG7_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define XAUI_STATUS_SLV_REG8_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000020)
#define XAUI_STATUS_SLV_REG9_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000024)
#define XAUI_STATUS_SLV_REG10_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000028)
#define XAUI_STATUS_SLV_REG11_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x0000002C)
#define XAUI_STATUS_SLV_REG12_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000030)
#define XAUI_STATUS_SLV_REG13_OFFSET (XAUI_STATUS_USER_SLV_SPACE_OFFSET + 0x00000034)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a XAUI_STATUS register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the XAUI_STATUS device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void XAUI_STATUS_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define XAUI_STATUS_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a XAUI_STATUS register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the XAUI_STATUS device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 XAUI_STATUS_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define XAUI_STATUS_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from XAUI_STATUS user logic slave registers.
 *
 * @param   BaseAddress is the base address of the XAUI_STATUS device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void XAUI_STATUS_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 XAUI_STATUS_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define XAUI_STATUS_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg8(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG8_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg9(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG9_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg10(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG10_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg11(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG11_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg12(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG12_OFFSET) + (RegOffset), (Xuint32)(Value))
#define XAUI_STATUS_mWriteSlaveReg13(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (XAUI_STATUS_SLV_REG13_OFFSET) + (RegOffset), (Xuint32)(Value))

#define XAUI_STATUS_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG0_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG1_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG2_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG3_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg4(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG4_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg5(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG5_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg6(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG6_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg7(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG7_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg8(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG8_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg9(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG9_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg10(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG10_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg11(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG11_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg12(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG12_OFFSET) + (RegOffset))
#define XAUI_STATUS_mReadSlaveReg13(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (XAUI_STATUS_SLV_REG13_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the XAUI_STATUS instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus XAUI_STATUS_SelfTest(u32 baseaddr_p);

#endif /** XAUI_STATUS_H */
