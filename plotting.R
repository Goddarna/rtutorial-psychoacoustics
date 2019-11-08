# IMPORT DATASET

data <- read.csv('example.csv')

# PLOT WITH DEFAULT FUNCTION

#dont forget to type 'install.packages("ggplot2")' if you dont have it installed already
library(ggplot2)

#Generate plots for each stimuli condition

plots <- data %>% 
  group_by(stimuli) %>%
  do(plot= {
    p <- ggplot(.,aes(hrtf_angle,ild)) +
      stat_summary(geom = "line",
                   fun.y = median, size = 1, color = "black") +
      xlab("HRTF Angle(°)") +
      ylab("Interaural Level Difference(dB)")
  })

# Show all plots
plots$plot

# Show plot 1
plots$plot[1]

#----------------------------------------------------------------------------- PLOT WITH GGPLOT2 (basic)

# Handy functon to define and calculate number of ticks on the y axis
number_ticks <- function(n) {function(limits) pretty(limits, n)}

ggplot(subset(data, stimuli=="Speech"), aes(x=hrtf_angle, y=ild)) +
  stat_summary(geom = "line",
               fun.y = median, size = 1, color = "black") +
  stat_summary(geom = "point", color = "red",
               fun.y = median) +
  
  # 95% confidence interval for medians 1.57 * IQR / sqrt(n)
  stat_summary(geom = "errorbar", fun.ymin = function(z) { median(z) - 1.57 * (quantile(z,0.75)-quantile(z,0.25)) / sqrt(length(z))},
               fun.ymax = function(z) {median(z) + 1.57 * (quantile(z,0.75)-quantile(z,0.25)) / sqrt(length(z)) },
               fun.y = median, size = 0.8) +
  xlab("HRTF Angle(°)") +
  ylab("Interaural Level Difference(dB)") +
  ggtitle("Median ILD with 95% notch edges, Speech") +
  theme_light() +
  theme(
    axis.line = element_line(color = "black",
                             size = 1, linetype = "solid")
  ) +
  scale_x_continuous(breaks = round(seq(min(data$hrtf_angle), max(data$hrtf_angle), by = 10),1)) +
  scale_y_continuous(breaks=number_ticks(20))


#----------------------------------------------------------------------------- PLOT WITH GGPLOT2 (moar data lines)

ggplot(data, aes(x=hrtf_angle, y=ild, color=factor(stimuli))) +
  stat_summary(geom = "line", fun.y = median, aes(group = stimuli), size = 1) +
  xlab("HRTF Angle(°)") +
  ylab("Interaural Level Difference(dB)") +
  ggtitle("Median ILD with 95% notch edges, Speech") +
  theme_light() +
  theme(
    axis.line = element_line(color = "black",
                             size = 1, linetype = "solid")
  ) +
  labs(color = "Stimuli:\n") +
  scale_x_continuous(breaks = round(seq(min(data$hrtf_angle), max(data$hrtf_angle), by = 10),1)) +
  scale_y_continuous(breaks=number_ticks(20))


