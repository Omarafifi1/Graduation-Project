

module sdf_tb;
parameter data_width=64,modulo=7681,addr_width=6 , n=8;
localparam T=10;

reg [data_width-1:0]sdf_in_tb;
reg enable_tb;
reg clk_tb ,rst_n_tb;
wire[data_width-1:0]sdf_out_tb;
wire done_tick_tb;

reg [data_width-1:0]sdf_in_mem[0:(2**addr_width)-1];     //n is the polynomial size
                                            // this rom contains the input of the sdf 

reg [data_width-1:0]sdf_out_mem[0:(2**addr_width)-1];    //n is the polynomial size
                                            // this rom stores the output of the sdf to compare it with golden model

reg [data_width-1:0]expected_sdf_out_mem[0:(2**addr_width)-1];    //n is the polynomial size
                                                     // this rom contains the output of golden model


sdf_top #(.data_width(data_width)  , .modulo(modulo) , .addr_width(addr_width) ) sdf_dut
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
    $readmemh("expected_sdf_out_BO_hexa.txt",expected_sdf_out_mem);
    $readmemh("sdf_in_mem.txt",sdf_in_mem);
end

initial begin
enable_tb=1;
reset;
read_sdf_inputs;
wait(done_tick_tb==1)
@(posedge clk_tb)
#(T);
check_sdf_output;
$stop;
end

initial begin
wait(sdf_dut.cu_dut.counter==((2**addr_width)))
store_sdf_outputs;
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
for (i=0 ; i<(2**addr_width) ; i=i+1 ) begin
    sdf_in_tb=sdf_in_mem[i];
    @(posedge clk_tb);
    
end
end
endtask 
///////////////////////////////////////////////////////
//                store sdf outputs task            //
/////////////////////////////////////////////////////
task store_sdf_outputs;
integer i;
begin
for (i=0 ; i<(2**addr_width) ; i=i+1 ) begin
    sdf_out_mem[i]=sdf_out_tb;  
    @(posedge clk_tb);
end
end
endtask 
///////////////////////////////////////////////////////
//                check sdf output task             //
/////////////////////////////////////////////////////
task check_sdf_output;
integer i;
begin
for (i=0 ; i<(2**addr_width) ; i=i+1 ) begin
    if(sdf_out_mem[i]==expected_sdf_out_mem[i])
    $display("test case %d succeeded : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_out_mem[i] );
    else
    $display("test case %d failed : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_out_mem[i]);
end
end
endtask 

endmodule




 
