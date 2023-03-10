library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
port(
--    signal clk: in std_logic;
--    signal clear: in std_logic;

    AReg, BReg: in std_logic_vector(31 downto 0);
--replacing the opcode with individual signals
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;

	 AddCin_sig: std_logic;
    ZReg: out std_logic_vector(63 downto 0)
);
end entity;


architecture behavior of ALU is 
--signal definition
signal RAIN, RBIN : std_logic_vector(31 downto 0);
signal And_result, Or_result, Add_result, Sub_result, Shr_result, Shl_result, Shra_result, Ror_result, Rol_result, Neg_result, Not_result, IncPC_result : std_logic_vector(31 downto 0);

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

component IncPC is
port(
    

    PCReg: in std_logic_vector(31 downto 0);

    ZReg: out std_logic_vector(31 downto 0)
);
end component;

begin
--port mapping EVERYTHING
AddCin <= '0';
SubCin <= '0';

Addop : CLA32 port map(ra => RAIN, rb => RBIN, cin => AddCin, sum => Add_result, cout => AddCout);
Andop : AND32 port map(AReg => RAIN, BReg => RBIN, ZReg => And_result);
Divop : DIV32 port map(ra => RAIN, rb => RBIN, rz => Div_result);
Mulop : MUL32 port map(ra => RAIN, rb => RBIN, rz => Mul_result);
Negop : NEG32 port map(AReg => RAIN, ZReg => Neg_result);
Notop : NOT32 port map(AReg => RBIN, ZReg => Not_result);
Orop : OR32 port map(AReg => RAIN, BReg => RBIN, ZReg => Or_result);
Rolop : ROL32 port map(AReg => RAIN, BReg => RBIN(4 downto 0), ZReg => Rol_result);
Rorop : ROR32 port map(AReg => RAIN, BReg => RBIN(4 downto 0), ZReg => Ror_result);
Shlop : SHL32 port map(AReg => RAIN, BReg => RBIN, ZReg => Shl_result);
Shrop : SHR32 port map(AReg => RAIN, BReg => RBIN, ZReg => Shr_result);
Shraop : SHRA32 port map(AReg => RAIN, BReg => RBIN, ZReg => Shra_result);
Subop : SUB32 port map(ra => RAIN, rb => RBIN, cin => SubCin, sum => Sub_result, cout => SubCout);
IncPCop : IncPC port map(PCReg => RBIN, ZReg => IncPC_result); --bypasses the need for Yin to be turned on for single register operations

process(And_result, Or_result, Add_result, Sub_result, Shr_result, Shl_result, Shra_result, Ror_result, Rol_result, Neg_result, Not_result, Mul_result, Div_result, And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig, AReg, BReg)
begin
RAIN <= AReg;
RBIN <= BReg;
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
elsif IncPC_sig = '1' then
    ZReg(31 downto 0) <= IncPC_result;
    ZReg(63 downto 32) <= (others => '0');
else
    ZReg <= "0000000000000000000000000000000000000000000000000000000000000000";
end if;
end process;
end behavior;