# get sleep data script
# inputs user name
# outputs sleep data frame to /data directory

library(lubridate)
# change this setting for git working directory
# setwd("~/dev/R/Fitbit_analysis_JHUDash/")

# Create cookie w/ your fitbit account login info
# cookie <- login(email="fitbit login email", password = "fitbit password")

cat(paste0("Current working directory is: ", getwd()))
# get the user name or id for thier step data
user_id <- readline("What is your name or id? ")

# write file to /data with user_id appended
file.name <- paste0("data", "/", user_id, "_", "sleep.csv")

# pull sleep data from fitbit
sleep <- get_sleep_data(cookie, start_date = "2014-10-01", end_date = "2015-09-20")

# convert sleep list() to a data frame
sleep_df <- data.frame(lapply(sleep$df, as.character), stringsAsFactors=FALSE)

write.csv(sleep_df, file = file.name, row.names = F)
