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
use IEEE.NUMERIC_STD.ALL;

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
  
  signal o_chrono: t_to_chronopixel;
  signal i_chrono: t_from_chronopixel := (Rd_out => '0');
  signal driver_opcode : t_driver_op;
  signal driver_start, driver_ready, driver_error : std_logic;
  signal recv_data : std_logic_vector ((recv_buf_len-1) downto 0);
  signal clk, rst, rnd_en : std_logic;
  signal rnd, rnd_reg : std_logic_vector ((recv_buf_len-1) downto 0) := (others => '0');

  signal lfsr_en, i_Seed_DV, o_LFSR_Done : std_logic;
  signal i_Seed_Data, o_LFSR_Data : std_logic_vector(recv_buf_len-1 downto 0);
  signal bit_ctr : unsigned(5 downto 0) := to_unsigned(0, 6);
  constant max_bits : integer := 12;
  
   
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
  
  lfsr_inst : LFSR
  port map (
    i_Clk => clk,
    i_Enable => lfsr_en,
    i_Seed_DV => i_seed_DV,
    i_Seed_Data => i_Seed_Data,     
    o_LFSR_Data => o_LFSR_Data,
    o_LFSR_Done => o_LFSR_Done
  );
  
  i_Seed_Data <= "100110111000";  
  lfsr_en <= '1';
  
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
    i_Seed_DV <= '1';
    driver_start <= '0';    
    rnd_en <= '0';
    i_Seed_DV <= '0';
    rnd <= (others => '0');    
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
    
    -- send 'random' data to the Rd_out line
    rnd <= o_LFSR_data;
    rnd_en <= '1';
    wait until driver_ready = '1';
    rnd_en <= '0';
    assert (recv_data = rnd) report "recv_data is wrong" severity failure;
    wait for 10 ns;    
  end process;
  
  process(o_chrono.RdClk) -- random PD data shift register
  begin    
    if falling_edge(o_chrono.RdClk) then
      if (rnd_en = '1') then
        if (bit_ctr = 0) then
          i_chrono.Rd_out <= rnd(recv_buf_len-1);
          rnd_reg(recv_buf_len-1 downto 1) <= rnd(recv_buf_len-2 downto 0);
        else
          i_chrono.Rd_out <= rnd_reg(recv_buf_len-1);
          rnd_reg(recv_buf_len-1 downto 1) <= rnd_reg(recv_buf_len-2 downto 0);
        end if;
        bit_ctr <= bit_ctr + 1;        
      end if;
    end if;
  end process;

end Behavioral;
