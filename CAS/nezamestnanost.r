library(readxl)
library(forecast)
library(tseries)
library(TTR)

nezam <- read_excel("data/Nezamestnanost_data.xlsx")

names(nezam)
View(nezam)

nez_ts <- ts(nezam$Nezamestnanost, frequency = 12, start = c(2011, 1))
plot(nez_ts)

seasonplot(nez_ts, col = rainbow(12))

pros_nezam <- nezam |> filter(Mesic == 12)
View(pros_nezam)

fit <- lm(Nezamestnanost ~ Rok, data = pros_nezam)
typeof(Nezamestnanost ~ Rok)
predict(fit)
plot(predict(fit))
coef1 <- summary(fit)$coefficients[1]
coef2 <- summary(fit)$coefficients[2]
summary(fit)

print(2023 * coef2 + coef1)

for (i in 1:12) {
    df <- nezam %>% filter(Mesic == i)
    fit <- lm(Nezamestnanost ~ Rok, data = df)
    coef1 <- summary(fit)$coefficients[1]
    coef2 <- summary(fit)$coefficients[2]
    print(i)
    print(2023 * coef2 + coef1)
}


fit2 <- lm(Nezamestnanost ~ poly(Rok, 12), data = pros_nezam)
summary(fit2)
predict(fit2)
plot(predict(fit2))
