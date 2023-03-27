--phase 3 tb
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- entity declaration only; no definition here
ENTITY Phase3_tb IS
END ENTITY Phase3_tb;
-- Architecture of the testbench with the signal names
ARCHITECTURE datapath_tb_arch OF Phase3_tb IS -- Add any other signals to see in your simulation
 --operation signals
 signal Clock_tb, clear_tb, reset_tb, run_tb, stop_tb : std_logic;
 signal R0Data, R1Data, R2Data, R3Data, R4Data, R5Data, R6Data, R7Data, R8Data, R9Data, R10Data, R11Data, R12Data, R13Data, R14Data, R15Data, MDRData, YData, ZLODATA, ZHIData, HIData, LOData, PCData, IRData, CData, Buscontents : std_logic_vector(31 downto 0);
 signal RamOutput_tb, RamAddress_tb, EncodercontentsIN_tb : std_logic_vector(31 downto 0);
 signal Encodercontents_tb : std_logic_vector(4 downto 0);
 signal CONFFout_tb : std_logic;
 signal OutportData_tb, IncomingData_tb : std_logic_vector(31 downto 0);
 --debugging signals
 signal wireMDRRead, wireRAMReadEn, wireRAMWriteEn, wireHIEn, wireLOEn, wireZEn, wirePCEn, wireIREn, wireMDREn, wireinPORTEn, wireoutPORTEn, wireYEn, wireMAREn, wireCONFFEn, wiregra, wiregrb, wiregrc, wirerin, wirerout, wirebaout, wireCout, wirePCout, wireMDRout, wireZHIout, wireZLOout, wireHIout, wireLOout, wirePORTout, wireAnd_sig, wireOr_sig, wireAdd_sig, wireSub_sig, wireMul_sig, wireDiv_sig, wireShr_sig, wireShl_sig, wireShra_sig, wireRor_sig, wireRol_sig, wireNeg_sig, wireNot_sig, wireIncPC_sig : std_logic;
 
 
 -- component instantiation of the datapath
component CpuBus3 is 
port( 
    clk, reset, stop: in std_logic;
	 
    --ports for the outputs of the registers (used for the testbenches only) Test ports
    R0Data, R1Data, R2Data, R3Data, R4Data, R5Data, R6Data, R7Data, R8Data, R9Data, R10Data, R11Data, R12Data, R13Data, R14Data, R15Data, MDRData, YData, ZLODATA, ZHIData, HIData, LOData, PCData, IRData, CData, Buscontents: out std_logic_vector(31 downto 0);
	 Encodercontents : out std_logic_vector(4 downto 0);
	 RamOutput, RamAddress, EncodercontentsIN : out std_logic_vector(31 downto 0);
	 CONFFout : out std_logic;
	 run, clear : out std_logic;
	 --i dont really know what to do about the data regarding the in and output ports right now, so for now they will be signals to and from the CPUBUS
	 OutportData : out std_logic_vector(31 downto 0);
	 IncomingData : in std_logic_vector(31 downto 0);
	 --so we can debug wtf is going on with the CU
	 Gra_DB, Grb_DB, Grc_DB, Rin_DB, Rout_DB, HIin_DB, LOin_DB, CONin_DB, PCin_DB, IRin_DB, Yin_DB, Zin_DB, IncPC_DB, MARin_DB, MDRin_DB, OutPortin_DB, InPortin_DB, Cout_DB, BAout_DB, PCout_DB, MDRout_DB, Zhighout_DB, Zlowout_DB, HIout_DB, LOout_DB, PORTout_DB, ram_read_DB, ram_write_DB, Add_Sig_DB, Sub_Sig_DB, And_Sig_DB, Or_Sig_DB, SHR_Sig_DB, SHL_Sig_DB, ROTR_Sig_DB, ROTL_Sig_DB, Mul_Sig_DB, Div_Sig_DB, Neg_Sig_DB, Not_Sig_DB, Read_sig_DB : out std_logic
);
end component;

BEGIN
 DUT : CpuBus3
--port mapping: between the dut and the testbench signals
 PORT MAP (
clk => Clock_tb,
clear => clear_tb,
reset => reset_tb,
run => run_tb,
stop => stop_tb,
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
Encodercontents => Encodercontents_tb,
EncodercontentsIN => EncodercontentsIN_tb,
RamOutput => RamOutput_tb,
RamAddress => RamAddress_tb,
CONFFout => CONFFout_tb,
OutportData => OutportData_tb,
IncomingData => IncomingData_tb,
gra_DB => wiregra,
grb_DB => wiregrb,
grc_DB => wiregrc,
rin_DB => wirerin,
rout_DB => wirerout,
HIin_DB => wireHIEn,
LOin_DB => wireLOEn,
CONin_DB => wireCONFFEn,
PCin_DB => wirePCEn,
IRin_DB => wireIREn,
Yin_DB => wireYEn,
Zin_DB => wireZEn,
IncPC_DB => wireIncPC_sig,
MARin_DB => wireMAREn,
MDRin_DB => wireMDREn,
OutPortin_DB => wireOutPORTEn,
InPortin_DB => wireInPORTEn,
Cout_DB => wireCout,
BAout_DB => wirebaout,
PCout_DB => wirePCout,
MDRout_DB => wireMDRout,
Zhighout_DB => wireZhIout,
Zlowout_DB => wireZLoout,
HIout_DB => wireHIout,
LOout_DB => wireLOout,
PORTout_DB => wirePORTout,
ram_read_DB => wireRAMReadEn,
ram_write_DB => wireRAMWriteEn,
Add_Sig_DB => wireAdd_sig,
Sub_Sig_DB => wireSub_sig,
And_Sig_DB => wireAnd_sig,
Or_Sig_DB => wireOr_sig,
SHR_Sig_DB => wireShr_sig,
SHL_Sig_DB => wireShl_sig,
ROTR_Sig_DB => wireRor_sig,
ROTL_Sig_DB => wireRol_sig,
Mul_Sig_DB => wireMul_sig,
Div_Sig_DB => wireDiv_sig,
Neg_Sig_DB => wireNeg_sig,
Not_Sig_DB => wireNot_sig,
Read_sig_DB => wireMDRRead
);
--add test logic here

Clock_process: PROCESS IS
BEGIN
Clock_tb <= '1', '0' after 5 ns;
 Wait for 10 ns;
END PROCESS Clock_process;

tb_process: PROCESS IS
BEGIN
reset_tb <= '1'; stop_tb <= '1';
wait until rising_edge(clock_tb);
reset_tb <= '0'; stop_tb <='0';
wait;
END PROCESS;

END ARCHITECTURE datapath_tb_arch;