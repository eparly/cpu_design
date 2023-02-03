library IEEE;
use IEEE.std_logic_1164.all;

entity SHRA32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of SHRA32 is

begin
--idk if works
Zreg <= AReg sra BReg;
end behavior;