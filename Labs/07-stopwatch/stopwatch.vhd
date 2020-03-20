library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity stopwatch is
port (
	clk_i      : in  std_logic;
	srst_n_i   : in  std_logic;
	ce_100Hz_i : in  std_logic;
	cnt_en_i   : in  std_logic;
	sec_h_o    : out std_logic_vector(3 downto 0);
	sec_l_o    : out std_logic_vector(3 downto 0);
	hth_h_o    : out std_logic_vector(3 downto 0);
	hth_l_o    : out std_logic_vector(3 downto 0)
		);
end stopwatch;

architecture Behavioral of stopwatch is
begin
def: process(clk_i, srst_n_i, ce_100Hz_i, cnt_en_i)
	  variable hth_l_o_temp : std_logic_vector(3 downto 0) := x"0";
	  variable hth_h_o_temp : std_logic_vector(3 downto 0) := x"0"; 
	  variable sec_l_o_temp : std_logic_vector(3 downto 0) := x"0";
	  variable sec_h_o_temp : std_logic_vector(3 downto 0) := x"0";

	begin
		if srst_n_i = '0' then
			hth_l_o_temp := x"0";
			hth_h_o_temp := x"0";
			sec_l_o_temp := x"0";
			sec_h_o_temp := x"0";
		  elsif clk_i  = '1' and cnt_en_i = '1' and rising_edge(ce_100Hz_i) then	
			hth_l_o_temp  := hth_l_o_temp  + x"1";
			
			if hth_l_o_temp  > 9 then hth_l_o_temp  := x"0";
				hth_h_o_temp := hth_h_o_temp + x"1"; 
			end if; 

			if hth_h_o_temp > 9 then hth_h_o_temp := x"0";
				sec_l_o_temp := sec_l_o_temp + x"1";
			end if; 

			if sec_l_o_temp > 9 then sec_l_o_temp := x"0";
				sec_h_o_temp := sec_h_o_temp + x"1";
			end if; 

			if sec_h_o_temp > 5 then sec_h_o_temp := x"0";
			end if;
			
		end if;
		
	sec_h_o <= sec_h_o_temp;
	sec_l_o <= sec_l_o_temp;
	hth_h_o <= hth_h_o_temp;
	hth_l_o <= hth_l_o_temp;
		
	end process;
end Behavioral;
