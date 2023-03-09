--Case 10: brzr R6, 25         -----> 10011 0110 0000 0000000000000011001 -----> x"9B000019"
library ieee;
use ieee.std_logic_1164.all;

entity brzr_tb is
end entity;

architecture load_tb_arch of brzr_tb is

component CpuBus2 is 
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
end component;

type state is (Default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, 
					T0, T1, Delay1, Delay2, Delay3, T2, T3, T4, T5, T6, final);

signal Present_State: state;

signal clk_tb, clr_tb, IncPC_tb, MemRd_tb, WriteSig_tb, strobe_tb, Outport_en_tb, Inport_en_tb, BAout_tb, GRA_tb, GRB_tb, GRC_tb, Rin_tb,
	Rout_tb, RA_en_tb, HIin_tb, LOin_tb, PCIn_tb, IRin_tb, Zin_tb, Yin_tb, MARin_tb, MDRin_tb, ConIn_tb, ConOut_tb, HIout_tb, LOout_tb,
	ZHIout_tb, Zlowout_tb, PCout_tb, MDRout_tb, PortOut_tb, Cout_tb, read_tb : std_logic;
	
signal ram_read_tb, ram_write_tb: std_logic;
signal InPort_tb, OutPort_tb : std_logic_vector(31 downto 0);

SIGNAL OR_tb, ADD_tb, SUB_tb, MUL_tb, DIV_tb, SHR_tb, SHL_tb, SHRA_tb, ROR_tb, ROL_tb, NEG_tb, NOT_tb, AND_tb : std_logic;

SIGNAL R0Data, R1Data, R2Data, R3Data, R4Data, R5Data, R6Data, R7Data, R8Data, R9Data, R10Data, R11Data, R12Data, R13Data, R14Data, R15Data, MDRData, YData, ZLODATA, ZHIData, Buscontents, LOData, HIData, PCData, IRData, CData : std_logic_vector(31 downto 0);
SIGNAL wireEncodercontents : std_logic_vector(4 downto 0);
SIGNAL wireEncodercontentsIN, RAMOutput_tb, RAMAddress_tb : std_logic_vector(31 downto 0);

signal R0in_tb, R1in_tb, R2in_tb, R3in_tb, R4in_tb, R5in_tb, R6in_tb : std_logic; 

signal wireManualData : std_logic_vector(31 downto 0);
signal MDRsel_tb, R0sel_tb, R1sel_tb, R2sel_tb, R3sel_tb, R4sel_tb, R5sel_tb, R6sel_tb : std_logic;
begin 

DUT: CpuBus2
PORT MAP (
clk => clk_tb,
clear => clr_tb,

MDRRead => read_tb,
--Do we still need the MDREn port --yep, MDRread is for the MDR mux, MDREn is for the register part, they are two different signals
MDREn => MDRin_tb,

HIout => HIout_tb,
LOout => LOout_tb,
ZHIout => ZHIout_tb,
PORTout => Portout_tb,
Cout => Cout_tb,
PCout => PCout_tb,
ZLOout => ZLowout_tb,
MDRout => MDRout_tb,
--map for manually loading values into the MDR
ManualData => wireManualData,
ManR0En => R0in_tb,
ManR1En => R1in_tb,
ManR2En => R2in_tb,
ManR3En => R3in_tb,
ManR4En => R4in_tb,
ManR5En => R5in_tb,
ManR6En => R6in_tb,
MDRsel => MDRsel_tb,
R0sel => R0sel_tb,
R1sel => R1sel_tb,
R2sel => R2sel_tb,
R3sel => R3sel_tb,
R4sel => R4sel_tb,
R5sel => R5sel_tb,
R6sel => R6sel_tb,
--en -> in port maps
HIEn => HIin_tb,
LOEn => LOin_tb,
inPORTEn => Inport_en_tb,
outPORTEn => Outport_en_tb,
MAREn => MARin_tb,
ZEn => Zin_tb,
PCEn => PCin_tb,
IREn => IRin_tb,
YEn => Yin_tb,
--misc ports
gra => gra_tb,
grb => grb_tb,
grc => grc_tb,
rin => rin_tb,
rout => rout_tb,
baout => baout_tb,

--RAM
RAMReadEn => ram_read_tb,
RAMWriteEn => ram_write_tb,

IncPC_sig => IncPC_tb,
--opcode ports
And_sig => AND_tb,
Or_sig => OR_tb,
Add_sig => ADD_tb,
Sub_sig => SUB_tb,
Mul_sig => MUL_tb,
Div_sig => DIV_tb,
Shr_sig => SHR_tb,
Shl_sig => SHL_tb,
shra_sig => SHRA_tb,
ror_sig => ROR_tb,
rol_sig => ROL_tb,
Neg_sig => NEG_tb,
Not_sig => NOT_tb,
--output data of the register
R0Data => R0Data,
R1Data => R1Data,
R2Data => R2Data,
R3Data => R3Data,
R4Data => R4Data,
R5Data => R5Data,
R6Data => R6Data,
R7Data => R7Data,
R8Data => R8Data,
R9Data => R9Data,
R10Data => R10Data,
R11Data => R11Data,
R12Data => R12Data,
R13Data => R13Data,
R14Data => R14Data,
R15Data => R15Data,
MDRData => MDRData,
YData => YData,
ZLODATA => ZLODATA,
ZHIData => ZHIData,
HIData => HIData,
LOData => LOData,
PCData => PCData,
IRData => IRData,
CData => CData,
Buscontents => Buscontents,
Encodercontents => wireEncodercontents,
RAMOutput => RAMOutput_tb,
RAMAddress => RAMAddress_tb,
EncodercontentsIN => wireEncodercontentsIN,
PortCONFFEn => ConIn_tb,
CONFFout => ConOut_tb,
OutportData => OutPort_tb,
IncomingData => Inport_tb);

Clock_process: PROCESS IS
BEGIN
clk_tb <= '1', '0' after 5 ns;
 Wait for 10 ns;
END PROCESS Clock_process;

PROCESS (Clk_tb) IS -- finite state machine
BEGIN
IF (rising_edge (Clk_tb)) THEN -- if clock rising-edge
CASE Present_state IS
 WHEN Default =>
Present_state <= Reg_load1a;
WHEN Reg_load1a =>
Present_state <= Reg_load1b;
WHEN Reg_load1b =>
Present_state <= Reg_load2a;
WHEN Reg_load2a =>
Present_state <= Reg_load2b;
WHEN Reg_load2b =>
Present_state <= Reg_load3a;
 WHEN Reg_load3a =>
Present_state <= Reg_load3b;
 WHEN Reg_load3b =>
Present_state <= T0;
WHEN T0 =>
Present_state <= T1;
WHEN T1 =>
Present_state <= Delay1; --we need to stall for additional clock cycles on every RAM read in order to keep pace
WHEN Delay1 =>
Present_state <= Delay2;
WHEN Delay2 =>
Present_state <= Delay3;
WHEN Delay3 =>
Present_state <= T2;
WHEN T2 =>
Present_state <= T3;
WHEN T3 =>
Present_state <= T4;
WHEN T4 =>
Present_state <= T5;
WHEN T5 =>
Present_state <= T6;
WHEN T6 => 
Present_State <= final;
WHEN OTHERS =>
END CASE;
END IF;
END PROCESS;


PROCESS (Present_state) IS -- do the required job in each state
BEGIN 
CASE Present_state IS -- assert the required signals in each clock cycle
 WHEN Default =>
  -- initialize the signals
 
 --other register enables
 clr_tb <='0';	
 IncPC_tb<='0'; Read_tb <= '0'; WriteSig_tb<='0';	strobe_tb<='0'; 
 GRA_tb<='0';	GRB_tb<='0';	GRC_tb<='0';		
 BAout_tb<='0';	Rin_tb<='0';	Rout_tb<='0';	
 Outport_en_tb<='0';	
 HIin_tb<='0';	LOin_tb<='0'; 	PCin_tb<='0';	IRin_tb<='0';	
 Zin_tb<='0';	Yin_tb<='0';	MARin_tb<='0';	MDRin_tb<='0';	Conin_tb<='0';
 R0in_tb<='0'; R1in_tb<='0'; R2in_tb<='0'; R3in_tb<='0'; R4in_tb<='0'; R5in_tb<='0'; R6in_tb<='0';

 HIOut_tb<='0';	LOOut_tb<='0';	ZHIOut_tb<='0';
 ZLowout_tb<='0'; 	PCOut_tb<='0'; 	MDROut_tb<='0';	
 PortOut_tb<='0'; Cout_tb<='0'; wireManualData <=  x"00000009";
 
 MDRsel_tb <= '0'; R0sel_tb <= '0'; R1sel_tb <= '0'; R2sel_tb <= '0'; R3sel_tb <= '0'; R4sel_tb <= '0'; R5sel_tb <= '0'; R6sel_tb <= '0'; 
 
 --we only have to load the PC register with the initial value of 0 (address of the first instruction)
 WHEN Reg_load1a =>  
 Read_tb <= '1'; -- the first zero is there for completeness
 MDRin_tb <= '1';
 WHEN Reg_load1b => 
 Read_tb <= '0'; 
 MDRin_tb <= '0';
 
 MDRout_tb <= '1'; 
 --R0in_tb <= '1';
 --Yin_tb <= '1';
 PCin_tb <= '1'; -- initialize R2 with the value $12 
 WHEN Reg_load2a => 
 MDRout_tb <= '0';
 PCin_tb <= '0';
 --Yin_tb <= '0';
 --R0in_tb <= '0';
 
 wireManualData <=  x"00000000";
 Read_tb <= '1'; 
 MDRin_tb <= '1';
 WHEN Reg_load2b => 
 Read_tb <= '0';
 MDRin_tb <= '0';
 
 MDRout_tb <= '1'; 
 R6in_tb <= '1'; -- initialize R3 with the value $14 
 R0in_tb <= '1';
 Yin_tb <= '1';
 WHEN Reg_load3a => 
 MDRout_tb <= '0';
 R6in_tb <= '0';
 R0in_tb <= '0';
 Yin_tb <= '0';
 wireManualData <=  x"0000000B";
	
 Read_tb <= '1'; 
 MDRin_tb <= '1';
 WHEN Reg_load3b => 
 Read_tb <= '0';
 MDRin_tb <= '0';
 
 MDRout_tb <= '1'; 
 R3in_tb <= '1'; -- initialize R1 with the value $18 

 WHEN T0 => 
 --switch to interal signals
 MDRsel_tb <= '1'; R0sel_tb <= '1'; R1sel_tb <= '1'; R2sel_tb <= '1'; R3sel_tb <= '1'; R4sel_tb <= '1'; R5sel_tb <= '1'; R6sel_tb <= '1'; 
 --
 MDRout_tb <= '0';
 R3in_tb <= '0';
 
 PCout_tb <= '1'; MARin_tb <= '1'; IncPC_tb <= '1'; Zin_tb <= '1'; 
 WHEN T1 => 
 PCout_tb <= '0'; MARin_tb <= '0'; IncPC_tb <= '0'; Zin_tb <= '0'; 
 
 Zlowout_tb <= '1'; PCin_tb <= '1'; Read_tb <= '1'; MDRin_tb <= '1'; ram_read_tb <= '1';
 WHEN T2 =>
 Zlowout_tb <= '0'; PCin_tb <= '0'; Read_tb <= '0'; MDRin_tb <= '0'; ram_read_tb <= '0';
 
 MDRout_tb <= '1'; IRin_tb <= '1';
 WHEN T3 =>
 MDRout_tb <= '0'; IRin_tb <= '0';
 
 Gra_tb <= '1'; rout_tb <= '1'; ConIn_tb <= '1';
 WHEN T4 =>
 Gra_tb <='0'; rout_tb <= '0'; ConIn_tb <= '0';
 
 PCout_tb <= '1'; Yin_tb <= '1';
 WHEN T5 =>
 PCout_tb <= '0'; Yin_tb <= '0';
 
 Cout_tb <= '1'; ADD_tb <= '1'; Zin_tb <= '1';
 WHEN T6 => 
 Cout_tb <= '0'; ADD_tb <= '0'; Zin_tb <= '0';
 
 Zlowout_tb <= '1'; 
 
 if(ConOut_tb = '1') then
	PCin_tb <= '1';
 else
	PCin_tb <= '0';
 end if;
 
 WHEN final =>
 Zlowout_tb <= '0'; PCin_tb <= '0';
 
WHEN OTHERS =>
END CASE;
END PROCESS; 
END ARCHITECTURE load_tb_arch;