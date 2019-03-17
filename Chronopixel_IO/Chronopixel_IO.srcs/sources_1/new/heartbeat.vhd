----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Elena Zhivun <zhivun@gmail.com>
-- 
-- Create Date: 03/04/2019 04:37:43 PM
-- Design Name: 
-- Module Name: heartbeat - rtl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Blinks LED so you can see if the board works at all
-- 
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

-- When clock is at 5 MHz, 5000000 is 1 second

entity heartbeat is
    generic (counter_max : unsigned(31 downto 0) := to_unsigned(2500000, 32));
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC);
end heartbeat;

architecture rtl of heartbeat is
  signal counter :unsigned(31 downto 0) := (others => '0');
  signal led_reg :std_logic;
begin
  led <= led_reg;

  process (clk)
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        led_reg <= '0';
        counter <= (others => '0');
      else        
        if (counter = counter_max) then
          counter <= (others => '0');
          led_reg <= not(led_reg);
        else
          counter <= counter + 1;
        end if;
      end if;
    end if;
  end process;
end rtl;
