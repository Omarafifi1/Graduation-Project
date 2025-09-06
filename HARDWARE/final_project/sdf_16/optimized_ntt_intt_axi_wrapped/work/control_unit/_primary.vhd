library verilog;
use verilog.vl_types.all;
entity control_unit is
    generic(
        address_width   : integer := 4
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        start           : in     vl_logic;
        ntt_logic_enable: in     vl_logic;
        intt_logic_enable: in     vl_logic;
        buffer_out_mux_selector_stage1: out    vl_logic;
        buffer_in_mux_selector_stage1: out    vl_logic;
        buffer_out_mux_selector_stage2: out    vl_logic;
        buffer_in_mux_selector_stage2: out    vl_logic;
        buffer_out_mux_selector_stage3: out    vl_logic;
        buffer_in_mux_selector_stage3: out    vl_logic;
        buffer_out_mux_selector_stage4: out    vl_logic;
        buffer_in_mux_selector_stage4: out    vl_logic;
        a_mod_add_out_mux_sel: out    vl_logic;
        b_reg4_mux_sel  : out    vl_logic;
        mod_add_out_reg4_mux_sel: out    vl_logic;
        b_mod_sub_out_mux_sel: out    vl_logic;
        a_mod_mul_out_mux_sel: out    vl_logic;
        mod_sub_out_mod_mul_out_mux_sel: out    vl_logic;
        ntt_tw_factor_2nd_stage_mux_sel: out    vl_logic;
        ntt_tw_factor_3rd_stage_mux_sel: out    vl_logic_vector(1 downto 0);
        ntt_tw_factor_4th_stage_mux_sel: out    vl_logic_vector(2 downto 0);
        intt_tw_factor_1st_stage_mux_sel: out    vl_logic_vector(2 downto 0);
        intt_tw_factor_2nd_stage_mux_sel: out    vl_logic_vector(1 downto 0);
        intt_tw_factor_3rd_stage_mux_sel: out    vl_logic;
        buffer_enable   : out    vl_logic;
        out_address     : out    vl_logic_vector;
        in_address      : out    vl_logic_vector;
        done_tick       : out    vl_logic;
        data_valid      : out    vl_logic;
        busy            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of address_width : constant is 1;
end control_unit;
