library(readxl)
library(dplyr)
library(ggplot2)
library(DescTools)
library(effsize)

df <- read_excel("data/Data_TACR_kategorizovane.xlsx")

df <- na.omit(df) |> select("MOT_B", "GYMN")

dfg <- df |> filter(GYMN == 1)
dfz <- df |> filter(GYMN == 0)

summary(dfg)
summary(dfz)

meang <- mean(dfg$MOT_B)
meanz <- mean(dfz$MOT_B)

ggplot(dfg, aes(x = MOT_B, y = GYMN)) + geom_boxplot()
ggplot(dfz, aes(x = MOT_B, y = GYMN)) + geom_boxplot()

ci1 <- MeanCI(dfg$MOT_B)
ci2 <- MeanCI(dfz$MOT_B)

ci3 <- MeanDiffCI(dfz$MOT_B, dfg$MOT_B)

test <- t.test(dfg$MOT_B, dfz$MOT_B, conf.level = 0.95)

CohenD(dfz$MOT_B, dfg$MOT_B)
