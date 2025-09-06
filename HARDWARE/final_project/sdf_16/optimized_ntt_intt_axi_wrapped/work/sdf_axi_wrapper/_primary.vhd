library verilog;
use verilog.vl_types.all;
entity sdf_axi_wrapper is
    generic(
        DATA_WIDTH      : integer := 32;
        ADDR_WIDTH      : integer := 5;
        modulo          : integer := 7681
    );
    port(
        s_axi_aclk      : in     vl_logic;
        s_axi_aresetn   : in     vl_logic;
        s_axi_awaddr    : in     vl_logic_vector;
        s_axi_awvalid   : in     vl_logic;
        s_axi_awready   : out    vl_logic;
        s_axi_wdata     : in     vl_logic_vector;
        s_axi_wvalid    : in     vl_logic;
        s_axi_wready    : out    vl_logic;
        s_axi_bresp     : out    vl_logic_vector(1 downto 0);
        s_axi_bvalid    : out    vl_logic;
        s_axi_bready    : in     vl_logic;
        s_axi_araddr    : in     vl_logic_vector;
        s_axi_arvalid   : in     vl_logic;
        s_axi_arready   : out    vl_logic;
        s_axi_rdata     : out    vl_logic_vector;
        s_axi_rresp     : out    vl_logic_vector(1 downto 0);
        s_axi_rvalid    : out    vl_logic;
        s_axi_rready    : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of modulo : constant is 1;
end sdf_axi_wrapper;
