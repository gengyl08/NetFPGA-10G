--*******************************************************************************
-- *
-- *  NetFPGA-10G http://www.netfpga.org
-- *
-- *  File:
-- *        nf10_switch
-- *
-- *  Library:
-- *        hw/std/pcores/nf10_switch_v1_00_a
-- *
-- *  Module:
-- *        nf10_switch
-- *
-- *  Author:
-- *        Xilinx, Michaela Blott
-- *
-- *  Description:
-- *        simple layer 2 switching module
-- *
-- *  Copyright notice:
-- *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
-- *                                 Junior University
-- *
-- *  Licence:
-- *        This file is part of the NetFPGA 10G development base package.
-- *
-- *        This file is free code: you can redistribute it and/or modify it under
-- *        the terms of the GNU Lesser General Public License version 2.1 as
-- *        published by the Free Software Foundation.
-- *
-- *        This package is distributed in the hope that it will be useful, but
-- *        WITHOUT ANY WARRANTY; without even the implied warranty of
-- *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- *        Lesser General Public License for more details.
-- *
-- *        You should have received a copy of the GNU Lesser General Public
-- *        License along with the NetFPGA source package.  If not, see
-- *        http://www.gnu.org/licenses/.
-- *
-- */

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity nf10_switch is
generic(
    C_M_AXIS_DATA_WIDTH  : integer :=256;
    C_S_AXIS_DATA_WIDTH  : integer := 256;
    C_M_AXIS_TUSER_WIDTH : integer := 128;
    C_S_AXIS_TUSER_WIDTH : integer := 128;
    SRC_PORT_POS         : integer := 16;
    DST_PORT_POS         : integer := 24
);
 port (
    axi_aclk      : in std_logic;
    axi_resetn    : in std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
    m_axis_tstrb  : out std_logic_vectOR(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tlast  : out std_logic;
    s_axis_tdata  : in std_logic_vector(C_S_AXIS_DATA_WIDTH-1 downto 0);
    s_axis_tstrb  : in std_logic_vectOR(C_S_AXIS_DATA_WIDTH/8-1 downto 0);
    s_axis_tuser  : in std_logic_vector(C_S_AXIS_TUSER_WIDTH-1 downto 0);
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tlast  : in std_logic
);
END nf10_switch;

ARCHITECTURE rtl OF nf10_switch IS

component slice 
generic (
   D_WIDTH     : integer := C_M_AXIS_DATA_WIDTH;
   U_WIDTH     : integer := C_M_AXIS_TUSER_WIDTH;
   DELAY_DEPTH : integer := 2
);
port ( 
    clk : in  std_logic;
    rst : in  std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
    m_axis_tstrb  : out std_logic_vectOR(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tlast  : out std_logic;	 
    s_axis_tdata  : in std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
    s_axis_tstrb  : in std_logic_vectOR(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
    s_axis_tuser  : in std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tlast  : in std_logic);
end component;  


signal ila_data       : std_logic_vector(255 downto 0);
signal ila_control0   : std_logic_vector(35 downto 0);
signal ila_control1   : std_logic_vector(35 downto 0);
signal vio_syncout    : std_logic_Vector(63 downto 0);
signal version        : std_logic_vector(7 downto 0);
signal ready          : std_logic;
signal new_tuser      : std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);

signal mac0   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt0   : std_logic_vector(7 downto 0)  := "00000001";
signal mac1   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt1   : std_logic_vector(7 downto 0)  := "00000010";
signal mac2   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt2   : std_logic_vector(7 downto 0)  := "00000100";
signal mac3   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt3   : std_logic_vector(7 downto 0)  := "00001000";
signal mac4   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt4   : std_logic_vector(7 downto 0)  := "00010000";
signal mac5   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt5   : std_logic_vector(7 downto 0)  := "00100000";
signal mac6   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt6   : std_logic_vector(7 downto 0)  := "01000000";
signal mac7   : std_logic_vector(47 downto 0) := x"000000000000";
signal prt7   : std_logic_vector(7 downto 0)  := "10000000";

signal state : std_logic_vector(1 downto 0);


BEGIN

version <= x"01";

slice_i : slice
generic map (
   D_WIDTH     => C_M_AXIS_DATA_WIDTH,
   U_WIDTH     => C_M_AXIS_TUSER_WIDTH,
   DELAY_DEPTH => 2
)
port map (
    clk           => axi_aclk,
    rst           => axi_resetn,
    m_axis_tdata  => m_axis_tdata,
    m_axis_tstrb  => m_axis_tstrb,
    m_axis_tuser  => m_axis_tuser,
    m_axis_tvalid => m_axis_tvalid,
    m_axis_tready => m_axis_tready,
    m_axis_tlast  => m_axis_tlast,
    s_axis_tdata  => s_axis_tdata,
    s_axis_tstrb  => s_axis_tstrb,
    s_axis_tuser  => new_tuser,
    s_axis_tvalid => s_axis_tvalid,
    s_axis_tready => ready,
    s_axis_tlast  => s_axis_tlast);

s_axis_tready <= ready;	
	
p: process(axi_aclk)
begin
   if (axi_aclk'event and axi_aclk='1') then
      -- debug
      ila_data(63 downto 0)    <= s_axis_tdata(63 downto 0);
      ila_data(128)            <= s_axis_tvalid;
      ila_data(129)            <= s_axis_tlast;
      ila_data(130)            <= ready;
      ila_data(138 downto 131) <= version;			
      ila_data(255 downto 139) <= new_tuser(116 downto 0);
   end if; 
end process;

switch_p: process(s_axis_tuser,s_axis_tvalid,state,s_axis_tdata)
begin
	new_tuser <= s_axis_tuser;
	if (state = "00" and s_axis_tvalid='1') then
		-- switching
		if (s_axis_tdata(47 downto 0)=mac0) then					
		   new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt0;	
		elsif (s_axis_tdata(47 downto 0)=mac1) then					
		   new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt1;	
		elsif (s_axis_tdata(47 downto 0)=mac2) then					
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt2;
		elsif (s_axis_tdata(47 downto 0)=mac3) then					
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt3;
		elsif (s_axis_tdata(47 downto 0)=mac4) then					
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt4;	
		elsif (s_axis_tdata(47 downto 0)=mac5) then				
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt5;	
		elsif (s_axis_tdata(47 downto 0)=mac6) then					
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt6;	
		elsif (s_axis_tdata(47 downto 0)=mac7) then					
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= prt7;	
		else 
			new_tuser(DST_PORT_POS+7 downto DST_PORT_POS) <= x"FF";
		end if;
	end if;
end process;

usr_p: process(axi_aclk)
begin
   if (axi_aclk'event and axi_aclk='1') then
		if (axi_resetn = '0') then
			state <= "00";
		else
			if (state = "00") then
				if (s_axis_tvalid='1') then 
					-- learning
					if (s_axis_tuser(SRC_PORT_POS + 0)='1') then
						mac0 <= s_axis_tdata(95 downto 48);
					end if;
					if (s_axis_tuser(SRC_PORT_POS + 1)='1') then
						mac1 <= s_axis_tdata(95 downto 48);
					end if;				
					if (s_axis_tuser(SRC_PORT_POS + 2)='1') then
						mac2 <= s_axis_tdata(95 downto 48);
					end if;
					if (s_axis_tuser(SRC_PORT_POS + 3)='1') then
						mac3 <= s_axis_tdata(95 downto 48);
					end if;
					if (s_axis_tuser(SRC_PORT_POS + 4)='1') then
						mac4 <= s_axis_tdata(95 downto 48);
					end if;
					if (s_axis_tuser(SRC_PORT_POS + 5)='1') then
						mac5 <= s_axis_tdata(95 downto 48);
					end if;					
					if (s_axis_tuser(SRC_PORT_POS + 6)='1') then
						mac6 <= s_axis_tdata(95 downto 48);
					end if;
					if (s_axis_tuser(SRC_PORT_POS + 7)='1') then
						mac7 <= s_axis_tdata(95 downto 48);
					end if;				
					if(ready='1') then
						state <= "01";
					end if; --tready
				end if; --tvalid	
			else -- state
				if(s_axis_tlast='1' and s_axis_tvalid='1' and ready='1') then
					state <= "00";
				end if; -- tlast
			end if; --state
		end if; -- reset
	end if; -- clk
end process;


end rtl;
