--neg R0, R1
--*NOTE* we dont care about address decoding right now, we are manually assigning the signals to tell the system wtf to do, T0, T1, and T2 don't mean much right now
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- entity declaration only; no definition here
ENTITY test12 IS
END ENTITY test12;
-- Architecture of the testbench with the signal names
ARCHITECTURE datapath_tb_arch OF test12 IS -- Add any other signals to see in your simulation
 --operation signals
 SIGNAL OR_tb, ADD_tb, SUB_tb, MUL_tb, DIV_tb, SHR_tb, SHL_tb, SHRA_tb, ROR_tb, ROL_tb, NEG_tb, NOT_tb, IncPC_tb, AND_tb : std_logic;
 --signals for the out ports (go into encoder)
 SIGNAL R0out_tb, R1out_tb, R2out_tb, R3out_tb, R4out_tb, R5out_tb, R6out_tb, R7out_tb, R8out_tb, R9out_tb, R10out_tb, R11out_tb, R12out_tb, R13out_tb, R14out_tb, R15out_tb, HIout_tb, LOout_tb, ZHIout_tb, Portout_tb, Cout_tb, PCout_tb, Zlowout_tb, MDRout_tb : std_logic;
 --signals for the write/enable ports on each register
 SIGNAL R0in_tb, R1in_tb, R2in_tb, R3in_tb R4in_tb, R5in_tb, R6in_tb, R7in_tb, R8in_tb, R9in_tb, R10in_tb, R11in_tb, R12in_tb, R13in_tb, R14in_tb, R15in_tb, HIin_tb, LOin_tb, Portin_tb, Cin_tb, MARin_tb, Zin_tb, PCin_tb, MDRin_tb, IRin_tb, Yin_tb : std_logic;
 --other misc ports needed
 SIGNAL Clock_tb: std_logic; 
 SIGNAL Clear_tb: std_logic;
 SIGNAL Read_tb, : std_logic;
 SIGNAL Mdatain_tb : std_logic_vector (31 downto 0);
 SIGNAL Opcode_tb : std_logic_vector(4 downto 0);
 
 TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1, 
 T2, T3, T4);
 SIGNAL Present_state: State := default;

 -- component instantiation of the datapath
component CPU_BUS is 
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
    And_sig, Or_sig, Add_sig, Sub_sig, Mul_sig, Div_sig, Shr_sig, Shl_sig, Shra_sig, Ror_sig, Rol_sig, Neg_sig, Not_sig, IncPC_sig: in std_logic
);
end component;

BEGIN
 DUT : CPU_BUS
--port mapping: between the dut and the testbench signals
 PORT MAP (
--out -> out port maps
PCout => PCout_tb,
ZLOout => Zlowout_tb,
MDRout => MDRout_tb,
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
--en -> in port maps
MAREn => MARin_tb,
ZEn => Zin_tb,
PCEn => PCin_tb,
MDREn => MDRin_tb,
IREn => IRin_tb,
YEn => Yin_tb,
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
--misc ports
clk => Clock_tb,
clear => Clear_tb,
IncPC_sig => IncPC_tb,
MDRRead => Read_tb,
And_sig => AND_tb,
Memdatain => Mdatain_tb,
--opcode ports
Or_sig => Or_tb,
Add_sig => Add_tb,
Sub_sig => Sub_tb,
Mul_sig => Mul_tb,
Div_sig => Div_tb,
SHR_sig => SHR_tb,
Shl_sig => Shl_tb,
shra_sig => shra_tb,
ror_sig => ror_tb,
rol_sig => rol_tb,
Neg_sig => neg_tb,
Not_sig => not_tb);
--add test logic here
Clock_process: PROCESS IS
BEGIN
Clock_tb <= '1', '0' after 10 ns;
 Wait for 20 ns;
END PROCESS Clock_process;
PROCESS (Clock_tb) IS -- finite state machine
BEGIN
IF (rising_edge (Clock_tb)) THEN -- if clock rising-edge
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
WHEN OTHERS =>
END CASE;
END IF;
END PROCESS;
PROCESS (Present_state) IS -- do the required job in each state
BEGIN 
CASE Present_state IS -- assert the required signals in each clock cycle
 WHEN Default =>
 PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
 R0out_tb <= '0'; R1out_tb <= '0'; MARin_tb <= '0'; Zin_tb <= '0'; 
 PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0'; 
 IncPC_tb <= '0'; Read_tb <= '0';  NEG_tb <= '0';
 R0in_tb <= '0'; R1in_tb <= '0'; Mdatain_tb <= x"00000000"; 
 
 WHEN Reg_load1a => 
 Mdatain_tb <= x"00000012"; 
 Read_tb <= '0', '1' after 10 ns, '0' after 25 ns; -- the first zero is there for completeness
 MDRin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load1b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R0in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R4 with the value $12 
 WHEN Reg_load2a => 
 Mdatain_tb <= x"00000014"; 
 Read_tb <= '1' after 10 ns, '0' after 25 ns; 
 MDRin_tb <= '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load2b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R1in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R5 with the value $14 
 WHEN Reg_load3a => 
 Mdatain_tb <= x"00000018";
 Read_tb <= '1' after 10 ns, '0' after 25 ns; 
 MDRin_tb <= '1' after 10 ns, '0' after 25 ns;
 --WHEN Reg_load3b => 
 --MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 --R0in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R0 with the value $18 idk why this is needed, this register holds the result?
 
 WHEN T0 => -- see if you need to de-assert these signals
 PCout_tb <= '1'; MARin_tb <= '1'; IncPC_tb <= '1'; Zin_tb <= '1';
 WHEN T1 => 
 Zlowout_tb <= '1'; PCin_tb <= '1'; Read_tb <= '1'; MDRin_tb <= '1';
 Mdatain_tb <= x"28918000"; -- opcode for “and R1, R2, R3” once again we don't care about the opcode
 WHEN T2 =>
 MDRout_tb <= '1'; IRin_tb <= '1';
 WHEN T3 =>
 R1out_tb <= '1'; NEG_tb <= '1'; Yin_tb <= '1'; Zin_tb <= '1'; 
 WHEN T4 =>
 Zlowout_tb <= '1'; R0in_tb <= '1';  
WHEN OTHERS =>
END CASE;
END PROCESS; 
END ARCHITECTURE datapath_tb_arch;