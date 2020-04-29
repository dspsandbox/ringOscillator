----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Pau Gomez
-- 
-- Create Date: 28.04.2020 17:40:30
-- Design Name: 
-- Module Name: sync - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sync is
    Generic(PORT_WIDTH: integer := 32;
            SYNC_STAGES : integer := 2);
            
    Port ( clk : in STD_LOGIC;
           dataIn : in STD_LOGIC_VECTOR(PORT_WIDTH - 1 downto 0);
           dataOut : out STD_LOGIC_VECTOR(PORT_WIDTH - 1 downto 0)
           );
end sync;

architecture Behavioral of sync is
type TYPE_dataRegister is array(0 to SYNC_STAGES) of STD_LOGIC_VECTOR(PORT_WIDTH - 1 downto 0);
signal dataRegister : TYPE_dataRegister := (others=>(others=>'0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            dataRegister(0) <= datain;
            for i in 1 to SYNC_STAGES - 1 loop 
                dataRegister(i) <= dataRegister(i - 1);
            end loop;
        end if;
    end process;
    
    dataOut <= dataRegister(SYNC_STAGES - 1);
end Behavioral;
