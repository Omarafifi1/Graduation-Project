def bit_reversed_order(input_file, output_file, bit_width):
    def bit_reverse_index(index, bit_width):
        reversed_bin = bin(index)[2:].zfill(bit_width)[::-1]  # Reverse the binary representation
        return int(reversed_bin, 2)

    # Read numbers from input file
    with open(input_file, "r") as file:
        numbers = [int(line.strip()) for line in file]

    # Ensure the list length matches 2^bit_width
    expected_length = 2 ** bit_width
    if len(numbers) != expected_length:
        raise ValueError(f"Expected {expected_length} numbers, but got {len(numbers)}.")

    # Generate bit-reversed indices and reorder the list
    reordered_numbers = [0] * expected_length
    for i in range(expected_length):
        reversed_index = bit_reverse_index(i, bit_width)
        reordered_numbers[reversed_index] = numbers[i]

    # Write the reordered numbers to the output file
    with open(output_file, "w") as file:
        for num in reordered_numbers:
            file.write(f"{num}\n")

    print(f"Reordered numbers saved to {output_file}")

# Example usage
input_file = "expected_sdf_out_NO.txt"   # File containing numbers (one per line)
output_file = "expected_sdf_out_BO.txt"   # File to store bit-reversed order
bit_width = 4  # Log2 of the number of elements (e.g., 3 for 8 elements)

bit_reversed_order(input_file, output_file, bit_width)
