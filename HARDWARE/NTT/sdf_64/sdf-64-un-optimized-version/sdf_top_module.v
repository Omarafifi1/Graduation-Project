module sdf_top #(parameter data_width = 64  , modulo=7681 , addr_width=6  )(
    input [data_width-1:0]sdf_in,
    input enable,
    input clk ,rst_n,
    output[data_width-1:0]sdf_out,
    output done_tick
);



genvar i;
wire [data_width-1:0] stage_in [0:6];  // Create a bus for all stages
reg  [data_width-1:0] tw_factor [0:5];


wire tw_factor_2nd_stage_mux_sel;
wire [1:0]tw_factor_3rd_stage_mux_sel;
wire [2:0]tw_factor_4th_stage_mux_sel;
wire [3:0]tw_factor_5th_stage_mux_sel;
wire [4:0]tw_factor_6th_stage_mux_sel;

wire buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1;
wire buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2;
wire buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3;
wire buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4;
wire buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5;
wire buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6;

wire [data_width*(2**addr_width-1)-1:0] psi_out ;
wire [data_width-1:0] psi [1:(2**addr_width)-1];



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
.buffer_out_mux_selector_stage5(buffer_out_mux_selector_stage5), 
.buffer_in_mux_selector_stage5(buffer_in_mux_selector_stage5),
.buffer_out_mux_selector_stage6(buffer_out_mux_selector_stage6), 
.buffer_in_mux_selector_stage6(buffer_in_mux_selector_stage6),
.tw_factor_2nd_stage_mux_sel(tw_factor_2nd_stage_mux_sel),
.tw_factor_3rd_stage_mux_sel(tw_factor_3rd_stage_mux_sel),
.tw_factor_4th_stage_mux_sel(tw_factor_4th_stage_mux_sel),
.tw_factor_5th_stage_mux_sel(tw_factor_5th_stage_mux_sel),
.tw_factor_6th_stage_mux_sel(tw_factor_6th_stage_mux_sel),
.done_tick(done_tick)
);

tw_factor_rom #(.addr_width(addr_width) , .data_width(data_width)) tw_row_dut(
.psi_out(psi_out)
);

genvar j;
generate
  for(j=0 ; j<((2**addr_width)-1) ; j=j+1) begin
     assign psi[j+1]=psi_out[(data_width*(j+1))-1 : data_width*j];
  end      
endgenerate 

assign stage_in[0] = sdf_in;    // Connect the input to the first stage
assign sdf_out = stage_in[6];   // Connect the output from the last stage

// Twiddle factor selection
always @(*) begin
    tw_factor[0]=psi[32];
    case (tw_factor_2nd_stage_mux_sel)
        1'b0: tw_factor[1] = psi[16];
        1'b1: tw_factor[1] = psi[48];
    endcase

    case (tw_factor_3rd_stage_mux_sel)
        2'b00: tw_factor[2] = psi[8];
        2'b01: tw_factor[2] = psi[40];
        2'b10: tw_factor[2] = psi[24];
        2'b11: tw_factor[2] = psi[56];
    endcase

    case (tw_factor_4th_stage_mux_sel)
        3'd0:  tw_factor[3] = psi[4];
        3'd1:  tw_factor[3] = psi[36];
        3'd2:  tw_factor[3] = psi[20];
        3'd3:  tw_factor[3] = psi[52];
        3'd4:  tw_factor[3] = psi[12];
        3'd5:  tw_factor[3] = psi[44];
        3'd6:  tw_factor[3] = psi[28];
        3'd7:  tw_factor[3] = psi[60];
    endcase

    case (tw_factor_5th_stage_mux_sel)
        4'd0:  tw_factor[4] = psi[2];
        4'd1:  tw_factor[4] = psi[34];
        4'd2:  tw_factor[4] = psi[18];
        4'd3:  tw_factor[4] = psi[50];
        4'd4:  tw_factor[4] = psi[10];
        4'd5:  tw_factor[4] = psi[42];
        4'd6:  tw_factor[4] = psi[26];
        4'd7:  tw_factor[4] = psi[58];
        4'd8:  tw_factor[4] = psi[6];
        4'd9:  tw_factor[4] = psi[38];
        4'd10: tw_factor[4] = psi[22];
        4'd11: tw_factor[4] = psi[54];
        4'd12: tw_factor[4] = psi[14];
        4'd13: tw_factor[4] = psi[46];
        4'd14: tw_factor[4] = psi[30];
        4'd15: tw_factor[4] = psi[62];
    endcase

    case (tw_factor_6th_stage_mux_sel)
        5'd0:  tw_factor[5] =  psi[1];
        5'd1:  tw_factor[5] =  psi[33];
        5'd2:  tw_factor[5] =  psi[17];
        5'd3:  tw_factor[5] =  psi[49];
        5'd4:  tw_factor[5] =  psi[9];
        5'd5:  tw_factor[5] =  psi[41];
        5'd6:  tw_factor[5] =  psi[25];
        5'd7:  tw_factor[5] =  psi[57];
        5'd8:  tw_factor[5] =  psi[5];
        5'd9:  tw_factor[5] =  psi[37];
        5'd10: tw_factor[5] =  psi[21];
        5'd11: tw_factor[5] =  psi[53];
        5'd12: tw_factor[5] =  psi[13];
        5'd13: tw_factor[5] =  psi[45];
        5'd14: tw_factor[5] =  psi[29];
        5'd15: tw_factor[5] =  psi[61];
        5'd16: tw_factor[5] =  psi[3];
        5'd17: tw_factor[5] =  psi[35];
        5'd18: tw_factor[5] =  psi[19];
        5'd19: tw_factor[5] =  psi[51];
        5'd20: tw_factor[5] =  psi[11];
        5'd21: tw_factor[5] =  psi[43];
        5'd22: tw_factor[5] =  psi[27];
        5'd23: tw_factor[5] =  psi[59];
        5'd24: tw_factor[5] =  psi[7];
        5'd25: tw_factor[5] =  psi[39];
        5'd26: tw_factor[5] =  psi[23];
        5'd27: tw_factor[5] =  psi[55];
        5'd28: tw_factor[5] =  psi[15];
        5'd29: tw_factor[5] =  psi[47];
        5'd30: tw_factor[5] =  psi[31];
        5'd31: tw_factor[5] =  psi[63];
    endcase
end


// Generate Loop for SDF Stages
generate
for (i = 0; i < 6; i = i + 1) begin : sdf_stages

sdf_single_stage #(.data_width(data_width), .index(5 - i), .modulo(modulo)) sdf_stage_inst (
.stage_in(stage_in[i]),
.clk(clk),
.rst_n(rst_n),
.tw_factor(tw_factor[i]),
.stage_out(stage_in[i+1]),
.buffer_out_mux_selector((i == 0) ? buffer_out_mux_selector_stage1 :
                         (i == 1) ? buffer_out_mux_selector_stage2 :
                         (i == 2) ? buffer_out_mux_selector_stage3 :
                         (i == 3) ? buffer_out_mux_selector_stage4 :
                         (i == 4) ? buffer_out_mux_selector_stage5 :
                                    buffer_out_mux_selector_stage6), 

.buffer_in_mux_selector((i == 0) ?  buffer_in_mux_selector_stage1:
                        (i == 1) ? buffer_in_mux_selector_stage2 :
                        (i == 2) ? buffer_in_mux_selector_stage3 :
                        (i == 3) ? buffer_in_mux_selector_stage4 :
                        (i == 4) ? buffer_in_mux_selector_stage5 :
                                   buffer_in_mux_selector_stage6)
);
end
endgenerate

endmodule


