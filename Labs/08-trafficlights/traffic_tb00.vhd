--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY traffic_tb00 IS
END traffic_tb00;
 
ARCHITECTURE behavior OF traffic_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT traffic
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         ce_2Hz_i : IN  std_logic;
         lights_o : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in : std_logic := '0';
   signal srst_n_in : std_logic := '0';
   signal ce_2Hz_in : std_logic := '0';

   --Outputs
   signal lights_out : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: traffic PORT MAP (
          clk_i => clk_in,
          srst_n_i => srst_n_in,
          ce_2Hz_i => ce_2Hz_in,
          lights_o => lights_out
        );
		  
	Clk_gen: process	
  	begin
    	while Now < 500 nS loop
      		clk_in <= '0';
      		wait for 0.5 NS;
      		clk_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;
	
	
	Clk_2Hz_gen: process	
  	begin
    	while Now < 500 nS loop
      		ce_2Hz_in <= '0';
      		wait for 1.5 NS;
      		ce_2Hz_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_2Hz_gen;


   -- Stimulus process
   stim_proc: process
   begin		
	wait until rising_edge(clk_in);
	wait until rising_edge(clk_in);
	srst_n_in <= '0';
	wait until rising_edge(clk_in);
	wait until rising_edge(clk_in);
	wait until rising_edge(clk_in);
	srst_n_in <= '1';
      wait;
   end process;

END behavior;
