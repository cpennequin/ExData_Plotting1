plot4 <- function (onpng) {
    # Load table
    # This assumes the file is in the working directory
    # There are incomplete lines resulting in unwanted coercion e.g.: 22/2/2007;22:58:00;?;?;?;?;?;?;
    # So we'll tag them: na.strings="?"
    
    library(data.table)
    data = fread("household_power_consumption.txt", sep = ";" , header = TRUE,  na.strings="?")
    
    # Subset to the two days
    twoDays <- data[ which( data$Date == "1/2/2007" | data$Date == "2/2/2007") , ]
    
    filePNG <- "plot4.png"
    if (onpng) {
        png(file=filePNG, width=480, height=480) 
    }
    
    dateTime <- strptime(paste(twoDays$Date, twoDays$Time),format="%d/%m/%Y %H:%M:%S")
    gap <- twoDays$Global_active_power
    voltage <- twoDays$Voltage
    grp <- twoDays$Global_reactive_power
    
    par(mfrow=c(2,2))
    plot(dateTime,gap,type="l",ylab="Global Active Power", xlab="")
    plot(dateTime,voltage,type="l",ylab="Voltage", xlab="datetime")
    
    plot(dateTime,twoDays$Sub_metering_1,type="l",ylab="Energy sub metering", xlab="")
    lines(dateTime,twoDays$Sub_metering_2, col="red")
    lines(dateTime,twoDays$Sub_metering_3, col="blue")
    legend("topright", col = c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")
    
    plot(dateTime,grp,type="l",ylab="Global_reactive_power", xlab="datetime")
    
    
    if (onpng) {
        dev.off() 
        cat(paste("Plot saved in file: ",filePath(getwd(),filePNG)))
    }
}


# Pass TRUE to save to file, FALSE to plot to screen
plot4(TRUE)
