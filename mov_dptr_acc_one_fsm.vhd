LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY mov_dptr_acc_one_fsm IS
	GENERIC(DATA_WIDTH : integer:= 8);
	PORT	(		clk					: 	IN 	STD_LOGIC;
					rst					:	IN		STD_LOGIC;
					strobe				: 	IN 	STD_LOGIC;
					--ready_data_path	: 	IN 	STD_LOGIC;
					data_ready			: OUT STD_LOGIC;
					uinstruction		: OUT STD_LOGIC_VECTOR(17 DOWNTO 0)

					);					
END ENTITY mov_dptr_acc_one_fsm;
-------------------------------------------------------------------------
ARCHITECTURE fsmd OF mov_dptr_acc_one_fsm IS
	TYPE state IS (idle, state_0);
	SIGNAL 	pr_state	: 	state;
	SIGNAL 	nx_state	: 	state;
	SIGNAL bank_wr_ena		:STD_LOGIC;
	SIGNAL busB_addr			:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL busC_addr 			:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL enaf					:STD_LOGIC;
	SIGNAL selop				:STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL shamt				:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ir_ena				:STD_LOGIC;
	SIGNAL mar_en				:STD_LOGIC;
	SIGNAL mdr_en				:STD_LOGIC;
	SIGNAL mdr_alu_n			:STD_LOGIC;
	SIGNAL wr_rd_n				:STD_LOGIC;
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
				data_ready		<= '0';
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
				busB_addr		<= "111"; -- Acc
				busC_addr		<= "010"; -- DPTR
				bank_wr_ena 	<= '1';--Write register bank
				mar_en			<= '0'; 
				mdr_en			<= '0';
				mdr_alu_n		<= '0';
				wr_rd_n			<= '0';--read memory
				ir_ena			<= '0';
				data_ready		<= '1';
				nx_state		<= idle;
			---------------------------				
		END CASE;
	END PROCESS;
	uinstruction(17) <= enaf;
	uinstruction(16 DOWNTO 14) <= selop;
	uinstruction(13 DOWNTO 12) <= shamt;
	uinstruction(11 DOWNTO 9)  <= busB_addr;
	uinstruction(8 DOWNTO 6)	<= busC_addr;
	uinstruction(5) <= bank_wr_ena;
	uinstruction(4) <= mar_en;
	uinstruction(3) <= mdr_en;
	uinstruction(2) <= mdr_alu_n;
	uinstruction(1) <= wr_rd_n;
	uinstruction(0) <= ir_ena;
END ARCHITECTURE fsmd; 