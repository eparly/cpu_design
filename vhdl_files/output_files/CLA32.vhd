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

architecture behavior of CLA32 is

signal cout1 : std_logic;
signal cout2 : std_logic;
signal TempSum : std_logic_vector(31 downto 0);

component CLA16 is
port(
    ra: in std_logic_vector(15 downto 0);
    rb: in std_logic_vector(15 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(15 downto 0);
    cout : out std_logic
);
end component;

begin
CFA161: CLA16 port map(ra => ra(15 downto 0), rb => rb(15 downto 0), cin => cin, sum=>TempSum(15 downto 0), cout=>cout1);
CFA162: CLA16 port map(ra => ra(31 downto 16), rb => rb(31 downto 16), cin => cout1, sum=>TempSum(31 downto 16), cout=>cout2);
process(TempSum)
begin
sum <= TempSum;
cout <= cout2;
end process;
end behavior;