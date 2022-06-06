library ieee;
use ieee.std_logic_1164.all;
----------------------------------
entity my_resDFF is
	generic ( max_width	:	integer	:=4);

	port(
				clk	:	in		std_logic;
				rst	:	in		std_logic;
				ena	:	in		std_logic;
				d		:	in		std_logic_vector(max_width-1 downto 0);
				q		:	out	std_logic_vector(max_width-1 downto 0)
		);

end entity;
-----------------------------------
architecture structural of my_resDFF is
begin

	my_reg_gen : for i in 0 to max_width-1 generate
		DFFx : entity work.my_dff
			port map(
							clk	=>		clk,
							rst	=>		rst,
							ena	=>		ena,
							d		=>		d(i),
							q		=>		q(i)
						);
	end generate;

end architecture;