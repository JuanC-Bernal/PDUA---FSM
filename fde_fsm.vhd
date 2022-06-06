LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY fde_fsm IS -- fetch decode execute 
	PORT	(		clk					: 	IN 	STD_LOGIC;
					rst					:	IN	   STD_LOGIC;
					strobe				: 	IN 	STD_LOGIC;
					ready_ih				: 	IN 	STD_LOGIC;
					ready_fetch			:	IN		STD_LOGIC;
					int					:	IN 	STD_LOGIC;
					ready_exe			:	IN		STD_LOGIC;
					halt					:	IN		STD_LOGIC;
					en_ih					:	OUT	STD_LOGIC;
					en_fetch				:	OUT 	STD_LOGIC;
					en_execute			:	OUT 	STD_LOGIC);
END ENTITY fde_fsm;
-------------------------------------------------------------------------
ARCHITECTURE fsmd OF fde_fsm IS
	TYPE state IS (idle, int_s, strobe_ih, int_handler, strobe_fetch, fetch, decoding, strobe_exec,execute);
	SIGNAL 	pr_state	: 	state;
	SIGNAL 	nx_state	: 	state;
BEGIN
	--===========================================
	--              FSM
	--===========================================
	-- Sequential Section ----------------------
	seq_fsm: PROCESS(clk, rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state <=idle;
		ELSIF(rising_edge(clk)) THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	
	-- Combinational Section ----------------------
	comb_fsm: PROCESS (pr_state, strobe, ready_exe, ready_fetch, ready_ih, int, halt)
	BEGIN
		
		CASE pr_state IS
			---------------------------
			WHEN idle =>
				en_ih			<= '0';
				en_fetch		<= '0';
				en_execute	<= '0';
				IF (strobe = '1') THEN
					nx_state	<= int_s;
				ELSE
					nx_state	<= idle;
				END IF;
			---------------------------
			WHEN int_s =>
				en_ih			<= '0';
				en_fetch		<= '0';
				en_execute	<= '0';
				IF (int = '1') THEN
					nx_state	<= strobe_ih;
				ELSE
					nx_state	<= strobe_fetch;
				END IF;
			---------------------------
			WHEN strobe_ih =>
				en_ih			<= '1';
				en_fetch		<= '0';
				en_execute	<= '0';
				nx_state	<= int_handler;
			---------------------------
			WHEN int_handler =>
				en_ih			<= '0';
				en_fetch		<= '0';
				en_execute	<= '0';
				IF (ready_ih = '1') THEN
					nx_state	<= int_s;
				ELSE
					nx_state	<= int_handler;
				END IF;
			---------------------------
			WHEN strobe_fetch =>
				en_ih			<= '0';
				en_fetch		<= '1';
				en_execute	<= '0';
				nx_state	<= fetch;
			---------------------------
			WHEN fetch =>
				en_ih			<= '0';
				en_fetch		<= '1';
				en_execute	<= '0';
				IF (ready_fetch = '1') THEN
					nx_state	<= decoding;
				ELSE
					nx_state	<= fetch;
				END IF;
			---------------------------
			WHEN decoding =>
				en_ih			<= '0';
				en_fetch		<= '0';
				en_execute	<= '0';
				IF (halt = '1') THEN
					nx_state	<= idle;
				ELSE
					nx_state	<= strobe_exec;
				END IF;
			---------------------------
			WHEN strobe_exec =>
				en_ih			<= '0';
				en_fetch		<= '0';
				en_execute	<= '1';
				nx_state	<= execute;
			---------------------------
			WHEN execute =>
				en_ih			<= '0';
				en_fetch		<= '0';
				en_execute	<= '1';
				IF (ready_exe = '1') THEN
					nx_state	<= int_s;
				ELSE
					nx_state	<= execute;
				END IF;
			---------------------------
		END CASE;
	END PROCESS;
END ARCHITECTURE fsmd;