library ieee;
use ieee.std_logic_1164.all;

entity CLA4_tb is
end CLA4_tb;

architecture behavior of CLA4_tb is
   signal ra, rb, sum : std_logic_vector(3 downto 0);
   signal cin, cout : std_logic;

   component CLA4 is
	port(
    ra: in std_logic_vector(3 downto 0);
    rb: in std_logic_vector(3 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(3 downto 0);
    cout : out std_logic
	);
	end component;

begin
dut: CLA4 port map (ra => ra, rb => rb, sum => sum, cin => cin, cout => cout);

	testcase1: process
		begin
        wait for 10 ns;
		ra <= "0010";
		rb <= "0101";
		cin <= '0';
		wait for 10 ns;
		wait;
	end process;

end behavior;
   