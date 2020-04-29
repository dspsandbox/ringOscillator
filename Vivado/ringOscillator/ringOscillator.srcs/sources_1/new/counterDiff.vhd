----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2020 18:09:39
-- Design Name: 
-- Module Name: counterDiff - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counterDiff is
    Generic(PORT_WIDTH : integer := 32);
    Port ( clk : in STD_LOGIC;
           counter : in STD_LOGIC_VECTOR(PORT_WIDTH - 1 downto 0);
           maxIntegrationCycles : in STD_LOGIC_VECTOR(PORT_WIDTH - 1 downto 0);
           diff : out STD_LOGIC_VECTOR(PORT_WIDTH - 1 downto 0)
         );
end counterDiff;

architecture Behavioral of counterDiff is
signal counterOld : unsigned(PORT_WIDTH - 1 downto 0) := (others => '0');
signal integrationCycles : unsigned(PORT_WIDTH - 1 downto 0) := (others => '0');
signal diffReg : unsigned(PORT_WIDTH - 1 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if integrationCycles >= unsigned(maxIntegrationCycles) then
                integrationCycles <= (others=>'0');
                diffReg <= unsigned(counter) - counterOld;
                counterOld <= unsigned(counter); 
            else
                integrationCycles <= integrationCycles + 1;
            end if;
        end if;
    end process;
    
    diff <= std_logic_vector(diffReg);
end Behavioral;
