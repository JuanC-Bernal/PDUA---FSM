LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY shif_unit_tb IS
END ENTITY shif_unit_tb;
-------------------------------------
ARCHITECTURE testbench OF shif_unit_tb IS
		SIGNAL	shamt		:	std_logic_vector(1 downto 0);
		SIGNAL	dataa		:	std_logic_vector(8-1 downto 0);
		SIGNAL	dataout	:	std_logic_vector(8-1 downto 0);
		
BEGIN
--input signal generation 
	dataa <= "10000101";

	shamt <= "00" after 0ns,
				"01" after 20ns,
				"10" after 40ns;
				
	DUT: ENTITY work.shif_unit
--GENERIC MAP (N => "8")
PORT MAP(
	dataa => dataa,
	shamt => shamt,
	dataout => dataout);

END ARCHITECTURE testbench;