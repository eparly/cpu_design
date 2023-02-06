library IEEE;
use IEEE.std_logic_1164.all;

entity MUL32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    rz : out std_logic_vector(63 downto 0)
);
end MUL32;

architecture behavior of MUL32 is
begin

process(ra, rb)

variable result, tempResult: std_logic_vector(63 downto 0);
variable addM, subM, zero: std_logic_vector(31 downto 0);
begin

addM := ra;
subM := 0-rb; --we are allowed the use +- for mul and div
result := "00000000000000000000000000000000000000000000000000000000000000000000";
zeros := "00000000000000000000000000000000";

for i in 0 to 31 loop
    if (i=0) then --first bit is handled differently in booth
        if (rb(0) = '1') then
            tempResult(31 downto 0) <= subM;
        end if;
    else           --not first bit, now we do the normal booth check, having 11 or 00 we can simply ignore (no need to add zeros, just remember to shift afterwarsd)
        if (rb(i)='1' and rb(i-1)='0') then -- -1
            tempResult(31 downto 0) := subM;
        elsif (rb(i)='0' and rb(i-1)='1') then -- +1
            tempResult(31 downto 0) := addM;
        else
            tempResult := zeros;
        end if;
    end if;
    --tempResult is only holding 32 bits, need to extend to 64 via what sign it has
    if (tempResult(31)='0') then
        tempResult(63 downto 32) := "00000000000000000000000000000000";
    else
        tempResult(63 downto 32) := "11111111111111111111111111111111";
    end if;
    tempResult := tempResult sll i; --remember in booth algorithm every time we add something its shifted by one
    result := result + tempResult;
end loop; 
rz <= result;
end process;
end behavior;