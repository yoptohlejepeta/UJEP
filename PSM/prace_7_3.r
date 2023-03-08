library(mice)
library(corrgram)

decath <- read.table("data/decathlon_1.txt", sep = " ")
auto_mpg <- read.table("data/auto-mpg.data-original", header = TRUE)

summary(decath)
summary(auto_mpg)
sum(is.na(decath))
sum(is.na(auto_mpg))

md.pattern(decath)
md.pattern(auto_mpg)

corrgram(decath)
corrgram(auto_mpg)

png("corrgram_decath.png",
    bg = "white", width = 6000, height = 6000,
    res = 600
)
par(cex.main = 1.6, las = 1, cex = 1.2)
corrgram(decath,
    order = TRUE, lower.panel = panel.shade,
    upper.panel = panel.pie, text.panel = panel.txt
)
dev.off()

png("corrgram_auto_mpg.png",
    bg = "white", width = 6000, height = 6000,
    res = 600
)
par(cex.main = 1.6, las = 1, cex = 1.2)
corrgram(auto_mpg,
    order = TRUE, lower.panel = panel.shade,
    upper.panel = panel.pie, text.panel = panel.txt
)
dev.off()

cor(decath, use = "complete.obs")
cor(auto_mpg, use = "complete.obs")

imp <- mice(decath, method = "rf")

data_1 <- complete(imp, action = 1)
data_2 <- complete(imp, action = 2)
data_3 <- complete(imp, action = 3)
data_4 <- complete(imp, action = 4)
data_5 <- complete(imp, action = 5)

crit_table <- data.frame()
