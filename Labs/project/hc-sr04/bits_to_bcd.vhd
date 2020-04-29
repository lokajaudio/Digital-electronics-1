library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity bits_to_bcd is
	port ( 
        dist_i:   in   std_logic_vector (15 downto 0);
        bcd_o0:  out  std_logic_vector (3 downto 0);
        bcd_o1:  out  std_logic_vector (3 downto 0);
        bcd_o2:  out  std_logic_vector (3 downto 0);
        bcd_o3:  out  std_logic_vector (3 downto 0)
    );
end bits_to_bcd;

architecture Behavioral of bits_to_bcd is
begin
	process (dist_i)
        type fourbits is array (3 downto 0) of std_logic_vector(3 downto 0);
        variable bcd:   std_logic_vector (15 downto 0);
        variable bint:  std_logic_vector (13 downto 0);
    begin
        bcd := (others => '0');     
        bint := dist_i (13 downto 0); 

        for i in 0 to 13 loop
            bcd(15 downto 1) := bcd(14 downto 0);
            bcd(0) := bint(13);
            bint(13 downto 1) := bint(12 downto 0);
            bint(0) := '0';

            if i < 13 and bcd(3 downto 0) > "0100" then
                bcd(3 downto 0) := 
                    std_logic_vector (unsigned(bcd(3 downto 0)) + 3);
            end if;
            if i < 13 and bcd(7 downto 4) > "0100" then
                bcd(7 downto 4) := 
                    std_logic_vector(unsigned(bcd(7 downto 4)) + 3);
            end if;
            if i < 13 and bcd(11 downto 8) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(11 downto 8)) + 3);
            end if;
            if i < 13 and bcd(15 downto 12) > "0100" then
                bcd(15 downto 12) := 
                    std_logic_vector(unsigned(bcd(15 downto 12)) + 3);
            end if;
        end loop;

        (bcd_o3, bcd_o2, bcd_o1, bcd_o0)  <= 
                  fourbits'( bcd (15 downto 12), bcd (11 downto 8), 
                               bcd ( 7 downto  4), bcd ( 3 downto 0) );
    end process ;
end Behavioral;