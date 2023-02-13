library ieee;
use ieee.std_logic_1164.all;

entity MDR_tb is
end entity;

architecture behavior of MDR_tb is

signal BusInput, MemDataIn, MDROut : std_logic_vector(31 downto 0);
signal sel, clk, clear, writeEnable : std_logic;

component MDR is
    port(
        BusInput: in std_logic_vector(31 downto 0);
        MemDataIn: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        MDROut: out std_logic_vector(31 downto 0); --will need to be configured later to go to bus or memory chip (phase 3)
        --i think i need the following for the register component?
        --signal MDRclk: in std_logic; maybe not the clk? irdk
		  clk: in std_logic;
		  clear: in std_logic;
        writeEnable: in std_logic
    );
end component;

begin
DUT : MDR port map(BusInput => BusInput, MemDataIn => MemDataIn, sel => sel, MDROut => MDROut, clk => clk, clear => clear, writeEnable => writeEnable);

Clock_process: PROCESS IS
BEGIN
clk <= '1', '0' after 10 ns;
Wait for 20 ns;
END PROCESS Clock_process;

Test_process : process
	begin
		wait until rising_edge(clk);
		writeEnable <= '0';
		BusInput <= x"F0F0_F0F0";
		MemDataIn <= x"FFFF_0000";
		wait until rising_edge(clk);
		sel <= '1';
		wait until rising_edge(clk);
		writeEnable <= '1';
		wait until rising_edge(clk);
		sel <='0';
		wait until rising_edge(clk);
		MemDataIn <= x"0000_FFFF";
		wait for 7 ns;
		clear <='1';
		wait until rising_edge(clk);
		sel<='0';
		clear <='0';
		wait until rising_edge(clk);
		MDin_tb <=x"0F0F0F0F";
		sel <= '1';
		writeEnable <= '0';
		wait;
	end process Test_process;

end behavior;