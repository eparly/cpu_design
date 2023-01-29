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
    ZReg: out std_logic_vector(63 downto 0);
);

--opcode is listed as constants to make future code more bearable, idk the actual opcodes yet so they are all 0's for now
constant ALU_And: std_logic_vector(4 downto 0): "00000";
constant Alu_Or: std_logic_vector(4 downto 0): "00000";
constant ALU_Add: std_logic_vector(4 downto 0): "00000";
constant ALU_Sub: std_logic_vector(4 downto 0): "00000";
constant ALU_Mul: std_logic_vector(4 downto 0): "00000";
constant ALU_Div: std_logic_vector(4 downto 0): "00000";
constant ALU_Shr: std_logic_vector(4 downto 0): "00000";
constant ALU_Shl: std_logic_vector(4 downto 0): "00000";
constant ALU_Ror: std_logic_vector(4 downto 0): "00000";
constant ALU_Rol: std_logic_vector(4 downto 0): "00000";
constant ALU_Neg: std_logic_vector(4 downto 0): "00000";
constant ALU_Not: std_logic_vector(4 downto 0): "00000";
constant ALU_Load: std_logic_vector(4 downto 0): "00000";
constant ALU_Loadi: std_logic_vector(4 downto 0): "00000";
constant ALU_Store: std_logic_vector(4 downto 0): "00000";
constant ALU_Addi: std_logic_vector(4 downto 0): "00000";
constant ALU_Andi: std_logic_vector(4 downto 0): "00000";
constant ALU_Ori: std_logic_vector(4 downto 0): "00000";
constant ALU_branch: std_logic_vector(4 downto 0): "00000";
constant ALU_jr: std_logic_vector(4 downto 0): "00000";
constant ALU_jal: std_logic_vector(4 downto 0): "00000";
constant ALU_mfhi: std_logic_vector(4 downto 0): "00000";
constant ALU_mflo: std_logic_vector(4 downto 0): "00000";
constant ALU_in: std_logic_vector(4 downto 0): "00000";
constant ALU_out: std_logic_vector(4 downto 0): "00000";
constant ALU_nop: std_logic_vector(4 downto 0): "00000";
constant ALU_halt: std_logic_vector(4 downto 0): "00000";