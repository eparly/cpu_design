library IEEE;
use IEEE.std_logic_1164.all;

entity NEG32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of NOT32 is
signal temp : std_logic_vector(31 downto 0);
signal plus1 : std_logic_vector(31 downto 0);
signal cout : std_logic;
signal cin : std_logic;

component NOT32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component CLA32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(31 downto 0);
    cout : out std_logic
);
end component;

begin
plus1 <= "00000000000000000000000000000001";
cin <= '0';

Not_1 : NOT32 port map(AReg => AReg, ZReg => temp); --temp will hold the result of the not operation now
CLA32_1 : CLA32 port map(ra => temp, rb => plus1, cin => cin, sum => ZReg, cout => cout); --at the result of the not operation with 1

end behavior;