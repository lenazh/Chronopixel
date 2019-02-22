set_property direction IN [get_ports {hi_in[0]}]
set_property direction IN [get_ports {hi_in[1]}]
set_property direction IN [get_ports {hi_in[2]}]
set_property direction IN [get_ports {hi_in[3]}]
set_property direction IN [get_ports {hi_in[4]}]
set_property direction IN [get_ports {hi_in[5]}]
set_property direction IN [get_ports {hi_in[6]}]
set_property direction IN [get_ports {hi_in[7]}]
set_property direction INOUT [get_ports {hi_inout[0]}]
set_property direction INOUT [get_ports {hi_inout[10]}]
set_property direction INOUT [get_ports {hi_inout[11]}]
set_property direction INOUT [get_ports {hi_inout[12]}]
set_property direction INOUT [get_ports {hi_inout[13]}]
set_property direction INOUT [get_ports {hi_inout[14]}]
set_property direction INOUT [get_ports {hi_inout[15]}]
set_property direction INOUT [get_ports {hi_inout[1]}]
set_property direction INOUT [get_ports {hi_inout[2]}]
set_property direction INOUT [get_ports {hi_inout[3]}]
set_property direction INOUT [get_ports {hi_inout[4]}]
set_property direction INOUT [get_ports {hi_inout[5]}]
set_property direction INOUT [get_ports {hi_inout[6]}]
set_property direction INOUT [get_ports {hi_inout[7]}]
set_property direction INOUT [get_ports {hi_inout[8]}]
set_property direction INOUT [get_ports {hi_inout[9]}]
set_property direction OUT [get_ports {hi_out[0]}]
set_property direction OUT [get_ports {hi_out[1]}]
set_property direction OUT [get_ports {led[0]}]
set_property direction OUT [get_ports {led[1]}]
set_property direction OUT [get_ports {led[2]}]
set_property direction OUT [get_ports {led[3]}]
set_property direction OUT [get_ports {led[4]}]
set_property direction OUT [get_ports {led[5]}]
set_property direction OUT [get_ports {led[6]}]
set_property direction OUT [get_ports {led[7]}]
set_property direction INOUT [get_ports {spi_clk}]
set_property direction INOUT [get_ports {spi_cs}]
set_property direction IN [get_ports {spi_din}]
set_property direction OUT [get_ports {spi_dout}]
make_diff_pair_ports ddr3_ck_p[0] ddr3_ck_n[0]
make_diff_pair_ports ddr3_dqs_p[0] ddr3_dqs_n[0]
make_diff_pair_ports ddr3_dqs_p[1] ddr3_dqs_n[1]
make_diff_pair_ports sys_clk_p sys_clk_n
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]
set_property PACKAGE_PIN P20 [get_ports hi_muxsel]
set_property IOSTANDARD LVCMOS33 [get_ports hi_muxsel]
set_property PACKAGE_PIN Y18 [get_ports {hi_in[0]}]
set_property PACKAGE_PIN V17 [get_ports {hi_in[1]}]
set_property PACKAGE_PIN AA19 [get_ports {hi_in[2]}]
set_property PACKAGE_PIN V20 [get_ports {hi_in[3]}]
set_property PACKAGE_PIN W17 [get_ports {hi_in[4]}]
set_property PACKAGE_PIN AB20 [get_ports {hi_in[5]}]
set_property PACKAGE_PIN V19 [get_ports {hi_in[6]}]
set_property PACKAGE_PIN AA18 [get_ports {hi_in[7]}]
set_property SLEW FAST [get_ports {hi_in[*]}]
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
set_property PACKAGE_PIN T21 [get_ports {hi_inout[11]}]
set_property PACKAGE_PIN R21 [get_ports {hi_inout[12]}]
set_property PACKAGE_PIN P21 [get_ports {hi_inout[13]}]
set_property PACKAGE_PIN R22 [get_ports {hi_inout[14]}]
set_property PACKAGE_PIN P22 [get_ports {hi_inout[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_inout[*]}]
set_property PACKAGE_PIN V22 [get_ports hi_aa]
set_property IOSTANDARD LVCMOS33 [get_ports hi_aa]
create_clock -period 20.830 -name okHostClk [get_ports {hi_in[0]}]
set_multicycle_path -setup -from [get_ports {hi_in[*]}] 2
set_property IOSTANDARD LVDS_25 [get_ports sys_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports sys_clk_n]
set_property PACKAGE_PIN K4 [get_ports sys_clk_p]
set_property PACKAGE_PIN J4 [get_ports sys_clk_n]
set_property PACKAGE_PIN N13 [get_ports {led[0]}]
set_property PACKAGE_PIN N14 [get_ports {led[1]}]
set_property PACKAGE_PIN P15 [get_ports {led[2]}]
set_property PACKAGE_PIN P16 [get_ports {led[3]}]
set_property PACKAGE_PIN N17 [get_ports {led[4]}]
set_property PACKAGE_PIN P17 [get_ports {led[5]}]
set_property PACKAGE_PIN R16 [get_ports {led[6]}]
set_property PACKAGE_PIN R17 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
set_property PACKAGE_PIN T19 [get_ports spi_cs]
set_property PACKAGE_PIN P14 [get_ports spi_clk]
set_property PACKAGE_PIN U17 [get_ports spi_din]
set_property PACKAGE_PIN U18 [get_ports spi_dout]
set_property IOSTANDARD LVCMOS33 [get_ports spi_cs]
set_property IOSTANDARD LVCMOS33 [get_ports spi_clk]
set_property IOSTANDARD LVCMOS33 [get_ports spi_din]
set_property IOSTANDARD LVCMOS33 [get_ports spi_dout]
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
#revert back to original instance
current_instance -quiet
