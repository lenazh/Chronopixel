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
--  Port ( ); 
end serial_tb;

architecture Behavioral of serial_tb is

  component chrono_serial is
    Port ( 
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      i_chrono : in t_from_chronopixel;
      o_chrono : out t_to_chronopixel;
      i_serial : in t_to_serial;
      o_serial : out t_from_serial  
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
    i_serial.opcode => driver_opcode,
    i_serial.start => driver_start,
    o_serial.ready => driver_ready,
    o_serial.error => driver_error,
    o_serial.recv_data => recv_data
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
    --rst <= '1';
    --driver_start <= '0';
    --wait for 10 ns;    
    rst <= '0';
    driver_start <= '0';
    i_chrono.Rd_out <= '0';
    wait for 10 ns;
    
    -- initiate idle4 sequence        
    driver_opcode <= op_idle4;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';
    wait until driver_ready = '1';
    wait for 10 ns;
    
    -- initiate op_calin4 sequence        
    driver_opcode <= op_calin4;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';    
    wait until driver_ready = '1';
    wait for 10 ns;
    
    -- initiate op_calib4 sequence        
    driver_opcode <= op_calib4;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';
    wait until driver_ready = '1';
    wait for 10 ns;
    
    -- initiate op_mrst4 sequence        
    driver_opcode <= op_mrst4;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';
    wait until driver_ready = '1';
    wait for 10 ns;
    
    -- initiate op_wrtsig sequence        
    driver_opcode <= op_wrtsig;
    driver_start <= '1';
    wait for 10 ns;
    driver_start <= '0';
    wait until driver_ready = '1';
    wait for 10 ns;
    
    -- initiate op_drdtst sequence        
    driver_opcode <= op_drdtst;
    driver_start <= '1';    
    wait for 10 ns;
    driver_start <= '0';
    -- recv_data should read 100110111000
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '1';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '0';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '0';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '1';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '1';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '0';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '1';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '1';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '1';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '0';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '0';
    wait until falling_edge(o_chrono.RdClk);
    i_chrono.Rd_out <= '0';
    wait until driver_ready = '1';
    assert (recv_data = "100110111000") report "recv_data is wrong" severity failure;
    wait for 10 ns;
    
  end process;

end Behavioral;
