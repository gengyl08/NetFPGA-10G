------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  Module:
--          mdio_ipif
--
--  Description:
--          MDIO engine IP interface
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
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- axi_ethernetlite_v1_00_a library is used for axi_ethernetlite_v1_00_a
-- component declarations
-------------------------------------------------------------------------------
library nf10_mdio_v1_00_a;
use nf10_mdio_v1_00_a.all;

-------------------------------------------------------------------------------
-- proc common package of the proc common library is used for different
-- function declarations
-------------------------------------------------------------------------------
library proc_common_v3_00_a;
use proc_common_v3_00_a.all;
use proc_common_v3_00_a.family.all;

-------------------------------------------------------------------------------
-- Vcomponents from unisim library is used for FIFO instatiation
-- function declarations
-------------------------------------------------------------------------------
library unisim;
use unisim.Vcomponents.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity mdio_ipif is
  generic (
    C_FAMILY                : string := "virtex6";
    C_BASEADDR              : std_logic_vector := X"60000000";
                                     --  Assigned Base Address for
                                     --  this device (system byte address)
    C_HIGHADDR              : std_logic_vector := X"60003fff";
                                     -- Maximum Address for this device (system
                                     -- byte address xxxx3fff)
                                     -- (using word addressing for each byte)

    C_S_AXI_ADDR_WIDTH      : integer := 32;
    C_S_AXI_DATA_WIDTH      : integer := 32;
    C_S_AXI_ACLK_PERIOD_PS  : integer := 10000;
    C_DUPLEX                : integer := 1; -- 1 = full duplex, 0 = half duplex
    C_RX_PING_PONG          : integer := 0; -- 1 = ping-pong memory used for
                                            --     receive buffer
    C_TX_PING_PONG          : integer := 0; -- 1 = ping-pong memory used for
                                            --     transmit buffer
    C_INCLUDE_MDIO          : integer := 1; -- 1 = Include MDIO interface
                                            -- 0 = No MDIO interface
    NODE_MAC                : bit_vector := x"00005e00FACE"
                                            --  power up defaul MAC address
    );
  port (
    Clk           : in  std_logic;
    Rst           : in  std_logic;
    IP2INTC_Irpt  : out std_logic;


    -- Controls to the IP/IPIF modules
    IP2Bus_Data   : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0 );
    IP2Bus_Error  : out std_logic;
    Bus2IP_Addr   : in  std_logic_vector(12 downto 0);
    Bus2IP_Data   : in  std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
    Bus2IP_BE     : in  std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1)downto 0);
    Bus2IP_RdCE   : in  std_logic;
    Bus2IP_WrCE   : in  std_logic;
    Bus2IP_Burst  : in  std_logic;

    -- MDIO Interface
    PHY_MDIO_I    : in  std_logic;
    PHY_MDIO_O    : out std_logic;
    PHY_MDIO_T    : out std_logic;
    PHY_MDC       : out std_logic
   );

end mdio_ipif;


architecture imp of mdio_ipif is


-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
constant MDIO_CNT         : integer := ((200000/C_S_AXI_ACLK_PERIOD_PS)+1);
constant IP2BUS_DATA_ZERO : std_logic_vector(0 to 31) := X"00000000";


-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------
signal reg_access             : std_logic;
signal reg_en                 : std_logic;
signal mdio_data_out          : std_logic_vector(31 downto 0);
signal mdio_reg_en            : std_logic;
signal reg_access_d1          : std_logic;
signal reg_access_i           : std_logic;

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
component SRL16E
    generic (
      INIT : bit_vector := X"0000"
      );

  port  (
    Q   : out std_logic; --[out]
    A0  : in  std_logic; --[in]
    A1  : in  std_logic; --[in]
    A2  : in  std_logic; --[in]
    A3  : in  std_logic; --[in]
    CE  : in  std_logic; --[in]
    CLK : in  std_logic; --[in]
    D   : in  std_logic  --[in]
  );
end component;


component FDR
  port (
    Q : out std_logic;
    C : in std_logic;
    D : in std_logic;
    R : in std_logic
  );
end component;

component FDRE
  port (
    Q  : out std_logic;
    C  : in std_logic;
    CE : in std_logic;
    D  : in std_logic;
    R  : in std_logic
  );
end component;

component LUT4
   generic(INIT : bit_vector);
   port (
     O  : out std_logic;
     I0 : in std_logic;
     I1 : in std_logic;
     I2 : in std_logic;
     I3 : in std_logic
   );
end component;


begin


   IP2Bus_Error <= '0';
   IP2INTC_Irpt <= '0';

   ----------------------------------------------------------------------------
   -- IP2Bus_Data generation
   IP2BUS_DATA_GENERATE: for i in 31 downto 0 generate
      IP2Bus_Data(i) <= ((
                          (mdio_data_out(i) and     mdio_reg_en)
                         ) and reg_access) ;

   end generate IP2BUS_DATA_GENERATE;

   ----------------------------------------------------------------------------
   -- Regiter Address Decoding
   ----------------------------------------------------------------------------
   -- This process loads data from the AXI when there is a write request and
   -- the control register is enabled.
   -- Register Address Space
   -----------------------------------------
   -- **** MDIO Registers offset ****
   --       Address Register    => 0x07E4
   --       Write Data Register => 0x07E8
   --       Read Data Register  => 0x07Ec
   --       Control Register    => 0x07F0
   ------------------------------------------
   -- bus2ip_addr(12 downto 0)= axi_addr (12 downto 0)
   ----------------------------------------------------------------------------
   reg_access_i <= '1' when bus2ip_addr(10 downto 5) = "111111"
                 else '0';


   -- Register access enable
   reg_en <= reg_access_i and (not Bus2IP_Burst);
   
   ----------------------------------------------------------------------------
   -- REG_ACCESS_PROCESS
   ----------------------------------------------------------------------------
   -- Registering the reg_access to break long timing path
   ----------------------------------------------------------------------------
   REG_ACCESS_PROCESS : process (Clk)
   begin  -- process
      if (Clk'event and Clk = '1') then
         if (Rst = '1') then
            reg_access     <= '0';
            reg_access_d1  <= '0';
         elsif Bus2IP_RdCE='1' then
            reg_access     <= reg_access_i;
            reg_access_d1  <= reg_access;
         end if;
      end if;
   end process REG_ACCESS_PROCESS;
   
   ----------------------------------------------------------------------------
   -- MDIO_GEN :- Include MDIO interface if the parameter C_INCLUDE_MDIO = 1
   ----------------------------------------------------------------------------
   MDIO_GEN: if C_INCLUDE_MDIO = 1 generate
   
      signal mdio_addr_en       : std_logic;
      signal mdio_wr_data_en    : std_logic;
      signal mdio_rd_data_en    : std_logic;
      signal mdio_ctrl_en       : std_logic;
      signal mdio_clause_i      : std_logic;
      signal mdio_op_i          : std_logic_vector(1 downto 0);
      signal mdio_en_i          : std_logic;
      signal mdio_req_i         : std_logic;
      signal mdio_done_i        : std_logic;
      signal mdio_wr_data_reg   : std_logic_vector(15 downto 0);
      signal mdio_rd_data_reg   : std_logic_vector(15 downto 0);
      signal mdio_phy_addr      : std_logic_vector(4 downto 0);
      signal mdio_reg_addr      : std_logic_vector(4 downto 0);
      signal mdio_clk_i         : std_logic;
      signal clk_cnt            : integer range 0 to 63;
   begin
   
      -- MDIO reg enable
      mdio_reg_en     <= (mdio_addr_en    or 
                          mdio_wr_data_en or 
                          mdio_rd_data_en or 
                          mdio_ctrl_en       ) and (not bus2ip_burst);
                          
      -- MDIO address reg enable
      mdio_addr_en    <= reg_en and (not bus2ip_addr(4))
                                and (not bus2ip_addr(3))
                                and (    bus2ip_addr(2));

      -- MDIO write data reg enable
      mdio_wr_data_en <= reg_en and (not bus2ip_addr(4))
                                and (    bus2ip_addr(3))
                                and (not bus2ip_addr(2));

      -- MDIO read data reg enable
      mdio_rd_data_en <= reg_en and (not bus2ip_addr(4))
                                and (    bus2ip_addr(3))
                                and (    bus2ip_addr(2));

      -- MDIO controlreg enable
      mdio_ctrl_en    <= reg_en and (    bus2ip_addr(4))
                                and (not bus2ip_addr(3))
                                and (not bus2ip_addr(2));                          
   
   
      -------------------------------------------------------------------------
      -- MDIO_CTRL_REG_WR_PROCESS
      -------------------------------------------------------------------------
      -- This process loads data from the AXI when there is a write request and
      -- the MDIO control register is enabled.
      -------------------------------------------------------------------------
      MDIO_CTRL_REG_WR_PROCESS : process (Clk)
      begin  -- process
         if (Clk'event and Clk = '1') then
            if (Rst = '1') then
               mdio_en_i    <= '0';
               mdio_req_i   <= '0';
            elsif (Bus2IP_WrCE = '1' and mdio_ctrl_en= '1') then
               --  Load MDIO Control Register with AXI
               --  data if there is a write request
               --  and the control register is enabled
               mdio_en_i    <= Bus2IP_Data(3);
               mdio_req_i   <= Bus2IP_Data(0);
            -- Clear the status bit when trnasmit complete
            elsif mdio_done_i = '1' then
               mdio_req_i   <=  '0';
            end if;
         end if;
      end process MDIO_CTRL_REG_WR_PROCESS;
   
      -------------------------------------------------------------------------
      -- MDIO_ADDR_REG_WR_PROCESS
      -------------------------------------------------------------------------
      -- This process loads data from the AXI when there is a write request and
      -- the MDIO Address register is enabled.
      -------------------------------------------------------------------------
      MDIO_ADDR_REG_WR_PROCESS : process (Clk)
      begin  -- process
         if (Clk'event and Clk = '1') then
            if (Rst = '1') then 
               mdio_phy_addr <= (others =>'0');
               mdio_reg_addr <= (others =>'0');
               mdio_op_i     <= (others =>'0');
               mdio_clause_i <= '0'; 
            elsif (Bus2IP_WrCE = '1' and mdio_addr_en= '1') then               
               --  Load MDIO ADDR Register with AXI
               --  data if there is a write request
               --  and the Address register is enabled
               mdio_phy_addr <= Bus2IP_Data(9 downto 5);
               mdio_reg_addr <= Bus2IP_Data(4 downto 0);
               mdio_op_i     <= Bus2IP_Data(11 downto 10);
               mdio_clause_i <= Bus2IP_Data(12);
               
            end if;
         end if;
      end process MDIO_ADDR_REG_WR_PROCESS;
   
      -------------------------------------------------------------------------
      -- MDIO_WRITE_REG_WR_PROCESS
      -------------------------------------------------------------------------
      -- This process loads data from the AXI when there is a write request  
      -- and the MDIO Write register is enabled.
      -------------------------------------------------------------------------
      MDIO_WRITE_REG_WR_PROCESS : process (Clk)
      begin  -- process
         if (Clk'event and Clk = '1') then
            if (Rst = '1') then 
               mdio_wr_data_reg <= (others =>'0');
            elsif (Bus2IP_WrCE = '1' and mdio_wr_data_en= '1') then            
               --  Load MDIO Write Data Register with AXI
               --  data if there is a write request
               --  and the Write Data register is enabled
               mdio_wr_data_reg <= Bus2IP_Data(15 downto 0);
               
            end if;
         end if;
      end process MDIO_WRITE_REG_WR_PROCESS;
      
      -------------------------------------------------------------------------
      -- MDIO_REG_RD_PROCESS
      -------------------------------------------------------------------------
      -- This process allows MDIO register read from the AXI when there is a
      -- read request and the MDIO registers are enabled.
      -------------------------------------------------------------------------
      MDIO_REG_RD_PROCESS : process (Clk)
      begin  -- process
         if (Clk'event and Clk = '1') then
            if (Rst = '1') then
               mdio_data_out <= (others =>'0');
            elsif (Bus2IP_RdCE = '1' and mdio_addr_en= '1') then
               --  MDIO Address Register Read through AXI
               mdio_data_out(4 downto 0) <= mdio_reg_addr;
               mdio_data_out(9 downto 5) <= mdio_phy_addr;
               mdio_data_out(11 downto 10)  <= mdio_op_i;
               mdio_data_out(12)       <= mdio_clause_i;
               mdio_data_out(31  downto 13) <= (others=>'0');
            elsif (Bus2IP_RdCE = '1' and mdio_wr_data_en= '1') then
               --  MDIO Write Data Register Read through AXI
               mdio_data_out(15 downto 0) <= mdio_wr_data_reg;
               mdio_data_out(31  downto 16) <= (others=>'0');
            elsif (Bus2IP_RdCE = '1' and mdio_rd_data_en= '1') then
               --  MDIO Read Data Register Read through AXI
               mdio_data_out(15 downto 0) <= mdio_rd_data_reg;
               mdio_data_out(31 downto 16) <= (others=>'0');
            elsif (Bus2IP_RdCE = '1' and mdio_ctrl_en= '1') then
               --  MDIO Control Register Read through AXI
               mdio_data_out(0) <= mdio_req_i;
               mdio_data_out(1) <= '0';
               mdio_data_out(2) <= '0';
               mdio_data_out(3) <= mdio_en_i;
               mdio_data_out(31  downto 4) <= (others=>'0');
            --else
            --   mdio_data_out <= (others =>'0');
            end if;
         end if;
      end process MDIO_REG_RD_PROCESS;
   
      -------------------------------------------------------------------------
      -- PROCESS : MDIO_CLK_COUNTER 
      -------------------------------------------------------------------------
      -- Generating MDIO clock. The minimum period for MDC clock is 400 ns. 
      -------------------------------------------------------------------------
      MDIO_CLK_COUNTER : process(Clk)
      begin
         if (Clk'event and Clk = '1') then
            if (Rst = '1' ) then
               clk_cnt  <= MDIO_CNT;
               mdio_clk_i <= '0';
            elsif (clk_cnt = 0) then
               clk_cnt    <= MDIO_CNT;
               mdio_clk_i <= not mdio_clk_i;
            else 
               clk_cnt <= clk_cnt - 1;
            end if;
         end if;
      end process;
   
      -------------------------------------------------------------------------
      -- MDIO master interface module
      -------------------------------------------------------------------------
      MDIO_IF_I: entity nf10_mdio_v1_00_a.mdio_if
         port map (             
            Clk            => Clk       , 
            Rst            => Rst     ,
            MDIO_CLK       => mdio_clk_i       ,
            MDIO_en        => mdio_en_i        ,
            MDIO_Clause    => mdio_clause_i    ,
            MDIO_OP        => mdio_op_i        ,
            MDIO_Req       => mdio_req_i       ,
            MDIO_PHY_AD    => mdio_phy_addr    ,      
            MDIO_REG_AD    => mdio_reg_addr    ,
            MDIO_WR_DATA   => mdio_wr_data_reg ,
            MDIO_RD_DATA   => mdio_rd_data_reg ,
            PHY_MDIO_I     => PHY_MDIO_I       ,
            PHY_MDIO_O     => PHY_MDIO_O       ,
            PHY_MDIO_T     => PHY_MDIO_T       ,
            PHY_MDC        => PHY_MDC          ,
            MDIO_done      => mdio_done_i
            );          
      
   
   end generate MDIO_GEN; 

   ----------------------------------------------------------------------------
   -- NO_MDIO_GEN :- Include MDIO interface if the parameter C_INCLUDE_MDIO = 0
   ----------------------------------------------------------------------------
   NO_MDIO_GEN: if C_INCLUDE_MDIO = 0 generate
   begin

      mdio_data_out <= (others=>'0');
      mdio_reg_en   <= '0';
      PHY_MDIO_O    <= '0';
      PHY_MDIO_T    <= '1';

   end generate NO_MDIO_GEN;

end imp;



