library verilog;
use verilog.vl_types.all;
entity tw_factor_rom is
    generic(
        addr_width      : integer := 6;
        data_width      : integer := 64
    );
    port(
        psi_out         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of addr_width : constant is 1;
    attribute mti_svvh_generic_type of data_width : constant is 1;
end tw_factor_rom;
