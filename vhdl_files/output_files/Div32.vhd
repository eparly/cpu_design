library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

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
    variable A, Q, M : unsigned(31 downto 0);
    variable count : integer := 32;
	 variable TempRa, TempRb, TempQuo: std_logic_vector(31 downto 0);
	 variable flag : std_logic;
    begin

				TempQuo := x"00000000";
				TempRa := ra;
				TempRb := rb;
				flag := '0';
				if (ra(31) = '1') then
					if (rb(31) = '1') then
						TempRa := (0-ra);
						TempRb := (0-rb);
					else 
						TempRa := (0-ra);
						flag := '1';
						end if;
				elsif (rb(31) = '1') then
					TempRb := (0-rb);
					flag := '1';
				end if;
				
            Q := resize(unsigned(TempRa), Q'length);
            A := (others => '0');
            M := resize(unsigned(TempRb), M'length);

            for i in 0 to 31 loop
				--shifting, but weird
					 A := SHIFT_LEFT(UNSIGNED(A), 1);
					 if (Q(31) = '1') then
						 A(0) := '1';
					 else
						 A(0) := '0';
					 end if;
					 Q := SHIFT_LEFT(UNSIGNED(Q), 1);
                if A(31) = '0' then
                    A := (unsigned(A) - unsigned(M)); 
                else
                    A := (unsigned(A) + unsigned(M));
					 end if;
					 if A(31) = '0' then
                    Q(0) := '1';   
                else
                    Q(0) := '0';
                end if;
            end loop;
				if A(31) = '1' then
					 A := (unsigned(A) + unsigned(M));
				end if;

				TempRa := std_logic_vector(Q);
				if (flag = '1') then
					TempQuo := (0-TempRa);
				else
					TempQuo := TempRa;
				end if;
            rz(63 downto 32) <= std_logic_vector(A);
            rz(31 downto 0) <= TempQuo;
    end process;
end behavior;
