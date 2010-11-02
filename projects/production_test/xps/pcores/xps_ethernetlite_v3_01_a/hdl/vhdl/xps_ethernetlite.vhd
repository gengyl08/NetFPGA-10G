-------------------------------------------------------------------------------
-- xps_ethernetlite - entity/architecture pair
-------------------------------------------------------------------------------
--  ***************************************************************************
--  ** DISCLAIMER OF LIABILITY                                               **
--  **                                                                       **
--  **  This file contains proprietary and confidential information of       **
--  **  Xilinx, Inc. ("Xilinx"), that is distributed under a license         **
--  **  from Xilinx, and may be used, copied and/or disclosed only           **
--  **  pursuant to the terms of a valid license agreement with Xilinx.      **
--  **                                                                       **
--  **  XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION                **
--  **  ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER           **
--  **  EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT                  **
--  **  LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,            **
--  **  MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx        **
--  **  does not warrant that functions included in the Materials will       **
--  **  meet the requirements of Licensee, or that the operation of the      **
--  **  Materials will be uninterrupted or error-free, or that defects       **
--  **  in the Materials will be corrected. Furthermore, Xilinx does         **
--  **  not warrant or make any representations regarding use, or the        **
--  **  results of the use, of the Materials in terms of correctness,        **
--  **  accuracy, reliability or otherwise.                                  **
--  **                                                                       **
--  **  Xilinx products are not designed or intended to be fail-safe,        **
--  **  or for use in any application requiring fail-safe performance,       **
--  **  such as life-support or safety devices or systems, Class III         **
--  **  medical devices, nuclear facilities, applications related to         **
--  **  the deployment of airbags, or any other applications that could      **
--  **  lead to death, personal injury or severe property or                 **
--  **  environmental damage (individually and collectively, "critical       **
--  **  applications"). Customer assumes the sole risk and liability         **
--  **  of any use of Xilinx products in critical applications,              **
--  **  subject only to applicable laws and regulations governing            **
--  **  limitations on product liability.                                    **
--  **                                                                       **
--  **  Copyright 2007, 2008, 2009 Xilinx, Inc.                              **
--  **  All rights reserved.                                                 **
--  **                                                                       **
--  **  This disclaimer and copyright notice must be retained as part        **
--  **  of this file at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:       xps_ethernetlite.vhd
-- Version:        v2.01.a
-- Description:    This is the top level wrapper file for the Ethernet
--                  Lite function It provides a 10 or 100 Mbs full or half 
--                  duplex Ethernet bus with an interface to an PLB Bus.               
-- VHDL-Standard:  VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--
--  xps_ethernetlite.vhd
--      \
--      \-- xemac.vhd
--           \
--           \-- xps_ipif_ssp1.vhd
--           \-- mdio_if.vhd
--           \-- emac_dpram.vhd                     
--           \    \                     
--           \    \-- RAMB16_S4_S36
--           \                          
--           \    
--           \-- emac.vhd                     
--                \                     
--                \                     
--                \-- receive.vhd
--                \      rx_statemachine.vhd
--                \      rx_intrfce.vhd
--                \         ethernetlite_v1_01_b_dmem_v2.edn
--                \      crcgenrx.vhd
--                \                     
--                \-- transmit.vhd
--                       crcgentx.vhd
--                          crcnibshiftreg
--                       tx_intrfce.vhd
--                          ethernetlite_v1_01_b_dmem_v2.edn
--                       tx_statemachine.vhd
--                       deferral.vhd
--                          cntr5bit.vhd
--                          defer_state.vhd
--                       bocntr.vhd
--                          lfsr16.vhd
--                       msh_cnt.vhd
--                       ld_arith_reg.vhd
--
-------------------------------------------------------------------------------
-- Author:    RSK
-- History:    
-- RSK        09/27/2008     First Version
-- ^^^^^^
-- First version of xps_ethernetlite, Based on opb_ethernetlite v1.01.b 
-- ~~~~~~
-- SK         12/04/2007     Updated new Version and free up the core
-- ^^^^^^
-- Removed the "PAY_CORE" attribute to make the core license free, 
-- no functional change in original version of xps_ethernetlite v1.00.a 
-- ~~~~~~
--  PVK       07/10/2008    Version v2.00.b
-- ^^^^^^^
--  Fixed CR:475195 (Ethernet packets with valid MAC destination address 
--  is getting dropped if the last ethernet packet contains invalid MAC 
--  address.) Modified rx_state_2.vhd to receive the valid packets properly.
-- ~~~~~~~
--  PVK       10/10/2008    Version v2.01.a
-- ^^^^^^^
--  1) Updated helper libraries proc_common_v2_00_a to proc_common_v3_00_a and
--     plbv46_slave_single_v1_00_a to plbv46_slave_single_v1_01_a.
--  2) Fixed CR:479209 - Updated the core to fix post map simulation issue.
-- ~~~~~~~
--  PVK       03/13/2009    Version v3.00.a
-- ^^^^^^^
-- 1) Fixed CR:479779 (Adding Burst capability to Core). Updated PLB slave 
--    interface from plbv46_slave_single_v1_01_a to plbv46_slave_burst_v1_01_a.
-- 2) Added local register implemention for the Ethernetlite registers.
-- 3) Added MDIO interface for PHY register access.
-- 4) Added internal loopback support to the core.
-- 5) Fixed issue with zero data padding when the frame size is less than 
--    minimum. This core will pad zeros if the frame length is less than 
--    64 byte and will trasnmit minimum 60 byte frame after padding.
-- 6) Updated the core to drop packet with frame size less than minimum packet
--    length (60 Bytes). 
-- 7) Fixed issue with IFG (Inter Frame Gap) not meeting for half duplex mode 
--    of operarion.
-- 8) Fixed issue with Packet retry in case of collision. 
-- 9) Fixed issue with core getting stuck in case of reset 
-- ~~~~~~~
--  PVK       08/06/2009    Version v3.01.a
-- ^^^^^^^
--  1) Fixed CR:527536(Tx Pong buffer cannot be used by EMAClite driver in 
--     interrupt mode). Added pong_soft_status bit in PONG control register. 
-- ~~~~~~~
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                                "C_*" 
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
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------
-- xps_ethernetlite_v3_01_a library is used for xps_ethernetlite_v3_01_a 
-- component declarations
-------------------------------------------------------------------------------
library xps_ethernetlite_v3_01_a;
use xps_ethernetlite_v3_01_a.mac_pkg.all;
use xps_ethernetlite_v3_01_a.all;

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
-- Definition of Generics:
-------------------------------------------------------------------------------
-- 
-- C_FAMILY                    -- Target device family 
-- C_BASEADDR                  -- Base Address of this device
-- C_HIGHADDR                  -- High Address of this device 
--                                (using word addressing for each byte)
-- C_SPLB_CLK_PERIOD_PS        -- The period of the PLB clock in ps
-- C_SPLB_AWIDTH               -- Width of the PLB Address Bus
-- C_SPLB_DWIDTH               -- Width of the PLB Data Bus
-- C_SPLB_P2P                  -- Optimize slave interface
--                                for a point to point connection
-- C_SPLB_MID_WIDTH            -- The width of the Master ID bus
--                                This is set to log2(C_SPLB_NUM_MASTERS)
-- C_SPLB_NUM_MASTERS          -- The number of Master Devices connected to 
--                                the PLB
-- C_SPLB_NATIVE_DWIDTH        -- Width of slave data bus
-- C_SPLB_SUPPORT_BURSTS       -- Enable PLB Burst support
-- C_SPLB_SMALLEST_MASTER      -- PLB smallest master datawidth
--              
-- C_DUPLEX                    -- 1 = Full duplex, 0 = Half duplex
-- C_TX_PING_PONG              -- 1 = Ping-pong memory used for transmit buffer
--                                0 = Pong memory not used for transmit buffer 
-- C_RX_PING_PONG              -- 1 = Ping-pong memory used for receive buffer
--                                0 = Pong memory not used for receive buffer 
-- C_INCLUDE_MDIO              -- 1 = Include MDIO Innterface, 
--                                0 = No MDIO Interface
-- C_INCLUDE_INTERNAL_LOOPBACK -- 1 = Include Internal Loopback logic, 
--                                0 = Internal Loopback logic disabled
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Ports:
--
-- PLB Interface
--   System signals
--     SPLB_Clk           -- PLB clock                                                  
--     SPLB_Rst           -- PLB Reset                                               
--   Bus Slave signals   
--     PLB_ABus           -- PLB address bus                                             
--     PLB_PAValid        -- PLB primary address valid indicator
--     PLB_masterID       -- PLB current master identifier
--     PLB_RNW            -- PLB read not write                                           
--     PLB_BE             -- PLB byte enables                                              
--     PLB_size           -- PLB transfer size
--     PLB_type           -- PLB transfer type
--     PLB_wrDBus         -- PLB Write Data Bus
--   Slave Response signals    
--     Sl_addrAck         -- Slave address acknowledge
--     Sl_SSize           -- Slave data bus size
--     Sl_wait            -- Slave wait indicator
--     Sl_rearbitrate     -- Slave rearbitrate bus indicator
--     Sl_wrDAck          -- Slave write data acknowledge
--     Sl_wrComp          -- Slave write transfer complete indicator
--     Sl_rdDBus          -- Slave read bus                                         
--     Sl_rdDAck          -- Slave read data acknowledge
--     Sl_rdComp          -- Slave read transfer complete indicator
--     Sl_MBusy           -- Slave busy indicator
--     Sl_MWrErr          -- Slave write error indicator
--     Sl_MRdErr          -- Slave read error indicator
--   Unused Bus Slave signals
--     PLB_UABus          -- PLB upper address bus
--     PLB_SAValid        -- PLB secondary address valid indicator
--     PLB_rdPrim         -- PLB secondary to primary read request indicator
--     PLB_wrPrim         -- PLB secondary to primary write request indicator
--     PLB_abort          -- PLB abort bus request indicator
--     PLB_busLock        -- PLB bus lock
--     PLB_MSize          -- PLB master data bus size
--     PLB_lockErr        -- PLB lock error indicator
--     PLB_wrBurst        -- PLB burst write transfer indicator
--     PLB_rdBurst        -- PLB burst read transfer indicator
--     PLB_wrPendReq      -- PLB pending write bus request indicator
--     PLB_rdPendReq      -- PLB pending read bus request indicator
--     PLB_wrPendPri      -- PLB pending write request priority 
--     PLB_rdPendPri      -- PLB pending read request priority
--     PLB_reqPri         -- PLB current request priority
--     PLB_TAttribute     -- PLB Transfer Attribute bus
--   Unused Slave Response signals
--     Sl_wrBTerm         -- Slave terminate write burst transfer
--     Sl_rdWdAddr        -- Slave read word address
--     Sl_rdBTerm         -- Slave terminate read burst transfer
--     Sl_MIRQ            -- Slave interrupt indicator
--  Interrupts           
--     IP2INTC_Irpt       -- Interrupt to processor
--                 
--  Ethernet
--       PHY_tx_clk       -- Ethernet tranmit clock
--       PHY_rx_clk       -- Ethernet receive clock
--       PHY_crs          -- Ethernet carrier sense
--       PHY_dv           -- Ethernet receive data valid
--       PHY_rx_data      -- Ethernet receive data
--       PHY_col          -- Ethernet collision indicator
--       PHY_rx_er        -- Ethernet receive error
--       PHY_rst_n        -- Ethernet PHY Reset
--       PHY_tx_en        -- Ethernet transmit enable
--       PHY_tx_data      -- Ethernet transmit data
--       PHY_MDIO_I       -- Ethernet PHY MDIO data input 
--       PHY_MDIO_O       -- Ethernet PHY MDIO data output 
--       PHY_MDIO_T       -- Ethernet PHY MDIO data 3-state control
--       PHY_MDC          -- Ethernet PHY management clock
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity xps_ethernetlite is
  generic 
   (
    C_FAMILY                        : string := "virtex5";
    C_BASEADDR                      : std_logic_vector := X"FFFFFFFF";
    C_HIGHADDR                      : std_logic_vector := X"00000000";
    C_SPLB_CLK_PERIOD_PS            : integer := 10000;
    C_SPLB_AWIDTH                   : integer range 32 to 36 := 32;
    C_SPLB_DWIDTH                   : integer range 32 to 128:= 32;
    C_SPLB_P2P                      : integer := 0;
    C_SPLB_MID_WIDTH                : integer := 1;
    C_SPLB_NUM_MASTERS              : integer := 1;
    C_SPLB_NATIVE_DWIDTH            : integer range 32 to 128:= 32;
    C_SPLB_SMALLEST_MASTER          : integer range 32 to 128:= 32;
    C_SPLB_SUPPORT_BURSTS           : integer range 0 to 1:= 0;
    C_INCLUDE_MDIO                  : integer := 1; 
    C_INCLUDE_INTERNAL_LOOPBACK     : integer := 0; 
    C_DUPLEX                        : integer range 0 to 1:= 1; 
    C_TX_PING_PONG                  : integer range 0 to 1:= 0;
    C_RX_PING_PONG                  : integer range 0 to 1:= 0
    );
  port 
    (
    PHY_tx_clk      : in std_logic;
    PHY_rx_clk      : in std_logic;
    PHY_crs         : in std_logic;
    PHY_dv          : in std_logic;
    PHY_rx_data     : in std_logic_vector (3 downto 0);
    PHY_col         : in std_logic;
    PHY_rx_er       : in std_logic;
    PHY_rst_n       : out std_logic; 
    PHY_tx_en       : out std_logic;
    PHY_tx_data     : out std_logic_vector (3 downto 0);
    PHY_MDIO_I      : in  std_logic;
    PHY_MDIO_O      : out std_logic;
    PHY_MDIO_T      : out std_logic;
    PHY_MDC         : out std_logic;   
    IP2INTC_Irpt    : out std_logic;
    SPLB_Clk        : in  std_logic;
    SPLB_Rst        : in  std_logic;
    PLB_ABus        : in  std_logic_vector(0 to C_SPLB_AWIDTH-1);
    PLB_UABus       : in  std_logic_vector(0 to 31);
    PLB_PAValid     : in  std_logic;
    PLB_SAValid     : in  std_logic;
    PLB_rdPrim      : in  std_logic;
    PLB_wrPrim      : in  std_logic;
    PLB_masterID    : in  std_logic_vector(0 to C_SPLB_MID_WIDTH-1);
    PLB_abort       : in  std_logic;
    PLB_busLock     : in  std_logic;
    PLB_RNW         : in  std_logic;
    PLB_BE          : in  std_logic_vector(0 to (C_SPLB_DWIDTH/8)-1);
    PLB_MSize       : in  std_logic_vector(0 to 1);
    PLB_size        : in  std_logic_vector(0 to 3);
    PLB_type        : in  std_logic_vector(0 to 2);
    PLB_lockErr     : in  std_logic;
    PLB_wrDBus      : in  std_logic_vector(0 to C_SPLB_DWIDTH-1);
    PLB_wrBurst     : in  std_logic;
    PLB_rdBurst     : in  std_logic;
    PLB_wrPendReq   : in  std_logic;
    PLB_rdPendReq   : in  std_logic;
    PLB_wrPendPri   : in  std_logic_vector(0 to 1);
    PLB_rdPendPri   : in  std_logic_vector(0 to 1);
    PLB_reqPri      : in  std_logic_vector(0 to 1);
    PLB_TAttribute  : in  std_logic_vector(0 to 15);
    Sl_addrAck      : out std_logic;
    Sl_SSize        : out std_logic_vector(0 to 1);
    Sl_wait         : out std_logic;
    Sl_rearbitrate  : out std_logic;
    Sl_wrDAck       : out std_logic;
    Sl_wrComp       : out std_logic;
    Sl_wrBTerm      : out std_logic;
    Sl_rdDBus       : out std_logic_vector(0 to C_SPLB_DWIDTH-1);
    Sl_rdWdAddr     : out std_logic_vector(0 to 3);
    Sl_rdDAck       : out std_logic;
    Sl_rdComp       : out std_logic;
    Sl_rdBTerm      : out std_logic;
    Sl_MBusy        : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
    Sl_MWrErr       : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
    Sl_MRdErr       : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
    Sl_MIRQ         : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1)
    );
    
-- XST attributes    
attribute syn_maxfan                     : integer;
attribute syn_maxfan      of SPLB_Clk    : signal is 10000;    
attribute syn_maxfan      of SPLB_Rst    : signal is 10000;
attribute MAX_FANOUT                     : string;
attribute MAX_FANOUT      of SPLB_Clk    : signal is "10000";
attribute MAX_FANOUT      of SPLB_Rst    : signal is "10000";

attribute uselowskewlines                : STRING;
attribute uselowskewlines of PHY_tx_clk  : signal is "yes";
attribute uselowskewlines of PHY_rx_clk  : signal is "yes";

--Psfutil attributes
attribute ALERT            :   string; 
attribute HDL              :   string; 
attribute IMP_NETLIST      :   string; 
attribute IP_GROUP         :   string; 
attribute IPTYPE           :   string; 
attribute STYLE            :   string; 
attribute SIGIS            :   string; 
attribute ASSIGNMENT       :   string;
attribute ADDRESS          :   string; 
attribute PAIR             :   string; 

attribute ALERT       of  xps_ethernetlite    :  entity   is  
"This design requires design constraints to guarantee performance.\nPlease refer to the  data sheet for details.  \nThe PLB clock frequency must be greater than or equal to 50 MHz for 100 Mbs Ethernet operation and greater than or equal to 5.0 MHz for 10 Mbs Ethernet operation.";
attribute HDL         of  xps_ethernetlite    :  entity   is  "VHDL"; 
attribute IMP_NETLIST of  xps_ethernetlite    :  entity   is  "TRUE"; 
attribute IP_GROUP    of  xps_ethernetlite    :  entity   is  "LOGICORE"; 
attribute IPTYPE      of  xps_ethernetlite    :  entity   is  "PERIPHERAL"; 
attribute STYLE       of  xps_ethernetlite    :  entity   is  "MIX"; 
attribute SIGIS       of  SPLB_Clk            :  signal   is  "CLK"; 
attribute SIGIS       of  SPLB_Rst            :  signal   is  "RST"; 
attribute SIGIS       of  IP2INTC_Irpt        :  signal   is  
                                                 "INTR_EDGE_RISING";

attribute ASSIGNMENT  of  C_BASEADDR          :  constant is  "REQUIRE"; 
attribute ASSIGNMENT  of  C_HIGHADDR          :  constant is  "REQUIRE"; 
attribute ADDRESS     of  C_BASEADDR          :  constant is  "BASE";
attribute ADDRESS     of  C_HIGHADDR          :  constant is  "HIGH";
attribute PAIR        of  C_BASEADDR          :  constant is  "C_HIGHADDR";
attribute PAIR        of  C_HIGHADDR          :  constant is  "C_BASEADDR";

end xps_ethernetlite;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------  

architecture imp of xps_ethernetlite is
-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
constant NODE_MAC : bit_vector := x"00005e00FACE";
-------------------------------------------------------------------------------
--   Signal declaration Section 
-------------------------------------------------------------------------------
signal phy_rx_clk_i    : std_logic;
signal phy_tx_clk_i    : std_logic;
signal phy_rx_data_i   : std_logic_vector(3 downto 0); 
signal phy_tx_data_i   : std_logic_vector(3 downto 0);
signal phy_dv_i        : std_logic;
signal phy_rx_er_i     : std_logic;
signal phy_tx_en_i     : std_logic;
signal Loopback        : std_logic;
signal phy_rx_data_in  : std_logic_vector (3 downto 0);
signal phy_dv_in       : std_logic;
signal phy_rx_data_reg : std_logic_vector(3 downto 0);
signal phy_rx_er_reg   : std_logic;
signal phy_dv_reg      : std_logic;

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
   PHY_rst_n   <= not SPLB_Rst ;

   ----------------------------------------------------------------------------
   -- LOOPBACK_GEN :- Include MDIO interface if the parameter 
   -- C_INCLUDE_INTERNAL_LOOPBACK = 1
   ----------------------------------------------------------------------------
   LOOPBACK_GEN: if C_INCLUDE_INTERNAL_LOOPBACK = 1 generate

   signal rx_mux_clk_out  : std_logic;
   begin

      -------------------------------------------------------------------------
      -- Internal Loopback generation logic
      -------------------------------------------------------------------------
      phy_rx_data_in <=  phy_tx_data_i when Loopback = '1' else
                         phy_rx_data_reg;
      
      phy_dv_in      <=  phy_tx_en_i   when Loopback = '1' else
                         phy_dv_reg;
      
      -- No receive error is generated in internal loopback
      phy_rx_er_i    <= '0' when Loopback = '1' else
                         phy_rx_er_reg;
      
      -------------------------------------------------------------------------
      -- BUFGMUX for clock muxing 
      -------------------------------------------------------------------------
      CLOCK_MUX: BUFGMUX
        port map (
          O  => rx_mux_clk_out,  --[out]
          I0 => PHY_rx_clk,      --[in]
          I1 => PHY_tx_clk,      --[in]
          S  => Loopback         --[in]
        );
      
                         
      -- Transmit and Receive clocks         
      phy_tx_clk_i <= not(PHY_tx_clk);
      phy_rx_clk_i <= not(rx_mux_clk_out);
   
      -------------------------------------------------------------------------
      -- Registering RX signal 
      -------------------------------------------------------------------------
      DV_FF: FDR
        port map (
          Q  => phy_dv_i,             --[out]
          C  => phy_rx_clk_i,         --[in]
          D  => phy_dv_in,            --[in]
          R  => SPLB_Rst);            --[in]
      
    
      -------------------------------------------------------------------------
      -- Registering RX data input with clock mux output
      -------------------------------------------------------------------------
      RX_REG_GEN: for i in 3 downto 0 generate
      begin
         RX_FF: FDRE
           port map (
             Q  => phy_rx_data_i(i),   --[out]
             C  => phy_rx_clk_i,       --[in]
             CE => '1',                --[in]
             D  => phy_rx_data_in(i),  --[in]
             R  => SPLB_Rst);          --[in]
      
      end generate RX_REG_GEN;

   end generate LOOPBACK_GEN; 

   ----------------------------------------------------------------------------
   -- NO_LOOPBACK_GEN :- Include MDIO interface if the parameter 
   -- C_INCLUDE_INTERNAL_LOOPBACK = 0
   ----------------------------------------------------------------------------
   NO_LOOPBACK_GEN: if C_INCLUDE_INTERNAL_LOOPBACK = 0 generate
   begin

      
      -- Transmit and Receive clocks         
      phy_tx_clk_i  <= not(PHY_tx_clk);
      phy_rx_clk_i  <= not(PHY_rx_clk);
      
      phy_rx_data_i <= phy_rx_data_reg;
      phy_rx_er_i   <= phy_rx_er_reg;
      phy_dv_i      <= phy_dv_reg;
      
      

   end generate NO_LOOPBACK_GEN; 


   ----------------------------------------------------------------------------
   -- Registering the Ethernet data signals
   ----------------------------------------------------------------------------   
   IOFFS_GEN: for i in 3 downto 0 generate
   attribute IOB of RX_FF_I : label is "true";
   attribute IOB of TX_FF_I : label is "true";
   begin
      RX_FF_I: FDRE
         port map (
            Q  => phy_rx_data_reg(i), --[out]
            C  => Phy_rx_clk,         --[in]
            CE => '1',                --[in]
            D  => PHY_rx_data(i),     --[in]
            R  => SPLB_Rst);          --[in]
            
      TX_FF_I: FDRE
         port map (
            Q  => PHY_tx_data(i),     --[out]
            C  => PHY_tx_clk,         --[in]
            CE => '1',                --[in]
            D  => phy_tx_data_i(i),   --[in]
            R  => SPLB_Rst);          --[in]
          
    end generate IOFFS_GEN;


   ----------------------------------------------------------------------------
   -- Registering the Ethernet control signals
   ----------------------------------------------------------------------------   
   IOFFS_GEN2: if(true) generate 
      attribute IOB of DVD_FF : label is "true";
      attribute IOB of RER_FF : label is "true";
      attribute IOB of TEN_FF : label is "true";
      begin
         DVD_FF: FDRE
           port map (
             Q  => phy_dv_reg,      --[out]
             C  => Phy_rx_clk,      --[in]
             CE => '1',             --[in]
             D  => PHY_dv,          --[in]
             R  => SPLB_Rst);       --[in]
               
         RER_FF: FDRE
           port map (
             Q  => phy_rx_er_reg,   --[out]
             C  => Phy_rx_clk,      --[in]
             CE => '1',             --[in]
             D  => PHY_rx_er,       --[in]
             R  => SPLB_Rst);       --[in]
               
         TEN_FF: FDRE
           port map (
             Q  => PHY_tx_en,       --[out]
             C  => PHY_tx_clk,      --[in]
             CE => '1',             --[in]
             D  => PHY_tx_en_i,     --[in]
             R  => SPLB_Rst);       --[in]    
               
   end generate IOFFS_GEN2;
      
   ----------------------------------------------------------------------------
   -- XEMAC Module
   ----------------------------------------------------------------------------   
   XEMAC_I : entity xps_ethernetlite_v3_01_a.xemac
     generic map 
        (
        C_DUPLEX               => C_DUPLEX,
        C_RX_PING_PONG         => C_RX_PING_PONG,
        C_TX_PING_PONG         => C_TX_PING_PONG,
        C_INCLUDE_MDIO         => C_INCLUDE_MDIO,
        NODE_MAC               => NODE_MAC,
        C_BASEADDR             => C_BASEADDR,
        C_HIGHADDR             => C_HIGHADDR,
        C_FAMILY               => C_FAMILY,
        C_SPLB_AWIDTH          => C_SPLB_AWIDTH,
        C_SPLB_DWIDTH          => C_SPLB_DWIDTH,
        C_SPLB_P2P             => C_SPLB_P2P,
        C_SPLB_MID_WIDTH       => C_SPLB_MID_WIDTH,
        C_SPLB_NUM_MASTERS     => C_SPLB_NUM_MASTERS,
        C_SPLB_SUPPORT_BURSTS  => C_SPLB_SUPPORT_BURSTS,
        C_SPLB_SMALLEST_MASTER => C_SPLB_SMALLEST_MASTER,
        C_SPLB_CLK_PERIOD_PS   => C_SPLB_CLK_PERIOD_PS,
        C_SPLB_NATIVE_DWIDTH   => C_SPLB_NATIVE_DWIDTH        
        )
     
     port map 
        (   
        SPLB_Clk       => SPLB_Clk,
        SPLB_Rst       => SPLB_Rst,
        PLB_ABus       => PLB_ABus,
        PLB_UABus      => PLB_UABus,
        PLB_PAValid    => PLB_PAValid,
        PLB_SAValid    => PLB_SAValid,
        PLB_rdPrim     => PLB_rdPrim,
        PLB_wrPrim     => PLB_wrPrim,
        PLB_masterID   => PLB_masterID,
        PLB_abort      => PLB_abort,
        PLB_busLock    => PLB_busLock,
        PLB_RNW        => PLB_RNW,
        PLB_BE         => PLB_BE,
        PLB_MSize      => PLB_MSize,
        PLB_size       => PLB_size,
        PLB_type       => PLB_type,
        PLB_lockErr    => PLB_lockErr,
        PLB_wrDBus     => PLB_wrDBus,
        PLB_wrBurst    => PLB_wrBurst,
        PLB_rdBurst    => PLB_rdBurst,
        PLB_wrPendReq  => PLB_wrPendReq,
        PLB_rdPendReq  => PLB_rdPendReq,
        PLB_wrPendPri  => PLB_wrPendPri,
        PLB_rdPendPri  => PLB_rdPendPri,
        PLB_reqPri     => PLB_reqPri,
        PLB_TAttribute => PLB_TAttribute,
        Sl_addrAck     => Sl_addrAck,
        Sl_SSize       => Sl_SSize,
        Sl_wait        => Sl_wait,
        Sl_rearbitrate => Sl_rearbitrate,
        Sl_wrDAck      => Sl_wrDAck,
        Sl_wrComp      => Sl_wrComp,
        Sl_wrBTerm     => Sl_wrBTerm,
        Sl_rdDBus      => Sl_rdDBus,
        Sl_rdWdAddr    => Sl_rdWdAddr,
        Sl_rdDAck      => Sl_rdDAck,
        Sl_rdComp      => Sl_rdComp,
        Sl_rdBTerm     => Sl_rdBTerm,
        Sl_MBusy       => Sl_MBusy,
        Sl_MWrErr      => Sl_MWrErr,
        Sl_MRdErr      => Sl_MRdErr,
        Sl_MIRQ        => Sl_MIRQ,
        IP2INTC_Irpt   => IP2INTC_Irpt,
        PHY_tx_clk     => phy_tx_clk_i,
        PHY_rx_clk     => phy_rx_clk_i,
        PHY_crs        => PHY_crs,
        PHY_dv         => phy_dv_i,
        PHY_rx_data    => phy_rx_data_i,
        PHY_col        => PHY_col,
        PHY_rx_er      => phy_rx_er_i,
        PHY_tx_en      => PHY_tx_en_i,
        PHY_tx_data    => PHY_tx_data_i,
        PHY_MDIO_I     => PHY_MDIO_I,
        PHY_MDIO_O     => PHY_MDIO_O,
        PHY_MDIO_T     => PHY_MDIO_T,
        PHY_MDC        => PHY_MDC,
        Loopback       => Loopback 
        );
end imp;