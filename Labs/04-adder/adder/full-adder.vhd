library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for full adder
------------------------------------------------------------------------
entity full_adder is
port (
    carry_i : in  std_logic;
    b_i :     in  std_logic;
    a_i :     in  std_logic;
    carry_o : out std_logic;
    sum_o   : out std_logic
);
end entity full_adder;

------------------------------------------------------------------------
-- Architecture declaration for full adder
------------------------------------------------------------------------
architecture Behavioral of full_adder is
    -- Internal signals between two half adders
    signal s_carry0, s_carry1, s_sum0 : std_logic;
begin

    --------------------------------------------------------------------
    -- Sub-blocks of two half_adder entities
    HALF_ADDER_0 : entity work.half_adder
    port map ( 
    -- WRITE YOUR CODE HERE
    -- vlevo vstupy a vystupy, vpravo davam to, co tam pripojím
        a_i => a_i,
        b_i => b_i,
        sum_o => s_sum0,
        carry_o => s_carry0);

    HALF_ADDER_1 : entity work.half_adder
    port map (
        b_i => carry_i,
        a_i => s_sum0,
        sum_o=> sum_o,
        carry_o => s_carry1);
    
    carry_o <= s_carry1 OR s_carry0;
    -- Output carry
    -- WRITE YOUR CODE HERE

end architecture Behavioral;