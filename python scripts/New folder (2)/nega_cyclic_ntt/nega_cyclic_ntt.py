
def psi_inv(modulo , psi ):
    psi_inv= pow(psi , (modulo-2)) % modulo
    print(psi_inv)
    return psi_inv

def scaling_factor(modulo , in_vector):
    input_size=len(in_vector)
    scaling_factor= pow(input_size , (modulo-2)) % modulo
    print(scaling_factor)
    return scaling_factor

def nega_cyclic_ntt(modulo , psi , in_vector):
    input_size=len(in_vector)
    ntt_out= [0]*input_size
    for j in range(input_size):
        sum=0
        for i in range(input_size):
            mod_psi_pow= ((2*i*j)+i) % (2*input_size)
            sum = sum + (pow(psi , mod_psi_pow))*in_vector[i]
        sum=sum % modulo    
        ntt_out[j]=sum
    return ntt_out
        
def nega_cyclic_intt(modulo , psi , nega_cyclic_ntt_out):
    inv_psi = psi_inv(modulo, psi)
    scale_factor=scaling_factor(modulo , nega_cyclic_ntt_out)
    n=len(nega_cyclic_ntt_out)
    nega_cyclic_intt_out= [0]*n
    for i in range(n):
        sum=0
        for j in range(n):
            psi_omega_pow= ((2*i*j)+i) % (2*n)
            sum = sum + (pow(inv_psi , psi_omega_pow))*nega_cyclic_ntt_out[j]
        sum=(sum*scale_factor) % modulo    
        nega_cyclic_intt_out[i]=sum
    return nega_cyclic_intt_out  



q=7681
psi= 97  

in_vector1=[ 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
]


ntt1  = nega_cyclic_ntt(q , psi , in_vector1)

intt1= nega_cyclic_intt(q,psi,ntt1)

print(ntt1)
print(intt1)


if intt1==in_vector1:
  print("yes")
else:
    print("no")

