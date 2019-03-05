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
  constant calib4_CKB : std_logic_vector(0 to 39)    := "0000000000000000000000000000000000000000";
  constant calib4_CKC : std_logic_vector(0 to 39)    := "0000000000000000000011111110000000000000";
  constant calib4_CALCLK : std_logic_vector(0 to 39) := "0000000011111110000000000000000000000000";
  constant calib4_TIN : std_logic_vector(0 to 39)    := "0000011110000000000011100000000000111100";
  constant calib4_TNTIN : std_logic_vector(0 to 39)  := "1111000000111110000000011110000000000000";
  constant calib4_PDRST : std_logic_vector(0 to 39)  := "1100000000000000000000000000000000000000";
  constant calib4_Vth : std_logic := '1';

  -- calin4 waveform definition                          0    5    10   15   20   25   30   35
  constant calin4_CKA : std_logic := '0';
  constant calin4_CKB : std_logic := '0';
  constant calin4_CKC : std_logic := '1';
  constant calin4_CALCLK : std_logic := '1';
  constant calin4_TIN : std_logic_vector(0 to 39) := calib4_TIN;
  constant calin4_TNTIN : std_logic_vector(0 to 39) := calib4_TNTIN;
  constant calin4_PDRST : std_logic_vector(0 to 39) := calib4_PDRST;
  constant calin4_Vth : std_logic := '1';
  
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
  constant mrst4_Vth : std_logic := '1';
  
  -- wrtsig waveform definition
  -- constant wrtsig_CKA : std_logic_vector(0 to 39) := calib4_CKA;
begin

end rtl;
