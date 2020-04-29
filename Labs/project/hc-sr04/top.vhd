library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    port (
    clk_i 			: in std_logic;
	echo  			: in std_logic;
    disp_digit_o 	: out std_logic_vector(4-1 downto 0); 
    disp_sseg_o  	: out std_logic_vector(7-1 downto 0);
	trigg 	     	: out std_logic
    );

end top;

architecture Behavioral of top is
	signal length_s	   : std_logic_vector (16-1 downto 0);
	signal bcd_0	   : std_logic_vector (3 downto 0);
	signal bcd_1	   : std_logic_vector (3 downto 0);
	signal bcd_2	   : std_logic_vector (3 downto 0);
	signal bcd_3	   : std_logic_vector (3 downto 0);
	signal s_hex       : std_logic_vector (4-1 downto 0);
	signal a     	   : std_logic_vector (2-1 downto 0);
begin

	 SENSOR : entity work.senzor
		port map (
			clk_i => clk_i,
			echo => echo,
			trigg => trigg,
			distance => length_s
		);


	 BITSTOBCD : entity work.bits_to_bcd
		port map (
			dist_i => length_s,
			bcd_o0 => bcd_0,
			bcd_o1 => bcd_1,
			bcd_o2 => bcd_2,
			bcd_o3 => bcd_3
		);

	 
    HEXTOSEG : entity work.hex_to_seg
        port map (
            hex_i => s_hex,   
            seg_o => disp_sseg_o   
        );

    DISPLAYDRV : entity work.display_driver
        port map (
            address_input => a,            
            active_out => disp_digit_o     
        );
	 
	 MATRIX : entity work.matrix
		  port map (
				clk_i => clk_i,
				echo_s => echo_s,
				a_x => a
		  );

    s_hex <= bcd_0 when (a = "00") else
             bcd_1 when (a = "01") else
             bcd_2 when (a = "10") else
             bcd_3; 
end Behavioral;