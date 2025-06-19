module sdf_tb;
parameter data_width=64,modulo=7681,addr_width=3 , n=8;
localparam T=10;

reg [data_width-1:0]sdf_in_tb;
reg enable_tb;
reg clk_tb ,rst_n_tb;
wire[data_width-1:0]sdf_out_tb;
wire done_tick_tb;

reg [data_width-1:0]sdf_in_mem[0:(n-1)];     //n is the polynomial size
                                            // this rom contains the input of the sdf 

reg [data_width-1:0]sdf_out_mem[0:(n-1)];    //n is the polynomial size
                                            // this rom stores the output of the sdf to compare it with golden model

reg [data_width-1:0]expected_sdf_out_mem[0:(n-1)];    //n is the polynomial size
                                                     // this rom contains the output of golden model


sdf_top #(.data_width(data_width)  , .modulo(modulo) , .addr_width(addr_width) ) sdf_tb_dut
(
.sdf_in(sdf_in_tb),
.clk(clk_tb),
.rst_n(rst_n_tb),
.sdf_out(sdf_out_tb),
.enable(enable_tb),
.done_tick(done_tick_tb)
);


//////////////////////////////////////////////////////
//                  initial block                  //
////////////////////////////////////////////////////
initial begin
    $readmemh("expected_sdf_out.txt",expected_sdf_out_mem);
    $readmemh("sdf_in_mem.txt",sdf_in_mem);
end

initial begin
enable_tb=1;
reset;
read_sdf_inputs;
wait(done_tick_tb==1)
@(posedge clk_tb)
$stop;
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
///////////////////////////////////////////////////////
//                read sdf inputs task              //
/////////////////////////////////////////////////////
task read_sdf_inputs;
integer i;
begin
for (i=0 ; i<n ; i=i+1 ) begin
    sdf_in_tb=sdf_in_mem[i];
    @(posedge clk_tb);
    
end
end
endtask 


endmodule




 
