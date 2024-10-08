library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity echo_analyserTB is
end echo_analyserTB;

architecture bench of echo_analyserTB is
    -- Component Declaration for the Echo_Analyzer
    component Echo_Analyser
        Port ( clk : in STD_LOGIC;
               echo_signal : in STD_LOGIC;
               Distance_out : out STD_LOGIC_VECTOR(7 downto 0) );
    end component;

    -- Test Bench Signals
    signal clk: STD_LOGIC := '0';
    signal echo_signal: STD_LOGIC := '0';
    signal Distance_out: STD_LOGIC_VECTOR(7 downto 0);

    -- Clock Period Definition
    constant clock_period: time := 10 ns; -- 100 MHz clock

begin
    -- Instantiating the Unit Under Test (UUT)
    uut: Echo_Analyser
        port map (
            clk          => clk,
            echo_signal  => echo_signal,
            Distance_out => Distance_out
        );

    -- Clock Process
    clocking: process
    begin
        while true loop
            clk <= '0';
            wait for clock_period / 2;
            clk <= '1';
            wait for clock_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stimulus: process
    begin
        -- Initial Setup
        echo_signal <= '0';
        wait for 100 ns; -- Waiting for the system to stabilize

        -- Test Case 1: No Echo
        echo_signal <= '0';
        wait for 100 ns;

        -- Test Case 2: Short Echo Pulse
        echo_signal <= '1';
        wait for 10 ns; -- Echo pulse for 10 ns
        echo_signal <= '0';
        wait for 100 ns;

        -- Test Case 3: Longer Echo Pulse
        echo_signal <= '1';
        wait for 50 ns; -- Echo pulse for 50 ns
        echo_signal <= '0';
        wait for 100 ns;

        -- Test Case 4: Maximum Echo Pulse
        echo_signal <= '1';
        wait for 255 * 10 ns; -- Echo pulse for 255 clock cycles
        echo_signal <= '0';
        wait for 100 ns;

        -- End simulation
        wait;
    end process;

end architecture;
