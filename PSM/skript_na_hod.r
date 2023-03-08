
library(VIM)
data(sleep, package = "VIM")
vars <- c("Sleep", "NonD", "Dream", "BodyWgt", "BrainWgt", "Span", "Gest", "Pred", "Exp", "Danger")
mydata <- sleep[, vars]
head(mydata)

# Data analysis

mpg <- read.table("data/auto-mpg.data-original", header = TRUE )
colnames(mpg) <- c(
    "mpg", "num_cyl", "displ", "hp", "wg", "accel", "md_year",
    "tm", "name"
)




# Data analysis

summary(mydata)
sum(is.na(mydata))

# Missing values
y <- c(5, NA, 28, NaN, 1 / 0)
sum(is.na(y))
is.nan(y)
is.infinite(y)


fullData <- mydata[complete.cases(mydata), ]
notfullData <- mydata[!complete.cases(mydata), ]


library(mice)

md.pattern(mydata)

aggr(mydata, prop = FALSE, numbers = TRUE)


png("missing_value_showing.png", bg = "white", width = 7000, height = 5000, res = 600)
aggr(mydata, prop = FALSE, numbers = TRUE, cex.lab = 1.4, cex.axis = 1.2)
dev.off()

cor(mydata, use = "complete.obs")

fullData <- na.omit(mydata)

library(corrgram)

png("corrgram.png",
    bg = "white", width = 6000, height = 6000,
    res = 600
)
par(cex.main = 1.6, las = 1, cex = 1.2)
corrgram(fullData,
    order = TRUE, lower.panel = panel.shade,
    upper.panel = panel.pie, text.panel = panel.txt,
    main = "Correlogram of sleep dataset variables intercorrelations"
)
dev.off()

library(car)
png("scatterplotmatrix.png",
    bg = "white", width = 8000, height = 6000,
    res = 600
)
scatterplotMatrix(mydata, cex = 1.4, cex.axis = 1.6)
dev.off()




imp <- mice(mydata, method = "rf")

data_1 <- complete(imp, action = 1)
data_2 <- complete(imp, action = 2)
data_3 <- complete(imp, action = 3)
data_4 <- complete(imp, action = 4)
data_5 <- complete(imp, action = 5)

crit_Table <- data.frame()

colnames(mydata)

fit_1 <- lm(Sleep ~ NonD + Dream + poly(Span, 2) + poly(Gest, 2), data = data_1)
stat1 <- summary(fit_1)
crit_Table[1, 1] <- stat1$r.squared
crit_Table[1, 2] <- AIC(fit_1)
crit_Table[1, 3] <- BIC(fit_1)
colnames(crit_Table) <- c("R_squared", "AIC", "BIC")

fit_2 <- lm(Sleep ~ NonD + Dream + poly(Span, 2) + poly(Gest, 2), data = data_2)
stat2 <- summary(fit_2)
crit_Table[2, 1] <- stat2$r.squared
crit_Table[2, 2] <- AIC(fit_2)
crit_Table[2, 3] <- BIC(fit_2)

fit_3 <- lm(Sleep ~ NonD + Dream + poly(Span, 2) + poly(Gest, 2), data = data_3)
stat3 <- summary(fit_3)
crit_Table[3, 1] <- stat3$r.squared
crit_Table[3, 2] <- AIC(fit_3)
crit_Table[3, 3] <- BIC(fit_3)

fit_4 <- lm(Sleep ~ NonD + Dream + poly(Span, 2) + poly(Gest, 2), data = data_4)
stat4 <- summary(fit_4)
crit_Table[4, 1] <- stat4$r.squared
crit_Table[4, 2] <- AIC(fit_4)
crit_Table[4, 3] <- BIC(fit_4)

fit_5 <- lm(Sleep ~ NonD + Dream + poly(Span, 2) + poly(Gest, 2), data = data_5)
stat5 <- summary(fit_5)
crit_Table[5, 1] <- stat5$r.squared
crit_Table[5, 2] <- AIC(fit_5)
crit_Table[5, 3] <- BIC(fit_5)

newdata <- complete(imp, action = 3)
head(newdata)

sum(is.na(newdata))


png("Fig_boxplots.png",
    bg = "white", width = 8000, height = 6000,
    res = 600
)
par(
    mfrow = c(2, 2), omi = c(0.2, 0.2, 0.2, 0.2),
    mai = c(0.5, 0.8, 0.4, 0.2), cex.axis = 1.4, mgp = c(3, 0.6, 0), las = 1, cex = 1.2
)
boxplot(data_1[, 1:3])
boxplot(data_1[, 4:5])
boxplot(data_1[, 6:7])
boxplot(data_1[, 8:10])
dev.off()

png("Fig_densityplot.png",
    bg = "white", width = 8000, height = 6000,
    res = 600
)
par(
    mfrow = c(2, 2), omi = c(0.2, 0.2, 0.2, 0.2),
    mai = c(0.5, 0.8, 0.4, 0.2), cex.axis = 1.4, mgp = c(3, 0.6, 0), las = 1, cex = 1.2, lwd = 2
)
plot(density(data_1[, 1]), col = 2, lty = 1, ann = F, ylim = c(0, 0.35))
lines(density(data_1[, 2]), col = 3, lty = 2, ann = F)
lines(density(data_1[, 3]), col = 4, lty = 3, ann = F)
legend(12, 0.35, c("NonD", "Dream", "Sleep"), col = c(2, 3, 4), lty = c(1, 2, 3), bty = "n")
plot(density(data_1[, 4]), col = 2, lty = 1, ann = F)
lines(density(data_1[, 5]), col = 3, lty = 2, ann = F)
legend(4000, 0.015, c("BodyWgt", "BrainWgt"), col = c(2, 3), lty = c(1, 2), bty = "n")
plot(density(data_1[, 6]), col = 2, lty = 1, ann = F, xlim = c(0, max(data_1$Gest)))
lines(density(data_1[, 7]), col = 3, lty = 2, ann = F)
legend(400, 0.028, c("Span", "Gest"), col = c(2, 3), lty = c(1, 2), bty = "n")
plot(density(data_1[, 8]), col = 2, lty = 1, ann = F, ylim = c(0, 0.35))
lines(density(data_1[, 9]), col = 3, lty = 2, ann = F)
lines(density(data_1[, 10]), col = 4, lty = 3, ann = F)
legend(4, 0.35, c("Pred", "Exp", "Danger"), col = c(2, 3, 4), lty = c(1, 2, 3), bty = "n")
dev.off()

fullData <- newdata

library(clusterSim)

st_data <- data.Normalization(fullData, type = "n1", normalization = "columns")

png("Fig_boxplot1.png", bg = "white", width = 1000, height = 500, family = "sans")
par(mfrow = c(1, 1), omi = c(0.2, 0.2, 0.2, 0.2), mai = c(1.3, 0.8, 0.4, 0.2), cex.axis = 1.4, las = 3, cex = 1.2, lwd = 1.5)
boxplot(st_data)
dev.off()


# Function calculate and return quality normalizing criterion
# x is a data frame

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
    norm_data <- data.Normalization(fullData[, -1],
        type = types[i],
        normalization = "columns"
    )
    v[i] <- norm_qual(norm_data)
}

t <- types[which.min(v)]
norm_data <- data.Normalization(fullData[, -1],
    type = t,
    normalization = "columns"
)

png("Fig_normalizing_final.png", bg = "white", width = 10000, height = 5000, res = 600)
par(
    mfrow = c(1, 1), omi = c(0.2, 0.2, 0.2, 0.2), mai = c(1.3, 0.8, 0.4, 0.2), cex.axis = 1.4,
    las = 3, cex = 1.2, lwd = 1.5
)
boxplot(norm_data)
dev.off()

final_data <- cbind(Sleep = fullData[, 1], norm_data)
