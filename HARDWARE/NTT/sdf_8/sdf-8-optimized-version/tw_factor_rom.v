module tw_factor_rom #(parameter addr_width = 3 , data_width = 64)(
  input  clk,rst_n,
  output reg [data_width-1:0] psi_1,psi_2,psi_3,psi_4,psi_5,psi_6,psi_7
);
(*rom_style = "block"*)reg [data_width-1:0]tw_rom[0:(2**addr_width)-1] ;
initial begin
  $readmemh("tw_rom.mem",tw_rom);
end

always @(posedge clk , negedge rst_n) begin
  if(!rst_n)begin
    psi_1<=64'd0;
    psi_2<=64'd0;
    psi_3<=64'd0;
    psi_4<=64'd0;
    psi_5<=64'd0;
    psi_6<=64'd0;
    psi_7<=64'd0;
  end
  else begin
    psi_1<=tw_rom[0];
    psi_2<=tw_rom[1];
    psi_3<=tw_rom[2];
    psi_4<=tw_rom[3];
    psi_5<=tw_rom[4];
    psi_6<=tw_rom[5];
    psi_7<=tw_rom[6];
  end
end


endmodule