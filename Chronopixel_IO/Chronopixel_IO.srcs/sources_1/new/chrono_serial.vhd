----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Elena Zhivun <zhivun@gmail.com>
-- 
-- Create Date: 03/04/2019 06:14:54 PM
-- Design Name: 
-- Module Name: chrono_serial - rtl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--         This module interfaces the chronopixel, reads and
--  generates the waveforms. Select the waveform with opcode,
--  start the transmission by setting start to '1'. Once the
--  transmission is complete, ready = '1' and the data is in
--  'recv_data' (if opcode = op_drdtst).
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- must wait at least 1 clock cycle between 'ready' raised and setting start <= '1'
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

library work;
use work.interfaces.all;

entity chrono_serial is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    i_chrono : in t_from_chronopixel;
    o_chrono : out t_to_chronopixel;
    i_serial : in t_to_serial;
    o_serial : out t_from_serial        
  ); 
end chrono_serial;

architecture rtl of chrono_serial is
  -- if you change std_logic into a std_logic_vector in these constant definitions
  -- you also need to update the s_start logic
  -- these waveforms are legacy, they are not optimal and need to be reconsidered 
  
  -- calib4 waveform definition                          0    5    10   15   20   25   30   35
  constant calib4_CKA : std_logic_vector(0 to 39)    := "0000000000000000000011111110000000000000";
  constant calib4_CKC : std_logic_vector(0 to 39)    := "0000000000000000000011111110000000000000";
  constant calib4_CALCLK : std_logic_vector(0 to 39) := "0000000011111110000000000000000000000000";
  constant calib4_TIN : std_logic_vector(0 to 39)    := "0000011110000000000011100000000000111100";
  constant calib4_TNIN : std_logic_vector(0 to 39)   := "1111000000111110000000011110000000000000";
  constant calib4_PDRST : std_logic_vector(0 to 39)  := "1100000000000000000000000000000000000000";
  constant calib4_Vth : std_logic := '1';
  constant calib4_SET : std_logic := '0';
  constant calib4_CKB : std_logic := '0';
  constant calib4_RdParLd : std_logic := '0';
  constant calib4_RdClk : std_logic := '0';
  constant calib4_RAdrValid : std_logic := '0';
  constant calib4_Hit_imlar : std_logic := '0';
  constant calib4_inc_tstmp : std_logic := '0';
  constant calib4_reading_d : std_logic := '0';
  constant calib4_incCntr : std_logic := '0';
  constant calib4_wrchrdat : std_logic := '0';
  constant calib4_len : integer := 40;

  -- calin4 waveform definition
  constant calin4_CKA : std_logic := '0';
  constant calin4_CKB : std_logic := '0';
  constant calin4_CKC : std_logic := '1';
  constant calin4_CALCLK : std_logic := '1';
  constant calin4_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant calin4_TNIN : std_logic_vector(0 to 39) := calib4_TNIN;
  constant calin4_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant calin4_SET : std_logic := '0';
  constant calin4_RdParLd : std_logic := '0';
  constant calin4_RdClk : std_logic := '0';
  constant calin4_RAdrValid : std_logic := '0';
  constant calin4_Vth : std_logic := '1';
  constant calin4_Hit_imlar : std_logic := '0';
  constant calin4_inc_tstmp : std_logic := '0';
  constant calin4_reading_d : std_logic := '0';
  constant calin4_incCntr : std_logic := '0';
  constant calin4_wrchrdat : std_logic := '0';
  constant calin4_len : integer := 40;
  
  -- mrst4 waveform definition    
  constant mrst4_CKA : std_logic_vector(0 to 39) := calib4_CKA;
  constant mrst4_CKB : std_logic := '0';
  constant mrst4_CKC : std_logic := '0';
  constant mrst4_CALCLK : std_logic := '0'; --          0    5    10   15   20   25   30   35
  constant mrst4_TIN : std_logic_vector(0 to 39)    := "0000011110000000000011100000000000001111";
  constant mrst4_SET : std_logic_vector(0 to 39)    := "1111100000000000000000000000000000000000";
  constant mrst4_PDRST : std_logic_vector(0 to 39)  := calib4_PDRST;
  constant mrst4_TNIN : std_logic_vector(0 to 39)  := calib4_TNIN;
  constant mrst4_Hit_imlar : std_logic_vector(0 to 39) := (39 => '0', others => '1');
  constant mrst4_RdParLd : std_logic := '0';
  constant mrst4_RdClk : std_logic := '0';
  constant mrst4_RAdrValid : std_logic := '0';
  constant mrst4_Vth : std_logic := '1';
  constant mrst4_inc_tstmp : std_logic := '0';
  constant mrst4_reading_d : std_logic := '0';
  constant mrst4_incCntr : std_logic := '0';
  constant mrst4_wrchrdat : std_logic := '0';
  constant mrst4_len : integer := 40;
  
  -- wrtsig waveform definition
  constant wrtsig_CKA : std_logic_vector(0 to 39) := calib4_CKA;
  constant wrtsig_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant wrtsig_TNIN : std_logic_vector(0 to 39) := calib4_TNIN;
  constant wrtsig_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant wrtsig_Vth : std_logic := '0';
  -- assuming here that wires not mentioned in spec are tied to GND
  constant wrtsig_CKB : std_logic := '0';
  constant wrtsig_CKC : std_logic := '0';
  constant wrtsig_CALCLK : std_logic := '0';
  constant wrtsig_SET : std_logic := '0';
  constant wrtsig_RdParLd : std_logic := '0';
  constant wrtsig_RdClk : std_logic := '0';
  constant wrtsig_RAdrValid : std_logic := '0';
  constant wrtsig_Hit_imlar : std_logic := '0';
  constant wrtsig_inc_tstmp : std_logic := '0';
  constant wrtsig_reading_d : std_logic := '0';
  constant wrtsig_incCntr : std_logic := '0';
  constant wrtsig_wrchrdat : std_logic := '0';
  constant wrtsig_len : integer := 40;
  
  -- idle4 waveform definition
  constant idle4_CKA : std_logic := '0';
  constant idle4_CKB : std_logic := '0';
  constant idle4_CKC : std_logic := '0';
  constant idle4_CALCLK : std_logic := '0';
  constant idle4_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant idle4_TNIN : std_logic_vector(0 to 39) := calib4_TNIN;
  constant idle4_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant idle4_Vth : std_logic := '0';
  constant idle4_SET : std_logic := '0';
  constant idle4_RdParLd : std_logic := '0';
  constant idle4_RdClk : std_logic := '0';
  constant idle4_RAdrValid : std_logic := '0';
  constant idle4_Hit_imlar : std_logic := '0';
  constant idle4_inc_tstmp : std_logic := '0';
  constant idle4_reading_d : std_logic := '0';
  constant idle4_incCntr : std_logic := '0';
  constant idle4_wrchrdat : std_logic := '0';
  constant idle4_len : integer := 40;
  
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
  constant drdtst_RAdrValid : std_logic_vector (0 to 129) := "0000000111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  -- determines when the data is latched (12 bit total)        0    5    10   15   20   25   30   35   40   45   50   55   60   65   70   75   80   85   90   95   100  105  110  115  120  125  130
  constant drdtst_latch : std_logic_vector (0 to 129)      := "0000000000000000000000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000100000000000000000";
  constant drdtst_incCntr : std_logic_vector (0 to 129)    := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000";
  constant drdtst_wrchrdat : std_logic_vector (0 to 129)   := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000";
  constant drdtst_SET : std_logic := '0'; -- not specified, assuming zero
  constant drdtst_len : integer := 130;  
   
  -- trancseiver states
  type t_trcv_state is (
    s_init,   -- initialize the FSM variables
    s_idle,  -- wait for transmission
    s_start,  -- start the transmission
    s_trcv, -- transmit & receive data
    s_done    -- done with data
  );
  signal trcv_state : t_trcv_state := s_init;  
 
  -- reads '1' when chronopixel data needs to be latched
  signal trcv_latch : std_logic := '0';
  
  -- output buffers for the signals (130 bit shift registers)
  constant buf_max_len : integer := 130; 
  signal CKA_buf, CKB_buf, CKC_buf, CALCLK_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
  signal TIN_buf, TNIN_buf, PDRST_buf, RdParLd_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
  signal RdClk_buf, RAdrValid_buf, SET_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
  signal Hit_imlar_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
  -- internal state buffers 
  signal latch_buf : std_logic_vector (0 to (buf_max_len-1)) := (others => '0');
    
  -- bit counter for output buffers 
  signal send_bits_left : unsigned ((recv_ctr_len-1) downto 0) := (others => '0');
  
  -- data in buffer (12 bit shift register, big-endian order)
  signal recv_buf : std_logic_vector ((recv_buf_len-1) downto 0) := (others => '0');


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
          if (i_serial.start = '1') then
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
          
        -- unknown state, should never happen
        when others =>          
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
        o_serial.recv_data <= (others => '0');
        recv_buf <= (others => '0');
        o_serial.ready <= '0';
        trcv_latch <= '0';
        send_bits_left <= (others => '0');   
        o_serial.error <= '0';
        o_chrono.cka <= '0';
        o_chrono.ckb <= '0';
        o_chrono.ckc <= '0';
        o_chrono.calclk <= '0';
        o_chrono.tin <= '0';
        o_chrono.tnin <= '0';
        o_chrono.pdrst <= '0';
        o_chrono.set <= '0';
        o_chrono.RdParLd <= '0';
        o_chrono.RdClk <= '0';
        o_chrono.RAdrValid <= '0'; 
        o_chrono.Vth <= '0';
        o_chrono.Hit_imlar <= '0';
        
    when s_idle =>
    when s_start =>
      o_serial.ready <= '0';      
      recv_buf <= (others => '0');
      trcv_latch <= '0';      
      
      -- load the correct data into the buffer registers
      -- for each selected operation
      case i_serial.opcode is
      when op_idle4 =>
        send_bits_left <= to_unsigned(idle4_len, recv_ctr_len);
        CKA_buf <= (others => idle4_CKA);
        CKB_buf <= (others => idle4_CKB);
        CKC_buf <= (others => idle4_CKC);
        CALCLK_buf <= (others => idle4_CALCLK);
        for i in 0 to idle4_len-1 loop
          TIN_buf(i) <= idle4_TIN(i);
          TNIN_buf(i) <= idle4_TNIN(i);
          PDRST_buf(i) <= idle4_PDRST(i);
        end loop;
        RdParLd_buf <= (others => idle4_RdParLd);
        RdClk_buf <= (others => idle4_RdClk); 
        RAdrValid_buf <= (others => idle4_RAdrValid);
        SET_buf <= (others => idle4_set);        
        latch_buf <= (others => '0');
        Hit_imlar_buf <= (others => idle4_Hit_imlar);     
        o_chrono.Vth <= idle4_Vth;        
        
      when op_calin4 =>
        send_bits_left <= to_unsigned(calin4_len, recv_ctr_len);
        CKA_buf <= (others => calin4_CKA);
        CKB_buf <= (others => calin4_CKB);
        CKC_buf <= (others => calin4_CKC);
        CALCLK_buf <= (others => calin4_CALCLK);
        for i in 0 to calin4_len-1 loop
          TIN_buf(i) <= calin4_TIN(i);
          TNIN_buf(i) <= calin4_TNIN(i);
          PDRST_buf(i) <= calin4_PDRST(i);
        end loop;
        RdParLd_buf <= (others => calin4_RdParLd);
        RdClk_buf <= (others => calin4_RdClk); 
        RAdrValid_buf <= (others => calin4_RAdrValid);
        SET_buf <= (others => calin4_set);        
        latch_buf <= (others => '0');
        Hit_imlar_buf <= (others => calin4_Hit_imlar); 
        o_chrono.Vth <= calin4_Vth;
        
      when op_calib4 =>        
        send_bits_left <= to_unsigned(calib4_len, recv_ctr_len);
        for i in 0 to calib4_len-1 loop
          CKA_buf(i) <= calib4_CKA(i);          
          CKC_buf(i) <= calib4_CKC(i);
          CALCLK_buf(i) <= calib4_CALCLK(i);
          TIN_buf(i) <= calib4_TIN(i);
          TNIN_buf(i) <= calib4_TNIN(i);
          PDRST_buf(i) <= calib4_PDRST(i);
        end loop;
        CKB_buf <= (others => calib4_CKB);
        RdParLd_buf <= (others => calib4_RdParLd);
        RdClk_buf <= (others => calib4_RdClk); 
        RAdrValid_buf <= (others => calib4_RAdrValid);
        SET_buf <= (others => calib4_set);        
        latch_buf <= (others => '0');
        Hit_imlar_buf <= (others => calib4_Hit_imlar); 
        o_chrono.Vth <= calib4_Vth;
        
      when op_mrst4 =>
        send_bits_left <= to_unsigned(mrst4_len, recv_ctr_len);
        for i in 0 to mrst4_len-1 loop
          CKA_buf(i) <= mrst4_CKA(i);                              
          TIN_buf(i) <= mrst4_TIN(i);
          TNIN_buf(i) <= mrst4_TNIN(i);
          PDRST_buf(i) <= mrst4_PDRST(i);
          SET_buf(i) <= mrst4_set(i);
          Hit_imlar_buf(i) <= mrst4_Hit_imlar(i);
        end loop;
        CKB_buf <= (others => mrst4_CKB);
        CALCLK_buf <= (others => mrst4_CALCLK);
        CKC_buf <= (others => mrst4_CKC);
        RdParLd_buf <= (others => mrst4_RdParLd);
        RdClk_buf <= (others => mrst4_RdClk); 
        RAdrValid_buf <= (others => mrst4_RAdrValid);               
        latch_buf <= (others => '0');         
        o_chrono.Vth <= mrst4_Vth;

        
      when op_wrtsig =>
        send_bits_left <= to_unsigned(wrtsig_len, recv_ctr_len);
        for i in 0 to wrtsig_len-1 loop
          CKA_buf(i) <= wrtsig_CKA(i);                              
          TIN_buf(i) <= wrtsig_TIN(i);
          TNIN_buf(i) <= wrtsig_TNIN(i);
          PDRST_buf(i) <= wrtsig_PDRST(i);          
        end loop;
        SET_buf <= (others => wrtsig_SET);
        CKB_buf <= (others => wrtsig_CKB);
        CALCLK_buf <= (others => wrtsig_CALCLK);
        CKC_buf <= (others => wrtsig_CKC);
        RdParLd_buf <= (others => wrtsig_RdParLd);
        RdClk_buf <= (others => wrtsig_RdClk); 
        RAdrValid_buf <= (others => wrtsig_RAdrValid);               
        latch_buf <= (others => '0');
        Hit_imlar_buf <= (others => wrtsig_Hit_imlar);
        o_chrono.Vth <= wrtsig_Vth;
        
      when op_drdtst =>
        send_bits_left <= to_unsigned(drdtst_len, recv_ctr_len);
        for i in 0 to drdtst_len-1 loop                       
          TIN_buf(i) <= drdtst_TIN(i);
          TNIN_buf(i) <= drdtst_TNIN(i);          
          RdParLd_buf(i) <= drdtst_RdParLd(i);
          RdClk_buf(i) <= drdtst_RdClk(i); 
          RAdrValid_buf(i) <= drdtst_RAdrValid(i);  
          latch_buf(i) <= drdtst_latch(i);
        end loop;
        SET_buf <= (others => drdtst_SET);
        CKB_buf <= (others => drdtst_CKB);
        CKA_buf <= (others => drdtst_CKA);
        CALCLK_buf <= (others => drdtst_CALCLK);
        CKC_buf <= (others => drdtst_CKC);
        PDRST_buf <= (others => drdtst_PDRST);
        Hit_imlar_buf <= (others => drdtst_Hit_imlar);
        o_chrono.Vth <= drdtst_Vth;
        
      -- unknown operation, don't send anything
      when others =>        
        send_bits_left <= (others => '0');
        SET_buf <= (others => '0');
        CKB_buf <= (others => '0');
        CKA_buf <= (others => '0');
        CALCLK_buf <= (others => '0');
        CKC_buf <= (others => '0');
        PDRST_buf <= (others => '0');
        TIN_buf <= (others => '0');
        TNIN_buf <= (others => '0');          
        RdParLd_buf <= (others => '0');
        RdClk_buf <= (others => '0'); 
        RAdrValid_buf <= (others => '0');  
        latch_buf <= (others => '0');
        Hit_imlar_buf <= (others => '0');
        o_chrono.Vth <= '0';
        o_serial.error <= '1';
      end case;
      
    -- clock out the data and update the counter
    when s_trcv =>      
      send_bits_left <= send_bits_left - 1;
      trcv_latch <= latch_buf(0);
      
      -- place the data on the data lines
      o_chrono.cka <= CKA_buf(0);
      o_chrono.ckb <= CKB_buf(0);
      o_chrono.ckc <= CKC_buf(0);
      o_chrono.calclk <= CALCLK_buf(0);
      o_chrono.tin <= TIN_buf(0);
      o_chrono.tnin <= TNIN_buf(0);
      o_chrono.pdrst <= PDRST_buf(0);
      o_chrono.set <= SET_buf(0);
      o_chrono.RdParLd <= RdParLd_buf(0);
      o_chrono.RdClk <= RdClk_buf(0);
      o_chrono.RAdrValid <= RAdrValid_buf(0);
      o_chrono.Hit_imlar <= Hit_imlar_buf(0);
   
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
      Hit_imlar_buf(0 to (buf_max_len-2)) <= Hit_imlar_buf(1 to (buf_max_len-1));
      -- internal state registers
      latch_buf(0 to (buf_max_len-2)) <= latch_buf(1 to (buf_max_len-1));

      -- read in chronopixel data
      if (trcv_latch = '1') then
        recv_buf((recv_buf_len-1) downto 1) <= recv_buf((recv_buf_len-2) downto 0);
        recv_buf(0) <= i_chrono.Rd_out;
      end if;

      -- data transmission complete, output the received data
      when s_done =>        
        o_serial.ready <= '1';
        o_serial.recv_data <= recv_buf;
        
      -- unknown state, should never happen        
      when others =>
        o_serial.error <= '1';
      end case;
    end if;
  end process;

end rtl;
