LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    COMPONENT stopwatch
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         ce_100Hz_i : IN  std_logic;
         cnt_en_i : IN  std_logic;
         sec_h_o : OUT  std_logic_vector(3 downto 0);
         sec_l_o : OUT  std_logic_vector(3 downto 0);
         hth_h_o : OUT  std_logic_vector(3 downto 0);
         hth_l_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal ce_100Hz_i : std_logic := '0';
   signal cnt_en_i : std_logic := '0';

   signal sec_h_o : std_logic_vector(3 downto 0);
   signal sec_l_o : std_logic_vector(3 downto 0);
   signal hth_h_o : std_logic_vector(3 downto 0);
   signal hth_l_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
	
	procedure clk_generate(signal clk : out std_logic; constant T: time) is -- new procedure with two arguments
	begin 
		loop
			clk <= '1';
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
		end loop;
	end procedure;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: stopwatch PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          ce_100Hz_i => ce_100Hz_i,
          cnt_en_i => cnt_en_i,
          sec_h_o => sec_h_o,
          sec_l_o => sec_l_o,
          hth_h_o => hth_h_o,
          hth_l_o => hth_l_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin

		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;

   end process;

   -- Stimulus process
   stim_proc: process
   begin		
     
        srst_n_i <= '1';
		cnt_en_i <= '1';
		wait for 5 ns;
		clk_generate(ce_100Hz_i, 1 ns);

      wait;
   end process;

END;
