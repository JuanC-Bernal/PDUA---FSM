library ieee;
use ieee.std_logic_1164.all;
----------------------------------
ENTITY PDUA IS 
	GENERIC( MAX_WIDTH	: integer:=8);
	PORT(		clk			: IN STD_LOGIC;
				rst			: IN STD_LOGIC;
				strobe		:  IN		STD_LOGIC 
--				mar_ena		: IN STD_LOGIC; 
--				ir_ena		: IN STD_LOGIC; 
--				wr_rd_n		: IN STD_LOGIC;
--				mdr_en		: IN STD_LOGIC;
--				mdr_alu_n	: IN STD_LOGIC;
--				busB_addr	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
--				busC_addr 	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
--				bank_wr_ena	: IN STD_LOGIC;
--				enaf			: IN STD_LOGIC;
--				selop			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
--				shamt			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--				opcode		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
--				C				: OUT STD_LOGIC;
--				N				: OUT STD_LOGIC;
--				P				: OUT STD_LOGIC;
--				Z				: OUT STD_LOGIC
			);
END ENTITY;
ARCHITECTURE structural OF PDUA IS 
SIGNAL busA  			 :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL busB  			 :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL busC  			 :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL bus_data_out 	 :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL bus_alu			 :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL bus_data_in 	 :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL q					 :STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL	mar_ena		:  STD_LOGIC; 
SIGNAL	ir_ena		:  STD_LOGIC; 
SIGNAL	wr_rd_n		:  STD_LOGIC;
SIGNAL	mdr_en		:  STD_LOGIC;
SIGNAL	mdr_alu_n	:  STD_LOGIC;
SIGNAL	busB_addr	:  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	busC_addr 	:  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	bank_wr_ena	:  STD_LOGIC;
SIGNAL	enaf			:  STD_LOGIC;
SIGNAL	selop			:  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	shamt			:  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	opcode		:  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	C				:  STD_LOGIC;
SIGNAL	N				:  STD_LOGIC;
SIGNAL	P				:  STD_LOGIC;
SIGNAL	Z				:  STD_LOGIC;
SIGNAL uinstruction: STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL int : STD_LOGIC;

BEGIN
	int <= '0';
	enaf<=uinstruction(17);
	selop<=uinstruction(16 DOWNTO 14);
	shamt<=uinstruction(13 DOWNTO 12);
	busB_addr<=uinstruction(11 DOWNTO 9);
	busC_addr<=uinstruction(8 DOWNTO 6);
	bank_wr_ena<=uinstruction(5);
	mar_ena<=uinstruction(4);
	mdr_en<=uinstruction(3);
	mdr_alu_n<=uinstruction(2);
	wr_rd_n<=uinstruction(1);
	ir_ena<=uinstruction(0);

MAR: entity work.my_resDFF
			GENERIC MAP (max_width => MAX_WIDTH)
			PORT MAP	(
							clk	=>		clk,
							rst	=>		rst,
							ena	=>		mar_ena,
							d		=>		busC,
							q		=>		q
							);
IR: entity work.my_resDFF
			GENERIC MAP (max_width => 5)
			PORT MAP	(
							clk	=>		clk,
							rst	=>		rst,
							ena	=>		ir_ena,
							d		=>		busC(7 DOWNTO 3),
							q		=>		opcode
							);
MDR: entity work.mdr
			GENERIC MAP (max_width => MAX_WIDTH)
			PORT MAP	(
				clk			=> clk,
				mdr_ena		=> mdr_en,
				mdr_alu_n	=> mdr_alu_n,
				DATA_EX_in	=> bus_data_in,
				rst			=> rst,
				bus_alu		=> bus_alu,
				busC			=> busC,
				BUS_DATA_OUT => bus_data_out
				);
SPRAM: entity work.my_SPRAM
			GENERIC MAP (DATA_WIDTH => MAX_WIDTH,
							 ADDR_WIDTH => MAX_WIDTH)
			PORT MAP	(
				clk			=> clk,
				wr_rdn		=> wr_rd_n,
				addr			=> q,
				w_data		=> bus_data_out,
				r_data		=> bus_data_in
				);
register_bank: entity work.register_file
			GENERIC MAP (data_width => MAX_WIDTH,
							 addr_width => 3)
			PORT MAP	(
			rst		=> rst,
			clk		=> clk,
			wr_en		=> bank_wr_ena,
			w_addr	=> busC_addr,
			r_addr	=> busB_addr,
			w_data	=> busC,
			busA		=> busA,
			busB		=> busB
				);
alu: entity work.alu
			GENERIC MAP (max_width => MAX_WIDTH)
			PORT MAP	(
			clk		=> clk,
			rst		=> rst,
			busA		=> busA,
			busB		=> busB,
			selop		=> selop,
			shamt		=> shamt,
			enaf		=> enaf,
			busC		=> bus_alu,
			C			=> C,
			Nneg		=> N,
			Z			=> Z,
			P			=> P
				);
control_unit: entity work.control_unit
			PORT MAP	(
			clk		=> clk,
			rst		=> rst,
			int		=> int,
			C			=> C,
			N			=> N,
			Z			=> Z,
			P			=> P,
			opcode 	=> opcode,
			uinstruction => uinstruction,
			strobe => strobe
				);

END ARCHITECTURE; 