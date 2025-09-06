def tw_rom (file_name,psi,n,q):
    file=open(file_name , "w")
    for i in range(1 , int((n))):
        psi_pow_i=((psi**i)%q)
        psi_pow_i_hex=f"{psi_pow_i:x}"  ##to convert to hex
        file.write(f"{psi_pow_i_hex}\n")
    file.close()   

 
