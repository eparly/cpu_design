library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end entity;

architecture behavior of ALU_tb is

signal And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: std_logic;
signal AReg, BReg: std_logic_vector(31 downto 0);
signal ZReg : std_logic_vector(63 downto 0); 

component ALU is
port(
--    signal clk: in std_logic;
--    signal clear: in std_logic;

    AReg, BReg: in std_logic_vector(31 downto 0);
--replacing the opcode with individual signals
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;

    ZReg: out std_logic_vector(63 downto 0)
);
end component;

begin
DUT : ALU port map( And_sig => And_sig, Or_sig => Or_sig, Add_sig => Add_sig, Sub_sig => Sub_sig, Mul_sig => Mul_sig, Div_sig => Div_sig, Shr_sig => Shr_sig, Shl_sig => Shl_sig, Shra_sig => Shra_sig, Ror_sig => Ror_sig, Rol_sig => Rol_sig, Neg_sig => Neg_sig, Not_sig => Not_sig, IncPC_sig => IncPC_sig, AReg => AReg, BReg => BReg, ZReg => ZReg);



Test_process : process
	begin
		wait for 50 ns;
		And_sig <= '1';
		wait for 10 ns;
		AReg <= x"0000_0010";
		BReg <= x"0000_0001";
		wait for 50 ns;
		And_sig <= '0';
--		And_sig <= '0';
--		wait for 20 ns;
--        Or_sig <= '1';
--		wait for 20 ns;
--		Or_sig <= '0';
--		wait for 20 ns;
--        Sub_sig <= '1';
--		wait for 20 ns;
--		Sub_sig <= '0';
--		wait for 20 ns;
--        Mul_sig <= '1';
--		wait for 20 ns;
--		Mul_sig <= '0';
--		wait for 20 ns;
--        Div_sig <= '1';
--		wait for 20 ns;
--		Div_sig <= '0';
--		wait for 20 ns;
--        Shr_sig <= '1';
--      wait for 20 ns;
--		Shr_sig <= '0';
--		wait for 20 ns;
--        Shl_sig <= '1';
--      wait for 20 ns;
--		Shl_sig <= '0';
--		wait for 20 ns;
--        Shra_sig <= '1';
--      wait for 20 ns;
--		Shra_sig <= '0';
--		wait for 20 ns;
--        Ror_sig <= '1';
--      wait for 20 ns;
--		Ror_sig <= '0';
--		wait for 20 ns;
--        Rol_sig <= '1';
--      wait for 20 ns;
--		Rol_sig <= '0';
--		wait for 20 ns;
--        Neg_sig <= '1';
--      wait for 20 ns;
--		Neg_sig <= '0';
--		wait for 20 ns;
--        Not_sig <= '1';
--      wait for 20 ns;
--		Not_sig <= '0';
--		wait for 20 ns;
--        IncPC_sig <= '1';
		wait;
end process Test_process;

end behavior;
