----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2026 12:10:21
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
Port (clk, rst : in std_logic;
 tx_start: in std_logic;
 baud_tick:in std_logic;
 done: out std_logic;
 load : out std_logic;
 shift_en : out std_logic);
end uart_tx;
architecture Behavioral of uart_tx is
type state_type is (IDLE, START, DATA , STOP);
signal state : state_type;
signal bit_count : integer range 0 to 9 :=0;
begin
process(clk,rst)
begin
if rst ='1' then 
shift_en<='0';
done<='0';
load<='0';
bit_count<=0;
state <=IDLE;
elsif rising_edge(clk) then 
case state is 
when IDLE=> 
shift_en<='0';
done<='0';
load<='0';
if tx_start ='1' then 
load <='1';
state<=START;
else 
state<=IDLE;
end if ;
when START =>
    load <= '1';

    if baud_tick='1' then
        load <= '0';
        bit_count <= 0;
        state <= DATA;
    end if;
when DATA => 
if baud_tick ='1'then
shift_en<=baud_tick; 
if bit_count=9 then 
state<=STOP;
else 
bit_count <=bit_count+1;
end if ;
 else
shift_en <= '0';
state    <= DATA;
end if ;
when STOP => 
shift_en<='0';
if baud_tick ='1'then 
done<='1';
state<=IDLE;
else
                        state <= STOP;
end if ;
end case;
end if ;
end process;
end Behavioral;
