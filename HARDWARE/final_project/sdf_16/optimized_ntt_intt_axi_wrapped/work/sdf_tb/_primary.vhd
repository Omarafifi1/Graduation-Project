library verilog;
use verilog.vl_types.all;
entity sdf_tb is
    generic(
        data_width      : integer := 32;
        modulo          : integer := 7681;
        address_width   : integer := 4
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
    attribute mti_svvh_generic_type of address_width : constant is 1;
end sdf_tb;
