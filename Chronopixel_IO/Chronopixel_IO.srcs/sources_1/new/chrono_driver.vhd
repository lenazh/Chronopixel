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
           inc_tstmp : out STD_LOGIC;
           reading_d : out STD_LOGIC;
           incCntr : out STD_LOGIC;
           wrchrdat : out STD_LOGIC;
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
  constant drdtst_latch : std_logic_vector (0 to 129)      := "0000000000000000000000000100000001000000010000000100000001000000010000000100000001000000010000000100000001000000010000000000000000";
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
  
  -- output buffers for the signals (130 bit shift registers)
  signal CKA_buf, CKB_buf, CKC_buf, CALCLK_buf : std_logic_vector (0 to 129) := (others => '0');
  signal TIN_buf, TNIN_buf, PDRST_buf, RdParLd_buf : std_logic_vector (0 to 129) := (others => '0');
  signal RdClk_buf, RAdrValid_buf, SET_buf : std_logic_vector (0 to 129) := (others => '0');
  
  -- internal state buffers 
  signal latch_buf, incCntr_buf, wrchrdat_buf : std_logic_vector (0 to 129) := (others => '0');
    
  -- bit counter for output buffers
  signal send_ctr : unsigned (7 downto 0) := (others => '0');
  
  -- data receiver buffer (12 bit shift register, big-endian order)
  signal recv_buf : std_logic_vector (11 downto 0) := (others => '0');
begin

end rtl;
