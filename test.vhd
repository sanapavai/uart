library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_top_tb is
end uart_top_tb;

architecture Behavioral of uart_top_tb is

    --------------------------------------------------------------------
    -- DUT Component Declaration
    --------------------------------------------------------------------
    component uart_top
    Port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        data_in  : in  std_logic_vector(7 downto 0);
        tx_start : in  std_logic;

        rx       : in  std_logic;

        tx       : out std_logic;
        data_out : out std_logic_vector(7 downto 0);
        rx_done  : out std_logic
    );
    end component;

    --------------------------------------------------------------------
    -- Signals
    --------------------------------------------------------------------
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal tx_start : std_logic := '0';

    signal tx       : std_logic;
    signal rx       : std_logic;

    signal data_in  : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out : std_logic_vector(7 downto 0);
    signal rx_done  : std_logic;

    constant clk_period : time := 10 ns;

begin

    --------------------------------------------------------------------
    -- Loopback Connection
    --------------------------------------------------------------------
    rx <= tx;

    --------------------------------------------------------------------
    -- DUT Instantiation
    --------------------------------------------------------------------
    uut : uart_top
    port map (
        clk      => clk,
        rst      => rst,
        data_in  => data_in,
        tx_start => tx_start,

        rx       => rx,

        tx       => tx,
        data_out => data_out,
        rx_done  => rx_done
    );

    --------------------------------------------------------------------
    -- Clock Generation
    --------------------------------------------------------------------
    clk_process : process
    begin
        while true loop

            clk <= '0';
            wait for clk_period/2;

            clk <= '1';
            wait for clk_period/2;

        end loop;
    end process;

    --------------------------------------------------------------------
    -- Stimulus Process
    --------------------------------------------------------------------
    stim_proc : process
    begin

        ------------------------------------------------------------
        -- Reset
        ------------------------------------------------------------
        rst <= '1';
        tx_start <= '0';
        data_in <= (others => '0');

        wait for 50 ns;

        rst <= '0';

        wait for 50 ns;

        ------------------------------------------------------------
        -- Transmit AA
        ------------------------------------------------------------
        data_in <= x"55";

        wait until rising_edge(clk);
        tx_start <= '1';

        wait until rising_edge(clk);
        tx_start <= '0';

        wait for 5 us;

        ------------------------------------------------------------
        -- Transmit CC
        ------------------------------------------------------------
        ------------------------------------------------------------
        -- End Simulation
        ------------------------------------------------------------
        wait;

    end process;

end Behavioral;