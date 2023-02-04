library IEEE;
use IEEE.std_logic_1164.all;

entity DIV32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    rz : out std_logic_vector(63 downto 0) --quotient will be held in the first 32 bits, then the remainder will go in front
);
end entity;
--assume format is ra/rb
architecture behavior of DIV32 is

begin

process(ra, rb)
variable A : std_logic_vector(31 downto 0); --will hold the eventual remainder
variable Q : std_logic_vector(31 downto 0); --will hold the quotient
variable subM : std_logic_vector(31 downto 0);
variable addM : std_logic_vector(31 downto 0);
begin
A := "00000000000000000000000000000000";
Q := rb;
subM := (0-ra);
addM := ra

for i in 0 to 31 loop
    A := sll 1;
    Q := sll 1;
    if (A < 0) then
        A := A + addM;
    else
        A := A - subM;
    end if;
    if (A < 0) then
        Q(0) = '0';
    else
        Q(0) = '1';
    end if;
end loop;
if (A<0) then
    A := A + addM;
end if;
--A holds the remainder, Q holds the quotient
rz(31 downto 0) = Q;
rz(63 downto 32) = A;
end process;
end behavior;
