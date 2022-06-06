LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
-- mov [DPTR] acc 
ENTITY bist_mov_dptr_acc_two IS
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
END ENTITY bist_mov_dptr_acc_two;
-------------------------------------------------------------------------
ARCHITECTURE fsmd OF bist_mov_dptr_acc_two IS
	TYPE state IS (idle, state_0, state_1, state_2);
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
				----- MAR <= DTPR
				enaf				<= '0';
				selop				<= "000"; --B
				shamt				<= "00"; -- no shift
				busB_addr		<= "010"; -- DTPR
				busC_addr		<= "000";
				bank_wr_ena 	<= '0';--read bank register 
				mar_en			<= '1'; --enable mar
				mdr_en			<= '0';
				mdr_alu_n		<= '0';
				wr_rd_n			<= '0';--read memory
				ir_ena			<= '0';
				nx_state		<= state_1;
			---------------------------
			WHEN state_1 => 
				----- write MDR
				enaf				<= '0';
				selop				<= "000"; --B
				shamt				<= "00"; -- no shift
				busB_addr		<= "111"; -- ACC 
				busC_addr		<= "000";
				bank_wr_ena 	<= '0';
				mar_en			<= '0';
				mdr_en			<= '1';--write MDR
				mdr_alu_n		<= '0';
				wr_rd_n			<= '0';
				ir_ena			<= '0';
				nx_state		<= state_2;
			---------------------------
			WHEN state_2 => 
				----- write MDR
				enaf				<= '0';
				selop				<= "000"; --B
				shamt				<= "00"; -- no shift
				busB_addr		<= "111"; -- ACC 
				busC_addr		<= "000";
				bank_wr_ena 	<= '0';
				mar_en			<= '0';
				mdr_en			<= '0';
				mdr_alu_n		<= '0';
				wr_rd_n			<= '1';--
				ir_ena			<= '0';
				nx_state		<= idle;
			---------------------------
		END CASE;
	END PROCESS;
END ARCHITECTURE fsmd; 