library verilog;
use verilog.vl_types.all;
entity delay_buffer is
    generic(
        data_width      : integer := 64;
        index           : integer := 2;
        depth           : vl_notype
    );
    port(
        buffer_in       : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        buffer_enable   : in     vl_logic;
        buffer_out      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of index : constant is 1;
    attribute mti_svvh_generic_type of depth : constant is 3;
end delay_buffer;
