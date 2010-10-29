-------------------------------------------------------------------------------
-- baudrate - entity/architecture pair 
-------------------------------------------------------------------------------
--
-- ***************************************************************************
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        baudrate.vhd
-- Version:         v1.00a
-- Description:     Baud rate enable logic
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of axi_uartlite.
--
--              axi_uartlite.vhd
--                 --axi_lite_ipif.vhd
--                 --uartlite_core.vhd
--                    --uartlite_tx.vhd
--                    --uartlite_rx.vhd
--                    --baudrate.vhd
-------------------------------------------------------------------------------
-- Author:          USM
--
--  USM     07/22/09
-- ^^^^^^
--  - Initial release of v1.00.a
-- ~~~~~~
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_com"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics :
-------------------------------------------------------------------------------
-- UART Lite generics
--  C_RATIO               -- The ratio between clk and the asked baudrate
--                           multiplied with 16
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Ports :
-------------------------------------------------------------------------------
-- System Signals
--  Clk                   --  Clock signal
--  Reset                 --  Reset signal
-- Internal UART interface signals
--  EN_16x_Baud           --  Enable signal which is 16x times baud rate
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                  Entity Section
-------------------------------------------------------------------------------

entity baudrate is
    generic
      (
      C_RATIO      : integer := 48  -- The ratio between clk and the asked
                                   -- baudrate multiplied with 16
      );                              
    port
      (
      Clk          : in  std_logic;
      Reset        : in  std_logic;
      EN_16x_Baud  : out std_logic
      );
end entity baudrate;

-------------------------------------------------------------------------------
-- Architecture Section
-------------------------------------------------------------------------------
architecture RTL of baudrate is

    ---------------------------------------------------------------------------
    -- Signal Declarations
    ---------------------------------------------------------------------------
    signal count : natural range 0 to C_RATIO-1;

begin  -- architecture VHDL_RTL

    ---------------------------------------------------------------------------
    -- COUNTER_PROCESS : Down counter for generating EN_16x_Baud signal
    ---------------------------------------------------------------------------
    COUNTER_PROCESS : process (Clk) is
        begin
            if Clk'event and Clk = '1' then  -- rising clock edge
                if (Reset = '1') then
                    count       <= 0;
                    EN_16x_Baud <= '0';
                else
                    if (count = 0) then
                        count       <= C_RATIO-1;
                        EN_16x_Baud <= '1';
                    else
                        count       <= count - 1;
                        EN_16x_Baud <= '0';
                    end if;
                end if;
            end if;
    end process COUNTER_PROCESS;

end architecture RTL;