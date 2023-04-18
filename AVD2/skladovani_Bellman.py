# Jiří Demel: Operační výzkum
# strana 80 příklad 5.3.3

import numpy as np

c_p = 70
# c_s = 1
q = [40, 50, 30, 20, 20, 15, 10]
t = [0, 1, 2, 3, 4, 6, 8]
matice = np.zeros((len(t),len(t)))

def N(den1, den2, q, t):
    naklady = []
    for i,j in zip(t[0:den2 + 1],q[den1:den2 + 1]):
        # print(t[0:den2 + 1])
        naklady.append(i * j)
    naklady.append(c_p)
    return sum(naklady)

for i in range(len(matice)):
    for j in range(len(matice)):
        matice[i,j] = N(i,j, q,t)
        
print(np.triu(matice))

def F(n):
    f = []
    for i in range(n+1):
        print(0 + N(i,n,q,t))
    # return ...

print(F(1))
# for i in range(len(t)):
#     print("---------")
#     for j in range(i+1):
#         print(sum(N(j,i,q,t)))
# print(sum(N(2,4, q)))



