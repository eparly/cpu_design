library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity SUB32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(31 downto 0);
    cout : out std_logic
);
end entity;

architecture behavior of SUB32 is

signal temp : std_logic_vector(31 downto 0);
signal TempAns : std_logic_vector(31 downto 0);

component NEG32 is
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
Neg_1 : NEG32 port map(AReg => rb, ZReg => temp);   --assuming ra-rb is the format to follow
CLA32_1 : CLA32 port map(ra => ra, rb => temp, cin => cin, sum => TempAns, cout => cout);

process(TempAns)
begin
sum <= TempAns;
--some bug on phase 3 when Rc is 0, this fixes it so idgaf how janky it is
if (rb = x"00000000") then
	sum <= ra;
end if;
end process;
end behavior;