module bfu #(parameter data_width = 64 , modulo=7681) (
  input [data_width-1:0]a , b,
  input [data_width-1:0]tw_factor,
  output[data_width-1:0]mod_add_out , mod_sub_out
);

wire [(data_width*2)-1:0] mod_mul_in ;
wire [data_width-1:0] mod_add_in , mod_sub_in ;
wire [data_width-1:0]mod_mul_out;


assign mod_mul_in=b*tw_factor;

barret_reduction #(
                .data_size(data_width) ,.prime_number(modulo)              
              )
barret_red_dut
(
.X(mod_mul_in),
.X_reduction(mod_mul_out)
);

assign mod_add_in=a+mod_mul_out;
assign mod_sub_in=a-mod_mul_out;



mod_addition_reduction #(
                    .data_size(data_width) , .prime_number(modulo) 
                    ) 
mod_add_dut 
(
.X(mod_add_in),
.X_reduction(mod_add_out)
);



mod_subtraction_reduction #(
                    .data_size(data_width) , .prime_number(modulo) 
                    ) 
mod_sub_dut 
(
.X(mod_sub_in),
.X_reduction(mod_sub_out)
);
  
  


endmodule