library IEEE;
use IEEE.std_logic_1164.all;

entity ROL32 is
    port(
        AReg: in std_logic_vector(31 downto 0);
        BReg: in std_logic_vector(4 downto 0); --number of rotations
        ZReg: out std_logic_vector(31 downto 0) 
    );
end ROL32;

--get number of rotations, take that number of bits from the start of AReg (now the MSB), and save the rest of the bits as the LSB, then overwrite AReg using the new MSB and LSB -> requires way to much work to port map and adjust everything
--im hard coding all possible rotations idgaf, probably better performance
architecture behavior of ROL32 is
begin 
process(AReg, BReg)
begin
    case BReg is
        when "00001" =>
            ZReg(31 downto 1) <= AReg(30 downto 0);
            ZReg(0) <= AReg(31);
        when "00010" =>
            ZReg(31 downto 2) <= AReg(29 downto 0);
            ZReg(1 downto 0) <= AReg(31 downto 30);
        when "00011" =>
            ZReg(31 downto 3) <= AReg(28 downto 0);
            ZReg(2 downto 0) <= AReg(31 downto 29);
        when "00100" =>
            ZReg(31 downto 4) <= AReg(27 downto 0);
            ZReg(3 downto 0) <= AReg(31 downto 28);
        when "00101" =>
            ZReg(31 downto 5) <= AReg(26 downto 0);
            ZReg(4 downto 0) <= AReg(31 downto 27);
        when "00110" =>
            ZReg(31 downto 6) <= AReg(25 downto 0);
            ZReg(5 downto 0) <= AReg(31 downto 26);
        when "00111" =>
            ZReg(31 downto 7) <= AReg(24 downto 0);
            ZReg(6 downto 0) <= AReg(31 downto 25);
        when "01000" =>
            ZReg(31 downto 8) <= AReg(23 downto 0);
            ZReg(7 downto 0) <= AReg(31 downto 24);
        when "01001" =>
            ZReg(31 downto 9) <= AReg(22 downto 0);
            ZReg(8 downto 0) <= AReg(31 downto 23);
        when "01010" =>
            ZReg(31 downto 10) <= AReg(21 downto 0);
            ZReg(9 downto 0) <= AReg(31 downto 22);
        when "01011" =>
            ZReg(31 downto 11) <= AReg(20 downto 0);
            ZReg(10 downto 0) <= AReg(31 downto 21);
        when "01100" =>
            ZReg(31 downto 12) <= AReg(19 downto 0);
            ZReg(11 downto 0) <= AReg(31 downto 20);
        when "01101" =>
            ZReg(31 downto 13) <= AReg(18 downto 0);
            ZReg(12 downto 0) <= AReg(31 downto 19);
        when "01110" =>
            ZReg(31 downto 14) <= AReg(17 downto 0);
            ZReg(13 downto 0) <= AReg(31 downto 18);
        when "01111" =>
            ZReg(31 downto 15) <= AReg(16 downto 0);
            ZReg(14 downto 0) <= AReg(31 downto 17);
        when "10000" =>
            ZReg(31 downto 16) <= AReg(15 downto 0);
            ZReg(15 downto 0) <= AReg(31 downto 16);
        when "10001" =>
            ZReg(31 downto 17) <= AReg(14 downto 0);
            ZReg(16 downto 0) <= AReg(31 downto 15);
        when "10010" =>
            ZReg(31 downto 18) <= AReg(13 downto 0);
            ZReg(17 downto 0) <= AReg(31 downto 14);
        when "10011" =>
            ZReg(31 downto 19) <= AReg(12 downto 0);
            ZReg(18 downto 0) <= AReg(31 downto 13);
        when "10100" =>
            ZReg(31 downto 20) <= AReg(11 downto 0);
            ZReg(19 downto 0) <= AReg(31 downto 12);
        when "10101" =>
            ZReg(31 downto 21) <= AReg(10 downto 0);
            ZReg(20 downto 0) <= AReg(31 downto 11);
        when "10110" =>
            ZReg(31 downto 22) <= AReg(9 downto 0);
            ZReg(21 downto 0) <= AReg(31 downto 10);
        when "10111" =>
            ZReg(31 downto 23) <= AReg(8 downto 0);
            ZReg(22 downto 0) <= AReg(31 downto 9);
        when "11000" =>
            ZReg(31 downto 24) <= AReg(7 downto 0);
            ZReg(23 downto 0) <= AReg(31 downto 8);
        when "11001" =>
            ZReg(31 downto 25) <= AReg(6 downto 0);
            ZReg(24 downto 0) <= AReg(31 downto 7);
        when "11010" =>
            ZReg(31 downto 26) <= AReg(5 downto 0);
            ZReg(25 downto 0) <= AReg(31 downto 6);
        when "11011" =>
            ZReg(31 downto 27) <= AReg(4 downto 0);
            ZReg(26 downto 0) <= AReg(31 downto 5);
        when "11100" =>
            ZReg(31 downto 28) <= AReg(3 downto 0);
            ZReg(27 downto 0) <= AReg(31 downto 4);
        when "11101" =>
            ZReg(31 downto 29) <= AReg(2 downto 0);
            ZReg(28 downto 0) <= AReg(31 downto 3);
        when "11110" =>
            ZReg(31 downto 30) <= AReg(1 downto 0);
            ZReg(29 downto 0) <= AReg(31 downto 2);
        when "11111" =>
            ZReg(31) <= AReg(0);
            ZReg(30 downto 0) <= AReg(31 downto 1);
        when others =>  --anything under 1 or over 31 just gets ignored
            ZReg <= AReg;
    end case;
end process;
end behavior;

