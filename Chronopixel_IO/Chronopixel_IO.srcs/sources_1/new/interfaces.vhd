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

package interfaces is
  -- chronopixel data size
  constant recv_buf_len : integer := 12;
  
  -- chronopixel driver bit counter size
  constant recv_ctr_len : integer := 8;  
  
  -- wires going to Chronopixel
  type t_to_chronopixel is record -- driven by chrono_serial
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
  
  
  -- to serial lines controller
  type t_to_serial is record
    opcode : t_driver_op;
    start : std_logic;
  end record t_to_serial;
  
  -- from serial lines controller
  type t_from_serial is record
    ready : std_logic;
    error : std_logic;
    recv_data : std_logic_vector ((recv_buf_len-1) downto 0); -- chronopixel readout
  end record t_from_serial;
  
  -- wires coming from Chronopixel
  type t_from_chronopixel is record
    Rd_out : STD_LOGIC;
  end record t_from_chronopixel;
  
  -- controller LED indicators
  type t_ctrl_leds is record
    err, err_serial, idle4, calib4, wrtsig, drdtst  : std_logic;
  end record t_ctrl_leds;
  
end package interfaces;

-- package body interfaces is
-- end package body interfaces;
