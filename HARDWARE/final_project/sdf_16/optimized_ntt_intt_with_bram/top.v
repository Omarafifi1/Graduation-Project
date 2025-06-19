module top #(parameter data_width = 32  , modulo=7681 , address_width=4  )(
    input ntt_logic_enable,intt_logic_enable, start,
    input clk ,rst_n,
    output[data_width-1:0]sdf_out,sdf_in,
    output done_tick,data_valid,busy,
    output [address_width-1:0]out_address , in_address
);


dual_port_bram bram(
.clk(clk),
.addr_a(in_address),
.dout_a(sdf_in),
.addr_b(out_address),
.din_b(sdf_out),
.we_b(data_valid)
);

sdf_top #(.data_width(data_width)  , .modulo(modulo) , .address_width(address_width) ) sdf_tb_dut
(
.sdf_in(sdf_in),
.clk(clk),
.rst_n(rst_n),
.sdf_out(sdf_out),
.ntt_logic_enable(ntt_logic_enable),
.intt_logic_enable(intt_logic_enable),
.out_address(out_address),
.in_address(in_address),
.done_tick(done_tick),
.data_valid(data_valid),
.start(start),
.busy(busy)
);

endmodule