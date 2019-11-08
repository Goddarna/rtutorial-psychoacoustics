# IMPORT DATASET

data <- read.csv('example.csv')

#dont forget to type 'install.packages("dplyr")' if you dont have it installed already
library(dplyr)

# HISTOGRAM

hist(data$ild, breaks=10, main="Distribution of ILD")

# QPLOTS

library(ggplot2)

qplot(hrtf_angle, ild, data = data, geom = c("point", "smooth")) +
  geom_smooth()

# SHAPIRO SUBSET

df2 <- subset(data, hrtf_angle == "10")
shapiro.test(df2$ild)

# APPLY SHAPIRO TO EACH CONDITION

data %>%
  group_by(stimuli, hrtf_angle) %>%
  summarise(
    p.value = shapiro.test(ild)$p.value
  )
     

data %>%
  group_by(PolarPattern, Spacing) %>%
  summarise(
    p.value = shapiro.test(SpatialImpression)$p.value
  )
