# Concatenate subject data into a single shared data frame. 

# Work in progress: Selects the correct columns from each subject's data file and adds a subject id.
# Needs: Merge across two frames for each subject. Merge frames across multiple subjects.



subject_data <- list(list("data/jtfsteps.csv","data/jtfsleep.csv"), list("data/chris_steps.csv","data/chris_sleep.csv"), list("data/stepsDLC.csv","data/sleepDLC.csv"))
#subject_data <- list(list("data/stepsDLC.csv","data/sleepDLC.csv"))
# list("data/an_steps.csv","") # This subject has no sleep file; doesn't currently handle gracefully

# Set appropriate working directory
setwd("~/Desktop/Fitbit_analysis_JHUDash/")

library(lubridate)
library(dplyr, type="source")

subject_ids <- seq(1,length(subject_data))

for (s in subject_ids) {
  # steps
  steps <- read.csv(subject_data[[s]][[1]]) # step data
  steps_final_format <- data.frame(
    subjID <- rep(s,dim(steps)[1]),
    date <- steps$date,
    DofW <- steps$wday,
    HofD <- steps$hour,
    MofH <- steps$minute,
    stepcount <- steps$steps
  )
  
  sleep <- read.csv(subject_data[[s]][[2]]) # sleep data
  sleep_final_format = data.frame(
    date <- sleep$date,
    sleepqualA <- sleep$sleepQualityScoreA,
    sleepDuration <- sleep$sleepDuration,
    minAsleep <- sleep$minAsleep
  )
}
