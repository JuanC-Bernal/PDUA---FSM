LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY processing_unit_tb IS
END ENTITY processing_unit_tb;
-------------------------------------
ARCHITECTURE testbench OF processing_unit_tb IS
	SIGNAL dataa 	: STD_LOGIC_VECTOR(8-1 DOWNTO 0);
	SIGNAL datab		: STD_LOGIC_VECTOR(8-1 DOWNTO 0);
	SIGNAL selop		: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL result 	:  STD_LOGIC_VECTOR(8-1 DOWNTO 0);
	SIGNAL cout 		:  STD_LOGIC;
	SIGNAL clk: STD_LOGIC := '0';
BEGIN 
--Clock generation 
clk <= not clk after 2ns; --50 mHz 

--input signal generation 
--signal_generation: PROCESS 
--BEGIN 
--Test vector 
	dataa <= "00000101";
	datab <= "00000010";
	selop <="000" after 0ns,
				"001" after 20ns,
				"010" after 40ns,
				"011" after 60ns, 
				"100" after 80ns,
				"101" after 100ns,
				"110" after 120ns,
				"111" after 140ns;
				
	--END PROCESS signal_generation;
	
DUT: ENTITY work.processing_unit
--GENERIC MAP (N => "8")
PORT MAP(
	dataa => dataa,
	datab => datab,
	selop => selop,
	result => result,
	cout => cout);
	
END ARCHITECTURE testbench;