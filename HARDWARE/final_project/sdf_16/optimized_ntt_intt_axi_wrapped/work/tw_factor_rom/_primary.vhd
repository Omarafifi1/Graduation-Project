library verilog;
use verilog.vl_types.all;
entity tw_factor_rom is
    generic(
        addr_width      : integer := 3;
        data_width      : integer := 64
    );
    port(
        psi_1           : out    vl_logic_vector;
        psi_2           : out    vl_logic_vector;
        psi_3           : out    vl_logic_vector;
        psi_4           : out    vl_logic_vector;
        psi_5           : out    vl_logic_vector;
        psi_6           : out    vl_logic_vector;
        psi_7           : out    vl_logic_vector;
        psi_8           : out    vl_logic_vector;
        psi_9           : out    vl_logic_vector;
        psi_10          : out    vl_logic_vector;
        psi_11          : out    vl_logic_vector;
        psi_12          : out    vl_logic_vector;
        psi_13          : out    vl_logic_vector;
        psi_14          : out    vl_logic_vector;
        psi_15          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of addr_width : constant is 1;
    attribute mti_svvh_generic_type of data_width : constant is 1;
end tw_factor_rom;
