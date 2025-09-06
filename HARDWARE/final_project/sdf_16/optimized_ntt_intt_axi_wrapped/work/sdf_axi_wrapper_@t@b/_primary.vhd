library verilog;
use verilog.vl_types.all;
entity sdf_axi_wrapper_TB is
    generic(
        DATA_WIDTH      : integer := 32;
        ADDR_WIDTH      : integer := 5;
        modulo          : integer := 7681;
        ntt_logic_enable: integer := 0;
        intt_logic_enable: integer := 1
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
    attribute mti_svvh_generic_type of ntt_logic_enable : constant is 1;
    attribute mti_svvh_generic_type of intt_logic_enable : constant is 1;
end sdf_axi_wrapper_TB;
