import plotly.express as px
import pandas as pd
import random


def prob_tennis(p, n):
    wins_A = 0

    for i in range(n):
        points_A = 0
        points_B = 0

        while True:
            if random.random() < p:
                points_A += 1
            else:
                points_B += 1

            if points_A > 3 and points_A - points_B > 1:
                wins_A += 1
                break
            elif points_B > 3 and points_B - points_A > 1:
                break

    return wins_A / n


p_values = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
n = 10000

probabilities = [prob_tennis(p, n) for p in p_values]

df = pd.DataFrame({"Probability (p)": p_values, "Estimated Probability": probabilities})

fig = px.line(
    df,
    x="Probability (p)",
    y="Estimated Probability",
    title="Probability of Player A Winning a Tennis Match",
)
fig.show()
