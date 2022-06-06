LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY decoder IS 
	PORT	(		en							: 	IN 	STD_LOGIC;
					DATA_IN					:	IN	   STD_LOGIC_VECTOR(4 DOWNTO 0);
					DATA_OUT					: 	OUT 	STD_LOGIC_VECTOR(24 DOWNTO 0));
END ENTITY decoder;
-------------------------------------------------------------------------
ARCHITECTURE one_hot OF decoder IS 
BEGIN 
	-- 20 instructions
	WITH	DATA_IN SELECT 
		DATA_OUT <= "0000000000000000000000000" WHEN "00000", -- fetch
						"0000000000000000000000001" WHEN "00001", -- mov acc,a
						"0000000000000000000000010" WHEN "00010", -- mov a, acc
						"0000000000000000000000100" WHEN "00011", -- mov acc, cte
						"0000000000000000000001000" WHEN "00100", -- mov acc [dptr]
						"0000000000000000000010000" WHEN "00101", -- mov dptr acc 
						"0000000000000000000100000" WHEN "00110", -- mov [dptr] acc
						"0000000000000000001000000" WHEN "00111", -- inv acc
						"0000000000000000010000000" WHEN "01000", -- and acc a
						"0000000000000000100000000" WHEN "01001", -- add acc a
						"0000000000000001000000000" WHEN "01010", -- jmp dir
						"0000000000000010000000000" WHEN "01011", -- jz dir
						"0000000000000100000000000" WHEN "01100", -- jn dir
						"0000000000001000000000000" WHEN "01101", -- jc dir
						"0000000000010000000000000" WHEN "10000", -- or acc
						"0000000000100000000000000" WHEN "10001", -- sll acc
						"0000000001000000000000000" WHEN "10010", -- slr acc	
						"0000000010000000000000000" WHEN "11100", -- halt 
						"0000000010000000000000000" WHEN OTHERS;
		

END ARCHITECTURE;