library IEEE;
use IEEE.std_logic_1164.all;

entity CPU_BUS is 
port( --needed to be done this way to implement the control unit later <- see comments at the bottom
    signal clk: in std_logic;
    signal clear: in std_logic;
--write/enable, goes into each registers "Rin" signal, also comes from the eventual Control Unit, could be moved inside the architecture
    R0En : in std_logic;
    R1En : in std_logic;
    R2En : in std_logic;
    R3En : in std_logic;
    R4En : in std_logic;
    R5En : in std_logic;
    R6En : in std_logic;
    R7En : in std_logic;
    R8En : in std_logic;
    R9En : in std_logic;
    R10En : in std_logic;
    R11En : in std_logic;
    R12En : in std_logic;
    R13En : in std_logic;
    R14En : in std_logic;
    R15En : in std_logic;
    HIEn : in std_logic;
    LOEn : in std_logic;
    ZHIEn : in std_logic;
    ZLOEn : in std_logic;
    PCEn : in std_logic;
    MDREn : in std_logic;
    PORTEn : in std_logic;
    CEn : in std_logic;
--goes into encoder, comes from the eventual Control unit, could be moved inside the architecture
    R0out : in std_logic;
    R1out : in std_logic;
    R2out : in std_logic;
    R3out : in std_logic;
    R4out : in std_logic;
    R5out : in std_logic;
    R6out : in std_logic;
    R7out : in std_logic;
    R8out : in std_logic;
    R9out : in std_logic;
    R10out : in std_logic;
    R11out : in std_logic;
    R12out : in std_logic;
    R13out : in std_logic;
    R14out : in std_logic;
    R15out : in std_logic;
    HIout : in std_logic;
    LOout : in std_logic;
    ZHIout : in std_logic;
    ZLOout : in std_logic;
    PCout : in std_logic;
    PORTout : in std_logic;
    Cout : in std_logic;
    --MDR is slightly different
    MDRout : in std_logic; --from control unit
    MDRRead : in std_logic --from control unit

);
end CPU_BUS;

architecture behavior of CPU_BUS is
--for the encoder, indivdual signals tied into one vector to be passed into the encoder (needed because of how we designed the encoder)
signal encoderInput : std_logic_vector(31 downto 0);
signal BusMuxOut : std_logic_vector(31 downto 0);

signal busEncoderOutput : std_logic_vector(4 downto 0);

--input from the register outputs for the 32-1 MUX
signal R0in : std_logic_vector(31 downto 0); 
signal R1in : std_logic_vector(31 downto 0);
signal R2in : std_logic_vector(31 downto 0);
signal R3in : std_logic_vector(31 downto 0);
signal R4in : std_logic_vector(31 downto 0);
signal R5in : std_logic_vector(31 downto 0);
signal R6in : std_logic_vector(31 downto 0);
signal R7in : std_logic_vector(31 downto 0);
signal R8in : std_logic_vector(31 downto 0);
signal R9in : std_logic_vector(31 downto 0);
signal R10in : std_logic_vector(31 downto 0);
signal R11in : std_logic_vector(31 downto 0);
signal R12in : std_logic_vector(31 downto 0);
signal R13in : std_logic_vector(31 downto 0);
signal R14in : std_logic_vector(31 downto 0);
signal R15in : std_logic_vector(31 downto 0);
signal HIin : std_logic_vector(31 downto 0);
signal LOin : std_logic_vector(31 downto 0);
signal ZHIin : std_logic_vector(31 downto 0);
signal ZLOin : std_logic_vector(31 downto 0);
signal PCin : std_logic_vector(31 downto 0);
signal PORTin : std_logic_vector(31 downto 0);
signal Cin : std_logic_vector(31 downto 0);
--MDR is special
signal RamOutput : std_logic_vector(31 downto 0); --currently no memory module, but its needed to connect the ALU
signal MDRin : std_logic_vector(31 downto 0); --needs to connect to Bus AND RAM
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
    signal IncPC: in std_logic;

    AReg: in std_logic_vector(31 downto 0);
    BReg: in std_logic_vector(31 downto 0);
    YReg: in std_logic_vector(31 downto 0);
    Opcode: in std_logic_vector(4 downto 0);
    ZReg: out std_logic_vector(63 downto 0)
);
end component;

component mux32_1 is
	port( signal sel : in std_logic_vector(4 downto 0);
	
			signal bus_mux_in_0 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_1 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_2 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_3 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_4 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_5 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_6 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_7 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_8 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_9 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_10 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_11 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_12 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_13 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_14 : in std_logic_vector(31 downto 0);
			signal bus_mux_in_15 : in std_logic_vector(31 downto 0);

			signal bus_mux_in_HI : in std_logic_vector(31 downto 0);
			signal bus_mux_in_LO : in std_logic_vector(31 downto 0);
			signal bus_mux_in_Z_high : in std_logic_vector(31 downto 0);
			signal bus_mux_in_Z_low : in std_logic_vector(31 downto 0);
			signal bus_mux_in_PC : in std_logic_vector(31 downto 0);
			signal bus_mux_in_MDR : in std_logic_vector(31 downto 0);
			signal bus_mux_in_InPort : in std_logic_vector(31 downto 0);
			signal bus_mux_in_C_sign_extended : in std_logic_vector(31 downto 0);
			
			signal bus_mux_out: out std_logic_vector(31 downto 0)
	);

end component;

component encoder32_5 is
    port( 
        signal encoderOutput : out std_logic_vector(4 downto 0);
	    signal encoderInput : in std_logic_vector(31 downto 0)
	);
end component;
begin
--encoder inputs
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


--port mapping
Encode : encoder32_5 port map(encoderOutput => busEncoderOutput, encoderInput => encoderInput);
BusMUX : mux32_1 port map(sel => busEncoderOutput, bus_mux_in_0 => R0in,bus_mux_in_1 => R1in, bus_mux_in_2 => R2in, bus_mux_in_3 => R3in, bus_mux_in_4 => R4in, bus_mux_in_5 => R5in, bus_mux_in_6 => R6in, bus_mux_in_7 => R7in, bus_mux_in_8 => R8in, bus_mux_in_9 => R9in, bus_mux_in_10 => R10in, bus_mux_in_11 => R11in, bus_mux_in_12 => R12in, bus_mux_in_13 => R13in, bus_mux_in_14 => R14in, bus_mux_in_15 => R15in, bus_mux_in_HI => HIin, bus_mux_in_LO => LOin, bus_mux_in_Z_high => ZHIin, bus_mux_in_Z_low => ZLOin, bus_mux_in_PC => PCin, bus_mux_in_MDR => MDRin, bus_mux_in_InPort => PORTin, bus_mux_in_C_sign_extended => Cin, Bus_mux_out => BusMuxOut);

--ALU
--Commenting out ALU port map for now, need to include signals inside the mapping
----------------------------------
--ALU : ALU port map();
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
RZHI : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => ZHIEn, reg_out => ZHIin);
RZLO : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => ZLOEn, reg_out => ZLOin);
RPC : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => PCEn, reg_out => PCin);
RPORT : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => PORTEn, reg_out => PORTin);
RC : reg port map(reg_input =>BusMuxOut, clk => clk, clear => clear, writeEnable => CEn, reg_out => Cin);
--special MDR register
--getting error on this line, commenting out for now
-----------------
--RMDR : MDR port map(BusInput => BusMuxOut, MemDataIn => RamOutput, sel => MDRRead, MDROut=> MDRin, clk =>, clear=> , writeEnable=> MDREn);
-----------------
end behavior;

--this file can change alot depending on how we do this, i've assumed that the memmory chip (RAM) will be imported in and port mapped, hence why every signal relating to RAM is defined internally (not in the entity definition). I've also assumed that the Control Unit will import the CpuBus and connect/port map to it from there, if we instead change this and import the control unit inside of this file, all the ports relating to the control unit will have to be changed into internal signals to make it work

--i've coded this at like 4am i'm almost sure this doesn't work