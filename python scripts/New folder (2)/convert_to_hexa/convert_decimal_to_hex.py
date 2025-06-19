def convert_decimal_to_hex(input_file, output_file):
    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        for line in infile:
            num = int(line.strip())  # Read and convert to integer
            hex_num = format(num, "X")  # Convert to uppercase hexadecimal
            outfile.write(hex_num + "\n")  # Write to output file

    print(f"Hexadecimal values saved in {output_file}")

# Example usage
input_file = "sdf_in_mem.txt"  # File with decimal numbers (one per line)
output_file = "expected_sdf_out_BO.txt"     # Output file for hexadecimal values
convert_decimal_to_hex(input_file, output_file)



