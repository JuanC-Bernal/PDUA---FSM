-----------add_sub.vhd (component)-----------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------
ENTITY add_sub IS

	GENERIC(N	:	INTEGER	:=		8);
	port
		(
			a			:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			b			:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			addn_sub	:	IN 	STD_LOGIC;
			s			:	OUT	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			cout		:	OUT	STD_LOGIC
		);

END ENTITY;
------------------------------------------------------
architecture rtl of add_sub IS

		SIGNAL	bxor					:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		SIGNAL	add_nsub_vector	:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);

	BEGIN

		-- create a vector wiht the value of addn_sub input
		vector_generation : FOR i IN N-1 DOWNTO 0 GENERATE
			add_nsub_vector(i) <= addn_sub;
		END GENERATE;

		bxor <= b xor add_nsub_vector;

		-- adder instatiation
		adder: ENTITY work.nbit_adder
		GENERIC MAP(N		=>		N)
		PORT MAP(
						a		=>		a,
						b		=>		bxor,
						cin	=>		addn_sub,
						s		=>		s,
						cout	=>		cout
					);

END architecture;



