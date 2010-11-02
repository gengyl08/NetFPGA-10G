-------------------------------------------------------------------------------
--  xps_ipif_ssp1 - entity/architecture pair
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
-- Filename:        xps_ipif_ssp1.vhd
-- 
-- Description:     
--                  This file contains the IPIF V3_01_a wrapper which passes 
--                  generics to IPIF inorder to customize it for Ethernetlite
--                  core
-- VHDL-Standard:   VHDL'93
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
-- Author:         Vaibhav
-- History:
--  RSK            11/06/06
-- ^^^^^^
--                 First Version, Based on opb_ethernetlite v1.01.b
--  ~~~~~
--  PVK       03/13/2009    Version v3.00.a
-- ^^^^^^^
--  Fixed CR:479779 (Adding Burst capability to Core) 
--  Updated plbv46_slave_burst_v1_01_a to plbv46_salve_burst_v1_01_a.
-- ~~~~~~~
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
-- plbv46_slave_burst_v1_01_a library is used for plbv46_slave_burst_v1_01_a 
-- component declarations
-------------------------------------------------------------------------------
library plbv46_slave_burst_v1_01_a;
use plbv46_slave_burst_v1_01_a.all;

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
-- C_SPLB_CLK_PERIOD_PS   -- The period of the PLB clock in ps
-- C_SPLB_AWIDTH          -- Width of the PLB Address Bus
-- C_SPLB_DWIDTH          -- Width of the PLB Data Bus
-- C_SPLB_P2P             -- Optimize slave interface(plbv46_slave_single)
--                           for a point to point connection
-- C_SPLB_MID_WIDTH       -- The width of the Master ID bus
--                           This is set to log2(C_SPLB_NUM_MASTERS)
-- C_SPLB_NUM_MASTERS     -- The number of Master Devices connected to the PLB
-- C_SPLB_NATIVE_DWIDTH   -- Width of slave data bus
-- C_SPLB_SUPPORT_BURSTS  -- Enable PLB Burst support
-- C_SPLB_SMALLEST_MASTER -- PLB smallest master datawidth
-- C_BASEADDR             -- Base Address of this device
-- C_HIGHADDR             -- High Address of this device 
--                           (using word addressing for each byte)
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
entity xps_ipif_ssp1 is
  generic
  (
        C_FAMILY              : string  := "virtex5";
        C_SPLB_AWIDTH         : integer := 32;
        C_SPLB_DWIDTH         : integer := 32;
        C_SPLB_P2P            : integer := 0;
        C_SPLB_MID_WIDTH      : integer := 3;
        C_SPLB_NUM_MASTERS    : integer := 8;
        C_SPLB_SUPPORT_BURSTS : integer := 0;
        C_SPLB_NATIVE_DWIDTH  : integer := 32;
        C_SPLB_SMALLEST_MASTER: integer := 32;
        C_BASEADDR            : std_logic_vector := X"FFFFFFFF";
        C_HIGHADDR            : std_logic_vector := X"00000000"

  );
  port
  (
        SPLB_Clk       : in  std_logic;
        SPLB_Rst       : in  std_logic;
        PLB_ABus       : in  std_logic_vector(0 to 31);
        PLB_UABus      : in  std_logic_vector(0 to 31);
        PLB_PAValid    : in  std_logic;
        PLB_SAValid    : in  std_logic;
        PLB_rdPrim     : in  std_logic;
        PLB_wrPrim     : in  std_logic;
        PLB_masterID   : in  std_logic_vector(0 to C_SPLB_MID_WIDTH-1);
        PLB_abort      : in  std_logic;
        PLB_busLock    : in  std_logic;
        PLB_RNW        : in  std_logic;
        PLB_BE         : in  std_logic_vector(0 to (C_SPLB_DWIDTH/8)-1);
        PLB_MSize      : in  std_logic_vector(0 to 1);
        PLB_size       : in  std_logic_vector(0 to 3);
        PLB_type       : in  std_logic_vector(0 to 2);
        PLB_lockErr    : in  std_logic;
        PLB_wrDBus     : in  std_logic_vector(0 to C_SPLB_DWIDTH-1);
        PLB_wrBurst    : in  std_logic;
        PLB_rdBurst    : in  std_logic;
        PLB_wrPendReq  : in  std_logic;
        PLB_rdPendReq  : in  std_logic;
        PLB_wrPendPri  : in  std_logic_vector(0 to 1);
        PLB_rdPendPri  : in  std_logic_vector(0 to 1);
        PLB_reqPri     : in  std_logic_vector(0 to 1);
        PLB_TAttribute : in  std_logic_vector(0 to 15);
        Sl_addrAck     : out std_logic;
        Sl_SSize       : out std_logic_vector(0 to 1);
        Sl_wait        : out std_logic;
        Sl_rearbitrate : out std_logic;
        Sl_wrDAck      : out std_logic;
        Sl_wrComp      : out std_logic;
        Sl_wrBTerm     : out std_logic;
        Sl_rdDBus      : out std_logic_vector(0 to C_SPLB_DWIDTH-1);
        Sl_rdWdAddr    : out std_logic_vector(0 to 3);
        Sl_rdDAck      : out std_logic;
        Sl_rdComp      : out std_logic;
        Sl_rdBTerm     : out std_logic;
        Sl_MBusy       : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
        Sl_MWrErr      : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
        Sl_MRdErr      : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
        Sl_MIRQ        : out std_logic_vector (0 to C_SPLB_NUM_MASTERS-1);
        Bus2IP_Clk     : out std_logic;        
        Bus2IP_Reset   : out std_logic;
        IP2Bus_Data    : in  std_logic_vector(0 to C_SPLB_NATIVE_DWIDTH -1);
        Bus2IP_Data    : out std_logic_vector(0 to C_SPLB_NATIVE_DWIDTH -1);
        Bus2IP_Addr    : out std_logic_vector(0 to C_SPLB_AWIDTH-1);
        Bus2IP_RdCE    : out std_logic;
        Bus2IP_WrCE    : out std_logic;
        Bus2IP_BE      : out std_logic_vector(0 to (C_SPLB_NATIVE_DWIDTH/8)-1);
        Bus2IP_Burst   : out std_logic;
        Bus2IP_WrReq   : out std_logic;
        Bus2IP_RdReq   : out std_logic;
        IP2Bus_AddrAck : in  std_logic;
        IP2Bus_WrAck   : in  std_logic;
        IP2Bus_RdAck   : in  std_logic
        );
end entity xps_ipif_ssp1;


-------------------------------------------------------------------------------
-- architecture
-------------------------------------------------------------------------------

architecture imp of xps_ipif_ssp1 is

-------------------------------------------------------------------------------
-- Function: get_wrbuf_depth
-- Purpose :  Calculate write buffer depth based on input parameter
-------------------------------------------------------------------------------

function get_wrbuf_depth return integer is
variable wr_buffer_depth_v : integer range 0 to 16;
begin
    if C_SPLB_SUPPORT_BURSTS = 1 then
      wr_buffer_depth_v := 16;
    else
      wr_buffer_depth_v := 0;
    end if;
    return wr_buffer_depth_v;
    
end function get_wrbuf_depth;

-------------------  Constant Declaration Section BEGIN -----------------------
constant WR_BUFFER_DEPTH     : integer  := get_wrbuf_depth;
constant CACHLINE_ADDR_MODE  : integer  := 0;


constant ZERO_ADDR_PAD         : std_logic_vector(0 to 64-C_SPLB_AWIDTH-1)
                                 := (others => '0');
constant PIPELINE_MODEL        : integer   := 4;  
constant USER_NUM_CE           : integer     := 1;
constant ARD_ID_ARRAY          : INTEGER_ARRAY_TYPE := (0 => USER_00);
constant POSTED_ZEROS          : std_logic_vector(0 to ARD_ID_ARRAY'length-1)
                                 := (others => '0');
constant ARD_ADDR_RANGE_ARRAY  : SLV64_ARRAY_TYPE :=
                                 (ZERO_ADDR_PAD & C_BASEADDR, 
                                  ZERO_ADDR_PAD & C_HIGHADDR);
constant ARD_NUM_CE_ARRAY      : INTEGER_ARRAY_TYPE := (0 => 1);

-- No dependent properties
constant ARD_DEPENDENT_PROPS_ARRAY: DEPENDENT_PROPS_ARRAY_TYPE 
                                    :=  (0 => (others => 0));

constant IP_INTR_MODE_ARRAY       : INTEGER_ARRAY_TYPE :=  (0=>1);
      
-- Do not include MIR
constant DEV_MIR_ENABLE           : integer := 0;
constant DEV_BLK_ID               : integer := 1;
-- Burst support generics
constant INCLUDE_BURST_SUPPORT    : integer   := 0; 
-- need both the address counter and the write burst buffer
constant INCLUDE_ADDR_CNTR        : integer := 0;
constant INCLUDE_WR_BUF           : integer := 0;

constant ZERO_DATA                : std_logic_vector
                                    (0 to C_SPLB_NATIVE_DWIDTH -1)
                                    :=(others => '0');
constant ZERO_INTR                : std_logic_vector
                                    (0 to IP_INTR_MODE_ARRAY'length-1)
                                    := (others => '0');
    
-------------------  Constant Declaration Section END -------------------------
signal ssp1_Bus2IP_CE  :std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal ssp1_Bus2IP_RdCE:std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal ssp1_Bus2IP_WrCE:std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
-------------------------------------------------------------------------------

begin

   Bus2IP_RdCE <= ssp1_Bus2IP_RdCE(0);
   Bus2IP_WrCE <= ssp1_Bus2IP_WrCE(0);

   ----------------------------------------------------------------------------
   -- PLBv46 Slave Burst Interface 
   ----------------------------------------------------------------------------
   PLBV46_BURST_I : entity plbv46_slave_burst_v1_01_a.plbv46_slave_burst
      generic map (
         C_ARD_ADDR_RANGE_ARRAY    =>  ARD_ADDR_RANGE_ARRAY,
         C_ARD_NUM_CE_ARRAY        =>  ARD_NUM_CE_ARRAY,
         C_SPLB_P2P                =>  C_SPLB_P2P,
         C_CACHLINE_ADDR_MODE      =>  CACHLINE_ADDR_MODE,      
         C_WR_BUFFER_DEPTH         =>  WR_BUFFER_DEPTH,
         C_SPLB_MID_WIDTH          =>  C_SPLB_MID_WIDTH,      
         C_SPLB_NUM_MASTERS        =>  C_SPLB_NUM_MASTERS,
         C_SPLB_AWIDTH             =>  C_SPLB_AWIDTH,
         C_SPLB_DWIDTH             =>  C_SPLB_DWIDTH,
         C_SIPIF_DWIDTH            =>  C_SPLB_NATIVE_DWIDTH,
         C_SPLB_SMALLEST_MASTER    =>  C_SPLB_SMALLEST_MASTER,
         C_BURSTLENGTH_TYPE        =>  1,     
         C_FAMILY                  =>  C_FAMILY      

       )
       
     port map(
         -- System signals
         SPLB_Clk               => SPLB_Clk,
         SPLB_Rst               => SPLB_Rst,
         -- Bus Slave signals
         PLB_ABus               => PLB_ABus,
         PLB_UABus              => PLB_UABus,
         PLB_PAValid            => PLB_PAValid,
         PLB_SAValid            => PLB_SAValid,
         PLB_rdPrim             => PLB_rdPrim,
         PLB_wrPrim             => PLB_wrPrim,
         PLB_masterID           => PLB_masterID,
         PLB_abort              => PLB_abort,
         PLB_busLock            => PLB_busLock,
         PLB_RNW                => PLB_RNW,
         PLB_BE                 => PLB_BE,
         PLB_MSize              => PLB_MSize,
         PLB_size               => PLB_size,
         PLB_type               => PLB_type,
         PLB_lockErr            => PLB_lockErr,
         PLB_wrDBus             => PLB_wrDBus,
         PLB_wrBurst            => PLB_wrBurst,
         PLB_rdBurst            => PLB_rdBurst,
         PLB_wrPendReq          => PLB_wrPendReq,
         PLB_rdPendReq          => PLB_rdPendReq,
         PLB_wrPendPri          => PLB_wrPendPri,
         PLB_rdPendPri          => PLB_rdPendPri,
         PLB_reqPri             => PLB_reqPri,
         PLB_TAttribute         => PLB_TAttribute,
         -- Slave Responce Signals
         Sl_addrAck             => Sl_addrAck,
         Sl_SSize               => Sl_SSize,
         Sl_wait                => Sl_wait,
         Sl_rearbitrate         => Sl_rearbitrate,
         Sl_wrDAck              => Sl_wrDAck,
         Sl_wrComp              => Sl_wrComp,
         Sl_wrBTerm             => Sl_wrBTerm,
         Sl_rdDBus              => Sl_rdDBus,
         Sl_rdWdAddr            => Sl_rdWdAddr,
         Sl_rdDAck              => Sl_rdDAck,
         Sl_rdComp              => Sl_rdComp,
         Sl_rdBTerm             => Sl_rdBTerm,
         Sl_MBusy               => Sl_MBusy,
         Sl_MWrErr              => Sl_MWrErr,
         Sl_MRdErr              => Sl_MRdErr,
         Sl_MIRQ                => Sl_MIRQ,
         -- IP Interconnect (IPIC) port signals
         Bus2IP_Clk             => Bus2IP_Clk,
         Bus2IP_Reset           => Bus2IP_Reset,
         IP2Bus_Data            => IP2Bus_Data,
         IP2Bus_WrAck           => IP2Bus_WrAck,
         IP2Bus_RdAck           => IP2Bus_RdAck,
         IP2Bus_Error           => '0',
         IP2Bus_AddrAck         => IP2Bus_AddrAck,
         Bus2IP_Addr            => Bus2IP_Addr,
         Bus2IP_Data            => Bus2IP_Data,
         Bus2IP_RNW             => open,
         Bus2IP_BE              => Bus2IP_BE,
         Bus2IP_CS              => open,
         Bus2IP_Burst           => Bus2IP_Burst, 
         Bus2IP_BurstLength     => open,
         Bus2IP_WrReq           => Bus2IP_WrReq,        
         Bus2IP_RdReq           => Bus2IP_RdReq, 
         Bus2IP_RdCE            => ssp1_Bus2IP_RdCE,
         Bus2IP_WrCE            => ssp1_Bus2IP_WrCE
        );

end architecture imp;