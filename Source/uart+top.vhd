----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.06.2026 14:33:14
-- Design Name: 
-- Module Name: uart+top - Behavioral
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

entity uart_top is
Port (clk,rst: in std_logic;
data_in: in std_logic_vector(7 downto 0);
tx_start: in std_logic;
tx:out std_logic;
rx       : in  std_logic;
data_out : out std_logic_vector(7 downto 0);
rx_done  : out std_logic );
end uart_top;

architecture Behavioral of uart_top is
signal baud_tick: std_logic;
signal done: std_logic;
signal  load : std_logic;
signal shift_en : std_logic;
signal rx_shift_en : std_logic;
begin
baud_inst: entity work.buard_rate_generator
port map (
    clk       => clk,
    rst       => rst,
    baud_tick => baud_tick
);
fsm_inst:entity work.uart_tx 
port map(
clk =>clk,
rst=>rst,
tx_start =>tx_start,
baud_tick=> baud_tick,
 done=>done,
 load=> load,
 shift_en=>shift_en);
 shift_inst: entity work. uart_tx_shift_register
 port map(
 clk=>clk,
 rst=>rst,
 load=>load,
 baud_tick=>baud_tick,
 data_in=>data_in,
 tx=>tx,
 shift_en=>shift_en);
 rx_fsm_inst : entity work.uart_rx
port map(
    clk       => clk,
    rst       => rst,
    rx        => rx,
    baud_tick => baud_tick,
    shift_en  => rx_shift_en,
    rx_done   => rx_done
);
rx_shift_inst : entity work.uart_rx_shift_register
port map(
    clk      => clk,
    rst      => rst,
    rx       => rx,
    shift_en => rx_shift_en,
    data_out => data_out
);

end Behavioral;
