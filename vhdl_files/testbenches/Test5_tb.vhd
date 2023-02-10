--mul R6, R7
--*NOTE* we dont care about address decoding right now, we are manually assigning the signals to tell the system wtf to do, T0, T1, and T2 don't mean much right now
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- entity declaration only; no definition here
ENTITY test5 IS
END ENTITY test5;
-- Architecture of the testbench with the signal names
ARCHITECTURE datapath_tb_arch OF test5 IS -- Add any other signals to see in your simulation
 SIGNAL PCout_tb, Zlowout_tb, Zhiout_tb, MDRout_tb, R6out_tb, R7out_tb: std_logic;
 SIGNAL MARin_tb, Zin_tb, PCin_tb, MDRin_tb, IRin_tb, Yin_tb, LOin_tb, HIin_tb: std_logic;
 SIGNAL IncPC_tb, Read_tb, MUL_tb, R6in_tb, R7in_tb: std_logic;
 SIGNAL Clock_tb: std_logic; 
 SIGNAL Mdatain_tb : std_logic_vector (31 downto 0);
 SIGNAL Opcode_tb : std_logic_vector(4 downto 0);
 
 TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1, 
 T2, T3, T4, T5, T6);
 SIGNAL Present_state: State := default;
 -- component instantiation of the datapath
 COMPONENT CPU_BUS
 PORT (

 PCout, ZLOout, ZHIout, MDRout, R6out, R7out: in std_logic;
 MAREn, ZEn, PCEn, MDREn, IREn, YEn: in std_logic;
 IncPC_sig, MDRRead, Mul_sig, R6En, R7En, LOEn, HIEn: in std_logic;
 
 clk: in Std_logic;
 Memdatain: in std_logic_vector (31 downto 0)
 
 );
END COMPONENT CPU_BUS;
BEGIN
 DUT : CPU_BUS
--port mapping: between the dut and the testbench signals
 PORT MAP (
PCout => PCout_tb,
ZLOout => Zlowout_tb,
ZHIout => Zhiout_tb,
MDRout => MDRout_tb,
R6out => R6out_tb,
R7out => R7out_tb, 
MAREn => MARin_tb,
ZEn => Zin_tb,
PCEn => PCin_tb,
MDREn => MDRin_tb,
IREn => IRin_tb,
YEn => Yin_tb,
LOEn => LOin_tb,
HIEn => HIin_tb,
IncPC_sig => IncPC_tb,
MDRRead => Read_tb,
Mul_sig => MUL_tb,
R6En => R6in_tb,
R7En => R7in_tb,
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
WHEN T5 =>
Present_state <= T6;
WHEN OTHERS =>
END CASE;
END IF;
END PROCESS;
PROCESS (Present_state) IS -- do the required job in each state
BEGIN 
CASE Present_state IS -- assert the required signals in each clock cycle
 WHEN Default =>
 PCout_tb <= '0'; Zlowout_tb <= '0'; Zhiout_tb <= '0'; MDRout_tb <= '0'; -- initialize the signals
 R6out_tb <= '0'; R7out_tb <= '0'; MARin_tb <= '0'; Zin_tb <= '0'; 
 PCin_tb <='0'; MDRin_tb <= '0'; IRin_tb <= '0'; Yin_tb <= '0'; 
 IncPC_tb <= '0'; Read_tb <= '0';  MUL_tb <= '0'; LOin_tb <= '0'; HIin_tb <= '0';
 R6in_tb <= '0'; R7in_tb <= '0'; Mdatain_tb <= x"00000000"; 
 
 WHEN Reg_load1a => 
 Mdatain_tb <= x"00000012"; 
 Read_tb <= '0', '1' after 10 ns, '0' after 25 ns; -- the first zero is there for completeness
 MDRin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load1b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R6in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R4 with the value $12 
 WHEN Reg_load2a => 
 Mdatain_tb <= x"00000014"; 
 Read_tb <= '1' after 10 ns, '0' after 25 ns; 
 MDRin_tb <= '1' after 10 ns, '0' after 25 ns;
 WHEN Reg_load2b => 
 MDRout_tb <= '1' after 10 ns, '0' after 25 ns; 
 R7in_tb <= '1' after 10 ns, '0' after 25 ns; -- initialize R5 with the value $14 
 --WHEN Reg_load3a => 
 --Mdatain_tb <= x"00000018";
 --Read_tb <= '1' after 10 ns, '0' after 25 ns; 
 --MDRin_tb <= '1' after 10 ns, '0' after 25 ns;
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
 R6out_tb <= '1'; Yin_tb <= '1';
 WHEN T4 =>
 R7out_tb <= '1'; MUL_tb <= '1'; Zin_tb <= '1';
 WHEN T5 =>
 Zlowout_tb <= '1' after 100 ns; LOin_tb <= '1' after 100 ns; --give the multiplier some extra time to finish
 WHEN T6 =>
 Zhiout_tb <= '1'; HIin_tb <= '1';
WHEN OTHERS =>
END CASE;
END PROCESS; 
END ARCHITECTURE datapath_tb_arch;