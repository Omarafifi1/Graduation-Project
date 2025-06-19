module sdf_top #(parameter data_width = 64  , modulo=7681 , addr_width=4  )(
    input [data_width-1:0]sdf_in,
    input enable,
    input clk ,rst_n,
    output[data_width-1:0]sdf_out,
    output done_tick
);



genvar i;
wire [data_width-1:0] stage_in [0:4];  // Create a bus for all stages
reg [data_width-1:0] tw_factor [0:3];


wire tw_factor_2nd_stage_mux_sel;
wire [1:0]tw_factor_3rd_stage_mux_sel;
wire [2:0]tw_factor_4th_stage_mux_sel;
wire buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1;
wire buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2;
wire buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3;
wire buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4;
wire [data_width-1:0] psi_1,psi_2,psi_3,psi_4,psi_5,psi_6,psi_7,psi_8,psi_9,psi_10,psi_11,psi_12,psi_13,psi_14,psi_15;


control_unit cu_dut(
.clk(clk),
.rst_n(rst_n),
.enable(enable),
.buffer_out_mux_selector_stage1(buffer_out_mux_selector_stage1), 
.buffer_in_mux_selector_stage1(buffer_in_mux_selector_stage1),
.buffer_out_mux_selector_stage2(buffer_out_mux_selector_stage2), 
.buffer_in_mux_selector_stage2(buffer_in_mux_selector_stage2),
.buffer_out_mux_selector_stage3(buffer_out_mux_selector_stage3), 
.buffer_in_mux_selector_stage3(buffer_in_mux_selector_stage3),
.buffer_out_mux_selector_stage4(buffer_out_mux_selector_stage4), 
.buffer_in_mux_selector_stage4(buffer_in_mux_selector_stage4),
.tw_factor_2nd_stage_mux_sel(tw_factor_2nd_stage_mux_sel),
.tw_factor_3rd_stage_mux_sel(tw_factor_3rd_stage_mux_sel),
.tw_factor_4th_stage_mux_sel(tw_factor_4th_stage_mux_sel),
.done_tick(done_tick)
);

tw_factor_rom #(.addr_width(addr_width) , .data_width(data_width)) tw_row_dut(
.psi_1(psi_1),
.psi_2(psi_2),
.psi_3(psi_3),
.psi_4(psi_4),
.psi_5(psi_5),
.psi_6(psi_6),
.psi_7(psi_7),
.psi_8(psi_8),
.psi_9(psi_9),
.psi_10(psi_10),
.psi_11(psi_11),
.psi_12(psi_12),
.psi_13(psi_13),
.psi_14(psi_14),
.psi_15(psi_15)
);


assign stage_in[0] = sdf_in;    // Connect the input to the first stage
assign sdf_out = stage_in[4];   // Connect the output from the last stage

// Twiddle factor selection
always @(*) begin
    case (tw_factor_2nd_stage_mux_sel)
        1'b0: tw_factor[1] = psi_4;
        1'b1: tw_factor[1] = psi_12;
    endcase

    case (tw_factor_3rd_stage_mux_sel)
        2'b00: tw_factor[2] = psi_2;
        2'b01: tw_factor[2] = psi_10;
        2'b10: tw_factor[2] = psi_6;
        2'b11: tw_factor[2] = psi_14;
    endcase

    case (tw_factor_4th_stage_mux_sel)
        3'd0: tw_factor[3] = psi_1;
        3'd1: tw_factor[3] = psi_9;
        3'd2: tw_factor[3] = psi_5;
        3'd3: tw_factor[3] = psi_13;
        3'd4: tw_factor[3] = psi_3;
        3'd5: tw_factor[3] = psi_11;
        3'd6: tw_factor[3] = psi_7;
        3'd7: tw_factor[3] = psi_15;
    endcase
end


// Generate Loop for SDF Stages
generate
    for (i = 0; i < 4; i = i + 1) begin : sdf_stages
        sdf_single_stage #(
            .data_width(data_width),
            .index(3 - i),
            .modulo(modulo)
        ) sdf_stage_inst (
            .stage_in(stage_in[i]),
            .clk(clk),
            .rst_n(rst_n),
            .tw_factor((i == 0) ? psi_8 : tw_factor[i]), // Special twiddle for stage 1
            .stage_out(stage_in[i+1]),
            .buffer_out_mux_selector((i == 0) ? buffer_out_mux_selector_stage1 :
                                     (i == 1) ? buffer_out_mux_selector_stage2 :
                                     (i == 2) ? buffer_out_mux_selector_stage3 :
                                                buffer_out_mux_selector_stage4),
            .buffer_in_mux_selector((i == 0) ? buffer_in_mux_selector_stage1 :
                                    (i == 1) ? buffer_in_mux_selector_stage2 :
                                    (i == 2) ? buffer_in_mux_selector_stage3 :
                                               buffer_in_mux_selector_stage4)
        );
    end
endgenerate

endmodule


