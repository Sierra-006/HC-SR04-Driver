library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Constant_Divider_tb is
end Constant_Divider_tb;

architecture Behavioral of Constant_Divider_tb is

    component Constant_Divider
        Port (
            clk : in  STD_LOGIC;
            reset : in STD_LOGIC;
            time_us : in  STD_LOGIC_vector (9 downto 0);
            range_cm : out std_logic_vector (7 downto 0)
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal time_us : STD_LOGIC_vector (9 downto 0) := (others => '0');
    signal range_cm : std_logic_vector (7 downto 0);

    constant clk_period : time := 1 us;

begin

    uut: Constant_Divider
        Port map (
            clk => clk,
            reset => reset,
            time_us => time_us,
            range_cm => range_cm
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2; 
            clk <= '1';
            wait for clk_period / 2;  
        end loop;
    end process;

    stim_proc: process
    begin

        reset <= '1';  
        time_us <= (others => '0');
        wait for 2 * clk_period;  

        reset <= '0'; 

        -- Test case 1: time_us = 1000 (1 ms)
        time_us <= std_logic_vector(to_unsigned(1000, 10));
        wait for 5 * clk_period;  
            
        -- Test case 2: time_us = 2000 (2 ms)
        time_us <= std_logic_vector(to_unsigned(2000, 10));
        wait for 5 * clk_period;

        -- Test case 3: time_us = 500 (0.5 ms)
        time_us <= std_logic_vector(to_unsigned(500, 10));
        wait for 5 * clk_period;

        -- Test case 4: time_us = 0
        time_us <= std_logic_vector(to_unsigned(0, 10));
        wait for 5 * clk_period;


        wait;
    end process;

end Behavioral;
