/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        system_axisim_tb.v
 *
 *  Project:
 *        reference_nic
 *
 *  Module:
 *        system_axisim_tb
 *
 *  Author:
 *        James Hongyi Zeng
 *
 *  Description:
 *        System testbench for reference_nic
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

`timescale 1 ns / 1ps

`uselib lib=unisims_ver

// START USER CODE (Do not remove this line)

// User: Put your directives here. Code in this
//       section will not be overwritten.

// END USER CODE (Do not remove this line)

module system_axisim_tb
  (
  );

  // START USER CODE (Do not remove this line)

  // User: Put your signals here. Code in this
  //       section will not be overwritten.
  integer             i;

  // END USER CODE (Do not remove this line)

  reg RESET;
  wire RS232_Uart_1_sout;
  reg RS232_Uart_1_sin;
  reg CLK;
  reg refclk_A_p;
  reg refclk_A_n;
  reg refclk_B_p;
  reg refclk_B_n;
  reg refclk_C_p;
  reg refclk_C_n;
  reg refclk_D_p;
  reg refclk_D_n;
  wire MDC;
  wire MDIO;
  wire PHY_RST_N;
  wire [35:0] qdr_d_0;
  wire [35:0] qdr_q_0;
  wire [18:0] qdr_sa_0;
  wire qdr_w_n_0;
  wire qdr_r_n_0;
  wire [3:0] qdr_bw_n_0;
  wire qdr_dll_off_n_0;
  wire qdr_cq_0;
  wire qdr_cq_n_0;
  wire qdr_c_n_0;
  wire qdr_k_n_0;
  wire qdr_c_0;
  wire qdr_k_0;
  wire [35:0] qdr_d_1;
  wire [35:0] qdr_q_1;
  wire [18:0] qdr_sa_1;
  wire qdr_w_n_1;
  wire qdr_r_n_1;
  wire [3:0] qdr_bw_n_1;
  wire qdr_dll_off_n_1;
  wire qdr_cq_1;
  wire qdr_cq_n_1;
  wire qdr_c_n_1;
  wire qdr_k_n_1;
  wire qdr_c_1;
  wire qdr_k_1;
  reg  TCK, TMS, TDI, ZQ;
  wire TDO;
  integer k;

  system_axisim
    dut (
      .RESET ( RESET ),
      .RS232_Uart_1_sout ( RS232_Uart_1_sout ),
      .RS232_Uart_1_sin ( RS232_Uart_1_sin ),
      .CLK ( CLK ),
      .refclk_A_p ( refclk_A_p ),
      .refclk_A_n ( refclk_A_n ),
      .refclk_B_p ( refclk_B_p ),
      .refclk_B_n ( refclk_B_n ),
      .refclk_C_p ( refclk_C_p ),
      .refclk_C_n ( refclk_C_n ),
      .refclk_D_p ( refclk_D_p ),
      .refclk_D_n ( refclk_D_n ),
      .MDC ( MDC ),
      .MDIO ( MDIO ),
      .PHY_RST_N ( PHY_RST_N ),

      .qdr_d_0(qdr_d_0),
      .qdr_q_0(qdr_q_0),
      .qdr_sa_0(qdr_sa_0),
      .qdr_w_n_0(qdr_w_n_0),
      .qdr_r_n_0(qdr_r_n_0),
      .qdr_bw_n_0(qdr_bw_n_0),
      .qdr_dll_off_n_0(qdr_dll_off_n_0),
      .qdr_cq_0(qdr_cq_0),
      .qdr_cq_n_0(qdr_cq_n_0),
      .qdr_c_n_0(qdr_c_n_0),
      .qdr_k_n_0(qdr_k_n_0),
      .qdr_c_0(qdr_c_0),
      .qdr_k_0(qdr_k_0),

      .qdr_d_1(qdr_d_1),
      .qdr_q_1(qdr_q_1),
      .qdr_sa_1(qdr_sa_1),
      .qdr_w_n_1(qdr_w_n_1),
      .qdr_r_n_1(qdr_r_n_1),
      .qdr_bw_n_1(qdr_bw_n_1),
      .qdr_dll_off_n_1(qdr_dll_off_n_1),
      .qdr_cq_1(qdr_cq_1),
      .qdr_cq_n_1(qdr_cq_n_1),
      .qdr_c_n_1(qdr_c_n_1),
      .qdr_k_n_1(qdr_k_n_1),
      .qdr_c_1(qdr_c_1),
      .qdr_k_1(qdr_k_1)
    );

  cyqdr2_b4
    mem0 (
      .TCK(TCK),
      .TMS(TMS),
      .TDI(TDI),
      .TDO(TDO),
      .D(qdr_d_0),
      .Q(qdr_q_0),
      .A(qdr_sa_0),
      .K(qdr_k_0),
      .Kb(qdr_k_n_0),
      .C(qdr_c_0),
      .Cb(qdr_c_n_0),
      .RPSb(qdr_r_n_0),
      .WPSb(qdr_w_n_0),
      .BWS0b(qdr_bw_n_0[0]),
      .BWS1b(qdr_bw_n_0[1]),
      .BWS2b(qdr_bw_n_0[2]),
      .BWS3b(qdr_bw_n_0[3]),
      .CQ(qdr_cq_0),
      .CQb(qdr_cq_n_0),
      .ZQ(ZQ),
      .DOFF(qdr_dll_off_n_0)
    );

  cyqdr2_b4
    mem1 (
      .TCK(TCK),
      .TMS(TMS),
      .TDI(TDI),
      .TDO(TDO),
      .D(qdr_d_1),
      .Q(qdr_q_1),
      .A(qdr_sa_1),
      .K(qdr_k_1),
      .Kb(qdr_k_n_1),
      .C(qdr_c_1),
      .Cb(qdr_c_n_1),
      .RPSb(qdr_r_n_1),
      .WPSb(qdr_w_n_1),
      .BWS0b(qdr_bw_n_1[0]),
      .BWS1b(qdr_bw_n_1[1]),
      .BWS2b(qdr_bw_n_1[2]),
      .BWS3b(qdr_bw_n_1[3]),
      .CQ(qdr_cq_1),
      .CQb(qdr_cq_n_1),
      .ZQ(ZQ),
      .DOFF(qdr_dll_off_n_1)
    );

  // START USER CODE (Do not remove this line)

  // User: Put your stimulus here. Code in this
  //       section will not be overwritten.

  // Part 1: Wire connection

  // Part 2: Reset
  initial begin
      RS232_Uart_1_sin = 1'b0;
      CLK   = 1'b0;

      refclk_A_p = 1'b0;
      refclk_A_n = 1'b1;
      refclk_B_p = 1'b0;
      refclk_B_n = 1'b1;
      refclk_C_p = 1'b0;
      refclk_C_n = 1'b1;
      refclk_D_p = 1'b0;
      refclk_D_n = 1'b1;

      $display("[%t] : System Reset Asserted...", $realtime);
      RESET = 1'b0;
      for (i = 0; i < 50; i = i + 1) begin
                 @(posedge CLK);
      end
      $display("[%t] : System Reset De-asserted...", $realtime);
      RESET = 1'b1;
  end

  // Part 3: Clock
  always #5  CLK = ~CLK;      // 100MHz
  always #3.2 refclk_A_p = ~refclk_A_p; // 156.25MHz
  always #3.2 refclk_A_n = ~refclk_A_n; // 156.25MHz
  always #3.2 refclk_B_p = ~refclk_B_p; // 156.25MHz
  always #3.2 refclk_B_n = ~refclk_B_n; // 156.25MHz
  always #3.2 refclk_C_p = ~refclk_C_p; // 156.25MHz
  always #3.2 refclk_C_n = ~refclk_C_n; // 156.25MHz
  always #3.2 refclk_D_p = ~refclk_D_p; // 156.25MHz
  always #3.2 refclk_D_n = ~refclk_D_n; // 156.25MHz

  // END USER CODE (Do not remove this line)

endmodule

