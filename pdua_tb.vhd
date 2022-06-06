LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY pdua_tb IS 
	GENERIC(TEST_OPCODE 		: STD_LOGIC_VECTOR := "00000";
				DATA_WIDTH		: INTEGER := 8;
				RB_ADDR_WIDTH  : INTEGER := 3;
				ADDR_WIDTH		: INTEGER := 8);
END ENTITY pdua_tb; 
ARCHITECTURE testbench OF pdua_tb IS 

				SIGNAL clk_tb			: STD_LOGIC := '0';
				SIGNAL rst_tb			: STD_LOGIC := '1';
				
				SIGNAL strobe_tb 		: STD_LOGIC := '0';
--				SIGNAL mar_ena_tb		: STD_LOGIC; 
--				SIGNAL ir_ena_tb		: STD_LOGIC; 
--				SIGNAL wr_rd_n_tb		: STD_LOGIC;
--				SIGNAL mdr_en_tb		: STD_LOGIC;
--				SIGNAL mdr_alu_n_tb	: STD_LOGIC;
--				SIGNAL busB_addr_tb	: STD_LOGIC_VECTOR(2 DOWNTO 0);
--				SIGNAL busC_addr_tb 	: STD_LOGIC_VECTOR(2 DOWNTO 0);
--				SIGNAL bank_wr_ena_tb: STD_LOGIC;
--				SIGNAL enaf_tb			: STD_LOGIC;
--				SIGNAL selop_tb		: STD_LOGIC_VECTOR(2 DOWNTO 0);
--				SIGNAL shamt_tb		: STD_LOGIC_VECTOR(1 DOWNTO 0);
--				SIGNAL opcode_tb		: STD_LOGIC_VECTOR(4 DOWNTO 0);
--				SIGNAL C_tb				: STD_LOGIC;
--				SIGNAL N_tb				: STD_LOGIC;
--				SIGNAL P_tb				: STD_LOGIC;
--				SIGNAL Z_tb				: STD_LOGIC;
BEGIN 
-- clock generation --
	clk_tb 		<= not clk_tb after 10ns;
	
-- reset generation -- 
	rst_tb 		<= '0' after 10ns;
	strobe_tb	<= '1' after 30ns;
						
--DUT: ENTITY work.PDUA
--	GENERIC MAP (MAX_WIDTH => DATA_WIDTH)
--	PORT MAP	(
--				clk			=> clk_tb,
--				rst			=> rst_tb,
--				mar_ena		=> mar_ena_tb,
--				ir_ena		=> ir_ena_tb, 
--				wr_rd_n		=> wr_rd_n_tb,
--				mdr_en		=> mdr_en_tb,
--				mdr_alu_n	=> mdr_alu_n_tb,
--				busB_addr	=> busB_addr_tb,
--				busC_addr 	=> busC_addr_tb,
--				bank_wr_ena	=> bank_wr_ena_tb,
--				enaf			=> enaf_tb,
--				selop			=> selop_tb,
--				shamt			=> shamt_tb,
--				opcode		=> opcode_tb,
--				C				=> C_tb,
--				N				=> N_tb,
--				P				=> P_tb,
--				Z				=> Z_tb
--				);
--BIST: ENTITY work.bist_slr_acc
--	GENERIC MAP (DATA_WIDTH => DATA_WIDTH)
--	PORT MAP	(
--				clk			=> clk_tb,
--				rst			=> rst_tb,
--				mar_en		=> mar_ena_tb,
--				ir_ena		=> ir_ena_tb, 
--				wr_rd_n		=> wr_rd_n_tb,
--				mdr_en		=> mdr_en_tb,
--				mdr_alu_n	=> mdr_alu_n_tb,
--				busB_addr	=> busB_addr_tb,
--				busC_addr 	=> busC_addr_tb,
--				bank_wr_ena	=> bank_wr_ena_tb,
--				enaf			=> enaf_tb,
--				selop			=> selop_tb,
--				shamt			=> shamt_tb,
--				strobe		=> strobe_tb
--				--opcode		=> opcode_tb,
----				C				=> C_tb,
----				N				=> N_tb,
----				P				=> P_tb,
----				Z				=> Z_tb
--				);

PDUA: ENTITY work.pdua
	GENERIC MAP (MAX_WIDTH => DATA_WIDTH)
	PORT MAP	(
				clk			=> clk_tb,
				rst			=> rst_tb,
				strobe		=> strobe_tb
				);
				
END ARCHITECTURE testbench;