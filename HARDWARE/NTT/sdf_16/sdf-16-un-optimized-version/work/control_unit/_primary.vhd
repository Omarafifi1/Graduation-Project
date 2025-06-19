library verilog;
use verilog.vl_types.all;
entity control_unit is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        enable          : in     vl_logic;
        buffer_out_mux_selector_stage1: out    vl_logic;
        buffer_in_mux_selector_stage1: out    vl_logic;
        buffer_out_mux_selector_stage2: out    vl_logic;
        buffer_in_mux_selector_stage2: out    vl_logic;
        buffer_out_mux_selector_stage3: out    vl_logic;
        buffer_in_mux_selector_stage3: out    vl_logic;
        buffer_out_mux_selector_stage4: out    vl_logic;
        buffer_in_mux_selector_stage4: out    vl_logic;
        tw_factor_2nd_stage_mux_sel: out    vl_logic;
        tw_factor_3rd_stage_mux_sel: out    vl_logic_vector(1 downto 0);
        tw_factor_4th_stage_mux_sel: out    vl_logic_vector(2 downto 0);
        done_tick       : out    vl_logic
    );
end control_unit;
