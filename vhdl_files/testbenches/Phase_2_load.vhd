library ieee;
use ieee.std_logic_1164;

entity load_tb is
end entity;


architecture load_tb_arch of load_tb is

component CpuBus is 
port( --needed to be done this way to implement the control unit later <- see comments at the bottom
    clk: in std_logic;
    clear: in std_logic;
--Comes from the control unit, maps to each registers 'writeEnable' port
    R0En, R1En, R2En, R3En, R4En, R5En, R6En, R7En, R8En, R9En, R10En, R11En, R12En, R13En, R14En, R15En, HIEn, LOEn, ZEn, PCEn, IREn, MDREn, PORTEn, CEn, YEn, MAREn : in std_logic;
--From the control unit, maps into the encoder, dictates which register can put its data onto the bus
    R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, ZHIout, ZLOout, PCout, PORTout, Cout : in std_logic;
    --MDR requires a slightly different setup
    MDRout, MDRRead : in std_logic; --from control unit, MDRout maps to encoder, MDRRead maps to MDR's MUX as the control signal
    MemDatain : in std_logic_vector(31 downto 0); --output from memory that is an input for the MDR's MUX
    --opcode signals from control unit (single bit)
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic;
    --ports for the outputs of the registers (used for the testbenches only) Test ports
    R0Data, R1Data, R2Data, R3Data, R4Data, R5Data, R6Data, R7Data, R8Data, R9Data, R10Data, R11Data, R12Data, R13Data, R14Data, R15Data, MDRData, YData, ZLODATA, ZHIData, HIData, LOData, Buscontents: out std_logic_vector(31 downto 0);
	 Encodercontents : out std_logic_vector(4 downto 0);
	 EncodercontentsIN : out std_logic_vector(31 downto 0)
);
end component;

type state is (T0, T1, T2, T3, T4, T5, T6, T7);
type operation is (Default, LoadR2, LoadR3, LoadR4, LoadR5, LoadR6, LoadR7,
		Add, Sub, Mul, Div, AndOp, OrOp, SHR, SHL, RotRight, RotLeft, Neg, NotOp,
		Load, LoadI, LoadR, Store, StoreR, AddI, AndI, OrI, BranchZero, BranchNZero, BranchPos, BranchNeg,
		Jump, JumpAL, Movefhi, Moveflo, Input, Output
		);
signal currentOp : operation;
signal currentState: state;

signal clk_tb, clr_tb, IncPC_tb, MemRd_tb, WriteSig_tb, strobe_tb, Outport_en_tb, BAout_tb, GRA_tb, GRB_tb, GRC_tb, Rin_tb,
	Rout_tb, RA_en_tb, HIin_tb, LOin_tb, PCIn_tb, IRin_tb, Zin_tb, Yin_tb, MARin_tb, MDRin_tb, Conin_tb, HIout_tb, LOout_tb,
	ZHIout_tb, Zlowout_tb, PCout_tb, MDRout_tb, PortOut_tb, Cout_tb : std_logic;
	
signal InPort_tb, OutPort_tb : std_logic_vector(31 downto 0);

SIGNAL OR_tb, ADD_tb, SUB_tb, MUL_tb, DIV_tb, SHR_tb, SHL_tb, SHRA_tb, ROR_tb, ROL_tb, NEG_tb, NOT_tb, IncPC_tb, AND_tb : std_logic;
 --signals for the out ports (go into encoder)
SIGNAL R0out_tb, R1out_tb, R2out_tb, R3out_tb, R4out_tb, R5out_tb, R6out_tb, R7out_tb, R8out_tb, R9out_tb, R10out_tb, R11out_tb, R12out_tb, R13out_tb, R14out_tb, R15out_tb : std_logic;
 --signals for the write/enable ports on each register
SIGNAL R0in_tb, R1in_tb, R2in_tb, R3in_tb, R4in_tb, R5in_tb, R6in_tb, R7in_tb, R8in_tb, R9in_tb, R10in_tb, R11in_tb, R12in_tb, R13in_tb, R14in_tb, R15in_tb: std_logic;

SIGNAL R0Data, R1Data, R2Data, R3Data, R4Data, R5Data, R6Data, R7Data, R8Data, R9Data, R10Data, R11Data, R12Data, R13Data, R14Data, R15Data, MDRData, YData, ZLODATA, ZHIData, Buscontents : std_logic_vector(31 downto 0);
SIGNAL wireEncodercontents : std_logic_vector(4 downto 0);
SIGNAL wireEncodercontentsIN : std_logic_vector(31 downto 0);

begin 

DUT: CPUBus 
PORT MAP (
--out -> out port maps
R0out => R0out_tb,
R1out => R1out_tb,
R2out => R2out_tb,
R3out => R3out_tb, 
R4out => R4out_tb,
R5out => R5out_tb,
R6out => R6out_tb,
R7out => R7out_tb,
R8out => R8out_tb,
R9out => R9out_tb,
R10out => R10out_tb,
R11out => R11out_tb,
R12out => R12out_tb,
R13out => R13out_tb,
R14out => R14out_tb,
R15out => R15out_tb,
HIout => HIout_tb,
LOout => LOout_tb,
ZHIout => ZHIout_tb,
PORTout => Portout_tb,
Cout => Cout_tb,
PCout => PCout_tb,
ZLOout => ZLOout_tb,
MDRout => MDRout_tb,
--en -> in port maps
R1En => R1in_tb,
R2En => R2in_tb,
R3En => R3in_tb,
R0En => R0in_tb,
R4En => R4in_tb,
R5En => R5in_tb,
R6En => R6in_tb,
R7En => R7in_tb,
R8En => R8in_tb,
R9En => R9in_tb,
R10En => R10in_tb,
R11En => R11in_tb,
R12En => R12in_tb,
R13En => R13in_tb,
R14En => R14in_tb,
R15En => R15in_tb,
HIEn => HIin_tb,
LOEn => LOin_tb,
PORTEn => Portin_tb,
CEn => Cin_tb,
MAREn => MARin_tb,
ZEn => Zin_tb,
PCEn => PCin_tb,
MDREn => MDRin_tb,
IREn => IRin_tb,
YEn => Yin_tb,
--misc ports
clk => Clock_tb,
clear => Clear_tb,
IncPC_sig => IncPC_tb,
MDRRead => Read_tb,
Memdatain => Mdatain_tb,
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
Buscontents => Buscontents,
Encodercontents => wireEncodercontents,
EncodercontentsIN => wireEncodercontentsIN);

Clock_process: PROCESS IS
BEGIN
Clock_tb <= '1', '0' after 10 ns;
 Wait for 20 ns;
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
Present_state <= T7;
WHEN T7 =>
Present_state <= final;
WHEN OTHERS =>
END CASE;
END IF;
END PROCESS;


PROCESS (Present_state) IS -- do the required job in each state
BEGIN 
CASE Present_state IS -- assert the required signals in each clock cycle
 WHEN Default =>
  -- initialize the signals
  
  --general purpose registers
 R0out_tb <= '0'; R1out_tb <= '0'; R2out_tb <= '0'; R3out_tb <= '0'; R4out_tb <= '0'; 
 R5out_tb <= '0'; R6out_tb <= '0'; R7out_tb <= '0'; R8out_tb <= '0'; R9out_tb <= '0'; 
 R10out_tb <= '0'; R11out_tb <= '0'; R12out_tb <= '0'; R13out_tb <= '0'; R14out_tb <= '0'; 
 R15out_tb <= '0'; 
 
 --other register enables
 clr_tb <='1';	
 IncPC_tb<='0'; Read_tb <= '0'; WriteSig_tb<='0';	strobe_tb<='0'; 
 GRA_tb<='0';	GRB_tb<='0';	GRC_tb<='0';		
 BAout_tb<='0';	Rin_tb<='0';	Rout_tb<='0';	
 Outport_en_tb<='0';	
 HIin_tb<='0';	LOin_tb<='0'; 	PCin_tb<='0';	IRin_tb<='0';	
 Zin_tb<='0';	Yin_tb<='0';	MARin_tb<='0';	MDRin_tb<='0';	Conin_tb<='0';

 HIOut_tb<='0';	LOOut_tb<='0';	ZHIOut_tb<='0';
 ZLowout_tb<='0'; 	PCOut_tb<='0'; 	MDROut_tb<='0';	
 PortOut_tb<='0'; Cout_tb<='0'; 
 Mdatain_tb <= x"00000000"; 
 
 WHEN Reg_load1a => 
 Mdatain_tb <= x"00000000"; 
 Read_tb <= '0', '1' after 10 ns; -- the first zero is there for completeness
 MDRin_tb <= '0', '1' after 10 ns;
 WHEN Reg_load1b => 
 Read_tb <= '0'; 
 MDRin_tb <= '0';
 
 MDRout_tb <= '1' after 10 ns; 
 R2in_tb <= '1' after 10 ns; -- initialize R2 with the value $12 
 WHEN Reg_load2a => 
 MDRout_tb <= '0';
 R2in_tb <= '0';
 
 Mdatain_tb <= x"00000014"; 
 Read_tb <= '1' after 10 ns; 
 MDRin_tb <= '1' after 10 ns;
 WHEN Reg_load2b => 
 Read_tb <= '0';
 MDRin_tb <= '0';
 
 MDRout_tb <= '1' after 10 ns; 
 R3in_tb <= '1' after 10 ns; -- initialize R3 with the value $14 
 WHEN Reg_load3a => 
 MDRout_tb <= '0';
 R3in_tb <= '0';
 
 Mdatain_tb <= x"00000000";
 Read_tb <= '1' after 10 ns; 
 MDRin_tb <= '1' after 10 ns;
 WHEN Reg_load3b => 
 Read_tb <= '0';
 MDRin_tb <= '0';
 
 MDRout_tb <= '1' after 10 ns; 
 R1in_tb <= '1' after 10 ns; -- initialize R1 with the value $18 
 
 WHEN T0 => 
 MDRout_tb <= '0';
 R1in_tb <= '0';
 
 PCout_tb <= '1' after 10 ns; MARin_tb <= '1' after 10 ns; IncPC_tb <= '1' after 10 ns; Zin_tb <= '1' after 10 ns;
 WHEN T1 => 
 PCout_tb <= '0'; MARin_tb <= '0'; IncPC_tb <= '0'; Zin_tb <= '0';
 
 Zlowout_tb <= '1' after 10 ns; PCin_tb <= '1' after 10 ns; Read_tb <= '1' after 10 ns; MDRin_tb <= '1' after 10 ns;
 Mdatain_tb <= x"28918000"; -- opcode for “and R1, R2, R3” 
 WHEN T2 =>
 Zlowout_tb <= '0'; PCin_tb <= '0'; Read_tb <= '0'; MDRin_tb <= '0';
 
 MDRout_tb <= '1' after 10 ns; IRin_tb <= '1' after 10 ns;
 WHEN T3 =>
 MDRout_tb <= '0'; IRin_tb <= '0';
 
 Grb_tb <= '1' after 10 ns; BAout_tb <= '1' after 10 ns; Yin_tb<='1' after 10 ns;
 WHEN T4 =>
 Grb_tb <='0'; BAout_tb <= '0'; Yin_tb <= '0';
 
 Cout_tb <= '1' after 10 ns; ADD_tb <= '1' after 10 ns; Zin_tb <= '1' after 10 ns;
 WHEN T5 =>
 Cout_tb <= '0'; ADD_tb <= '0'; Zin_tb <= '0';
 
 Zlowout_tb <= '1' after 10 ns; MARin_tb <= '1' after 10 ns; 
 WHEN T6 =>
 Zlowout_tb <='0'; MARin_tb <='0';
 
 Read_tb <= '1' after 10 ns; Mdatain_tb <=x"00000000" after 10 ns; MDRin_tb <= '1' after 10 ns;
 WHEN T7 =>
 Read_tb <='0'; MDRin_tb <='0';
 
 MDROut_tb <='1' after 10 ns; GRA_tb <= '1' after 10 ns; R1in_tb <='1' after 10 ns;
 WHEN final =>
 MDROut_tb <='0'; GRA_tb <='0'; R1in_tb <= '0';
WHEN OTHERS =>
END CASE;
END PROCESS; 
END ARCHITECTURE load_tb_arch;