------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  Module:
--          nf10_mdio
--
--  Description:
--          MDIO engine for AEL2005 programming
--                 
--  Revision history:
--          2010/12/8 hyzeng: Initial check-in
--
------------------------------------------------------------------------
-- Structure:   
--
--  nf10_mdio.vhd
--      \
--      \-- axi_interface.vhd
--      \-- mdio_ipif.vhd
--           \
--           \-- mdio_if.vhd
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------
-- nf10_mdio_v1_00_a library is used for axi_ethernetlite_v1_00_a 
-- component declarations
-------------------------------------------------------------------------------
library nf10_mdio_v1_00_a;
use nf10_mdio_v1_00_a.axi_interface;
use nf10_mdio_v1_00_a.all;

-------------------------------------------------------------------------------
-- proc common package of the proc common library is used for different 
-- function declarations
-------------------------------------------------------------------------------
library proc_common_v3_00_a;
use proc_common_v3_00_a.all;

-------------------------------------------------------------------------------
-- Vcomponents from unisim library is used for FIFO instatiation
-- function declarations
-------------------------------------------------------------------------------
library unisim;
use unisim.Vcomponents.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity nf10_mdio is
  generic 
   (
    C_FAMILY                        : string := "virtex6";
    C_BASEADDR                      : std_logic_vector := X"FFFFFFFF";
    C_HIGHADDR                      : std_logic_vector := X"00000000";
    C_S_AXI_ACLK_PERIOD_PS          : integer := 10000;
    C_S_AXI_ADDR_WIDTH              : integer range 32 to 32 := 32;
    C_S_AXI_DATA_WIDTH              : integer range 32 to 64 := 32;
    C_S_AXI_ID_WIDTH                : integer := 4;
    C_S_AXI_PROTOCOL                : string  := "AXI4";

    C_INCLUDE_MDIO                  : integer := 1; 
    C_INCLUDE_INTERNAL_LOOPBACK     : integer := 0; 
    C_INCLUDE_GLOBAL_BUFFERS        : integer := 0; 
    C_DUPLEX                        : integer range 0 to 1:= 1; 
    C_TX_PING_PONG                  : integer range 0 to 1:= 0;
    C_RX_PING_PONG                  : integer range 0 to 1:= 0
    );
  port 
    (

--  -- AXI Slave signals ------------------------------------------------------
--   -- AXI Global System Signals
       S_AXI_ACLK       : in  std_logic;
       S_AXI_ARESETN    : in  std_logic;
       IP2INTC_Irpt     : out std_logic;
       

--   -- AXI Slave Burst Interface
--   -- AXI Write Address Channel Signals
       S_AXI_AWID    : in  std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
       S_AXI_AWADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
       S_AXI_AWLEN   : in  std_logic_vector(7 downto 0);
       S_AXI_AWSIZE  : in  std_logic_vector(2 downto 0);
       S_AXI_AWBURST : in  std_logic_vector(1 downto 0);
       S_AXI_AWCACHE : in  std_logic_vector(3 downto 0);
       S_AXI_AWVALID : in  std_logic;
       S_AXI_AWREADY : out std_logic;

--   -- AXI Write Data Channel Signals
       S_AXI_WDATA   : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
       S_AXI_WSTRB   : in  std_logic_vector 
                               (((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
       S_AXI_WLAST   : in  std_logic;
       S_AXI_WVALID  : in  std_logic;
       S_AXI_WREADY  : out std_logic;

--   -- AXI Write Response Channel Signals
       S_AXI_BID     : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
       S_AXI_BRESP   : out std_logic_vector(1 downto 0);
       S_AXI_BVALID  : out std_logic;
       S_AXI_BREADY  : in  std_logic;
--   -- AXI Read Address Channel Signals
       S_AXI_ARID    : in  std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
       S_AXI_ARADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
       S_AXI_ARLEN   : in  std_logic_vector(7 downto 0);
       S_AXI_ARSIZE  : in  std_logic_vector(2 downto 0);
       S_AXI_ARBURST : in  std_logic_vector(1 downto 0);
       S_AXI_ARCACHE : in  std_logic_vector(3 downto 0);
       S_AXI_ARVALID : in  std_logic;
       S_AXI_ARREADY : out std_logic;
       
--   -- AXI Read Data Channel Signals
       S_AXI_RID     : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
       S_AXI_RDATA   : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
       S_AXI_RRESP   : out std_logic_vector(1 downto 0);
       S_AXI_RLAST   : out std_logic;
       S_AXI_RVALID  : out std_logic;
       S_AXI_RREADY  : in  std_logic;     


--   -- Ethernet Interface
       PHY_MDIO_I        : in  std_logic;
       PHY_MDIO_O        : out std_logic;
       PHY_MDIO_T        : out std_logic;
       PHY_MDC           : out std_logic;
       PHY_rst_n         : out std_logic   
    
    );
    
-- XST attributes    

-- Fan-out attributes for XST
attribute MAX_FANOUT                             : string;
attribute MAX_FANOUT of S_AXI_ACLK               : signal is "10000";
attribute MAX_FANOUT of S_AXI_ARESETN            : signal is "10000";


--Psfutil attributes
attribute ASSIGNMENT       :   string;
attribute ADDRESS          :   string; 
attribute PAIR             :   string; 

attribute ASSIGNMENT  of  C_BASEADDR          :  constant is  "REQUIRE"; 
attribute ASSIGNMENT  of  C_HIGHADDR          :  constant is  "REQUIRE"; 
attribute ADDRESS     of  C_BASEADDR          :  constant is  "BASE";
attribute ADDRESS     of  C_HIGHADDR          :  constant is  "HIGH";
attribute PAIR        of  C_BASEADDR          :  constant is  "C_HIGHADDR";
attribute PAIR        of  C_HIGHADDR          :  constant is  "C_BASEADDR";

end nf10_mdio;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------  

architecture imp of nf10_mdio is
-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
constant NODE_MAC : bit_vector := x"00005e00FACE";


-------------------------------------------------------------------------------
--   Signal declaration Section 
-------------------------------------------------------------------------------

-- IPIC Signals
signal temp_Bus2IP_Addr: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
signal bus2ip_addr     : std_logic_vector(31 downto 0);
signal Bus2IP_Data     : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal bus2ip_rdce     : std_logic;
signal bus2ip_wrce     : std_logic;
signal ip2bus_data     : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
signal bus2ip_burst    : std_logic;
signal bus2ip_be       : std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
signal bus_rst         : std_logic;
signal ip2bus_errack   : std_logic;


component FDRE
  port 
   (
    Q  : out std_logic;
    C  : in std_logic;
    CE : in std_logic;
    D  : in std_logic;
    R  : in std_logic
   );
end component;
  
component BUFG
  port (
     O  : out std_ulogic;
     I : in std_ulogic := '0'
  );
end component;

component BUFGMUX
  port (
     O  : out std_ulogic;
     I0 : in std_ulogic := '0';
     I1 : in std_ulogic := '0';
     S  : in std_ulogic
  );
end component;

component BUF 
  port(
    O : out std_ulogic;

    I : in std_ulogic
    );
end component;

  attribute IOB         : string;  

begin -- this is the begin between declarations and architecture body


   -- PHY Reset
   PHY_rst_n   <= S_AXI_ARESETN ;

   -- Bus Reset
   bus_rst     <= not S_AXI_ARESETN ;
      
   ----------------------------------------------------------------------------
   -- MDIO Module
   ----------------------------------------------------------------------------   
   MDIO : entity nf10_mdio_v1_00_a.mdio_ipif
     generic map 
        (
        C_FAMILY                 => C_FAMILY,
        C_BASEADDR               => C_BASEADDR,
        C_HIGHADDR               => C_HIGHADDR,
        C_S_AXI_ADDR_WIDTH       => C_S_AXI_ADDR_WIDTH,  
        C_S_AXI_DATA_WIDTH       => C_S_AXI_DATA_WIDTH,                     
        C_S_AXI_ACLK_PERIOD_PS   => C_S_AXI_ACLK_PERIOD_PS,
        C_DUPLEX                 => C_DUPLEX,
        C_RX_PING_PONG           => C_RX_PING_PONG,
        C_TX_PING_PONG           => C_TX_PING_PONG,
        C_INCLUDE_MDIO           => C_INCLUDE_MDIO,
        NODE_MAC                 => NODE_MAC

        )
     
     port map 
        (   
        Clk       => S_AXI_ACLK,
        Rst       => bus_Rst,
        IP2INTC_Irpt   => IP2INTC_Irpt,


 
     -- Bus2IP Signals
        Bus2IP_Addr          => bus2ip_addr(12 downto 0),
        Bus2IP_Data          => bus2ip_data,
        Bus2IP_BE            => bus2ip_be,
        Bus2IP_Burst         => bus2ip_burst,
        Bus2IP_RdCE          => bus2ip_rdce,
        Bus2IP_WrCE          => bus2ip_wrce,

     -- IP2Bus Signals
        IP2Bus_Data          => ip2bus_data,
        IP2Bus_Error         => ip2bus_errack,

     -- EMAC Signals
        PHY_MDIO_I     => PHY_MDIO_I,
        PHY_MDIO_O     => PHY_MDIO_O,
        PHY_MDIO_T     => PHY_MDIO_T,
        PHY_MDC        => PHY_MDC
        );
        
I_AXI_NATIVE_IPIF: entity nf10_mdio_v1_00_a.axi_interface
  generic map (
  
        C_S_AXI_ADDR_WIDTH          => C_S_AXI_ADDR_WIDTH,  
        C_S_AXI_DATA_WIDTH          => C_S_AXI_DATA_WIDTH,                     
        C_S_AXI_ID_WIDTH            => C_S_AXI_ID_WIDTH,
        C_S_AXI_PROTOCOL            => C_S_AXI_PROTOCOL,
        C_FAMILY                    => C_FAMILY

        )
  port map (  
            
          
        S_AXI_ACLK      =>  S_AXI_ACLK,
        S_AXI_ARESETN   =>  S_AXI_ARESETN,
        S_AXI_AWADDR    =>  S_AXI_AWADDR,
        S_AXI_AWID      =>  S_AXI_AWID,
        S_AXI_AWLEN     =>  S_AXI_AWLEN,
        S_AXI_AWSIZE    =>  S_AXI_AWSIZE,
        S_AXI_AWBURST   =>  S_AXI_AWBURST,
        S_AXI_AWCACHE   =>  S_AXI_AWCACHE,
        S_AXI_AWVALID   =>  S_AXI_AWVALID,
        S_AXI_AWREADY   =>  S_AXI_AWREADY,
        S_AXI_WDATA     =>  S_AXI_WDATA,
        S_AXI_WSTRB     =>  S_AXI_WSTRB,
        S_AXI_WLAST     =>  S_AXI_WLAST,
        S_AXI_WVALID    =>  S_AXI_WVALID,
        S_AXI_WREADY    =>  S_AXI_WREADY,
        S_AXI_BID       =>  S_AXI_BID,
        S_AXI_BRESP     =>  S_AXI_BRESP,
        S_AXI_BVALID    =>  S_AXI_BVALID,
        S_AXI_BREADY    =>  S_AXI_BREADY,
        S_AXI_ARID      =>  S_AXI_ARID,
        S_AXI_ARADDR    =>  S_AXI_ARADDR,                                       
        S_AXI_ARLEN     =>  S_AXI_ARLEN,                                        
        S_AXI_ARSIZE    =>  S_AXI_ARSIZE,                                       
        S_AXI_ARBURST   =>  S_AXI_ARBURST,                                      
        S_AXI_ARCACHE   =>  S_AXI_ARCACHE,                                      
        S_AXI_ARVALID   =>  S_AXI_ARVALID,
        S_AXI_ARREADY   =>  S_AXI_ARREADY,                                              
        S_AXI_RID       =>  S_AXI_RID,                                      
        S_AXI_RDATA     =>  S_AXI_RDATA,                                        
        S_AXI_RRESP     =>  S_AXI_RRESP,                                        
        S_AXI_RLAST     =>  S_AXI_RLAST,                                        
        S_AXI_RVALID    =>  S_AXI_RVALID,                                       
        S_AXI_RREADY    =>  S_AXI_RREADY,                                       
                                                                
            
-- IP Interconnect (IPIC) port signals ------------------------------------                                                     
      -- Controls to the IP/IPIF modules
            -- IP Interconnect (IPIC) port signals
        IP2Bus_Data     =>  ip2bus_data,
        IP2Bus_Error    =>  ip2bus_errack,
			    
        Bus2IP_Addr     =>  bus2ip_addr,
        Bus2IP_Data     =>  bus2ip_data,
        Bus2IP_BE       =>  bus2ip_be,
        Bus2IP_Burst    =>  bus2ip_burst,
        Bus2IP_RdCE     =>  bus2ip_rdce,
        Bus2IP_WrCE     =>  bus2ip_wrce
        ); 
        

------------------------------------------------------------------------------------------

end imp;
