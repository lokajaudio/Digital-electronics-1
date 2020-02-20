library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
    port (BTN1, BTN0:    in  std_logic; -- btn0 A, btn1 B
          LD3, LD2, LD1, LD0: out std_logic);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
begin
    LD0 <= not(BTN0 and (not BTN1)); -- A>B
    LD1 <= not(((not BTN0) and (not BTN1)) or (BTN0 and BTN1));-- A=B
    LD2 <= not(BTN1 and (not BTN0)); -- A>B
    LD3 <= not BTN0;
end architecture Behavioral;