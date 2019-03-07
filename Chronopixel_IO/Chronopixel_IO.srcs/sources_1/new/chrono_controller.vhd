----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Elena Zhivun <zhivun@gmail.com>
-- 
-- Create Date: 03/06/2019 06:56:15 PM
-- Design Name: 
-- Module Name: chrono_controller - Behavioral
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

library work;
use work.interfaces.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chrono_controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           o_chrono : out t_to_chronopixel;
           i_chrono : in t_from_chronopixel;
           leds : out t_ctrl_leds); 
end chrono_controller;


architecture rtl of chrono_controller is
  signal driver_opcode : t_driver_op;
  signal driver_start, driver_ready, driver_error : std_logic;
  signal recv_data : std_logic_vector ((recv_buf_len-1) downto 0);

  component chrono_driver is
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             o_chrono : out t_to_chronopixel;
             i_chrono : in t_from_chronopixel;
             opcode : in t_driver_op;
             start : in std_logic; -- write 1 here to start data transmission
             ready : out std_logic;
             error : out std_logic;
             signal recv_data : out std_logic_vector ((recv_buf_len-1) downto 0) -- chronopixel readout
             ); 
  end component;

 -- TODO: are there pulses on imlar ?
 -- trancseiver states
 type t_ctrl_state is (
   s_init,        -- initialize the FSM variables
   s_idle4_setup, -- prepare the series of idle4 sequences
   s_idle4_start, -- prepare one idle4 sequence
   s_idle4_wait,  -- wait for idle4 sequence to finish
   s_calin4_start,
   s_calin4_wait,
   s_calib4_setup,
   s_calib4_start,
   s_calib4_wait,
   s_mrst_start,
   s_mrst_wait,
   s_wrtsig_setup,
   s_wrtsig_start,
   s_wrtsig_wait,
   s_drdtst_setup,
   s_drdtst_start,
   s_drdtst_wait
 );
 signal ctrl_state : t_ctrl_state := s_init;

 -- sequence repetitions left 
 constant ctrl_seq_ctr_len : integer := 12;
 
 signal ctrl_seq_ctr : unsigned ((ctrl_seq_ctr_len-1) downto 0) := (others => '0');
begin
  -- Instantiate Chronopixel driver
  chrono_driver_inst : chrono_driver
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

  -- controller state update logic
  process (clk) 
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        ctrl_state <= s_init;
      else
      case (ctrl_state) is
      when s_init =>
        ctrl_state <= s_idle4_setup;
      when s_idle4_setup =>
        ctrl_state <= s_idle4_start;
      when s_idle4_start =>
        ctrl_state <= s_idle4_wait;         
      when s_idle4_wait => 
        if (driver_ready = '1') then
          if (ctrl_seq_ctr = 0) then
            ctrl_state <= s_calin4_start;
          else
            ctrl_state <= s_idle4_start;
          end if;
        else
          ctrl_state <= s_idle4_wait;
        end if; 
      when s_calin4_start =>
        ctrl_state <= s_calin4_wait;
      when s_calin4_wait =>
        if (driver_ready = '1') then
          ctrl_state <= s_calib4_setup;
        else
          ctrl_state <= s_calin4_wait;
        end if;
      when s_calib4_setup =>
        ctrl_state <= s_calib4_start;
      when s_calib4_start =>
        ctrl_state <= s_calib4_wait;
      when s_calib4_wait =>
        if (driver_ready = '1') then
          if (ctrl_seq_ctr = 0) then
            ctrl_state <= s_mrst_start;
          else
            ctrl_state <= s_calib4_start;
          end if;
        else
          ctrl_state <= s_calib4_wait;
        end if;       
      when s_mrst_start =>
        ctrl_state <= s_mrst_wait;
      when s_mrst_wait =>
        if (driver_ready = '1') then
          ctrl_state <= s_wrtsig_setup;
        else
          ctrl_state <= s_mrst_wait;
        end if;
      when s_wrtsig_setup =>
        ctrl_state <= s_wrtsig_start;
      when s_wrtsig_start =>
        ctrl_state <= s_wrtsig_wait;
      when s_wrtsig_wait =>
        if (driver_ready = '1') then
          if (ctrl_seq_ctr = 0) then
            ctrl_state <= s_drdtst_setup;
          else
            ctrl_state <= s_wrtsig_start;
          end if;
        else
          ctrl_state <= s_wrtsig_wait;
        end if; 
      when s_drdtst_setup =>
        ctrl_state <= s_drdtst_start;
      when s_drdtst_start =>
        ctrl_state <= s_drdtst_wait;
      when s_drdtst_wait =>
        if (driver_ready = '1') then
          if (ctrl_seq_ctr = 0) then
            ctrl_state <= s_idle4_setup;
          else
            ctrl_state <= s_drdtst_start;
          end if;
        else
          ctrl_state <= s_drdtst_wait;
        end if; 
      when others =>
        ctrl_state <= s_init;
        -- should never happen
      end case;
      end if;
    end if;
  end process;

end rtl;
