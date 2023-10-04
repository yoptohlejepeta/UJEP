import numpy as np
import plotly.express as px

def f(x):
    return -x**3 + 10*x**2 - 3*x + 6

xstart = 0
xend = 10
nx = 5
dx = (xend - xstart)/nx
x = np.linspace(xstart, xend, nx)
fx = f(x)

def lagrange(x, xs):
    Ln = 0
    for i in range(len(xs)):
        li = f(x[i])
        for j in range(len(xs)):
            li *= (x-x[j])/(x[i] - x[j]) if i != j else 1
        Ln += li
    return Ln

phi = []
xphi = []

ninterpol = 5
for i in range(len(x)-1):
    xinterpol = np.linspace(x[i], x[i+1], ninterpol)
    g = lagrange(xinterpol, x)
    xphi.extend(xinterpol)
    phi.extend(g)


# plot graph
fig = px.line(x=x, y=fx)
fig.add_scatter(x=xphi, y=phi, mode='markers')
fig.show()