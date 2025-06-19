module mod_addition_reduction #(parameter data_size = 64 , prime_number = 7681)
(
	input  signed[data_size-1:0] X,
    output reg  [data_size-1:0] X_reduction
);

always @ (*) begin
	if (X>prime_number) begin
		X_reduction = X - prime_number ;
	end
	else begin
		X_reduction = X ;
	end
end

endmodule


