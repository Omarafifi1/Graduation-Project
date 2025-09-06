library verilog;
use verilog.vl_types.all;
entity sdf_single_stage is
    generic(
        data_width      : integer := 64;
        index           : integer := 2;
        modulo          : integer := 7681
    );
    port(
        stage_in        : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        buffer_enable   : in     vl_logic;
        tw_factor       : in     vl_logic_vector;
        buffer_out_mux_selector: in     vl_logic;
        buffer_in_mux_selector: in     vl_logic;
        a_mod_add_out_mux_sel: in     vl_logic;
        b_reg4_mux_sel  : in     vl_logic;
        mod_add_out_reg4_mux_sel: in     vl_logic;
        b_mod_sub_out_mux_sel: in     vl_logic;
        a_mod_mul_out_mux_sel: in     vl_logic;
        mod_sub_out_mod_mul_out_mux_sel: in     vl_logic;
        intt_logic_enable: in     vl_logic;
        stage_out       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of index : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
end sdf_single_stage;
