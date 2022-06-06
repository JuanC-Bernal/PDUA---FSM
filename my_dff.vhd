LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------
ENTITY my_dff IS
	--GENERIC (N			:	INTEGER :=8);
	PORT(
			clk	:	IN		std_logic;
			rst	:	IN		std_logic;
			ena	:	IN		std_logic;
			d		:	IN		std_logic;--_vector(N-1 downto 0);
			q		:	OUT	std_logic--_vector(N-1 downto 0)
			);

END my_dff;
-----------------------------------------------
ARCHITECTURE rtl OF my_dff IS
--CONSTANT ZEROS			: STD_LOGIC_VECTOR(N-1 DOWNTO 0):= (OTHERS => '0');
--signal  ena : std_logic := '1';
	BEGIN

		dff: PROCESS(clk, rst, d)
			BEGIN
				IF(rst = '1') THEN
					q <= '0';
				ELSIF (rising_edge(clk)) THEN
					IF (ena ='1') THEN
						q <= d;
					END IF;
				END IF;
			END PROCESS;

END ARCHITECTURE;