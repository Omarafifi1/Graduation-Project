library verilog;
use verilog.vl_types.all;
entity mod_addition_reduction is
    generic(
        data_size       : integer := 64;
        prime_number    : integer := 7681
    );
    port(
        X               : in     vl_logic_vector;
        X_reduction     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_size : constant is 1;
    attribute mti_svvh_generic_type of prime_number : constant is 1;
end mod_addition_reduction;
