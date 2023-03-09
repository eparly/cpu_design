library IEEE;
use IEEE.std_logic_1164.all;

entity CpuBus2 is 
port( 
    clk: in std_logic;
    clear: in std_logic;
    --MDR requires a slightly different setup
    MDRRead : in std_logic; --from control unit, MDRout maps to encoder, MDRRead maps to MDR's MUX as the control signal
    --opcode signals from control unit (single bit)
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;
	 --signal from the Control Unit for the select and encode logic
	 gra, grb, grc, rin, rout, baout : in std_logic;
	 --RAM enable signals
	 RAMReadEn, RAMWriteEn: in std_logic;
	 --enable signals that have to come from the 'control unit'
	 HIEn, LOEn, ZEn, PCEn, IREn, MDREn, inPORTEn, outPORTEn, YEn, MAREn : std_logic;
	 PortCONFFEn : in std_logic;
	 --signals for the encoder that have to come from the 'control unit'
	 HIout, LOout, ZHIout, ZLOout, PCout, MDROut, PORTout, Cout : std_logic;
	 
	 --only needed to manually load in register data BEFORE the actual instruction begins
	 ManualData : in std_logic_vector(31 downto 0);
	 ManR0En, ManR1En, ManR2En, ManR3En, ManR4En, ManR5En, ManR6En : in std_logic;
	 MDRsel, R0sel, R1sel, R2sel, R3sel, R4sel, R5sel, R6sel : in std_logic;
	 
    --ports for the outputs of the registers (used for the testbenches only) Test ports
    R0Data, R1Data, R2Data, R3Data, R4Data, R5Data, R6Data, R7Data, R8Data, R9Data, R10Data, R11Data, R12Data, R13Data, R14Data, R15Data, MDRData, YData, ZLODATA, ZHIData, HIData, LOData, PCData, IRData, CData, Buscontents: out std_logic_vector(31 downto 0);
	 Encodercontents : out std_logic_vector(4 downto 0);
	 RamOutput, RamAddress, EncodercontentsIN : out std_logic_vector(31 downto 0);
	 CONFFout : out std_logic;
	 --i dont really know what to do about the data regarding the in and output ports right now, so for now they will be signals to and from the CPUBUS
	 OutportData : out std_logic_vector(31 downto 0);
	 IncomingData : in std_logic_vector(31 downto 0)
);
end CpuBus2;

architecture behavior of CpuBus2 is

signal wireclk, wireclear : std_logic;
signal wireHIEn, wireLOEn, wireZEn, wirePCEn, wireIREn, wireMDREn, wireinPORTEn, wireoutPORTEn, wireYEn, wireMAREn : std_logic;
signal wireCONFFEn : std_logic;
signal wireCONFFpassed : std_logic;
--for the select and encoder
signal SEin, SEout : std_logic_vector(15 downto 0);
signal wiregra, wiregrb, wiregrc, wirerin, wirerout, wirebaout : std_logic;
signal CSE : std_logic_vector(31 downto 0);
signal InPortInput : std_logic_vector(31 downto 0);
signal wireMDRRead : std_logic;
signal wireRAMReadEn, wireRAMWriteEn : std_logic;
--for the encoder, indivdual signals tied into one vector to be passed into the encoder (needed because of how we designed the encoder)
signal encoderInput : std_logic_vector(31 downto 0);
signal BusMuxOut : std_logic_vector(31 downto 0);
signal encoderOutput : std_logic_vector(4 downto 0);
--maps to data output from the register that maps to the inputs of the 32-1 MUX
signal R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, LOin, ZHIin, ZLOin, PCin, IRin, Yin, InPortin, OutPortin : std_logic_vector(31 downto 0);
--maps to MDR output, and will have to map to the input of both the Bus and RAM
signal MDRin : std_logic_vector(31 downto 0);
--maps to the MAR output, maps to the RAM input
signal MARin : std_logic_vector(31 downto 0);
--Z reg is a different size
signal ZOut : std_logic_vector(63 downto 0);
--wire for ALU operations
signal wireAnd_sig, wireOr_sig, wireAdd_sig, wireSub_sig, wireMul_sig, wireDiv_sig, wireShr_sig, wireShl_sig, wireShra_sig, wireRor_sig, wireRol_sig, wireNeg_sig, wireNot_sig, wireIncPC_sig: std_logic;
--additional wires needed
signal wireMemDatain : std_logic_vector(31 downto 0);
signal wireFromRAM : std_logic_vector(31 downto 0);
signal R0EnFinal, R1EnFinal, R2EnFinal, R3EnFinal, R4EnFinal, R5EnFinal, R6EnFinal : std_logic;
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
--    signal clk: in std_logic;
--    signal clear: in std_logic;

    AReg, BReg: in std_logic_vector(31 downto 0);
--replacing the opcode with individual signals
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;

    ZReg: out std_logic_vector(63 downto 0)
);
end component;


component mux32 is
	port( 
		signal sel : in std_logic_vector(4 downto 0);
			-- maps to the "in" signals from CpuBus, which is the data output from all the registers (expect for MAR)
		signal bus_mux_in_0, bus_mux_in_1, bus_mux_in_2, bus_mux_in_3, bus_mux_in_4, bus_mux_in_5, bus_mux_in_6, bus_mux_in_7, bus_mux_in_8, bus_mux_in_9, bus_mux_in_10, bus_mux_in_11, bus_mux_in_12, bus_mux_in_13, bus_mux_in_14, bus_mux_in_15, bus_mux_in_HI, bus_mux_in_LO, bus_mux_in_Z_high, bus_mux_in_Z_low, bus_mux_in_PC, bus_mux_in_MDR, bus_mux_in_InPort, bus_mux_in_C_sign_extended : in std_logic_vector(31 downto 0);
			-- the actual 'bus' data
		bus_mux_out: out std_logic_vector(31 downto 0)
	);
end component;

component encoder32to5 is
    port( 
        signal encoderOutput : out std_logic_vector(4 downto 0);
	    signal encoderInput : in std_logic_vector(31 downto 0)
	);
end component;

component RAM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

component sel_and_encode is
port(
ir_in : in std_logic_vector(31 downto 0);
gra, grb, grc, rin, rout, baout : in std_logic;
rin_out, rout_out : out std_logic_vector(15 downto 0);
C_sign_extended_out : out std_logic_vector(31 downto 0)
);
end component;

component reg0 is
port( 
reg_input : in std_logic_vector(31 downto 0);
clk: in std_logic;
clear: in std_logic;
baout : in std_logic;
writeEnable: in std_logic; --R#In
reg_out : out std_logic_vector(31 downto 0)
);
end component;

component CONFF is
port(
	BusInput : in std_logic_vector(31 downto 0); --contents of the Ra from 4 bits in IR
	CONFFEn : in std_logic;
	IRbits : in std_logic_vector(1 downto 0);
	passed : out std_logic
);
end component; 

--these components are needed to support both manually and interal inputs for MemDataIn and register enables
component MDRMux2 is 
	port(
		sel : in std_logic;
		ManualInput : in std_logic_vector(31 downto 0);
		FromRAM : in std_logic_vector(31 downto 0);
		TowireMemDatain : out std_logic_vector(31 downto 0)
	);
end component;

component RegEnMux is 
	port(
		sel : in std_logic;
		ManualInput : in std_logic;
		FromSE : in std_logic;
		TowireMemDatain : out std_logic
	);
end component;

begin
--to support manual inputs in testing, only R1-R6 has this support for now
MDRMUX : MDRMux2 port map(sel => MDRsel, ManualInput => ManualData, FromRAM => wireFromRAM, TowireMemDatain => wireMemDatain);
R1MUX : RegEnMux port map(sel => R0sel, ManualInput => ManR0En, FromSE => SEin(0), TowireMemDatain => R0EnFinal);
R0MUX : RegEnMux port map(sel => R1sel, ManualInput => ManR1En, FromSE => SEin(1), TowireMemDatain => R1EnFinal);
R2MUX : RegEnMux port map(sel => R2sel, ManualInput => ManR2En, FromSE => SEin(2), TowireMemDatain => R2EnFinal);
R3MUX : RegEnMux port map(sel => R3sel, ManualInput => ManR3En, FromSE => SEin(3), TowireMemDatain => R3EnFinal);
R4MUX : RegEnMux port map(sel => R4sel, ManualInput => ManR4En, FromSE => SEin(4), TowireMemDatain => R4EnFinal);
R5MUX : RegEnMux port map(sel => R5sel, ManualInput => ManR5En, FromSE => SEin(5), TowireMemDatain => R5EnFinal);
R6MUX : RegEnMux port map(sel => R6sel, ManualInput => ManR6En, FromSE => SEin(6), TowireMemDatain => R6EnFinal);
--CONFF
CONFF1 : CONFF port map(BusInput => BusMuxOut, CONFFEn => wireCONFFEn, IRbits => IRin(20 downto 19), passed => wireCONFFpassed);
--sel and encode
SE : sel_and_encode port map(ir_in => IRin, gra => wiregra, grb => wiregrb, grc => wiregrc, rin => wirerin, rout => wirerout, baout => wirebaout, rin_out => SEin, rout_out => SEout, C_sign_extended_out => CSE);
--Main encoder
Encode : encoder32to5 port map(encoderOutput => encoderOutput, encoderInput => encoderInput);
--Bus MUX
BusMUX : mux32 port map(sel => encoderOutput, bus_mux_in_0 => R0in,bus_mux_in_1 => R1in, bus_mux_in_2 => R2in, bus_mux_in_3 => R3in, bus_mux_in_4 => R4in, bus_mux_in_5 => R5in, bus_mux_in_6 => R6in, bus_mux_in_7 => R7in, bus_mux_in_8 => R8in, bus_mux_in_9 => R9in, bus_mux_in_10 => R10in, bus_mux_in_11 => R11in, bus_mux_in_12 => R12in, bus_mux_in_13 => R13in, bus_mux_in_14 => R14in, bus_mux_in_15 => R15in, bus_mux_in_HI => HIin, bus_mux_in_LO => LOin, bus_mux_in_Z_high => ZHIin, bus_mux_in_Z_low => ZLOin, bus_mux_in_PC => PCin, bus_mux_in_MDR => MDRin, bus_mux_in_InPort => InPORTin, bus_mux_in_C_sign_extended => CSE, Bus_mux_out => BusMuxOut);
--RAM
RAM1 : RAM port map(address => MARin(8 downto 0), clock => wireclk, data => MDRin, rden => wireRAMReadEn, wren => wireRAMWriteEn, q => wireFromRAM);
--ALU
ALU1 : ALU port map(AReg => Yin, BReg => BusMuxOut, And_sig => wireAnd_sig, Or_sig => wireOr_sig, Add_sig => wireAdd_sig, Sub_sig => wireSub_sig, Mul_sig => wireMul_sig, Div_sig => wireDiv_sig, Shr_sig => wireShr_sig, Shl_sig => wireShl_sig, Shra_sig => wireShra_sig, Ror_sig => wireRor_sig, Rol_sig => wireRol_sig, Neg_sig => wireNeg_sig, Not_sig => wireNot_sig, IncPC_sig => wireIncPC_sig, ZReg => ZOut);
--all (for now) registers
R0 : reg0 port map(reg_input => BusMuxOut, clk => wireclk, clear => wireclear, baout => wirebaout, writeEnable => R0EnFinal, reg_out => R0in);
R1 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => R1EnFinal, reg_out => R1in);
R2 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => R2EnFinal, reg_out => R2in);
R3 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => R3EnFinal, reg_out => R3in);
R4 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => R4EnFinal, reg_out => R4in);
R5 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => R5EnFinal, reg_out => R5in);
R6 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => R6EnFinal, reg_out => R6in);
R7 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(7), reg_out => R7in);
R8 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(8), reg_out => R8in);
R9 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(9), reg_out => R9in);
R10 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(10), reg_out => R10in);
R11 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(11), reg_out => R11in);
R12 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(12), reg_out => R12in);
R13 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(13), reg_out => R13in);
R14 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(14), reg_out => R14in);
R15 : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => SEin(15), reg_out => R15in);
RHI : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => wireHIEn, reg_out => HIin);
RLO : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => wireLOEn, reg_out => LOin);
RZHI : reg port map(reg_input =>ZOut(63 downto 32), clk => wireclk, clear => wireclear, writeEnable => wireZEn, reg_out => ZHIin);
RZLO : reg port map(reg_input =>ZOut(31 downto 0), clk => wireclk, clear => wireclear, writeEnable => wireZEn, reg_out => ZLOin);
RPC : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => wirePCEn, reg_out => PCin);
RIR : reg port map(reg_input => BusmuxOut, clk => wireclk, clear => wireclear, writeEnable => wireIREn, reg_out => IRin);
ROUTPORT : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => wireoutPORTEn, reg_out => OutPORTin);
RINPORT : reg port map(reg_input =>InportInput, clk => wireclk, clear => wireclear, writeEnable => wireinPORTEn, reg_out => InPORTin);
YReg : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => wireYEn, reg_out => Yin);
MARReg : reg port map(reg_input =>BusMuxOut, clk => wireclk, clear => wireclear, writeEnable => wireMAREn, reg_out => MARin);
--special MDR register
RMDR : MDR port map(BusInput => BusMuxOut, MemDataIn => wireMemDatain, sel => wireMDRRead, MDROut=> MDRin, clk => clk, clear=> clear, writeEnable=> wireMDREn);

--ports recieve the register outputs
process (clk, clear, MDRRead, RAMReadEn, RAMWriteEn,
HIEn, LOEn, ZEn, PCEn, IREn, MDREn, 
InPORTEn, OutPORTEn, YEn, MAREn, BusMuxOut,
gra, grb, grc, rin, rout, baout, R0in, R1in, R2in, R3in, 
R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, 
R13in, R14in, R15in, PCin, Yin, CSE) is

begin
wireHIEn <= HIEn;
wireLOEn <= LOEn;
wireZEn <= ZEn;
wirePCEn <= PCEn;
wireIREn <= IREn;
wireMDREn <= MDREn;
wireinPORTEn <= inPORTEn;
wireoutPORTEn <= outPORTEn;
wireYEn <= YEn;
wireMAREn <= MAREn;
wireMDRRead <= MDRRead;
wireRAMReadEn <= RAMReadEn;
wireRAMWriteEn <= RAMWriteEn;
wiregra <= gra;
wiregrb <= grb;
wiregrc <= grc;
wirerin <= rin;
wirerout <= rout;
wirebaout <= baout;
wireCONFFEn <= PortCONFFEn;
CONFFout <= wireCONFFpassed;
wireclk <= clk;
wireclear <= clear;
--test signals
R0Data <= R0in;
R1Data <= R1in;
R2Data <= R2in;
R3Data <= R3in;
R4Data <= R4in;
R5Data <= R5in;
R6Data <= R6in;
R7Data <= R7in;
R8Data <= R8in;
R9Data <= R9in;
R10Data <= R10in;
R11Data <= R11in;
R12Data <= R12in;
R13Data <= R13in;
R14Data <= R14in;
R15Data <= R15in;
YData <= Yin;
ZLODATA <= ZLOin;
ZHIData <= ZHIin;
MDRData <= MDRin;
HIData <= HIin;
LOData <= Loin;
PCData <= PCin;
IRData <= IRin;
CData <= CSE;
OutportData <= outPORTin;
InportInput <= IncomingData;
Buscontents <= BusMuxOut;
RamAddress <= MARin;
end process;

process(wireFromRAM)
begin
RamOutput <= wireFromRAM;
end process;

process(SEout,
HIout, LOout, ZHIout, ZLOout, PCout, PORTout, Cout, MDRout, 
EncoderOutput, EncoderInput)
variable TempEncoderInput : std_logic_vector(31 downto 0) := (others => '0');
begin
encoderInput <= TempEncoderInput;
encoderInput(15 downto 0) <= SEout;
encoderInput(16) <= HIout;
encoderInput(17) <= LOout;
encoderInput(18) <= ZHIout;
encoderInput(19) <= ZLOout;
encoderInput(20) <= PCout;
encoderInput(21) <= MDRout;
encoderInput(22) <= PORTout;
encoderInput(23) <= Cout;
--test signals
EncodercontentsIN <= EncoderInput;
Encodercontents <= EncoderOutput;
end process;
--dont touch for now
process(And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, 
Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig)
begin
wireAnd_sig <= And_sig; 
wireOr_sig <= Or_sig;
wireAdd_sig <= Add_sig;
wireSub_sig <= Sub_sig;
wireMul_sig <= Mul_sig; 
wireDiv_sig <= Div_sig; 
wireShr_sig <= Shr_sig; 
wireShl_sig <= Shl_sig; 
wireShra_sig <= Shra_sig; 
wireRor_sig <= Ror_sig; 
wireRol_sig <= Rol_sig; 
wireNeg_sig <= Neg_sig; 
wireNot_sig <= Not_sig; 
wireIncPC_sig <= IncPC_sig;
end process;
end behavior;