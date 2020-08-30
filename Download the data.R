get_data <- function()
{

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

df <- df[complete.cases(df),]
## strptime(x, format)
dateTime <- paste(df$Date, df$Time)
temp <- setNames(dateTime, "DateTime")
df <- df[ ,!(names(df) %in% c("Date","Time"))]
df <- cbind(temp, df)
df$dateTime <- as.POSIXct(temp)

}