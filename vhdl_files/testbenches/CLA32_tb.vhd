library ieee;
use ieee.std_logic_1164.all;

entity CLA32_tb is
end entity;

architecture behavior of CLA32_tb is
signal cla_ra, cla_rb, cla_sum : std_logic_vector(31 downto 0);
signal cla_cin, cla_cout : std_logic;

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
DUT : CLA32 port map(ra=>cla_ra, rb=>cla_rb, cin=>cla_cin, sum=>cla_sum, cout=>cla_cout);

Test_process : process
begin
wait for 30 ns;
cla_cin <= '0';
wait for 10 ns;
cla_ra <= x"00000001";
wait for 10 ns;
cla_rb <= x"00000001";
wait for 30 ns;
end process;
end behavior;
