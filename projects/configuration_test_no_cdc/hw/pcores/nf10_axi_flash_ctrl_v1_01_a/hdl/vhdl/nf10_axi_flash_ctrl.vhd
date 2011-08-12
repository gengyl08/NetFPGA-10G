------------------------------------------------------------------------
--
--  NETFPGA-10G www.netfpga.org
--
--  Module:
--          axi_flash - Behavioral
--
--  Description:
--          Connects the flash controller to the PCIe axi_lite interface
--                 
--  Revision history:
--          01/11/2010 Stephanie Friederich Initial Revision
--          08/07/2011 Mark Grindell        Added an extra address line to the CPLD
--                                          supporting an extra FLASH device; got rid
--                                          of the apparently unnecessary reset line 
--                                          to the FLASH.
--
--  Known issues:
--          None
--
--  Library: ieee
--           proc_common_v3_00_a
--           nf10_axi_flash_ctrl_v1_00_a
--           axi_lite_ipif_v1_00_a
--
------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.clog2;
use proc_common_v3_00_a.proc_common_pkg.max2;
use proc_common_v3_00_a.family_support.all;
use proc_common_v3_00_a.ipif_pkg.all;

library nf10_axi_flash_ctrl_v1_00_a;
use nf10_axi_flash_ctrl_v1_00_a.all;

library axi_lite_ipif_v1_01_a;
use axi_lite_ipif_v1_01_a.axi_lite_ipif;

-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- C_FAMILY              -- Target FPGA family
-- C_BASEADDR            -- Base address of the core
-- C_HIGHADDR
-- C_S_AXI_DATA_WIDTH    -- AXI data bus width
-- C_S_AXI_ADDR_WIDTH    -- AXI address bus width
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
-------------------------------------------------------------------------------

entity nf10_axi_flash_ctrl is
    generic (
      C_FAMILY              : string                    := "virtex5";
      C_BASEADDR            : std_logic_vector          := X"FFFFFFFF";
      C_HIGHADDR            : std_logic_vector          := X"00000000";
      C_S_AXI_DATA_WIDTH    : integer  range 32 to 32   := 32;
      C_S_AXI_ADDR_WIDTH    : integer                   := 32;
      C_S_AXI_ACLK_FREQ_HZ  : integer                   := 100
      );

    port (
	 -- CPLD_CLK              : in std_logic;
	  reboot                : out std_logic;
      -- System signals
      S_AXI_ACLK            : in  std_logic;
      S_AXI_ARESETN         : in  std_logic;
      S_AXI_AWADDR          : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_AWVALID         : in  std_logic;
      S_AXI_AWREADY         : out std_logic;
      S_AXI_WDATA           : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_WSTRB           : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
      S_AXI_WVALID          : in  std_logic;
      S_AXI_WREADY          : out std_logic;
      S_AXI_BRESP           : out std_logic_vector(1 downto 0);
      S_AXI_BVALID          : out std_logic;
      S_AXI_BREADY          : in  std_logic;
      S_AXI_ARADDR          : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_ARVALID         : in  std_logic;
      S_AXI_ARREADY         : out std_logic;
      S_AXI_RDATA           : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_RRESP           : out std_logic_vector(1 downto 0);
      S_AXI_RVALID          : out std_logic;
      S_AXI_RREADY          : in  std_logic;
	  -- Flash signals
      FPGA_A			    : out std_logic_vector(23 downto 0); 
      FPGA_FOE		        : out std_logic;
      FPGA_FWE		        : out std_logic;
      FPGA_FCS		        : out std_logic;
      FPGA_IOL9P		    : out std_logic;
--      FLASH_RST		        : out std_logic;  
      FPGA_DQ_I             : in std_logic_vector(15 downto 0);
      FPGA_DQ_O             : out std_logic_vector(15 downto 0);
      FPGA_DQ_T             : out std_logic_vector(15 downto 0));

	   
  
	   
end nf10_axi_flash_ctrl;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

architecture rtl of nf10_axi_flash_ctrl is

    --------------------------------------------------------------------------
    -- Constant declarations
    --------------------------------------------------------------------------

    constant ZEROES                 : std_logic_vector(31 downto 0)
                                    := X"00000000";

    constant C_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
            (
              -- registers Base Address
              ZEROES & C_BASEADDR,
              ZEROES & (C_BASEADDR or X"0000000F")
            );

    constant C_ARD_NUM_CE_ARRAY     : INTEGER_ARRAY_TYPE :=
            (
              0 => 4
            );

    constant C_S_AXI_MIN_SIZE       : std_logic_vector(31 downto 0)
                                    := X"0000000F";

    constant C_USE_WSTRB            : integer := 0;

    constant C_DPHASE_TIMEOUT       : integer := 4;

    --------------------------------------------------------------------------
    -- Signal declarations
    --------------------------------------------------------------------------
    signal bus2ip_clk    : std_logic;
    signal bus2ip_reset  : std_logic;
    signal bus2ip_resetn : std_logic;
    signal ip2bus_data   : std_logic_vector((C_S_AXI_DATA_WIDTH-1)  downto 0)
                           := (others  => '0');
    signal ip2bus_error  : std_logic := '0';
    signal ip2bus_wrack  : std_logic := '0';
    signal ip2bus_rdack  : std_logic := '0';
    signal bus2ip_data   : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
    signal bus2ip_cs     : std_logic_vector(((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);
    signal bus2ip_rdce   : std_logic_vector(calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);
    signal bus2ip_wrce   : std_logic_vector(calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);
    signal FLASH_RST     : std_logic; 				   
						   
						   
component flash_reg is
	generic (C_IPIF_ABUS_WIDTH   : integer := 32;
	         C_IPIF_DBUS_WIDTH   : integer := 32);
    Port (CPLD_CLK            : in std_logic;
	  reboot              : out std_logic;
	  CLK		      : in std_logic;		
	  -- Flash signals
	  FPGA_A	      : out std_logic_vector(23 downto 0); 
	  --FPGA_DQ	      : inout std_logic_vector (15 downto 0);
	  FPGA_DQ_I           : in std_logic_vector(15 downto 0);
          FPGA_DQ_O           : out std_logic_vector(15 downto 0);
          FPGA_DQ_T           : out std_logic_vector(15 downto 0);
	  FPGA_FOE	      : out std_logic;
	  FPGA_FWE	      : out std_logic;
	  FPGA_FCS	      : out std_logic;
	  FPGA_IOL9P	      : out std_logic;
	  FLASH_RST	      : out std_logic;
	  -- Controls to the IP/IPIF modules
	  Bus2IP_Resetn       : in  std_logic;
	  Bus2IP_CS           : in  std_logic;
	  Bus2IP_RdCE         : in  std_logic_vector(3 downto 0);
	  Bus2IP_WrCE         : in  std_logic_vector(3 downto 0);
	  Bus2IP_Data         : in  std_logic_vector((C_IPIF_DBUS_WIDTH-1) downto 0);
	  IP2Bus_Data         : out std_logic_vector((C_IPIF_DBUS_WIDTH-1) downto 0);
	  IP2Bus_WrAck        : out std_logic;
	  IP2Bus_RdAck        : out std_logic;
	  IP2Bus_Error        : out std_logic);
end component;

begin

    --------------------------------------------------------------------------
    -- RESET signal assignment - IPIC RESET is active low
    --------------------------------------------------------------------------

         bus2ip_reset <= not bus2ip_resetn;


    --------------------------------------------------------------------------
    -- Instantiate AXI lite IPIF
    --------------------------------------------------------------------------
    AXI_LITE_IPIF_I : entity axi_lite_ipif_v1_01_a.axi_lite_ipif
      generic map
       (
        C_FAMILY                  => C_FAMILY,
        C_S_AXI_ADDR_WIDTH        => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH        => C_S_AXI_DATA_WIDTH,
        C_S_AXI_MIN_SIZE          => C_S_AXI_MIN_SIZE,
        C_USE_WSTRB               => C_USE_WSTRB,
        C_DPHASE_TIMEOUT          => C_DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY    => C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY        => C_ARD_NUM_CE_ARRAY
       )
     port map
       (
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

     -- IP Interconnect (IPIC) port signals
        Bus2IP_Clk     => bus2ip_clk,
        Bus2IP_Resetn  => bus2ip_resetn,
        IP2Bus_Data    => ip2bus_data,
        IP2Bus_WrAck   => ip2bus_wrack,
        IP2Bus_RdAck   => ip2bus_rdack,
        IP2Bus_Error   => ip2bus_error,
        Bus2IP_Data    => bus2ip_data,
        Bus2IP_CS      => bus2ip_cs,
        Bus2IP_RdCE    => bus2ip_rdce,
        Bus2IP_WrCE    => bus2ip_wrce
       );
	
	flash_top_level	:	flash_reg
    generic map(C_IPIF_ABUS_WIDTH => C_S_AXI_ADDR_WIDTH,
                C_IPIF_DBUS_WIDTH => C_S_AXI_DATA_WIDTH)

       port map(CPLD_CLK        => S_AXI_ACLK,
	        reboot          => reboot,
		CLK		=> bus2ip_clk,
		-- Flash signals
		FPGA_A		=> FPGA_A,
		--FPGA_DQ	=> FPGA_DQ,
		FPGA_DQ_I       => FPGA_DQ_I,
                FPGA_DQ_O       => FPGA_DQ_O,
                FPGA_DQ_T       => FPGA_DQ_T,
		FPGA_FOE	=> FPGA_FOE,
		FPGA_FWE	=> FPGA_FWE,
		FPGA_FCS	=> FPGA_FCS,
		FPGA_IOL9P	=> FPGA_IOL9P,
		FLASH_RST	=> FLASH_RST,
		-- IPIC signals
                Bus2IP_Resetn   =>  bus2ip_resetn,
                Bus2IP_CS       =>  bus2ip_cs(0),
                Bus2IP_RdCE     =>  Bus2IP_RdCE(3 downto 0),
                Bus2IP_WrCE     =>  Bus2IP_WrCE(3 downto 0),
                Bus2IP_Data     =>  Bus2IP_Data,
                IP2Bus_Data     =>  IP2Bus_Data,
                IP2Bus_WrAck    =>  IP2Bus_WrAck,
                IP2Bus_RdAck    =>  IP2Bus_RdAck,
                IP2Bus_Error    =>  IP2Bus_Error);


	
end rtl;
