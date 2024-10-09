library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Constant_Divider is
    Port (
        clk : in  STD_LOGIC;
        nreset : in STD_LOGIC;
        time_us : in  STD_LOGIC_vector (9 downto 0);
        range_cm : out std_logic_vector (7 downto 0)
    );
end Constant_Divider;

architecture Behavioral of Constant_Divider is
    constant multiplier : integer := 1130;
    signal temp_result : integer;
    signal time_int : integer;
    signal range_cm_int : integer;
begin
    time_int <= to_integer(unsigned(time_us));
    process(clk)
    begin
        if rising_edge(clk) then
            if nreset = '1' then
                range_cm_int <= 0;
            else
                temp_result <= time_int * multiplier;
                range_cm_int <= temp_result / 65536;
            end if;
            range_cm <= std_logic_vector(to_unsigned(range_cm_int, range_cm'length));
        end if;
    end process;
end Behavioral;
