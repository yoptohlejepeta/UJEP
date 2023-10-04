# indexova analyza
# cisteni cas. rad (rozlozeni na slozky)
# hurst
# arima

# graf (vykresli)

library(fredr)
library(dplyr)
library(ggplot2)
library(TTR)
library(tseries)
library(forecast)

fredr_set_key("674fece7ba0555de6f195bbf45739006")

# intervaly spolehlivosti, popisne veci
# definice problematiky
# skala, interpretace cisel, velikost statu
# interpretace
# otazka
# odpoved
# zaver

my_series <- fredr_series_search_text("unemployment rate")
# View(my_series)
# View(my_series[c("id", "title", "notes")])
# usur <- fredr("UNRATENSA")[, 1:3] # Spojene staty


dataset <- c()
for (state in state.abb) {
  dataset <- rbind(dataset, fredr(paste0(state, "URN"))[, 1:3])
}

dataset$series_id <- gsub("urn", "", dataset$series_id, ignore.case = TRUE)


for (state in state.abb) {
  df <- dataset |> filter(dataset["series_id"] == state)
  print(ggplot(data = df, aes(x = date, y = value, color = series_id)) +
  geom_line(linewidth = 1))
}

df <- dataset %>% filter(dataset["series_id"] == "AL")
ggplot(data = df, aes(x = date, y = value, color = series_id)) +
geom_line(linewidth = 1)

View(dataset)

View(df)

