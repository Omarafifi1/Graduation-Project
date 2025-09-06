module sdf_tb;
parameter data_width=32,modulo=7681,address_width=4 ;
localparam T=10;

reg [data_width-1:0]sdf_in_tb;
reg ntt_logic_enable_tb,intt_logic_enable_tb ,start_tb;
reg clk_tb ,rst_n_tb;
wire[data_width-1:0]sdf_out_tb;
wire done_tick_tb , data_valid_tb , busy_tb;
wire [address_width-1:0]out_address_tb , in_address_tb;

reg [data_width-1:0]sdf_in_mem[0:(2**address_width)-1];     //n is the polynomial size
                                                           // this rom contains the input of the sdf 

reg [data_width-1:0]sdf_out_mem[0:(2**address_width)-1];    //n is the polynomial size
                                                           // this rom stores the output of the sdf to compare it with golden model

reg [data_width-1:0]expected_sdf_out_mem[0:(2**address_width)-1];    //n is the polynomial size
                                                                    // this rom contains the output of golden model


sdf_top #(.data_width(data_width)  , .modulo(modulo) , .address_width(address_width) ) sdf_tb_dut
(
.sdf_in(sdf_in_tb),
.clk(clk_tb),
.rst_n(rst_n_tb),
.sdf_out(sdf_out_tb),
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
start_tb=0;
#(2*T);
start_tb=1;
#(2*T);
start_tb=0;
end

initial 
begin
#(2*T);
read_sdf_inputs;    
end

initial begin
ntt_logic_enable_tb=0;
intt_logic_enable_tb=1;
reset;

wait(done_tick_tb==1)
#(5*T);
check_sdf_output;
$stop;
end

initial begin
    if (ntt_logic_enable_tb) begin
        $readmemh("ntt_expected_sdf_out_NO.txt",expected_sdf_out_mem);
        $readmemh("ntt_sdf_in_mem.txt",sdf_in_mem);
    end
    else if ( intt_logic_enable_tb ) begin
        $readmemh("intt_expected_sdf_out_NO.txt",expected_sdf_out_mem);
        $readmemh("intt_sdf_in_mem.txt",sdf_in_mem);
    end
end

initial begin
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
for (i=0 ; i<(2**address_width) ; i=i+1 ) begin
    sdf_in_tb=sdf_in_mem[i];
    #1;
    @(negedge clk_tb);   
end
end
endtask 
///////////////////////////////////////////////////////
//                store sdf outputs task            //
/////////////////////////////////////////////////////
task store_sdf_outputs;
integer i , j;
parameter buffer_size_of_first_stage=8;
parameter size = 16;
begin
wait(sdf_tb_dut.cu_dut.counter==(8+(size-1)+buffer_size_of_first_stage+4))  //4 the accumulated latency of the last stage due to the flip flop inserted at the input of the sdf stage  
for (i=0 ; i<((2**address_width)/2) ; i=i+1 ) begin
    @(posedge clk_tb);
    sdf_out_mem[out_address_tb]=sdf_out_tb;  
end
wait(sdf_tb_dut.cu_dut.counter==(12+(size-1)+(size/2)+buffer_size_of_first_stage+4)) //4 the accumulated latency of the last stage
for (j=0 ; j<((2**address_width)/2) ; j=j+1) begin
    @(posedge clk_tb);
    sdf_out_mem[out_address_tb]=sdf_out_tb;    
end
end
endtask 
///////////////////////////////////////////////////////
//                check sdf output task             //
/////////////////////////////////////////////////////
task check_sdf_output;
integer i;
begin
for (i=0 ; i<(2**address_width) ; i=i+1 ) begin
    if(sdf_out_mem[i]==expected_sdf_out_mem[i])
    $display("test case %d succeeded : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_out_mem[i] );
    else
    $display("test case %d failed : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_out_mem[i]);
end
end
endtask 

endmodule




 
