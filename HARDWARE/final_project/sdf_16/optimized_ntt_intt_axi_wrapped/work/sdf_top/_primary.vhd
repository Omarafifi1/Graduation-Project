library verilog;
use verilog.vl_types.all;
entity sdf_top is
    generic(
        data_width      : integer := 32;
        modulo          : integer := 7681;
        address_width   : integer := 4
    );
    port(
        sdf_in          : in     vl_logic_vector;
        ntt_logic_enable: in     vl_logic;
        intt_logic_enable: in     vl_logic;
        start           : in     vl_logic;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sdf_out         : out    vl_logic_vector;
        done_tick       : out    vl_logic;
        data_valid      : out    vl_logic;
        busy            : out    vl_logic;
        out_address     : out    vl_logic_vector;
        in_address      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
    attribute mti_svvh_generic_type of address_width : constant is 1;
end sdf_top;
