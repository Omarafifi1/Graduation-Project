def sdf_in_mem (file_name , sdf_in_vector , n):
    file=open(file_name , "w")
    for i in range(0 , int((n))):
        sdf_in_vector_hex=f"{sdf_in_vector[i]:x}"  ##to convert to hex
        file.write(f"{sdf_in_vector_hex}\n")
    file.close()
 