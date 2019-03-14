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
use IEEE.NUMERIC_STD.ALL;

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
           fifo_din : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           fifo_wr_en : out STD_LOGIC;
           fifo_rd_rst_busy : in STD_LOGIC;
           chrono_read_enable : in STD_LOGIC; 
           leds : out t_ctrl_leds); 
  end component;
  
  component LFSR is
  generic (
    g_Num_Bits : integer := recv_buf_len
    );
  port (
    i_Clk    : in std_logic;
    i_Enable : in std_logic;
 
    -- Optional Seed Value
    i_Seed_DV   : in std_logic;
    i_Seed_Data : in std_logic_vector(g_Num_Bits-1 downto 0);
     
    o_LFSR_Data : out std_logic_vector(g_Num_Bits-1 downto 0);
    o_LFSR_Done : out std_logic
    );
 end component;

  signal o_chrono_addr : t_chronopixel_addr;
  signal i_chrono : t_from_chronopixel;
  signal fifo_din : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal o_LFSR_Data : STD_LOGIC_VECTOR((recv_buf_len-1) DOWNTO 0);
  signal fifo_wr_en, fifo_rd_rst_busy, chrono_read_enable : STD_LOGIC;
  signal leds : t_ctrl_leds;
  
  signal i_serial : t_to_serial;
  signal o_serial : t_from_serial;
  signal serial_init : std_logic := '1';
  
  signal o_LFSR_Done, i_Seed_DV, lfsr_en, zero : std_logic;

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
    chrono_read_enable => chrono_read_enable,
    leds => leds
  );
  
  lfsr_inst : LFSR
  port map (
    i_Clk => clk,
    i_Enable => lfsr_en,
    i_Seed_DV => i_Seed_DV,
    i_Seed_Data => "001110111110",     
    o_LFSR_Data => o_LFSR_Data,
    o_LFSR_Done => o_LFSR_Done
  );
  
  lfsr_en <= i_serial.start or i_Seed_DV;
  o_serial.recv_data <= (others => '0') when (zero = '1') else o_LFSR_Data;
  
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
    zero <= '0';
    i_chrono.Rd_out <= '0';
    o_serial.error <= '0';
    fifo_rd_rst_busy <= '0';
    chrono_read_enable <= '1';
    rst <= '0';
    i_Seed_DV <= '1';
    wait for 10 ns;
    i_Seed_DV <= '0';
    
    wait for 250 us;
    zero <= '1';
    wait for 10 us;
    zero <= '0';
    wait for 1 ms;
  end process;

end Behavioral;
