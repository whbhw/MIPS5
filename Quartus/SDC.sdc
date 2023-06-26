create_clock [get_ports clk]  -period 20 -name clk
#set_clock_latency 0  [get_clocks clk]
set_clock_latency -source 0 [get_clocks clk]
#set_clock_uncertainty 1.0 -to [get_clocks clk]
#set_clock_transition -min -fall 1.0 [get_clocks clk]
#set_clock_transition -min -rise 1.0 [get_clocks clk]
#set_clock_transition -max -fall 1.0 [get_clocks clk]
#set_clock_transition -max -rise 1.0 -to [get_clocks clk]
set all_in_ex_clk [remove_from_collection [all_inputs] [get_ports "clk"]]
set_input_delay 0 -clock clk -max $all_in_ex_clk
set_input_delay 0 -clock clk -min $all_in_ex_clk
set_output_delay 0 -clock clk -max [all_outputs]
set_output_delay 0 -clock clk -min [all_outputs]