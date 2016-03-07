plot2 <- function (onpng) {
    # Load table
    # This assumes the file is in the working directory
    # There are incomplete lines resulting in unwanted coercion e.g.: 22/2/2007;22:58:00;?;?;?;?;?;?;
    # So we'll tag them: na.strings="?"
    
    library(data.table)
    data = fread("household_power_consumption.txt", sep = ";" , header = TRUE,  na.strings="?")
    
    # Subset to the two days
    twoDays <- data[ which( data$Date == "1/2/2007" | data$Date == "2/2/2007") , ]
    
    filePNG <- "plot2.png"
    if (onpng) {
        png(file=filePNG, width=480, height=480) 
    }
    
    y <- twoDays$Global_active_power
    x <- strptime(paste(twoDays$Date, twoDays$Time),format="%d/%m/%Y %H:%M:%S")
    plot(x,y,type="l",ylab="Global Active Power (kilowatts)", xlab="")
    
    if (onpng) {
        dev.off() 
        cat(paste("Plot saved in file: ",filePath(getwd(),filePNG)))
    }
}


# Pass TRUE to save to file, FALSE to plot to screen
plot2(TRUE)
