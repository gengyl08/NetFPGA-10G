-------------------------------------------------------------------------------
--  axi_ipif_interface - entity/architecture pair
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
--  **  Copyright 2010 Xilinx, Inc.                                          **
--  **  All rights reserved.                                                 **
--  **                                                                       **
--  **  This disclaimer and copyright notice must be retained as part        **
--  **  of this file at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename     : axi_ipif_interface.vhd
-- Version      : v1.00.a
-- Description  : This file contains the IPIF V3_01_a wrapper which passes 
--                generics to IPIF inorder to customize it for Ethernetlite
--                core
-- VHDL-Standard: VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--
--  axi_ethernetlite.vhd
--      \
--      \-- axi_interface.vhd
--      \-- xemac.vhd
--           \
--           \-- mdio_if.vhd
--           \-- emac_dpram.vhd                     
--           \    \                     
--           \    \-- RAMB16_S4_S36
--           \                          
--           \    
--           \-- emac.vhd                     
--                \                     
--                \-- MacAddrRAM                   
--                \-- receive.vhd
--                \      rx_statemachine.vhd
--                \      rx_intrfce.vhd
--                \         async_fifo_fg.vhd
--                \      crcgenrx.vhd
--                \                     
--                \-- transmit.vhd
--                       crcgentx.vhd
--                          crcnibshiftreg
--                       tx_intrfce.vhd
--                          async_fifo_fg.vhd
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
-- Author:    PVK
-- History:    
-- PVK        06/07/2010     First Version
-- ^^^^^^
-- First version.  
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
library ieee;
use ieee.std_logic_1164.all;


-------------------------------------------------------------------------------
-- axi_lite_ipif_v1_00_a library is used for axi_lite_ipif_v1_00_a 
-- component declarations
-------------------------------------------------------------------------------
library axi_lite_ipif_v1_00_a;
use axi_lite_ipif_v1_00_a.all;


-------------------------------------------------------------------------------
-- axi_slave_burst_v1_00_a library is used for axi_slave_burst_v1_00_a 
-- component declarations
-------------------------------------------------------------------------------
library axi_slave_burst_v1_00_a;
use axi_slave_burst_v1_00_a.all;

-------------------------------------------------------------------------------
-- proc common package of the proc common library is used for different 
-- function declarations
-------------------------------------------------------------------------------
library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.ipif_pkg.all;

-------------------------------------------------------------------------------
-- Definition of Generics:
-------------------------------------------------------------------------------
-- C_FAMILY               -- Target device family 
-- C_SAXI_CLK_PERIOD_PS   -- The period of the AXI clock in ps
-- C_SAXI_AWIDTH          -- Width of the AXI Address Bus
-- C_SAXI_DWIDTH          -- Width of the AXI Data Bus
-- C_SAXI_P2P             -- Optimize slave interface(axiv46_slave_single)
--                           for a point to point connection
-- C_SAXI_MID_WIDTH       -- The width of the Master ID bus
--                           This is set to log2(C_SAXI_NUM_MASTERS)
-- C_SAXI_NUM_MASTERS     -- The number of Master Devices connected to the AXI
-- C_SAXI_NATIVE_DWIDTH   -- Width of slave data bus
-- C_SAXI_SUPPORT_BURSTS  -- Enable AXI Burst support
-- C_SAXI_SMALLEST_MASTER -- AXI smallest master datawidth
-- C_BASEADDR             -- Base Address of this device
-- C_HIGHADDR             -- High Address of this device 
--                           (using word addressing for each byte)
-------------------------------------------------------------------------------
-- Definition of Ports:
--
-- AXI Interface
--   System signals
--     SAXI_Clk           -- AXI clock                                                  
--     SAXI_Rst           -- AXI Reset                                               
--   Bus Slave signals   
--     AXI_ABus           -- AXI address bus                                             
--     AXI_PAValid        -- AXI primary address valid indicator
--     AXI_masterID       -- AXI current master identifier
--     AXI_RNW            -- AXI read not write                                           
--     AXI_BE             -- AXI byte enables                                              
--     AXI_size           -- AXI transfer size
--     AXI_type           -- AXI transfer type
--     AXI_wrDBus         -- AXI Write Data Bus
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
--     AXI_UABus          -- AXI upper address bus
--     AXI_SAValid        -- AXI secondary address valid indicator
--     AXI_rdPrim         -- AXI secondary to primary read request indicator
--     AXI_wrPrim         -- AXI secondary to primary write request indicator
--     AXI_abort          -- AXI abort bus request indicator
--     AXI_busLock        -- AXI bus lock
--     AXI_MSize          -- AXI master data bus size
--     AXI_lockErr        -- AXI lock error indicator
--     AXI_wrBurst        -- AXI burst write transfer indicator
--     AXI_rdBurst        -- AXI burst read transfer indicator
--     AXI_wrPendReq      -- AXI pending write bus request indicator
--     AXI_rdPendReq      -- AXI pending read bus request indicator
--     AXI_wrPendPri      -- AXI pending write request priority 
--     AXI_rdPendPri      -- AXI pending read request priority
--     AXI_reqPri         -- AXI current request priority
--     AXI_TAttribute     -- AXI Transfer Attribute bus
--   Unused Slave Response signals
--     Sl_wrBTerm         -- Slave terminate write burst transfer
--     Sl_rdWdAddr        -- Slave read word address
--     Sl_rdBTerm         -- Slave terminate read burst transfer
--     Sl_MIRQ            -- Slave interrupt indicator
--                 
--   IPIC signals   
--     Bus2IP_Clk         -- Bus to IP clock
--     Bus2IP_Reset       -- Bus to IP reset
--     Bus2IP_Data        -- Bus to IP data
--     Bus2IP_Addr        -- Bus to IP address
--     Bus2IP_RdCE        -- Bus to IP read chip enable
--     Bus2IP_WrCE        -- Bus to IP write chip enable
--     Bus2IP_BE          -- Bus to IP byte enables
--     Bus2IP_Burst       -- Bus to IP burst indicator
--     Bus2IP_WrReq       -- Bus to IP write request
--     Bus2IP_RdReq       -- Bus to IP read request
--     IP2Bus_Data        -- IP  to Bus data 
--     IP2Bus_AddrAck     -- IP  to Bus address ack
--     IP2Bus_WrAck       -- IP  to Bus write data ack
--     IP2Bus_RdAck       -- IP  to Bus read data ack
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity axi_ipif_interface is
  generic
  (
        C_FAMILY                : string  := "virtex6";
        C_S_AXI_ADDR_WIDTH      : integer := 32;
        C_S_AXI_DATA_WIDTH      : integer := 32;
        C_S_AXI_SUPPORT_BURSTS  : integer := 0;
        C_S_AXI_ID_WIDTH        : integer := 3;
        C_BASEADDR              : std_logic_vector := X"FFFFFFFF";
        C_HIGHADDR              : std_logic_vector := X"00000000"

  );
  port
  (


--   -- AXI Global System Signals
       S_AXI_ACLK    : in  std_logic;
       S_AXI_ARESETN : in  std_logic;
--   -- AXI Write Address Channel Signals
       S_AXI_AWID    : in  std_logic_vector((C_S_AXI_ID_WIDTH-1) downto 0);
       S_AXI_AWADDR  : in  std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
       S_AXI_AWLEN   : in  std_logic_vector(7 downto 0);
       S_AXI_AWSIZE  : in  std_logic_vector(2 downto 0);
       S_AXI_AWBURST : in  std_logic_vector(1 downto 0);
       S_AXI_AWCACHE : in  std_logic_vector(3 downto 0);
       S_AXI_AWVALID : in  std_logic;
       S_AXI_AWREADY : out std_logic;
--   -- AXI Write Channel Signals
       S_AXI_WDATA   : in  std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
       S_AXI_WSTRB   : in  std_logic_vector
                               (((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
       S_AXI_WLAST   : in  std_logic;
       S_AXI_WVALID  : in  std_logic;
       S_AXI_WREADY  : out std_logic;
--   -- AXI Write Response Channel Signals
       S_AXI_BID     : out std_logic_vector((C_S_AXI_ID_WIDTH-1) downto 0);
       S_AXI_BRESP   : out std_logic_vector(1 downto 0);
       S_AXI_BVALID  : out std_logic;
       S_AXI_BREADY  : in  std_logic;
--   -- AXI Read Address Channel Signals
       S_AXI_ARID    : in  std_logic_vector((C_S_AXI_ID_WIDTH-1) downto 0);
       S_AXI_ARADDR  : in  std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
       S_AXI_ARLEN   : in  std_logic_vector(7 downto 0);
       S_AXI_ARSIZE  : in  std_logic_vector(2 downto 0);
       S_AXI_ARBURST : in  std_logic_vector(1 downto 0);
       S_AXI_ARCACHE : in  std_logic_vector(3 downto 0);
       S_AXI_ARVALID : in  std_logic;
       S_AXI_ARREADY : out std_logic;
--   -- AXI Read Data Channel Signals
       S_AXI_RID     : out std_logic_vector((C_S_AXI_ID_WIDTH-1) downto 0);
       S_AXI_RDATA   : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
       S_AXI_RRESP   : out std_logic_vector(1 downto 0);
       S_AXI_RLAST   : out std_logic;
       S_AXI_RVALID  : out std_logic;
       S_AXI_RREADY  : in  std_logic;


      -- Controls to the IP/IPIF modules
       Bus2IP_Clk    : out std_logic;
       Bus2IP_Resetn : out std_logic;
       IP2Bus_Data   : in  std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0 );
       IP2Bus_WrAck  : in  std_logic;
       IP2Bus_RdAck  : in  std_logic;
       IP2Bus_AddrAck: in  std_logic;
       IP2Bus_Error  : in  std_logic;

       Bus2IP_Addr   : out std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
       Bus2IP_Data   : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
       Bus2IP_RNW    : out std_logic;
       Bus2IP_BE    : out std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1)downto 0);
       Bus2IP_Burst  : out std_logic;
       Bus2IP_BurstLength: out std_logic_vector(7 downto 0);
       Bus2IP_WrReq  : out std_logic;
       Bus2IP_RdReq  : out std_logic;
       Bus2IP_CS     : out std_logic;
       Bus2IP_RdCE   : out std_logic;
       Bus2IP_WrCE   : out std_logic;
       Type_of_xfer  : out std_logic

        );
end entity axi_ipif_interface;


-------------------------------------------------------------------------------
-- architecture
-------------------------------------------------------------------------------

architecture imp of axi_ipif_interface is

constant AXI_ARD_NUM_CE_ARRAY         : INTEGER_ARRAY_TYPE := (0 => 1);

constant C_S_AXI_SUPPORTS_WRITE       : integer := 1; 
constant C_S_AXI_SUPPORTS_READ    : integer := 1; 
constant C_INCLUDE_BURST_CACHELN_SUPPORT  : integer := 0;

constant C_RDATA_FIFO_DEPTH           : integer := 32;
--constant C_RDATA_FIFO_DEPTH           : integer := 16;
constant C_INCLUDE_TIMEOUT_CNT    : integer := 0;
constant C_ALIGN_BE_RDADDR        : integer := 1; 

constant ZERO_ADDR_PAD         : std_logic_vector(64-C_S_AXI_ADDR_WIDTH-1 downto 0)
                                 := (others => '0');
 
constant AXI_ARD_ADDR_RANGE_ARRAY  : SLV64_ARRAY_TYPE :=
                                 (ZERO_ADDR_PAD & C_BASEADDR, 
                                  ZERO_ADDR_PAD & C_HIGHADDR);

-------------------  Constant Declaration Section BEGIN -----------------------


constant ARD_ADDR_RANGE_ARRAY  : SLV64_ARRAY_TYPE :=
                                 (ZERO_ADDR_PAD & C_BASEADDR, 
                                  ZERO_ADDR_PAD & C_HIGHADDR);
constant ARD_NUM_CE_ARRAY      : INTEGER_ARRAY_TYPE := (0 => 1);


  constant AXI_MIN_SIZE       : std_logic_vector(31 downto 0) := X"00001FFF";
  constant USE_WSTRB          : integer := 1;
  constant DPHASE_TIMEOUT     : integer := 0;



      
signal bus2ip_cs_i            : std_logic_vector
                                (((AXI_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0 );
signal bus2ip_rdce_i          : std_logic_vector
                              (calc_num_ce(AXI_ARD_NUM_CE_ARRAY)-1 downto 0);
signal bus2ip_wrce_i          : std_logic_vector
                              (calc_num_ce(AXI_ARD_NUM_CE_ARRAY)-1 downto 0);

    
-------------------  Constant Declaration Section END -------------------------
signal ssp1_Bus2IP_CE  :std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal ssp1_Bus2IP_RdCE:std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal ssp1_Bus2IP_WrCE:std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
-------------------------------------------------------------------------------

begin

   -------------------------------------------------------------------------
   -- AXI_LITE_GEN : AXI4-Lite interface to AXI if C_S_AXI_SUPPORT_BURSTS = 0
   -------------------------------------------------------------------------
   AXI_LITE_GEN: if C_S_AXI_SUPPORT_BURSTS = 0 generate
   begin
      --------------------------------------------------------------------------
      -- Instantiate AXI lite IPIF
      --------------------------------------------------------------------------
      AXI_LITE_IPIF_I : entity axi_lite_ipif_v1_00_a.axi_lite_ipif
        generic map
         (
          C_S_AXI_ADDR_WIDTH        => C_S_AXI_ADDR_WIDTH,
          C_S_AXI_DATA_WIDTH        => C_S_AXI_DATA_WIDTH,
          C_S_AXI_MIN_SIZE          => AXI_MIN_SIZE,
          C_USE_WSTRB               => USE_WSTRB,
          C_DPHASE_TIMEOUT          => DPHASE_TIMEOUT,
          C_ARD_ADDR_RANGE_ARRAY    => AXI_ARD_ADDR_RANGE_ARRAY,
          C_ARD_NUM_CE_ARRAY        => AXI_ARD_NUM_CE_ARRAY,
          C_FAMILY                  => C_FAMILY
         )
       port map
         (
          S_AXI_ACLK       => S_AXI_ACLK,
          S_AXI_ARESETN    => S_AXI_ARESETN,
          S_AXI_AWADDR     => S_AXI_AWADDR,
          S_AXI_AWVALID    => S_AXI_AWVALID,
          S_AXI_AWREADY    => S_AXI_AWREADY,
          S_AXI_WDATA      => S_AXI_WDATA,
          S_AXI_WSTRB      => S_AXI_WSTRB,
          S_AXI_WVALID     => S_AXI_WVALID,
          S_AXI_WREADY     => S_AXI_WREADY,
          S_AXI_BRESP      => S_AXI_BRESP,
          S_AXI_BVALID     => S_AXI_BVALID,
          S_AXI_BREADY     => S_AXI_BREADY,
          S_AXI_ARADDR     => S_AXI_ARADDR,
          S_AXI_ARVALID    => S_AXI_ARVALID,
          S_AXI_ARREADY    => S_AXI_ARREADY,
          S_AXI_RDATA      => S_AXI_RDATA,
          S_AXI_RRESP      => S_AXI_RRESP,
          S_AXI_RVALID     => S_AXI_RVALID,
          S_AXI_RREADY     => S_AXI_RREADY,
       
       -- IP Interconnect (IPIC) port signals 
          Bus2IP_Clk       => open,
          Bus2IP_Resetn    => open,
          Bus2IP_Addr      => bus2ip_addr,
          Bus2IP_Data      => bus2ip_data,
          Bus2IP_RNW       => bus2ip_rnw,
          Bus2IP_BE        => bus2ip_be,
          Bus2IP_CS        => bus2ip_cs_i,
          Bus2IP_RdCE      => bus2ip_rdce_i,
          Bus2IP_WrCE      => bus2ip_wrce_i,
          IP2Bus_Data      => ip2bus_data,
          IP2Bus_WrAck     => ip2bus_wrack,
          IP2Bus_RdAck     => ip2bus_rdack,
          IP2Bus_Error     => '0'
         );
         
      bus2ip_burst <= '0'; 
      Bus2IP_RdReq <= bus2ip_rdce_i(0);
      Bus2IP_WrReq <= bus2ip_wrce_i(0);
      S_AXI_BRESP <= (others=>'0');
      S_AXI_BID   <= S_AXI_AWID;
      S_AXI_RLAST <= '1';
      --S_AXI_RID   <= S_AXI_ARID;


  --  -----------------------------------------------------------------------
  --  Process WRITE_RESPONSE_P to generate Write Response valid
  --  -----------------------------------------------------------------------
      WRITE_RESP_P: process (S_AXI_ACLK) is
      begin
          if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
              if (S_AXI_ARESETN='0') then
                  S_AXI_RID <= (others=>'0');
              elsif (S_AXI_ARVALID = '1') then   
                  S_AXI_RID <= S_AXI_ARID;
              end if;
          end if;
      end process WRITE_RESP_P;

   end generate AXI_LITE_GEN; 

   -------------------------------------------------------------------------
   -- AXI_MM_GEN : AXI4-MM interface to AXI if C_S_AXI_SUPPORT_BURSTS = 1
   -------------------------------------------------------------------------
   AXI_MM_GEN: if C_S_AXI_SUPPORT_BURSTS = 1 generate
   begin

I_AXI_SLAVE_BURST_IPIF: entity axi_slave_burst_v1_00_a.axi_slave_burst
  generic map (
  
  ---- AXI Parameters
        C_ARD_NUM_CE_ARRAY          => AXI_ARD_NUM_CE_ARRAY,                            
        C_S_AXI_ADDR_WIDTH          => C_S_AXI_ADDR_WIDTH,  
        C_S_AXI_DATA_WIDTH          => C_S_AXI_DATA_WIDTH,                     

        C_ARD_ADDR_RANGE_ARRAY      => AXI_ARD_ADDR_RANGE_ARRAY,
        C_ALIGN_BE_RDADDR           => C_ALIGN_BE_RDADDR    ,

        C_RDATA_FIFO_DEPTH          => C_RDATA_FIFO_DEPTH,                                      
        C_INCLUDE_TIMEOUT_CNT       => C_INCLUDE_TIMEOUT_CNT,                               
        C_S_AXI_SUPPORTS_WRITE      => C_S_AXI_SUPPORTS_WRITE,  
        C_S_AXI_SUPPORTS_READ       => C_S_AXI_SUPPORTS_READ,   
        C_S_AXI_ID_WIDTH            => C_S_AXI_ID_WIDTH,
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
        S_AXI_AWLOCK    =>  (others=>'0'),--S_AXI_AWLOCK,
        S_AXI_AWCACHE   =>  S_AXI_AWCACHE,
        S_AXI_AWPROT    =>  (others=>'0'),
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
        S_AXI_ARLOCK    =>  (others=>'0'),--S_AXI_ARLOCK,                                       
        S_AXI_ARCACHE   =>  S_AXI_ARCACHE,                                      
        S_AXI_ARPROT    =>  (others=>'0'),--S_AXI_ARPROT,                                       
        S_AXI_ARVALID   =>  S_AXI_ARVALID,
        S_AXI_ARREADY   =>  S_AXI_ARREADY,                                              
                                                    
        S_AXI_RID       =>  S_AXI_RID,                                      
        S_AXI_RDATA     =>  S_AXI_RDATA,                                        
        S_AXI_RRESP     =>  S_AXI_RRESP,                                        
        S_AXI_RLAST     =>  S_AXI_RLAST,                                        
        S_AXI_RVALID    =>  S_AXI_RVALID,                                       
        S_AXI_RREADY    =>  S_AXI_RREADY,                                       
                                                                
           -- S_AXI_CSYSREQ   =>  S_AXI_MEM_CSYSREQ,                                                
           -- S_AXI_CSYSACK   =>  S_AXI_MEM_CSYSACK,                                                
           -- S_AXI_CACTIVE   =>  S_AXI_MEM_CACTIVE,    
            
-- IP Interconnect (IPIC) port signals ------------------------------------                                                     
      -- Controls to the IP/IPIF modules
            -- IP Interconnect (IPIC) port signals
            Bus2IP_Clk           => open,
            Bus2IP_Resetn         => open,

            IP2Bus_Data          => ip2bus_data,
            IP2Bus_WrAck         => ip2bus_wrack,
            IP2Bus_RdAck         => ip2bus_rdack,
            IP2Bus_AddrAck       => ip2bus_addrack,
            IP2Bus_Error         => IP2Bus_Error,

            Bus2IP_Addr          => bus2ip_addr,
            Bus2IP_Data          => bus2ip_data,
            Bus2IP_RNW           => bus2ip_rnw,
            Bus2IP_BE            => bus2ip_be,
            Bus2IP_Burst         => bus2ip_burst,
            --Bus2IP_AddrBurstLength => bus2ip_burstlength,
            Bus2IP_BurstLength   => bus2ip_burstlength,
            Bus2IP_RdReq         => Bus2IP_RdReq,
            Bus2IP_WrReq         => Bus2IP_WrReq,
            Bus2IP_CS            => bus2ip_cs_i,
            Bus2IP_RdCE          => bus2ip_rdce_i,
            Bus2IP_WrCE          => bus2ip_wrce_i,
            Type_of_xfer         => Type_of_xfer
        ); 

   end generate AXI_MM_GEN; 


Bus2IP_CS    <= bus2ip_cs_i(0);
Bus2IP_RdCE  <= bus2ip_rdce_i(0);
Bus2IP_WrCE  <= bus2ip_wrce_i(0);



end architecture imp;