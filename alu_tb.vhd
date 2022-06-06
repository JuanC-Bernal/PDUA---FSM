LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY alu_tb IS
END ENTITY alu_tb;
-------------------------------------
ARCHITECTURE testbench OF alu_tb IS
			SIGNAL clk		:std_logic := '0';
			SIGNAL rst		:std_logic :='1';
			SIGNAL busA		:	std_logic_vector(8-1 downto 0);
			SIGNAL busB		:	std_logic_vector(8-1 downto 0);
			SIGNAL selop		:	std_logic_vector(2 downto 0);
			SIGNAL shamt		:	std_logic_vector(1 downto 0);
			SIGNAL enaf		:	std_logic := '1';

			SIGNAL busC			:		std_logic_vector(8-1 downto 0);
			SIGNAL C,Nneg,Z,P	:	std_logic;
BEGIN 
--Clock generation 
clk <= not clk after 2ns; --50 mHz 

--input signal generation 
--signal_generation: PROCESS 
--BEGIN 
--Test vector 
	rst <= '0' after 10ns;
	busB <= "00000101";
	busA <= "00000111";
	selop <= "000" after 0ns,
				"001" after 41ns,
				"010" after 60ns,
				"011" after 80ns, 
				"100" after 100ns,
				"101" after 120ns,
				"110" after 160ns,
				"111" after 180ns;
	shamt <= "00" after 0ns,
				"01" after 10ns,
				"10" after 20ns,
				"00" after 30ns;
				--"01" after 130ns,
				--"10" after 140ns,
				--"00" after 150ns;
				
	--END PROCESS signal_generation;
	
DUT: ENTITY work.alu
--GENERIC MAP (N => "8")
PORT MAP(
	clk => clk,
	busA => busA,
	busB => busB,
	busC => busC,
	shamt => shamt,
	rst => rst,
	selop => selop,
	enaf => enaf,
	C => C,
	NNeg => Nneg,
	Z => Z,
	P => P);
	
END ARCHITECTURE testbench;