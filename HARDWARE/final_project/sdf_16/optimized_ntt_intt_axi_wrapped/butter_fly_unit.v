module bfu #(parameter data_width = 64 , modulo=7681) (
  input [data_width-1:0]a , b,
  input [data_width-1:0]tw_factor,
  input a_mod_add_out_mux_sel,
  input b_reg4_mux_sel,
  input mod_add_out_reg4_mux_sel,
  input b_mod_sub_out_mux_sel,
  input a_mod_mul_out_mux_sel,
  input mod_sub_out_mod_mul_out_mux_sel,
  input intt_logic_enable,
  input clk , rst_n ,
  output[data_width-1:0]bfu_out_1 , bfu_out_2
);

parameter correction_factor=(modulo+1) >> 1;

wire [(data_width*2)-1:0] mod_mul_in;
wire [data_width-1:0]     mod_add_in, mod_sub_in;
wire [data_width-1:0]     mod_mul_out;
wire [data_width-1:0]     mod_add_out;
wire [data_width-1:0]     mod_sub_out;
wire [data_width-1:0]     a_mod_add_out_mux_out;
wire [data_width-1:0]     b_reg4_mux_out;
wire [data_width-1:0]     a_mod_mul_out_mux_out;
wire [data_width-1:0]     b_mod_sub_out_mux_out;
wire [data_width-1:0]     mod_add_out_reg4_mux_out;
wire [data_width-1:0]     mod_sub_out_mod_mul_out_mux_out;
wire [data_width-1:0]     mod_add_out_reg4_mux_out_shifted;
wire [data_width-1:0]     mod_sub_out_mod_mul_out_mux_out_shifted;    
wire [data_width-1:0]     bfu_out_1_intt , bfu_out_1_ntt;
wire [data_width-1:0]     bfu_out_2_intt , bfu_out_2_ntt;
reg  [data_width-1:0]     reg1 ,reg2 ,reg3 ,reg4;


mux #(.data_width(data_width)) a_mod_add_out_mux(
.in0(a),
.in1(mod_add_out),
.sel(a_mod_add_out_mux_sel),
.out(a_mod_add_out_mux_out)
);


always @(posedge clk , negedge rst_n) begin
  if(!rst_n)begin
    reg1<=0;
    reg2<=0;
    reg3<=0;
    reg4<=0;
  end
  else begin
    reg1<=a_mod_add_out_mux_out;
    reg2<=reg1;
    reg3<=reg2;
    reg4<=reg3;
  end
end


mux #(.data_width(data_width)) b_reg4_mux(
.in0(reg4),
.in1(b),
.sel(b_reg4_mux_sel),
.out(b_reg4_mux_out)
);

assign mod_add_in=b_reg4_mux_out+a_mod_mul_out_mux_out;
mod_addition_reduction #(
                    .data_size(data_width) , .prime_number(modulo) 
                    ) 
mod_add_dut 
(
.X(mod_add_in),
.X_reduction(mod_add_out)
);

mux #(.data_width(data_width)) mod_add_out_reg4_mux(
.in0(mod_add_out),
.in1(reg4),
.sel(mod_add_out_reg4_mux_sel),
.out(mod_add_out_reg4_mux_out)
);

assign mod_add_out_reg4_mux_out_shifted = mod_add_out_reg4_mux_out >> 1;
assign bfu_out_1_intt = (mod_add_out_reg4_mux_out[0])?(mod_add_out_reg4_mux_out_shifted + correction_factor) : mod_add_out_reg4_mux_out_shifted;
assign bfu_out_1_ntt = mod_add_out_reg4_mux_out;
assign bfu_out_1 = (intt_logic_enable) ? bfu_out_1_intt : bfu_out_1_ntt ;

mux #(.data_width(data_width)) b_mod_sub_out_mux(
.in0(b),
.in1(mod_sub_out),
.sel(b_mod_sub_out_mux_sel),
.out(b_mod_sub_out_mux_out)
);

assign mod_mul_in=b_mod_sub_out_mux_out*tw_factor;

barret_reduction #(
                .data_size(data_width) ,.prime_number(modulo)              
              )
barret_red_dut
(
.X(mod_mul_in),
.X_reduction(mod_mul_out),
.clk(clk),
.rst_n(rst_n)
);

mux #(.data_width(data_width)) a_mod_mul_out_mux(
.in0(mod_mul_out),
.in1(a),
.sel(a_mod_mul_out_mux_sel),
.out(a_mod_mul_out_mux_out)
);

assign mod_sub_in=b_reg4_mux_out-a_mod_mul_out_mux_out;

mod_subtraction_reduction #(
                    .data_size(data_width) , .prime_number(modulo) 
                    ) 
mod_sub_dut 
(
.X(mod_sub_in),
.X_reduction(mod_sub_out)
);
  
  
mux #(.data_width(data_width)) mod_sub_out_mod_mul_out_mux(
.in0(mod_sub_out),
.in1(mod_mul_out),
.sel(mod_sub_out_mod_mul_out_mux_sel),
.out(mod_sub_out_mod_mul_out_mux_out)
);

assign mod_sub_out_mod_mul_out_mux_out_shifted=mod_sub_out_mod_mul_out_mux_out>>1;
assign bfu_out_2_intt = (mod_sub_out_mod_mul_out_mux_out[0])?(mod_sub_out_mod_mul_out_mux_out_shifted + correction_factor) : mod_sub_out_mod_mul_out_mux_out_shifted;
assign bfu_out_2_ntt = mod_sub_out_mod_mul_out_mux_out;
assign bfu_out_2 = (intt_logic_enable) ? bfu_out_2_intt : bfu_out_2_ntt ;



endmodule