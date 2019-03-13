----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2019 09:57:15 PM
-- Design Name: 
-- Module Name: controller_tb - Behavioral
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

library work;
use work.interfaces.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_tb is
--  Port ( );
end controller_tb;

architecture Behavioral of controller_tb is
  signal clk, rst : std_logic;

  component chrono_controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           o_chrono_addr : out t_chronopixel_addr;
           i_serial : out t_to_serial;
           o_serial : in t_from_serial; 
           fifo_din : out STD_LOGIC_VECTOR(11 DOWNTO 0);
           fifo_wr_en : out STD_LOGIC;
           fifo_rd_rst_busy : in STD_LOGIC;
           host_connected : in STD_LOGIC; 
           leds : out t_ctrl_leds); 
  end component;

  signal o_chrono_addr : t_chronopixel_addr;
  signal i_chrono : t_from_chronopixel;
  signal fifo_din : STD_LOGIC_VECTOR(11 DOWNTO 0);
  signal fifo_wr_en, fifo_rd_rst_busy, host_connected : STD_LOGIC;
  signal leds : t_ctrl_leds;
  
  signal i_serial : t_to_serial;
  signal o_serial : t_from_serial;
  signal serial_init : std_logic := '1';

begin

  controller_inst : chrono_controller
  port map(
    clk => clk,
    rst => rst,
    o_chrono_addr => o_chrono_addr,
    i_serial => i_serial,
    o_serial => o_serial,   
    fifo_din => fifo_din,
    fifo_wr_en => fifo_wr_en,
    fifo_rd_rst_busy => fifo_rd_rst_busy,  
    host_connected => host_connected,
    leds => leds
  );
  
  process -- CLK
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;
  
  process -- serial controller mock
  begin
    if (serial_init = '1') then
      serial_init <= '0';
      o_serial.ready <= '0';
    else
      wait until rising_edge(i_serial.start);
      o_serial.ready <= '0';
      wait for 20 ns;
      o_serial.ready <= '1';
    end if;
    wait for 10 ns;
  end process;
  
  process
  begin
    i_chrono.Rd_out <= '0';
    o_serial.error <= '0';
    o_serial.recv_data <= (others => '0');
    fifo_rd_rst_busy <= '0';
    host_connected <= '1';
    rst <= '0';
    wait for 1 ms;
  end process;

end Behavioral;
