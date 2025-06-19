module sdf_single_stage #(parameter data_width = 64  , index=2  , modulo=7681)(
    input [data_width-1:0]stage_in,
    input clk ,rst_n,
    input buffer_enable,
    input [data_width-1:0]tw_factor,
    input buffer_out_mux_selector , buffer_in_mux_selector,
    input a_mod_add_out_mux_sel,
    input b_reg4_mux_sel,
    input mod_add_out_reg4_mux_sel,
    input b_mod_sub_out_mux_sel,
    input a_mod_mul_out_mux_sel,
    input mod_sub_out_mod_mul_out_mux_sel,
    input intt_logic_enable,
    output [data_width-1:0] stage_out
);

wire [data_width-1:0]bfu_out_1,bfu_out_2;
wire [data_width-1:0]a_buffer_out;
wire [data_width-1:0]buffer_in;
reg [data_width-1:0] stage_in_reg;


always @(posedge clk , negedge rst_n) begin
    if(!rst_n) begin
        stage_in_reg<=0;
    end
    else begin
        stage_in_reg<=stage_in;
    end
end

bfu #(.data_width(data_width), .modulo(modulo) ) buf_dut (
.a(a_buffer_out), 
.b(stage_in_reg),
.clk (clk) ,
.rst_n (rst_n) ,
.tw_factor(tw_factor),
.a_mod_add_out_mux_sel(a_mod_add_out_mux_sel),
.b_reg4_mux_sel(b_reg4_mux_sel),
.mod_add_out_reg4_mux_sel(mod_add_out_reg4_mux_sel),
.b_mod_sub_out_mux_sel(b_mod_sub_out_mux_sel),
.a_mod_mul_out_mux_sel(a_mod_mul_out_mux_sel),
.mod_sub_out_mod_mul_out_mux_sel(mod_sub_out_mod_mul_out_mux_sel),
.bfu_out_1 (bfu_out_1),
.bfu_out_2(bfu_out_2),
.intt_logic_enable(intt_logic_enable)
);





mux #(.data_width(data_width)) buffer_out_mux(
.in0(a_buffer_out),
.in1(bfu_out_1),
.sel(buffer_out_mux_selector),
.out(stage_out)
);

mux #(.data_width(data_width)) buffer_in_mux(
.in0(bfu_out_2),
.in1(stage_in_reg),
.sel(buffer_in_mux_selector),
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


