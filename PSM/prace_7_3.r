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

full_decath <- decath[complete.cases(mydata), ]
full_mpg <- auto_mpg[complete.cases(mydata), ]

corrgram(decath, upper.panel = panel.pie)
corrgram(auto_mpg, upper.panel = panel.pie)

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

fit_1 <- lm(Points ~ X100m + Long.jump + poly(Shot.put, 2) + poly(High.jump, 2) +
    X400m + X110m.hurdle + poly(Discus, 2) + poly(Pole.vault, 2) +
    poly(Javeline, 2) + poly(X1500m, 2), data = data_1)
stat1 <- summary(fit_1)
crit_table[1, 1] <- stat1$r.squared
crit_table[1, 2] <- AIC(fit_1)
crit_table[1, 3] <- BIC(fit_1)
colnames(crit_table) <- c("R_squared", "AIC", "BIC")

fit_2 <- lm(Points ~ X100m + Long.jump + poly(Shot.put, 2) + poly(High.jump, 2) +
    X400m + X110m.hurdle + poly(Discus, 2) + poly(Pole.vault, 2) +
    poly(Javeline, 2) + poly(X1500m, 2), data = data_2)
stat2 <- summary(fit_2)
crit_table[2, 1] <- stat2$r.squared
crit_table[2, 2] <- AIC(fit_2)
crit_table[2, 3] <- BIC(fit_2)

fit_3 <- lm(Points ~ X100m + Long.jump + poly(Shot.put, 2) + poly(High.jump, 2) +
    X400m + X110m.hurdle + poly(Discus, 2) + poly(Pole.vault, 2) +
    poly(Javeline, 2) + poly(X1500m, 2), data = data_3)
stat3 <- summary(fit_3)
crit_table[3, 1] <- stat3$r.squared
crit_table[3, 2] <- AIC(fit_3)
crit_table[3, 3] <- BIC(fit_3)

fit_4 <- lm(Points ~ X100m + Long.jump + poly(Shot.put, 2) + poly(High.jump, 2) +
    X400m + X110m.hurdle + poly(Discus, 2) + poly(Pole.vault, 2) +
    poly(Javeline, 2) + poly(X1500m, 2), data = data_4)
stat4 <- summary(fit_4)
crit_table[4, 1] <- stat4$r.squared
crit_table[4, 2] <- AIC(fit_4)
crit_table[4, 3] <- BIC(fit_4)

fit_5 <- lm(Points ~ X100m + Long.jump + poly(Shot.put, 2) + poly(High.jump, 2) +
    X400m + X110m.hurdle + poly(Discus, 2) + poly(Pole.vault, 2) +
    poly(Javeline, 2) + poly(X1500m, 2), data = data_5)
stat5 <- summary(fit_5)
crit_table[5, 1] <- stat5$r.squared
crit_table[5, 2] <- AIC(fit_5)
crit_table[5, 3] <- BIC(fit_5)

result <- list(crit_table = crit_table, imp = imp)
result

library(clusterSim)

norm_qual <- function(x) {
    r <- sqrt(sapply((x^2), sum))
    return(var(r))
}

types <- c(
    "n0", "n1", "n2", "n3", "n3a", "n4", "n5", "n5a", "n6", "n6a", "n7", "n8",
    "n9", "n9a", "n10", "n11", "n12", "n12a", "n13"
)


v <- vector()
for (i in 1:length(types)) {
    norm_data <- data.Normalization(full_decath[, -1],
        type = types[i],
        normalization = "columns"
    )
    v[i] <- norm_qual(norm_data)
}

t <- types[which.min(v)]
norm_data <- data.Normalization(full_decath[, -1],
    normalization = "columns"
)

v <- vector()
for (i in 1:length(types)) {
    norm_data <- data.Normalization(full_mpg[, -1],
        type = types[i],
        normalization = "columns"
    )
    v[i] <- norm_qual(norm_data)

t <- types[which.min(v)]
norm_data <- data.Normalization(full_mpg[, -1],
    type = t,
    normalization = "columns"
)