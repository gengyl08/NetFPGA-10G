//*****************************************************************************
// DISCLAIMER OF LIABILITY
//
// This file contains proprietary and confidential information of
// Xilinx, Inc. ("Xilinx"), that is distributed under a license
// from Xilinx, and may be used, copied and/or disclosed only
// pursuant to the terms of a valid license agreement with Xilinx.
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
// LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
// MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
// does not warrant that functions included in the Materials will
// meet the requirements of Licensee, or that the operation of the
// Materials will be uninterrupted or error-free, or that defects
// in the Materials will be corrected. Furthermore, Xilinx does
// not warrant or make any representations regarding use, or the
// results of the use, of the Materials in terms of correctness,
// accuracy, reliability or otherwise.
//
// Xilinx products are not designed or intended to be fail-safe,
// or for use in any application requiring fail-safe performance,
// such as life-support or safety devices or systems, Class III
// medical devices, nuclear facilities, applications related to
// the deployment of airbags, or any other applications that could
// lead to death, personal injury or severe property or
// environmental damage (individually and collectively, "critical
// applications"). Customer assumes the sole risk and liability
// of any use of Xilinx products in critical applications,
// subject only to applicable laws and regulations governing
// limitations on product liability.
//
// Copyright 2007, 2008 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor             : Xilinx
// \   \   \/    Version            : 3.6.1
//  \   \        Application        : MIG
//  /   /        Filename           : controller.veo
// /___/   /\    Date Last Modified : $Date: 2010/11/26 18:26:31 $
// \   \  /  \   Date Created       : Wed May 2 2007
//  \___\/\___\
//
// Purpose     : Template file containing code that can be used as a model
//               for instantiating a CORE Generator module in a HDL design.
// Revision History:
//*****************************************************************************

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

 controller # (
    .C0_QDRII_ADDR_WIDTH(19),   
                                     // # of memory component address bits.
    .C0_QDRII_BURST_LENGTH(4),   
                                     // # = 2 -> Burst Length 2 memory part,
                                     // # = 4 -> Burst Length 4 memory part.
    .C0_QDRII_BW_WIDTH(4),   
                                     // # of Byte Write Control bits.
    .F0_QDRII_DLL_FREQ_MODE("HIGH"),   
                                     // DCM's DLL Frequency mode.
    .F0_QDRII_CLK_PERIOD(5000),   
                                     // Core\Memory clock period (in ps).
    .CLK_TYPE("DIFFERENTIAL"),   
                                     // # = "DIFFERENTIAL " -> Differential input clocks,
                                     // # = "SINGLE_ENDED" -> Single ended input clocks.
    .C0_QDRII_CLK_WIDTH(1),   
                                     // # of memory clock outputs. Represents
                                     // the number of K, K_n, C, and C_n clocks.
    .C0_QDRII_CQ_WIDTH(1),   
                                     // # of CQ bits.
    .C0_QDRII_DATA_WIDTH(36),   
                                     // Design Data Width.
    .C0_QDRII_DEBUG_EN(0),   
                                     // Enable debug signals/controls. When this
                                     // parameter is changed from 0 to 1, make
                                     // sure to uncomment the coregen commands
                                     // in ise_flow.bat or create_ise.bat files
                                     // in par folder.
    .C0_QDRII_HIGH_PERFORMANCE_MODE("TRUE"),   
                                     // # = "TRUE", the IODELAY performance mode
                                     // is set to high.
                                     // # = "FALSE", the IODELAY performance mode
                                     // is set to low.
    .MASTERBANK_PIN_WIDTH(2),   
                                     // # of dummy inuput pins for the Master
                                     // Banks. This dummy input pin will appear
                                     // in the Master bank only when it does not
                                     // have alteast one input\inout pins with
                                     // the IO_STANDARD same as the slave banks.
    .C0_QDRII_MEMORY_WIDTH(36),   
                                     // # of memory part's data width.
    .F0_QDRII_NOCLK200(0),   
                                     // clk200 enable and disable.
    .RST_ACT_LOW(1),   
                                     // # = 1 for active low reset,
                                     // # = 0 for active high.
    .C0_QDRII_SIM_ONLY(0),   
                                     // # = 1 to skip SRAM power up delay.
    .C1_QDRII_ADDR_WIDTH(19),   
                                     // # of memory component address bits.
    .C1_QDRII_BURST_LENGTH(4),   
                                     // # = 2 -> Burst Length 2 memory part,
                                     // # = 4 -> Burst Length 4 memory part.
    .C1_QDRII_BW_WIDTH(4),   
                                     // # of Byte Write Control bits.
    .C1_QDRII_CLK_WIDTH(1),   
                                     // # of memory clock outputs. Represents
                                     // the number of K, K_n, C, and C_n clocks.
    .C1_QDRII_CQ_WIDTH(1),   
                                     // # of CQ bits.
    .C1_QDRII_DATA_WIDTH(36),   
                                     // Design Data Width.
    .C1_QDRII_DEBUG_EN(0),   
                                     // Enable debug signals/controls. When this
                                     // parameter is changed from 0 to 1, make
                                     // sure to uncomment the coregen commands
                                     // in ise_flow.bat or create_ise.bat files
                                     // in par folder.
    .C1_QDRII_HIGH_PERFORMANCE_MODE("TRUE"),   
                                     // # = "TRUE", the IODELAY performance mode
                                     // is set to high.
                                     // # = "FALSE", the IODELAY performance mode
                                     // is set to low.
    .MASTERBANK_PIN_WIDTH(2),   
                                     // # of dummy inuput pins for the Master
                                     // Banks. This dummy input pin will appear
                                     // in the Master bank only when it does not
                                     // have alteast one input\inout pins with
                                     // the IO_STANDARD same as the slave banks.
    .C1_QDRII_MEMORY_WIDTH(36),   
                                     // # of memory part's data width.
    .C1_QDRII_SIM_ONLY(0),   
                                     // # = 1 to skip SRAM power up delay.
    .C2_QDRII_ADDR_WIDTH(19),   
                                     // # of memory component address bits.
    .C2_QDRII_BURST_LENGTH(4),   
                                     // # = 2 -> Burst Length 2 memory part,
                                     // # = 4 -> Burst Length 4 memory part.
    .C2_QDRII_BW_WIDTH(4),   
                                     // # of Byte Write Control bits.
    .C2_QDRII_CLK_WIDTH(1),   
                                     // # of memory clock outputs. Represents
                                     // the number of K, K_n, C, and C_n clocks.
    .C2_QDRII_CQ_WIDTH(1),   
                                     // # of CQ bits.
    .C2_QDRII_DATA_WIDTH(36),   
                                     // Design Data Width.
    .C2_QDRII_DEBUG_EN(0),   
                                     // Enable debug signals/controls. When this
                                     // parameter is changed from 0 to 1, make
                                     // sure to uncomment the coregen commands
                                     // in ise_flow.bat or create_ise.bat files
                                     // in par folder.
    .C2_QDRII_HIGH_PERFORMANCE_MODE("TRUE"),   
                                     // # = "TRUE", the IODELAY performance mode
                                     // is set to high.
                                     // # = "FALSE", the IODELAY performance mode
                                     // is set to low.
    .MASTERBANK_PIN_WIDTH(2),   
                                     // # of dummy inuput pins for the Master
                                     // Banks. This dummy input pin will appear
                                     // in the Master bank only when it does not
                                     // have alteast one input\inout pins with
                                     // the IO_STANDARD same as the slave banks.
    .C2_QDRII_MEMORY_WIDTH(36),   
                                     // # of memory part's data width.
    .C2_QDRII_SIM_ONLY(0)     
                                     // # = 1 to skip SRAM power up delay.
)
u_controller (
    .c0_qdr_d                  (c0_qdr_d),
    .c0_qdr_q                  (c0_qdr_q),
    .c0_qdr_sa                 (c0_qdr_sa),
    .c0_qdr_w_n                (c0_qdr_w_n),
    .c0_qdr_r_n                (c0_qdr_r_n),
    .c0_qdr_dll_off_n          (c0_qdr_dll_off_n),
    .c0_qdr_bw_n               (c0_qdr_bw_n),
    .qdrii_sys_clk_f0_p        (qdrii_sys_clk_f0_p),
    .qdrii_sys_clk_f0_n        (qdrii_sys_clk_f0_n),
    .dly_clk_200_p             (dly_clk_200_p),
    .dly_clk_200_n             (dly_clk_200_n),
    .masterbank_sel_pin        (masterbank_sel_pin),
    .sys_rst_n                 (sys_rst_n),
    .c0_cal_done               (c0_cal_done),
    .f0_user_rst_0_tb          (f0_user_rst_0_tb),
    .f0_qdrii_clk0_tb          (f0_qdrii_clk0_tb),
    .c0_user_ad_w_n            (c0_user_ad_w_n),
    .c0_user_d_w_n             (c0_user_d_w_n),
    .c0_user_r_n               (c0_user_r_n),
    .c0_user_wr_full           (c0_user_wr_full),
    .c0_user_rd_full           (c0_user_rd_full),
    .c0_user_qr_valid          (c0_user_qr_valid),
    .c0_user_dwl               (c0_user_dwl),
    .c0_user_dwh               (c0_user_dwh),
    .c0_user_qrl               (c0_user_qrl),
    .c0_user_qrh               (c0_user_qrh),
    .c0_user_bwl_n             (c0_user_bwl_n),
    .c0_user_bwh_n             (c0_user_bwh_n),
    .c0_user_ad_wr             (c0_user_ad_wr),
    .c0_user_ad_rd             (c0_user_ad_rd),
    .c0_qdr_cq                 (c0_qdr_cq),
    .c0_qdr_cq_n               (c0_qdr_cq_n),
    .c0_qdr_k                  (c0_qdr_k),
    .c0_qdr_k_n                (c0_qdr_k_n),
    .c0_qdr_c                  (c0_qdr_c),
    .c0_qdr_c_n                (c0_qdr_c_n),
    .c1_qdr_d                  (c1_qdr_d),
    .c1_qdr_q                  (c1_qdr_q),
    .c1_qdr_sa                 (c1_qdr_sa),
    .c1_qdr_w_n                (c1_qdr_w_n),
    .c1_qdr_r_n                (c1_qdr_r_n),
    .c1_qdr_dll_off_n          (c1_qdr_dll_off_n),
    .c1_qdr_bw_n               (c1_qdr_bw_n),
    .c1_cal_done               (c1_cal_done),
    .c1_user_ad_w_n            (c1_user_ad_w_n),
    .c1_user_d_w_n             (c1_user_d_w_n),
    .c1_user_r_n               (c1_user_r_n),
    .c1_user_wr_full           (c1_user_wr_full),
    .c1_user_rd_full           (c1_user_rd_full),
    .c1_user_qr_valid          (c1_user_qr_valid),
    .c1_user_dwl               (c1_user_dwl),
    .c1_user_dwh               (c1_user_dwh),
    .c1_user_qrl               (c1_user_qrl),
    .c1_user_qrh               (c1_user_qrh),
    .c1_user_bwl_n             (c1_user_bwl_n),
    .c1_user_bwh_n             (c1_user_bwh_n),
    .c1_user_ad_wr             (c1_user_ad_wr),
    .c1_user_ad_rd             (c1_user_ad_rd),
    .c1_qdr_cq                 (c1_qdr_cq),
    .c1_qdr_cq_n               (c1_qdr_cq_n),
    .c1_qdr_k                  (c1_qdr_k),
    .c1_qdr_k_n                (c1_qdr_k_n),
    .c1_qdr_c                  (c1_qdr_c),
    .c1_qdr_c_n                (c1_qdr_c_n),
    .c2_qdr_d                  (c2_qdr_d),
    .c2_qdr_q                  (c2_qdr_q),
    .c2_qdr_sa                 (c2_qdr_sa),
    .c2_qdr_w_n                (c2_qdr_w_n),
    .c2_qdr_r_n                (c2_qdr_r_n),
    .c2_qdr_dll_off_n          (c2_qdr_dll_off_n),
    .c2_qdr_bw_n               (c2_qdr_bw_n),
    .c2_cal_done               (c2_cal_done),
    .c2_user_ad_w_n            (c2_user_ad_w_n),
    .c2_user_d_w_n             (c2_user_d_w_n),
    .c2_user_r_n               (c2_user_r_n),
    .c2_user_wr_full           (c2_user_wr_full),
    .c2_user_rd_full           (c2_user_rd_full),
    .c2_user_qr_valid          (c2_user_qr_valid),
    .c2_user_dwl               (c2_user_dwl),
    .c2_user_dwh               (c2_user_dwh),
    .c2_user_qrl               (c2_user_qrl),
    .c2_user_qrh               (c2_user_qrh),
    .c2_user_bwl_n             (c2_user_bwl_n),
    .c2_user_bwh_n             (c2_user_bwh_n),
    .c2_user_ad_wr             (c2_user_ad_wr),
    .c2_user_ad_rd             (c2_user_ad_rd),
    .c2_qdr_cq                 (c2_qdr_cq),
    .c2_qdr_cq_n               (c2_qdr_cq_n),
    .c2_qdr_k                  (c2_qdr_k),
    .c2_qdr_k_n                (c2_qdr_k_n),
    .c2_qdr_c                  (c2_qdr_c),
    .c2_qdr_c_n                (c2_qdr_c_n)
);

// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file controller.v when simulating
// the core, controller. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

