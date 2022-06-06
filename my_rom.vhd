library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------
entity my_rom is

	generic(
				data_width	:	natural	:=		8;
				addr_width	:	natural	:=		8
			);

	port(
			clk		:	in		std_logic;
			addr		:	in		std_logic_vector(addr_width-1 downto 0);

			q			:	out	std_logic_vector(data_width-1 downto 0)
		);

end entity;
-------------------------------------
architecture rtl of my_rom is
	--buIld a 2-D array type for the ROM
	type memory_t is array(0 to 2**addr_width-1) of std_logic_vector((data_width-1) downto 0);
	signal rom : memory_t;

	--assign rom contents.mif to memory circuit
	attribute ram_init_file : string;
	attribute ram_init_file of rom : signal is "rom_contentets.mif";

begin

	process(clk)
	begin
			if(rising_edge(clk)) then
				q <= rom(to_integer(unsigned(addr)));
			end if;
	end process;

end architecture;
