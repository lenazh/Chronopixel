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
use work.FRONTPANEL.all;

entity top_tb is
end top_tb;

architecture behavioral of top_tb is

component chronopixel is
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
    -- TODO Vth, Hit_imlar are not wired to anything
  );
  end component;

  signal clk_200Mhz, sys_clk_p, sys_clk_n : std_logic;
  
  signal hi_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal hi_out : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal hi_inout : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal led : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal hi_muxsel : STD_LOGIC;
  signal hi_aa : STD_LOGIC;
  
  -- DRAM
  signal ddr3_dq : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ddr3_addr : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal ddr3_ba : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ddr3_odt : STD_LOGIC_VECTOR ( 0 downto 0 );
  signal ddr3_dm : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr3_dqs_p : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr3_dqs_n : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr3_ck_p : STD_LOGIC_VECTOR ( 0 downto 0 );
  signal ddr3_ck_n : STD_LOGIC_VECTOR ( 0 downto 0 );
  signal ddr3_ras_n : STD_LOGIC;
  signal ddr3_cas_n : STD_LOGIC;
  signal ddr3_we_n : STD_LOGIC;
  signal ddr3_reset_n : STD_LOGIC;
  signal ddr3_cke : STD_LOGIC;
  
  -- SPI
  signal spi_cs : STD_LOGIC;
  signal spi_clk : STD_LOGIC;
  signal spi_din : STD_LOGIC;
  signal spi_dout : STD_LOGIC;

  -- Chronopixel
  signal TSCNT : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal RADR : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal ColAdr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal CKCAL : STD_LOGIC;
  signal CKC : STD_LOGIC;
  signal CKA : STD_LOGIC;
  signal CKB : STD_LOGIC;
  signal SET : STD_LOGIC;
  signal RMEM_SEL : STD_LOGIC;
  signal TNIN : STD_LOGIC;
  signal TIN : STD_LOGIC;
  signal RAdrValid : STD_LOGIC;
  signal RdTstH : STD_LOGIC;
  signal RdClk : STD_LOGIC;
  signal RdParLD : STD_LOGIC;
  signal Rd_out : STD_LOGIC;
  signal PDRST : STD_LOGIC;

begin

  chronopixel_inst : chronopixel
  port map (
    sys_clk_p => sys_clk_p,
    sys_clk_n => sys_clk_n,
    
  -- Opal Kelly
    hi_in => hi_in,
    hi_out => hi_out,
    hi_inout => hi_inout,
    led => led,
    hi_muxsel => hi_muxsel,
    hi_aa => hi_aa,
    
    -- DRAM
    ddr3_dq => ddr3_dq,
    ddr3_addr => ddr3_addr,
    ddr3_ba => ddr3_ba,
    ddr3_odt => ddr3_odt,
    ddr3_dm => ddr3_dm,
    ddr3_dqs_p => ddr3_dqs_p,
    ddr3_dqs_n => ddr3_dqs_n,
    ddr3_ck_p => ddr3_ck_p,
    ddr3_ck_n => ddr3_ck_n,
    ddr3_ras_n => ddr3_ras_n,
    ddr3_cas_n => ddr3_cas_n,
    ddr3_we_n => ddr3_we_n,
    ddr3_reset_n => ddr3_reset_n,
    ddr3_cke => ddr3_cke,
    
    -- SPI
    spi_cs => spi_cs,
    spi_clk => spi_clk,
    spi_din => spi_din,
    spi_dout => spi_dout,

    -- Chronopixel
    TSCNT => TSCNT,
    RADR => RADR,
    ColAdr => ColAdr,
    CKCAL => CKCAL,
    CKC => CKC,
    CKA => CKA,
    CKB => CKB,
    SET => SET,
    RMEM_SEL => RMEM_SEL,
    TNIN => TNIN,
    TIN => TIN,
    RAdrValid => RAdrValid,
    RdTstH => RdTstH,
    RdClk => RdClk,
    RdParLD => RdParLD,
    Rd_out => Rd_out,
    PDRST => PDRST 
  );
  
  clk_OBUFDS: unisim.vcomponents.OBUFDS
    port map (
      O => sys_clk_p,
      OB => sys_clk_n,
      I => clk_200Mhz
    );
    
    process
    begin
      clk_200MHz <= '0';
      wait for 2.5 ns;
      clk_200MHz <= '1';
      wait for 2.5 ns;
    end process;
end behavioral;