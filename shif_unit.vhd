library ieee;
use ieee.std_logic_1164.all;

entity shif_unit is

	generic(n	:	integer	:=		8);
	port
		(
			shamt		:	in		std_logic_vector(1 downto 0);
			dataa		:	in		std_logic_vector(n-1 downto 0);
			dataout	:	out	std_logic_vector(n-1 downto 0)
		);

end entity;
-----------------------------------------------------
architecture rtl of shif_unit is
begin
	-- note: use only one of the folloing implementations:
	-- mux ver. 1
	dataout	<=	dataa											when shamt = "00" else -- no shift
					'0' & dataa(n-1 downto 1)				when shamt = "01" else -- srl
					dataa(n-2 downto 0) & '0'				when shamt = "10" else -- sll
					(others => '0');

--	-- mux ver. 2
--	with	shamt select
--			dataout	<=		data								when "00",
--			
--								'0' & data(n-1 downto 1)	when "01"

end architecture;
