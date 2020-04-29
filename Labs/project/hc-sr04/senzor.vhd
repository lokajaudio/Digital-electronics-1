library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.ALL;


entity senzor is
    port(
		clk_i : in std_logic;
		echo_s  : in std_logic;
		trigg  : out std_logic;
		distance : out std_logic_vector(16-1 downto 0)
        );
end senzor;

architecture Behavioral of senzor is
    signal max_time : integer := 0;
	signal pulse_length_s : integer := 0;
    signal trigger: std_logic := '1';
	signal bin_distance : std_logic_vector(16-1 downto 0);

    
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if trigger = '1' then
					bin_distance <= "0000000000000000";
                if pulse_length_s = 10 then
                    trigg <= '0';
                    trigger <= '0';
                    pulse_length_s <= 0;
                else
                    trigg <= '1';
                    pulse_length_s <= pulse_length_s + 1;
                end if;
            else
                if echo_s = '1' then 
				bin_distance <= bin_distance + "1";
                else
                    if max_time = 20000 then
                        trigger <= '1';
                        max_time <= 0;
                    else
                        if max_time = 10 then
                            bin_distance <= "000000" & bin_distance(15 DOWNTO 6); 
							--- shift reg left << 6
							--- divides by /64, which is approx 58.13
                        end if;
                        distance <= bin_distance;
                        max_time <= max_time + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;