library ieee;
use ieee.std_logic_1164.all;
----------------------------------
ENTITY mdr IS 
	GENERIC( MAX_WIDTH	: integer:=8);
	PORT(		clk			: IN STD_LOGIC;
				mdr_ena		: IN STD_LOGIC;
				mdr_alu_n	: IN STD_LOGIC; 
				DATA_EX_in	: IN STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0); 
				rst			: IN STD_LOGIC; 
				bus_alu		: IN STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				busC			: OUT STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				BUS_DATA_OUT: OUT STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0)
			);
END ENTITY;
ARCHITECTURE structural OF mdr IS 
SIGNAL data_q : STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
BEGIN 
WITH mdr_alu_n SELECT 
	busC <= bus_alu WHEN '0',
				data_q WHEN OTHERS;
				
	q1: entity work.my_resDFF
			GENERIC MAP (max_width => MAX_WIDTH)
			PORT MAP	(
							clk	=>		clk,
							rst	=>		rst,
							ena	=>		mdr_ena,
							d		=>		DATA_EX_in,
							q		=>		data_q
							);
							
	q2: entity work.my_resDFF
			GENERIC MAP (max_width => MAX_WIDTH)
			PORT MAP	(
							clk	=>		clk,
							rst	=>		rst,
							ena	=>		mdr_ena,
							d		=>		bus_alu,
							q		=>		bus_DATA_OUT
							);
			
END ARCHITECTURE;