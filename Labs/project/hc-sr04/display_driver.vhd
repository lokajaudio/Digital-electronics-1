library ieee;
use ieee.std_logic_1164.all;

entity display_driver is
    port(
        address_input : in std_logic_vector(2-1 downto 0); 
        active_out : out std_logic_vector(4-1 downto 0)  
    );
end display_driver;

architecture Behavioral of display_driver is
begin
    active_out(3) <= NOT (address_input(0) AND address_input(1));     
    active_out(2) <= NOT (NOT address_input(0) AND address_input(1));
    active_out(1) <= NOT (address_input(0) AND NOT address_input(1)); 
    active_out(0) <= address_input(0) OR address_input(1);             
end Behavioral;
