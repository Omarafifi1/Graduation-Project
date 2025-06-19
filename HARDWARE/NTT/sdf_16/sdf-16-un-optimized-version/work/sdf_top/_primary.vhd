library verilog;
use verilog.vl_types.all;
entity sdf_top is
    generic(
        data_width      : integer := 64;
        modulo          : integer := 7681;
        addr_width      : integer := 4
    );
    port(
        sdf_in          : in     vl_logic_vector;
        enable          : in     vl_logic;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sdf_out         : out    vl_logic_vector;
        done_tick       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
    attribute mti_svvh_generic_type of addr_width : constant is 1;
end sdf_top;
