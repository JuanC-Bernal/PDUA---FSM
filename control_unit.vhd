LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY control_unit IS 
	PORT	(		clk						: 	IN 	STD_LOGIC;
					rst						: 	IN 	STD_LOGIC;
					strobe					: 	IN 	STD_LOGIC;
					int			 			:	IN	   STD_LOGIC;
					opcode					: 	IN 	STD_LOGIC_VECTOR(4 DOWNTO 0);
					C							: 	IN 	STD_LOGIC;
					N							: 	IN 	STD_LOGIC;
					Z							: 	IN 	STD_LOGIC;
					P							: 	IN 	STD_LOGIC;
					uinstruction			: 	OUT 	STD_LOGIC_VECTOR(17 DOWNTO 0)
					
					);
END ENTITY control_unit;
-------------------------------------------------------------------------
ARCHITECTURE structural OF control_unit IS 
SIGNAL a0 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a1 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a2 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a3 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a4 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a5 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a6 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a7 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a8 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a9 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a10 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a11 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a12 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a13 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a14 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a15 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a16 : STD_LOGIC_VECTOR (17 DOWNTO 0);
SIGNAL a17 : STD_LOGIC_VECTOR (17 DOWNTO 0);

SIGNAL d0 : STD_LOGIC;
SIGNAL d1 : STD_LOGIC;
SIGNAL d2 : STD_LOGIC;
SIGNAL d3 : STD_LOGIC;
SIGNAL d4 : STD_LOGIC;
SIGNAL d5 : STD_LOGIC;
SIGNAL d6 : STD_LOGIC;
SIGNAL d7 : STD_LOGIC;
SIGNAL d8 : STD_LOGIC;
SIGNAL d9 : STD_LOGIC;
SIGNAL d10 : STD_LOGIC;
SIGNAL d11 : STD_LOGIC;
SIGNAL d12 : STD_LOGIC;
SIGNAL d13 : STD_LOGIC;
SIGNAL d14 : STD_LOGIC;
SIGNAL d15 : STD_LOGIC;
SIGNAL d16 : STD_LOGIC;
SIGNAL d17 : STD_LOGIC;

signal str,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16 : std_LOGIC;

SIGNAL readys : STD_LOGIC;
SIGNAL DATA_OUT : STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL en_exe : STD_LOGIC;
SIGNAL en_fetch : STD_LOGIC;
SIGNAL en_ih : STD_LOGIC;
SIGNAL sel : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL aux: STD_LOGIC;
BEGIN 

fde: ENTITY work.fde_fsm
	PORT MAP	(
			ready_ih		=> d0,
			ready_fetch	=> d1,
			strobe		=> strobe,
			int			=> int,
			rst			=> rst,
			clk			=> clk,
			ready_exe 	=> readys,
			halt			=> DATA_OUT(16),
			en_ih			=> en_ih,
			en_fetch		=> en_fetch,
			en_execute	=> en_exe
			);
			
decoder: ENTITY work.decoder
	PORT MAP	(
			en			=> en_exe,
			DATA_IN	=> opcode,
			DATA_OUT		=> DATA_OUT
			);
ih: ENTITY work.ih_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> en_ih,
			data_ready	=> d0,
			uinstruction => a0
			);
fetch: ENTITY work.fetch_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> en_fetch,
			data_ready	=> d1,
			uinstruction => a1
			);
			
			str <= en_exe AND DATA_OUT(0);
mov_acc_a: ENTITY work.mov_acc_a_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str,
			data_ready	=> d2,
			uinstruction => a2
			);
			str2 <= en_exe AND DATA_OUT(1);
mov_a_acc: ENTITY work.mov_a_acc_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str2,
			data_ready	=> d3,
			uinstruction => a3
			);
			str3 <= en_exe AND DATA_OUT(2);
mov_acc_cte: ENTITY work.mov_acc_cte_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str3,
			data_ready	=> d4,
			uinstruction => a4
			);
			str4 <= en_exe AND DATA_OUT(3);
mov_acc_dptr: ENTITY work.mov_acc_dptr_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str4,
			data_ready	=> d5,
			uinstruction => a5
			);
			str5 <= en_exe AND DATA_OUT(4);
mov_dptr_acc_one: ENTITY work.mov_dptr_acc_one_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str5,
			data_ready	=> d6,
			uinstruction => a6
			);
			str6 <= en_exe AND DATA_OUT(5);
mov_dptr_acc_two: ENTITY work.mov_dptr_acc_two_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str6,
			data_ready	=> d7,
			uinstruction => a7
			);
			str7 <= en_exe AND DATA_OUT(6);
inv_acc: ENTITY work.inv_acc_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str7,
			data_ready	=> d8,
			uinstruction => a8
			);
			str8 <= en_exe AND DATA_OUT(7);
and_acc: ENTITY work.and_acc_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str8,
			data_ready	=> d9,
			uinstruction => a9
			);
			str9 <= en_exe AND DATA_OUT(8);
-- add acc a
add_acc_a: ENTITY work.add_acc_a_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str9,
			data_ready	=> d10,
			uinstruction => a10
			);
			str10 <= en_exe AND DATA_OUT(9);
-- jmp dir
jmp_dir: ENTITY work.jmp_cte_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str10,
			data_ready	=> d11,
			uinstruction => a11
			);
-- jz dir
str11 <= en_exe AND DATA_OUT(10);
jmp_z: ENTITY work.jmp_z_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str11,
			data_ready	=> d12,
			uinstruction => a12,
			Z	=> Z
			);
-- jn dir
str12 <= en_exe AND DATA_OUT(11);
jmp_n: ENTITY work.jmp_z_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str12,
			data_ready	=> d13,
			uinstruction => a13,
			Z	=> N
			);
-- jc dir
str13 <= en_exe AND DATA_OUT(12);
jmp_C: ENTITY work.jmp_z_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str13,
			data_ready	=> d14,
			uinstruction => a14,
			Z	=> C
			);
-- or acc
str14 <= en_exe AND DATA_OUT(13);
or_acc: ENTITY work.or_acc_a_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str14,
			data_ready	=> d15,
			uinstruction => a15
			);
-- sll acc
str15 <= en_exe AND DATA_OUT(14);
sll_acc: ENTITY work.sll_acc_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str15,
			data_ready	=> d16,
			uinstruction => a16
			);
			str16 <= en_exe AND DATA_OUT(15);
-- slr acc	
slr_acc: ENTITY work.slr_acc_fsm
	PORT MAP	(
			clk			=> clk,
			rst			=> rst,
			strobe		=> str16,
			data_ready	=> d17,
			uinstruction => a17
			);
readys <= d0 OR d1 OR d2 OR d3 OR d4 OR d5 OR d6 OR d7 OR d8 OR d9 OR d10 OR d11 OR d12 OR d13 OR d14 OR d15 OR d16 OR d17;

sel(4 DOWNTO 0) <= opcode;

--toggle: ENTITY work.T_FF
--	PORT MAP	(
--			clock			=> aux,
--			T			=> '1',
--			Q		=> sel(5)
--			);
--aux <= en_fetch OR en_exe;
sel(5) <= en_exe;
sel(6) <= en_fetch;
sel(7) <= en_ih; --hacer algun tipo de flipflop

WITH sel select 
uinstruction <= a1 when "01000000",
					 a2 when "00100001",
					 a3 when "00100010",
					 a4 when "00100011",
					 a5 when "00100100",
					 a6 when "00100101",
					 a7 when "00100110",
					 a8 when "00100111",
					 a9 when "00101000",
					 a10 when "00101001",
					 a11 when "00101010",
					 a12 when "00101011",
					 a13 when "00101100",
					 a14 when "00101101",
					 a15 when "00110000",
					 a16 when "00110001",
					 a17 when "00110010",
					 a1 when OTHERS;

--uinstruction <= a0 when (en_ih = '1') ELSE 
--					 a1 when (en_fetch = '1' AND opcode = "00000") ELSE 
--					 a2 when (en_exe = '1' AND opcode = "00001") ELSE
--					 a3 when (en_exe = '1' AND opcode = "00010") ELSE
--					 a4 when (en_exe = '1' AND opcode = "00011") ELSE
--					 a5 when (en_exe = '1' AND opcode = "00100") ELSE
--					 a6 when (en_exe = '1' AND opcode = "00101") ELSE
--					 a7 when (en_exe = '1' AND opcode = "00110") ELSE
--					 a8 when (en_exe = '1' AND opcode = "00111") ELSE
--					 a9 when (en_exe = '1' AND opcode = "01000") ELSE
--					 a10 when (en_exe = '1' AND opcode = "01001") ELSE
--					 a11 when (en_exe = '1' AND opcode = "01010") ELSE
--					 a12 when (en_exe = '1' AND opcode = "01011") ELSE
--					 a13 when (en_exe = '1' AND opcode = "01100") ELSE
--					 a14 when (en_exe = '1' AND opcode = "01101") ELSE
--					 a15 when (en_exe = '1' AND opcode = "10000") ELSE
--					 a16 when (en_exe = '1' AND opcode = "10001") ELSE
--					 a17 when (en_exe = '1' AND opcode = "10010");

END ARCHITECTURE;