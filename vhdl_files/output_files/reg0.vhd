library IEEE;
use IEEE.std_logic_1164.all;

entity reg0 is
port( 
reg_input : in std_logic_vector(31 downto 0);
clk: in std_logic;
clear: in std_logic;
baout : in std_logic;
writeEnable: in std_logic; --R#In
reg_out : out std_logic_vector(31 downto 0)
);
end reg0;

architecture behavior of reg0 is

signal tempOutput : std_logic_vector(31 downto 0);
signal baout32 : std_logic_vector(31 downto 0);
signal wire_reg_input : std_logic_vector(31 downto 0);
signal wire_clk : std_logic;
signal wire_clr : std_logic;
signal wire_baout : std_logic;
signal wire_writeEnable : std_logic;

component reg is
port( signal reg_input : in std_logic_vector(31 downto 0);
signal clk: in std_logic;
signal clear: in std_logic;
signal writeEnable: in std_logic; --R#In
signal reg_out : out std_logic_vector(31 downto 0)
);
end component; 

begin

interalReg : reg port map(reg_input => wire_reg_input, clk => wire_clk, clear => wire_clr, writeEnable => wire_writeEnable, reg_out => tempOutput);

process(clk)
begin
wire_reg_input <= reg_input;
wire_baout <= baout;
wire_clk <= clk;
wire_clr <= clear;
wire_writeEnable <= writeEnable;

if (wire_baout = '1') then
	baout32 <= (others => '1');
else 
	baout32 <= (others => '0');
end if;	
	
reg_out <= tempOutput and not baout32;

end process;
end behavior;