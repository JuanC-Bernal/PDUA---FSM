library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------
entity register_file is

	generic(
				data_width	:	integer	:=		8;
				addr_width	:	integer	:=		2);

	port(
			clk		:	in		std_logic;
			wr_en		:	in		std_logic;
			rst 		: IN 	STD_LOGIC;
			w_addr	:	in		std_logic_vector(addr_width-1 downto 0);
			r_addr	:	in		std_logic_vector(addr_width-1 downto 0);
			w_data	:	in		std_logic_vector(data_width-1 downto 0);
			busA		:	out	std_logic_vector(data_width-1 downto 0);
			busB		: 	out std_logic_vector(data_width-1 downto 0)
		);

end entity;
------------------------------------------------
architecture rtl of register_file is
	type nem_type is array(0 to 2**addr_width-1) of std_logic_vector((data_width-1) downto 0);
	signal array_reg: nem_type;
	signal buses: std_logic_vector(data_width-1 downto 0);

begin
	--write process
	write_process : process(clk,rst)
	begin
	IF(rst ='1') THEN 
	array_reg(0) <= "00000001";
	array_reg(1) <= "11111111";
	array_reg(2) <= "00000001";
	array_reg(3) <= "00001010";
	array_reg(4) <= "00000000";
	array_reg(5) <= "00000000";
	array_reg(6) <= "11111111";
	array_reg(7) <= "00011010";

		elsif(rising_edge(clk)) then
			if(wr_en = '1') then
				array_reg(to_integer(unsigned(w_addr))) <= w_data;
			end if;
		end if;

	end process;

	--read
	buses <= array_reg(to_integer(unsigned(r_addr)));
	busA <= array_reg(7);
	busB <= buses;

end architecture;