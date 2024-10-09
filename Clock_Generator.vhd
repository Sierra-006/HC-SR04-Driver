library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Clock_Generator is
    Port (
        clk_in : in STD_LOGIC;
        nreset : in STD_LOGIC; -- Active-low reset
        clk_out : out STD_LOGIC
    );
end Clock_Generator;

architecture Behavioral of Clock_Generator is
    signal cntval : integer range 0 to 65;
    signal temp : std_logic;
begin
    process (clk_in, nreset)
    begin
        if nreset = '0' then
            cntval <= 0;
            temp <= '0';
        elsif rising_edge(clk_in) then
            if cntval = 62 then  -- 124 in binary
                temp <= not temp;
                cntval <= 0;
            else
                cntval <= cntval + 1;
            end if;
        end if;
    end process;
    clk_out <= temp;
end Behavioral;
