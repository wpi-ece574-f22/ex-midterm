read_liberty /mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/timing/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog movavg_gl.v
link_design movavg
create_clock -name clk -period 10 {clk}
set non_clock_inputs [lsearch -inline -all -not -exact [all_inputs] clk]
set_input_delay -clock clk 0 $non_clock_inputs
set_output_delay -clock clk 0 [all_outputs]
report_checks
report_power
exit


#current_design movavg
#
#set clk_name  core_clock
#set clk_port_name clk
#set clk_period 10
#set clk_io_pct 0.2
#
#set clk_port [get_ports $clk_port_name]
#
#create_clock -name $clk_name -period $clk_period $clk_port
#
#
#set_input_delay  [expr $clk_period * $clk_io_pct] -clock $clk_name $non_clock_inputs
#set_output_delay [expr $clk_period * $clk_io_pct] -clock $clk_name [all_outputs]
