
# CREATING VARIABLES

string <- "string"
integer <- 2 + 2
vector <- c(2, 4, 6)
df <- data.frame(
          "PolarPattern" = c("Hyper-cardioid","Cardioid","Omnidirectional"),
          "Angle" = c(45, 90, 180),
          "Spacing" = 0:2,
          "SpacialImpression" = -1:1)

# PRINT TO CONSOLE

print(df)

# CREATE LOOP


for (i in df$Angle){
  print(i)
}

# CREATE FUNCTION

toRadians <- function(x){
  radians <- x *pi/180
  return(radians)
}

toRadians(df$Angle[1])

# IMPORT DATASET

data <- read.csv('example.csv')

# DATA MANIPULATION
df %>% 
  group_by(stimuli, hrtf_angle) %>%
  summarise() %>%
  filter(hrtf_angle > 40)

# IMPORT BUILT-IN DATASET

data()

#HELP

#function

?median

#package

help(dplyr)

