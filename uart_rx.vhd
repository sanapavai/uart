library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_rx is
Port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    rx        : in  std_logic;
    baud_tick : in  std_logic;

    shift_en  : out std_logic;
    rx_done   : out std_logic
);
end uart_rx;

architecture Behavioral of uart_rx is

    type state_type is (IDLE, START, DATA, STOP);
    signal state : state_type := IDLE;

    signal bit_count : integer range 0 to 8 := 0;

begin

process(clk,rst)
begin

    if rst='1' then

        state <= IDLE;
        bit_count <= 0;
        shift_en <= '0';
        rx_done <= '0';

    elsif rising_edge(clk) then

        shift_en <= '0';
        rx_done <= '0';

        case state is

            --------------------------------------------------
            when IDLE =>
            --------------------------------------------------
                if rx='0' then
                    state <= START;
                end if;

            --------------------------------------------------
            when START =>
            --------------------------------------------------
                if baud_tick='1' then
                    bit_count <= 0;
                    state <= DATA;
                end if;

            --------------------------------------------------
            when DATA =>
            --------------------------------------------------

    if baud_tick = '1' then

        if bit_count < 8 then
            shift_en <= '1';
            bit_count <= bit_count + 1;

        else
            shift_en <= '1';      -- capture 8th bit
            state <= STOP;
        end if;

    end if;

            --------------------------------------------------
            when STOP =>
            --------------------------------------------------
                if baud_tick='1' then
                    rx_done <= '1';
                    bit_count <= 0;
                    state <= IDLE;
                end if;

        end case;

    end if;

end process;

end Behavioral;