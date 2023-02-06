library IEEE;
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
begin
Zreg <= AReg srl BReg;
end process;
end behavior;