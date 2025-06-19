
import tw_factor_generator 
import tw_factor_rom 
import nega_cyclic_ntt_intt
import random
import read_sdf_in
import store_sdf_out
import sympy as sp


def main():
    files_path = "D:/study/digital/gp/NTT/HARDWARE/NTT_INTT/sdf_16/sdf-16-optimized-version/"
    q = int(input("Enter the prime modulus (q): "))
    
    user_input = input("Enter the input vector seperated by spaces : ")

    input_vector = user_input.split()  # Splits input by spaces

    # Converting list items to integers
    input_vector = [int(num) for num in input_vector]
    
    n=int(len(input_vector))

    read_sdf_in.sdf_in_mem(f"{files_path}ntt_sdf_in_mem.txt",input_vector , n)
    store_sdf_out.sdf_out_mem(f"{files_path}intt_expected_sdf_out_NO.txt",input_vector,n)

    # Find the primitive roots of unity
    omega = tw_factor_generator.find_primitive_root(q, n)
    psi = []

    # Calculate square roots modulo q
    for i in range(len(omega)):
        psi.append(sp.sqrt_mod(omega[i], q, all_roots=True))
        if psi == [[], []]:
            psi = 0
            break  

    # Display results
    if omega:
        print(f"The n-th primitive root of unity for prime modulus {q} is: {omega}")
    else:
        print(f"No n-th primitive root of unity is found for the given prime modulus {q}")
    
    if psi:
        print(f"The 2n-th primitive root of unity for prime modulus {q} is: {psi}")
    else:
        print(f"No 2n-th primitive root of unity is found for the given prime modulus {q}")

    # Flatten the list of psi values first
    flat_psi = [num for sublist in psi for num in sublist]  

    # Then select one randomly
    random_psi = random.choice(flat_psi)    

    print(f"randomly chosen psi is: {random_psi}")

    tw_factor_rom.tw_rom(f"{files_path}tw_rom.txt",random_psi,n,q)
    
    ntt  = nega_cyclic_ntt_intt.nega_cyclic_ntt (q , random_psi , input_vector)

    read_sdf_in.sdf_in_mem(f"{files_path}intt_sdf_in_mem.txt" , ntt , n)

    store_sdf_out.sdf_out_mem(f"{files_path}ntt_expected_sdf_out_NO.txt",ntt,n)

    
    intt = nega_cyclic_ntt_intt.nega_cyclic_intt(q , random_psi , ntt)

    print (f"nega_cyclic_ntt = {ntt}\nnega_cyclic_intt = {intt}")


    if intt==input_vector:
        print("the output from intt is same as the input vector , everthing is ok ")
    else:
        print("the output from intt is not the same  as the input vector , something wrong")

if __name__ == "__main__":
    main()
