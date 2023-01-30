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
constant ALU_And: std_logic_vector(4 downto 0):= "00000";
constant Alu_Or: std_logic_vector(4 downto 0):= "00000";
constant ALU_Add: std_logic_vector(4 downto 0):= "00000";
constant ALU_Sub: std_logic_vector(4 downto 0):= "00000";
constant ALU_Mul: std_logic_vector(4 downto 0):= "00000";
constant ALU_Div: std_logic_vector(4 downto 0):= "00000";
constant ALU_Shr: std_logic_vector(4 downto 0):= "00000";
constant ALU_Shl: std_logic_vector(4 downto 0):= "00000";
constant ALU_Ror: std_logic_vector(4 downto 0):= "00000";
constant ALU_Rol: std_logic_vector(4 downto 0):= "00000";
constant ALU_Neg: std_logic_vector(4 downto 0):= "00000";
constant ALU_Not: std_logic_vector(4 downto 0):= "00000";
constant ALU_Shra: std_logic_vector(4 downto 0):= "00000";

--how to implement ALU with all of its operations
--every operation has a defined signal for its output, when port mapping the operation to the alu, its output will be mapped to its specific signal
--in the switch-case, if the opcode matches, have the c register (ALU's output) grab the output signal of the given operation
--then pray it works

end behavior;