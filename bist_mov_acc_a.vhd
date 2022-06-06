LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY bist_mov_acc_a IS
	GENERIC(DATA_WIDTH : integer:= 8);
	PORT	(		clk					: 	IN 	STD_LOGIC;
					rst					:	IN		STD_LOGIC;
					strobe				: 	IN 	STD_LOGIC;
					--ready_data_path	: 	IN 	STD_LOGIC;
					bank_wr_ena			: OUT 	STD_LOGIC;
					busB_addr			: OUT 	STD_LOGIC_VECTOR(2 DOWNTO 0);
					busC_addr 			: OUT 	STD_LOGIC_VECTOR(2 DOWNTO 0);
					enaf					: OUT 	STD_LOGIC;
					selop					: OUT 	STD_LOGIC_VECTOR(2 DOWNTO 0);
					shamt					: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
					ir_ena				: OUT 	STD_LOGIC;
					mar_en				: OUT 	STD_LOGIC;
					mdr_en				: OUT 	STD_LOGIC;
					mdr_alu_n			: OUT 	STD_LOGIC;
					wr_rd_n				: OUT 	STD_LOGIC
					);					
END ENTITY bist_mov_acc_a;
-------------------------------------------------------------------------
ARCHITECTURE fsmd OF bist_mov_acc_a IS
	TYPE state IS (idle, state_0);
	SIGNAL 	pr_state	: 	state;
	SIGNAL 	nx_state	: 	state;
BEGIN
	--===========================================
	--              FSM
	--===========================================
	-- Sequential Section ----------------------
	PROCESS(clk, rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state <=idle;
		ELSIF(rising_edge(clk)) THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	
	-- Combinational Section ----------------------
	PROCESS (pr_state, strobe)
	BEGIN
		
		CASE pr_state IS
			---------------------------
			WHEN idle =>
				enaf				<= '0';
				selop				<= "000";
				shamt				<= "00";
				busB_addr		<= "000";
				busC_addr		<= "000";
				bank_wr_ena 	<= '0';
				mar_en			<= '0';
				mdr_en			<= '0';
				mdr_alu_n		<= '0';
				wr_rd_n			<= '0';
				ir_ena			<= '0';
				IF (strobe = '1') THEN
					nx_state	<= state_0;
				ELSE
					nx_state	<= idle;
				END IF;
			---------------------------
			WHEN state_0 => 

				enaf				<= '1';
				selop				<= "000"; --B
				shamt				<= "00"; -- no shift
				busB_addr		<= "011";
				busC_addr		<= "111";
				bank_wr_ena 	<= '1';--Write register bank
				mar_en			<= '0'; 
				mdr_en			<= '0';
				mdr_alu_n		<= '0';
				wr_rd_n			<= '0';--read memory
				ir_ena			<= '0';
				nx_state		<= idle;
			---------------------------
		END CASE;
	END PROCESS;
END ARCHITECTURE fsmd; 