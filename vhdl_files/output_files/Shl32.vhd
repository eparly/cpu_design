library IEEE;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity SHL32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of SHL32 is

begin
--idk if works
process(AReg, BReg)
variable ATemp : signed(31 downto 0);
variable BTemp : integer;
variable ZTemp : signed(31 downto 0);
begin
ATemp := resize(signed(AReg), ATemp'length);
BTemp := to_integer(unsigned(BReg));
ZTemp := ATemp sll BTemp;
ZReg <= std_logic_vector(ZTemp);
end process;
end behavior;