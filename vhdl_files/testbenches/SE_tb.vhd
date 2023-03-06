library ieee;
use ieee.std_logic_1164.all;

entity SE_tb is
end entity;

architecture behavior of SE_tb is

signal ir_in : std_logic_vector(31 downto 0);
signal gra, grb, grc, rin, rout, baout : std_logic;
signal rin_out, rout_out : std_logic_vector(15 downto 0);
signal C_sign_extended_out : std_logic_vector(31 downto 0);

component sel_and_encode is
port(
ir_in : in std_logic_vector(31 downto 0);
gra, grb, grc, rin, rout, baout : in std_logic;
rin_out, rout_out : out std_logic_vector(15 downto 0);
C_sign_extended_out : out std_logic_vector(31 downto 0)
);
end component;

begin
SE1: sel_and_encode port map(ir_in => ir_in, gra => gra, grb => grb, grc => grc, rin => rin, rout => rout, baout => baout, rin_out => rin_out, rout_out => rout_out, C_sign_extended_out => C_sign_extended_out);

Test_process : process
	begin
		wait for 50 ns;
		ir_in <= x"0080004B";
		gra <= '1';
		rin <= '1';
		wait;
end process Test_process;

end behavior;