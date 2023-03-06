--select and encoder
library IEEE;
use IEEE.std_logic_1164.all;

entity sel_and_encode is
port(
ir_in : in std_logic_vector(31 downto 0);
gra, grb, grc, rin, rout, baout : in std_logic;
rin_out, rout_out : out std_logic_vector(15 downto 0);
C_sign_extended_out : out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of sel_and_encode is
signal wire_regID : std_logic_vector(3 downto 0);
begin
--process to adjust copy over the constant from the IR: sign-extended
process(ir_in)
begin
for i in 31 downto 18 loop
	C_sign_extended_out(i) <= ir_in(18);
end loop;
C_sign_extended_out(17 downto 0) <= ir_in(17 downto 0);
end process;

--process to capture 4 bits from IR to determine registers 0-15 based on "gr#" signals to determine location in IR
process(ir_in, gra, grb, grc)
begin
if (gra = '1') then
	wire_regID <= ir_in(26 downto 23);
elsif (grb = '1') then
	wire_regID <= ir_in(22 downto 19);
elsif (grc = '1') then
	wire_regID <= ir_in(18 downto 15);
else
	wire_regID <= ir_in(26 downto 23); --default to assuming RA because i can
end if;
end process;

--process to decode the four bits we just pulled from IR, to determine which REn or Rout signal to send!
process(wire_regID, rin, rout, baout)
begin
		if (rin = '1') then --decode the four bits to decide which Register to enable
			case wire_regID is
				when "0000" => rin_out <= "0000000000000001";
				when "0001" => rin_out <= "0000000000000010";
				when "0010" => rin_out <= "0000000000000100";
				when "0011" => rin_out <= "0000000000001000";
				when "0100" => rin_out <= "0000000000010000";
				when "0101" => rin_out <= "0000000000100000";
				when "0110" => rin_out <= "0000000001000000";
				when "0111" => rin_out <= "0000000010000000";
				when "1000" => rin_out <= "0000000100000000";
				when "1001" => rin_out <= "0000001000000000";
				when "1010" => rin_out <= "0000010000000000";
				when "1011" => rin_out <= "0000100000000000";
				when "1100" => rin_out <= "0001000000000000";
				when "1101" => rin_out <= "0010000000000000";
				when "1110" => rin_out <= "0100000000000000";
				when "1111" => rin_out <= "1000000000000000";
				when others => rin_out <= "0000000000000000";	--if the IR contents are corrupted
			end case;
		else
			rin_out <= "0000000000000000";	--if rin = 0, set to default
		end if;
		if (baout = '1') then --if the baout signal is given, and we've selected R0, then we want to put the R0 contents onto the bus, which should be all zeros (read bottom comment)
			if wire_regID = "0000" then
				rout_out <= "0000000000000001";
			end if;
		end if;
		if (rout = '1') then --decode the four bits to decide which register puts it's contents onto the bus
			case wire_regID is
				when "0000" =>	rout_out <= "0000000000000001";
				when "0001" => rout_out <= "0000000000000010";
				when "0010" => rout_out <= "0000000000000100";
				when "0011" => rout_out <= "0000000000001000";
				when "0100" => rout_out <= "0000000000010000";
				when "0101" => rout_out <= "0000000000100000";
				when "0110" => rout_out <= "0000000001000000";
				when "0111" => rout_out <= "0000000010000000";
				when "1000" => rout_out <= "0000000100000000";
				when "1001" => rout_out <= "0000001000000000";
				when "1010" => rout_out <= "0000010000000000";
				when "1011" => rout_out <= "0000100000000000";
				when "1100" => rout_out <= "0001000000000000";
				when "1101" => rout_out <= "0010000000000000";
				when "1110" => rout_out <= "0100000000000000";
				when "1111" => rout_out <= "1000000000000000";
				when others => rout_out <= "0000000000000000"; ----if the IR contents are corrupted
			end case;
		else
			if (baout = '0') then --covers the case of Rout = 0 and baout = 0 
				rout_out <= "0000000000000000";
			end if;
		end if;	
end process;
end behavior;

--just to clarify, the contents of R0 can be put onto the bus given the following combinations
--Rout = 0, baout = 1
--Rout = 1, baout = 0
--Rout = 1, baout = 1
--this is based on the diagrams given in the phase2 pdf