library IEEE;
use IEEE.std_logic_1164.all;

entity OutputPort is
port( input : in std_logic_vector(31 downto 0);
clk: in std_logic;
clear: in std_logic;
writeEnable: in std_logic; --R#In
output : out std_logic_vector(31 downto 0)
);
end OutputPort;

architecture sim of OutputPort is
begin
process(clk) is
begin
if rising_edge(clk) then
	if (writeEnable = '1') then
		output <= input;
	elsif (clear='1') then
		output <= x"00000000";
		
	end if;
end if;
end process;
end sim;
