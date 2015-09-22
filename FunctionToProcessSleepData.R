#library(lubridate)

tot_stepsDay <- all_data %>% group_by(id,date) %>% summarise(steps_dayTotal = sum(steps))

#df = read.csv2(file = 'pathtofile',header = T,sep = ',',stringsAsFactors=F)

processSleepDF <- function(df){
  df$date = ymd(df$date)
  df$month = month(df$date)
  df$wday = wday(df$date,label=T)
  df$startTime = hm(df$startTime)
  df$startTimeHour = hour(df$startTime)
  df$startTimeMinute = minute(df$startTime)
  df$endTime = hm(df$endTime)
  df$endTimeHour = hour(df$endTime)
  df$endTimeMinute = minute(df$endTime)
  df$sleepDuration = as.numeric(df$sleepDuration)
  df$awokenCount = as.numeric(df$awokenCount)
  df$restlessCount = as.numeric(df$restlessCount)
  df$awakeTime = df$awakeTime
  df$restlessTime = df$restlessTime
  df$minAsleep = as.numeric(df$minAsleep)
  df$sleepQualityScoreB = as.numeric(df$sleepQualityScoreB)
  df$sleepQualityScoreA = as.numeric(df$sleepQualityScoreA)
  return(df)
}