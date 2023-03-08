import numpy as np
import random

def blind_algorithm(tmax, k, n):
    # tmax - počet opakování
    # n - je počet dimenzí
    # k - bitový rozlišení
    f_fin = np.Inf
    print(f_fin)
    t = 0
    for i in range(tmax):
    # while t < tmax:
        # t += 1
        # alpha = nahodna sekvence 0,1 o delce n
        alpha = [random.choice([0,1]) for i in range(k*n)]
        if f(gamma(alpha)) < f_fin:
            alpha_fin = alpha
            f_fin = f(gamma(alpha))
    return alpha_fin, f_fin

def gamma(alpha):
    # převod binárního vyjadreni
    x = sum(alpha)
    return x

def f(x):
    fx = 2*(x**2)
    return fx


print(blind_algorithm(5,3,2))