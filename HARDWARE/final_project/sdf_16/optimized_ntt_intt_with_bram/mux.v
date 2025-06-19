module mux #(parameter data_width = 64)(
  input [data_width-1:0]in0,in1,
  input sel,
  output [data_width-1:0]out
);
assign out=sel?in1:in0;
endmodule


