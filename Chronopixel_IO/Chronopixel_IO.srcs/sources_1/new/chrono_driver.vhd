----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Elena Zhivun
-- 
-- Create Date: 03/04/2019 06:14:54 PM
-- Design Name: 
-- Module Name: chrono_driver - rtl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This module interfaces the chronopixel and generates the waveforms
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

entity chrono_driver is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cka : out STD_LOGIC;
           ckb : out STD_LOGIC;
           ckc : out STD_LOGIC;
           calclk : out STD_LOGIC;
           tin : out STD_LOGIC;
           tnin : out STD_LOGIC;
           pdrst : out STD_LOGIC;
           set : out STD_LOGIC;
           RdParLd : out STD_LOGIC;
           RdClk : out STD_LOGIC;
           RAdrValid : out STD_LOGIC;
           Vth : out STD_LOGIC;
           Hit_imlar : out STD_LOGIC;
           inc_tstmp : out STD_LOGIC;  -- is it really needed?
           reading_d : out STD_LOGIC;  -- is it really needed?
           incCntr : out STD_LOGIC;  -- is it really needed?
           wrchrdat : out STD_LOGIC;  -- is it really needed?
           Rd_out : in STD_LOGIC); 
end chrono_driver;

architecture rtl of chrono_driver is
  -- calib4 waveform definition                          0    5    10   15   20   25   30   35
  constant calib4_CKA : std_logic_vector(0 to 39)    := "0000000000000000000011111110000000000000";
  constant calib4_CKC : std_logic_vector(0 to 39)    := "0000000000000000000011111110000000000000";
  constant calib4_CALCLK : std_logic_vector(0 to 39) := "0000000011111110000000000000000000000000";
  constant calib4_TIN : std_logic_vector(0 to 39)    := "0000011110000000000011100000000000111100";
  constant calib4_TNTIN : std_logic_vector(0 to 39)  := "1111000000111110000000011110000000000000";
  constant calib4_PDRST : std_logic_vector(0 to 39)  := "1100000000000000000000000000000000000000";
  constant calib4_Vth : std_logic := '1';
  constant calib4_SET : std_logic := '0';
  constant calib4_CKB : std_logic := '0';
  constant calib4_RdParLd : std_logic := '0';
  constant calib4_RdClk : std_logic := '0';
  constant calib4_RdAdrValid : std_logic := '0';
  constant calib4_Hit_imlar : std_logic := '0';
  constant calib4_inc_tstmp : std_logic := '0';
  constant calib4_reading_d : std_logic := '0';
  constant calib4_incCntr : std_logic := '0';
  constant calib4_wrchrdat : std_logic := '0';

  -- calin4 waveform definition
  constant calin4_CKA : std_logic := '0';
  constant calin4_CKB : std_logic := '0';
  constant calin4_CKC : std_logic := '1';
  constant calin4_CALCLK : std_logic := '1';
  constant calin4_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant calin4_TNTIN : std_logic_vector(0 to 39) := calib4_TNTIN;
  constant calin4_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant calin4_SET : std_logic := '0';
  constant calin4_RdParLd : std_logic := '0';
  constant calin4_RdClk : std_logic := '0';
  constant calin4_RdAdrValid : std_logic := '0';
  constant calin4_Vth : std_logic := '1';
  constant calin4_Hit_imlar : std_logic := '0';
  constant calin4_inc_tstmp : std_logic := '0';
  constant calin4_reading_d : std_logic := '0';
  constant calin4_incCntr : std_logic := '0';
  constant calin4_wrchrdat : std_logic := '0';
  
  -- mrst4 waveform definition    
  constant mrst4_CKA : std_logic_vector(0 to 39) := calib4_CKA;
  constant mrst4_CKB : std_logic := '0';
  constant mrst4_CKC : std_logic := '0';
  constant mrst4_CALCLK : std_logic := '0'; --          0    5    10   15   20   25   30   35
  constant mrst4_TIN : std_logic_vector(0 to 39)    := "0000011110000000000011100000000000001111";
  constant mrst4_SET : std_logic_vector(0 to 39)    := "1111100000000000000000000000000000000000";
  constant mrst4_PDRST : std_logic_vector(0 to 39)  := calib4_PDRST;
  constant mrst4_TNTIN : std_logic_vector(0 to 39)  := calib4_TNTIN;
  constant mrst4_Hit_imlar : std_logic_vector(0 to 39) := (39 => '0', others => '1');
  constant mrst4_RdParLd : std_logic := '0';
  constant mrst4_RdClk : std_logic := '0';
  constant mrst4_RdAdrValid : std_logic := '0';
  constant mrst4_Vth : std_logic := '1';
  constant mrst4_inc_tstmp : std_logic := '0';
  constant mrst4_reading_d : std_logic := '0';
  constant mrst4_incCntr : std_logic := '0';
  constant mrst4_wrchrdat : std_logic := '0';
  
  -- wrtsig waveform definition
  constant wrtsig_CKA : std_logic_vector(0 to 39) := calib4_CKA;
  constant wrtsig_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant wrtsig_TNTIN : std_logic_vector(0 to 39) := calib4_TNTIN;
  constant wrtsig_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant wrtsig_Vth : std_logic := '0';
  -- assuming here that wires not mentioned in spec are tied to GND
  constant wrtsig_CKB : std_logic := '0';
  constant wrtsig_CKC : std_logic := '0';
  constant wrtsig_CALCLK : std_logic := '0';
  constant wrtsig_SET : std_logic := '0';
  constant wrtsig_RdParLd : std_logic := '0';
  constant wrtsig_RdClk : std_logic := '0';
  constant wrtsig_RdAdrValid : std_logic := '0';
  constant wrtsig_Hit_imlar : std_logic := '0';
  constant wrtsig_inc_tstmp : std_logic := '0';
  constant wrtsig_reading_d : std_logic := '0';
  constant wrtsig_incCntr : std_logic := '0';
  constant wrtsig_wrchrdat : std_logic := '0';
  
  -- idle4 waveform definition
  constant idle4_CKA : std_logic := '0';
  constant idle4_CKB : std_logic := '0';
  constant idle4_CKC : std_logic := '0';
  constant idle4_CALCLK : std_logic := '0';
  constant idle4_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant idle4_TNTIN : std_logic_vector(0 to 39) := calib4_TNTIN;
  constant idle4_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant idle4_Vth : std_logic := '0';
  constant idle4_SET : std_logic := '0';
  constant idle4_RdParLd : std_logic := '0';
  constant idle4_RdClk : std_logic := '0';
  constant idle4_RdAdrValid : std_logic := '0';
  constant idle4_Hit_imlar : std_logic := '0';
  constant idle4_inc_tstmp : std_logic := '0';
  constant idle4_reading_d : std_logic := '0';
  constant idle4_incCntr : std_logic := '0';
  constant idle4_wrchrdat : std_logic := '0';
  
  -- drdtst waveform definition -- TODO: convert into an FSM
  constant drdtst_CKA : std_logic := '0';
  constant drdtst_CKB : std_logic := '0';
  constant drdtst_CKC : std_logic := '0';
  constant drdtst_CALCLK : std_logic := '0';
  constant drdtst_PDRST : std_logic := '1';
  constant drdtst_Vth : std_logic := '0';
  constant drdtst_Hit_imlar : std_logic := '0';
  --                                                           0    5    10   15   20   25   30   35   40   45   50   55   60   65   70   75   80   85   90   95   100  105  110  115  120  125  130
  constant drdtst_TIN : std_logic_vector (0 to 129)        := "0000000011110000000000000000000000001111000000000000000000000000111100000000000000000000000011110000000000000000000000001111000000";
  constant drdtst_TNIN : std_logic_vector (0 to 129)       := "1111000000000000000000000000111100000000000000000000000011110000000000000000000000001111000000000000000000000000111100000000000000";
  constant drdtst_RdClk : std_logic_vector (0 to 129)      := "0000000000000111110001111000011110000111100001111000011110000111100001111000011110000111100001111000011110000111100000000000000000";
  constant drdtst_RdParLd : std_logic_vector (0 to 129)    := "0000000000111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  constant drdtst_RdArdValid : std_logic_vector (0 to 129) := "0000000111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  -- determines when the data is latched (12 bit total)        0    5    10   15   20   25   30   35   40   45   50   55   60   65   70   75   80   85   90   95   100  105  110  115  120  125  130
  constant drdtst_latch : std_logic_vector (0 to 129)      := "0000000000000000000000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000000000000000";
  constant drdtst_incCntr : std_logic_vector (0 to 129)    := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000";
  constant drdtst_wrchrdat : std_logic_vector (0 to 129)   := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000";
  -- please note that the incCntr and wrchr pulses here have to be 1 bit long, unlike in the spec waveform sheet
  
  -- Things that are not clear to me:
  --
  -- where are these signals going ?
  --   Hit_imlar, RMEMSEL, RdTstH, Bias_EN, Hit_imsm
  --
  -- Is Chronopixel data presented on rising or falling edge, 
  -- and how long does it take to settle? (assumed rising, affected: drdtst_latch)
 
   
  -- trancseiver states
  type t_trcv_state is (
  s_init,   -- initialize the FSM variables
  s_idle,  -- wait for transmission
  s_start,  -- start the transmission
  s_trcv, -- transmit & receive data
    s_done    -- done with data
 );
 signal trcv_state : t_trcv_state := s_init;
 
 -- received data output
 constant recv_buf_len : integer := 12;
 constant recv_ctr_len : integer := 8;
 signal recv_data : std_logic_vector ((recv_buf_len-1) downto 0) := (others => '0');
 
 -- how many bits send to the Chronopixel
 signal trcv_Nbits_to_send : unsigned ((recv_ctr_len-1) downto 0) := (others => '0');
 
 -- write '1' here to start the transmission
 signal trcv_start : std_logic := '0';
 
 -- reads '1' once the transmission is complete
 signal trcv_rdy : std_logic := '0';
 
 -- reads '1' when chronopixel data needs to be latched
 signal trcv_latch : std_logic := '0';
  
 -- output buffers for the signals (130 bit shift registers)
 constant buf_max_len : integer := 130; 
 signal CKA_buf, CKB_buf, CKC_buf, CALCLK_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
 signal TIN_buf, TNIN_buf, PDRST_buf, RdParLd_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
 signal RdClk_buf, RAdrValid_buf, SET_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
 -- internal state buffers 
 signal latch_buf, incCntr_buf, wrchrdat_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
    
 -- bit counter for output buffers 
 signal send_bits_left : unsigned ((recv_ctr_len-1) downto 0) := (others => '0');
  
 -- data in buffer (12 bit shift register, big-endian order)
 signal recv_buf : std_logic_vector ((recv_buf_len-1) downto 0) := (others => '0');


 -- TODO: are there pulses on imlar ?
 -- trancseiver states
 type t_ctrl_state is (
   s_init,        -- initialize the FSM variables
   s_idle4_start, -- prepare idle4 sequence
   s_idle4_wait,  -- wait for idle4 sequence to finish
   s_calin4_start,
   s_calin4_wait,
   s_calib4_start,
   s_calib4_wait,
   s_mrst_start,
   s_mrst_wait,
   s_wrtsig_start,
   s_wrtsig_wait,
   s_drdtst_start,
   s_drdtst_wait
 );
 signal ctrl_state : t_ctrl_state := s_init;

 -- sequence repetitions left 
 constant ctrl_seq_ctr_len : integer := 12;
 signal ctrl_seq_ctr : unsigned ((ctrl_seq_ctr_len-1) downto 0) := (others => '0');

begin

  -- transceiver state update logic
  process (clk) 
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        trcv_state <= s_init;
      else
        case (trcv_state) is
        when s_init =>
          trcv_state <= s_idle;
        when s_idle =>
          if (trcv_start = '1') then
            trcv_state <= s_start;
          else
            trcv_state <= s_idle;
          end if;
        when s_start =>
          trcv_state <= s_trcv;
        when s_trcv =>
          if (send_bits_left = 0) then
            trcv_state <= s_done;
          else
            trcv_state <= s_trcv;
          end if;
        when s_done =>
          trcv_state <= s_idle;
        when others =>
          -- should never happen
          trcv_state <= s_idle;
        end case;
      end if;
    end if;
  end process; 

  -- transceiver FSM logic
  process (clk) 
  begin
    if rising_edge(clk) then
      case (trcv_state) is
      when s_init =>
        recv_data <= (others => '0');
        recv_buf <= (others => '0');
        trcv_start <= '0';
        trcv_rdy <= '0';
        trcv_latch <= '0';
        send_bits_left <= (others => '0');
    when s_idle =>
    when s_start =>
      trcv_start <= '0';
      trcv_rdy <= '0';
      send_bits_left <= trcv_Nbits_to_send;
      recv_buf <= (others => '0');
      trcv_latch <= '0';
    when s_trcv =>
      -- update the data counter and state
      send_bits_left <= send_bits_left - 1;
      trcv_latch <= latch_buf(0);
      
      -- place the data on the data lines
      cka <= CKA_buf(0);
      ckb <= CKB_buf(0);
      ckc <= CKC_buf(0);
      calclk <= CALCLK_buf(0);
      tin <= TIN_buf(0);
      tnin <= TNIN_buf(0);
      pdrst <= PDRST_buf(0);
      set <= SET_buf(0);
      RdParLd <= RdParLd_buf(0);
      RdClk <= RdClk_buf(0);
      RAdrValid <= RAdrValid_buf(0); 
      incCntr <= incCntr_buf(0);   -- is it really needed?  
      wrchrdat <= wrchrdat_buf(0);  -- is it really needed? 
   
      -- shift registers -- TODO: find a less repetitive way of writing this 
      CKA_buf(0 to (buf_max_len-2)) <= CKA_buf(1 to (buf_max_len-1));      
      CKB_buf(0 to (buf_max_len-2)) <= CKB_buf(1 to (buf_max_len-1));
      CKC_buf(0 to (buf_max_len-2)) <= CKC_buf(1 to (buf_max_len-1));
      CALCLK_buf(0 to (buf_max_len-2)) <= CALCLK_buf(1 to (buf_max_len-1));
      TIN_buf(0 to (buf_max_len-2)) <= TIN_buf(1 to (buf_max_len-1));
      TNIN_buf(0 to (buf_max_len-2)) <= TNIN_buf(1 to (buf_max_len-1));
      PDRST_buf(0 to (buf_max_len-2)) <= PDRST_buf(1 to (buf_max_len-1));
      SET_buf(0 to (buf_max_len-2)) <= SET_buf(1 to (buf_max_len-1));
      RdParLd_buf(0 to (buf_max_len-2)) <= RdParLd_buf(1 to (buf_max_len-1));
      RdClk_buf(0 to (buf_max_len-2)) <= RdClk_buf(1 to (buf_max_len-1));
      RAdrValid_buf(0 to (buf_max_len-2)) <= RAdrValid_buf(1 to (buf_max_len-1));
      -- internal state registers
      latch_buf(0 to (buf_max_len-2)) <= latch_buf(1 to (buf_max_len-1));
      incCntr_buf(0 to (buf_max_len-2)) <= incCntr_buf(1 to (buf_max_len-1)); -- is it really needed?
      wrchrdat_buf(0 to (buf_max_len-2)) <= wrchrdat_buf(1 to (buf_max_len-1)); -- is it really needed?

      -- read in chronopixel data
      if (trcv_latch = '1') then
        recv_buf(1 to (recv_buf_len-1)) <= recv_buf(0 to (recv_buf_len-2));
        recv_buf(0) <= Rd_out;
      else
        recv_buf <= recv_buf;
      end if;

      when s_done =>
        trcv_rdy <= '1';
        recv_data <= recv_buf;
      when others =>
        -- should never happen
      end case;
    end if;
  end process;
  
  -- controller state update logic
  process (clk) 
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        ctrl_state <= s_init;
      else
      case (ctrl_state) is
      when s_init =>
        ctrl_state <= s_idle4_start;
      when s_idle4_start =>
        ctrl_state <= s_idle4_wait; 
      when s_idle4_wait => 
        if (trcv_rdy = '1') then
          if (ctrl_seq_ctr = 0) then
            ctrl_state <= s_calin4_start;
          else
            ctrl_state <= s_idle4_wait;
          end if;
        else
          ctrl_state <= s_idle4_start;
        end if; 

      when s_calin4_start =>
      when s_calin4_wait =>
      when s_calib4_start =>
      when s_calib4_wait =>
      when s_mrst_start =>
      when s_mrst_wait =>
      when s_wrtsig_start =>
      when s_wrtsig_wait =>
      when s_drdtst_start =>
      when s_drdtst_wait =>
      when others =>
        ctrl_state <= s_init;
        -- should never happen
      end case;
      end if;
    end if;
  end process;
  
end rtl;
