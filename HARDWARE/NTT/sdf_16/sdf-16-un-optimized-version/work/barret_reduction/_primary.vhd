library verilog;
use verilog.vl_types.all;
entity barret_reduction is
    generic(
        data_size       : integer := 64;
        prime_number    : integer := 7681;
        no_of_bits_of_prime_no: vl_notype;
        factor_approximate_div: vl_notype
    );
    port(
        X               : in     vl_logic_vector;
        X_reduction     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_size : constant is 1;
    attribute mti_svvh_generic_type of prime_number : constant is 1;
    attribute mti_svvh_generic_type of no_of_bits_of_prime_no : constant is 3;
    attribute mti_svvh_generic_type of factor_approximate_div : constant is 3;
end barret_reduction;
