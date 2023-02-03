library ieee;
use ieee.std_logic_1164.all;

entity tb_carry_lookahead_adder is
end tb_carry_lookahead_adder;

architecture tb of tb_carry_lookahead_adder is
   component CLA4 is
	port(
    ra: in std_logic_vector(3 downto 0);
    rb: in std_logic_vector(3 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(3 downto 0);
    cout : out std_logic
	);
	end component;

   signal ra, rb, sum, cin, cout : std_logic_vector(3 downto 0);
begin
   dut: CLA4
      port map (ra => ra, rb => rb, sum => sum, cin => cin, cout => cout);

   -- Test case 1: add two positive numbers
	testcase1: process
		begin
		ra <= "0010";
		rb <= "0101";
		cin <= '0';
		wait for 10 ns;
		assert (sum = "0111") report "Test case 1 failed" severity failure;
		wait;
	end process;

   -- Test case 2: add two negative numbers with a carry in
--   ra <= "1101";
--   rb <= "1011";
--   carry_in <= '1';
--   wait for 10 ns;
--   assert (sum = "0111") report "Test case 2 failed" severity failure;

   -- Add additional test cases as desired
end tb;
