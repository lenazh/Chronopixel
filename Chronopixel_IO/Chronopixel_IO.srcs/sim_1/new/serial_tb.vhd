----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2019 05:07:23 PM
-- Design Name: 
-- Module Name: serial_tb - Behavioral
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

-- TODO: make sure global RST is issued, or the circuit works w/o global reset

entity serial_tb is    
end serial_tb;

architecture Behavioral of serial_tb is

  component chrono_serial is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           o_chrono : out t_to_chronopixel;
           addr_chrono : out t_chronopixel_addr;
           i_chrono : in t_from_chronopixel;
           opcode : in t_driver_op;
           start : in std_logic; -- write 1 here to start data transmission
           ready : out std_logic;
           error : out std_logic;
           signal recv_data : out std_logic_vector ((recv_buf_len-1) downto 0) -- chronopixel readout
             ); 
  end component;
  
  signal o_chrono: t_to_chronopixel;
  signal i_chrono: t_from_chronopixel;
  signal driver_opcode : t_driver_op;
  signal driver_start, driver_ready, driver_error : std_logic;
  signal recv_data : std_logic_vector ((recv_buf_len-1) downto 0);
  signal clk, rst : std_logic;

begin

-- Instantiate Chronopixel driver
  chrono_serial_inst : chrono_serial
  port map ( 
    clk => clk,
    rst => rst,
    o_chrono => o_chrono,
    i_chrono => i_chrono,
    opcode => driver_opcode,
    start => driver_start,
    ready => driver_ready,
    error => driver_error,
    recv_data => recv_data
  );
  
  process -- CLK
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;
  
  process -- ctrl
  begin
    -- reset the instance
    rst <= '1';
    i_chrono.Rd_out <= '0';
    driver_start <= '0';
    wait for 10 ns;    
    rst <= '0';    
    wait for 10 ns;
    
    -- initiate idle4 sequence        
    driver_opcode <= op_idle4;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';
    wait for 450 ns;
    
    -- initiate op_calin4 sequence        
    driver_opcode <= op_calin4;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';
    wait for 450 ns;
    
  end process;

end Behavioral;