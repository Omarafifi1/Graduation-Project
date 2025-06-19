module sdf_single_stage #(parameter data_width = 64  , index=2  , modulo=7681)(
    input [data_width-1:0]stage_in,
    input clk ,rst_n,
    input buffer_enable,
    input [data_width-1:0]tw_factor,
    input buffer_out_mux_selector , buffer_in_mux_selector,
    output[data_width-1:0] stage_out
);

wire [data_width-1:0]mod_add_out,mod_sub_out;
wire [data_width-1:0]a_buffer_out;
wire [data_width-1:0]buffer_in;


bfu #(.data_width(data_width), .modulo(modulo) ) buf_dut (
.a(a_buffer_out), 
.b(stage_in),
.clk (clk) ,
.rst_n (rst_n) ,
.tw_factor(tw_factor),
.mod_add_out(mod_add_out) ,
.mod_sub_out(mod_sub_out)
);


mux #(.data_width(data_width)) buffer_out_mux(
.in0(a_buffer_out),
.in1(mod_add_out),
.sel(buffer_out_mux_selector),/////////////////////////
.out(stage_out)
);

mux #(.data_width(data_width)) buffer_in_mux(
.in0(mod_sub_out),
.in1(stage_in),
.sel(buffer_in_mux_selector),//////////////
.out(buffer_in)
);

delay_buffer #(.data_width(data_width) , .index(index))  buffer_dut(
.buffer_in(buffer_in),  
.clk(clk), 
.rst_n(rst_n),
.buffer_enable(buffer_enable),
.buffer_out(a_buffer_out)
);

endmodule


