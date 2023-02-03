library IEEE;
use IEEE.std_logic_1164.all;

entity OR32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of OR32 is

begin
--i assume they expect us to AND one bit at a time
Or_loop : for i in 0 to 31 loop
    Zreg(i) = AReg(i) or BReg(i);
end loop Or_loop;
end behavior;