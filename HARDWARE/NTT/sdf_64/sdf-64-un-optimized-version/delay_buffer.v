module delay_buffer #(parameter data_width = 64, index = 2, depth = (2**index)) (
  input [data_width-1:0] buffer_in,
  input clk, rst_n,
  output [data_width-1:0] buffer_out
  
);

reg [data_width-1:0]buffer_mem[0:depth-1];  

assign buffer_out=buffer_mem[depth-1];       


integer i;
always @ (posedge clk , negedge rst_n) begin
  if (!rst_n) begin
    // Reset buffer memory
    for (i = 0; i < depth; i = i + 1) begin
      buffer_mem[i] <= 0;
    end
  end 
  else begin
    // Shift register logic
    buffer_mem[0] <= buffer_in;   
    for (i = 1; i < depth; i = i + 1) begin
      buffer_mem[i] <= buffer_mem[i-1];  
    end
  end
end

endmodule
