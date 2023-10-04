# Bisekce
import numpy as np
import plotly.express as px

a = 0.1
b = 4
x = np.linspace(a, b)
y = x + np.log(x)

def f(x):
    return x + np.log(x)

while np.absolute(a - b) > 1e-10:
    c = (a+b)/2
    if f(a) * f(c) < 0:
        b = c
    else:
        a = c
print(c, f(c))

# plot graph
fig = px.line(x=x, y=y)
fig.show()