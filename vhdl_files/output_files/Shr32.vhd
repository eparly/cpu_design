library IEEE;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity SHR32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of SHR32 is

begin
--idk if works
process(AReg, BReg)
variable BTemp : integer;
begin
BTemp := to_integer(unsigned(BReg));
ZReg <= std_logic_vector(shift_right(unsigned(AReg), BTemp));
end process;
end behavior;