library IEEE;
use IEEE.std_logic_1164.all;

entity mux32_1
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

end mux32_1;



architecture behavior of mux32_1 is

component reg is
port( signal reg_input : in std_logic_vector(31 downto 0);
signal clk: in std_logic;
signal clear: in std_logic;
signal writeEnable: in std_logic;
signal reg_out : out std_logic_vector(31 downto 0);
);
--we need to do something with portmapping I believe?
end component;

begin

	case sel is
		when "00000" =>
			bus_mux_out <= bus_mux_in_0;
		when "00001" =>
			bus_mux_out <= bus_mux_in_1;
		when "00010" =>
			bus_mux_out <= bus_mux_in_2;
		when "00011" =>
			bus_mux_out <= bus_mux_in_3;
		when "00100" =>
			bus_mux_out <= bus_mux_in_4;
		when "00101" =>
			bus_mux_out <= bus_mux_in_5;
		when "00110" =>
			bus_mux_out <= bus_mux_in_6;
		when "00111" =>
			bus_mux_out <= bus_mux_in_7;
		when "01000" =>
			bus_mux_out <= bus_mux_in_8;
		when "01001" =>
			bus_mux_out <= bus_mux_in_9;
		when "01010" =>
			bus_mux_out <= bus_mux_in_10;
		when "01011" =>
			bus_mux_out <= bus_mux_in_11;
		when "01100" =>
			bus_mux_out <= bus_mux_in_12;
		when "01101" =>
			bus_mux_out <= bus_mux_in_13;
		when "01110" =>
			bus_mux_out <= bus_mux_in_14;
		when "01111" =>
			bus_mux_out <= bus_mux_in_15; --general registers stop here, default register for now
		when "10000" =>
			bus_mux_out <= bus_mux_in_HI;
		when "10001" =>
			bus_mux_out <= bus_mux_in_LO;
		when "10010" =>
			bus_mux_out <= bus_mux_in_Z_high;
		when "10011" =>
			bus_mux_out <= bus_mux_in_Z_low;
		when "10100" =>
			bus_mux_out <= bus_mux_in_PC;
		when "10101" =>
			bus_mux_out <= bus_mux_in_MDR;
		when "10110" =>
			bus_mux_out <= bus_mux_in_InPort;
		when "10111" =>
			bus_mux_out <= bus_mux_in_C_sign_extended;
		when others =>
			bus_mux_out <= bus_mux_in_15;
	end case;


end behavior;
