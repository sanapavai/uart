
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2026 12:26:46
-- Design Name: 
-- Module Name: uart_tx_shift_register - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx_shift_register is
Port (clk,rst: in std_logic;
load:in std_logic;
baud_tick: in std_logic;
data_in: in std_logic_vector(7 downto 0);
shift_en   : in std_logic;
tx:out std_logic 
);
end uart_tx_shift_register;

architecture Behavioral of uart_tx_shift_register is
signal shift_register : std_logic_vector(9 downto 0);
begin
tx <= shift_register(0);
process(clk,rst)
begin
if rst='1' then 
shift_register<= (others=>'1');
elsif rising_edge(clk) then
if load='1' then
    shift_register <= '1' & data_in & '0';
elsif shift_en ='1' then 
shift_register <= '1' & shift_register(9 downto 1);

end if ;
end if ;
end process;
end Behavioral;
