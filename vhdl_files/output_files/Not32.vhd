library IEEE;
use IEEE.std_logic_1164.all;

entity NOT32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of NOT32 is

begin
--i assume they expect us to AND one bit at a time
process
begin
And_loop : for i in 0 to 31 loop
    Zreg(i) <= not AReg(i);
end loop And_loop;
end process;
end behavior;