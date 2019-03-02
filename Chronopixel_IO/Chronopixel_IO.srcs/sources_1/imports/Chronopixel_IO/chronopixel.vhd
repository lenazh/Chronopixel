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
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- The following library declaration should be present if 
---- instantiating any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;


entity chronopixel is
  Port ( 
    hi_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    hi_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    hi_inout : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    led : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ddr3_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    ddr3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    ddr3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr3_odt : out STD_LOGIC_VECTOR ( 0 downto 0 );
    ddr3_dm : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr3_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr3_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    ddr3_ck_p : out STD_LOGIC_VECTOR ( 0 downto 0 );
    ddr3_ck_n : out STD_LOGIC_VECTOR ( 0 downto 0 );
    TSCNT : out STD_LOGIC_VECTOR ( 11 downto 0 );
    RADR : out STD_LOGIC_VECTOR ( 5 downto 0 );
    ColAdr : out STD_LOGIC_VECTOR ( 5 downto 0 );
    hi_muxsel : out STD_LOGIC;
    hi_aa : inout STD_LOGIC;
    sys_clk_p : in STD_LOGIC;
    sys_clk_n : in STD_LOGIC;
    spi_cs : inout STD_LOGIC;
    spi_clk : in STD_LOGIC;
    spi_din : in STD_LOGIC;
    spi_dout : out STD_LOGIC;
    ddr3_ras_n : out STD_LOGIC;
    ddr3_cas_n : out STD_LOGIC;
    ddr3_we_n : out STD_LOGIC;
    ddr3_reset_n : out STD_LOGIC;
    ddr3_cke : out STD_LOGIC;
    CKCAL : out STD_LOGIC;
    CKC : out STD_LOGIC;
    CKA : out STD_LOGIC;
    CKB : out STD_LOGIC;
    SET : out STD_LOGIC;
    RMEM_SEL : out STD_LOGIC;
    TNIN : out STD_LOGIC;
    TIN : out STD_LOGIC;
    RAdrValid : out STD_LOGIC;
    RdTstH : out STD_LOGIC;
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
  signal clk : STD_LOGIC;
begin

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
      O => clk,
      CE => '1',
      CLR => '0', 
      I => sys_clk_IBUFDS_O
    );
    


end STRUCTURE;
