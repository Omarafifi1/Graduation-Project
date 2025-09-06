def sdf_out_mem (file_name, sdf_out_vector , n):
    file=open(file_name , "w")
    for i in range(0 , int((n))):
        sdf_out_vector_hex=f"{sdf_out_vector[i]:x}"  ##to convert to hex
        file.write(f"{sdf_out_vector_hex}\n")
    file.close()
