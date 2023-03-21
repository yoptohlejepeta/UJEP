library(ggplot2)
library(dplyr)
library(DescTools)

dataset <- read.csv("Travel_details_dataset.csv")
dataset <- na.omit(dataset)
dataset[["Transportation.cost"]] <- as.numeric(dataset[["Transportation.cost"]])

male <- dataset %>% filter(Traveler.gender == "Male")
male <- na.omit(male)
female <- dataset %>% filter(Traveler.gender == "Female")
female <- na.omit(female)

costs <- dataset %>%
    group_by(Traveler.gender) %>%
    summarise(costs = sum(Transportation.cost))

ggplot(costs, aes(y = costs, x = Traveler.gender)) + geom_bar(stat = "identity")

boxplot(male$"Traveler.age")
boxplot(female$"Traveler.age")


MeanCI(male$"Transportation.cost", conf.level = 0.95)
MeanCI(female$"Transportation.cost", conf.level = 0.95)
VarCI(male$"Transportation.cost", conf.level = 0.95)
VarCI(female$"Transportation.cost", conf.level = 0.95)

View(dataset)
