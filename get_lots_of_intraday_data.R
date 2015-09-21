# This script uses the fitbitScraper package - you need to install that first!
# Then edit to include your fitbit login info, and the dates and data type
# you want to scrape.

# Create cookie w/ your fitbit account login info
#cookie <- login(email="fitbit login email", password = "fitbit password")

# Specify dates and data
start_date <- as.Date("2015-01-01")
end_date <- as.Date("2015-09-15")
data_to_get = "steps" # or "distance", "floors", "active-minutes", "calories-burned", "heart-rate"

# ------ Edit above this line, shouldn't need to edit below -------------

# Initialize empty data frame
steps_df = data.frame(day=as.Date(character()), time=character(), steps=integer(), stringsAsFactors=FALSE)

# Loop over days and scrape
date_seq = seq(start_date, to = end_date, by = "day")
i = 1
while (i <= length(date_seq)) {
  print(i)
  # Scraper call
  one_day_data = get_intraday_data(cookie, "steps", date = as.character(date_seq[i])) 
  i = i+1
  # Combine across days
  steps_df = rbind(steps_df, one_day_data)
}

# Pull date and time into separate columns
steps_df$date = format(steps_df$time, format = "%Y-%m-%d")
steps_df$wday = wday(steps_df$time, label=TRUE, abbr=TRUE)
steps_df$hour = hour(steps_df$time)
steps_df$minute = minute(steps_df$time)
steps_df$month = month(steps_df$time)
