module top_tb;
parameter data_width=32,modulo=7681,address_width=4 ;
localparam T=10;


reg ntt_logic_enable_tb,intt_logic_enable_tb ,start_tb;
reg clk_tb ,rst_n_tb;
wire[data_width-1:0]sdf_out_tb , sdf_in_tb;
wire done_tick_tb , data_valid_tb , busy_tb;
wire [address_width-1:0]out_address_tb , in_address_tb;



design_1_wrapper #(.data_width(data_width)  , .modulo(modulo) , .address_width(address_width) ) design_1_wrapper_tb_dut
(

.clk(clk_tb),
.rst_n(rst_n_tb),
.sdf_out(sdf_out_tb),
.sdf_in(sdf_in_tb),
.ntt_logic_enable(ntt_logic_enable_tb),
.intt_logic_enable(intt_logic_enable_tb),
.out_address(out_address_tb),
.in_address(in_address_tb),
.done_tick(done_tick_tb),
.data_valid(data_valid_tb),
.start(start_tb),
.busy(busy_tb)
);


//////////////////////////////////////////////////////
//                  initial block                  //
////////////////////////////////////////////////////
initial 
begin
ntt_logic_enable_tb=1;
intt_logic_enable_tb=0;
start_tb=0;
#(2*T);
start_tb=1;
#(2*T);
start_tb=0;

wait(done_tick_tb==1)
#(5*T);
ntt_logic_enable_tb=0;
intt_logic_enable_tb=1;
start_tb=0;
#(2*T);
start_tb=1;
#(2*T);
start_tb=0;

wait(done_tick_tb==1)
#(5*T);
$stop;
end

initial begin

reset;
end

//////////////////////////////////////////////////////
//                 clock generation                //
////////////////////////////////////////////////////
always 
begin
clk_tb=0;
#(T/2);
clk_tb=1;
#(T/2);
end
//////////////////////////////////////////////////////
//                    reset task                   //
////////////////////////////////////////////////////
task reset;
begin
rst_n_tb=0;
#2;
rst_n_tb=1;
end
endtask

endmodule




 
