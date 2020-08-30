## function to get the data
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
  return(df)
}

## call the function to get the data
plot_df <- get_data()

## setup the plot
par(mfrow=c(2,2), mar=c(3,3,2,1), oma=c(0,0,2,0))
plot(plot_df$Global_active_power~plot_df$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(plot_df$Voltage~plot_df$dateTime, type="l", ylab="Voltage (volt)", xlab="")
plot(plot_df$Sub_metering_1~plot_df$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(plot_df$Sub_metering_2~plot_df$dateTime,col='Red')
lines(plot_df$Sub_metering_3~plot_df$dateTime,col='Blue')
## legend is not working correctly......
## adjust cex
## Not looking correctly in the png file...
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=.5)

plot(plot_df$Global_reactive_power~plot_df$dateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")

## copy the file, close the device

dev.copy(png,"plot4.png",height=480, width=480)
dev.off()

