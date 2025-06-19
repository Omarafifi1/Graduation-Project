library verilog;
use verilog.vl_types.all;
entity bfu is
    generic(
        data_width      : integer := 64;
        modulo          : integer := 7681
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        tw_factor       : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        mod_add_out     : out    vl_logic_vector;
        mod_sub_out     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
end bfu;
