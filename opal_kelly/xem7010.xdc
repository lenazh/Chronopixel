############################################################################
# XEM7010 - Xilinx constraints file
#
# Pin mappings for the XEM7010.  Use this as a template and comment out 
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2016 Opal Kelly Incorporated
############################################################################

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

set_property PACKAGE_PIN P20 [get_ports {hi_muxsel}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_muxsel}]

############################################################################
## FrontPanel Host Interface
############################################################################
set_property PACKAGE_PIN Y18  [get_ports {hi_in[0]}]
set_property PACKAGE_PIN V17  [get_ports {hi_in[1]}]
set_property PACKAGE_PIN AA19 [get_ports {hi_in[2]}]
set_property PACKAGE_PIN V20  [get_ports {hi_in[3]}]
set_property PACKAGE_PIN W17  [get_ports {hi_in[4]}]
set_property PACKAGE_PIN AB20 [get_ports {hi_in[5]}]
set_property PACKAGE_PIN V19  [get_ports {hi_in[6]}]
set_property PACKAGE_PIN AA18 [get_ports {hi_in[7]}]

set_property SLEW FAST [get_ports {hi_in[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_in[*]}]

set_property PACKAGE_PIN Y21 [get_ports {hi_out[0]}]
set_property PACKAGE_PIN U20 [get_ports {hi_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_out[*]}]

set_property PACKAGE_PIN AB22 [get_ports {hi_inout[0]}]
set_property PACKAGE_PIN AB21 [get_ports {hi_inout[1]}]
set_property PACKAGE_PIN Y22  [get_ports {hi_inout[2]}]
set_property PACKAGE_PIN AA21 [get_ports {hi_inout[3]}]
set_property PACKAGE_PIN AA20 [get_ports {hi_inout[4]}]
set_property PACKAGE_PIN W22  [get_ports {hi_inout[5]}]
set_property PACKAGE_PIN W21  [get_ports {hi_inout[6]}]
set_property PACKAGE_PIN T20  [get_ports {hi_inout[7]}]
set_property PACKAGE_PIN R19  [get_ports {hi_inout[8]}]
set_property PACKAGE_PIN P19  [get_ports {hi_inout[9]}]
set_property PACKAGE_PIN U21  [get_ports {hi_inout[10]}]
set_property PACKAGE_PIN T21  [get_ports {hi_inout[11]}]
set_property PACKAGE_PIN R21  [get_ports {hi_inout[12]}]
set_property PACKAGE_PIN P21  [get_ports {hi_inout[13]}]
set_property PACKAGE_PIN R22  [get_ports {hi_inout[14]}]
set_property PACKAGE_PIN P22  [get_ports {hi_inout[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_inout[*]}]

set_property PACKAGE_PIN V22 [get_ports {hi_aa}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_aa}]


create_clock -name okHostClk -period 20.83 [get_ports {hi_in[0]}]

set_input_delay -add_delay -max -clock [get_clocks {okHostClk}]  11.000 [get_ports {hi_inout[*]}]
set_input_delay -add_delay -min -clock [get_clocks {okHostClk}]  0.000  [get_ports {hi_inout[*]}]
set_multicycle_path -setup -from [get_ports {hi_inout[*]}] 2

set_input_delay -add_delay -max -clock [get_clocks {okHostClk}]  6.700 [get_ports {hi_in[*]}]
set_input_delay -add_delay -min -clock [get_clocks {okHostClk}]  0.000 [get_ports {hi_in[*]}]
set_multicycle_path -setup -from [get_ports {hi_in[*]}] 2

set_output_delay -add_delay -clock [get_clocks {okHostClk}]  8.900 [get_ports {hi_out[*]}]

set_output_delay -add_delay -clock [get_clocks {okHostClk}]  9.200 [get_ports {hi_inout[*]}]


set_property IOSTANDARD LVDS_25 [get_ports {sys_clk_p}]
set_property IOSTANDARD LVDS_25 [get_ports {sys_clk_n}]
set_property PACKAGE_PIN K4 [get_ports {sys_clk_p}]
set_property PACKAGE_PIN J4 [get_ports {sys_clk_n}]



# MC1-1 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-2 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-3 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-4 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-5 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-6 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-7 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-8 
set_property PACKAGE_PIN B20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-9 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-10 
set_property PACKAGE_PIN M9 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-11 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-12 
set_property PACKAGE_PIN L10 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-13 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-14 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-15 
set_property PACKAGE_PIN P5 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-16 
set_property PACKAGE_PIN R1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-17 
set_property PACKAGE_PIN P4 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-18 
set_property PACKAGE_PIN P1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-19 
set_property PACKAGE_PIN P6 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-20 
set_property PACKAGE_PIN P2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-21 
set_property PACKAGE_PIN N5 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-22 
set_property PACKAGE_PIN N2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-23 
set_property PACKAGE_PIN N4 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-24 
set_property PACKAGE_PIN M3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-25 
set_property PACKAGE_PIN N3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-26 
set_property PACKAGE_PIN M2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-27 
set_property PACKAGE_PIN M1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-28 
set_property PACKAGE_PIN M6 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-29 
set_property PACKAGE_PIN L1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-30 
set_property PACKAGE_PIN M5 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-31 
set_property PACKAGE_PIN L3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-32 
set_property PACKAGE_PIN L5 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-33 
set_property PACKAGE_PIN K3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-34 
set_property PACKAGE_PIN L4 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-35 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-36 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-37 
set_property PACKAGE_PIN K1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-38 
set_property PACKAGE_PIN K2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-39 
set_property PACKAGE_PIN J1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-40 
set_property PACKAGE_PIN J2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-41 
set_property PACKAGE_PIN H2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-42 
set_property PACKAGE_PIN K6 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-43 
set_property PACKAGE_PIN G2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-44 
set_property PACKAGE_PIN J6 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-45 
set_property PACKAGE_PIN H3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-46 
set_property PACKAGE_PIN J5 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-47 
set_property PACKAGE_PIN G3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-48 
set_property PACKAGE_PIN H5 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-49 
set_property PACKAGE_PIN E2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-50 
set_property PACKAGE_PIN G1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-51 
set_property PACKAGE_PIN D2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-52 
set_property PACKAGE_PIN F1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-53 
set_property PACKAGE_PIN E1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-54 
set_property PACKAGE_PIN F3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-55 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-56 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-57 
set_property PACKAGE_PIN D1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-58 
set_property PACKAGE_PIN E3 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-59 
set_property PACKAGE_PIN B1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-60 
set_property PACKAGE_PIN C2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-61 
set_property PACKAGE_PIN A1 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-62 
set_property PACKAGE_PIN B2 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-63 
set_property PACKAGE_PIN E13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-64 
set_property PACKAGE_PIN F13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-65 
set_property PACKAGE_PIN E14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-66 
set_property PACKAGE_PIN F14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-67 
set_property PACKAGE_PIN C14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-68 
set_property PACKAGE_PIN D14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-69 
set_property PACKAGE_PIN C15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-70 
set_property PACKAGE_PIN D15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-71 
set_property PACKAGE_PIN B15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-72 
set_property PACKAGE_PIN F16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-73 
set_property PACKAGE_PIN B16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-74 
set_property PACKAGE_PIN E17 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-75 
set_property PACKAGE_PIN E16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-76 
set_property PACKAGE_PIN D16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-77 
set_property PACKAGE_PIN H4 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-78 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC1-79 
set_property PACKAGE_PIN G4 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC1-80 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-1 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-2 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-3 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-4 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-5 
set_property PACKAGE_PIN V12 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-6 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-7 
set_property PACKAGE_PIN T13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-8 
set_property PACKAGE_PIN U13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-9 
set_property PACKAGE_PIN R13 [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-10 
set_property PACKAGE_PIN J16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-11 
set_property PACKAGE_PIN A20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-12 
set_property PACKAGE_PIN M17 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-13 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-14 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-15 
set_property PACKAGE_PIN N18 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-16 
set_property PACKAGE_PIN N20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-17 
set_property PACKAGE_PIN N19 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-18 
set_property PACKAGE_PIN M20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-19 
set_property PACKAGE_PIN M15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-20 
set_property PACKAGE_PIN M13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-21 
set_property PACKAGE_PIN M16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-22 
set_property PACKAGE_PIN L13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-23 
set_property PACKAGE_PIN N22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-24 
set_property PACKAGE_PIN M18 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-25 
set_property PACKAGE_PIN M22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-26 
set_property PACKAGE_PIN L18 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-27 
set_property PACKAGE_PIN M21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-28 
set_property PACKAGE_PIN L14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-29 
set_property PACKAGE_PIN L21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-30 
set_property PACKAGE_PIN L15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-31 
set_property PACKAGE_PIN L19 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-32 
set_property PACKAGE_PIN K21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-33 
set_property PACKAGE_PIN L20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-34 
set_property PACKAGE_PIN K22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-35 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-36 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-37 
set_property PACKAGE_PIN L16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-38 
set_property PACKAGE_PIN K18 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-39 
set_property PACKAGE_PIN K16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-40 
set_property PACKAGE_PIN K19 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-41 
set_property PACKAGE_PIN K13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-42 
set_property PACKAGE_PIN J20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-43 
set_property PACKAGE_PIN K14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-44 
set_property PACKAGE_PIN J21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-45 
set_property PACKAGE_PIN K17 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-46 
set_property PACKAGE_PIN J15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-47 
set_property PACKAGE_PIN J17 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-48 
set_property PACKAGE_PIN H15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-49 
set_property PACKAGE_PIN H17 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-50 
set_property PACKAGE_PIN J14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-51 
set_property PACKAGE_PIN H18 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-52 
set_property PACKAGE_PIN H14 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-53 
set_property PACKAGE_PIN J22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-54 
set_property PACKAGE_PIN H20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-55 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-56 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-57 
set_property PACKAGE_PIN H22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-58 
set_property PACKAGE_PIN G20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-59 
set_property PACKAGE_PIN H13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-60 
set_property PACKAGE_PIN G17 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-61 
set_property PACKAGE_PIN G13 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-62 
set_property PACKAGE_PIN G18 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-63 
set_property PACKAGE_PIN G21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-64 
set_property PACKAGE_PIN G15 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-65 
set_property PACKAGE_PIN G22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-66 
set_property PACKAGE_PIN G16 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-67 
set_property PACKAGE_PIN E22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-68 
set_property PACKAGE_PIN E21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-69 
set_property PACKAGE_PIN D22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-70 
set_property PACKAGE_PIN D21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-71 
set_property PACKAGE_PIN D20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-72 
set_property PACKAGE_PIN C22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-73 
set_property PACKAGE_PIN C20 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-74 
set_property PACKAGE_PIN B22 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-75 
set_property PACKAGE_PIN B21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-76 
set_property PACKAGE_PIN A21 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-77 
set_property PACKAGE_PIN J19 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-78 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# MC2-79 
set_property PACKAGE_PIN H19 [get_ports {}]
set_property IOSTANDARD LVCMOS33 [get_ports {}]

# MC2-80 
set_property PACKAGE_PIN  [get_ports {}]
set_property IOSTANDARD  [get_ports {}]

# LEDs #####################################################################
set_property PACKAGE_PIN N13 [get_ports {led[0]}]
set_property PACKAGE_PIN N14 [get_ports {led[1]}]
set_property PACKAGE_PIN P15 [get_ports {led[2]}]
set_property PACKAGE_PIN P16 [get_ports {led[3]}]
set_property PACKAGE_PIN N17 [get_ports {led[4]}]
set_property PACKAGE_PIN P17 [get_ports {led[5]}]
set_property PACKAGE_PIN R16 [get_ports {led[6]}]
set_property PACKAGE_PIN R17 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]

# Flash ####################################################################
set_property PACKAGE_PIN T19 [get_ports {spi_cs}]
set_property PACKAGE_PIN P14 [get_ports {spi_clk}]
set_property PACKAGE_PIN U17 [get_ports {spi_din}]
set_property PACKAGE_PIN U18 [get_ports {spi_dout}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_cs}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_din}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_dout}]

# DRAM #####################################################################
set_property PACKAGE_PIN AB1 [get_ports {ddr3_dq[0]}]
set_property PACKAGE_PIN Y4  [get_ports {ddr3_dq[1]}]
set_property PACKAGE_PIN AB2 [get_ports {ddr3_dq[2]}]
set_property PACKAGE_PIN V4  [get_ports {ddr3_dq[3]}]
set_property PACKAGE_PIN AB5 [get_ports {ddr3_dq[4]}]
set_property PACKAGE_PIN AA5 [get_ports {ddr3_dq[5]}]
set_property PACKAGE_PIN AB3 [get_ports {ddr3_dq[6]}]
set_property PACKAGE_PIN AA4 [get_ports {ddr3_dq[7]}]
set_property PACKAGE_PIN U3  [get_ports {ddr3_dq[8]}]
set_property PACKAGE_PIN W2  [get_ports {ddr3_dq[9]}]
set_property PACKAGE_PIN U2  [get_ports {ddr3_dq[10]}]
set_property PACKAGE_PIN Y2  [get_ports {ddr3_dq[11]}]
set_property PACKAGE_PIN U1  [get_ports {ddr3_dq[12]}]
set_property PACKAGE_PIN Y1  [get_ports {ddr3_dq[13]}]
set_property PACKAGE_PIN T1  [get_ports {ddr3_dq[14]}]
set_property PACKAGE_PIN W1  [get_ports {ddr3_dq[15]}]
set_property SLEW FAST [get_ports {ddr3_dq[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[*]}]

set_property PACKAGE_PIN W6  [get_ports {ddr3_addr[0]}]
set_property PACKAGE_PIN U7  [get_ports {ddr3_addr[1]}]
set_property PACKAGE_PIN W7  [get_ports {ddr3_addr[2]}]
set_property PACKAGE_PIN Y6  [get_ports {ddr3_addr[3]}]
set_property PACKAGE_PIN U6  [get_ports {ddr3_addr[4]}]
set_property PACKAGE_PIN AB7 [get_ports {ddr3_addr[5]}]
set_property PACKAGE_PIN Y8  [get_ports {ddr3_addr[6]}]
set_property PACKAGE_PIN AB8 [get_ports {ddr3_addr[7]}]
set_property PACKAGE_PIN Y7  [get_ports {ddr3_addr[8]}]
set_property PACKAGE_PIN AA8 [get_ports {ddr3_addr[9]}]
set_property PACKAGE_PIN T4  [get_ports {ddr3_addr[10]}]
set_property PACKAGE_PIN V7  [get_ports {ddr3_addr[11]}]
set_property PACKAGE_PIN T6  [get_ports {ddr3_addr[12]}]
set_property PACKAGE_PIN Y9  [get_ports {ddr3_addr[13]}]
set_property PACKAGE_PIN W9  [get_ports {ddr3_addr[14]}]
set_property SLEW FAST [get_ports {ddr3_addr[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[*]}]

set_property PACKAGE_PIN AB6 [get_ports {ddr3_ba[0]}]
set_property PACKAGE_PIN R6  [get_ports {ddr3_ba[1]}]
set_property PACKAGE_PIN AA6 [get_ports {ddr3_ba[2]}]
set_property SLEW FAST [get_ports {ddr3_ba[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[*]}]

set_property PACKAGE_PIN V5 [get_ports {ddr3_ras_n}]
set_property SLEW FAST [get_ports {ddr3_ras_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]

set_property PACKAGE_PIN U5 [get_ports {ddr3_cas_n}]
set_property SLEW FAST [get_ports {ddr3_cas_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]

set_property PACKAGE_PIN T5 [get_ports {ddr3_we_n}]
set_property SLEW FAST [get_ports {ddr3_we_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]

set_property PACKAGE_PIN T3 [get_ports {ddr3_reset_n}]
set_property SLEW FAST [get_ports {ddr3_reset_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]

set_property PACKAGE_PIN R4 [get_ports {ddr3_cke}]
set_property SLEW FAST [get_ports {ddr3_cke}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke}]

set_property PACKAGE_PIN W5 [get_ports {ddr3_odt[0]}]
set_property SLEW FAST [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]

set_property PACKAGE_PIN AA1 [get_ports {ddr3_dm[0]}]
set_property PACKAGE_PIN V2  [get_ports {ddr3_dm[1]}]
set_property SLEW FAST [get_ports {ddr3_dm[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[*]}]

set_property PACKAGE_PIN Y3  [get_ports {ddr3_dqs_p[0]}]
set_property PACKAGE_PIN AA3 [get_ports {ddr3_dqs_n[0]}]
set_property PACKAGE_PIN R3  [get_ports {ddr3_dqs_p[1]}]
set_property PACKAGE_PIN R2  [get_ports {ddr3_dqs_n[1]}]
set_property SLEW FAST [get_ports {ddr3_dqs*}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs*}]

set_property PACKAGE_PIN V9 [get_ports {ddr3_ck_p[0]}]
set_property PACKAGE_PIN V8 [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports {ddr3_ck*}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_*}]

