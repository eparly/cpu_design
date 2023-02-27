library ieee;
use ieee.std_logic_1164.all;

entity cla16_tb is
end cla16_tb;

architecture tb of cla16_tb is
   component CLA16 is
	port(
    ra: in std_logic_vector(15 downto 0);
    rb: in std_logic_vector(15 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(15 downto 0);
    cout : out std_logic
	);
	end component;

   signal ra, rb, sum : std_logic_vector(15 downto 0);
	signal cin, cout : std_logic;
begin
   dut: CLA16
      port map (ra => ra, rb => rb, sum => sum, cin => cin, cout => cout);

   -- Test case 1: add two positive numbers
	testcase1: process
		begin
		ra <= x"0001";
		rb <= x"0002";
		cin <= '0';
		wait for 10 ns;
		assert (sum = x"0003") report "Test case 1 failed" severity failure;
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
