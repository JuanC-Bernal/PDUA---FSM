------------------processing_unit.vhd--------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-------------------------------------
ENTITY processing_unit IS 
	GENERIC (N			:	INTEGER :=8);
	PORT(		dataa 	: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				datab		: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				selop		: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				result 	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				cout 		: OUT STD_LOGIC);
END ENTITY processing_unit;
--------------------------------------------------------
ARCHITECTURE rtl OF processing_unit IS 
CONSTANT ONE 			: STD_LOGIC_VECTOR(N-1 DOWNTO 0):= std_logic_vector(to_unsigned(1,N));
CONSTANT ZEROS			: STD_LOGIC_VECTOR(N-1 DOWNTO 0):= (OTHERS => '0');

SIGNAL not_b			:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL a_and_b			:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL a_or_b			:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL a_xor_b			:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL a_plus_b		:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL b_plus_one		:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL neg_b			:STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL c_sel			:STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL c_add, c_plus1, c_negB : STD_LOGIC;

BEGIN
	---===========================
	--		ALU Operations
	--============================
	not_b		<=NOT(datab);
	a_and_b	<=dataa AND datab;
	a_or_b	<=dataa OR datab;
	a_xor_b 	<=dataa XOR datab;
	
	AplusB: ENTITY work.add_sub
	GENERIC MAP(N			=>N)
	PORT MAP(	a			=>dataa,
					b			=>datab,
					addn_sub	=>'0',
					s			=>a_plus_b,
					cout		=>c_add);
	
	Bplus1: ENTITY work.add_sub
	GENERIC MAP(N			=>N)
	PORT MAP(	a			=>datab,
					b			=>ONE,
					addn_sub	=>'0',
					s			=>b_plus_one,
					cout		=>c_plus1);
	
	negB: ENTITY work.add_sub
	GENERIC MAP(N => N)
	PORT MAP(	a			=>ZEROS,
					b			=>datab,
					addn_sub	=>'1',
					s			=>neg_b,
					cout		=>c_negB);
	---===========================
	--		Output Multiplexers
	--============================
	-- Result Mux
	WITH selop SELECT 
		result 	<= datab 		when "000",
						not_b 		when "001",
						a_and_b 		when "010",
						a_or_b 		when "011",
						a_xor_b 		when "100",
						a_plus_b 	when "101",
						b_plus_one 	when "110",
						neg_b			when OTHERS;
						
	-- Carry Mux 
	c_sel	<= selop(1 DOWNTO 0);
	WITH c_sel SELECT 
		cout		<= c_add 	WHEN "01",
						c_plus1 	WHEN "10",
						c_negB 	WHEN "11",
						'0'		WHEN OTHERS;
END ARCHITECTURE;