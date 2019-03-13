-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Fri Mar  1 18:18:15 2019
-- Host        : DESKTOP-OV0R6TO running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode pin_planning -force -port_diff_buffers
--               D:/Users/zhivu/Chronopixel/Chronopixel_vivado/Chronopixel_IO/chronopixel.vhd
-- Design      : chronopixel
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a50tfgg484-1
-- Engineer    : Elena Zhivun <zhivun@gmail.com>
--
-- TODOs indicate that either the implementation wasn't clear from the specs,
--        or that the feature isn't implemented yet
-- TODO:  
-- - There are no timing constraints whatsoever on the chronopixel pins
--   (due to the lack of any docs), this can result in unstable performance 
-- - Nothing is driving rst. Let the USB host issue rst?
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- The following library declaration should be present if 
---- instantiating any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.interfaces.all;

entity chronopixel is
  Port (
  -- On-board oscillator 200 MHz 
    sys_clk_p : in STD_LOGIC;
    sys_clk_n : in STD_LOGIC;
    
  -- Opal Kelly
    hi_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    hi_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    hi_inout : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    led : out STD_LOGIC_VECTOR ( 7 downto 0 );
    hi_muxsel : out STD_LOGIC;
    hi_aa : inout STD_LOGIC;
    
    -- DRAM
    ddr3_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    ddr3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    ddr3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr3_odt : out STD_LOGIC_VECTOR ( 0 downto 0 );
    ddr3_dm : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr3_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr3_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr3_ck_p : out STD_LOGIC_VECTOR ( 0 downto 0 );
    ddr3_ck_n : out STD_LOGIC_VECTOR ( 0 downto 0 );
    ddr3_ras_n : out STD_LOGIC;
    ddr3_cas_n : out STD_LOGIC;
    ddr3_we_n : out STD_LOGIC;
    ddr3_reset_n : out STD_LOGIC;
    ddr3_cke : out STD_LOGIC;
    
    -- SPI
    spi_cs : inout STD_LOGIC;
    spi_clk : in STD_LOGIC;
    spi_din : in STD_LOGIC;
    spi_dout : out STD_LOGIC;

    -- Chronopixel
    TSCNT : out STD_LOGIC_VECTOR ( 11 downto 0 );
    RADR : out STD_LOGIC_VECTOR ( 5 downto 0 );
    ColAdr : out STD_LOGIC_VECTOR ( 5 downto 0 );
    CKCAL : out STD_LOGIC;
    CKC : out STD_LOGIC;
    CKA : out STD_LOGIC;
    CKB : out STD_LOGIC;
    SET : out STD_LOGIC;
    RMEM_SEL : out STD_LOGIC; -- tied to GND
    TNIN : out STD_LOGIC;
    TIN : out STD_LOGIC;
    RAdrValid : out STD_LOGIC;
    RdTstH : out STD_LOGIC; -- tied to GND
    RdClk : out STD_LOGIC;
    RdParLD : out STD_LOGIC;
    Rd_out : in STD_LOGIC;
    PDRST : out STD_LOGIC
  );

end chronopixel;

architecture STRUCTURE of chronopixel is
  signal ddr3_dqs_IOBUFDS_I : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr3_dqs_IOBUFDS_O : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr3_dqs_IOBUFDS_T : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr3_ck_OBUFDS_I : STD_LOGIC_VECTOR ( 0 downto 0 );
  signal sys_clk_IBUFDS_O : STD_LOGIC;
  signal clk_div8, clk_div64 : STD_LOGIC;
  signal led_reg : std_logic_vector (7 downto 0);
  signal rst : std_logic := '0'; -- global reset 
  signal chrono_clock : std_logic; -- chronopixel logic clock
  signal okHostClock : std_logic;  -- Opal Kelly host clock
  signal controller_leds : t_ctrl_leds;

  signal fifo_wr_en, fifo_rd_en, fifo_full, fifo_empty : STD_LOGIC;
  signal fifo_din, fifo_dout : STD_LOGIC_VECTOR(11 DOWNTO 0);
  signal fifo_wr_rst_busy, fifo_rd_rst_busy : STD_LOGIC;
  signal host_connected : STD_LOGIC; -- indicates whether the USB host is connected
  signal led_heartbeat : std_logic;
  
  -- TODO remove these?
  signal Vth, Hit_imlar, inc_tstmp, reading_d, incCntr, wrchrdat : STD_LOGIC;
  
  component heartbeat is
    port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           led : out STD_LOGIC);
  end component; 
  
  component chrono_controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           o_chrono : out t_to_chronopixel;
           o_chrono_addr : out t_chronopixel_addr;
           i_chrono : in t_from_chronopixel;   
           fifo_din : out STD_LOGIC_VECTOR(11 DOWNTO 0);
           fifo_wr_en : out STD_LOGIC;
           fifo_rd_rst_busy : in STD_LOGIC;
           host_connected : in STD_LOGIC; 
           leds : out t_ctrl_leds); 
  end component;
  
  component chrono_fifo IS
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END component;

begin
  led <= not(led_reg);
  rst <= '0'; -- there are no buttons on board to do reset, tie to GND for now
  chrono_clock <= clk_div8;
  okHostClock <= hi_in(0);
  
  -- on-board LEDs
  led_reg(0) <= led_heartbeat;
  led_reg(1) <= controller_leds.err;
  led_reg(2) <= controller_leds.err_serial;
  led_reg(3) <= controller_leds.idle4;
  led_reg(4) <= controller_leds.calib4;
  led_reg(5) <= controller_leds.wrtsig;
  led_reg(6) <= controller_leds.drdtst;
  led_reg(7) <= '0';
  
  -- TODO control signals are not specified for these pins
  RMEM_SEL <= '0';
  RdTstH <= '0';

  ddr3_dqs_IOBUFDS_0: unisim.vcomponents.IOBUFDS
    port map (
      IO => ddr3_dqs_p(0),
      IOB => ddr3_dqs_n(0),
      I => ddr3_dqs_IOBUFDS_I(0),
      O => ddr3_dqs_IOBUFDS_O(0),
      T => ddr3_dqs_IOBUFDS_T(0)
    );
    
  ddr3_dqs_IOBUFDS_1: unisim.vcomponents.IOBUFDS
    port map (
      IO => ddr3_dqs_p(1),
      IOB => ddr3_dqs_n(1),
      I => ddr3_dqs_IOBUFDS_I(1),
      O => ddr3_dqs_IOBUFDS_O(1),
      T => ddr3_dqs_IOBUFDS_T(1)
    );

  ddr3_ck_OBUFDS_0: unisim.vcomponents.OBUFDS
    port map (
      O => ddr3_ck_p(0),
      OB => ddr3_ck_n(0),
      I => ddr3_ck_OBUFDS_I(0)
    );

-- convert board clock from differential to single-ended
  sys_clk_IBUFDS: unisim.vcomponents.IBUFDS
    port map (
      I => sys_clk_p,
      IB => sys_clk_n,
      O => sys_clk_IBUFDS_O
    );
    
-- divide input clock by 8    
  BUFR_inst : unisim.vcomponents.BUFR
    generic map (
      BUFR_DIVIDE => "8", -- Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
      SIM_DEVICE => "7SERIES" -- Must be set to "7SERIES"
    )
    port map (
      O => clk_div8,
      CE => '1',
      CLR => '0', 
      I => sys_clk_IBUFDS_O
    );
 
-- divide clock by 64    
  BUFR_inst2 : unisim.vcomponents.BUFR
    generic map (
      BUFR_DIVIDE => "8", -- Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
      SIM_DEVICE => "7SERIES" -- Must be set to "7SERIES"
    )
    port map (
      O => clk_div64,
      CE => '1',
      CLR => '0', 
      I => clk_div8
    );   
    
  heartbeat_inst : heartbeat
  port map (
    clk => clk_div64,
    rst => rst,
    led => led_heartbeat
  );

  fifo_inst : chrono_fifo
  PORT MAP (
    rst => rst,
    wr_clk => chrono_clock,
    rd_clk => okHostClock,
    din => fifo_din,
    wr_en => fifo_wr_en,
    rd_en => fifo_rd_en,
    dout => fifo_dout,
    wr_rst_busy => fifo_wr_rst_busy,
    rd_rst_busy => fifo_rd_rst_busy
  );

  
  controller_inst : chrono_controller
  port map (
    clk => chrono_clock,
    rst => rst,
    
    o_chrono.cka => CKA,
    o_chrono.ckb => CKB,
    o_chrono.ckc => CKC,
    o_chrono.calclk => CKCAL,
    o_chrono.tin => TIN,
    o_chrono.tnin => TNIN,
    o_chrono.pdrst => PDRST,
    o_chrono.set => SET,
    o_chrono.RdParLd => RdParLd,
    o_chrono.RdClk => RdClk,
    o_chrono.RAdrValid => RAdrValid,
    o_chrono.Vth => Vth, -- no output wire with such name
    o_chrono.Hit_imlar => Hit_imlar,
    
    o_chrono_addr.TSCNT => TSCNT,    -- TODO verify the bit ordering (defined in interfaces.vhd)
    o_chrono_addr.RADR => RADR,      -- TODO verify the bit ordering
    o_chrono_addr.ColAdr => ColAdr,  -- TODO verify the bit ordering
    
    i_chrono.Rd_out => Rd_out,
    
    fifo_din => fifo_din,
    fifo_wr_en => fifo_wr_en,
    fifo_rd_rst_busy => fifo_rd_rst_busy, 
    host_connected => host_connected, 
    leds => controller_leds
  ); 

end STRUCTURE;
