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
        a_mod_add_out_mux_sel: in     vl_logic;
        b_reg4_mux_sel  : in     vl_logic;
        mod_add_out_reg4_mux_sel: in     vl_logic;
        b_mod_sub_out_mux_sel: in     vl_logic;
        a_mod_mul_out_mux_sel: in     vl_logic;
        mod_sub_out_mod_mul_out_mux_sel: in     vl_logic;
        intt_logic_enable: in     vl_logic;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        bfu_out_1       : out    vl_logic_vector;
        bfu_out_2       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
end bfu;
