library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_rx_shift_register is
Port (
    clk      : in  std_logic;
    rst      : in  std_logic;

    rx       : in  std_logic;
    shift_en : in  std_logic;

    data_out : out std_logic_vector(7 downto 0)
);
end uart_rx_shift_register;

architecture Behavioral of uart_rx_shift_register is

    signal shift_register : std_logic_vector(7 downto 0);

begin

    data_out <= shift_register;

    process(clk,rst)
    begin

        if rst='1' then

            shift_register <= (others=>'0');

        elsif rising_edge(clk) then

            if shift_en='1' then

                shift_register <= rx & shift_register(7 downto 1);

            end if;

        end if;

    end process;

end Behavioral;