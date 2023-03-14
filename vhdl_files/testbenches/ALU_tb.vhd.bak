library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end entity;

architecture behavior of ALU_tb is

signal clk, clear, And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: std_logic;
signal AReg, BReg: std_logic_vector(31 downto 0);
signal ZReg : std_logic_vector(63 downto 0); 

component ALU is
port(
    signal clk: in std_logic;
    signal clear: in std_logic;

    AReg, BReg: in std_logic_vector(31 downto 0);
--replacing the opcode with individual signals
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;

    ZReg: out std_logic_vector(63 downto 0)
);
end component;

begin
DUT : ALU port map(clk => clk, clear=> clear, And_sig => And_sig, Or_sig => Or_sig, Add_sig => Add_sig, Sub_sig => Sub_sig, Mul_sig => Mul_sig, Div_sig => Div_sig, Shr_sig => Shr_sig, Shl_sig => Shl_sig, Shra_sig => Shra_sig, Ror_sig => Ror_sig, Rol_sig => Rol_sig, Neg_sig => Neg_sig, Not_sig => Not_sig, IncPC_sig => IncPC_sig, AReg => AReg, BReg => BReg, ZReg => ZReg);

Clock_process: PROCESS IS
BEGIN
clk <= '1', '0' after 10 ns;
Wait for 20 ns;
END PROCESS Clock_process;

Test_process : process
	begin
		wait until rising_edge(clk);
		Add_sig <= '1';
		AReg <= x"0000_0010";
		BReg <= x"0000_0001";
		wait until rising_edge(clk);
		Add_sig <= '0';
        And_sig <= '1';
		wait until rising_edge(clk);
		And_sig <= '0';
        Or_sig <= '1';
		wait until rising_edge(clk);
		Or_sig <= '0';
        Sub_sig <= '1';
		wait until rising_edge(clk);
		Sub_sig <= '0';
        Mul_sig <= '1';
		wait until rising_edge(clk);
		Mul_sig <= '0';
        Div_sig <= '1';
		wait until rising_edge(clk);
		Div_sig <= '0';
        Shr_sig <= '1';
        wait until rising_edge(clk);
		Shr_sig <= '0';
        Shl_sig <= '1';
        wait until rising_edge(clk);
		Shl_sig <= '0';
        Shra_sig <= '1';
        wait until rising_edge(clk);
		Shra_sig <= '0';
        Ror_sig <= '1';
        wait until rising_edge(clk);
		Ror_sig <= '0';
        Rol_sig <= '1';
        wait until rising_edge(clk);
		Rol_sig <= '0';
        Neg_sig <= '1';
        wait until rising_edge(clk);
		Neg_sig <= '0';
        Not_sig <= '1';
        wait until rising_edge(clk);
		Not_sig <= '0';
        IncPC_sig <= '1';
		wait;
end process Test_process;

end behavior;
