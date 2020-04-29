-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         echo_s : IN  std_logic;
         disp_digit_o : OUT  std_logic_vector(3 downto 0);
         disp_sseg_o : OUT  std_logic_vector(6 downto 0);
         trigg : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal echo_s : std_logic := '0';

 	--Outputs
   signal disp_digit_o : std_logic_vector(3 downto 0);
   signal disp_sseg_o : std_logic_vector(6 downto 0);
   signal trigg : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          echo_s => echo_s,
          disp_digit_o => disp_digit_o,
          disp_sseg_o => disp_sseg_o,
          trigg => trigg
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
      -- hold reset state for 100 ns.
      wait for 10 us;	
		echo_s <= '0';
		wait for 10 us;
		echo_s <= '1';
		wait for 50 us;
		echo_s <= '0';	
		wait for 10 us;
		echo_s <= '1';
		wait for 150 us;
		echo_s <= '0';
		wait for 10 us;	
		echo_s <= '0';
		wait for 10 us;
		echo_s <= '1';
		wait for 800 us;
		echo_s <= '0';	

      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
