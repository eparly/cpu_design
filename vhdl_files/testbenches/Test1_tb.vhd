-- and R1, R2, R3
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- entity declaration only; no definition here
ENTITY datapath_tb IS
END ENTITY datapath_tb;
-- Architecture of the testbench with the signal names
ARCHITECTURE datapath_tb_arch OF datapath_tb IS -- Add any other signals to see in your simulation
 SIGNAL PCout_tb, Zlowout_tb, MDRout_tb, R2out_tb, R3out_tb: std_logic;
 SIGNAL MARin_tb, Zin_tb, PCin_tb, MDRin_tb, IRin_tb, Yin_tb: std_logic;
 SIGNAL IncPC_tb, Read_tb, AND_tb, R1in_tb, R2in_tb, R3in_tb: std_logic;
 SIGNAL Clock_tb: std_logic; 
 SIGNAL Mdatain_tb : std_logic_vector (31 downto 0);
 SIGNAL Opcode_tb : std_logic_vector(4 downto 0);
 
 TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1, 
 T2, T3, T4, T5);
 SIGNAL Present_state: State := default;
 -- component instantiation of the datapath
 COMPONENT CPU_BUS
 PORT (

 PCout, ZLOout, MDRout, R2out, R3out: in std_logic;
 MAREn, ZEn, PCEn, MDREn, IREn, YEn: in std_logic;
 IncPC, MDRRead, AND_sig, R1En, R2En, R3En: in std_logic;
 
 clk: in Std_logic;
 Memdatain: in std_logic_vector (31 downto 0)
 
 );
END COMPONENT CPU_BUS;
BEGIN
 DUT : datapath
--port mapping: between the dut and the testbench signals
 PORT MAP (
PCout => PCout_tb,
ZLOout => Zlowout_tb,
MDRout => MDRout_tb,
R2out => R2out_tb,
R3out => R3out_tb, 
MARin => MARin_tb,
Zin => Zin_tb,
PCin => PCin_tb,
MDRin => MDRin_tb,
IRin => IRin_tb,
Yin => Yin_tb,
IncPC => IncPC_tb,
MDRRead => Read_tb,
AND_sig => AND_tb,
R1in => R1in_tb,
R2in => R2in_tb,
R3in => R3in_tb,
clk => Clock_tb,
Memdatain => Mdatain_tb);
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
WHEN T4 =>
Present_state <= T5;
WHEN OTHERS =>
END CASE;
END IF;
END PROCESS;
PROCESS (Present_state) IS -- do the required job in each state
BEGIN 
CASE Present_state IS -- assert the required signals in each clock cycle
 WHEN Default =>
 PCout_tb <= '0'; Zlowout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
 R2out_tb <= '0'; R3out_tb <= '0'; MARin_tb <= '0'; Zin_tb <= '0'; 
 PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0'; 
 IncPC_tb <= '0'; Read_tb <= '0';  AND_tb <= '0';
 R1in_tb <= '0'; R2in_tb <= '0'; R3in_tb <= '0'; Mdatain_tb <= x”00000000”; 
 
 WHEN Reg_load1a => 
 Mdatain_tb <= x"00000012"; 
 Read_tb <= '0', '1' after 10 ns, '0' after 25 ns; -- the first zero is there for completeness
 MDRin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load1b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R2in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R2 with the value $12 
 WHEN Reg_load2a => 
 Mdatain_tb <= x"00000014"; 
 Read_tb <= '1' after 10 ns, '0' after 25 ns; 
 MDRin_tb <= '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load2b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R3in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R3 with the value $14 
 WHEN Reg_load3a => 
 Mdatain_tb <= x"00000018";
 Read_tb <= '1' after 10 ns, '0' after 25 ns; 
 MDRin_tb <= '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load3b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R1in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R1 with the value $18 
 
 WHEN T0 => -- see if you need to de-assert these signals
 PCout_tb <= '1'; MARin_tb <= '1'; IncPC_tb <= '1'; Zin_tb <= '1';
 WHEN T1 => 
 Zlowout_tb <= '1'; PCin_tb <= '1'; Read_tb <= '1'; MDRin_tb <= '1';
 Mdatain_tb <= x”28918000”; -- opcode for “and R1, R2, R3”
 WHEN T2 =>
 MDRout_tb <= '1'; IRin_tb <= '1';
 WHEN T3 =>
 R2out_tb <= '1'; Yin_tb <= '1';
 WHEN T4 =>
 R3out_tb <= '1'; AND_tb <= '1'; Zin_tb <= '1';
 WHEN T5 =>
 Zlowout_tb <= '1'; R1in_tb <= '1'; 
WHEN OTHERS =>
END CASE;
END PROCESS; 
END ARCHITECTURE datapath_tb_arch;