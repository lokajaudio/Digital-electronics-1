--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:11:02 03/05/2020
-- Design Name:   
-- Module Name:   /home/lab661/Documents/lokajmaro/Digital-electronics-1/Labs/05_counter_binary/binary_counter/counter_tb00.vhd
-- Project Name:  binary_counter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clock_enable
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
 
ENTITY counter_tb00 IS
END counter_tb00;
 
ARCHITECTURE behavior OF counter_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_enable
    PORT(
        );
    END COMPONENT;
    
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
-- 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_enable PORT MAP (
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
        srst_n_i <= '1';
      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
