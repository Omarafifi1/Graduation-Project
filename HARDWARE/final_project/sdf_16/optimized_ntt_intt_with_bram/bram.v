module dual_port_bram #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 4,
    parameter RAM_DEPTH = 16
)(
    input wire clk,

    // Port A
    input wire [ADDR_WIDTH-1:0] addr_a,
    output reg [DATA_WIDTH-1:0] dout_a,

    // Port B
    input wire [ADDR_WIDTH-1:0] addr_b,
    input wire [DATA_WIDTH-1:0] din_b,
    input wire we_b
);


    // Shared RAM
    reg [DATA_WIDTH-1:0] ram [0:RAM_DEPTH-1];

    // Port A operation

initial begin
ram[0]=32'h1;
ram[1]=32'h2;
ram[2]=32'h3;
ram[3]=32'h4;
ram[4]=32'h5;
ram[5]=32'h6;
ram[6]=32'h7;
ram[7]=32'h8;
ram[8]=32'h9;
ram[9]=32'ha;
ram[10]=32'hb;
ram[11]=32'hc;
ram[12]=32'hd;
ram[13]=32'he;
ram[14]=32'hf;
ram[15]=32'h1;
end
    always @(posedge clk) begin
            dout_a <= ram[addr_a];
    end

    // Port B operation
    always @(posedge clk) begin
        if (we_b)
            ram[addr_b] <= din_b;
    end

endmodule