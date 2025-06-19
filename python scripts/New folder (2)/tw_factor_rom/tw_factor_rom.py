def tw_rom (psi,n,q):
    file_name="tw_rom.txt"
    file=open(file_name , "w")
    for i in range(0 , int((n))):
        psi_pow_i=((psi**i)%q)
        psi_pow_i_hex=f"{psi_pow_i:x}"  ##to convert to hex
        print(psi_pow_i)
        file.write(f"{psi_pow_i_hex}\n")
    file.close()   

def main():
    n=int(input("please enter the value of the polynomial size (n): "))
    psi=int(input("please enter the value of primitve root (psi): "))
    q=int(input("please enter the value of modulo (q): "))
    tw_rom(psi,n,q)

if __name__ == "__main__":    
    main()

