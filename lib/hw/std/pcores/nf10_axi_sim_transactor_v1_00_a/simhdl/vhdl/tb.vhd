library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

library nf10_axi_sim_transactor_v1_00_a;
library axi_bram_ctrl_v1_02_a;

library unisim;

entity tb is
end;

architecture behav of tb is
    constant C_S_AXI_ADDR_WIDTH  : integer := 32;        -- Width of AXI address bus (in bits)
    constant C_S_AXI_DATA_WIDTH  : integer := 32;        -- Width of AXI data bus (in bits)
    constant C_S_AXI_ID_WIDTH : INTEGER := 4;        --  AXI ID vector width
    constant C_S_AXI_PROTOCOL : string := "AXI4LITE";        -- Set to AXI4LITE to optimize out burst transaction support
    constant C_S_AXI_SUPPORTS_NARROW_BURST : INTEGER := 1;        -- Support for narrow burst operations

    constant C_SINGLE_PORT_BRAM : INTEGER := 0;        -- Enable single port usage of BRAM
    constant C_FAMILY : string := "virtex6";        -- Specify the target architecture type

    -- AXI-Lite Register Parameters
    constant C_S_AXI_CTRL_ADDR_WIDTH : integer := 32;        -- Width of AXI-Lite address bus (in bits)
    constant C_S_AXI_CTRL_DATA_WIDTH  : integer := 32;        -- Width of AXI-Lite data bus (in bits)

    -- ECC Parameters
    constant C_ECC : integer := 0;        -- Enables or disables ECC functionality
    constant C_FAULT_INJECT : integer := 0;        -- Enable fault injection registers
    constant C_ECC_ONOFF_RESET_VALUE : integer := 0;        -- By default, ECC checking is on
        -- (can disable ECC @ reset by setting this to 0)

    signal AXI_ACLK           : std_logic := '0';
    signal AXI_ARESETN      : std_logic;
    signal ECC_Interrupt      : std_logic := '0';
    signal ECC_UE             : std_logic := '0';
    signal AXI_AWID           : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
    signal AXI_AWADDR         : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal AXI_AWLEN          : std_logic_vector(7 downto 0);
    signal AXI_AWSIZE         : std_logic_vector(2 downto 0);
    signal AXI_AWBURST      : std_logic_vector(1 downto 0);
    signal AXI_AWLOCK         : std_logic;
    signal AXI_AWCACHE      : std_logic_vector(3 downto 0);
    signal AXI_AWPROT         : std_logic_vector(2 downto 0);
    signal AXI_AWVALID      : std_logic;
    signal AXI_AWREADY      : std_logic;
    signal AXI_WDATA          : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal AXI_WSTRB          : std_logic_vector(C_S_AXI_DATA_WIDTH/8-1 downto 0);
    signal AXI_WLAST          : std_logic;
    signal AXI_WVALID         : std_logic;
    signal AXI_WREADY         : std_logic;
    signal AXI_BID            : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
    signal AXI_BRESP          : std_logic_vector(1 downto 0);
    signal AXI_BVALID         : std_logic;
    signal AXI_BREADY         : std_logic;
    signal AXI_ARID           : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
    signal AXI_ARADDR         : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal AXI_ARLEN          : std_logic_vector(7 downto 0);
    signal AXI_ARSIZE         : std_logic_vector(2 downto 0);
    signal AXI_ARBURST      : std_logic_vector(1 downto 0);
    signal AXI_ARLOCK         : std_logic;
    signal AXI_ARCACHE      : std_logic_vector(3 downto 0);
    signal AXI_ARPROT         : std_logic_vector(2 downto 0);
    signal AXI_ARVALID      : std_logic;
    signal AXI_ARREADY      : std_logic;
    signal AXI_RID            : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
    signal AXI_RDATA          : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal AXI_RRESP          : std_logic_vector(1 downto 0);
    signal AXI_RLAST          : std_logic;
    signal AXI_RVALID         : std_logic;
    signal AXI_RREADY         : std_logic;
    signal AXI_CTRL_AWVALID : std_logic;
    signal AXI_CTRL_AWREADY : std_logic;
    signal AXI_CTRL_AWADDR  : std_logic_vector(C_S_AXI_CTRL_ADDR_WIDTH-1 downto 0);
    signal AXI_CTRL_WDATA   : std_logic_vector(C_S_AXI_CTRL_DATA_WIDTH-1 downto 0);
    signal AXI_CTRL_WVALID  : std_logic;
    signal AXI_CTRL_WREADY  : std_logic;
    signal AXI_CTRL_BRESP   : std_logic_vector(1 downto 0);
    signal AXI_CTRL_BVALID  : std_logic;
    signal AXI_CTRL_BREADY  : std_logic;
    signal AXI_CTRL_ARADDR  : std_logic_vector(C_S_AXI_CTRL_ADDR_WIDTH-1 downto 0);
    signal AXI_CTRL_ARVALID : std_logic;
    signal AXI_CTRL_ARREADY : std_logic;
    signal AXI_CTRL_RDATA   : std_logic_vector(C_S_AXI_CTRL_DATA_WIDTH-1 downto 0);
    signal AXI_CTRL_RRESP   : std_logic_vector(1 downto 0);
    signal AXI_CTRL_RVALID  : std_logic;
    signal AXI_CTRL_RREADY  : std_logic;

    signal BRAM_Rst_A         : std_logic;
    signal BRAM_Clk_A         : std_logic;
    signal BRAM_En_A          : std_logic;
    signal BRAM_WE_A          : std_logic_vector (C_S_AXI_DATA_WIDTH/8 + C_ECC-1 downto 0);
    signal BRAM_Addr_A        : std_logic_vector (C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal BRAM_WrData_A      : std_logic_vector (C_S_AXI_DATA_WIDTH+8*C_ECC-1 downto 0);
    signal BRAM_RdData_A      : std_logic_vector (C_S_AXI_DATA_WIDTH+8*C_ECC-1 downto 0);

    signal BRAM_Rst_B         : std_logic;
    signal BRAM_Clk_B         : std_logic;
    signal BRAM_En_B          : std_logic;
    signal BRAM_WE_B          : std_logic_vector (C_S_AXI_DATA_WIDTH/8 + C_ECC-1 downto 0);
    signal BRAM_Addr_B        : std_logic_vector (C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal BRAM_WrData_B      : std_logic_vector (C_S_AXI_DATA_WIDTH+8*C_ECC-1 downto 0);
    signal BRAM_RdData_B      : std_logic_vector (C_S_AXI_DATA_WIDTH+8*C_ECC-1 downto 0);
begin
    AXI_ACLK <= not AXI_ACLK after 5 ns;
    AXI_ARESETN <= '0', '1' after 101 ns;

    nf10_axi_sim_transactor_1: entity nf10_axi_sim_transactor_v1_00_a.nf10_axi_sim_transactor
        generic map (
            stim_file => "reg_stim.axi",
            log_file  => "reg_stim.log")
        port map (
            M_AXI_ACLK    => AXI_ACLK,
            M_AXI_ARESETN => AXI_ARESETN,
            M_AXI_AWADDR  => AXI_AWADDR,
            M_AXI_AWVALID => AXI_AWVALID,
            M_AXI_AWREADY => AXI_AWREADY,
            M_AXI_WDATA   => AXI_WDATA,
            M_AXI_WSTRB   => AXI_WSTRB,
            M_AXI_WVALID  => AXI_WVALID,
            M_AXI_WREADY  => AXI_WREADY,
            M_AXI_BRESP   => AXI_BRESP,
            M_AXI_BVALID  => AXI_BVALID,
            M_AXI_BREADY  => AXI_BREADY,
            M_AXI_ARADDR  => AXI_ARADDR,
            M_AXI_ARVALID => AXI_ARVALID,
            M_AXI_ARREADY => AXI_ARREADY,
            M_AXI_RDATA   => AXI_RDATA,
            M_AXI_RRESP   => AXI_RRESP,
            M_AXI_RVALID  => AXI_RVALID,
            M_AXI_RREADY  => AXI_RREADY);


    axi_bram_ctrl_1: entity axi_bram_ctrl_v1_02_a.axi_bram_ctrl
        generic map (
            C_S_AXI_ADDR_WIDTH            => C_S_AXI_ADDR_WIDTH,
            C_S_AXI_DATA_WIDTH            => C_S_AXI_DATA_WIDTH,
            C_S_AXI_ID_WIDTH              => C_S_AXI_ID_WIDTH,
            C_S_AXI_PROTOCOL              => C_S_AXI_PROTOCOL,
            C_S_AXI_SUPPORTS_NARROW_BURST => C_S_AXI_SUPPORTS_NARROW_BURST,
            C_SINGLE_PORT_BRAM            => C_SINGLE_PORT_BRAM,
            C_FAMILY                      => C_FAMILY,
            C_S_AXI_CTRL_ADDR_WIDTH       => C_S_AXI_CTRL_ADDR_WIDTH,
            C_S_AXI_CTRL_DATA_WIDTH       => C_S_AXI_CTRL_DATA_WIDTH,
            C_ECC                         => C_ECC,
            C_FAULT_INJECT                => C_FAULT_INJECT,
            C_ECC_ONOFF_RESET_VALUE       => C_ECC_ONOFF_RESET_VALUE)
        port map (
            S_AXI_ACLK         => AXI_ACLK,
            S_AXI_ARESETN      => AXI_ARESETN,
            ECC_Interrupt      => ECC_Interrupt,
            ECC_UE             => ECC_UE,
            S_AXI_AWID         => AXI_AWID,
            S_AXI_AWADDR       => AXI_AWADDR,
            S_AXI_AWLEN        => AXI_AWLEN,
            S_AXI_AWSIZE       => AXI_AWSIZE,
            S_AXI_AWBURST      => AXI_AWBURST,
            S_AXI_AWLOCK       => AXI_AWLOCK,
            S_AXI_AWCACHE      => AXI_AWCACHE,
            S_AXI_AWPROT       => AXI_AWPROT,
            S_AXI_AWVALID      => AXI_AWVALID,
            S_AXI_AWREADY      => AXI_AWREADY,
            S_AXI_WDATA        => AXI_WDATA,
            S_AXI_WSTRB        => AXI_WSTRB,
            S_AXI_WLAST        => AXI_WLAST,
            S_AXI_WVALID       => AXI_WVALID,
            S_AXI_WREADY       => AXI_WREADY,
            S_AXI_BID          => AXI_BID,
            S_AXI_BRESP        => AXI_BRESP,
            S_AXI_BVALID       => AXI_BVALID,
            S_AXI_BREADY       => AXI_BREADY,
            S_AXI_ARID         => AXI_ARID,
            S_AXI_ARADDR       => AXI_ARADDR,
            S_AXI_ARLEN        => AXI_ARLEN,
            S_AXI_ARSIZE       => AXI_ARSIZE,
            S_AXI_ARBURST      => AXI_ARBURST,
            S_AXI_ARLOCK       => AXI_ARLOCK,
            S_AXI_ARCACHE      => AXI_ARCACHE,
            S_AXI_ARPROT       => AXI_ARPROT,
            S_AXI_ARVALID      => AXI_ARVALID,
            S_AXI_ARREADY      => AXI_ARREADY,
            S_AXI_RID          => AXI_RID,
            S_AXI_RDATA        => AXI_RDATA,
            S_AXI_RRESP        => AXI_RRESP,
            S_AXI_RLAST        => AXI_RLAST,
            S_AXI_RVALID       => AXI_RVALID,
            S_AXI_RREADY       => AXI_RREADY,
            S_AXI_CTRL_AWVALID => AXI_CTRL_AWVALID,
            S_AXI_CTRL_AWREADY => AXI_CTRL_AWREADY,
            S_AXI_CTRL_AWADDR  => AXI_CTRL_AWADDR,
            S_AXI_CTRL_WDATA   => AXI_CTRL_WDATA,
            S_AXI_CTRL_WVALID  => AXI_CTRL_WVALID,
            S_AXI_CTRL_WREADY  => AXI_CTRL_WREADY,
            S_AXI_CTRL_BRESP   => AXI_CTRL_BRESP,
            S_AXI_CTRL_BVALID  => AXI_CTRL_BVALID,
            S_AXI_CTRL_BREADY  => AXI_CTRL_BREADY,
            S_AXI_CTRL_ARADDR  => AXI_CTRL_ARADDR,
            S_AXI_CTRL_ARVALID => AXI_CTRL_ARVALID,
            S_AXI_CTRL_ARREADY => AXI_CTRL_ARREADY,
            S_AXI_CTRL_RDATA   => AXI_CTRL_RDATA,
            S_AXI_CTRL_RRESP   => AXI_CTRL_RRESP,
            S_AXI_CTRL_RVALID  => AXI_CTRL_RVALID,
            S_AXI_CTRL_RREADY  => AXI_CTRL_RREADY,

            BRAM_Rst_A         => BRAM_Rst_A,
            BRAM_Clk_A         => BRAM_Clk_A,
            BRAM_En_A          => BRAM_En_A,
            BRAM_WE_A          => BRAM_WE_A,
            BRAM_Addr_A        => BRAM_Addr_A,
            BRAM_WrData_A      => BRAM_WrData_A,
            BRAM_RdData_A      => BRAM_RdData_A,
            BRAM_Rst_B         => BRAM_Rst_B,
            BRAM_Clk_B         => BRAM_Clk_B,
            BRAM_En_B          => BRAM_En_B,
            BRAM_WE_B          => BRAM_WE_B,
            BRAM_Addr_B        => BRAM_Addr_B,
            BRAM_WrData_B      => BRAM_WrData_B,
            BRAM_RdData_B      => BRAM_RdData_B);


    RAMB16_S36_S36_1: entity unisim.RAMB16_S36_S36
        port map (
            DOA   => BRAM_RdData_A,
            DOB   => BRAM_RdData_B,
            DOPA  => open,
            DOPB  => open,
            ADDRA => BRAM_Addr_A(8 downto 0),
            ADDRB => BRAM_Addr_B(8 downto 0),
            CLKA  => BRAM_Clk_A,
            CLKB  => BRAM_Clk_B,
            DIA   => BRAM_WrData_A,
            DIB   => BRAM_WrData_B,
            DIPA  => "0000",
            DIPB  => "0000",
            ENA   => BRAM_En_A,
            ENB   => BRAM_En_B,
            SSRA  => BRAM_Rst_A,
            SSRB  => BRAM_Rst_B,
            WEA   => BRAM_WE_A(0),
            WEB   => BRAM_WE_B(0));
end;
