library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity tb is
end;

architecture behav of tb is
    constant auto_stim: boolean := false;

    signal ACLK          : std_logic := '0';
    signal ARESETN       : std_logic;
    signal AXIS_TDATA    : std_logic_vector(63 downto 0) := (others => '0');
    signal AXIS_TSTRB    : std_logic_vector(7 downto 0) := (others => '1');
    signal AXIS_TVALID : std_logic;
    signal AXIS_TREADY : std_logic;
    signal AXIS_TLAST    : std_logic;
begin
    ARESETN <= '0', '1' after 10 ns;
    ACLK <= not ACLK after 2.5 ns;

    stim_from_file: if not auto_stim generate
        nf10_axis_sim_stim_1: entity work.nf10_axis_sim_stim
            generic map (
                C_M_AXIS_DATA_WIDTH => AXIS_TDATA'length,
                input_file          => "test_in.dat")
            port map (
                ACLK      => ACLK,
                ARESETN   => ARESETN,
                M_AXIS_TDATA  => AXIS_TDATA,
                M_AXIS_TSTRB  => AXIS_TSTRB,
                M_AXIS_TVALID => AXIS_TVALID,
                M_AXIS_TREADY => AXIS_TREADY,
                M_AXIS_TLAST  => AXIS_TLAST);
    end generate;

    stim_from_tb: if auto_stim generate
        process(ACLK)
        begin
            if rising_edge(ACLK) then
                AXIS_TDATA <= AXIS_TDATA + 1;
            end if;
        end process;

        AXIS_TLAST  <= '1' when AXIS_TDATA(3 downto 0 ) = "1111" else
                       '0';

        AXIS_TVALID <= AXIS_TDATA(4);
    end generate;

    nf10_axis_sim_record_1: entity work.nf10_axis_sim_record
        generic map (
            C_S_AXIS_DATA_WIDTH => AXIS_TDATA'length,
            output_file         => "test_out.dat")
        port map (
            ACLK          => ACLK,
            S_AXIS_TDATA  => AXIS_TDATA,
            S_AXIS_TSTRB  => AXIS_TSTRB,
            S_AXIS_TVALID => AXIS_TVALID,
            S_AXIS_TREADY => AXIS_TREADY,
            S_AXIS_TLAST  => AXIS_TLAST);

end;
