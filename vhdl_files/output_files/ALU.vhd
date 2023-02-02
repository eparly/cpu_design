library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
port(
    signal clk: in std_logic;
    signal clear: in std_logic;
    signal IncPC: in std_logic;

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    YReg: in std_logic_vector(31 downto 0);
    Opcode: in std_logic_vector(4 downto 0);
    ZReg: out std_logic_vector(63 downto 0)
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
signal Ror_result: std_logic_vector(31 downto 0);
signal Rol_result: std_logic_vector(31 downto 0);
signal Neg_result: std_logic_vector(31 downto 0);
signal Not_result: std_logic_vector(31 downto 0);
signal Shra_result: std_logic_vector(31 downto 0);
--paste ALL the components for all the operations in here
begin
--port mapping EVERYTHING

--actual process of checking opcode to determine what operation to do
process
case opcode is
    when "00000" => --ALU_And:
        ZReg(31 downto 0) <= And_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --Alu_Or:
        ZReg(31 downto 0) <= Or_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Add:
        Zreg(31 downto 0) <= Add_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Sub:
        Zreg(31 downto 0) <= Sub_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Mul:
        Zreg <= Mul_result;
    when "00000" => --ALU_Div:
        Zreg <= Div_result;
    when "00000" => --ALU_Shr:
        Zreg(31 downto 0) <= Shr_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Shl:
        Zreg(31 downto 0) <= Shl_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Ror:
        Zreg(31 downto 0) <= Ror_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Rol:
        Zreg(31 downto 0) <= Rol_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Neg:
        Zreg(31 downto 0) <= Neg_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Not:
        Zreg(31 downto 0) <= Not_result;
        ZReg(63 downto 32) <= (others => '0');
    when "00000" => --ALU_Shra:
        Zreg(31 downto 0) <= Shra_result;
        ZReg(63 downto 32) <= (others => '0');
end case;
end process;
end behavior;

--how to implement ALU with all of its operations
--every operation has a defined signal for its output, when port mapping the operation to the alu, its output will be mapped to its specific signal
--in the switch-case, if the opcode matches, have the c register (ALU's output) grab the output signal of the given operation
--then pray it works

end behavior;