library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity Echo_Analyser is
    Port ( clk : in STD_LOGIC;
           echo_signal : in STD_LOGIC;
           Distance_out : out STD_LOGIC_VECTOR(9 downto 0) ); -- 10-bit output
end Echo_Analyser;

architecture Behavioral of Echo_Analyser is
    signal counter: unsigned(9 downto 0) := (others => '0'); -- 10-bit counter
    signal pulse_active: std_logic := '0'; -- Indicates when the echo signal pulse is being measured
    signal echo_signal_prev: std_logic:= '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            echo_signal_prev <= echo_signal;
            
            if echo_signal = '1' and pulse_active = '0' then
                -- Start of new echo pulse
                counter <= (others => '0');  -- Reset counter at the pulse's rising edge
                pulse_active <= '1';
            elsif echo_signal = '1' and pulse_active = '1' then
                -- Continue counting the duration of the pulse
                counter <= counter + 1;
            elsif echo_signal = '0' and pulse_active = '1' then
                -- End of echo pulse
                pulse_active <= '0';
            end if;
        end if;
    end process;

    -- Output the counter value when not actively measuring a pulse
    Distance_out <= std_logic_vector(counter) when pulse_active = '0' else
                      (others => '0'); -- Reset output when measuring to avoid confusion
end Behavioral;
