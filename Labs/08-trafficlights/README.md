# Lab 8: Traffic light controller

[Example Video on Youtube: Traffic Light Controller](https://www.youtube.com/watch?v=6_Rotnw1hFM)

Hint: Use the `numeric_std` package instead of `ieee.std_logic_unsigned` and change type for internal signals `count`, `SEC5`, and `SEC1` from `std_logic_vector` to `unsigned`. Also change `clk'event and clk = '1'` to `rising_edge(clk)`.

```vhdl
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

...

architecture traffic of traffic is
    ...
    --signal count: std_logic_vector(3 downto 0);
    --constant SEC5: std_logic_vector(3 downto 0) := "1111";
    --constant SEC1: std_logic_vector(3 downto 0) := "0011";
    signal count : unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";

    ...

        --elsif clk'event and clk = '1' then
        elsif rising_edge(clk) then
        ...

end traffic;
```

Change the reset in the example from asynchronous to synchronous.

Follow programming conventions and coding style from previous lab exercises and rename all inputs, outputs and internal signals.

Rename the states `s0`, `s1`, .., `s5` from the example to more meaningful and draw the state diagram.

#### SIMULATION


![simulation](simulation.png)


#### STATE DIAGRAM
![state diagram](state_diagram.jpg){:height="50%" width="50%"}


#### TOP DIAGRAM
![topdiagram](top_diagram.jpg){:height="50%" width="50%"}



