------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        nf10_axilite_rbs_bridge.vhd
--
--  Library:
--        contrib/pisa/pcores/nf10_axilite_rbs_bridge_v1_00_a
--
--  Module:
--        nf10_axilite_rbs_bridge
--
--  Author:
--        Gianni Antichi, Muhammad Shahbaz
--
--  Description:
--        AXILITE to RBS (Register Bus Streaming - NetFPGA 1G reference pipeline) conversion library.
--
--  Copyright notice:
--        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
--                                 Junior University
--
--  Licence:
--        This file is part of the NetFPGA 10G development base package.
--
--        This file is free code: you can redistribute it and/or modify it under
--        the terms of the GNU Lesser General Public License version 2.1 as
--        published by the Free Software Foundation.
--
--        This package is distributed in the hope that it will be useful, but
--        WITHOUT ANY WARRANTY; without even the implied warranty of
--        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--        Lesser General Public License for more details.
--
--        You should have received a copy of the GNU Lesser General Public
--        License along with the NetFPGA source package.  If not, see
--        http://www.gnu.org/licenses/.
--
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.family_support.all;
use proc_common_v3_00_a.ipif_pkg.all;

library axi_lite_ipif_v1_01_a;
use axi_lite_ipif_v1_01_a.axi_lite_ipif;

-- Definition of Generics:
--   C_S_AXI_DATA_WIDTH           -- AXI data bus width
--   C_S_AXI_ADDR_WIDTH           -- AXI address bus width
--   C_BASEADDR                   -- Base address of the core
--   C_HIGHADDR                   -- AXI4LITE slave: high address
--   C_FAMILY                     -- Target FPGA family
--   C_RBS_SRC_WIDTH              -- RBS source bus width
--   C_RBS_RING_SIZE              -- RBS ring size i.e. number of attached modules on the RBS side
--   C_RBS_SRC_ID                 -- RBS source ID

-- Definition of Ports:
--   S_AXI_ACLK                   -- AXI Clock
--   S_AXI_ARESETN                -- AXI Reset
--   S_AXI_AWADDR                 -- AXI Write Address
--   S_AXI_AWVALID                -- Write Address Valid
--   S_AXI_WDATA                  -- Write Data
--   S_AXI_WSTRB                  -- Write Strobes
--   S_AXI_WVALID                 -- Write Valid
--   S_AXI_BREADY                 -- Response Ready
--   S_AXI_ARADDR                 -- Read Address
--   S_AXI_ARVALID                -- Read Address Valid
--   S_AXI_RREADY                 -- Read Ready
--   S_AXI_ARREADY                -- Read Address Ready
--   S_AXI_RDATA                  -- Read Data
--   S_AXI_RRESP                  -- Read Response
--   S_AXI_RVALID                 -- Read Valid
--   S_AXI_WREADY                 -- Write Ready
--   S_AXI_BRESP                  -- Write Response
--   S_AXI_BVALID                 -- Write Response Valid
--   S_AXI_AWREADY                -- Write Address Ready
------------------------------------------------------------------------------

entity nf10_axilite_rbs_bridge is
  generic
  (
    C_S_AXI_DATA_WIDTH             : integer              := 32;
    C_S_AXI_ADDR_WIDTH             : integer              := 32;
    C_BASEADDR                     : std_logic_vector     := X"76c00000";
    C_HIGHADDR                     : std_logic_vector     := X"76c0ffff";
    C_FAMILY                       : string               := "virtex5";
    C_S_AXI_ACLK_FREQ_HZ	   : integer              := 100;
    C_RBS_SRC_WIDTH                : integer              := 2; 
    C_RBS_RING_SIZE                : integer              := 16;
    C_RBS_SRC_ID                   : integer              := 0
  );
  port
  (
    S_AXI_ACLK                     : in  std_logic;
    S_AXI_ARESETN                  : in  std_logic;
    S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWVALID                  : in  std_logic;
    S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID                   : in  std_logic;
    S_AXI_BREADY                   : in  std_logic;
    S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID                  : in  std_logic;
    S_AXI_RREADY                   : in  std_logic;
    S_AXI_ARREADY                  : out std_logic;
    S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
    S_AXI_RVALID                   : out std_logic;
    S_AXI_WREADY                   : out std_logic;
    S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
    S_AXI_BVALID                   : out std_logic;
    S_AXI_AWREADY                  : out std_logic;

    -- NetFPGA 1G register pipeline signals
    S_RBS_REQ		           : in std_logic;
    S_RBS_ACK		           : in std_logic;
    S_RBS_RD_WR_L		   : in std_logic;
    S_RBS_ADDR		           : in std_logic_vector((C_S_AXI_ADDR_WIDTH-2)-1 downto 0);
    S_RBS_DATA		           : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_RBS_SRC			   : in std_logic_vector(C_RBS_SRC_WIDTH-1 downto 0);
   
    M_RBS_REQ	                   : out std_logic;
    M_RBS_ACK	                   : out std_logic;
    M_RBS_RD_WR_L	           : out std_logic;
    M_RBS_ADDR	                   : out std_logic_vector((C_S_AXI_ADDR_WIDTH-2)-1 downto 0);
    M_RBS_DATA	                   : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    M_RBS_SRC	                   : out std_logic_vector(C_RBS_SRC_WIDTH-1 downto 0)
  );

end entity nf10_axilite_rbs_bridge;

------------------------------------------------------------------------------
-- Architecture
------------------------------------------------------------------------------

architecture rtl of nf10_axilite_rbs_bridge is

  constant ZEROES			  : std_logic_vector(31 downto 0)	:= X"00000000";
  constant C_S_AXI_MIN_SIZE		  : std_logic_vector(31 downto 0)	:= C_BASEADDR xor C_HIGHADDR;
  constant C_ARD_ADDR_RANGE_ARRAY	  : SLV64_ARRAY_TYPE			:=
										   (
								                   -- registers Base Address
									              ZEROES & C_BASEADDR,
 										      ZEROES & C_HIGHADDR
										    );
  constant C_ARD_NUM_CE_ARRAY		  : INTEGER_ARRAY_TYPE			:=
										    (
										      0 => 4
										    );
  constant C_USE_WSTRB			  : integer				:= 0;
  constant C_DPHASE_TIMEOUT		  : integer				:= C_RBS_RING_SIZE+1; 

------------------------------------------
-- Signals declarations
------------------------------------------
  
  signal bus2ip_clk                     : std_logic;
  signal bus2ip_reset			: std_logic;
  signal bus2ip_resetn                  : std_logic;
  signal bus2ip_addr                    : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal bus2ip_rnw                     : std_logic;
  signal bus2ip_be                      : std_logic_vector(C_S_AXI_DATA_WIDTH/8-1 downto 0);
  signal bus2ip_cs                      : std_logic_vector(((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);
  signal bus2ip_rdce                    : std_logic_vector(calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);
  signal bus2ip_wrce                    : std_logic_vector(calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);
  signal bus2ip_data                    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
  signal ip2bus_data                    : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)	:= (others => '0');
  signal ip2bus_rdack                   : std_logic	:= '0';
  signal ip2bus_wrack                   : std_logic	:= '0';
  signal ip2bus_error                   : std_logic	:= '0';


  component ipif_rbs_bridge is
    generic
    (
      --IPIF settings
	C_S_IPIF_DATA_WIDTH	: integer range 32 to 32	:= 32;
	C_S_IPIF_ADDR_WIDTH	: integer			:= 32;
        C_S_IPIF_CS_WIDTH	: integer			:= 1;
	C_S_IPIF_RdCE_WIDTH	: integer			:= 1;
        C_S_IPIF_WrCE_WIDTH	: integer			:= 1;
        C_RBS_SRC_WIDTH         : integer                       := 2;
        C_RBS_RING_SIZE         : integer			:= 16;
        C_RBS_SRC_ID            : integer                       := 0 
    );
    port
    (
      Bus2IP_Clk                     : in  std_logic;
      Bus2IP_Reset                   : in  std_logic;
      Bus2IP_Addr                    : in  std_logic_vector(C_S_IPIF_ADDR_WIDTH-1 downto 0);
      Bus2IP_RNW                     : in  std_logic;
      Bus2IP_Data                    : in  std_logic_vector(C_S_IPIF_DATA_WIDTH-1 downto 0);
      Bus2IP_BE                      : in  std_logic_vector((C_S_IPIF_DATA_WIDTH/8)-1 downto 0);
      Bus2IP_RdCE                    : in  std_logic_vector(C_S_IPIF_RdCE_WIDTH-1 downto 0);
      Bus2IP_WrCE                    : in  std_logic_vector(C_S_IPIF_WrCE_WIDTH-1 downto 0);
      Bus2IP_CS			     : in  std_logic_vector(C_S_IPIF_CS_WIDTH-1 downto 0);
      IP2Bus_Data                    : out std_logic_vector(C_S_IPIF_DATA_WIDTH-1 downto 0);
      IP2Bus_RdAck                   : out std_logic;
      IP2Bus_WrAck                   : out std_logic;
      IP2Bus_Error                   : out std_logic;

      -- NetFPGA 1G register pipeline signals
      S_RBS_REQ		             : in std_logic;
      S_RBS_ACK		             : in std_logic;
      S_RBS_RD_WR_L		     : in std_logic;
      S_RBS_ADDR	             : in std_logic_vector((C_S_IPIF_ADDR_WIDTH-2)-1 downto 0);
      S_RBS_DATA	             : in std_logic_vector(C_S_IPIF_DATA_WIDTH-1 downto 0);
      S_RBS_SRC			     : in std_logic_vector(C_RBS_SRC_WIDTH-1 downto 0);
   
      M_RBS_REQ	                     : out std_logic;
      M_RBS_ACK	                     : out std_logic;
      M_RBS_RD_WR_L	             : out std_logic;
      M_RBS_ADDR	             : out std_logic_vector((C_S_IPIF_ADDR_WIDTH-2)-1 downto 0);
      M_RBS_DATA	             : out std_logic_vector(C_S_IPIF_DATA_WIDTH-1 downto 0);
      M_RBS_SRC	                     : out std_logic_vector(C_RBS_SRC_WIDTH-1 downto 0)
    );
  end component ipif_rbs_bridge;

begin

---------------------------------------------------------------
-- RESET signal assignment - IPIC RESET is active low
---------------------------------------------------------------

      bus2ip_reset <= not bus2ip_resetn;

------------------------------------------
-- Instantiate AXI lite IPIF
------------------------------------------

  AXI_LITE_IPIF_I : entity axi_lite_ipif_v1_01_a.axi_lite_ipif
    generic map
    (
      C_S_AXI_DATA_WIDTH             => C_S_AXI_DATA_WIDTH,
      C_S_AXI_ADDR_WIDTH             => C_S_AXI_ADDR_WIDTH,
      C_S_AXI_MIN_SIZE               => C_S_AXI_MIN_SIZE,
      C_USE_WSTRB                    => C_USE_WSTRB,
      C_DPHASE_TIMEOUT               => C_DPHASE_TIMEOUT,
      C_ARD_ADDR_RANGE_ARRAY         => C_ARD_ADDR_RANGE_ARRAY,
      C_ARD_NUM_CE_ARRAY             => C_ARD_NUM_CE_ARRAY,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      S_AXI_ACLK                     => S_AXI_ACLK,
      S_AXI_ARESETN                  => S_AXI_ARESETN,
      S_AXI_AWADDR                   => S_AXI_AWADDR,
      S_AXI_AWVALID                  => S_AXI_AWVALID,
      S_AXI_WDATA                    => S_AXI_WDATA,
      S_AXI_WSTRB                    => S_AXI_WSTRB,
      S_AXI_WVALID                   => S_AXI_WVALID,
      S_AXI_BREADY                   => S_AXI_BREADY,
      S_AXI_ARADDR                   => S_AXI_ARADDR,
      S_AXI_ARVALID                  => S_AXI_ARVALID,
      S_AXI_RREADY                   => S_AXI_RREADY,
      S_AXI_ARREADY                  => S_AXI_ARREADY,
      S_AXI_RDATA                    => S_AXI_RDATA,
      S_AXI_RRESP                    => S_AXI_RRESP,
      S_AXI_RVALID                   => S_AXI_RVALID,
      S_AXI_WREADY                   => S_AXI_WREADY,
      S_AXI_BRESP                    => S_AXI_BRESP,
      S_AXI_BVALID                   => S_AXI_BVALID,
      S_AXI_AWREADY                  => S_AXI_AWREADY,
     
      -- IP Interconnect (IPIC) port signals
      Bus2IP_Clk                     => bus2ip_clk,
      Bus2IP_Resetn                  => bus2ip_resetn,
      Bus2IP_Addr                    => bus2ip_addr,
      Bus2IP_RNW                     => bus2ip_rnw,
      Bus2IP_BE                      => bus2ip_be,
      Bus2IP_CS                      => bus2ip_cs,
      Bus2IP_RdCE                    => bus2ip_rdce,
      Bus2IP_WrCE                    => bus2ip_wrce,
      Bus2IP_Data                    => bus2ip_data,
      IP2Bus_WrAck                   => ip2bus_wrack,
      IP2Bus_RdAck                   => ip2bus_rdack,
      IP2Bus_Error                   => ip2bus_error,
      IP2Bus_Data                    => ip2bus_data
    );

  ------------------------------------------
  -- instantiate User Logic
  ------------------------------------------
  IPIF_RBS_BRIDGE_I : component ipif_rbs_bridge
    generic map
    (
      --IPIF settings
      C_S_IPIF_DATA_WIDTH     => C_S_AXI_DATA_WIDTH,
      C_S_IPIF_ADDR_WIDTH     => C_S_AXI_ADDR_WIDTH,
      C_S_IPIF_CS_WIDTH       => ((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2),
      C_S_IPIF_RdCE_WIDTH     => (calc_num_ce(C_ARD_NUM_CE_ARRAY)),
      C_S_IPIF_WrCE_WIDTH     => (calc_num_ce(C_ARD_NUM_CE_ARRAY)),
      C_RBS_SRC_WIDTH         => C_RBS_SRC_WIDTH,
      C_RBS_RING_SIZE         => C_RBS_RING_SIZE,
      C_RBS_SRC_ID            => C_RBS_SRC_ID
    )
    port map
    (
      -- IPIF signals
      Bus2IP_Clk              => bus2ip_clk,
      Bus2IP_Reset            => bus2ip_reset,
      Bus2IP_Addr             => bus2ip_addr,
      Bus2IP_RNW              => bus2ip_rnw,
      Bus2IP_Data             => bus2ip_data,
      Bus2IP_BE               => bus2ip_be,
      Bus2IP_RdCE             => bus2ip_rdce,
      Bus2IP_WrCE             => bus2ip_wrcE,
      Bus2IP_CS		      => bus2ip_cs,
      IP2Bus_Data             => ip2bus_data,
      IP2Bus_RdAck            => ip2bus_rdack,
      IP2Bus_WrAck            => ip2bus_wrack,
      IP2Bus_Error            => ip2bus_error,

      -- NetFPGA 1G registers pipeline signals
      S_RBS_REQ	              => S_RBS_REQ,
      S_RBS_ACK	              => S_RBS_ACK,
      S_RBS_RD_WR_L           => S_RBS_RD_WR_L,
      S_RBS_ADDR              => S_RBS_ADDR,
      S_RBS_DATA	      => S_RBS_DATA,
      S_RBS_SRC               => S_RBS_SRC,
   
      M_RBS_REQ               => M_RBS_REQ,
      M_RBS_ACK               => M_RBS_ACK,
      M_RBS_RD_WR_L           => M_RBS_RD_WR_L,
      M_RBS_ADDR              => M_RBS_ADDR,
      M_RBS_DATA              => M_RBS_DATA,
      M_RBS_SRC               => M_RBS_SRC
    );

end architecture rtl;
