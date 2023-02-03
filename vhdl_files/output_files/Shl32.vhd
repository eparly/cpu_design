library IEEE;
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
Zreg <= AReg sll BReg;
end behavior;