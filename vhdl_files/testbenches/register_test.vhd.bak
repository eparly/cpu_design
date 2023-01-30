library ieee;
use ieee.std_logic_1164.all;

entity register_tb is
end entity;

architecture behavior of register_tb is
    component reg is
        port( signal reg_input : in std_logic_vector(31 downto 0);
        signal clk: in std_logic;
        signal clear: in std_logic;
        signal writeEnable: in std_logic;
        signal reg_out : out std_logic_vector(31 downto 0);
        );
    --first time using port mapping, i have no idea if this is right, trying to feed RegIn to reg_input, and reg_out to MDROut
    end component;

  signal clk : std_logic := '0';
  signal reg_input : std_logic := '0';
  signal writeEnable : std_logic := '0';
  signal clear: std_logic := '0';
  signal reg_out : std_logic;

begin

  dut : register
    port map (
      clk => clk,
      reg_input => reg_input,
      reg_out => reg_out,
      writeEnable => writeEnable,
      clear => clear
    );

  clk_gen : process
  begin
    wait for 5 ns;
    clk <= not clk;
    if now > 100 ns then
      wait;
    end if;
  end process;

  test_case : process
  begin
    reg_input <= '0';
    writeEnable <= '0';
    wait for 10 ns;

    reg_input <= '1';
    writeEnable <= '1';
    wait for 10 ns;

    reg_input <= '0';
    writeEnable <= '0';
    wait for 10 ns;

    assert dout = '1' report "Test case 1 failed" severity failure;
    wait;
  end process;
end architecture;
