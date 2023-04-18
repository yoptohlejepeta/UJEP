library(forecast)
library(readxl)

df1 <- read_excel("data/CO2.xlsx")
df2 <- read_excel("data/Australia.xlsx", col_names = c("year", "month", "NA"))
df2 <- df2[, 1:2]
df1 <- df[, -2]

View(df1[c("Year", "CO2")])
View(df2)


ts_co2 <- ts(df1[c("CO2")], frequency = 12)
ts_aus <- ts(df2[c("year")], frequency = 12)

plot(ts_aus)
plot(ts_co2)

fitarima1 <- auto.arima(ts_co2)
fitarima2 <- auto.arima(ts_aus)

arima1 <- arima(ts_co2, order = c(1, 0, 1), seasonal = list(order = c(2, 1, 2)))
futureco2 <- forecast(arima1, h = 10, level = c(99.5))
plot(futureco2)

arima2 <- arima(ts_aus, order = c(0, 1, 1), seasonal = list(order = c(0, 1, 2)))
futureaus <- forecast(arima2, h = 20, level = c(99.5))
plot(futureaus)

decom1 <- decompose(ts_aus)
decom2 <- decompose(ts_co2)



co2_min_trend <- ts_co2 - decom2$trend
acf(co2_min_trend, na.action = na.pass, lag.max = 50)

aus_min_trend <- ts_aus - decom1$trend
acf(aus_min_trend, na.action = na.pass, lag.max = 50)
