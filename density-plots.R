library(dplyr)
library(lubridate)
library(ggplot2)

load('~/Desktop/Fitbit_analysis_JHUDash/data/all_data.Rdata')

all_data <- all_data %>% filter(!is.na(id))
all_data$id <- factor(all_data$id)

grouped <- all_data %>% filter(date >= ymd("2015-01-01")) %>%
  group_by(id, date) %>%
  mutate(total_steps = sum(steps),
         restless = sum(restless.count)) %>%
  select(id, time, date, total_steps,
         sleep.duration,
         sleepQuality.A, restless, DofW.steps) %>%
  distinct() %>%
  ungroup() %>% mutate(prev_sleep = lag(sleep.duration),
                       next_sleep = lead(sleep.duration))

# grouped <- grouped %>% filter(!is.na(total_steps))

# data grouped by total_steps != 0
options(scipen=3)
grouped %>% filter(total_steps > 0) %>%
  { ggplot(., aes(x=total_steps, color=factor(id))) +
  geom_density() +
      labs(title = "Steps per Day (non-zero)",
           y = "Density", x = "Total Steps") +
  geom_rug(color="gray") +
  scale_color_discrete(name="User ID") +
  theme(plot.title = element_text(size=rel(1.5), vjust=0.5),
  panel.background = element_rect(fill = "gray95")) +
      scale_y_continuous() 
  }
