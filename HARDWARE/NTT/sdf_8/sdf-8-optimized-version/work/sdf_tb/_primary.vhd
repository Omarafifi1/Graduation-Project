library verilog;
use verilog.vl_types.all;
entity sdf_tb is
    generic(
        data_width      : integer := 64;
        modulo          : integer := 7681;
        addr_width      : integer := 3;
        n               : integer := 8
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
    attribute mti_svvh_generic_type of addr_width : constant is 1;
    attribute mti_svvh_generic_type of n : constant is 1;
end sdf_tb;
