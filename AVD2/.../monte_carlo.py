import numpy as np
import time
import multiprocessing as mp
import random

poptavka = [
    0.1,
    0.02,
    0.03,
    0.05,
    0.07,
    0.09,
    0.11,
    0.13,
    0.14,
    0.12,
    0.07,
    0.04,
    0.02,
    0.01,
]
n = 14  # pocet hodnot
k = 100  # pocet opakovani

hodnoty = [np.random.choice(np.arange(0, 14), p=poptavka) for i in range(n)]

# poptavka = [sum([random.choices(np.arange(0, 14), weights=poptavka) for i in range(n)]) for i in range(k)]

poptavka = np.array(
    [random.choices(np.arange(0, 14), weights=poptavka) for i in range(n * k)]
)
print(poptavka)

count = sum(i > 100 for i in poptavka)
print(count / k)
