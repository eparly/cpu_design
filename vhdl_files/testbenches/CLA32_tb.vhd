library ieee;
use ieee.std_logic_1164.all;

entity CLA32_tb is
end entity;

architecture behavior of CLA32 is
signal ra, rb, sum : std_logic_vector(31 downto 0);
signal cin, cout : std_logic;

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
DUT : CLA32 port map(ra=>ra, rb=>rb, cin=>cin, sum=>sum, cout=>cout);

Test_process : process
begin
cin <= '0';
ra <= x"00000001";
rb <= x"00000001";
end process;
end behavior;
