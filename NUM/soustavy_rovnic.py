# Jacobiho metoda
import numpy as np

A = np.array([[2, 1],[5, 7]])
b = np.array([11,13])

np.linalg.solve(A,b)

L = np.tril(A, -1)
D = np.diag(np.diag(A))
U = np.triu(A, 1)

x = np.zeros(len(A))

i = 1
while True:
    x = np.matmul(np.linalg.inv(D), (b - np.matmul(L+U, x) ))
    # print(i, x)
    i += 1
    if np.linalg.norm(np.matmul(A, x) - b) < 1e-10:
        break

print(x)
print(np.linalg.solve(A,b))