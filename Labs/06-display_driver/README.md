# Lab 6: Driver for seven-segment display

#### Objectives

In this laboratory exercise, you will study the creation of a sequential circuit for multiplexing a 7-segment display. This allows you to display 4-digit values including the decimal point on the display.


#### Materials

You will use a push button on the CoolRunner-II CPLD starter board ([XC2C256-TQ144](../../Docs/xc2c256_cpld.pdf), [manual](../../Docs/coolrunner-ii_rm.pdf), [schematic](../../Docs/coolrunner-ii_sch.pdf)) as reset device, onboard clock signal with frequency of 10&nbsp;kHz for synchronization, and 7-segment display as output device. You will also use slide switches on the CPLD expansion board ([schematic](../../Docs/cpld_expansion.pdf)) as inputs.

![coolrunner_bin_cnt](../../Images/coolrunner_disp_driver.jpg)


## 1 Preparation tasks (done before the lab at home)

1. See [reference manual](../../Docs/coolrunner-ii_rm.pdf) of the Coolrunner board, find out the connection of 7-segment display, and complete the signal timing to display `03.14` value. Note that the duration of one symbol is 4&nbsp;ms.

    &nbsp;
    ![segment_timing](../../Images/wavedrom_7-segment.png)
    &nbsp;

> The figure above was created in [WaveDrom](https://wavedrom.com/) digital timing diagram online tool. The figure source code is as follows:
>
```javascript
{signal: [
  ['Digit position',
    {name: 'disp_dig_o(3)', wave: 'xx01..01..xx', },
    {name: 'disp_dig_o(2)', wave: 'xx1', },
    {name: 'disp_dig_o(1)', wave: 'xx1', },
    {name: 'disp_dig_o(0)', wave: 'xx1', },
  ],
  ['Seven-segment data',
    {name: 'disp_seg_o',       wave: 'xx33335555xx', data: ['0','3','1','4','0','3','1','4'], },  
    {name: 'A: disp_seg_o(6)', wave: 'xx0.1.0.1.xx', },
    {name: 'B: disp_seg_o(5)', wave: 'xx0',          },
    {name: 'C: disp_seg_o(4)', wave: 'xx0',          },
    {name: 'D: disp_seg_o(3)', wave: 'xx0',          },
    {name: 'E: disp_seg_o(2)', wave: 'xx0',          },
    {name: 'F: disp_seg_o(1)', wave: 'xx0',          },
    {name: 'G: disp_seg_o(0)', wave: 'xx1',          },
  ],
  {name: 'Decimal point', wave: 'xx101..01.xx', },
],
  head: {
    text: '4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms',
  },
}
```

2. See how to make [signal assignments](https://github.com/tomas-fryza/Digital-electronics-1/wiki/Signal-assignments) outside and inside a process. What is the difference between combinational and sequential processes?


## 2 Synchronize Git and create a new folder

1. Open a Linux terminal, change path to your Digital-electronics-1 working directory, and synchronize the contents with GitHub.

2. Create a new folder `Labs/06-display_driver`


## 3 Display driver VHDL code

Multiplexer or MUX is a digital switch. It allows to route binary information from several input lines or sources to one output line or channel.

1. Create a new project in ISE titled `display_driver` for XC2C256-TQ144 CPLD device in location `/home/lab661/Documents/your-name/Digital-electronics-1/Labs/06-display_driver`

2. Create a new VHDL module `driver_7seg` and copy/paste the following code template







------------------------------------------------------------------------
--
-- Driver for seven-segment displays.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------------------
entity driver_7seg is
port (
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    data0_i  : in  std_logic_vector(4-1 downto 0);  -- Input values
    data1_i  : in  std_logic_vector(4-1 downto 0);
    data2_i  : in  std_logic_vector(4-1 downto 0);
    data3_i  : in  std_logic_vector(4-1 downto 0);
    dp_i     : in  std_logic_vector(4-1 downto 0);  -- Decimal points
    
    dp_o     : out std_logic;                       -- Decimal point
    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
);
end entity driver_7seg;

------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of driver_7seg is
    signal s_en  : std_logic;
    signal s_cnt : std_logic_vector(2-1 downto 0) := "00";
    signal s_hex : std_logic_vector(4-1 downto 0);
begin

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity
    CLK_EN_0 : entity work.clock_enable
    generic map (
        g_NPERIOD => x"0028"        -- perioda pre 10khz
    )
    port map (
        clk_i          => clk_i,
        srst_n_i       => srst_n_i,
        clock_enable_o => s_en
    );

    --------------------------------------------------------------------
    Sub-block of hex_to_7seg entity
    HEX_TO_SEG : entity work.hex_to_7seg
    port map (
        hex_i => s_hex,
        seg_o => seg_o
    );

    --------------------------------------------------------------------
    -- p_select_cnt:
    -- Sequential process with synchronous reset and clock enable,
    -- which implements an internal 2-bit counter for multiplexer 
    -- selection bits.
    --------------------------------------------------------------------
    p_select_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                s_cnt <= (others => '0');
            elsif s_en = '1' then
                s_cnt <= s_cnt + 1;
            end if;
        end if;
    end process p_select_cnt;

    --------------------------------------------------------------------
    -- p_mux:
    -- Combinational process which implements a 4-to-1 mux.
    --------------------------------------------------------------------
    p_mux : process (s_cnt, data0_i, data1_i, data2_i, data3_i, dp_i)
    begin
        case s_cnt is
        when "00" =>
            s_hex <= data0_i;
            dp_o  <= dp_i(0);
            dig_o <= "1110";
        when "01" =>
            s_hex <= data1_i;
            dp_o  <= dp_i(1);
            dig_o <= "1101";
        when "10" =>
            s_hex <= data2_i;
            dp_o  <= dp_i(2);
            dig_o <= "1011";
        when others =>
            s_hex <= data3_i;
            dp_o  <= dp_i(3);
            dig_o <= "0111";
        end case;
    end process p_mux;


end architecture Behavioral;

2. Connect seven-segment driver and implement it on the Coolrunner-II board. Use slide switches on the CPLD expansion board as data inputs and display the values on the 7-segment display. Connect the reset to BTN0 push button and make sure the 10kHz clock frequency is selected by JP1 jumper. Copy Coolrunner and Expansion UCF files to the working folder. Add these files to the project.



## Experiments on your own

1. On your smartphone, set slow motion video recording and observe the seven-segment display behavior. :)

2. Display 4-bit input values with green and red LEDs on the CPLD expansion board.

3. Display digit position value with LEDs on the Coolrunner board.

4. Extend the duration of one symbol on the 7-segment display (ie. generic `g_NPERIOD` in `driver_7seg.vhd` file) and experimentally determine the maximum value at which switching by the human eye is not yet observable.

5. Complete your `README.md` file with notes and screenshots from simulation and implementation
