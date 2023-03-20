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
	 IncomingData : in std_logic_vector(31 downto 0)
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
IncomingData => IncomingData_tb
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