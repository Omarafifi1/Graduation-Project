module barret_tb;
parameter data_size=64,modulo=7681,addr_width=3 , n=8;
localparam T=10;
reg  [(data_size*2)-1:0] X;
reg  clk,rst_n;
wire signed  [data_size-1:0] X_reduction;
barret_reduction uut
(
.X(X),
.clk(clk),
.rst_n(rst_n),
.X_reduction(X_reduction)
);


//////////////////////////////////////////////////////
//                  initial block                  //
////////////////////////////////////////////////////
initial begin
reset;
X=1233925;
#(15*T);
$stop;
end

//////////////////////////////////////////////////////
//                 clock generation                //
////////////////////////////////////////////////////
always 
begin
clk=0;
#(T/2);
clk=1;
#(T/2);
end
//////////////////////////////////////////////////////
//                    reset task                   //
////////////////////////////////////////////////////
task reset;
begin
rst_n=0;
#2;
rst_n=1;
end
endtask 


endmodule




 
