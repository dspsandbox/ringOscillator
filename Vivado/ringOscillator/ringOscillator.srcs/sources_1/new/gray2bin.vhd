----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Pau Gomez
-- 
-- Create Date: 28.04.2020 17:15:41
-- Design Name: 
-- Module Name: gray2bin - Behavioral
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

entity gray2bin is
    Generic(LOG2_PORT_WIDTH : integer := 5);
    Port (clk : in STD_LOGIC;
          gray : in STD_LOGIC_VECTOR(2**LOG2_PORT_WIDTH - 1 downto 0);
          bin : out STD_LOGIC_VECTOR(2**LOG2_PORT_WIDTH - 1 downto 0)
         );
end gray2bin;

architecture Behavioral of gray2bin is
signal dataIn : unsigned(2**LOG2_PORT_WIDTH - 1 downto 0):= (others=> '0');
signal dataOut : unsigned(2**LOG2_PORT_WIDTH - 1 downto 0):= (others=> '0');

type TYPE_dataProcess is array (0 to LOG2_PORT_WIDTH - 1) of unsigned(2**LOG2_PORT_WIDTH - 1 downto 0);
signal dataProcess : TYPE_dataProcess := (others=>(others=>'0'));

begin
    process(clk)
    begin
        if rising_edge(clk) then
            dataIn <= unsigned(gray);
            
            for j in 0 to dataIn'length - 1 loop
                dataProcess(0)(j) <= dataIn(j) xor shift_right(dataIn,2**0)(j); 
            end loop;
           
            for i in 1 to LOG2_PORT_WIDTH - 1 loop
                for j in 0 to  dataIn'length - 1 loop
                    dataProcess(i)(j) <= dataProcess(i-1)(j) xor shift_right(dataProcess(i-1),2**i)(j); 
                end loop;
            end loop;
        end if;
    end process;
bin<=std_logic_vector(dataProcess(LOG2_PORT_WIDTH - 1));
end Behavioral;
