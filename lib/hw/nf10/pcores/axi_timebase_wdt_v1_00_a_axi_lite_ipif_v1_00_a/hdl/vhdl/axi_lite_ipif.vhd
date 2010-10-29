-------------------------------------------------------------------------------
--  AXI Lite IP Interface (IPIF) - entity/architecture pair
-------------------------------------------------------------------------------
--
-- ************************************************************************
-- ** DISCLAIMER OF LIABILITY                                            **
-- **                                                                    **
-- ** This file contains proprietary and confidential information of     **
-- ** Xilinx, Inc. ("Xilinx"), that is distributed under a license       **
-- ** from Xilinx, and may be used, copied and/or disclosed only         **
-- ** pursuant to the terms of a valid license agreement with Xilinx.    **
-- **                                                                    **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION              **
-- ** ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER         **
-- ** EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT                **
-- ** LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,          **
-- ** MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx      **
-- ** does not warrant that functions included in the Materials will     **
-- ** meet the requirements of Licensee, or that the operation of the    **
-- ** Materials will be uninterrupted or error-free, or that defects     **
-- ** in the Materials will be corrected. Furthermore, Xilinx does       **
-- ** not warrant or make any representations regarding use, or the      **
-- ** results of the use, of the Materials in terms of correctness,      **
-- ** accuracy, reliability or otherwise.                                **
-- **                                                                    **
-- ** Xilinx products are not designed or intended to be fail-safe,      **
-- ** or for use in any application requiring fail-safe performance,     **
-- ** such as life-support or safety devices or systems, Class III       **
-- ** medical devices, nuclear facilities, applications related to       **
-- ** the deployment of airbags, or any other applications that could    **
-- ** lead to death, personal injury or severe property or               **
-- ** environmental damage (individually and collectively, "critical     **
-- ** applications"). Customer assumes the sole risk and liability       **
-- ** of any use of Xilinx products in critical applications,            **
-- ** subject only to applicable laws and regulations governing          **
-- ** limitations on product liability.                                  **
-- **                                                                    **
-- ** Copyright 2010 Xilinx, Inc.                                        **
-- ** All rights reserved.                                               **
-- **                                                                    **
-- ** This disclaimer and copyright notice must be retained as part      **
-- ** of this file at all times.                                         **
-- ************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        axi_lite_ipif.vhd
-- Version:         v1.00.a
-- Description:     This is the top level design file for the axi_lite_ipif
--                  function. It provides a standardized slave interface
--                  between the IP and the AXI. This version supports
--                  single read/write transfers only.  It does not provide
--                  address pipelining or simultaneous read and write
--                  operations.
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of axi_lite_ipif.
--
--              --axi_lite_ipif.vhd
--                    --slave_attachment.vhd
--                       --address_decoder.vhd
-------------------------------------------------------------------------------
-- Author:      BSB
--
-- History:
--
--  BSB      05/20/10      -- First version
-- ~~~~~~
--  - Created the first version v1.00.a
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library axi_timebase_wdt_v1_00_a_proc_common_v3_00_a;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.proc_common_pkg.all;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.proc_common_pkg.clog2;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.proc_common_pkg.max2;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.family_support.all;
use axi_timebase_wdt_v1_00_a_proc_common_v3_00_a.ipif_pkg.all;

library axi_timebase_wdt_v1_00_a_axi_lite_ipif_v1_00_a;
use axi_timebase_wdt_v1_00_a_axi_lite_ipif_v1_00_a.all;

-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- C_S_AXI_DATA_WIDTH    -- AXI data bus width
-- C_S_AXI_ADDR_WIDTH    -- AXI address bus width
-- C_S_AXI_MIN_SIZE      -- Minimum address range of the IP
-- C_USE_WSTRB           -- Use write strobs or not
-- C_DPHASE_TIMEOUT      -- Data phase time out counter
-- C_ARD_ADDR_RANGE_ARRAY-- Base /High Address Pair for each Address Range
-- C_ARD_NUM_CE_ARRAY    -- Desired number of chip enables for an address range
-- C_FAMILY              -- Target FPGA family
-------------------------------------------------------------------------------
--                  Definition of Ports
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
-- Bus2IP_Clk            -- Synchronization clock provided to User IP
-- Bus2IP_Reset          -- Active high reset for use by the User IP
-- Bus2IP_Addr           -- Desired address of read or write operation
-- Bus2IP_RNW            -- Read or write indicator for the transaction
-- Bus2IP_BE             -- Byte enables for the data bus
-- Bus2IP_CS             -- Chip select for the transcations
-- Bus2IP_RdCE           -- Chip enables for the read
-- Bus2IP_WrCE           -- Chip enables for the write
-- Bus2IP_Data           -- Write data bus to the User IP
-- IP2Bus_Data           -- Input Read Data bus from the User IP
-- IP2Bus_WrAck          -- Active high Write Data qualifier from the IP
-- IP2Bus_RdAck          -- Active high Read Data qualifier from the IP
-- IP2Bus_Error          -- Error signal from the IP
-------------------------------------------------------------------------------

entity axi_lite_ipif is
    generic (

      C_S_AXI_DATA_WIDTH    : integer  range 32 to 32   := 32;
      C_S_AXI_ADDR_WIDTH    : integer                   := 32;
      C_S_AXI_MIN_SIZE      : std_logic_vector(31 downto 0):= X"000001FF";
      C_USE_WSTRB           : integer := 0;
      C_DPHASE_TIMEOUT      : integer range 0 to 256   := 16;
      C_ARD_ADDR_RANGE_ARRAY: SLV64_ARRAY_TYPE :=  -- not used
         (
           X"0000_0000_7000_0000", -- IP user0 base address
           X"0000_0000_7000_00FF", -- IP user0 high address
           X"0000_0000_7000_0100", -- IP user1 base address
           X"0000_0000_7000_01FF"  -- IP user1 high address
         );

      C_ARD_NUM_CE_ARRAY    : INTEGER_ARRAY_TYPE := -- not used
         (
           4,         -- User0 CE Number
           12         -- User1 CE Number
         );
      C_FAMILY              : string  := "virtex6"
           );
    port (

        --System signals
      S_AXI_ACLK            : in  std_logic;
      S_AXI_ARESETN         : in  std_logic;
      S_AXI_AWADDR          : in  std_logic_vector
                              (C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_AWVALID         : in  std_logic;
      S_AXI_AWREADY         : out std_logic;
      S_AXI_WDATA           : in  std_logic_vector
                              (C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_WSTRB           : in  std_logic_vector
                              ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
      S_AXI_WVALID          : in  std_logic;
      S_AXI_WREADY          : out std_logic;
      S_AXI_BRESP           : out std_logic_vector(1 downto 0);
      S_AXI_BVALID          : out std_logic;
      S_AXI_BREADY          : in  std_logic;
      S_AXI_ARADDR          : in  std_logic_vector
                              (C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_ARVALID         : in  std_logic;
      S_AXI_ARREADY         : out std_logic;
      S_AXI_RDATA           : out std_logic_vector
                              (C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_RRESP           : out std_logic_vector(1 downto 0);
      S_AXI_RVALID          : out std_logic;
      S_AXI_RREADY          : in  std_logic;
      -- Controls to the IP/IPIF modules
      Bus2IP_Clk            : out std_logic;
      Bus2IP_Resetn         : out std_logic;
      Bus2IP_Addr           : out std_logic_vector
                              ((C_S_AXI_ADDR_WIDTH-1) downto 0);
      Bus2IP_RNW            : out std_logic;
      Bus2IP_BE             : out std_logic_vector
                              (((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
      Bus2IP_CS             : out std_logic_vector
                              (((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2-1) downto 0);
      Bus2IP_RdCE           : out std_logic_vector
                              ((calc_num_ce(C_ARD_NUM_CE_ARRAY)-1) downto 0);
      Bus2IP_WrCE           : out std_logic_vector
                              ((calc_num_ce(C_ARD_NUM_CE_ARRAY)-1) downto 0);
      Bus2IP_Data           : out std_logic_vector
                              ((C_S_AXI_DATA_WIDTH-1) downto 0);
      IP2Bus_Data           : in  std_logic_vector
                              ((C_S_AXI_DATA_WIDTH-1) downto 0);
      IP2Bus_WrAck          : in  std_logic;
      IP2Bus_RdAck          : in  std_logic;
      IP2Bus_Error          : in  std_logic

       );

end axi_lite_ipif;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture rtl of axi_lite_ipif is

-------------------------------------------------------------------------------
-- Begin architecture logic
-------------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- Slave Attachment
-------------------------------------------------------------------------------

I_SLAVE_ATTACHMENT:  entity axi_timebase_wdt_v1_00_a_axi_lite_ipif_v1_00_a.slave_attachment
    generic map(
        C_ARD_ADDR_RANGE_ARRAY    => C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY        => C_ARD_NUM_CE_ARRAY,
        C_IPIF_ABUS_WIDTH         => C_S_AXI_ADDR_WIDTH,
        C_IPIF_DBUS_WIDTH         => C_S_AXI_DATA_WIDTH,
        C_USE_WSTRB               => C_USE_WSTRB,
        C_DPHASE_TIMEOUT          => C_DPHASE_TIMEOUT,
        C_S_AXI_MIN_SIZE          => C_S_AXI_MIN_SIZE,
        C_FAMILY                  => C_FAMILY
    )
    port map(
        -- AXI signals
        S_AXI_ACLK          =>  S_AXI_ACLK,
        S_AXI_ARESETN       =>  S_AXI_ARESETN,
        S_AXI_AWADDR        =>  S_AXI_AWADDR,
        S_AXI_AWVALID       =>  S_AXI_AWVALID,
        S_AXI_AWREADY       =>  S_AXI_AWREADY,
        S_AXI_WDATA         =>  S_AXI_WDATA,
        S_AXI_WSTRB         =>  S_AXI_WSTRB,
        S_AXI_WVALID        =>  S_AXI_WVALID,
        S_AXI_WREADY        =>  S_AXI_WREADY,
        S_AXI_BRESP         =>  S_AXI_BRESP,
        S_AXI_BVALID        =>  S_AXI_BVALID,
        S_AXI_BREADY        =>  S_AXI_BREADY,
        S_AXI_ARADDR        =>  S_AXI_ARADDR,
        S_AXI_ARVALID       =>  S_AXI_ARVALID,
        S_AXI_ARREADY       =>  S_AXI_ARREADY,
        S_AXI_RDATA         =>  S_AXI_RDATA,
        S_AXI_RRESP         =>  S_AXI_RRESP,
        S_AXI_RVALID        =>  S_AXI_RVALID,
        S_AXI_RREADY        =>  S_AXI_RREADY,
        -- IPIC signals
        Bus2IP_Clk          =>  Bus2IP_Clk,
        Bus2IP_Resetn       =>  Bus2IP_Resetn,
        Bus2IP_Addr         =>  Bus2IP_Addr,
        Bus2IP_RNW          =>  Bus2IP_RNW,
        Bus2IP_BE           =>  Bus2IP_BE,
        Bus2IP_CS           =>  Bus2IP_CS,
        Bus2IP_RdCE         =>  Bus2IP_RdCE,
        Bus2IP_WrCE         =>  Bus2IP_WrCE,
        Bus2IP_Data         =>  Bus2IP_Data,
        IP2Bus_Data         =>  IP2Bus_Data,
        IP2Bus_WrAck        =>  IP2Bus_WrAck,
        IP2Bus_RdAck        =>  IP2Bus_RdAck,
        IP2Bus_Error        =>  IP2Bus_Error
    );

end rtl;
