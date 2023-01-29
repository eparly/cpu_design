library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
port( signal reg_input : in std_logic_vector(31 downto 0);
signal clk: in std_logic;
signal clear: in std_logic;
signal writeEnable: in std_logic; --R#In
signal reg_out : out std_logic_vector(31 downto 0)
);
end reg;

architecture sim of reg is
begin
process(clk) is
begin
if rising_edge(clk) then
	if (writeEnable = '1') then
		reg_out <= reg_input;
	elsif (clear='1') then
		reg_out <= x"00000000";
		
	end if;
end if;
end process;
end sim;
