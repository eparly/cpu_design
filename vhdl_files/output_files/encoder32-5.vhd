library IEEE;
use IEEE.std_logic_1164.all;

entity encoder32_5
    port( 
        signal encoderOutput : out std_logic_vector(4 downto 0);
	    signal encoderInput : in std_logic_vector(31 downto 0);
	);

architecture enbehavior of encoder32_5 is

begin
--encoding input from the registers is the same order as in the 32-1 MUX
case encoderInput is
		when "00000000000000000000000000000001" =>
			encoderOutput <= "00000";
        when "00000000000000000000000000000010" =>
			encoderOutput <= "00001";
        when "00000000000000000000000000000100" =>
			encoderOutput <= "00010";
        when "00000000000000000000000000001000" =>
			encoderOutput <= "00011";
        when "00000000000000000000000000010000" =>
			encoderOutput <= "00100";
        when "00000000000000000000000000100000" =>
			encoderOutput <= "00101";
        when "00000000000000000000000001000000" =>
			encoderOutput <= "00110";
        when "00000000000000000000000010000000" =>
			encoderOutput <= "00111";
        when "00000000000000000000000100000000" =>
			encoderOutput <= "01000";
        when "00000000000000000000001000000000" =>
			encoderOutput <= "01001";
        when "00000000000000000000010000000000" =>
			encoderOutput <= "01010";
        when "00000000000000000000100000000000" =>
			encoderOutput <= "01011";
        when "00000000000000000001000000000000" =>
			encoderOutput <= "01100";
        when "00000000000000000010000000000000" =>
			encoderOutput <= "01101";
        when "00000000000000000100000000000000" =>
			encoderOutput <= "01110";
        when "00000000000000001000000000000000" =>
			encoderOutput <= "01111";
        when "00000000000000010000000000000000" =>
			encoderOutput <= "10000";
        when "00000000000000100000000000000000" =>
			encoderOutput <= "10001";
        when "00000000000001000000000000000000" =>
			encoderOutput <= "10010";
        when "00000000000010000000000000000000" =>
			encoderOutput <= "10011";
        when "00000000000100000000000000000000" =>
			encoderOutput <= "10100";
        when "00000000001000000000000000000000" =>
			encoderOutput <= "10101";
        when "00000000010000000000000000000000" =>
			encoderOutput <= "10110";
        when "00000000100000000000000000000000" =>
			encoderOutput <= "10111";
		when others =>
			encoderOutput <= "01111";
	end case;

end enbehavior;

