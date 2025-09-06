module sdf_top #(parameter data_width = 32  , modulo=7681 , address_width=4  )(
    input [data_width-1:0]sdf_in,
    input ntt_logic_enable,intt_logic_enable, start,
    input clk ,rst_n,
    output[data_width-1:0]sdf_out,
    output done_tick,data_valid,busy,
    output [address_width-1:0]out_address , in_address
);



genvar i;
wire [data_width-1:0] stage_in [0:4];  // Create a bus for all stages
reg [data_width-1:0] tw_factor [0:3];


wire ntt_tw_factor_2nd_stage_mux_sel;
wire [1:0]ntt_tw_factor_3rd_stage_mux_sel;
wire [2:0]ntt_tw_factor_4th_stage_mux_sel;

wire [2:0]intt_tw_factor_1st_stage_mux_sel;
wire [1:0]intt_tw_factor_2nd_stage_mux_sel;
wire intt_tw_factor_3rd_stage_mux_sel;
    
wire buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1;
wire buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2;
wire buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3;
wire buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4;
wire  a_mod_add_out_mux_sel;
wire  b_reg4_mux_sel;
wire  mod_add_out_reg4_mux_sel;
wire  b_mod_sub_out_mux_sel;
wire  a_mod_mul_out_mux_sel;
wire  mod_sub_out_mod_mul_out_mux_sel;
wire [data_width-1:0] psi_1,psi_2,psi_3,psi_4,psi_5,psi_6,psi_7,psi_8,psi_9,psi_10,psi_11,psi_12,psi_13,psi_14,psi_15;
wire buffer_enable;

control_unit  #(.address_width(address_width)) cu_dut(
.clk(clk),
.rst_n(rst_n),
.ntt_logic_enable(ntt_logic_enable),
.intt_logic_enable(intt_logic_enable),

.start(start),

.buffer_out_mux_selector_stage1(buffer_out_mux_selector_stage1), 
.buffer_in_mux_selector_stage1(buffer_in_mux_selector_stage1),
.buffer_out_mux_selector_stage2(buffer_out_mux_selector_stage2), 
.buffer_in_mux_selector_stage2(buffer_in_mux_selector_stage2),
.buffer_out_mux_selector_stage3(buffer_out_mux_selector_stage3), 
.buffer_in_mux_selector_stage3(buffer_in_mux_selector_stage3),
.buffer_out_mux_selector_stage4(buffer_out_mux_selector_stage4), 
.buffer_in_mux_selector_stage4(buffer_in_mux_selector_stage4),

.ntt_tw_factor_2nd_stage_mux_sel(ntt_tw_factor_2nd_stage_mux_sel),
.ntt_tw_factor_3rd_stage_mux_sel(ntt_tw_factor_3rd_stage_mux_sel),
.ntt_tw_factor_4th_stage_mux_sel(ntt_tw_factor_4th_stage_mux_sel),

.intt_tw_factor_1st_stage_mux_sel(intt_tw_factor_1st_stage_mux_sel),
.intt_tw_factor_2nd_stage_mux_sel(intt_tw_factor_2nd_stage_mux_sel),
.intt_tw_factor_3rd_stage_mux_sel(intt_tw_factor_3rd_stage_mux_sel),

.a_mod_add_out_mux_sel(a_mod_add_out_mux_sel),
.b_reg4_mux_sel(b_reg4_mux_sel),
.mod_add_out_reg4_mux_sel(mod_add_out_reg4_mux_sel),
.b_mod_sub_out_mux_sel(b_mod_sub_out_mux_sel),
.a_mod_mul_out_mux_sel(a_mod_mul_out_mux_sel),
.mod_sub_out_mod_mul_out_mux_sel(mod_sub_out_mod_mul_out_mux_sel),

.buffer_enable(buffer_enable),
.out_address(out_address),
.in_address(in_address),
.done_tick(done_tick),
.data_valid(data_valid),
.busy(busy)
);

tw_factor_rom #( .data_width(data_width)) tw_row_dut(
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


assign stage_in[0] = sdf_in;     // Connect the input to the first stage
assign sdf_out = stage_in[4];   // Connect the output from the last stage

// Twiddle factor selection
always @(*) begin
    if(ntt_logic_enable) begin
    case (ntt_tw_factor_2nd_stage_mux_sel)
        1'b0: tw_factor[1] = psi_4;
        1'b1: tw_factor[1] = psi_12;
    endcase

    case (ntt_tw_factor_3rd_stage_mux_sel)
        2'b00: tw_factor[2] = psi_2;
        2'b01: tw_factor[2] = psi_10;
        2'b10: tw_factor[2] = psi_6;
        2'b11: tw_factor[2] = psi_14;
    endcase

    case (ntt_tw_factor_4th_stage_mux_sel)
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

    else begin
    case (intt_tw_factor_3rd_stage_mux_sel)
        1'b1: tw_factor[3] = psi_4;
        1'b0: tw_factor[3] = psi_12;
    endcase

    case (intt_tw_factor_2nd_stage_mux_sel)
        2'd3: tw_factor[2] = psi_2;
        2'd2: tw_factor[2] = psi_6;
        2'd1: tw_factor[2] = psi_10;
        2'd0: tw_factor[2] = psi_14;
    endcase

    case (intt_tw_factor_1st_stage_mux_sel)
        3'd7: tw_factor[1] = psi_1;
        3'd6: tw_factor[1] = psi_3;
        3'd5: tw_factor[1] = psi_5;
        3'd4: tw_factor[1] = psi_7;
        3'd3: tw_factor[1] = psi_9;
        3'd2: tw_factor[1] = psi_11;
        3'd1: tw_factor[1] = psi_13;
        3'd0: tw_factor[1] = psi_15;
    endcase
    end

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
            .intt_logic_enable(intt_logic_enable),
            .tw_factor((ntt_logic_enable)? ((i == 0) ? psi_8 : tw_factor[i]) : 
                        ((i == 3) ? psi_8 : tw_factor[i+1])), // Special twiddle for stage 1
            .stage_out(stage_in[i+1]),
            .buffer_enable((i==0) ? buffer_enable : 1'b1),
            .buffer_out_mux_selector((i == 0) ? buffer_out_mux_selector_stage1 :
                                     (i == 1) ? buffer_out_mux_selector_stage2 :
                                     (i == 2) ? buffer_out_mux_selector_stage3 :
                                                buffer_out_mux_selector_stage4),
            .buffer_in_mux_selector((i == 0) ? buffer_in_mux_selector_stage1 :
                                    (i == 1) ? buffer_in_mux_selector_stage2 :
                                    (i == 2) ? buffer_in_mux_selector_stage3 :
                                               buffer_in_mux_selector_stage4),
            .a_mod_add_out_mux_sel(a_mod_add_out_mux_sel),
            .b_reg4_mux_sel(b_reg4_mux_sel),
            .mod_add_out_reg4_mux_sel(mod_add_out_reg4_mux_sel),
            .b_mod_sub_out_mux_sel(b_mod_sub_out_mux_sel),
            .a_mod_mul_out_mux_sel(a_mod_mul_out_mux_sel),
            .mod_sub_out_mod_mul_out_mux_sel(mod_sub_out_mod_mul_out_mux_sel)
        );
    end
endgenerate

endmodule



































 