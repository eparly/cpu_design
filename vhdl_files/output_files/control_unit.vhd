library IEEE;
use IEEE.std_logic_1164.all;

entity control_unit is
port(Clock, Reset, Stop, CONFF: in std_logic;
		Run, Clear: out std_logic;
		IR: in std_logic_vector(31 downto 0);
		ram_read, ram_write: out std_logic;
		Gra, Grb, Grc, Rin, Rout: out std_logic;
		HIin, LOin, CONin, PCin, IRin, Yin, Zin, IncPC, MARin, MDRin, OutPortin, InPortin, Cout, BAout: out std_logic;
		PCout, MDRout, Zhighout, Zlowout, HIout, LOout, PORTout: out std_logic;
		Add_Sig, Sub_Sig, And_Sig, Or_Sig, 
		SHR_Sig, SHRA_Sig, SHL_Sig, ROTR_Sig, ROTL_Sig,
		Mul_Sig, Div_Sig, Neg_Sig, Not_Sig: out std_logic;
		Read_sig: out std_logic);
end control_unit;

architecture behavior of control_unit is
TYPE State IS (Fetch0, fetch1, fetchD1, fetchD2, fetchD3, fetch2, 
						load3, load4, load5, load6, load61, load62, load63, load7,
						loadi3, loadi_delay, loadi4, loadi5,
						store3, store4, store5,
						loadr3, loadr4, loadr5, 
						loadr61, loadr62, loadr63, loadr7,
						storer3, storer4, storer5, storer6, storer7,
						Add3, Add4, Add5,
						Sub3, Sub4, Sub5,
						And3, And4, And5,
						Or3, Or4, Or5,
						SHR3, SHR4, SHR5,
						SHRA3, SHRA4, SHRA5,
						SHL3, SHL4, SHL5,
						RotR3, RotR4, RotR5,
						RotL3, RotL4, RotL5,
						addi3, addi4, addi5,
						andi3, andi4, andi5,
						ori3, ori4, ori5,
						mul3, mul4, mul5, mul6,
						div3, div4, div5, div6,
						neg3, neg4, neg5,
						not3, not4, not5,
						br3, br4, br5, br6,
						jr3,
						jal3, jal4, jal5,
						in3,
						out3,
						mfhi3,
						mflo3,
						nop,
						halt,
						Reset_State);
Signal present_state: state;
begin
process(clock, reset, stop)
begin
	if(Reset='1') then
		present_state <= reset_State;
	elsif(rising_edge(clock) and stop = '0') then
		case present_state is 
			when reset_State =>
				present_state <= fetch0;
			when fetch0 =>
				present_state <= fetch1;
			when fetch1 =>
				present_state <= fetchD1;
			when fetchD1 =>
				present_state <= fetchD2;
			when fetchD2 => 
				present_state <= fetchD3;
			when fetchD3 =>
				present_state <= fetch2;
			when fetch2 =>
				case IR(31 downto 27) is
					when "00000" =>
						present_state <= load3;
					when "00001" =>
						present_state <= loadi3;
					when "00010" => 
						present_state <= store3;
					when "00011" =>
						present_state <=add3;
					when "00100" =>
						present_state <= sub3;
					when "00101" =>
						present_state <= and3;
					when "00110" =>
						present_state <= or3;
					when "00111" =>
						present_state <= shr3;
					when "01000" =>
						present_state <= shra3;
					when "01001" =>
						present_state <= shl3;
					when "01010" =>
						present_state <= rotR3;
					when "01011" =>
						present_state <= rotL3;
					when "01100" =>
						present_state <= addi3;
					when "01101" => 
						present_state <= andi3;
					when "01110" =>
						present_state <= ori3;
					when "01111" =>
						present_state <= mul3;
					when "10000" =>
						present_state <= div3;
					when "10001" =>
						present_state <= neg3;
					when "10010" =>
						present_state <= not3;
					when "10011" =>
						present_state <= br3;
					when "10100" => 
						present_state <= jr3;
					when "10101" =>
						present_state <= jal3;
					when "10110" =>
						present_state <= in3;
					when "10111" =>
						present_state <= out3;
					when "11000" =>
						present_state <= mfhi3;
					when "11001" =>
						present_state <= mflo3;
					when "11010" =>
						present_state <= nop;
					when "11011" =>
						present_state <= halt;
					when others =>
				end case;
			when load3 =>
				Present_State <= load4;
			when load4 =>
				Present_State <= load5;
			when load5 =>
				present_State <= load6;
			when load6 =>
				Present_State <= load61;
			when load61 =>
				Present_State <= load62;	
			when load62 =>
				Present_State <= load63;
			when load63 =>
				Present_State <= load7;
			when load7 =>
				Present_State <= fetch0;
			-------------------------------------------
			when loadi3 =>
				Present_State <= loadi_delay;
			when loadi_delay =>
				Present_State <= loadi4;
			when loadi4 =>
				Present_State <= loadi5;
			when loadi5 =>
				Present_State <= fetch0;
			-------------------------------------------
			when store3 =>
				Present_State <= store4;
			when store4 =>
				Present_State <= store5;
			when store5 =>
				Present_State <= fetch0;
			-------------------------------------------
			when add3 =>
				Present_State <= add4;
			when add4 =>
				Present_State <= add5;
			when add5 =>
				Present_State <= fetch0;					
			-------------------------------------------
			when sub3 =>
				Present_State <= sub4;
			when sub4 =>
				Present_State <= sub5;
			when sub5 =>
				Present_State <= fetch0;					
			-------------------------------------------
			when and3 =>
				Present_State <= and4;
			when and4 =>
				Present_State <= and5;
			when and5 =>
				Present_State <= fetch0;					
			-------------------------------------------
			when or3 =>
				Present_State <= or4;
			when or4 =>
				Present_State <= or5;
			when or5 =>
				Present_State <= fetch0;	
			-------------------------------------------
			when SHR3 =>
				Present_State <= SHR4;
			when SHR4 =>
				Present_State <= SHR5;
			when SHR5 =>
				Present_State <= fetch0;	
			-------------------------------------------
			when SHRA3 =>
				Present_State <= SHRA4;
			when SHRA4 =>
				Present_State <= SHRA5;
			when SHRA5 =>
				Present_State <= fetch0;	
			-------------------------------------------
			when SHL3 =>
				Present_State <= SHL4;
			when SHL4 =>
				Present_State <= SHL5;
			when SHL5 =>
				Present_State <= fetch0;
			-------------------------------------------
			when ROTR3 =>
				Present_State <= ROTR4;
			when ROTR4 =>
				Present_State <= ROTR5;
			when ROTR5 =>
				Present_State <= fetch0;	
			-------------------------------------------
			when ROTL3 =>
				Present_State <= ROTL4;
			when ROTL4 =>
				Present_State <= ROTL5;
			when ROTL5 =>
				Present_State <= fetch0;	
			-------------------------------------------
			when addi3 =>
				Present_State <= addi4;
			when addi4 =>
				Present_State <= addi5;
			when addi5 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when andi3 =>
				Present_State <= andi4;
			when andi4 =>
				Present_State <= andi5;
			when andi5 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when ori3 =>
				Present_State <= ori4;
			when ori4 =>
				Present_State <= ori5;
			when ori5 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when mul3 =>
				Present_State <= mul4;
			when mul4 =>
				Present_State <= mul5;
			when mul5 =>
				Present_State <= mul6;
			when mul6 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when div3 =>
				Present_State <= div4;
			when div4 =>
				Present_State <= div5;
			when div5 =>
				Present_State <= div6;
			when div6 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when neg3 =>
				Present_State <= neg4;
			when neg4 =>
				Present_State <= neg5;
			when neg5 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when not3 =>
				Present_State <= not4;
			when not4 =>
				present_State <= not5;
			when not5 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when br3 =>
				Present_State <= br4;
			when br4 =>
				present_State <= br5;
			when br5 =>
				present_State <= br6;
			when br6 =>
				present_State <= fetch0;
			-------------------------------------------	
			when jr3 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when jal3 =>
				Present_State <= jal4;
			when jal4 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when in3 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when out3 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when mfhi3 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when mflo3 =>
				Present_State <= fetch0;
			-------------------------------------------	
			when nop =>
				Present_State <= fetch0;
			when halt => 
				Present_State <= halt;
			when others =>
		end case;
	end if;
end process;

process(present_State) is 
begin
	case present_State is 
		when reset_State =>
			clear <='1'; run <='0';
			Gra <= '0'; Grb <= '0'; Grc <= '0'; Rin <= '0'; Rout <= '0';
			HIin <= '0'; LOin <= '0'; CONin <= '0'; PCin <= '0'; IRin <= '0'; Yin <= '0'; Zin <= '0'; 
			IncPC <= '0'; MARin <= '0'; MDRin <= '0'; OutPortin <= '0'; InPortin <= '0'; Cout <= '0'; BAout <= '0';
			Rin <= '0'; Rout <= '0'; Gra <= '0'; Grb <= '0'; Grc <= '0';
			PCout <= '0'; MDRout <= '0'; Zhighout <= '0'; Zlowout <= '0'; HIout <= '0'; LOout <= '0'; PORTout <= '0';
			Add_Sig <= '0'; Sub_Sig <= '0'; And_Sig <= '0'; Or_Sig <= '0'; 
			SHR_Sig <= '0'; SHL_Sig <= '0'; ROTR_Sig <= '0'; ROTL_Sig <= '0';
			Mul_Sig <= '0'; Div_Sig <= '0'; Neg_Sig <= '0'; Not_Sig <= '0';
			Read_sig <= '0';
		when fetch0 =>		
			PCout <='1'; MARin <='1'; INCPC <='1'; Zin <='1'; Run <= '1'; clear <= '0';
			
			Gra <= '0'; Grb <= '0'; Grc <= '0'; Rin <= '0'; Rout <= '0';
			HIin <= '0'; LOin <= '0'; CONin <= '0'; PCin <= '0'; IRin <= '0'; Yin <= '0'; Zin <= '0'; 
			IncPC <= '0'; MARin <= '0'; MDRin <= '0'; OutPortin <= '0'; InPortin <= '0'; Cout <= '0'; BAout <= '0';
			Rin <= '0'; Rout <= '0'; Gra <= '0'; Grb <= '0'; Grc <= '0';
			PCout <= '0'; MDRout <= '0'; Zhighout <= '0'; Zlowout <= '0'; HIout <= '0'; LOout <= '0'; PORTout <= '0';
			Add_Sig <= '0'; Sub_Sig <= '0'; And_Sig <= '0'; Or_Sig <= '0'; 
			SHR_Sig <= '0'; SHL_Sig <= '0'; ROTR_Sig <= '0'; ROTL_Sig <= '0';
			Mul_Sig <= '0'; Div_Sig <= '0'; Neg_Sig <= '0'; Not_Sig <= '0';
			Read_sig <= '0';
		when fetch1 =>
			PCout <='0'; MARin <='0'; INCPC <='0'; Zin <='0';
			
			Zlowout <='1'; PCin <='1'; read_sig <='1'; mdrin <='1'; ram_read <='1';
		when fetch2 =>
			Zlowout <='0'; PCin <='0'; read_sig <='0'; mdrin <='0'; ram_read <='0';
			
			mdrout <='1'; IRin <='1';
		
		----------------------------
		
		when load3 =>
			mdrout <='0'; IRin <='0';
			
			Grb <='1'; BAout <='1'; yin <='1'; --might need to add in delay step for Yin signal, if not working do this for all ops!!!
		when load4 =>
			Grb <='0'; BAout <='0'; yin <='0';
			
			Cout <= '1'; add_Sig <='1'; Zin <='1';
		when load5 =>
			Cout <= '0'; add_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; MARin <='1';
		when load6 =>
			Zlowout <='0'; MARin <='0';
			
			read_sig <= '1'; MDRin <='1'; ram_read <='1';
		when load7 =>
			read_sig <= '0'; MDRin <='0'; ram_read <='0';
			
			MDRout <='1'; Gra <='1'; Rin <='1';
		---------------------------------------
		
		when loadi3 =>
			MDRout <='0'; IRin <='0';
			
			Grb <='1';
			if(IR(22 downto 19) = "0000") then
				rout <= '1';
			else
				BAout <='1';
			end if;
		when loadi_delay =>
			Yin <= '1'; IncPC <= '1';
		when loadi4 =>
			Grb <='0'; BAout <='0'; rout <= '0'; Yin <='0';
			
			Cout <= '1'; Add_Sig<='1'; Zin <='1';
		when loadi5 =>
			Cout <= '0'; Add_Sig<='0'; Zin <='0';
			
			Zlowout <='1'; Gra <='1'; Rin <='1';
		-------------------------
		when store3 =>
			MDRout <='0'; IRin <='0';
			
			Grb <='1'; BAout <='1'; Yin <='1';
		when store4 =>
			Grb <='0'; BAout <='0'; Yin <='0';
			
			Cout <= '1'; Add_Sig<='1'; Zin <='1';
		when store5 =>
			Cout <= '0'; Add_Sig<='0'; Zin <='0';
			
			Zlowout <= '1'; MARin <='1'; --might need to add more states to reflect the testbench, unsure because we loaded back
												  -- after storing, so this might need to change <--- we can check memory in Model Sim
		-----------------------------------
		when add3 => --we didnt have a testbench for the form add r1, r2, r3, this is my best shot at it
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when add4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; add_Sig <='1'; Zin <='1';
		when add5 =>
			Rout <='0'; Grc <='0'; add_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------
			
		when sub3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when sub4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; sub_Sig <='1'; Zin <='1';
		when sub5 =>
			Rout <='0'; Grc <='0'; sub_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------
		when and3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when and4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; and_Sig <='1'; Zin <='1';
		when and5 =>
			Rout <='0'; Grc <='0'; and_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------	
		when or3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when or4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; or_Sig <='1'; Zin <='1';
		when or5 =>
			Rout <='0'; Grc <='0'; or_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------	
		when SHR3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when SHR4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; SHR_Sig <='1'; Zin <='1';
		when SHR5 =>
			Rout <='0'; Grc <='0'; SHR_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------		
		when SHRA3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when SHRA4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; SHRA_Sig <='1'; Zin <='1';
		when SHRA5 =>
			Rout <='0'; Grc <='0'; SHRA_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------	
		when SHL3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when SHL4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; SHL_Sig <='1'; Zin <='1';
		when SHL5 =>
			Rout <='0'; Grc <='0'; SHL_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------	
		when ROTR3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when ROTR4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; ROTR_Sig <='1'; Zin <='1';
		when ROTR5 =>
			Rout <='0'; Grc <='0'; ROTR_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------			
		when ROTL3 => 
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when ROTL4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Rout <='1'; Grc <='1'; ROTL_Sig <='1'; Zin <='1';
		when ROTL5 =>
			Rout <='0'; Grc <='0'; ROTL_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Rin <='1'; Gra <='1';
		-------------------------------------------			
		when addi3 =>
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when addi4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Cout <='1'; Add_Sig <='1'; Zin <='1';
		when addi5 =>
			Cout <='0'; Add_Sig <='0'; Zin <='0';
				
			Zlowout <='1'; Gra <='1'; Rin<='1';
		-------------------------------------------
		when ori3 =>
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Grb <='1'; Yin <='1';
		when ori4 =>
			Rout <='0'; Grb <='0'; Yin <='0';
			
			Cout <='1'; or_Sig <='1'; Zin <='1';
		when ori5 =>
			Cout <='0'; or_Sig <='0'; Zin <='0';
				
			Zlowout <='1'; Gra <='1'; Rin<='1';
		-------------------------------------------
		when mul3 =>
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Gra <='1'; Yin <='1';
		when mul4 => 
			Rout <='0'; Gra <='0'; Yin <='0';
			
			Rout <='1'; Grb <='1'; Zin <='1'; Mul_Sig <='1';
		when mul5 => 
			Rout <='0'; Grb <='0'; Zin <='0'; Mul_Sig <='0';
			
			Zlowout <='1'; LOin <='1';
		when mul6 =>
			Zlowout <='0'; LOin <='0';
			
			Zhighout <='1'; HIin <='1';
		--------------------------------------------
		when div3 =>
			MDRout <='0'; IRin <='0';
		
			Rout <='1'; Gra <='1'; Yin <='1';
		when div4 => 
			Rout <='0'; Gra <='0'; Yin <='0';
			
			Rout <='1'; Grb <='1'; Zin <='1'; Div_Sig <='1';
		when div5 => 
			Rout <='0'; Grb <='0'; Zin <='0'; Div_Sig <='0';
			
			Zlowout <='1'; LOin <='1';
		when Div6 =>
			Zlowout <='0'; LOin <='0';
			
			Zhighout <='1'; HIin <='1';
		--------------------------------------------		
		when neg3 => 
			MDRout <='0'; IRin <='0';
			
			Rout <='1'; Grb <='1'; Yin <='1'; NEG_Sig <='1'; Zin <='1'; -- might need to break into 2 steps
		when neg4 =>
			Rout <='0'; Grb <='0'; Yin <='0'; NEG_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Gra <='1'; Rin <='1';
		--------------------------------------------
		when not3 => 
			MDRout <='0'; IRin <='0';
			
			Rout <='1'; Grb <='1'; Yin <='1'; NOT_Sig <='1'; Zin <='1'; -- might need to break into 2 steps
		when not4 =>
			Rout <='0'; Grb <='0'; Yin <='0'; NOT_Sig <='0'; Zin <='0';
			
			Zlowout <='1'; Gra <='1'; Rin <='1';
		---------------------------------------------
		when br3 => 
			MDRout <='0'; IRin <='0';
			
			Gra <='1'; Rout <='1'; Conin <='1';
		when br4 =>
			Gra <='0'; Rout <='0'; Conin <='0';
			
			PCout <='1'; Yin <='1';
		when br5 =>
			PCout <='0'; Yin <='0';
			
			Cout <='1'; Add_Sig <='1'; Zin <='1';
		when br6 => 
			Cout <='0'; Add_Sig <='0'; Zin <='0';
			
			Zlowout <='1';
			if(CONFF = '1') then
				PCin <='1';
			else
				PCin <='0';
			end if;
		----------------------------------------------
		when jr3 =>
			MDRout <='0'; IRin <='0';
			
			Gra <='1'; Rout <='1'; PCin <='1';
		----------------------------------------------
		when jal3 =>
			MDRout <='0'; IRin <='0';
			
			Grb <='1'; Rin <='1'; PCout <='1';
		when jal4 =>
			Grb <='1'; Rin <='1'; PCout <='1';
			
			Gra <='1'; Rout <='1'; PCin <='1';
		----------------------------------------------
		when in3 =>
			MDRout <='0'; IRin <='0';
			
			Gra <='1'; Rin <='1'; PORTout <='1';
		----------------------------------------------
		when out3 =>
			MDRout <='0'; IRin <='0';
			
			Gra <='1'; Rout <='1'; OutPortin <='1';
		----------------------------------------------
		when mfhi3 =>
			MDRout <='0'; IRin <='0';
			
			Hiout <='1'; Rin <='1'; Gra <='1';
		----------------------------------------------
		when mflo3 =>
			MDRout <='0'; IRin <='0';
			
			Loout <='1'; Rin <='1'; Gra <='1';
		----------------------------------------------
		when nop => --easisest instruction
		----------------------------------------------
		when halt =>
			run <='0';
		----------------------------------------------
		when others =>
		
	end case;
end process;			
end behavior;		