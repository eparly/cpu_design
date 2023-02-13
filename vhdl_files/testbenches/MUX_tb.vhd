library ieee;
use ieee.std_logic_1164.all;

entity MUX_tb is
end entity;

architecture behavior of MUX_tb is

signal sel : std_logic_vector(4 downto 0);
signal bus_mux_in_0, bus_mux_in_1, bus_mux_in_2, bus_mux_in_3, bus_mux_in_4, bus_mux_in_5, bus_mux_in_6, bus_mux_in_7, bus_mux_in_8, bus_mux_in_9, bus_mux_in_10, bus_mux_in_11, bus_mux_in_12, bus_mux_in_13, bus_mux_in_14, bus_mux_in_15, bus_mux_in_HI, bus_mux_in_LO, bus_mux_in_Z_high, bus_mux_in_Z_low, bus_mux_in_PC, bus_mux_in_MDR, bus_mux_in_InPort, bus_mux_in_C_sign_extended : std_logic_vector(31 downto 0);
bus_mux_out: std_logic_vector(31 downto 0);

component mux32_1 is
	port( 
		signal sel : in std_logic_vector(4 downto 0);
			-- maps to the "in" signals from CpuBus, which is the data output from all the registers (expect for MAR)
		signal bus_mux_in_0, bus_mux_in_1, bus_mux_in_2, bus_mux_in_3, bus_mux_in_4, bus_mux_in_5, bus_mux_in_6, bus_mux_in_7, bus_mux_in_8, bus_mux_in_9, bus_mux_in_10, bus_mux_in_11, bus_mux_in_12, bus_mux_in_13, bus_mux_in_14, bus_mux_in_15, bus_mux_in_HI, bus_mux_in_LO, bus_mux_in_Z_high, bus_mux_in_Z_low, bus_mux_in_PC, bus_mux_in_MDR, bus_mux_in_InPort, bus_mux_in_C_sign_extended : in std_logic_vector(31 downto 0);
			-- the actual 'bus' data
		bus_mux_out: out std_logic_vector(31 downto 0)
	);
end component;

begin

end behavior;