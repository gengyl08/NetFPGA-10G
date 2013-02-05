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
      .PHY_RST_N ( PHY_RST_N )
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

