library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pulse_Generator is
    Port (
        clk : IN  std_logic;
        nreset : IN std_logic; -- Active-low reset
        trigger : OUT std_logic
    );
end Pulse_Generator;

architecture Behavioral of Pulse_Generator is
    signal counter : integer range 0 to 99 := 0;
    signal pulse_active : std_logic := '0';
begin
    process (clk, nreset)
    begin
        if nreset = '0' then
            counter <= 0;
            pulse_active <= '0';
        elsif rising_edge(clk) then
            if counter < 9 then
                pulse_active <= '1';
            else
                pulse_active <= '0';
            end if;
            
            if counter = 99 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    trigger <= pulse_active;
end Behavioral;
