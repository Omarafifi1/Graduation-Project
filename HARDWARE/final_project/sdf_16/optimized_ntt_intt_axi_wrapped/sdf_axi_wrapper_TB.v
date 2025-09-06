module sdf_axi_wrapper_TB #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,
    parameter modulo     = 7681,
    parameter ntt_logic_enable=0 , intt_logic_enable=1
);
    // Global signals
    reg                            s_axi_aclk_tb;
    reg                            s_axi_aresetn_tb;
    
    // Write address channel
    reg   [ADDR_WIDTH-1:0]         s_axi_awaddr_tb;
    reg                            s_axi_awvalid_tb;
    wire                           s_axi_awready_tb;
    
    // Write data channel
    reg     [DATA_WIDTH-1:0]       s_axi_wdata_tb;
    //reg   [3:0]                  s_axi_wstrb_tb;
    reg                            s_axi_wvalid_tb;
    wire                           s_axi_wready_tb;
    
    // Write response channel
    wire  [1:0]                    s_axi_bresp_tb;
    wire                           s_axi_bvalid_tb;
    reg                            s_axi_bready_tb;
    
    // Read address channel
    reg   [ADDR_WIDTH-1:0]         s_axi_araddr_tb;
    reg                            s_axi_arvalid_tb;
    wire                           s_axi_arready_tb;
    
    // Read data channel
    wire  [DATA_WIDTH-1:0]         s_axi_rdata_tb;
    wire  [1:0]                    s_axi_rresp_tb;
    wire                           s_axi_rvalid_tb;
    reg                            s_axi_rready_tb ;   

reg [DATA_WIDTH-1:0]sdf_in_mem[0:15];     //n is the polynomial size
                                                           // this rom contains the input of the sdf 
reg [DATA_WIDTH-1:0]expected_sdf_out_mem[0:15];    //n is the polynomial size
                                                                    // this rom contains the output of golden model

integer i , j ,k ,w;
localparam T=10;

sdf_axi_wrapper #(
     .DATA_WIDTH(DATA_WIDTH),
     .ADDR_WIDTH(ADDR_WIDTH),
     .modulo(modulo)
)sdf_axi_wrapper(

.s_axi_aclk(s_axi_aclk_tb),
.s_axi_aresetn(s_axi_aresetn_tb),

.s_axi_awaddr(s_axi_awaddr_tb),
.s_axi_awvalid(s_axi_awvalid_tb),
.s_axi_awready(s_axi_awready_tb),
   
.s_axi_wdata(s_axi_wdata_tb),
.s_axi_wvalid(s_axi_wvalid_tb),
.s_axi_wready(s_axi_wready_tb),

.s_axi_bresp(s_axi_bresp_tb),
.s_axi_bvalid(s_axi_bvalid_tb),
.s_axi_bready(s_axi_bready_tb),

.s_axi_araddr(s_axi_araddr_tb),
.s_axi_arvalid(s_axi_arvalid_tb),
.s_axi_arready(s_axi_arready_tb),

.s_axi_rdata(s_axi_rdata_tb),
.s_axi_rresp(s_axi_rresp_tb),
.s_axi_rvalid(s_axi_rvalid_tb),
.s_axi_rready(s_axi_rready_tb)   
);
//////////////////////////////////////////////////////
//                 clock generation                //
////////////////////////////////////////////////////
always 
begin
s_axi_aclk_tb=0;
#(T/2);
s_axi_aclk_tb=1;
#(T/2);
end
//////////////////////////////////////////////////////
//                    reset task                   //
////////////////////////////////////////////////////
task reset;
begin
s_axi_aresetn_tb=0;
#(2*T);
s_axi_aresetn_tb=1;
end
endtask 
//////////////////////////////////////////////////////////////
//                    write address task                   //
////////////////////////////////////////////////////////////
task write_address;
input [ADDR_WIDTH-1:0]write_address;
begin
    s_axi_awaddr_tb=write_address;
    s_axi_awvalid_tb=1;
    @(negedge s_axi_awready_tb);
    @(negedge s_axi_aclk_tb);
    s_axi_awvalid_tb=0;
    s_axi_awaddr_tb=0;
    #(2*T);
end
endtask
//////////////////////////////////////////////////////////////
//                     write data task                     //
////////////////////////////////////////////////////////////
task write_data;
input [DATA_WIDTH-1:0]write_data;
begin
    s_axi_wdata_tb=write_data;
    s_axi_wvalid_tb=1;
    @(negedge s_axi_wready_tb)
    @(negedge s_axi_aclk_tb);
    s_axi_wvalid_tb=0;
    s_axi_wdata_tb=0;
    #(2*T);
end
endtask
//////////////////////////////////////////////////////////////////
//                     write response task                     //
////////////////////////////////////////////////////////////////
task write_response;
input bready_signal;
begin
    s_axi_bready_tb=bready_signal;
end
endtask

///////////////////////////////////////////////////////////
//                    read address task                 //
/////////////////////////////////////////////////////////
task read_address;
input [ADDR_WIDTH-1:0]read_address;
begin
    s_axi_araddr_tb=read_address;
    s_axi_arvalid_tb=1;
    @(negedge s_axi_arready_tb)
    @(negedge s_axi_aclk_tb);
    s_axi_arvalid_tb=0;
    s_axi_araddr_tb=0;
    #(2*T);
end
endtask

//////////////////////////////////////////////////////////////
//                     read data task                      //
////////////////////////////////////////////////////////////
task read_data;
input rready_signal;
begin
    s_axi_rready_tb=rready_signal;
end
endtask


initial begin
    if (ntt_logic_enable) begin
        $readmemh("ntt_expected_sdf_out_NO.txt",expected_sdf_out_mem);
        $readmemh("ntt_sdf_in_mem.txt",sdf_in_mem);
    end
    else if ( intt_logic_enable) begin
        $readmemh("intt_expected_sdf_out_NO.txt",expected_sdf_out_mem);
        $readmemh("intt_sdf_in_mem.txt",sdf_in_mem);
    end
end
initial begin
    s_axi_awvalid_tb=0;
    s_axi_wvalid_tb=0;
    s_axi_arvalid_tb=0;
    s_axi_bready_tb=0;
    s_axi_rready_tb=0;
    reset;

end

initial begin
    wait(s_axi_aresetn_tb);
    @(negedge s_axi_aclk_tb);

    for (k=0  ;k<17 ;k=k+1 ) begin
        write_address(k);
    end

    #(2*T);
    write_address(6'd16);

    wait(sdf_axi_wrapper.done_tick)
    #(5*T);
    @(negedge s_axi_aclk_tb);

    read_address(6'd17);  
    for (w=0  ;w<16 ;w=w+1 ) begin
        read_address(w);
    end
  
    #(3*T); 
    for (i =0 ;i<16 ;i=i+1 ) begin     
        if(sdf_axi_wrapper.memory_map[i] == expected_sdf_out_mem[i])
            if (ntt_logic_enable) 
                $display("NTT test case %d succeeded : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_axi_wrapper.memory_map[i]);
            else if (intt_logic_enable)
                $display("INTT test case %d succeeded : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_axi_wrapper.memory_map[i]);
        else 
            if(ntt_logic_enable)
                $display("NTT test case %d failed : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_axi_wrapper.memory_map[i]);
            else if (intt_logic_enable)
                $display("INTT test case %d failed : expected ==> %d , got==> %d " ,i+1 , expected_sdf_out_mem[i] , sdf_axi_wrapper.memory_map[i]);
        end
    $stop;
end

initial begin
    wait(s_axi_aresetn_tb);
    @(negedge s_axi_aclk_tb);

    for (j=0  ;j<16 ;j=j+1 ) begin
        write_data(sdf_in_mem[j]);
    end

    if (ntt_logic_enable) begin
        write_data(32'd5);//101 for ntt  
        #(2*T)
        write_data(32'd4);//100 for ntt  
    end
    else if ( intt_logic_enable) begin
        write_data(32'd3);// 011 for intt
        #(2*T)
        write_data(32'd2);// 010 for intt
    end
end

initial begin
    wait(s_axi_aresetn_tb);
    write_response(1);
    read_data(1);
end

endmodule