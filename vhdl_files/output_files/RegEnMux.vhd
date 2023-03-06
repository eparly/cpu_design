library IEEE;
use IEEE.std_logic_1164.all;

entity RegEnMux is 
	port(
		sel : in std_logic;
		ManualInput : in std_logic;
		FromSE : in std_logic;
		TowireMemDatain : out std_logic
	);
end entity;

architecture behavior of RegEnMux is
begin
process(sel, ManualInput, FromSE)
begin
	if sel = '0' then
		TowireMemDatain <= ManualInput;
	else
		TowireMemDatain <= FromSE; --default reading from Select and Encoder
	end if;
end process;
end behavior;
	