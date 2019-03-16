# Chronopixel

VHDL implementation of [https://github.com/ChristianTMWeber/ChronoOS](https://github.com/ChristianTMWeber/ChronoOS)

Chronopixel is a monolithic CMOS pixel detector designed for the International Linear Collider in collaboration with the SARNOFF Corporation. [https://arxiv.org/abs/0902.2192](https://arxiv.org/abs/0902.2192)


## Design files:

[chronopixel.vhd](https://github.com/lenazh/Chronopixel/blob/master/Chronopixel_IO/Chronopixel_IO.srcs/sources_1/imports/Chronopixel_IO/chronopixel.vhd) - top level entity

[chrono_controller.vhd](https://github.com/lenazh/Chronopixel/blob/master/Chronopixel_IO/Chronopixel_IO.srcs/sources_1/new/chrono_controller.vhd) - state machine for control flow

[chrono_serial.vhd](https://github.com/lenazh/Chronopixel/blob/master/Chronopixel_IO/Chronopixel_IO.srcs/sources_1/new/chrono_serial.vhd) - outputs a single control sequence of a given type

[chronopixel.xdc](https://github.com/lenazh/Chronopixel/blob/master/Chronopixel_IO/Chronopixel_IO.srcs/constrs_1/new/chronopixel.xdc) - constraints


## Simulation
[serial_tb.vhd](https://github.com/lenazh/Chronopixel/blob/master/Chronopixel_IO/Chronopixel_IO.srcs/sim_serial/imports/new/serial_tb.vhd) - test chrono_serial.vhd

[controller_tb.vhd](https://github.com/lenazh/Chronopixel/blob/master/Chronopixel_IO/Chronopixel_IO.srcs/sim_controller/imports/new/controller_tb.vhd) - test chrono_controller.vhd
