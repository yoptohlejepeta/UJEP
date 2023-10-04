import numpy as np

# Velikost poptávky
q = [40, 50, 30, 20, 20, 15, 10]
# Časové okamžiky
t = [0, 1, 2, 3, 4, 6, 8]
# Náklady na zásoby
Cp = 70
# Náklady na skladování
Cs = 1

N = np.full(shape=(7, 7), fill_value=np.nan)
for j in range(7):
    for i in range(j + 1):
        sum = 0
        for k in range(i, j + 1):
            sum += q[k] * (t[k] - t[i])

        N[i, j] = Cp + Cs * sum
print(N)
N = np.fliplr(N)
N = np.flipud(N)
F = [0]
for j in range(1, 7):
    l = [F[i - 1] + N[-i, -j] for i in range(1, j + 1)]
    # print(j, l)
    F_j = min(l)
    F.append(F_j)

for i in range(len(F)):
    print(f"ČAS:{i} | VELIKOST OBJEDNÁVKY:{F[i]}")
