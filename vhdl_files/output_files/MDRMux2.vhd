library IEEE;
use IEEE.std_logic_1164.all;

entity MDRMux2 is 
	port(
		sel : in std_logic;
		ManualInput : in std_logic_vector(31 downto 0);
		FromRAM : in std_logic_vector(31 downto 0);
		TowireMemDatain : out std_logic_vector(31 downto 0)
	);
end entity;

architecture behavior of MDRMux2 is
begin
process(sel, ManualInput, FromRAM)
begin
	if sel = '0' then
		TowireMemDatain <= ManualInput;
	else
		TowireMemDatain <= FromRAM; --default reading from RAM
	end if;
end process;
end behavior;
	