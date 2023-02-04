library IEEE;
use IEEE.std_logic_1164.all;

--register used to recieve memory data to/from the Bus or memory chip

entity MDR is
    port(
        BusInput: in std_logic_vector(31 downto 0);
        MemDataIn: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        MDROut: out std_logic_vector(31 downto 0); --will need to be configured later to go to bus or memory chip (phase 3)
        --i think i need the following for the register component?
        --signal MDRclk: in std_logic; maybe not the clk? irdk
		MDRclk: in std_logic;
        MDRclear: in std_logic;
        MDRwriteEnable: in std_logic
    );
end MDR;

architecture behavior of MDR is
signal RegIn: std_logic_vector(31 downto 0); --whatever the sel selects, goes into the register component

component reg is
port( signal reg_input : in std_logic_vector(31 downto 0);
	clk: in std_logic;
	clear: in std_logic;
	writeEnable: in std_logic;
	reg_out : out std_logic_vector(31 downto 0)
);
--first time using port mapping, i have no idea if this is right, trying to feed RegIn to reg_input, and reg_out to MDROut
end component;

begin 
MDRReg: reg port map(reg_input => RegIn, reg_out => MDROut, clear => MDRclear, writeEnable=>MDRwriteEnable, clk=>MDRclk);

process (sel, BusInput)
begin
case sel is
    when '0' =>
        RegIn <= BusInput;
    when '1' =>
        RegIn <= MemDataIn;
    when others =>
        RegIn <=BusInput; --we don't have the memory stuff setup yet, default to recieve from bus
end case;
end process;
end architecture;

-- i have no idea if this is right
--test