# Využití matic a řešení soustav lineárních rovnic při modelování obnovy
# http://physics.ujep.cz/~jskvor/UlohaMatice/

import numpy as np


# Matice přechodu
P = np.array([[0.04, 0.96, 0.0], [0.24, 0.0, 0.76], [1, 0.0, 0.0]])

# Celkový počet součástek
total_components = 1000

# Vektor počátečního rozložení
# Všechny součástky jsou v prvním týdnu
a = np.array([1.0, 0.0, 0.0])


while True:
    a_new = np.dot(a, P)
    if np.allclose(a, a_new, rtol=1e-20):
        break
    a = a_new

a *= total_components

print("Stationary Distribution:", a)
