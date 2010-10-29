-------------------------------------------------------------------------------
-- axi_timebase_wdt - entity/architecture pair
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
-- Copyright 2001, 2002, 2003, 2004, 2008, 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename        :axi_timebase_wdt.vhd
-- Company         :Xilinx
-- Version         :v1.00.a
-- Description     :32-bit timebase counter and Watch Dog Timer (WDT)
-- Standard        :VHDL-93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of
--              axi_timebase_wdt.
--
--              axi_timebase_wdt.vhd
--                 -- axi_lite_ipif.vhd
--                 -- timebase_wdt_core.vhd
--
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         03/18/2010      -- Ceated the version  v1.00.a
-- ^^^^^^
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_cmb"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- C_BASEADDR            -- Base address of the core
-- C_HIGHADDR            -- Permits alias of address space
-- C_S_AXI_DATA_WIDTH    -- AXI data bus width
-- C_S_AXI_ADDR_WIDTH    -- AXI address bus width
-- C_FAMILY              -- Target FPGA family
-------------------------------------------------------------------------------
-- WDT generics
--  C_WDT_INTERVAL       -- Watchdog Timer Interval = 2**C_WDT_INTERVAL clocks
--                           Defaults to 2**31 clock cycles 
--                           (** is exponentiation)
--  C_WDT_ENABLE_ONCE    -- WDT enable behavior. If TRUE (1),once the WDT has 
--                           been enabled, it can only be disabled by RESET.
--                           Defaults to FALSE;
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- S_AXI_ACLK            -- AXI Clock
-- S_AXI_ARESETN         -- AXI Reset
-- S_AXI_AWADDR          -- AXI Write address
-- S_AXI_AWVALID         -- Write address valid
-- S_AXI_AWREADY         -- Write address ready
-- S_AXI_WDATA           -- Write data
-- S_AXI_WSTRB           -- Write strobes
-- S_AXI_WVALID          -- Write valid
-- S_AXI_WREADY          -- Write ready
-- S_AXI_BRESP           -- Write response
-- S_AXI_BVALID          -- Write response valid
-- S_AXI_BREADY          -- Response ready
-- S_AXI_ARADDR          -- Read address
-- S_AXI_ARVALID         -- Read address valid
-- S_AXI_ARREADY         -- Read address ready
-- S_AXI_RDATA           -- Read data
-- S_AXI_RRESP           -- Read response
-- S_AXI_RVALID          -- Read valid
-- S_AXI_RREADY          -- Read ready
-------------------------------------------------------------------------------
-- Timebase WDT signals 
-------------------------------------------------------------------------------
-- Freeze                -- Freeze count value
-- WDT INTERFACE
-- WDT_Reset             -- Output. Watchdog Timer Reset
-- Timebase_Interrupt    -- Output. Timebase Interrupt
-- WDT_Interrupt         -- Output. Watchdog Timer Interrupt
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library axi_timebase_wdt_v1_00_a_proc_common_v3_00_a;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.ipif_pkg.SLV64_ARRAY_TYPE;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.ipif_pkg.INTEGER_ARRAY_TYPE;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.ipif_pkg.calc_num_ce;
library axi_timebase_wdt_v1_00_a_axi_lite_ipif_v1_00_a;
library axi_timebase_wdt_v1_00_a;
-------------------------------------------------------------------------------
-- Entity section
-------------------------------------------------------------------------------

entity axi_timebase_wdt is
 generic 
  ( C_FAMILY             : string    := "virtex5";
  -- Timebase watchdog timer generics
    C_WDT_INTERVAL       : integer range 8 to 31  := 30;
    C_WDT_ENABLE_ONCE    : integer range 0 to 1   := 1;
  -- axi lite ipif block generics
    C_BASEADDR        : std_logic_vector(31 downto 0) := X"FFFF_FFFF";
    C_HIGHADDR        : std_logic_vector(31 downto 0) := X"0000_0000";  
    C_S_AXI_DATA_WIDTH: integer  range 32 to 32   := 32;
    C_S_AXI_ADDR_WIDTH: integer                   := 32
  );  
  port 
  (
    Freeze             : in   std_logic;
  -- TIMEBASE WATCHDOG TIMER INTERFACE
    WDT_Reset          : out std_logic;
    Timebase_Interrupt : out std_logic;
    WDT_Interrupt      : out std_logic;
    
    --System signals
    S_AXI_ACLK        : in  std_logic;
    S_AXI_ARESETN     : in  std_logic;
    S_AXI_AWADDR      : in  std_logic_vector
                        (C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWVALID     : in  std_logic;
    S_AXI_AWREADY     : out std_logic;
    S_AXI_WDATA       : in  std_logic_vector
                        (C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB       : in  std_logic_vector
                        ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID      : in  std_logic;
    S_AXI_WREADY      : out std_logic;
    S_AXI_BRESP       : out std_logic_vector(1 downto 0);
    S_AXI_BVALID      : out std_logic;
    S_AXI_BREADY      : in  std_logic;
    S_AXI_ARADDR      : in  std_logic_vector
                        (C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID     : in  std_logic;
    S_AXI_ARREADY     : out std_logic;
    S_AXI_RDATA       : out std_logic_vector
                        (C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP       : out std_logic_vector(1 downto 0);
    S_AXI_RVALID      : out std_logic;
    S_AXI_RREADY      : in  std_logic
  );

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------
-- Fan-Out attributes for XST
ATTRIBUTE MAX_FANOUT                     : string;
ATTRIBUTE MAX_FANOUT   of S_AXI_ACLK     : signal is "10000";
ATTRIBUTE MAX_FANOUT   of S_AXI_ARESETN  : signal is "10000";

end entity axi_timebase_wdt;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture imp of axi_timebase_wdt is

-------------------------------------------------------------------------------
-- Constant declarations
-------------------------------------------------------------------------------

constant ZEROES                 : std_logic_vector(0 to 31) := X"00000000";
constant C_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
        (
          -- TBWDT registers Base Address
          ZEROES & C_BASEADDR,
          ZEROES & (C_BASEADDR or X"0000_000F") 
        );

constant C_ARD_NUM_CE_ARRAY     : INTEGER_ARRAY_TYPE :=
        (
          0 => 4
        );
constant C_USE_WSTRB            :integer := 1;
constant C_S_AXI_MIN_SIZE       :std_logic_vector(31 downto 0):= X"0000000F";
constant C_DPHASE_TIMEOUT       :integer range 0 to 256   := 0;
-------------------------------------------------------------------------------
--  Function Declarations
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Bitwise AND of a std_logic_vector.
-------------------------------------------------------------------------------
    function and_reduce(slv : std_logic_vector) return std_logic is
        variable r : std_logic := '1';
    begin
        for i in slv'range loop
            r := r and slv(i);
        end loop;
        return r;
    end and_reduce;
-------------------------------------------------------------------------------
-- Signal declarations
-------------------------------------------------------------------------------

signal bus2ip_clk      : std_logic;                    
signal bus2ip_reset    : std_logic; 
signal bus2ip_resetn   : std_logic;
signal ip2bus_data     : std_logic_vector(0 to C_S_AXI_DATA_WIDTH - 1):= 
                         (others  => '0');
signal ip2bus_error    : std_logic := '0';
signal ip2bus_wrack    : std_logic := '0';
signal ip2bus_rdack    : std_logic := '0';

signal bus2ip_data     : std_logic_vector
                         (0 to C_S_AXI_DATA_WIDTH - 1);
signal bus2ip_addr     : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH - 1 );
signal bus2ip_be       : std_logic_vector
                         (0 to C_S_AXI_DATA_WIDTH / 8 - 1 );
signal bus2ip_cs       : std_logic_vector
                         (0 to ((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1);
signal bus2ip_rdce     : std_logic_vector
                         (0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
signal bus2ip_wrce     : std_logic_vector
                         (0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);

begin  -- VHDL_RTL

ip2bus_error <= bus2ip_cs(0) and not and_reduce(bus2ip_be);

-------------------------------------------------------------------------------
-- Instantiate the Timebase Watchdog Timer core
-------------------------------------------------------------------------------

TIMEBASE_WDT_CORE_I: entity axi_timebase_wdt_v1_00_a.timebase_wdt_core
  generic map 
       (
        C_FAMILY              => C_FAMILY,
        C_WDT_INTERVAL        => C_WDT_INTERVAL,
        C_WDT_ENABLE_ONCE     => C_WDT_ENABLE_ONCE /= 0,
        C_NATIVE_DWIDTH       => C_S_AXI_DATA_WIDTH
       )  
  port map 
       (
        Clk                   => bus2ip_clk,
        Reset                 => bus2ip_reset,
        Freeze                => Freeze,
        IP2Bus_Data           => ip2bus_data,
        IP2Bus_WrAck          => ip2bus_wrack,
        IP2Bus_RdAck          => ip2bus_rdack,
        Bus2IP_Data           => bus2ip_data,
        Bus2IP_RdCE           => bus2ip_rdce,
        Bus2IP_WrCE           => bus2ip_wrce,                                
        WDT_Reset             => WDT_Reset,          --[out]
        Timebase_Interrupt    => Timebase_Interrupt, --[out]
        WDT_Interrupt         => WDT_Interrupt       --[out]
       );

    ---------------------------------------------------------------------
    -- INSTANTIATE AXI Lite IPIF
    ---------------------------------------------------------------------
    AXI4_LITE_I : entity axi_timebase_wdt_v1_00_a_axi_lite_ipif_v1_00_a.axi_lite_ipif
      generic map
           (
        C_S_AXI_DATA_WIDTH    => C_S_AXI_DATA_WIDTH,
        C_S_AXI_ADDR_WIDTH    => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_MIN_SIZE      => C_S_AXI_MIN_SIZE,
        C_USE_WSTRB           => C_USE_WSTRB,
        C_DPHASE_TIMEOUT      => C_DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY=> C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY    => C_ARD_NUM_CE_ARRAY,
        C_FAMILY              => C_FAMILY
           )
     port map
        (
        S_AXI_ACLK            => S_AXI_ACLK,
        S_AXI_ARESETN         => S_AXI_ARESETN,
        S_AXI_AWADDR          => S_AXI_AWADDR,
        S_AXI_AWVALID         => S_AXI_AWVALID,
        S_AXI_AWREADY         => S_AXI_AWREADY,
        S_AXI_WDATA           => S_AXI_WDATA,
        S_AXI_WSTRB           => S_AXI_WSTRB,
        S_AXI_WVALID          => S_AXI_WVALID,
        S_AXI_WREADY          => S_AXI_WREADY,
        S_AXI_BRESP           => S_AXI_BRESP,
        S_AXI_BVALID          => S_AXI_BVALID,
        S_AXI_BREADY          => S_AXI_BREADY,
        S_AXI_ARADDR          => S_AXI_ARADDR,
        S_AXI_ARVALID         => S_AXI_ARVALID,
        S_AXI_ARREADY         => S_AXI_ARREADY,
        S_AXI_RDATA           => S_AXI_RDATA,
        S_AXI_RRESP           => S_AXI_RRESP,
        S_AXI_RVALID          => S_AXI_RVALID,
        S_AXI_RREADY          => S_AXI_RREADY,
         -- IP Interconnect (IPIC) port signals --------------------------------
        Bus2IP_Clk            => bus2ip_clk,
        Bus2IP_Resetn         => bus2ip_resetn,
        IP2Bus_Data           => ip2bus_data,
        IP2Bus_WrAck          => ip2bus_wrack,
        IP2Bus_RdAck          => ip2bus_rdack,
        IP2Bus_Error          => ip2bus_error,
        Bus2IP_Addr           => bus2ip_addr,
        Bus2IP_Data           => bus2ip_data,
        Bus2IP_RNW            => open,
        Bus2IP_BE             => bus2ip_be,
        Bus2IP_CS             => bus2ip_cs,
        Bus2IP_RdCE           => bus2ip_rdce,
        Bus2IP_WrCE           => bus2ip_wrce                                
    );
bus2ip_reset <= not bus2ip_resetn;
end imp;
-------------------------------------------------------------------------------
--END OF FILE
-------------------------------------------------------------------------------

