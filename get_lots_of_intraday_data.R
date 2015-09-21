# This script uses the fitbitScraper package - you need to install that first!
# Then edit to include your fitbit login info, and the dates and data type
# you want to scrape.

# Create cookie w/ your fitbit account login info
cookie <- login(email="fitbit login email", password = "fitbit password")

# Specify dates and data
start_date <- as.Date("2015-01-01")
end_date <- as.Date("2015-09-15")
data_to_get = "steps" # or "distance", "floors", "active-minutes", "calories-burned", "heart-rate"

# ------ Edit above this line, shouldn't need to edit below -------------

# Initialize empty data frame
all_data = data.frame(day=as.Date(character()), time=character(), steps=integer(), stringsAsFactors=FALSE)

# Loop over days and scrape
date_seq = seq(start_date, to = end_date, by = "day")
i = 1
while (i <= length(date_seq)) {
  print(i)
  # Scraper call
  one_day_data = get_intraday_data(cookie, "steps", date = as.character(date_seq[i])) 
  i = i+1
  
  # Pull date and time into separate columns
  one_day_data$day = format(one_day_data$time, format = "%Y-%m-%d")
  one_day_data$time = format(one_day_data$time, format = "%H:%M:%S")
  
  # Combine across days
  all_data = rbind(all_data, one_day_data)
}

