------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        flash_reg.vhd
--
--  Library:
--        ieee
--        unisim
--        proc_common_v3_00_a
--        nf10_axi_flash_ctrl_v1_00_a
--
--  Project:
--        configuration_test_no_cdc
--
--  Module:
--        flash_reg - Behavioral
--
--  Author:
--        Muhammad Shahbaz
--
--  Description:
--        Flash controller for NetFPGA 10G
--
--  Copyright notice:
--        Copyright (C) 2010, 2011 University of Cambridge
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
--

library ieee;
library unisim;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.proc_common_pkg.clog2;
use proc_common_v3_00_a.proc_common_pkg.max2;
use proc_common_v3_00_a.ipif_pkg.all;
use proc_common_v3_00_a.family_support.all;
use proc_common_v3_00_a.counter_f;

library nf10_axi_flash_ctrl_v1_00_a;
use nf10_axi_flash_ctrl_v1_00_a.all;

---------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------

entity flash_reg  is
	generic (C_IPIF_ABUS_WIDTH   : integer := 32;
                 C_IPIF_DBUS_WIDTH   : integer := 32);
        Port (CPLD_CLK        : in std_logic;
              reboot          : out std_logic;
              CLK	      : in std_logic;
		-- Flash signals
              FPGA_A	      : out std_logic_vector(23 downto 0);
		--FPGA_DQ			: inout std_logic_vector (15 downto 0);
              FPGA_DQ_I       : in std_logic_vector(15 downto 0);
              FPGA_DQ_O       : out std_logic_vector(15 downto 0);
              FPGA_DQ_T       : out std_logic_vector(15 downto 0);
	      FPGA_FOE        : out std_logic;
              FPGA_FWE        : out std_logic;
              FPGA_FCS        : out std_logic;
              FPGA_IOL9P      : out std_logic;
              FLASH_RST	      : out std_logic;
-- Controls to the IP/IPIF modules
              Bus2IP_Resetn   : in  std_logic;
              Bus2IP_CS       : in  std_logic;
              Bus2IP_RdCE     : in  std_logic_vector(3 downto 0);
              Bus2IP_WrCE     : in  std_logic_vector(3 downto 0);
              Bus2IP_Data     : in  std_logic_vector((C_IPIF_DBUS_WIDTH-1) downto 0);
              IP2Bus_Data     : out std_logic_vector((C_IPIF_DBUS_WIDTH-1) downto 0);
              IP2Bus_WrAck    : out std_logic;
              IP2Bus_RdAck    : out std_logic;
              IP2Bus_Error    : out std_logic);
end flash_reg;


architecture Behavioral of flash_reg is

component flash_controller
  port (CPLD_CLK        : in    std_logic;
	reboot          : out   std_logic;
	A        	: out   std_logic_vector(23 downto 0);
	Data_out 	: out   std_logic_vector(15 downto 0); -- data io
	Data_in  	: in    std_logic_vector(15 downto 0); -- data io
	E_N      	: out   std_logic;
	G_N      	: out   std_logic;
	clk      	: in    std_logic;
	RP_N     	: out   std_logic;
	W_N      	: out   std_logic;
	L_N      	: out   std_logic;
	counter	 	: out   std_logic_vector(15 downto 0);
	check	 	: out   std_logic;
	data_register	: out   std_logic_vector(15 downto 0);
	command		: in    std_logic_vector(3 downto 0);
	control		: out   std_logic_vector(3 downto 0);
	address		: in    std_logic_vector(23 downto 0);
	data		: in    std_logic_vector(15 downto 0);
	execute_order	: in    std_logic;
	hw_wr_ack       : out   std_logic;
        execute         : inout std_logic);
end component;


component icon_v5
  port (CONTROL0 : inout std_logic_vector(35 downto 0);
        CONTROL1 : inout std_logic_vector(35 downto 0));
end component;

component ila256_v5
  port (CLK     : in std_logic;
        CONTROL : inout std_logic_vector(35 downto 0);
        TRIG0   : in std_logic_vector(255 downto 0));
end component;

component vio_sync64_v5
  port (CLK      : in std_logic;
        CONTROL  : inout std_logic_vector(35 downto 0);
        SYNC_OUT : out std_logic_vector(63 downto 0));
end component;


  signal Flash_A_DQ_out : std_logic_vector(15 downto 0);
  signal Flash_A_G      : std_logic;
  signal ila_data       : std_logic_vector(255 downto 0);
  signal ila_clk        : std_logic;
  signal ila_control0   : std_logic_vector(35 downto 0);
  signal ila_control1   : std_logic_vector(35 downto 0);
  signal vio_syncout    : std_logic_Vector(63 downto 0);
  signal address        : std_logic_vector (23 downto 0);
  signal fpga_we        : std_logic;
  signal fpga_cs        : std_logic;
  signal fpga_iol       : std_logic;
  signal cs_counter     : std_logic_vector(15 downto 0);
  signal cs_check       : std_logic;
  signal dat_reg        : std_logic_vector(15 downto 0);
  signal control_state  : std_logic_vector(3 downto 0);
  signal hw_wr_ack      : std_logic;

  signal execute_order   : std_logic;
  signal execute_order_8 : std_logic;
  signal exec_order      : std_logic;
  signal exec_order_sr   : std_logic_vector(2 downto 0);
  signal exec_couter     : std_logic_vector(3 downto 0);

  signal sig_Bus2IP_Resetn : std_logic;
  signal sig_Bus2IP_CS     : std_logic;
  signal sig_Bus2IP_RdCE   : std_logic_vector(3 downto 0);
  signal sig_Bus2IP_WrCE   : std_logic_vector(3 downto 0);
  signal sig_Bus2IP_Data   : std_logic_vector(31 downto 0);
  signal sig_IP2Bus_Data   : std_logic_vector(31 downto 0);
  signal sig_IP2Bus_WrAck  : std_logic;
  signal sig_IP2Bus_RdAck  : std_logic;
  signal sig_IP2Bus_Error  : std_logic;
  -----------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal cmd_reg             : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal data_in_reg         : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal adr_reg             : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal unsigned_adr_reg    : unsigned (31 downto 0);
  signal incremented_adr_reg : unsigned (23 downto 0);

  signal data_out_reg        : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal slv_reg_write_sel   : std_logic_vector(3 downto 0);
  signal slv_reg_read_sel    : std_logic_vector(3 downto 0);
  signal slv_reg_read_sel_1  : std_logic_vector(3 downto 0);
  signal slv_reg_read_sel_2  : std_logic_vector(3 downto 0);
  signal slv_ip2bus_data     : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal slv_read_ack        : std_logic;
  signal slv_write_ack       : std_logic;

  signal cmd_reg_1           : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal data_in_reg_1       : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal adr_reg_1           : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal data_out_reg_1      : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal cmd_reg_2           : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal data_in_reg_2       : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal adr_reg_2           : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);
  signal data_out_reg_2      : std_logic_vector(C_IPIF_DBUS_WIDTH-1 downto 0);

  signal FLASH_A_DQ_buffered  : std_logic_vector (15 downto 0);
  signal FPGA_data_buffered   : std_logic_vector (15 downto 0);
  signal Flash_A_G_buffered   : std_logic;
  signal Flash_A_G_buffered_2 : std_logic;

  signal execute     : std_logic; -- Signals the completion of a flash based task - is zero when finished.
  signal CurrExecute : std_logic;
  signal PrevExecute : std_logic;
  signal increment   : std_logic;

begin

  flash_ctlr : flash_controller
    port map (CPLD_CLK      => CPLD_CLK,
              reboot        => reboot,
              A             => address,
              Data_out      => Flash_A_DQ_out,
              Data_in       => FPGA_DQ_I,
              E_N           => fpga_cs,
              G_N           => Flash_A_G,
              clk           => CLK,
              RP_N          => FLASH_RST,
              W_N           => fpga_we,
              L_N           => fpga_iol,
              counter       => cs_counter,
              check	    => cs_check,
              data_register => dat_reg,
              command       => cmd_reg(3 downto 0),
              control       => control_state,
              address       => adr_reg(23 downto 0),
              data	    => data_in_reg(15 downto 0),
              execute_order => exec_order,
              hw_wr_ack     => hw_wr_ack,
              execute       => execute);


	---------  chip scope stuff ----------------------------------------------
--	i1_icon : icon_v5
--	port map(
--		 CONTROL0  => ila_control0,
--		 CONTROL1  => ila_control1
--	);

--	i1_ila : ila256_v5
--	port map(
--		 CLK     => CLK,
--		 CONTROL => ila_control0,
--		 TRIG0   => ila_data
--	);

--	i1_vio : vio_sync64_v5
--	port map(
--		 CLK      => CLK,
--		 CONTROL  => ila_control1,
--		 SYNC_OUT => vio_syncout
--	);

	-- Output signals
	FPGA_FOE 		<= Flash_A_G;
	FPGA_A 			<= address;
	FPGA_FWE		<= fpga_we;
	FPGA_FCS		<= fpga_cs;
	FPGA_IOL9P		<= fpga_iol;

	sig_Bus2IP_Resetn   <= Bus2IP_Resetn;
	sig_Bus2IP_CS       <= Bus2IP_CS;
	sig_Bus2IP_RdCE     <= Bus2IP_RdCE;
	sig_Bus2IP_WrCE     <= Bus2IP_WrCE;
	sig_Bus2IP_Data     <= Bus2IP_Data;
	sig_IP2Bus_Data     <= slv_ip2bus_data;
	sig_IP2Bus_WrAck    <= slv_write_ack;
	sig_IP2Bus_RdAck    <= slv_read_ack;
	sig_IP2Bus_Error    <= '0';


	-- ChipScope signals
--      ila_data(22 downto 0)   <= address (22 downto 0);
--      ila_data(38 downto 23)  <= FPGA_data_buffered;
--      ila_data(54 downto 39)  <= Flash_A_DQ_out;
--      ila_data(55) 		    <= Flash_A_G;
--      ila_data(56) 		    <= fpga_we;
--      ila_data(57) 		    <= fpga_cs;
--      ila_data(58) 		    <= fpga_iol;
--      ila_data(59) 		    <= cs_check;
--      ila_data(75 downto 60) 	<= cs_counter;
--      ila_data(91 downto 76) 	<= dat_reg;
--      ila_data(95 downto 92) 	<= control_state;
--      ila_data(96) 	        <= sig_Bus2IP_Resetn;
--      ila_data(97) 	        <= sig_Bus2IP_CS;
--      ila_data(101 downto 98) <= sig_Bus2IP_RdCE;
--      ila_data(105 downto 102)<= sig_Bus2IP_WrCE;
--      ila_data(137 downto 106)<= sig_Bus2IP_Data;
--      ila_data(169 downto 138)<= sig_IP2Bus_Data;
--      ila_data(170) 	        <= sig_IP2Bus_WrAck;
--      ila_data(171) 	        <= sig_IP2Bus_RdAck;
--      ila_data(172) 	        <= sig_IP2Bus_Error;
--      ila_data(173) 	        <= execute_order_8;
--      ila_data(176 downto 174)<= exec_order_sr;
--      ila_data(199 downto 177) <= adr_reg (22 downto 0);
--      ila_data(200)            <= PrevExecute;
--      ila_data(201)            <= CurrExecute;
--      ila_data(202)            <= slv_write_ACK;
--      ila_data(206 downto 203) <= slv_reg_write_sel (3 downto 0);
--      ila_data(207)            <= hw_wr_ack;
--      ila_data(211 downto 208) <= slv_reg_read_sel (3 downto 0);
--      ila_data(255 downto 212)<= (others => '0');


	flash_chk_p: process(CLK)
    begin
      if CLK'event and CLK='1' then
		FLASH_A_DQ_buffered	    <= Flash_A_DQ_out;
		FPGA_data_buffered 	    <= FPGA_DQ_I;
		Flash_A_G_buffered 	    <= not Flash_A_G;
		Flash_A_G_buffered_2    <= Flash_A_G_buffered;
      end if;
   end process;


	-- buffer for inout signal from flash
	FPGA_DQ_O     <= FLASH_A_DQ_buffered;
	FPGA_DQ_T     <= (others => not Flash_A_G);


  ---------------------------------------------------------------------------------
  --  code to read/write slave s/w accessible registers
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0  Command Register
  --                     "0100"   C_BASEADDR + 0x4  Data in Register
  --                     "0010"   C_BASEADDR + 0x8  Address Register
  --                     "0001"   C_BASEADDR + 0xC  Data out Register


  IP2Bus_Data       <= slv_ip2bus_data;
  IP2Bus_WrAck      <= slv_write_ack;
  IP2Bus_RdAck      <= slv_read_ack;


    ---------------------------------------------------------------------------
    -- Generating the acknowledgement and error signals
    ---------------------------------------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE;
  slv_reg_read_sel  <= Bus2IP_RdCE;
  slv_write_ack     <= Bus2IP_WrCE(3) or Bus2IP_WrCE(2) or Bus2IP_WrCE(1) or Bus2IP_WrCE(0);
  slv_read_ack      <= Bus2IP_RdCE(3) or Bus2IP_RdCE(2) or Bus2IP_RdCE(1) or Bus2IP_RdCE(0);
  IP2Bus_Error      <= '0';

  --Write Register
  SLAVE_REG_WRITE_PROC : process(CLK, slv_reg_write_sel, Bus2IP_Resetn ) is
  begin
    unsigned_adr_reg <= unsigned (adr_reg);
    incremented_adr_reg <= unsigned_adr_reg(23 downto 0) + 1;
    if CLK'event and CLK = '1'
    then
      CurrExecute <= Execute;      -- Note that "execute" belongs to the CPLD_clk domain.
      if (CurrExecute = '1')       -- We capture its current value and its previous value.
      then
        PrevExecute <= '1';
      else
        PrevExecute <= '0';
      end if;

      if Bus2IP_Resetn = '0'
      then
        adr_reg      <= (others => '0');
      elsif (PrevExecute = '1') and (CurrExecute = '0')
      then
        adr_reg <= conv_std_logic_vector(incremented_adr_reg, 32);
      elsif (slv_write_ack = '1') --and (slv_reg_write_sel = "0010")
      then
        case slv_reg_write_sel is
          when "0010" =>
	   adr_reg(23 downto 0) <= Bus2IP_Data(23 downto 0);

          when others => null;
        end case;
      end if;


      if Bus2IP_Resetn = '0'
      then
        cmd_reg      <= (others => '0');
        data_in_reg  <= (others => '0');
        data_out_reg <= (others => '0');
    -- Software write
      elsif slv_write_ack = '1'
      then
        case slv_reg_write_sel is
          when "1000" => cmd_reg(3 downto 0)       <= Bus2IP_Data(3 downto 0);
          when "0100" => data_in_reg(15 downto 0)  <= Bus2IP_Data(15 downto 0);
          when "0001" => data_out_reg(15 downto 0) <= Bus2IP_Data(15 downto 0);
          when others => null;
        end case;

	  -- Hardware write
      elsif hw_wr_ack = '1'
      then
        data_out_reg(15 downto 0)   <= dat_reg;
      end if;
    end if;
  end process SLAVE_REG_WRITE_PROC;

  -- Read register
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel_2, cmd_reg, data_in_reg, adr_reg, data_out_reg_2 ) is
  begin
    slv_ip2bus_data <= (others => '0');
    case slv_reg_read_sel is
      when "1000" => slv_ip2bus_data(3 downto 0)  <= cmd_reg_1(3 downto 0);
      when "0100" => slv_ip2bus_data(15 downto 0) <= data_in_reg_1(15 downto 0);
      when "0010" => slv_ip2bus_data(23 downto 0) <= adr_reg_1(23 downto 0);
      when "0001" => slv_ip2bus_data(15 downto 0) <= data_out_reg_1(15 downto 0);
      when others => slv_ip2bus_data <= (others => '0');
    end case;
  end process SLAVE_REG_READ_PROC;


  -- Execute Order after writing data to the command register
  EX_ORDER : process(slv_reg_write_sel) is
  begin

  end process EX_ORDER;

  EX_ORDER_sl : process(CPLD_CLK, execute_order_8) is
  begin
    if CPLD_CLK'event and CPLD_CLK = '1'
    then
      exec_order_sr(2 downto 0) <= exec_order_sr(1 downto 0) & execute_order_8;
      if exec_order_sr(2 downto 1) = "01"
      then
        exec_order <= '1';
      else
        exec_order <= '0';
      end if;
    end if;
  end process EX_ORDER_sl;


  EX_ORDER_cnt : process (CLK, execute_order_8)
  begin
    if (slv_reg_write_sel = "1000") or (slv_reg_read_sel = "0001") or
       ((slv_reg_write_sel = "0100") and (cmd_reg = "0100"))
    then
      execute_order_8 <= '1';
    elsif CLK'event and CLK = '1'
    then
      if execute_order_8 = '1'
      then
        exec_couter <= exec_couter + 1;
      end if;
      if exec_couter = "0101"
      then
        execute_order_8   <= '0';
        exec_couter <= "0000";
      end if;
    end if;
  end process EX_ORDER_cnt;

  -- clock domain crossing
  clk_cross : process (CPLD_CLK)
  begin
    if CPLD_CLK'event and CPLD_CLK = '1'
    then
      slv_reg_read_sel_1 <= slv_reg_read_sel;
      cmd_reg_1          <= cmd_reg;
      data_in_reg_1      <= data_in_reg;
      adr_reg_1          <= adr_reg;

      slv_reg_read_sel_2 <= slv_reg_read_sel_1;
      cmd_reg_2          <= cmd_reg_1;
      data_in_reg_2      <= data_in_reg_1;
      adr_reg_2          <= adr_reg_1;
    end if;
  end process clk_cross;

  clk_cross_2 : process (CLK)
  begin
    if CLK'event and CLK = '1'
    then
      data_out_reg_1  <= data_out_reg;
      data_out_reg_2  <= data_out_reg_1;
    end if;
  end process clk_cross_2;


end Behavioral;

