library(forecast)

ts <- AirPassengers

train_air <- window(ts, end = c(1958, 12))
test_air <- window(ts, start = c(1959, 1))

decomp <- decompose(train_air)
# plot(decomp)

sarima_train_air <- auto.arima(train_air)
# summary(sarima_train_air) vysvetlit parametry

forecast_air <- forecast(sarima_train_air, 24)
accuracy(forecast_air, test_air)

autoplot(forecast_air) + autolayer(test_air)
