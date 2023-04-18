# SARIMA = sezonni ARIMA (7 parametrů
# ARIMA = AR (odhad následujících hodnot pomocí přechozích členů) + 
#         MA (moving average, předchozí residua) + 
#         I (d=kolikrát diferencuju)

# data("AirPassengers")
library(forecast)

View(AirPassengers)
fitarima <- auto.arima(AirPassengers)
