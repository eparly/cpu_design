library IEEE;
use IEEE.std_logic_1164.all;

entity CLA16 is
port(
    ra: in std_logic_vector(15 downto 0);
    rb: in std_logic_vector(15 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(15 downto 0);
    cout : out std_logic
);
end entity;

architecture behavior of CLA16 is

signal cout1 : std_logic;
signal cout2 : std_logic;
signal cout3 : std_logic;

component CLA4 is
port(
    ra: in std_logic_vector(3 downto 0);
    rb: in std_logic_vector(3 downto 0);
    cin : in std_logic;
    sum : in std_logic_vector(3 downto 0);
    cout : out std_logic
);
end component;

begin
CFA41: reg port map(ra => ra(3 downto 0), rb => rb(3 downto 0), cin => cin, sum=>sum(3 downto 0), cout=>cout1);
CFA42: reg port map(ra => ra(7 downto 4), rb => rb(7 downto 4), cin => cout1, sum=>sum(7 downto 4), cout=>cout2);
CFA43: reg port map(ra => ra(11 downto 8), rb => rb(11 downto 8), cin => cout2, sum=>sum(11 downto 8), cout=>cout3);
CFA44: reg port map(ra => ra(15 downto 12), rb => rb(15 downto 12), cin => cout3, sum=>sum(15 downto 12), cout=>cout);

end behavior;