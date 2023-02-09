library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
port(
    signal clk: in std_logic;
    signal clear: in std_logic;

    AReg, BReg: in std_logic_vector(31 downto 0);
--replacing the opcode with individual signals
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig: in std_logic;

    ZReg: out std_logic_vector(63 downto 0)
);
end entity;


architecture behavior of ALU is 
--signal definition
signal And_result, Or_result, Add_result, Sub_result, Shr_result, Shl_result, Shra_result, Ror_result, Rol_result, Neg_result, Not_result: std_logic_vector(31 downto 0);

signal Mul_result , Div_result: std_logic_vector(63 downto 0); --careful

--additional stuff needed for the add and sub operations
signal AddCout, SubCout, AddCin, SubCin : std_logic;

--paste ALL the components for all the _sigerations in here
component CLA32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(31 downto 0);
    cout : out std_logic
);
end component;

component AND32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component DIV32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    rz : out std_logic_vector(63 downto 0) --quotient will be held in the first 32 bits, then the remainder will go in front
);
end component;

component MUL32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    rz : out std_logic_vector(63 downto 0)
);
end component;

component NEG32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component NOT32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component OR32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component ROL32 is
    port(
        AReg: in std_logic_vector(31 downto 0);
        BReg: in std_logic_vector(4 downto 0); --number of rotations
        ZReg: out std_logic_vector(31 downto 0) 
    );
end component;

component ROR32 is
    port(
        AReg: in std_logic_vector(31 downto 0); --thing being rotated
        BReg: in std_logic_vector(4 downto 0); --number of rotations (limit to 5 bits)
        ZReg: out std_logic_vector(31 downto 0) 
    );
end component;

component SHL32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component SHR32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component SHRA32 is
port(

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(31 downto 0)
);
end component;

component SUB32 is
port(
    ra: in std_logic_vector(31 downto 0);
    rb: in std_logic_vector(31 downto 0);
    cin : in std_logic;
    sum : out std_logic_vector(31 downto 0);
    cout : out std_logic
);
end component;

begin
--port mapping EVERYTHING
AddCin <= '0';
SubCin <= '0';

Add_sig : CLA32 port map(ra => YReg, rb => BReg, cin => AddCin, sum => Add_result, cout => AddCout);
And_sig : AND32 port map(AReg => YReg, BReg => BReg, ZReg => And_result);
Div_sig : DIV32 port map(ra => YReg, rb => BReg, rz => Div_result);
Mul_sig : MUL32 port map(ra => YReg, rb => BReg, rz => Mul_result);
Neg_sig : NEG32 port map(AReg => YReg, ZReg => Neg_result);
Not_sig : NOT32 port map(AReg => YReg, ZReg => Not_result);
Or_sig : OR32 port map(AReg => YReg, BReg => BReg, ZReg => Or_result);
Rol_sig : ROL32 port map(AReg => YReg, BReg => BReg, ZReg => Rol_result);
Ror_sig : ROR32 port map(AReg => YReg, BReg => BReg, ZReg => Ror_result);
Shl_sig : SHL32 port map(AReg => YReg, BReg => BReg, ZReg => Shl_result);
Shr_sig : SHR32 port map(AReg => YReg, BReg => BReg, ZReg => Shr_result);
Shra_sig : SHRA32 port map(AReg => YReg, BReg => BReg, ZReg => Shra_result);
Sub_sig : SUB32 port map(ra => YReg, rb => BReg, cin => SubCin, sum => Sub_result, cout => SubCout);
--actual process of checking _sigcode to determine what _sigeration to do
process(clk, clear, AReg, BReg, And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig)
begin
if And_sig = '1' then
    ZReg(31 downto 0) <= And_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Or_sig = '1' then
    ZReg(31 downto 0) <= Or_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Add_sig = '1' then    
    ZReg(31 downto 0) <= Add_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Sub_sig = '1' then    
    ZReg(31 downto 0) <= Sub_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Mul_sig = '1' then
    ZReg <= Mul_result;
elsif Div_sig = '1' then
    ZReg <= Div_result;
elsif Shr_sig = '1' then
    ZReg(31 downto 0) <= Shr_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Shl_sig = '1' then
    ZReg(31 downto 0) <= Shl_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Ror_sig = '1' then
    ZReg(31 downto 0) <= Ror_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Rol_sig = '1' then
    ZReg(31 downto 0) <= Rol_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Neg_sig = '1' then
    ZReg(31 downto 0) <= Neg_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Not_sig = '1' then
    ZReg(31 downto 0) <= Not_result;
    ZReg(63 downto 32) <= (others => '0');
elsif Shra_sig = '1' then
    ZReg(31 downto 0) <= Shra_result;
    ZReg(63 downto 32) <= (others => '0');
else
    ZReg <= "0000000000000000000000000000000000000000000000000000000000000000";
end if;
end process;
end behavior;

--how to implement ALU with all of its _sigerations
--every _sigeration has a defined signal for its output, when port mapping the _sigeration to the alu, its output will be mapped to its specific signal
--in the switch-case, if the _sigcode matches, have the c register (ALU's output) grab the output signal of the given _sigeration
--then pray it works

--end behavior;