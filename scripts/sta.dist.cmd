read_liberty /mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/timing/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog movavg_gl.v
link_design movavg
create_clock -name clk -period 10 {clk}
set non_clock_inputs [lsearch -inline -all -not -exact [all_inputs] clk]
set_input_delay -clock clk 0 $non_clock_inputs
set_output_delay -clock clk 0 [all_outputs]
report_checks -group_count 500 -format end
# report_power
exit

