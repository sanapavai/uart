
-- Engineer: 
-- 
-- Create Date: 05.06.2026 12:10:51
-- Design Name: 
-- Module Name: buard_rate_generator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity buard_rate_generator is
Port (clk,rst:in std_logic;
baud_tick: out std_logic
 );
end buard_rate_generator;

architecture Behavioral of buard_rate_generator is
signal count : integer :=0;
signal max_count: integer := 10;
begin
process(clk,rst)
begin
if rst='1'then 
count<= 0;
baud_tick<='0';
elsif rising_edge(clk)then
if count= max_count then 
count<=0;
baud_tick<='1';
else
count<= count+1;
baud_tick<='0';
end if ;
end if ;
end process ;
end Behavioral;
