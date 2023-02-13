library IEEE;
use IEEE.std_logic_1164.all;

entity CPU_BUS is 
port( --needed to be done this way to implement the control unit later <- see comments at the bottom
    signal clk: in std_logic;
    signal clear: in std_logic;
--Comes from the control unit, maps to each registers 'writeEnable' port
    R0En, R1En, R2En, R3En, R4En, R5En, R6En, R7En, R8En, R9En, R10En, R11En, R12En, R13En, R14En, R15En, HIEn, LOEn, ZEn, PCEn, IREn, MDREn, PORTEn, CEn, YEn, MAREn : in std_logic;
--From the control unit, maps into the encoder, dictates which register can put its data onto the bus
    R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, ZHIout, ZLOout, PCout, PORTout, Cout : in std_logic;
    --MDR requires a slightly different setup
    MDRout, MDRRead : in std_logic; --from control unit, MDRout maps to encoder, MDRRead maps to MDR's MUX as the control signal
    MemDatain : in std_logic_vector(31 downto 0); --output from memory that is an input for the MDR's MUX
    --opcode signals from control unit (single bit)
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;
    --ports for the outputs of the registers (used for the testbenches only)
    R0Data, R1Data, R2Data: out std_logic_vector(31 downto 0)
);
end CPU_BUS;

architecture behavior of CPU_BUS is
--for the encoder, indivdual signals tied into one vector to be passed into the encoder (needed because of how we designed the encoder)
signal encoderInput : std_logic_vector(31 downto 0);
signal BusMuxOut : std_logic_vector(31 downto 0);

signal encoderOutput : std_logic_vector(4 downto 0);

--maps to data output from the register that maps to the inputs of the 32-1 MUX
signal R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, LOin, ZHIin, ZLOin, PCin, IRin, PORTin, Cin, Yin : std_logic_vector(31 downto 0);
--maps to MDR output, and will have to map to the input of both the Bus and RAM
signal MDRin : std_logic_vector(31 downto 0);
--maps to the MAR output, maps to the RAM input
signal MARin : std_logic_vector(31 downto 0);
--Z reg is a different size
signal ZOut : std_logic_vector(63 downto 0);
--components
component reg is
	port( signal reg_input : in std_logic_vector(31 downto 0);
		signal clk: in std_logic;
		signal clear: in std_logic;
		signal writeEnable: in std_logic; --R#In
		signal reg_out : out std_logic_vector(31 downto 0)
	);
end component;

component MDR is
    port(
        BusInput: in std_logic_vector(31 downto 0);
        MemDataIn: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        MDROut: out std_logic_vector(31 downto 0); --will need to be configured later to go to bus or memory chip (phase 3)
        --i think i need the following for the register component?
        --signal MDRclk: in std_logic; maybe not the clk? irdk
		clk: in std_logic;
        clear: in std_logic;
        writeEnable: in std_logic
    );
end component;

component ALU is
port(
    signal clk: in std_logic;
    signal clear: in std_logic;

    AReg, BReg: in std_logic_vector(31 downto 0);
--replacing the opcode with individual signals
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;

    ZReg: out std_logic_vector(63 downto 0)
);
end component;


component mux32_1 is
	port( 
		signal sel : in std_logic_vector(4 downto 0);
			-- maps to the "in" signals from CpuBus, which is the data output from all the registers (expect for MAR)
		signal bus_mux_in_0, bus_mux_in_1, bus_mux_in_2, bus_mux_in_3, bus_mux_in_4, bus_mux_in_5, bus_mux_in_6, bus_mux_in_7, bus_mux_in_8, bus_mux_in_9, bus_mux_in_10, bus_mux_in_11, bus_mux_in_12, bus_mux_in_13, bus_mux_in_14, bus_mux_in_15, bus_mux_in_HI, bus_mux_in_LO, bus_mux_in_Z_high, bus_mux_in_Z_low, bus_mux_in_PC, bus_mux_in_MDR, bus_mux_in_InPort, bus_mux_in_C_sign_extended : in std_logic_vector(31 downto 0);
			-- the actual 'bus' data
		bus_mux_out: out std_logic_vector(31 downto 0)
	);
end component;

component encoder32_5 is
    port( 
        signal encoderOutput : out std_logic_vector(4 downto 0);
	    signal encoderInput : in std_logic_vector(31 downto 0)
	);
end component;

begin
--ports recieve the register outputs
process (clk) is
begin
R0Data <= R0in;
R1Data <= R1in;
R2Data <= R2in;
--encoder inputs, putting all of the encoder input signals into 1 vector
encoderInput(0) <= R0out;
encoderInput(1) <= R1out;
encoderInput(2) <= R2out;
encoderInput(3) <= R3out;
encoderInput(4) <= R4out;
encoderInput(5) <= R5out;
encoderInput(6) <= R6out;
encoderInput(7) <= R7out;
encoderInput(8) <= R8out;
encoderInput(9) <= R9out;
encoderInput(10) <= R10out;
encoderInput(11) <= R11out;
encoderInput(12) <= R12out;
encoderInput(13) <= R13out;
encoderInput(14) <= R14out;
encoderInput(15) <= R15out;
encoderInput(16) <= HIout;
encoderInput(17) <= LOout;
encoderInput(18) <= ZHIout;
encoderInput(19) <= ZLOout;
encoderInput(20) <= PCout;
encoderInput(21) <= MDRout;
encoderInput(22) <= PORTout;
encoderInput(23) <= Cout;
end process;
--port mapping, for the main components
Encode : encoder32_5 port map(encoderOutput => encoderOutput, encoderInput => encoderInput);
BusMUX : mux32_1 port map(sel => encoderOutput, bus_mux_in_0 => R0in,bus_mux_in_1 => R1in, bus_mux_in_2 => R2in, bus_mux_in_3 => R3in, bus_mux_in_4 => R4in, bus_mux_in_5 => R5in, bus_mux_in_6 => R6in, bus_mux_in_7 => R7in, bus_mux_in_8 => R8in, bus_mux_in_9 => R9in, bus_mux_in_10 => R10in, bus_mux_in_11 => R11in, bus_mux_in_12 => R12in, bus_mux_in_13 => R13in, bus_mux_in_14 => R14in, bus_mux_in_15 => R15in, bus_mux_in_HI => HIin, bus_mux_in_LO => LOin, bus_mux_in_Z_high => ZHIin, bus_mux_in_Z_low => ZLOin, bus_mux_in_PC => PCin, bus_mux_in_MDR => MDRin, bus_mux_in_InPort => PORTin, bus_mux_in_C_sign_extended => Cin, Bus_mux_out => BusMuxOut);

--ALU
----------------------------------
ALU1 : ALU port map(clk => clk, clear => clear, AReg => Yin, BReg => BusMuxOut, And_sig => And_sig, Or_sig => Or_sig, Add_sig => Add_sig, Sub_sig => Sub_sig, Mul_sig => Mul_sig, Div_sig => Div_sig, Shr_sig => Shr_sig, Shl_sig => Shl_sig, Shra_sig => Shra_sig, Ror_sig => Ror_sig, Rol_sig => Rol_sig, Neg_sig => Neg_sig, Not_sig => Not_sig, IncPC_sig => IncPC_sig, ZReg => ZOut);
----------------------------------
--all (for now) registers
R0 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R0En, reg_out => R0in);
R1 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R1En, reg_out => R1in);
R2 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R2En, reg_out => R2in);
R3 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R3En, reg_out => R3in);
R4 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R4En, reg_out => R4in);
R5 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R5En, reg_out => R5in);
R6 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R6En, reg_out => R6in);
R7 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R7En, reg_out => R7in);
R8 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R8En, reg_out => R8in);
R9 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R9En, reg_out => R9in);
R10 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R10En, reg_out => R10in);
R11 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R11En, reg_out => R11in);
R12 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R12En, reg_out => R12in);
R13 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R13En, reg_out => R13in);
R14 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R14En, reg_out => R14in);
R15 : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => R15En, reg_out => R15in);
RHI : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => HIEn, reg_out => HIin);
RLO : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => LOEn, reg_out => LOin);
RZHI : reg port map(reg_input =>ZOut(63 downto 32), clk => clk, clear => clear, writeEnable => ZEn, reg_out => ZHIin);
RZLO : reg port map(reg_input =>ZOut(31 downto 0), clk => clk, clear => clear, writeEnable => ZEn, reg_out => ZLOin);
RPC : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => PCEn, reg_out => PCin);
RIR : reg port map(reg_input => BusmuxOut, clk => clk, clear => clear, writeEnable => IREn, reg_out => IRin);
RPORT : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => PORTEn, reg_out => PORTin);
RC : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => CEn, reg_out => Cin);
YReg : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => YEn, reg_out => Yin);
MARReg : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => MAREn, reg_out => MARin);
--special MDR register
RMDR : MDR port map(BusInput => BusMuxOut, MemDataIn => MemDatain, sel => MDRRead, MDROut=> MDRin, clk => clk, clear=> clear, writeEnable=> MDREn);
end behavior;

--this file can change alot depending on how we do this, i've assumed that the memmory chip (RAM) will be imported in and port mapped, hence why every signal relating to RAM is defined internally (not in the entity definition). I've also assumed that the Control Unit will import the CpuBus and connect/port map to it from there, if we instead change this and import the control unit inside of this file, all the ports relating to the control unit will have to be changed into internal signals to make it work

--i've coded this at like 4am i'm almost sure this doesn't work