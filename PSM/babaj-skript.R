# Simple regression model
# Data women

library(ggplot2)
library(gridExtra)

myData <- women

plot(myData$height, myData$weight, type = "p", pch = 16)

p <- ggplot(data = women, aes(x = height, y = weight)) +
  theme_light() +
  geom_point(fill = "black") +
  labs(title = "Scatter plot Weight = F(Height)", x = "Height (inch)", y = "Weight (lbs)") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1)), axis.text = element_text(size = rel(1))
  )

png(file = "women_data.png", width = 2000, height = 1600, res = 600)
print(p)
dev.off()

# Using lm() function

fit1 <- lm(weight ~ height, data = women)
fit2 <- lm(weight ~ poly(height, 2), data = women)
fit3 <- lm(weight ~ poly(height, 3), data = women)

# Prediction of the output values
w_1 <- predict(fit1)
w_2 <- predict(fit2)
w_3 <- predict(fit3)

mydata <- cbind(women, pred1 = w_1, pred2 = w_2, pred3 = w_3)

# Statistic of the models
sum1 <- summary(fit1)
sum2 <- summary(fit2)
sum3 <- summary(fit3)

crit_table <- data.frame()
crit_table[1, 1] <- sum1$r.squared
crit_table[2, 1] <- sum2$r.squared
crit_table[3, 1] <- sum3$r.squared
crit_table[1, 2] <- AIC(fit1)
crit_table[2, 2] <- AIC(fit2)
crit_table[3, 2] <- AIC(fit3)
crit_table[1, 3] <- BIC(fit1)
crit_table[2, 3] <- BIC(fit2)
crit_table[3, 3] <- BIC(fit3)
colnames(crit_table) <- c("R_squared", "AIC", "BIC")
row.names(crit_table) <- c("n = 1", "n = 2", "n = 3")


resid_1 <- fit1$residuals
resid_2 <- fit2$residuals
resid_3 <- fit3$residuals

mydata <- cbind(mydata, resid_1, resid_2, resid_3)

p1 <- ggplot(data = mydata, aes(sample = resid_1)) +
  theme_light() +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "a) Normal Q-Q plot, simple linear regression", x = "Theoretical quartiles",
    y = "Residuals"
  ) +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )
p2 <- ggplot(data = mydata, aes(sample = resid_2)) +
  theme_light() +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "b) Normal Q-Q plot, polynomial linear regression", x = "Theoretical quartiles",
    y = "Residuals"
  ) +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )
p3 <- ggplot(data = mydata, aes(sample = resid_3)) +
  theme_light() +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "c) Normal Q-Q plot, polynomial linear regression", x = "Theoretical quartiles",
    y = "Residuals"
  ) +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )

p4 <- ggplot(data = mydata, aes(x = height)) +
  theme_light() +
  geom_point(aes(y = weight, fill = "black")) +
  geom_line(aes(y = pred1, colour = "red")) +
  labs(title = "d) Simple linear regression", x = "Height (inch)", y = "Weight (lbs)") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )
p5 <- ggplot(data = mydata, aes(x = height)) +
  theme_light() +
  geom_point(aes(y = weight, fill = "black")) +
  geom_line(aes(y = pred2, colour = "red")) +
  labs(title = "e) Polynomial linear regression", x = "Height (inch)", y = "Weight (lbs)") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )
p6 <- ggplot(data = mydata, aes(x = height)) +
  theme_light() +
  geom_point(aes(y = weight, fill = "black")) +
  geom_line(aes(y = pred3, colour = "red")) +
  labs(title = "f) Polynomial linear regression", x = "Height (inch)", y = "Weight (lbs)") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )

png(file = "Linear_regression.png", width = 8000, height = 5000, res = 600)
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3)
dev.off()


# Non-linear regression

# enzime kinetic data

library(nlstools)

mydata <- L.minor

p <- ggplot(data = mydata, aes(x = conc, y = rate)) +
  theme_light() +
  geom_point() +
  labs(title = "Scatter plot rate vs conc", x = "Conc", y = "Rate") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1)), axis.text = element_text(size = rel(1))
  )

png(
  file = "nonlinear_data.png", width = 2000, height = 1600,
  res = 600
)
print(p)
dev.off()


fit3 <- lm(rate ~ conc, data = mydata)
summary(fit3)
r_1 <- predict(fit3)

fit4 <- lm(rate ~ poly(conc, 2), data = mydata)
summary(fit4)
r_2 <- predict(fit4)

fit5 <- nls(rate ~ (a * conc) / (1 + b * conc), data = mydata, start = list(a = 1, b = 1))
summary(fit5)
r_3 <- predict(fit5, data = mydata, type = "response")

AIC(fit3)
AIC(fit4)
AIC(fit5)
BIC(fit3)
BIC(fit4)
BIC(fit5)
resid_3 <- fit3$residuals
resid_4 <- fit4$residuals
resid_5 <- as.vector(fit5$m$resid())

# Results visualization

p1 <- ggplot(data = mydata, aes(x = conc)) +
  theme_light() +
  geom_point(aes(y = rate)) +
  geom_line(aes(y = r_1, colour = "linear")) +
  geom_line(aes(y = r_2, colour = "polynomial")) +
  geom_line(aes(y = r_3, colour = "nonlinear")) +
  scale_color_manual(name = "Models", values = c(
    "linear" = "red", "polynomial" = "green",
    "nonlinear" = "blue"
  )) +
  labs(title = "a)Regression models: rate vs conc", x = "Conc", y = "Rate") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1)), axis.text = element_text(size = rel(1))
  )

p2 <- ggplot(data = mydata, aes(sample = resid_3)) +
  theme_light() +
  stat_qq() +
  stat_qq_line() +
  labs(title = "b) Normal Q-Q plot, simple linear regression", x = "Theoretical quartiles", y = "Residuals") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )

p3 <- ggplot(data = mydata, aes(sample = resid_4)) +
  theme_light() +
  stat_qq() +
  stat_qq_line() +
  labs(title = "c) Normal Q-Q plot, polynomial linear regression", x = "Theoretical quartiles", y = "Residuals") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )

p4 <- ggplot(data = mydata, aes(sample = resid_5)) +
  theme_light() +
  stat_qq() +
  stat_qq_line() +
  labs(title = "d) Normal Q-Q plot, nonlinear regression", x = "Theoretical quartiles", y = "Residuals") +
  theme(
    plot.title = element_text(size = rel(1.3), hjust = 0.5),
    axis.title = element_text(size = rel(1.1)), axis.text = element_text(size = rel(1.1)),
    legend.position = "NA"
  )

png(
  file = "Nonlinear_regression_Results.png", width = 6000, height = 4000,
  res = 600
)
grid.arrange(p1, p2, p3, p4, ncol = 2)
dev.off()
