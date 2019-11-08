# IMPORT DATASET

data <- read.csv('example.csv')

#dont forget to type 'install.packages("dplyr")' if you dont have it installed already
library(dplyr)

# APPLY WILCOXON TEST

data2 <- subset(data, stimuli == "Speech")
res <- pairwise.wilcox.test(data2$ild, data2$hrtf_angle, p.adjust.method = "none", paired = TRUE)
res


# APPLY WILCOXON TEST TO EACH CONDITION
# stimuli is the condition we want to loop through

data %>% 
  group_by(stimuli) %>% 
  summarise(results = wilcox.test(ild, hrtf_angle, paired = TRUE)$p.value)

# APPLY PAIRWISE WILCOXON TEST TO EACH SEPERATE CONDITIONS
# Use do() to return a data frame for pairwise functions

res <- data %>% 
  group_by(stimuli) %>% 
  do(results = pairwise.wilcox.test(.$ild, .$hrtf_angle, paired = TRUE)$p.value)
  

#show pairwise comparison results for each stimuli condition
res$results
