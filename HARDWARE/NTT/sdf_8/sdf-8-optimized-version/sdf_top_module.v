module sdf_top #(parameter data_width = 64  , modulo=7681 , addr_width=3  )(
    input [data_width-1:0]sdf_in,
    input start,
    input clk ,rst_n,
    output[data_width-1:0]sdf_out,
    output done_tick
);



wire [data_width-1:0]stage_2_in , stage_3_in ;
wire tw_factor_2nd_stage_mux_sel;
wire [1:0]tw_factor_3rd_stage_mux_sel;
wire buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1;
wire buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2;
wire buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3;
wire [data_width-1:0] psi_1,psi_2,psi_3,psi_4,psi_5,psi_6,psi_7;
wire buffer_enable;
reg [data_width-1:0] tw_factor_2nd_stage ,tw_factor_3rd_stage;

control_unit cu_dut(
.clk(clk),
.rst_n(rst_n),
.start(start),
.buffer_out_mux_selector_stage1(buffer_out_mux_selector_stage1), 
.buffer_in_mux_selector_stage1(buffer_in_mux_selector_stage1),
.buffer_out_mux_selector_stage2(buffer_out_mux_selector_stage2), 
.buffer_in_mux_selector_stage2(buffer_in_mux_selector_stage2),
.buffer_out_mux_selector_stage3(buffer_out_mux_selector_stage3), 
.buffer_in_mux_selector_stage3(buffer_in_mux_selector_stage3),
.tw_factor_2nd_stage_mux_sel(tw_factor_2nd_stage_mux_sel),
.tw_factor_3rd_stage_mux_sel(tw_factor_3rd_stage_mux_sel),
.buffer_enable(buffer_enable),
.done_tick(done_tick)
);

tw_factor_rom #(.addr_width(addr_width) , .data_width(data_width)) tw_row_dut(
.clk(clk),    
.rst_n(rst_n),
.psi_1(psi_1),
.psi_2(psi_2),
.psi_3(psi_3),
.psi_4(psi_4),
.psi_5(psi_5),
.psi_6(psi_6),
.psi_7(psi_7)
);


sdf_single_stage #(.data_width(data_width) , .index(2)  , .modulo(modulo)) sdf_first_stage_dut(  
.stage_in(sdf_in),
.clk (clk),
.rst_n(rst_n),
.tw_factor(psi_4),
.buffer_enable(buffer_enable),
.stage_out(stage_2_in),
.buffer_out_mux_selector (buffer_out_mux_selector_stage1) ,
.buffer_in_mux_selector (buffer_in_mux_selector_stage1) 
);

always @(*) begin
    case (tw_factor_2nd_stage_mux_sel)
        1'b0: tw_factor_2nd_stage=psi_2;
        1'b1: tw_factor_2nd_stage=psi_6;
    endcase  
end

sdf_single_stage #(.data_width(data_width) , .index(1)  , .modulo(modulo)) sdf_second_stage_dut(
.stage_in(stage_2_in),
.clk (clk),
.rst_n(rst_n),
.tw_factor(tw_factor_2nd_stage),
.buffer_enable(1'b1),
.stage_out(stage_3_in),
.buffer_out_mux_selector (buffer_out_mux_selector_stage2) ,
.buffer_in_mux_selector (buffer_in_mux_selector_stage2) 
);


always @(*) begin
    case (tw_factor_3rd_stage_mux_sel)
        2'b00: tw_factor_3rd_stage=psi_1;
        2'b01: tw_factor_3rd_stage=psi_5;
        2'b10: tw_factor_3rd_stage=psi_3;
        2'b11: tw_factor_3rd_stage=psi_7;
    endcase  
end
sdf_single_stage #(.data_width(data_width) , .index(0)  , .modulo(modulo)) sdf_third_stage_dut(
.stage_in(stage_3_in),
.clk (clk),
.rst_n(rst_n),
.tw_factor(tw_factor_3rd_stage),
.buffer_enable(1'b1),
.stage_out(sdf_out),
.buffer_out_mux_selector (buffer_out_mux_selector_stage3) ,
.buffer_in_mux_selector (buffer_in_mux_selector_stage3) 
);

endmodule


