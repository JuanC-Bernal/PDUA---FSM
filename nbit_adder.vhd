-----------adder.vhd (component)-----------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------------
ENTITY nbit_adder IS

	generic(N	:	INTEGER	:=		8);
	PORT
		(
			a		:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			b		:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			cin	:	IN		STD_LOGIC;

			s		:	OUT	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			cout	:	OUT	STD_LOGIC
		);

END ENTITY nbit_adder;
----------------------------------------------
ARCHITECTURE rtl OF nbit_adder IS

		SIGNAL	carry : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

	begin

		adder: FOR i IN N-1 DOWNTO 0 GENERATE

			bit0: IF i=0	GENERATE
							b0: ENTITY work.full_adder PORT MAP (a(i), b(i), cin, s(i), carry(i));
					END GENERATE;

			bitn: IF i/=0	GENERATE
							bn: ENTITY work.full_adder PORT MAP (a(i), b(i), carry(i-1), s(i), carry(i));
					END GENERATE;

		END GENERATE;

		cout <= carry(carry'LEFT);

END ARCHITECTURE;