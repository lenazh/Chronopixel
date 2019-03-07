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
  -- wires going to Chronopixel
  type t_to_chronopixel is record
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
    inc_tstmp : STD_LOGIC;  -- is it really needed?
    reading_d : STD_LOGIC;  -- is it really needed?
    incCntr : STD_LOGIC;  -- is it really needed?
    wrchrdat : STD_LOGIC;  -- is it really needed?
  end record t_to_chronopixel;
  
  -- which sequence to send
  type t_driver_op is (op_idle, op_calin4, op_calib4, op_mrst4, op_wrtsig, op_drdtst);
  
  -- wires coming from Chronopixel
  type t_from_chronopixel is record
    Rd_out : STD_LOGIC;
  end record t_from_chronopixel;
  
  -- chronopixel data size
  constant recv_buf_len : integer := 12;
  
  -- chronopixel driver bit counter size
  constant recv_ctr_len : integer := 8;
  
  -- controller LED indicators
  type t_ctrl_leds is record
    err, idle4, calin4, calib4, mrst, wrtsig, drdtst  : std_logic;
  end record t_ctrl_leds;
  
end package interfaces;

-- package body interfaces is
-- end package body interfaces;
