# Concatenate subject data into a single shared data frame. 

# Work in progress: Selects the correct columns from each subject's data file and adds a subject id.
# Needs: Merge across two frames for each subject. Merge frames across multiple subjects.

#subject_data <- list(#list("data/jtfsteps.csv","data/jtfsleep.csv"), 
#                     list("data/chris_steps.csv","data/chris_sleep.csv"), 
#                     list("data/stepsDLC.csv","data/sleepDLC.csv"))
#subject_data <- list(list("data/stepsDLC.csv","data/sleepDLC.csv"))
# list("data/an_steps.csv","") # This subject has no sleep file; doesn't currently handle gracefully

library(lubridate)
library(dplyr)

# Set appropriate working directory
setwd("~/dev/R/Fitbit_analysis_JHUDash/")
cat(paste0("Current working directory is: ", getwd()))

steps_format <- function(x, f) {
  steps <- read.csv(f, row.names = NULL, header = T, stringsAsFactors=F) # step data
  steps <- cbind(id = x, steps)
  names(steps) <- c("id", "time", "steps", "date", "DofW", "HofD", "MofH", "month") 
  steps$time <- ymd_hms(steps$time)
  steps$date <- ymd(steps$date)
  steps$DofW <- wday(parse_date_time(steps$time, 
                                           "Y%m%d %H%M%S"), abbr=T, label=T)
  # if month label uncomment below
  # steps$month <- month(steps$month, abbr=T, label=T)
  steps
}

sleep_format <- function(x, f) {
  sleep <- read.csv(f, row.names = NULL, header = T, stringsAsFactors=F) # sleep data
  sleep <- cbind(id = x, sleep)
  sleep$date <- ymd(sleep$date)
  sleep$DofW <- wday(parse_date_time(paste(ymd(sleep$date), 
                        sleep$startTime),"Y%m%d %H%M"), abbr=T, label=T)
  sleep$HofD <- hour(parse_date_time(paste(ymd(sleep$date), 
                                           sleep$startTime),"Y%m%d %H%M"))
  sleep$MofH <- minute(parse_date_time(paste(ymd(sleep$date), 
                                           sleep$startTime),"Y%m%d %H%M"))
  sleep$month <- month(parse_date_time(paste(ymd(sleep$date), 
                                           sleep$startTime),"Y%m%d %H%M"))
  sleep
}

df.steps <- data.frame()
df.sleep <- data.frame()
sleep.files <- list.files(path = "data", pattern = "sleep", full.names=T)
steps.files <- list.files(path = "data", pattern = "step", full.names=T)

sleep.files <- strsplit(sleep.files, split = " ")
steps.files <- strsplit(steps.files, split = " ")

for (s in 1:length(sleep.files)) {
  # steps
  sleep <- sleep_format(s, sleep.files[[s]])
  df.sleep <- rbind(df.sleep, sleep)
}

for (s in 1:length(steps.files)) {
  steps <- steps_format(s, steps.files[[s]])
  df.steps <- rbind(df.steps, steps)
}

all_data <- inner_join(df.steps, df.sleep, by="date")

names(all_data) <- c("id", "time", "steps", "date", "DofW.steps",
                     "HofD.steps", "MofH.steps", "month.steps",
                     "id.sleep", "sleep.start", "sleep.end", "sleep.duration",
                     "awoken.count", "restless.count", "awake.time",
                     "restless.time", "min.asleep", "sleepQuality.B",
                     "sleepQuality.A", "DofW.sleep", "HofD.sleep", "MofH.sleep",
                     "month.sleep")

save(all_data, file = "data/all_data.Rdata")
# Note: I have no ordered the data at this point of checked for sort order
#
# usage
filter(all_data, date == ymd("2015-09-07") & HofD.sleep == 2 & id == 1)
