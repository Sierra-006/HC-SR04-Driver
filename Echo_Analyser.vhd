library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Echo_Analyser is
    Port (
        clk : in STD_LOGIC;
        nreset : in STD_LOGIC; -- Active-low reset
        echo_signal : in STD_LOGIC;
        Distance_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
end Echo_Analyser;

architecture Behavioral of Echo_Analyser is
    signal counter : unsigned(9 downto 0) := (others => '0');
    signal pulse_active : std_logic := '0';
    signal echo_signal_prev : std_logic := '0';
begin
    process (clk, nreset)
    begin
        if nreset = '0' then
            counter <= (others => '0');
            pulse_active <= '0';
        elsif rising_edge(clk) then
            echo_signal_prev <= echo_signal;

            if (echo_signal = '1' and echo_signal_prev = '0') then
                counter <= (others => '0');
                pulse_active <= '1';
            elsif (echo_signal = '0' and echo_signal_prev = '1') then
                pulse_active <= '0';
            elsif pulse_active = '1' then
                counter <= counter + 1;
            end if;
        end if;
    end process;
    Distance_out <= std_logic_vector(counter) when pulse_active = '0' else (others => '0');
end Behavioral;
