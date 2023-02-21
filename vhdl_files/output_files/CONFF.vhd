library IEEE;
use IEEE.std_logic_1164.all;

entity CONFF is
port(
	BusInput : in std_logic_vector(31 downto 0); --contents of the Ra from 4 bits in IR
	CONFFEn : in std_logic;
	IRbits : in std_logic_vector(1 downto 0);
	passed : out std_logic
);
end entity; 

architecture behavior of CONFF is
	
begin
process(BusInput, CONFFEn, IRbits)
begin
if (CONFFEn = '1') then
	case IRbits is
		when "00" => --branch if zero, test buscontents
			if (busInput = x"00000000") then
				passed <= '1';
			else
				passed <= '0';
			end if;
		when "01" => --branch if not zero, test buscontents
			if (busInput /= x"00000000") then
				passed <= '1';
			else
				passed <= '0';
			end if;
		when "10" => --branch if positive, test buscontents
			if (busInput(31) = '0') then
				passed <= '1';
			else
				passed <= '0';
			end if;
		when "01" => --branch if negative, test buscontents
			if (busInput(31) = '1') then
				passed <= '1';
			else
				passed <= '0';
			end if;
	end case;
else
passed <= '0';
end if;
end process;
end behavior;