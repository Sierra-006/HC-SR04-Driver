library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Constant_Divider is
    Port (
        clk : in  STD_LOGIC;
        reset : in STD_LOGIC;  -- Synchronous reset
        time_us : in  STD_LOGIC_vector (9 downto 0);  -- Integer input value (ToF in microseconds)
        range_cm : out std_logic_vector (7 downto 0)  -- Integer output value (range in centimeters)
    );
end Constant_Divider;

architecture Behavioral of Constant_Divider is
    constant multiplier : integer := 1130;  -- Multiplier equivalent to 1/58
    signal temp_result : integer;  -- Intermediate result for the multiplication
    signal time_int : integer;
    signal range_cm_int : integer;
       
begin

        time_int <= to_integer (unsigned(time_us));

process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                range_cm_int <= 0;  -- Reset output value
            else
                -- Perform the multiplication with constant 1130 and shift right by 16
                temp_result <= time_int * multiplier;  -- Perform the multiplication
                range_cm_int <= temp_result / 65536;  -- Divide by 65536 (right shift by 16)
            end if;
                range_cm <= std_logic_vector(to_unsigned(range_cm_int, range_cm'length));
        end if;
    end process;
end Behavioral;
