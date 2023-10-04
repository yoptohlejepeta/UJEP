import numpy as np

# Parameters
num_classes = 15  # Number of bonus-malus classes
initial_class = 15  # Initial bonus-malus class (typically highest)
claim_prob = 0.2  # Probability of making a claim
policy_periods = 10  # Number of policy periods to simulate

# Transition matrix
transition_matrix = np.zeros((num_classes, num_classes))

for i in range(num_classes):
    for j in range(num_classes):
        if i == j:
            transition_matrix[i, j] = 1 - claim_prob
        elif j == i - 1:
            transition_matrix[i, j] = claim_prob

# Simulate policyholder's class transitions
policyholder_class = initial_class
class_history = [policyholder_class]

for _ in range(policy_periods):
    # Simulate a policy period
    transition_probs = transition_matrix[policyholder_class - 1, :]
    policyholder_class = np.random.choice(np.arange(1, num_classes + 1), p=transition_probs)
    class_history.append(policyholder_class)

# Print the simulated class history
print("Policyholder's Bonus-Malus Class History:")
print(class_history[1:])  # Exclude initial class

# Calculate the final bonus-malus class
final_class = class_history[-1]
print(f"Final Bonus-Malus Class: {final_class}")
