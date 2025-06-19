module tw_factor_rom #(parameter addr_width = 3 , data_width = 32)(
  output [data_width-1:0] psi_1,psi_2,psi_3,psi_4,psi_5,psi_6,psi_7,psi_8,psi_9,psi_10,psi_11,psi_12,psi_13,psi_14,psi_15
);


assign psi_1=  32'h61; 
assign psi_2=  32'h6c0;
assign psi_3=  32'h18ab;
assign psi_4=  32'h167c;
assign psi_5=  32'h14b4;
assign psi_6=  32'h1bf2;
assign psi_7=  32'ha58;
assign psi_8=  32'hd37; 
assign psi_9=  32'h15ad;
assign psi_10= 32'h247;
assign psi_11= 32'hae0;
assign psi_12= 32'h4bd;
assign psi_13= 32'h98e;
assign psi_14= 32'h1ab0;
assign psi_15= 32'h85a;


endmodule