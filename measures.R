# IMPORT DATASET

data <- read.csv('example.csv')

#dont forget to type 'install.packages("dplyr")' if you dont have it installed already
library(dplyr)

# CENTRAL TENDENCY

data %>%
  group_by(stimuli, hrtf_angle) %>%
  summarise(
    median = median(ild)
  )


# DISPERSION

data %>%
  group_by(stimuli, hrtf_angle) %>%
  summarise(
    median = median(ild),
    q1 = quantile(ild, 0.25),
    q3 = quantile(ild, 0.75),
    iqr = quantile(ild, 0.75) - quantile(ild, 0.25) 
  )




