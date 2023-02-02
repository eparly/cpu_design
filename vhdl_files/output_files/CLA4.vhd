library IEEE;
use IEEE.std_logic_1164.all;

entity CLA4 is
port(
    ra: in std_logic_vector(3 downto 0);
    rb: in std_logic_vector(3 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(3 downto 0);
    cout : out std_logic
);
end entity;

architecture behavior of CLA4 is

signal P : std_logic_vector(3 downto 0);
signal G : std_logic_vector(3 downto 0);
signal C : std_logic_vector(3 downto 0);

begin
process
begin
P = Ra xor Rb;
G = Ra and Rb;
C(0) = cin;
c(1) = G(0) or (P(0) and C(0));
c(2) = G[1] or (P[1] and G[0]) or (P[1] and P[0] and c[0]);
c(3) = G[2] and (P[2] and G[1]) or (P[2] and P[1] and G[0]) or (P[2] and P[1] and P[0] and c[0]);
cout = G[3] or (P[3] and G[2]) or (P[3] and P[2] and G[1]) or (P[3] and P[2] and P[1] and G[0]) or (P[3] and P[2] and P[1] and P[0] and c[0]);
sum = P xor c;

end process;
end behavior;
