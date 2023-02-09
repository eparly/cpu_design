library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
port(
    signal clk: in std_logic;
    signal clear: in std_logic;

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    YReg: in std_logic_vector(31 downto 0);
    ZReg: out std_logic_vector(63 downto 0);
	 
	 ADD_select: in std_logic;
	 SUB_select: in std_logic;
	 MUL_select: in std_logic;
	 DIV_select: in std_logic;
	 SHR_select: in std_logic;
	 SHRA_select: in std_logic;
	 SHL_select: in std_logic;
	 ROR_select: in std_logic;
	 ROL_select: in std_logic;
	 AND_select: in std_logic;
	 OR_select: in std_logic;
	 NEG_select: in std_logic;
	 NOT_select: in std_logic
);
end entity;

--opcode is listed as constants to make future code more bearable, idk the actual opcodes yet so they are all 0's for now
architecture behavior of ALU is 
--signal definition
signal And_result: std_logic_vector(31 downto 0);
signal Or_result: std_logic_vector(31 downto 0);
signal Add_result: std_logic_vector(31 downto 0);
signal Sub_result: std_logic_vector(31 downto 0);
signal Mul_result: std_logic_vector(63 downto 0); --careful
signal Div_result: std_logic_vector(63 downto 0); --careful
signal Shr_result: std_logic_vector(31 downto 0);
signal Shl_result: std_logic_vector(31 downto 0);
signal Shra_result: std_logic_vector(31 downto 0);
signal Ror_result: std_logic_vector(31 downto 0);
signal Rol_result: std_logic_vector(31 downto 0);
signal Neg_result: std_logic_vector(31 downto 0);
signal Not_result: std_logic_vector(31 downto 0);

--additional stuff needed for the add and sub operations
signal AddCout : std_logic;
signal SubCout : std_logic;
signal AddCin : std_logic;
signal SubCin : std_logic;

--paste ALL the components for all the operations in here
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

AddOP : CLA32 port map(ra => YReg, rb => BReg, cin => AddCin, sum => Add_result, cout => AddCout);
AndOP : AND32 port map(AReg => YReg, BReg => BReg, ZReg => And_result);
DivOP : DIV32 port map(ra => YReg, rb => BReg, rz => Div_result);
MulOP : MUL32 port map(ra => YReg, rb => BReg, rz => Mul_result);
NegOP : NEG32 port map(AReg => YReg, ZReg => Neg_result);
NotOP : NOT32 port map(AReg => YReg, ZReg => Not_result);
OrOP : OR32 port map(AReg => YReg, BReg => BReg, ZReg => Or_result);
RolOP : ROL32 port map(AReg => YReg, BReg => BReg, ZReg => Rol_result);
RorOP : ROR32 port map(AReg => YReg, BReg => BReg, ZReg => Ror_result);
ShlOP : SHL32 port map(AReg => YReg, BReg => BReg, ZReg => Shl_result);
ShrOP : SHR32 port map(AReg => YReg, BReg => BReg, ZReg => Shr_result);
ShraOP : SHRA32 port map(AReg => YReg, BReg => BReg, ZReg => Shra_result);
SubOP : SUB32 port map(ra => YReg, rb => BReg, cin => SubCin, sum => Sub_result, cout => SubCout);
--actual process of checking opcode to determine what operation to do
process(clk, clear, AReg, BReg, AND_select, OR_select, ADD_select, SUB_select,
			MUL_select, DIV_select, SHR_select, SHL_select, ROR_select, NEG_select, NOT_select, SHRA_select)
begin

    if AND_select then --ALU_And:
        ZReg(31 downto 0) <= And_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif OR_select then --Alu_Or:
        ZReg(31 downto 0) <= Or_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif ADD_select then --ALU_Add:
        Zreg(31 downto 0) <= Add_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif SUB_select then --ALU_Sub:
        Zreg(31 downto 0) <= Sub_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif MUL_select then --ALU_Mul:
        Zreg <= Mul_result;
    elsif DIV_select then --ALU_Div:
        Zreg <= Div_result;
    elsif SHR_select then --ALU_Shr:
        Zreg(31 downto 0) <= Shr_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif SHL_select then --ALU_Shl:
        Zreg(31 downto 0) <= Shl_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif ROR_select then --ALU_Ror:
        Zreg(31 downto 0) <= Ror_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif ROL_select then --ALU_Rol:
        Zreg(31 downto 0) <= Rol_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif NEG_select then --ALU_Neg:
        Zreg(31 downto 0) <= Neg_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif NOT_select then --ALU_Not:
        Zreg(31 downto 0) <= Not_result;
        ZReg(63 downto 32) <= (others => '0');
    elsif SHRA_select then --ALU_Shra:
        Zreg(31 downto 0) <= Shra_result;
        ZReg(63 downto 32) <= (others => '0');

end if;
end process;
end behavior;

--how to implement ALU with all of its operations
--every operation has a defined signal for its output, when port mapping the operation to the alu, its output will be mapped to its specific signal
--in the switch-case, if the opcode matches, have the c register (ALU's output) grab the output signal of the given operation
--then pray it works

--end behavior;