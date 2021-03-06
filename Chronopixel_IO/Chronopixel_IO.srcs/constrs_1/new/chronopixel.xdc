
############################################################################
# Chronopixel on XEM7010-A50 - Xilinx constraints file
#
# Based on the template from Opal Kelly
# Copyright (c) 2004-2016 Opal Kelly Incorporated
#
# 03/01/2019
#
# Author: Elena Zhivun
# zhivun@gmail.com
#
############################################################################


set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property BITSTREAM.GENERAL.COMPRESS True [current_design]
set_property PACKAGE_PIN P20 [get_ports hi_muxsel]
set_property IOSTANDARD LVCMOS33 [get_ports hi_muxsel]


# Primary clock

set_property IOSTANDARD LVDS_25 [get_ports sys_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports sys_clk_n]
set_property PACKAGE_PIN K4 [get_ports sys_clk_p]
set_property PACKAGE_PIN J4 [get_ports sys_clk_n]
#create_clock -name devclk -period 5 [get_ports sys_clk_p]


############################################################################
## FrontPanel Host Interface
############################################################################


# Frontpanel clock & delays

create_clock -period 20.830 -name okHostClk [get_ports {hi_in[0]}]
set_input_delay -clock [get_clocks okHostClk] -max -add_delay 11.000 [get_ports {hi_inout[*]}]
set_input_delay -clock [get_clocks okHostClk] -min -add_delay 0.000 [get_ports {hi_inout[*]}]
set_multicycle_path -setup -from [get_ports {hi_inout[*]}] 2
set_input_delay -clock [get_clocks okHostClk] -max -add_delay 6.700 [get_ports {hi_in[*]}]
set_input_delay -clock [get_clocks okHostClk] -min -add_delay 0.000 [get_ports {hi_in[*]}]
set_multicycle_path -setup -from [get_ports {hi_in[*]}] 2
set_output_delay -clock [get_clocks okHostClk] -add_delay 8.900 [get_ports {hi_out[*]}]
set_output_delay -clock [get_clocks okHostClk] -add_delay 9.200 [get_ports {hi_inout[*]}]


# Opal Kelly Frontpanel I/O

set_property PACKAGE_PIN R22 [get_ports {hi_inout[14]}]
set_property PACKAGE_PIN T21 [get_ports {hi_inout[11]}]
set_property PACKAGE_PIN R21 [get_ports {hi_inout[12]}]
set_property PACKAGE_PIN P21 [get_ports {hi_inout[13]}]
set_property PACKAGE_PIN P22 [get_ports {hi_inout[15]}]
set_property PACKAGE_PIN Y18 [get_ports {hi_in[0]}]
set_property PACKAGE_PIN V17 [get_ports {hi_in[1]}]
set_property PACKAGE_PIN AA19 [get_ports {hi_in[2]}]
set_property PACKAGE_PIN V20 [get_ports {hi_in[3]}]
set_property PACKAGE_PIN W17 [get_ports {hi_in[4]}]
set_property PACKAGE_PIN AB20 [get_ports {hi_in[5]}]
set_property PACKAGE_PIN V19 [get_ports {hi_in[6]}]
set_property PACKAGE_PIN AA18 [get_ports {hi_in[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_in[*]}]
set_property PACKAGE_PIN Y21 [get_ports {hi_out[0]}]
set_property PACKAGE_PIN U20 [get_ports {hi_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_out[*]}]
set_property PACKAGE_PIN AB22 [get_ports {hi_inout[0]}]
set_property PACKAGE_PIN AB21 [get_ports {hi_inout[1]}]
set_property PACKAGE_PIN Y22 [get_ports {hi_inout[2]}]
set_property PACKAGE_PIN AA21 [get_ports {hi_inout[3]}]
set_property PACKAGE_PIN AA20 [get_ports {hi_inout[4]}]
set_property PACKAGE_PIN W22 [get_ports {hi_inout[5]}]
set_property PACKAGE_PIN W21 [get_ports {hi_inout[6]}]
set_property PACKAGE_PIN T20 [get_ports {hi_inout[7]}]
set_property PACKAGE_PIN R19 [get_ports {hi_inout[8]}]
set_property PACKAGE_PIN P19 [get_ports {hi_inout[9]}]
set_property PACKAGE_PIN U21 [get_ports {hi_inout[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_inout[*]}]
set_property PACKAGE_PIN V22 [get_ports hi_aa]
set_property IOSTANDARD LVCMOS33 [get_ports hi_aa]
set_property SLEW SLOW [get_ports {hi_inout[0]}]
set_property SLEW SLOW [get_ports {hi_inout[1]}]
set_property SLEW SLOW [get_ports {hi_inout[2]}]
set_property SLEW SLOW [get_ports {hi_inout[3]}]
set_property SLEW SLOW [get_ports {hi_inout[4]}]
set_property SLEW SLOW [get_ports {hi_inout[5]}]
set_property SLEW SLOW [get_ports {hi_inout[6]}]
set_property SLEW SLOW [get_ports {hi_inout[7]}]
set_property SLEW SLOW [get_ports {hi_inout[8]}]
set_property SLEW SLOW [get_ports {hi_inout[9]}]
set_property SLEW SLOW [get_ports {hi_inout[10]}]
set_property SLEW SLOW [get_ports {hi_inout[11]}]
set_property SLEW SLOW [get_ports {hi_inout[12]}]
set_property SLEW SLOW [get_ports {hi_inout[13]}]
set_property SLEW SLOW [get_ports {hi_inout[14]}]
set_property SLEW SLOW [get_ports {hi_inout[15]}]


# SPI slave (unused)

set_property PACKAGE_PIN T19 [get_ports spi_cs]
set_property PACKAGE_PIN P14 [get_ports spi_clk]
set_property PACKAGE_PIN U17 [get_ports spi_din]
set_property PACKAGE_PIN U18 [get_ports spi_dout]
set_property IOSTANDARD LVCMOS33 [get_ports spi_cs]
set_property IOSTANDARD LVCMOS33 [get_ports spi_clk]
set_property IOSTANDARD LVCMOS33 [get_ports spi_din]
set_property IOSTANDARD LVCMOS33 [get_ports spi_dout]


# LEDs

set_property PACKAGE_PIN N13 [get_ports {led[0]}]
set_property PACKAGE_PIN N14 [get_ports {led[1]}]
set_property PACKAGE_PIN P15 [get_ports {led[2]}]
set_property PACKAGE_PIN P16 [get_ports {led[3]}]
set_property PACKAGE_PIN N17 [get_ports {led[4]}]
set_property PACKAGE_PIN P17 [get_ports {led[5]}]
set_property PACKAGE_PIN R16 [get_ports {led[6]}]
set_property PACKAGE_PIN R17 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]


# DRAM (unused)

set_property PACKAGE_PIN AB1 [get_ports {ddr3_dq[0]}]
set_property PACKAGE_PIN Y4 [get_ports {ddr3_dq[1]}]
set_property PACKAGE_PIN AB2 [get_ports {ddr3_dq[2]}]
set_property PACKAGE_PIN V4 [get_ports {ddr3_dq[3]}]
set_property PACKAGE_PIN AB5 [get_ports {ddr3_dq[4]}]
set_property PACKAGE_PIN AA5 [get_ports {ddr3_dq[5]}]
set_property PACKAGE_PIN AB3 [get_ports {ddr3_dq[6]}]
set_property PACKAGE_PIN AA4 [get_ports {ddr3_dq[7]}]
set_property PACKAGE_PIN U3 [get_ports {ddr3_dq[8]}]
set_property PACKAGE_PIN W2 [get_ports {ddr3_dq[9]}]
set_property PACKAGE_PIN U2 [get_ports {ddr3_dq[10]}]
set_property PACKAGE_PIN Y2 [get_ports {ddr3_dq[11]}]
set_property PACKAGE_PIN U1 [get_ports {ddr3_dq[12]}]
set_property PACKAGE_PIN Y1 [get_ports {ddr3_dq[13]}]
set_property PACKAGE_PIN T1 [get_ports {ddr3_dq[14]}]
set_property PACKAGE_PIN W1 [get_ports {ddr3_dq[15]}]
set_property SLEW FAST [get_ports {ddr3_dq[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[*]}]
set_property PACKAGE_PIN W6 [get_ports {ddr3_addr[0]}]
set_property PACKAGE_PIN U7 [get_ports {ddr3_addr[1]}]
set_property PACKAGE_PIN W7 [get_ports {ddr3_addr[2]}]
set_property PACKAGE_PIN Y6 [get_ports {ddr3_addr[3]}]
set_property PACKAGE_PIN U6 [get_ports {ddr3_addr[4]}]
set_property PACKAGE_PIN AB7 [get_ports {ddr3_addr[5]}]
set_property PACKAGE_PIN Y8 [get_ports {ddr3_addr[6]}]
set_property PACKAGE_PIN AB8 [get_ports {ddr3_addr[7]}]
set_property PACKAGE_PIN Y7 [get_ports {ddr3_addr[8]}]
set_property PACKAGE_PIN AA8 [get_ports {ddr3_addr[9]}]
set_property PACKAGE_PIN T4 [get_ports {ddr3_addr[10]}]
set_property PACKAGE_PIN V7 [get_ports {ddr3_addr[11]}]
set_property PACKAGE_PIN T6 [get_ports {ddr3_addr[12]}]
set_property PACKAGE_PIN Y9 [get_ports {ddr3_addr[13]}]
set_property PACKAGE_PIN W9 [get_ports {ddr3_addr[14]}]
set_property SLEW FAST [get_ports {ddr3_addr[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[*]}]
set_property PACKAGE_PIN AB6 [get_ports {ddr3_ba[0]}]
set_property PACKAGE_PIN R6 [get_ports {ddr3_ba[1]}]
set_property PACKAGE_PIN AA6 [get_ports {ddr3_ba[2]}]
set_property SLEW FAST [get_ports {ddr3_ba[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[*]}]
set_property PACKAGE_PIN V5 [get_ports ddr3_ras_n]
set_property SLEW FAST [get_ports ddr3_ras_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_ras_n]
set_property PACKAGE_PIN U5 [get_ports ddr3_cas_n]
set_property SLEW FAST [get_ports ddr3_cas_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_cas_n]
set_property PACKAGE_PIN T5 [get_ports ddr3_we_n]
set_property SLEW FAST [get_ports ddr3_we_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_we_n]
set_property PACKAGE_PIN T3 [get_ports ddr3_reset_n]
set_property SLEW FAST [get_ports ddr3_reset_n]
set_property IOSTANDARD LVCMOS15 [get_ports ddr3_reset_n]
set_property PACKAGE_PIN R4 [get_ports ddr3_cke]
set_property IOSTANDARD SSTL15 [get_ports ddr3_cke]
set_property PACKAGE_PIN W5 [get_ports {ddr3_odt[0]}]
set_property SLEW FAST [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]
set_property PACKAGE_PIN AA1 [get_ports {ddr3_dm[0]}]
set_property PACKAGE_PIN V2 [get_ports {ddr3_dm[1]}]
set_property SLEW FAST [get_ports {ddr3_dm[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[*]}]
set_property PACKAGE_PIN Y3 [get_ports {ddr3_dqs_p[0]}]
set_property PACKAGE_PIN AA3 [get_ports {ddr3_dqs_n[0]}]
set_property PACKAGE_PIN R3 [get_ports {ddr3_dqs_p[1]}]
set_property PACKAGE_PIN R2 [get_ports {ddr3_dqs_n[1]}]
set_property SLEW FAST [get_ports ddr3_dqs*]
set_property IOSTANDARD DIFF_SSTL15 [get_ports ddr3_dqs*]
set_property PACKAGE_PIN V9 [get_ports {ddr3_ck_p[0]}]
set_property PACKAGE_PIN V8 [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports ddr3_ck*]
set_property IOSTANDARD DIFF_SSTL15 [get_ports ddr3_ck_*]
set_property INTERNAL_VREF 0.75 [get_iobanks 34]

# Chronopixel I/O

# TODO: Note that the I/O delays for Chronopixel are unknown.
#
# Please add the set_input_delay and set_output_delay constrainsts
# once the delays are measured
#
# TODO: Note that the drive load for the I/O pins is unknown.
# Since the leads appear to have high parasitic capacitance, the
# drive strength is set to maximum.
# Verify that the control signals don't overshoot.


# From: S., N. B. <xxxx@slac.stanford.edu>
# Date: Mon, Mar 21, 2016 at 4:08 PM
# Subject: Re: "comparator fire"
# Included in the waveform mrst4 you see the signal "Hit_imlar" which forces actual firing.
# There is no pin designated to this signal. This signal is applied to VTH pin, and VTH is coupled to
# comparator input through capacitor ("calibration capacitor").
# ....
# VTH - during calibration about 60 mV, positive jump during mrst4 about 250 mV
set_property PACKAGE_PIN Y19 [get_ports Vth]
set_property PACKAGE_PIN V18 [get_ports Hit_imlar]
# Vth = 0 mV when both pins are deasserted
set_property IOSTANDARD LVCMOS33 [get_ports Vth]
set_property IOSTANDARD LVCMOS33 [get_ports Hit_imlar]
set_property SLEW SLOW [get_ports Vth]
set_property SLEW SLOW [get_ports Hit_imlar]

# TODO: some of these pins are on Bank 16, driven by 3.3V
# The output levels need to be LVCMOS25 compliant

set_property PACKAGE_PIN D16 [get_ports CKCAL]
set_property PACKAGE_PIN E16 [get_ports CKC]
set_property PACKAGE_PIN E17 [get_ports CKA]
set_property PACKAGE_PIN B16 [get_ports CKB]
set_property PACKAGE_PIN F16 [get_ports SET]
set_property PACKAGE_PIN B15 [get_ports {TSCNT[0]}]
set_property PACKAGE_PIN D15 [get_ports {TSCNT[1]}]
set_property PACKAGE_PIN C15 [get_ports {TSCNT[2]}]
set_property PACKAGE_PIN D14 [get_ports {TSCNT[3]}]
set_property PACKAGE_PIN C14 [get_ports {TSCNT[4]}]
set_property PACKAGE_PIN F14 [get_ports {TSCNT[5]}]
set_property PACKAGE_PIN E14 [get_ports {TSCNT[6]}]
set_property PACKAGE_PIN F13 [get_ports {TSCNT[7]}]
set_property PACKAGE_PIN E13 [get_ports {TSCNT[8]}]
set_property PACKAGE_PIN B2 [get_ports {TSCNT[9]}]
set_property PACKAGE_PIN A1 [get_ports {TSCNT[10]}]
set_property PACKAGE_PIN C2 [get_ports {TSCNT[11]}]
set_property PACKAGE_PIN B1 [get_ports RMEM_SEL]
set_property PACKAGE_PIN E3 [get_ports {RADR[5]}]
set_property PACKAGE_PIN D1 [get_ports {RADR[4]}]
set_property PACKAGE_PIN F3 [get_ports {RADR[3]}]
set_property PACKAGE_PIN F1 [get_ports {RADR[2]}]
set_property PACKAGE_PIN D2 [get_ports {RADR[1]}]
set_property PACKAGE_PIN G18 [get_ports {RADR[0]}]
set_property PACKAGE_PIN G21 [get_ports TNIN]
set_property PACKAGE_PIN G15 [get_ports TIN]
set_property PACKAGE_PIN G22 [get_ports RAdrValid]
set_property PACKAGE_PIN G16 [get_ports RdTstH]
set_property PACKAGE_PIN E22 [get_ports RdClk]
set_property PACKAGE_PIN E21 [get_ports RdParLD]
set_property PACKAGE_PIN D22 [get_ports Rd_out]
set_property PACKAGE_PIN D21 [get_ports {ColAdr[0]}]
set_property PACKAGE_PIN D20 [get_ports {ColAdr[1]}]
set_property PACKAGE_PIN C22 [get_ports {ColAdr[2]}]
set_property PACKAGE_PIN C20 [get_ports {ColAdr[3]}]
set_property PACKAGE_PIN B22 [get_ports {ColAdr[4]}]
set_property PACKAGE_PIN B21 [get_ports {ColAdr[5]}]
set_property PACKAGE_PIN A21 [get_ports PDRST]

set_property IOSTANDARD LVCMOS25 [get_ports {RADR[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {RADR[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {RADR[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {RADR[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {RADR[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {RADR[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports CKA]
set_property IOSTANDARD LVCMOS25 [get_ports CKB]
set_property IOSTANDARD LVCMOS25 [get_ports CKC]
set_property IOSTANDARD LVCMOS25 [get_ports CKCAL]
set_property IOSTANDARD LVCMOS25 [get_ports RAdrValid]
set_property IOSTANDARD LVCMOS25 [get_ports Rd_out]
set_property IOSTANDARD LVCMOS25 [get_ports RdClk]
set_property IOSTANDARD LVCMOS25 [get_ports RdParLD]
set_property IOSTANDARD LVCMOS25 [get_ports RdTstH]
set_property IOSTANDARD LVCMOS25 [get_ports RMEM_SEL]
set_property IOSTANDARD LVCMOS25 [get_ports SET]
set_property IOSTANDARD LVCMOS25 [get_ports TIN]
set_property IOSTANDARD LVCMOS25 [get_ports TNIN]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[8]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[9]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[10]}]
set_property IOSTANDARD LVCMOS25 [get_ports {TSCNT[11]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ColAdr[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ColAdr[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ColAdr[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ColAdr[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ColAdr[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ColAdr[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports PDRST]

set_property SLEW SLOW [get_ports CKCAL]
set_property SLEW SLOW [get_ports CKA]
set_property SLEW SLOW [get_ports CKB]
set_property SLEW SLOW [get_ports CKC]
set_property SLEW SLOW [get_ports SET]
set_property SLEW SLOW [get_ports RMEM_SEL]
set_property SLEW SLOW [get_ports {RADR[0]}]
set_property SLEW SLOW [get_ports {RADR[1]}]
set_property SLEW SLOW [get_ports {RADR[2]}]
set_property SLEW SLOW [get_ports {RADR[3]}]
set_property SLEW SLOW [get_ports {RADR[4]}]
set_property SLEW SLOW [get_ports {RADR[5]}]
set_property SLEW SLOW [get_ports TNIN]
set_property SLEW SLOW [get_ports TIN]
set_property SLEW SLOW [get_ports RAdrValid]
set_property SLEW SLOW [get_ports RdTstH]
set_property SLEW SLOW [get_ports RdClk]
set_property SLEW SLOW [get_ports RdParLD]
set_property SLEW SLOW [get_ports PDRST]
set_property SLEW SLOW [get_ports {ColAdr[0]}]
set_property SLEW SLOW [get_ports {ColAdr[1]}]
set_property SLEW SLOW [get_ports {ColAdr[2]}]
set_property SLEW SLOW [get_ports {ColAdr[3]}]
set_property SLEW SLOW [get_ports {ColAdr[4]}]
set_property SLEW SLOW [get_ports {ColAdr[5]}]
set_property SLEW SLOW [get_ports {TSCNT[0]}]
set_property SLEW SLOW [get_ports {TSCNT[1]}]
set_property SLEW SLOW [get_ports {TSCNT[2]}]
set_property SLEW SLOW [get_ports {TSCNT[3]}]
set_property SLEW SLOW [get_ports {TSCNT[4]}]
set_property SLEW SLOW [get_ports {TSCNT[5]}]
set_property SLEW SLOW [get_ports {TSCNT[6]}]
set_property SLEW SLOW [get_ports {TSCNT[7]}]
set_property SLEW SLOW [get_ports {TSCNT[8]}]
set_property SLEW SLOW [get_ports {TSCNT[9]}]
set_property SLEW SLOW [get_ports {TSCNT[10]}]
set_property SLEW SLOW [get_ports {TSCNT[11]}]


set_property DRIVE 16 [get_ports Vth]
set_property DRIVE 16 [get_ports TNIN]
set_property DRIVE 16 [get_ports TIN]
set_property DRIVE 16 [get_ports spi_dout]
set_property DRIVE 12 [get_ports spi_cs]
set_property DRIVE 16 [get_ports SET]
set_property DRIVE 16 [get_ports RMEM_SEL]
set_property DRIVE 16 [get_ports RdParLD]
set_property DRIVE 16 [get_ports RdTstH]
set_property DRIVE 16 [get_ports RdClk]
set_property DRIVE 16 [get_ports RAdrValid]
set_property DRIVE 16 [get_ports PDRST]
set_property DRIVE 16 [get_ports Hit_imlar]
set_property DRIVE 12 [get_ports hi_muxsel]
set_property DRIVE 16 [get_ports CKCAL]
set_property DRIVE 16 [get_ports CKC]
set_property DRIVE 16 [get_ports CKB]
set_property DRIVE 16 [get_ports CKA]
set_property DRIVE 16 [get_ports {TSCNT[11]}]
set_property DRIVE 16 [get_ports {TSCNT[10]}]
set_property DRIVE 16 [get_ports {TSCNT[9]}]
set_property DRIVE 16 [get_ports {TSCNT[8]}]
set_property DRIVE 16 [get_ports {TSCNT[7]}]
set_property DRIVE 16 [get_ports {TSCNT[6]}]
set_property DRIVE 16 [get_ports {TSCNT[5]}]
set_property DRIVE 16 [get_ports {TSCNT[4]}]
set_property DRIVE 16 [get_ports {TSCNT[3]}]
set_property DRIVE 16 [get_ports {TSCNT[2]}]
set_property DRIVE 16 [get_ports {TSCNT[1]}]
set_property DRIVE 16 [get_ports {TSCNT[0]}]
set_property DRIVE 16 [get_ports {RADR[5]}]
set_property DRIVE 16 [get_ports {RADR[4]}]
set_property DRIVE 16 [get_ports {RADR[3]}]
set_property DRIVE 16 [get_ports {RADR[2]}]
set_property DRIVE 16 [get_ports {RADR[1]}]
set_property DRIVE 16 [get_ports {RADR[0]}]
set_property DRIVE 12 [get_ports {hi_out[1]}]
set_property DRIVE 12 [get_ports {hi_out[0]}]
set_property DRIVE 16 [get_ports {ColAdr[5]}]
set_property DRIVE 16 [get_ports {ColAdr[4]}]
set_property DRIVE 16 [get_ports {ColAdr[3]}]
set_property DRIVE 16 [get_ports {ColAdr[2]}]
set_property DRIVE 16 [get_ports {ColAdr[1]}]
set_property DRIVE 16 [get_ports {ColAdr[0]}]
