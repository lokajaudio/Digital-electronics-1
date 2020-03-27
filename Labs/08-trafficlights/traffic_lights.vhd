library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic is 
	port (clk_i: in std_logic;
			srst_n_i: in std_logic;
			ce_2Hz_i: in std_logic;
			lights_o: out std_logic_vector(5 downto 0));
end traffic;

architecture traffic of traffic is
    type state_type is (zelena_cervena, oranzova_cervena, cervena_cervena1, cervena_zelena, cervena_oranzova, cervena_cervena2);
    signal state: state_type;
    signal count : unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1001";
    constant SEC1: unsigned(3 downto 0) := "0001";
	 begin
		process(clk_i, srst_n_i)
		begin
		if srst_n_i = '0' then
			state <= zelena_cervena;
			count <= X"0";
		elsif rising_edge(clk_i) and ce_2Hz_i = '1' then
		case state is
			when zelena_cervena =>
			 if count < SEC5 then
				state <= zelena_cervena;
				count <= count + 1;
			else
				state <= oranzova_cervena;
				count <= X"0";
			end if;
								
			when oranzova_cervena =>
			 if count < SEC1 then
				state <= oranzova_cervena;
				count <= count + 1;
			else
				state <= cervena_cervena1;
				count <= X"0";
			end if;
								
			when cervena_cervena1 =>
			 if count < SEC1 then
				state <= cervena_cervena1;
				count <= count + 1;
			else
				state <= cervena_zelena;
				count <= X"0";
			end if;
								
			when cervena_zelena =>
			 if count < SEC5 then
				state <= cervena_zelena;
				count <= count + 1;
			else
				state <= cervena_oranzova;
				count <= X"0";
			end if;
								
			when cervena_oranzova =>
			 if count < SEC1 then
				state <= cervena_oranzova;
				count <= count + 1;
			else
				state <= cervena_cervena2;
				count <= X"0";
		        end if;
								
			when cervena_cervena2 =>
			if count < SEC1 then
				state <= cervena_cervena2;
				count <= count + 1;
			else
				state <= zelena_cervena;
				count <= X"0";
			end if;

			when others =>
				state <= zelena_cervena;
			end case;
			end if;
			end process;
			
			
			C2: process(state)
			begin
			case state is 
				when zelena_cervena => lights_o <= "100001";
				when oranzova_cervena => lights_o <= "100010";
				when cervena_cervena1 => lights_o <= "100100";
				when cervena_zelena => lights_o <= "001100";
				when cervena_oranzova => lights_o <= "010100";
				when cervena_cervena2 => lights_o <= "100100";
				when others => lights_o <= "100001";
			end case;
			end process;		   
end traffic;
