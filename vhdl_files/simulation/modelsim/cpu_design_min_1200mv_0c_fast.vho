-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"

-- DATE "01/30/2023 17:00:56"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	cpu_design IS
    PORT (
	reg_out : OUT std_logic_vector(31 DOWNTO 0);
	clk : IN std_logic;
	clear : IN std_logic;
	writeEnable : IN std_logic;
	reg_input : IN std_logic_vector(31 DOWNTO 0)
	);
END cpu_design;

-- Design Ports Information
-- reg_out[31]	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[30]	=>  Location: PIN_W15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[29]	=>  Location: PIN_V22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[28]	=>  Location: PIN_U12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[27]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[26]	=>  Location: PIN_AA16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[25]	=>  Location: PIN_W14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[24]	=>  Location: PIN_L15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[23]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[22]	=>  Location: PIN_V12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[21]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[20]	=>  Location: PIN_AB7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[19]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[18]	=>  Location: PIN_V13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[17]	=>  Location: PIN_R13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[16]	=>  Location: PIN_N15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[15]	=>  Location: PIN_P21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[14]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[13]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[12]	=>  Location: PIN_AA18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[11]	=>  Location: PIN_U22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[10]	=>  Location: PIN_AB16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[9]	=>  Location: PIN_N22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[8]	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[7]	=>  Location: PIN_K19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[6]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[5]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[4]	=>  Location: PIN_P20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[3]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[2]	=>  Location: PIN_AB19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[1]	=>  Location: PIN_R18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_out[0]	=>  Location: PIN_V14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeEnable	=>  Location: PIN_G22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[31]	=>  Location: PIN_G21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_G2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clear	=>  Location: PIN_AA20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[30]	=>  Location: PIN_V15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[29]	=>  Location: PIN_M19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[28]	=>  Location: PIN_T14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[27]	=>  Location: PIN_N17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[26]	=>  Location: PIN_U14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[25]	=>  Location: PIN_AB18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[24]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[23]	=>  Location: PIN_U21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[22]	=>  Location: PIN_T16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[21]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[20]	=>  Location: PIN_AA19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[19]	=>  Location: PIN_R20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[18]	=>  Location: PIN_U13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[17]	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[16]	=>  Location: PIN_V21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[15]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[14]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[13]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[12]	=>  Location: PIN_AA17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[11]	=>  Location: PIN_M15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[10]	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[9]	=>  Location: PIN_R19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[8]	=>  Location: PIN_H22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[7]	=>  Location: PIN_L16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[6]	=>  Location: PIN_AB17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[5]	=>  Location: PIN_N18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[4]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[3]	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[2]	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[1]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reg_input[0]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF cpu_design IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_reg_out : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_clk : std_logic;
SIGNAL ww_clear : std_logic;
SIGNAL ww_writeEnable : std_logic;
SIGNAL ww_reg_input : std_logic_vector(31 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \reg_input[31]~input_o\ : std_logic;
SIGNAL \reg_input[27]~input_o\ : std_logic;
SIGNAL \reg_input[21]~input_o\ : std_logic;
SIGNAL \reg_input[4]~input_o\ : std_logic;
SIGNAL \reg_input[3]~input_o\ : std_logic;
SIGNAL \reg_input[2]~input_o\ : std_logic;
SIGNAL \reg_out[31]~output_o\ : std_logic;
SIGNAL \reg_out[30]~output_o\ : std_logic;
SIGNAL \reg_out[29]~output_o\ : std_logic;
SIGNAL \reg_out[28]~output_o\ : std_logic;
SIGNAL \reg_out[27]~output_o\ : std_logic;
SIGNAL \reg_out[26]~output_o\ : std_logic;
SIGNAL \reg_out[25]~output_o\ : std_logic;
SIGNAL \reg_out[24]~output_o\ : std_logic;
SIGNAL \reg_out[23]~output_o\ : std_logic;
SIGNAL \reg_out[22]~output_o\ : std_logic;
SIGNAL \reg_out[21]~output_o\ : std_logic;
SIGNAL \reg_out[20]~output_o\ : std_logic;
SIGNAL \reg_out[19]~output_o\ : std_logic;
SIGNAL \reg_out[18]~output_o\ : std_logic;
SIGNAL \reg_out[17]~output_o\ : std_logic;
SIGNAL \reg_out[16]~output_o\ : std_logic;
SIGNAL \reg_out[15]~output_o\ : std_logic;
SIGNAL \reg_out[14]~output_o\ : std_logic;
SIGNAL \reg_out[13]~output_o\ : std_logic;
SIGNAL \reg_out[12]~output_o\ : std_logic;
SIGNAL \reg_out[11]~output_o\ : std_logic;
SIGNAL \reg_out[10]~output_o\ : std_logic;
SIGNAL \reg_out[9]~output_o\ : std_logic;
SIGNAL \reg_out[8]~output_o\ : std_logic;
SIGNAL \reg_out[7]~output_o\ : std_logic;
SIGNAL \reg_out[6]~output_o\ : std_logic;
SIGNAL \reg_out[5]~output_o\ : std_logic;
SIGNAL \reg_out[4]~output_o\ : std_logic;
SIGNAL \reg_out[3]~output_o\ : std_logic;
SIGNAL \reg_out[2]~output_o\ : std_logic;
SIGNAL \reg_out[1]~output_o\ : std_logic;
SIGNAL \reg_out[0]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \writeEnable~input_o\ : std_logic;
SIGNAL \inst|reg_out~0_combout\ : std_logic;
SIGNAL \clear~input_o\ : std_logic;
SIGNAL \inst|reg_out[31]~1_combout\ : std_logic;
SIGNAL \reg_input[30]~input_o\ : std_logic;
SIGNAL \inst|reg_out~2_combout\ : std_logic;
SIGNAL \reg_input[29]~input_o\ : std_logic;
SIGNAL \inst|reg_out~3_combout\ : std_logic;
SIGNAL \reg_input[28]~input_o\ : std_logic;
SIGNAL \inst|reg_out~4_combout\ : std_logic;
SIGNAL \inst|reg_out~5_combout\ : std_logic;
SIGNAL \reg_input[26]~input_o\ : std_logic;
SIGNAL \inst|reg_out~6_combout\ : std_logic;
SIGNAL \reg_input[25]~input_o\ : std_logic;
SIGNAL \inst|reg_out~7_combout\ : std_logic;
SIGNAL \reg_input[24]~input_o\ : std_logic;
SIGNAL \inst|reg_out~8_combout\ : std_logic;
SIGNAL \reg_input[23]~input_o\ : std_logic;
SIGNAL \inst|reg_out~9_combout\ : std_logic;
SIGNAL \reg_input[22]~input_o\ : std_logic;
SIGNAL \inst|reg_out~10_combout\ : std_logic;
SIGNAL \inst|reg_out~11_combout\ : std_logic;
SIGNAL \reg_input[20]~input_o\ : std_logic;
SIGNAL \inst|reg_out~12_combout\ : std_logic;
SIGNAL \reg_input[19]~input_o\ : std_logic;
SIGNAL \inst|reg_out~13_combout\ : std_logic;
SIGNAL \reg_input[18]~input_o\ : std_logic;
SIGNAL \inst|reg_out~14_combout\ : std_logic;
SIGNAL \reg_input[17]~input_o\ : std_logic;
SIGNAL \inst|reg_out~15_combout\ : std_logic;
SIGNAL \reg_input[16]~input_o\ : std_logic;
SIGNAL \inst|reg_out~16_combout\ : std_logic;
SIGNAL \reg_input[15]~input_o\ : std_logic;
SIGNAL \inst|reg_out~17_combout\ : std_logic;
SIGNAL \reg_input[14]~input_o\ : std_logic;
SIGNAL \inst|reg_out~18_combout\ : std_logic;
SIGNAL \reg_input[13]~input_o\ : std_logic;
SIGNAL \inst|reg_out~19_combout\ : std_logic;
SIGNAL \reg_input[12]~input_o\ : std_logic;
SIGNAL \inst|reg_out~20_combout\ : std_logic;
SIGNAL \reg_input[11]~input_o\ : std_logic;
SIGNAL \inst|reg_out~21_combout\ : std_logic;
SIGNAL \reg_input[10]~input_o\ : std_logic;
SIGNAL \inst|reg_out~22_combout\ : std_logic;
SIGNAL \reg_input[9]~input_o\ : std_logic;
SIGNAL \inst|reg_out~23_combout\ : std_logic;
SIGNAL \reg_input[8]~input_o\ : std_logic;
SIGNAL \inst|reg_out~24_combout\ : std_logic;
SIGNAL \reg_input[7]~input_o\ : std_logic;
SIGNAL \inst|reg_out~25_combout\ : std_logic;
SIGNAL \reg_input[6]~input_o\ : std_logic;
SIGNAL \inst|reg_out~26_combout\ : std_logic;
SIGNAL \reg_input[5]~input_o\ : std_logic;
SIGNAL \inst|reg_out~27_combout\ : std_logic;
SIGNAL \inst|reg_out~28_combout\ : std_logic;
SIGNAL \inst|reg_out~29_combout\ : std_logic;
SIGNAL \inst|reg_out~30_combout\ : std_logic;
SIGNAL \reg_input[1]~input_o\ : std_logic;
SIGNAL \inst|reg_out~31_combout\ : std_logic;
SIGNAL \reg_input[0]~input_o\ : std_logic;
SIGNAL \inst|reg_out~32_combout\ : std_logic;
SIGNAL \inst|reg_out\ : std_logic_vector(31 DOWNTO 0);

BEGIN

reg_out <= ww_reg_out;
ww_clk <= clk;
ww_clear <= clear;
ww_writeEnable <= writeEnable;
ww_reg_input <= reg_input;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

-- Location: IOIBUF_X41_Y15_N1
\reg_input[31]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(31),
	o => \reg_input[31]~input_o\);

-- Location: IOIBUF_X41_Y12_N1
\reg_input[27]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(27),
	o => \reg_input[27]~input_o\);

-- Location: IOIBUF_X41_Y13_N8
\reg_input[21]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(21),
	o => \reg_input[21]~input_o\);

-- Location: IOIBUF_X41_Y14_N15
\reg_input[4]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(4),
	o => \reg_input[4]~input_o\);

-- Location: IOIBUF_X32_Y0_N8
\reg_input[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(3),
	o => \reg_input[3]~input_o\);

-- Location: IOIBUF_X26_Y0_N15
\reg_input[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(2),
	o => \reg_input[2]~input_o\);

-- Location: IOOBUF_X41_Y2_N2
\reg_out[31]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(31),
	devoe => ww_devoe,
	o => \reg_out[31]~output_o\);

-- Location: IOOBUF_X32_Y0_N23
\reg_out[30]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(30),
	devoe => ww_devoe,
	o => \reg_out[30]~output_o\);

-- Location: IOOBUF_X41_Y7_N2
\reg_out[29]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(29),
	devoe => ww_devoe,
	o => \reg_out[29]~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\reg_out[28]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(28),
	devoe => ww_devoe,
	o => \reg_out[28]~output_o\);

-- Location: IOOBUF_X41_Y13_N2
\reg_out[27]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(27),
	devoe => ww_devoe,
	o => \reg_out[27]~output_o\);

-- Location: IOOBUF_X28_Y0_N23
\reg_out[26]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(26),
	devoe => ww_devoe,
	o => \reg_out[26]~output_o\);

-- Location: IOOBUF_X30_Y0_N16
\reg_out[25]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(25),
	devoe => ww_devoe,
	o => \reg_out[25]~output_o\);

-- Location: IOOBUF_X41_Y17_N2
\reg_out[24]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(24),
	devoe => ww_devoe,
	o => \reg_out[24]~output_o\);

-- Location: IOOBUF_X41_Y18_N23
\reg_out[23]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(23),
	devoe => ww_devoe,
	o => \reg_out[23]~output_o\);

-- Location: IOOBUF_X23_Y0_N2
\reg_out[22]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(22),
	devoe => ww_devoe,
	o => \reg_out[22]~output_o\);

-- Location: IOOBUF_X41_Y12_N16
\reg_out[21]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(21),
	devoe => ww_devoe,
	o => \reg_out[21]~output_o\);

-- Location: IOOBUF_X11_Y0_N9
\reg_out[20]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(20),
	devoe => ww_devoe,
	o => \reg_out[20]~output_o\);

-- Location: IOOBUF_X41_Y10_N9
\reg_out[19]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(19),
	devoe => ww_devoe,
	o => \reg_out[19]~output_o\);

-- Location: IOOBUF_X30_Y0_N23
\reg_out[18]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(18),
	devoe => ww_devoe,
	o => \reg_out[18]~output_o\);

-- Location: IOOBUF_X30_Y0_N30
\reg_out[17]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(17),
	devoe => ww_devoe,
	o => \reg_out[17]~output_o\);

-- Location: IOOBUF_X41_Y7_N16
\reg_out[16]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(16),
	devoe => ww_devoe,
	o => \reg_out[16]~output_o\);

-- Location: IOOBUF_X41_Y12_N23
\reg_out[15]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(15),
	devoe => ww_devoe,
	o => \reg_out[15]~output_o\);

-- Location: IOOBUF_X41_Y7_N9
\reg_out[14]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(14),
	devoe => ww_devoe,
	o => \reg_out[14]~output_o\);

-- Location: IOOBUF_X41_Y12_N9
\reg_out[13]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(13),
	devoe => ww_devoe,
	o => \reg_out[13]~output_o\);

-- Location: IOOBUF_X35_Y0_N30
\reg_out[12]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(12),
	devoe => ww_devoe,
	o => \reg_out[12]~output_o\);

-- Location: IOOBUF_X41_Y8_N9
\reg_out[11]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(11),
	devoe => ww_devoe,
	o => \reg_out[11]~output_o\);

-- Location: IOOBUF_X28_Y0_N16
\reg_out[10]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(10),
	devoe => ww_devoe,
	o => \reg_out[10]~output_o\);

-- Location: IOOBUF_X41_Y13_N16
\reg_out[9]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(9),
	devoe => ww_devoe,
	o => \reg_out[9]~output_o\);

-- Location: IOOBUF_X41_Y14_N2
\reg_out[8]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(8),
	devoe => ww_devoe,
	o => \reg_out[8]~output_o\);

-- Location: IOOBUF_X41_Y18_N2
\reg_out[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(7),
	devoe => ww_devoe,
	o => \reg_out[7]~output_o\);

-- Location: IOOBUF_X35_Y0_N9
\reg_out[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(6),
	devoe => ww_devoe,
	o => \reg_out[6]~output_o\);

-- Location: IOOBUF_X41_Y6_N16
\reg_out[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(5),
	devoe => ww_devoe,
	o => \reg_out[5]~output_o\);

-- Location: IOOBUF_X41_Y10_N2
\reg_out[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(4),
	devoe => ww_devoe,
	o => \reg_out[4]~output_o\);

-- Location: IOOBUF_X37_Y0_N2
\reg_out[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(3),
	devoe => ww_devoe,
	o => \reg_out[3]~output_o\);

-- Location: IOOBUF_X35_Y0_N16
\reg_out[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(2),
	devoe => ww_devoe,
	o => \reg_out[2]~output_o\);

-- Location: IOOBUF_X41_Y9_N23
\reg_out[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(1),
	devoe => ww_devoe,
	o => \reg_out[1]~output_o\);

-- Location: IOOBUF_X30_Y0_N2
\reg_out[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|reg_out\(0),
	devoe => ww_devoe,
	o => \reg_out[0]~output_o\);

-- Location: IOIBUF_X0_Y14_N1
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G4
\clk~inputclkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X41_Y15_N8
\writeEnable~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_writeEnable,
	o => \writeEnable~input_o\);

-- Location: LCCOMB_X32_Y1_N8
\inst|reg_out~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~0_combout\ = (\reg_input[31]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reg_input[31]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~0_combout\);

-- Location: IOIBUF_X37_Y0_N22
\clear~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clear,
	o => \clear~input_o\);

-- Location: LCCOMB_X32_Y1_N6
\inst|reg_out[31]~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out[31]~1_combout\ = (\clear~input_o\) # (\writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \clear~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out[31]~1_combout\);

-- Location: FF_X32_Y1_N9
\inst|reg_out[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~0_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(31));

-- Location: IOIBUF_X32_Y0_N29
\reg_input[30]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(30),
	o => \reg_input[30]~input_o\);

-- Location: LCCOMB_X32_Y1_N26
\inst|reg_out~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~2_combout\ = (\writeEnable~input_o\ & \reg_input[30]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[30]~input_o\,
	combout => \inst|reg_out~2_combout\);

-- Location: FF_X32_Y1_N27
\inst|reg_out[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~2_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(30));

-- Location: IOIBUF_X41_Y14_N8
\reg_input[29]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(29),
	o => \reg_input[29]~input_o\);

-- Location: LCCOMB_X40_Y13_N8
\inst|reg_out~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~3_combout\ = (\writeEnable~input_o\ & \reg_input[29]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \writeEnable~input_o\,
	datac => \reg_input[29]~input_o\,
	combout => \inst|reg_out~3_combout\);

-- Location: FF_X40_Y13_N9
\inst|reg_out[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~3_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(29));

-- Location: IOIBUF_X32_Y0_N15
\reg_input[28]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(28),
	o => \reg_input[28]~input_o\);

-- Location: LCCOMB_X32_Y1_N20
\inst|reg_out~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~4_combout\ = (\writeEnable~input_o\ & \reg_input[28]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[28]~input_o\,
	combout => \inst|reg_out~4_combout\);

-- Location: FF_X32_Y1_N21
\inst|reg_out[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~4_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(28));

-- Location: LCCOMB_X40_Y13_N10
\inst|reg_out~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~5_combout\ = (\reg_input[27]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reg_input[27]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~5_combout\);

-- Location: FF_X40_Y13_N11
\inst|reg_out[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~5_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(27));

-- Location: IOIBUF_X39_Y0_N22
\reg_input[26]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(26),
	o => \reg_input[26]~input_o\);

-- Location: LCCOMB_X32_Y1_N14
\inst|reg_out~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~6_combout\ = (\writeEnable~input_o\ & \reg_input[26]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[26]~input_o\,
	combout => \inst|reg_out~6_combout\);

-- Location: FF_X32_Y1_N15
\inst|reg_out[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~6_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(26));

-- Location: IOIBUF_X32_Y0_N1
\reg_input[25]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(25),
	o => \reg_input[25]~input_o\);

-- Location: LCCOMB_X32_Y1_N24
\inst|reg_out~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~7_combout\ = (\reg_input[25]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[25]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~7_combout\);

-- Location: FF_X32_Y1_N25
\inst|reg_out[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~7_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(25));

-- Location: IOIBUF_X41_Y11_N1
\reg_input[24]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(24),
	o => \reg_input[24]~input_o\);

-- Location: LCCOMB_X40_Y13_N4
\inst|reg_out~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~8_combout\ = (\writeEnable~input_o\ & \reg_input[24]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[24]~input_o\,
	combout => \inst|reg_out~8_combout\);

-- Location: FF_X40_Y13_N5
\inst|reg_out[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~8_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(24));

-- Location: IOIBUF_X41_Y8_N1
\reg_input[23]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(23),
	o => \reg_input[23]~input_o\);

-- Location: LCCOMB_X40_Y13_N22
\inst|reg_out~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~9_combout\ = (\writeEnable~input_o\ & \reg_input[23]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \writeEnable~input_o\,
	datac => \reg_input[23]~input_o\,
	combout => \inst|reg_out~9_combout\);

-- Location: FF_X40_Y13_N23
\inst|reg_out[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~9_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(23));

-- Location: IOIBUF_X37_Y0_N8
\reg_input[22]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(22),
	o => \reg_input[22]~input_o\);

-- Location: LCCOMB_X32_Y1_N18
\inst|reg_out~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~10_combout\ = (\reg_input[22]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[22]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~10_combout\);

-- Location: FF_X32_Y1_N19
\inst|reg_out[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~10_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(22));

-- Location: LCCOMB_X40_Y13_N24
\inst|reg_out~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~11_combout\ = (\reg_input[21]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reg_input[21]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~11_combout\);

-- Location: FF_X40_Y13_N25
\inst|reg_out[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~11_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(21));

-- Location: IOIBUF_X35_Y0_N22
\reg_input[20]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(20),
	o => \reg_input[20]~input_o\);

-- Location: LCCOMB_X32_Y1_N4
\inst|reg_out~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~12_combout\ = (\reg_input[20]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[20]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~12_combout\);

-- Location: FF_X32_Y1_N5
\inst|reg_out[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~12_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(20));

-- Location: IOIBUF_X41_Y8_N15
\reg_input[19]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(19),
	o => \reg_input[19]~input_o\);

-- Location: LCCOMB_X40_Y13_N2
\inst|reg_out~13\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~13_combout\ = (\writeEnable~input_o\ & \reg_input[19]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[19]~input_o\,
	combout => \inst|reg_out~13_combout\);

-- Location: FF_X40_Y13_N3
\inst|reg_out[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~13_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(19));

-- Location: IOIBUF_X30_Y0_N8
\reg_input[18]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(18),
	o => \reg_input[18]~input_o\);

-- Location: LCCOMB_X32_Y1_N22
\inst|reg_out~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~14_combout\ = (\writeEnable~input_o\ & \reg_input[18]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[18]~input_o\,
	combout => \inst|reg_out~14_combout\);

-- Location: FF_X32_Y1_N23
\inst|reg_out[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~14_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(18));

-- Location: IOIBUF_X28_Y0_N29
\reg_input[17]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(17),
	o => \reg_input[17]~input_o\);

-- Location: LCCOMB_X32_Y1_N16
\inst|reg_out~15\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~15_combout\ = (\writeEnable~input_o\ & \reg_input[17]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[17]~input_o\,
	combout => \inst|reg_out~15_combout\);

-- Location: FF_X32_Y1_N17
\inst|reg_out[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~15_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(17));

-- Location: IOIBUF_X41_Y8_N22
\reg_input[16]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(16),
	o => \reg_input[16]~input_o\);

-- Location: LCCOMB_X40_Y13_N12
\inst|reg_out~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~16_combout\ = (\reg_input[16]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[16]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~16_combout\);

-- Location: FF_X40_Y13_N13
\inst|reg_out[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~16_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(16));

-- Location: IOIBUF_X41_Y18_N8
\reg_input[15]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(15),
	o => \reg_input[15]~input_o\);

-- Location: LCCOMB_X40_Y13_N30
\inst|reg_out~17\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~17_combout\ = (\writeEnable~input_o\ & \reg_input[15]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[15]~input_o\,
	combout => \inst|reg_out~17_combout\);

-- Location: FF_X40_Y13_N31
\inst|reg_out[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~17_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(15));

-- Location: IOIBUF_X41_Y14_N22
\reg_input[14]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(14),
	o => \reg_input[14]~input_o\);

-- Location: LCCOMB_X40_Y13_N16
\inst|reg_out~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~18_combout\ = (\writeEnable~input_o\ & \reg_input[14]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \writeEnable~input_o\,
	datac => \reg_input[14]~input_o\,
	combout => \inst|reg_out~18_combout\);

-- Location: FF_X40_Y13_N17
\inst|reg_out[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~18_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(14));

-- Location: IOIBUF_X41_Y10_N15
\reg_input[13]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(13),
	o => \reg_input[13]~input_o\);

-- Location: LCCOMB_X40_Y13_N26
\inst|reg_out~19\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~19_combout\ = (\reg_input[13]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[13]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~19_combout\);

-- Location: FF_X40_Y13_N27
\inst|reg_out[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~19_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(13));

-- Location: IOIBUF_X28_Y0_N8
\reg_input[12]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(12),
	o => \reg_input[12]~input_o\);

-- Location: LCCOMB_X32_Y1_N2
\inst|reg_out~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~20_combout\ = (\writeEnable~input_o\ & \reg_input[12]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[12]~input_o\,
	combout => \inst|reg_out~20_combout\);

-- Location: FF_X32_Y1_N3
\inst|reg_out[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~20_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(12));

-- Location: IOIBUF_X41_Y7_N22
\reg_input[11]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(11),
	o => \reg_input[11]~input_o\);

-- Location: LCCOMB_X40_Y13_N28
\inst|reg_out~21\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~21_combout\ = (\writeEnable~input_o\ & \reg_input[11]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \writeEnable~input_o\,
	datac => \reg_input[11]~input_o\,
	combout => \inst|reg_out~21_combout\);

-- Location: FF_X40_Y13_N29
\inst|reg_out[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~21_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(11));

-- Location: IOIBUF_X37_Y0_N29
\reg_input[10]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(10),
	o => \reg_input[10]~input_o\);

-- Location: LCCOMB_X32_Y1_N12
\inst|reg_out~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~22_combout\ = (\writeEnable~input_o\ & \reg_input[10]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[10]~input_o\,
	combout => \inst|reg_out~22_combout\);

-- Location: FF_X32_Y1_N13
\inst|reg_out[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~22_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(10));

-- Location: IOIBUF_X41_Y9_N15
\reg_input[9]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(9),
	o => \reg_input[9]~input_o\);

-- Location: LCCOMB_X40_Y13_N14
\inst|reg_out~23\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~23_combout\ = (\writeEnable~input_o\ & \reg_input[9]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \writeEnable~input_o\,
	datac => \reg_input[9]~input_o\,
	combout => \inst|reg_out~23_combout\);

-- Location: FF_X40_Y13_N15
\inst|reg_out[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~23_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(9));

-- Location: IOIBUF_X41_Y20_N1
\reg_input[8]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(8),
	o => \reg_input[8]~input_o\);

-- Location: LCCOMB_X40_Y14_N16
\inst|reg_out~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~24_combout\ = (\writeEnable~input_o\ & \reg_input[8]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[8]~input_o\,
	combout => \inst|reg_out~24_combout\);

-- Location: FF_X40_Y14_N17
\inst|reg_out[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~24_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(8));

-- Location: IOIBUF_X41_Y17_N8
\reg_input[7]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(7),
	o => \reg_input[7]~input_o\);

-- Location: LCCOMB_X40_Y13_N0
\inst|reg_out~25\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~25_combout\ = (\reg_input[7]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[7]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~25_combout\);

-- Location: FF_X40_Y13_N1
\inst|reg_out[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~25_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(7));

-- Location: IOIBUF_X28_Y0_N1
\reg_input[6]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(6),
	o => \reg_input[6]~input_o\);

-- Location: LCCOMB_X32_Y1_N30
\inst|reg_out~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~26_combout\ = (\writeEnable~input_o\ & \reg_input[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[6]~input_o\,
	combout => \inst|reg_out~26_combout\);

-- Location: FF_X32_Y1_N31
\inst|reg_out[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~26_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(6));

-- Location: IOIBUF_X41_Y13_N22
\reg_input[5]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(5),
	o => \reg_input[5]~input_o\);

-- Location: LCCOMB_X40_Y13_N18
\inst|reg_out~27\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~27_combout\ = (\reg_input[5]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[5]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~27_combout\);

-- Location: FF_X40_Y13_N19
\inst|reg_out[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~27_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(5));

-- Location: LCCOMB_X40_Y13_N20
\inst|reg_out~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~28_combout\ = (\reg_input[4]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reg_input[4]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~28_combout\);

-- Location: FF_X40_Y13_N21
\inst|reg_out[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~28_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(4));

-- Location: LCCOMB_X32_Y1_N0
\inst|reg_out~29\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~29_combout\ = (\reg_input[3]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reg_input[3]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~29_combout\);

-- Location: FF_X32_Y1_N1
\inst|reg_out[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~29_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(3));

-- Location: LCCOMB_X32_Y1_N10
\inst|reg_out~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~30_combout\ = (\reg_input[2]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reg_input[2]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~30_combout\);

-- Location: FF_X32_Y1_N11
\inst|reg_out[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~30_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(2));

-- Location: IOIBUF_X41_Y10_N22
\reg_input[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(1),
	o => \reg_input[1]~input_o\);

-- Location: LCCOMB_X40_Y13_N6
\inst|reg_out~31\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~31_combout\ = (\reg_input[1]~input_o\ & \writeEnable~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \reg_input[1]~input_o\,
	datac => \writeEnable~input_o\,
	combout => \inst|reg_out~31_combout\);

-- Location: FF_X40_Y13_N7
\inst|reg_out[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~31_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(1));

-- Location: IOIBUF_X26_Y0_N8
\reg_input[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reg_input(0),
	o => \reg_input[0]~input_o\);

-- Location: LCCOMB_X32_Y1_N28
\inst|reg_out~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|reg_out~32_combout\ = (\writeEnable~input_o\ & \reg_input[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \writeEnable~input_o\,
	datad => \reg_input[0]~input_o\,
	combout => \inst|reg_out~32_combout\);

-- Location: FF_X32_Y1_N29
\inst|reg_out[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst|reg_out~32_combout\,
	ena => \inst|reg_out[31]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|reg_out\(0));

ww_reg_out(31) <= \reg_out[31]~output_o\;

ww_reg_out(30) <= \reg_out[30]~output_o\;

ww_reg_out(29) <= \reg_out[29]~output_o\;

ww_reg_out(28) <= \reg_out[28]~output_o\;

ww_reg_out(27) <= \reg_out[27]~output_o\;

ww_reg_out(26) <= \reg_out[26]~output_o\;

ww_reg_out(25) <= \reg_out[25]~output_o\;

ww_reg_out(24) <= \reg_out[24]~output_o\;

ww_reg_out(23) <= \reg_out[23]~output_o\;

ww_reg_out(22) <= \reg_out[22]~output_o\;

ww_reg_out(21) <= \reg_out[21]~output_o\;

ww_reg_out(20) <= \reg_out[20]~output_o\;

ww_reg_out(19) <= \reg_out[19]~output_o\;

ww_reg_out(18) <= \reg_out[18]~output_o\;

ww_reg_out(17) <= \reg_out[17]~output_o\;

ww_reg_out(16) <= \reg_out[16]~output_o\;

ww_reg_out(15) <= \reg_out[15]~output_o\;

ww_reg_out(14) <= \reg_out[14]~output_o\;

ww_reg_out(13) <= \reg_out[13]~output_o\;

ww_reg_out(12) <= \reg_out[12]~output_o\;

ww_reg_out(11) <= \reg_out[11]~output_o\;

ww_reg_out(10) <= \reg_out[10]~output_o\;

ww_reg_out(9) <= \reg_out[9]~output_o\;

ww_reg_out(8) <= \reg_out[8]~output_o\;

ww_reg_out(7) <= \reg_out[7]~output_o\;

ww_reg_out(6) <= \reg_out[6]~output_o\;

ww_reg_out(5) <= \reg_out[5]~output_o\;

ww_reg_out(4) <= \reg_out[4]~output_o\;

ww_reg_out(3) <= \reg_out[3]~output_o\;

ww_reg_out(2) <= \reg_out[2]~output_o\;

ww_reg_out(1) <= \reg_out[1]~output_o\;

ww_reg_out(0) <= \reg_out[0]~output_o\;
END structure;


