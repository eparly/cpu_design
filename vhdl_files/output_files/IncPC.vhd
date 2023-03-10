library IEEE;
use IEEE.std_logic_1164.all;

entity IncPC is
port(
    
    PCReg: in std_logic_vector(31 downto 0);

    ZReg: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavior of IncPC is
signal Plus1 : std_logic_vector(31 downto 0);
signal cout : std_logic;
signal cin : std_logic;
signal result : std_logic_vector(31 downto 0);

component CLA32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(31 downto 0);
    cout : out std_logic
);
end component;

begin
    cin <= '0';
    Plus1 <= "00000000000000000000000000000001";
    CLA32_1 : CLA32 port map(ra => PCReg, rb => Plus1, cin => cin, sum => result, cout => cout);
	 process(result)
	 begin
	 ZReg <= result;
	 end process;
end behavior;