------alu.vhd (component):-------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------
entity alu is

	generic (max_width	:	integer	:=8);
	port(
			clk		:	IN		std_logic;
			rst		:	IN		std_logic;
			busA		:	IN		std_logic_vector(max_width-1 downto 0);
			busB		:	IN		std_logic_vector(max_width-1 downto 0);
			selop		:	IN		std_logic_vector(2 downto 0);
			shamt		:	IN		std_logic_vector(1 downto 0);
			enaf		:	IN		std_logic;

			busC			:	OUT	std_logic_vector(max_width-1 downto 0);
			C,Nneg,Z,P	:	OUT	std_logic
		);--flags

END ENTITY alu;
ARCHITECTURE functional OF alu IS 

	SIGNAL cout 	:	STD_LOGIC;
	SIGNAL result  :	std_logic_vector(max_width - 1 downto 0);
	SIGNAL flop  	: std_logic_vector(max_width - 1 downto 0);
BEGIN
	
			procUnit: ENTITY work.processing_unit
		GENERIC MAP(N		=>		max_width)
		PORT MAP(	dataa		=>		busA,
						datab		=>		busB,
						selop		=>		selop,
						cout		=>		cout,
						result	=>		result
					);

			flagReg: ENTITY work.flag_register
		GENERIC MAP(N		=>		max_width)
		PORT MAP(
						carry		=>		cout,
						clk		=>		clk,
						dataa	=>		result,
						enaf		=>		enaf,
						rst	=>		rst,
						C		=> C,
						Nneg 	=> Nneg,
						P		=> P,
						Z 		=> Z
					);
					
			shiftUnit: ENTITY work.shif_unit
		GENERIC MAP(N		=>		max_width)
		PORT MAP(
						dataa		=>		result,
						shamt		=>		shamt,
						dataout	=>		busC
					);
					
--			flipFlop: ENTITY work.my_resDFF
--		GENERIC MAP(max_width		=>		max_width)
--		PORT MAP(
--						rst	=>		rst,
--						clk	=>		clk,
--						ena  	=> 	'1',
--						d		=>		flop,
--						q		=>		busC
--				);
END ARCHITECTURE;