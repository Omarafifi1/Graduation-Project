added latecy after inserting the flip flop at the input of the sdf stage 

latency of 1st stage = 1
latency of 2nd stage = 2
latency of 3rd stage = 3
latency of 4th stage = 4


so the modification is to add 1 to any thing in the 1st stage that depends on the counter
and 2 to any thing in the 2nd stage that depends on the counter and so on 

and add 4 to the address counter as the output comes from the 4th stage 



take care after u run the script to copy the roots from the tw_rom.txt to the tw_rom.v
//////////////////////////////////////////////////////////////////////////////////
                                 vivado constraints
//////////////////////////////////////////////////////////////////////////////////


set input_ports [list sdf_in start_ntt start_intt]
set output_ports [list sdf_out done_tick out_address]
set clk_period 10

create_clock -name master_clk -period $clk_period -waveform "0 [expr $clk_period/2]" [get_ports clk]


set_max_delay 10 -from [get_ports $input_ports] -to [all_outputs]


