----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Elena Zhivun <zhivun@gmail.com>
-- 
-- Create Date: 03/06/2019 06:45:15 PM
-- Design Name: 
-- Module Name: interfaces - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package interfaces is
  -- chronopixel data size
  constant recv_buf_len : integer := 12;
  
  -- chronopixel driver bit counter size
  constant recv_ctr_len : integer := 8;  
  
  -- wires going to Chronopixel
  type t_to_chronopixel is record -- driven by chrono_driver
    cka : STD_LOGIC;
    ckb : STD_LOGIC;
    ckc : STD_LOGIC;
    calclk : STD_LOGIC;
    tin : STD_LOGIC;
    tnin : STD_LOGIC;
    pdrst : STD_LOGIC;
    set : STD_LOGIC;
    RdParLd : STD_LOGIC;
    RdClk : STD_LOGIC;
    RAdrValid : STD_LOGIC;
    Vth : STD_LOGIC;
    Hit_imlar : STD_LOGIC;
    inc_tstmp : STD_LOGIC;  -- TODO is it really needed?
    reading_d : STD_LOGIC;  -- TODO is it really needed?
    incCntr : STD_LOGIC;    -- TODO is it really needed?
    wrchrdat : STD_LOGIC;   -- TODO is it really needed?    
  end record t_to_chronopixel;
  
  constant TSCNT_len : integer := 12;
  constant chrono_addr_len : integer := 6;
  type t_chronopixel_addr is record -- driven by chrono_controller
    TSCNT : STD_LOGIC_VECTOR ( (TSCNT_len-1) downto 0 ); -- TODO bit ordering not in specs, might be reverse
    RADR : STD_LOGIC_VECTOR ( (chrono_addr_len-1) downto 0 );   -- TODO bit ordering not in specs, might be reverse 
    ColAdr : STD_LOGIC_VECTOR ( (chrono_addr_len-1) downto 0 ); -- TODO bit ordering not in specs, might be reverse
  end record t_chronopixel_addr;
  
  -- which sequence to send
  type t_driver_op is (op_idle4, op_calin4, op_calib4, op_mrst4, op_wrtsig, op_drdtst);
  
  -- wires coming from Chronopixel
  type t_from_chronopixel is record
    Rd_out : STD_LOGIC;
  end record t_from_chronopixel;
  
  -- controller LED indicators
  type t_ctrl_leds is record
    err, idle4, calin4, calib4, mrst, wrtsig, drdtst  : std_logic;
  end record t_ctrl_leds;
  
end package interfaces;

-- package body interfaces is
-- end package body interfaces;
