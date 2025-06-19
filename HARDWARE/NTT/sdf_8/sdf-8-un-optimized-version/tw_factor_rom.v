module tw_factor_rom #(parameter addr_width = 3 , data_width = 64)(
  output [data_width-1:0] psi_1,psi_2,psi_3,psi_4,psi_5,psi_6,psi_7
);
reg [data_width-1:0]tw_rom[0:(2**addr_width)-1] ;

initial begin
tw_rom[0]=64'h1bba; 
tw_rom[1]=64'h785;
tw_rom[2]=64'h1ab0;
tw_rom[3]=64'hd37;
tw_rom[4]=64'h6c0;
tw_rom[5]=64'h1944;
tw_rom[6]=64'h20f;
end


assign psi_1=tw_rom[0];
assign psi_2=tw_rom[1];
assign psi_3=tw_rom[2];
assign psi_4=tw_rom[3];
assign psi_5=tw_rom[4];
assign psi_6=tw_rom[5];
assign psi_7=tw_rom[6];

endmodule