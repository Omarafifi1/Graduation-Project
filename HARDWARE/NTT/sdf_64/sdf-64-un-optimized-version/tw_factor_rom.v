module tw_factor_rom #(parameter addr_width = 6 , data_width = 64)(
  output [data_width*(2**addr_width-1)-1:0] psi_out   
);
// Declare ROM with "distributed" memory style for vivado to tell it to use lut for this rom as vivado dont read "readmemh" in synthesis only in sim 
// so when viv reads this attribute it will use lut instead of creating a rom 
// also take care that if u have a synch ram/rom u have to use ip brams in vivado 
(* rom_style = "distributed" *) reg [data_width-1:0]tw_rom[0:(2**addr_width)-1] ;

initial begin
  tw_rom[0]  = 64'h0AA4;
  tw_rom[1]  = 64'h014A;
  tw_rom[2]  = 64'h00F3;
  tw_rom[3]  = 64'h0556;
  tw_rom[4]  = 64'h0D34;
  tw_rom[5]  = 64'h14A2;
  tw_rom[6]  = 64'h0677;
  tw_rom[7]  = 64'h1BF2;
  tw_rom[8]  = 64'h031F;
  tw_rom[9]  = 64'h0AC1;
  tw_rom[10] = 64'h09D4;
  tw_rom[11] = 64'h0854;
  tw_rom[12] = 64'h02DC;
  tw_rom[13] = 64'h11ED;
  tw_rom[14] = 64'h0D79;
  tw_rom[15] = 64'h04BD;
  tw_rom[16] = 64'h0566;
  tw_rom[17] = 64'h036E;
  tw_rom[18] = 64'h0B41;
  tw_rom[19] = 64'h15A7;
  tw_rom[20] = 64'h174F;
  tw_rom[21] = 64'h0458;
  tw_rom[22] = 64'h0AD6;
  tw_rom[23] = 64'h1741;
  tw_rom[24] = 64'h0565;
  tw_rom[25] = 64'h16CB;
  tw_rom[26] = 64'h09F7;
  tw_rom[27] = 64'h14B4;
  tw_rom[28] = 64'h11F9;
  tw_rom[29] = 64'h1525;
  tw_rom[30] = 64'h1435;
  tw_rom[31] = 64'h10CA;
  tw_rom[32] = 64'h0774;
  tw_rom[33] = 64'h13AC;
  tw_rom[34] = 64'h1D37;
  tw_rom[35] = 64'h0AE0;
  tw_rom[36] = 64'h09A5;
  tw_rom[37] = 64'h1249;
  tw_rom[38] = 64'h0248;
  tw_rom[39] = 64'h0351;
  tw_rom[40] = 64'h02B7;
  tw_rom[41] = 64'h0E46;
  tw_rom[42] = 64'h19C9;
  tw_rom[43] = 64'h1DA0;
  tw_rom[44] = 64'h11FF;
  tw_rom[45] = 64'h18FB;
  tw_rom[46] = 64'h1BF1;
  tw_rom[47] = 64'h167C;
  tw_rom[48] = 64'h0977;
  tw_rom[49] = 64'h08E1;
  tw_rom[50] = 64'h02FE;
  tw_rom[51] = 64'h13A9;
  tw_rom[52] = 64'h1B4C;
  tw_rom[53] = 64'h0702;
  tw_rom[54] = 64'h06CC;
  tw_rom[55] = 64'h0247;
  tw_rom[56] = 64'h16AE;
  tw_rom[57] = 64'h016D;
  tw_rom[58] = 64'h0D53;
  tw_rom[59] = 64'h1473;
  tw_rom[60] = 64'h106C;
  tw_rom[61] = 64'h1B5E;
  tw_rom[62] = 64'h1284;
end

genvar i;
generate
  for(i=0 ; i<((2**addr_width)-1) ; i=i+1) begin: psi_gen_block
    assign psi_out[(data_width*(i+1))-1 : data_width*i]=tw_rom[i];
  end
endgenerate

endmodule