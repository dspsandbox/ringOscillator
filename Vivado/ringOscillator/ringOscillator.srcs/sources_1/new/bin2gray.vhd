----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Pau Gomez
-- 
-- Create Date: 28.04.2020 16:58:37
-- Design Name: 
-- Module Name: bin2gray - Behavioral
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

entity bin2gray is
    Generic(LOG2_PORT_WIDTH : integer := 5);
    Port (clk : in STD_LOGIC;
          bin : in STD_LOGIC_VECTOR(2**LOG2_PORT_WIDTH - 1 downto 0);
          gray : out STD_LOGIC_VECTOR(2**LOG2_PORT_WIDTH - 1 downto 0)
         );
end bin2gray;

architecture Behavioral of bin2gray is
signal dataIn : unsigned(2**LOG2_PORT_WIDTH - 1 downto 0):= (others=> '0');
signal dataOut : unsigned(2**LOG2_PORT_WIDTH - 1 downto 0):= (others=> '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            dataIn <= unsigned(bin);
            for i in 0 to dataIn'length-1 loop
                dataOut(i) <= dataIn(i) xor  shift_right(dataIn,1)(i);
            end loop;
        end if;
    end process;
gray<=std_logic_vector(dataOut);
end Behavioral;
