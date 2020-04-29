library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity matrix is
		port (
			clk_i : in std_logic; 
			echo_s  : in std_logic;
			a_x  : out std_logic_vector(2-1 downto 0)
		);
end matrix;

architecture Behavioral of matrix is
	signal i: integer := 0;

begin
	process(clk_i)
	begin
		if falling_edge(clk_i) then
			if echo_s = '0' then
					if i = 0 then
						a_x <= "00";
					elsif i = 1 then
						a_x <= "01";
					elsif i = 2 then
						a_x <= "10";
					else  
						a_x <= "11";
					end if;
						i <= i + 1; 
					if (i = 4) then
						i <= 0;
					end if;
			end if;
		end if;	
	end process;
end Behavioral;