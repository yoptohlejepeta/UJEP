
import numpy as np


def main_british():

    p_lambda = 0.1
    k = 6
    M = [
        [np.exp(-p_lambda), 0, 0, p_lambda * np.exp(-p_lambda), 0, ((p_lambda**2) / 2) * np.exp(-p_lambda), 1-np.exp(-p_lambda)-p_lambda*np.exp(-p_lambda)-((p_lambda**2)/2)*np.exp(-p_lambda)],
        [np.exp(-p_lambda), 0, 0, p_lambda * np.exp(-p_lambda), 0, ((p_lambda**2) / 2) * np.exp(-p_lambda), 1-np.exp(-p_lambda)-p_lambda*np.exp(-p_lambda)-((p_lambda**2)/2)*np.exp(-p_lambda)],
        [0, np.exp(-p_lambda), 0, 0, p_lambda * np.exp(-p_lambda), 0, 1-np.exp(-p_lambda)-p_lambda*np.exp(-p_lambda)],
        [0, 0, np.exp(-p_lambda), 0, p_lambda * np.exp(-p_lambda), 0, 1-np.exp(-p_lambda)-p_lambda*np.exp(-p_lambda)],
        [0, 0, 0, np.exp(-p_lambda), 0, p_lambda * np.exp(-p_lambda), 1-np.exp(-p_lambda)-p_lambda*np.exp(-p_lambda)],
        [0, 0, 0, 0, np.exp(-p_lambda), 0, 1-np.exp(-p_lambda)],
        [0, 0, 0, 0, 0, np.exp(-p_lambda), 1-np.exp(-p_lambda)],
    ]
    a = [0, 0, 0, 0, 0, 1, 0]

    for _ in range(100):
        a = np.dot(a, M)
    print(a)

if __name__ == "__main__":
    np.random.seed(42)
    #spanish()
    #british()
    #get_probs()
    #main_spanish()
    main_british()
