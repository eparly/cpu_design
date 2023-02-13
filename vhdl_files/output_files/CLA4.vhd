library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

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




begin
process(ra, rb, cin)
variable P : signed(3 downto 0);
variable G : signed(3 downto 0);
variable C : signed(3 downto 0);
begin


P := resize(signed(ra xor rb), G'length);
G := resize(signed(ra and rb), G'length);
C(0) := cin;
C(1) := G(0) or (P(0) and C(0));
C(2) := G(1) or (P(1) and G(0)) or (P(1) and P(0) and C(0));
--------------------------
C(3) := (G(2) and (P(2) and G(1))) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and C(0));
--------------------------


cout <= std_logic(G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and C(0)));
sum <= std_logic_vector(P xor C);

end process;
end behavior;
