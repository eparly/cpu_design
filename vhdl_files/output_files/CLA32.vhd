library IEEE;
use IEEE.std_logic_1164.all;

entity CLA32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(31 downto 0);
    cout : out std_logic
);
end entity;

architecture behavior of CLA16 is

signal cout1 : std_logic;

component CLA16 is
port(
    ra: in std_logic_vector(15 downto 0);
    rb: in std_logic_vector(15 downto 0);
    cin : in std_logic;
    sum : in std_logic_vector(15 downto 0);
    cout : out std_logic
);
end component;

begin
begin
CFA161: reg port map(ra => ra(15 downto 0), rb => rb(15 downto 0), cin => cin, sum=>sum(15 downto 0), cout=>cout1);
CFA162: reg port map(ra => ra(31 downto 16), rb => rb(31 downto 16), cin => cout1, sum=>sum(31 downto 16), cout=>cout);
end behavior;