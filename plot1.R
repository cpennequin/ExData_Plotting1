library(data.table)
library(R.utils)

plot1 <- function (onpng) {
    # Load table
    # This assumes the file is in the working directory
    # There are incomplete lines resulting in unwanted coercion e.g.: 22/2/2007;22:58:00;?;?;?;?;?;?;
    # So we'll tag them: na.strings="?"
    
    library(data.table)
    data = fread("household_power_consumption.txt", sep = ";" , header = TRUE,  na.strings="?")
    
    # Subset to the two days
    twoDays <- data[ which( data$Date == "1/2/2007" | data$Date == "2/2/2007") , ]
    
    filePNG <- "plot1.png"
    if (onpng) {
        png(file=filePNG, width=480, height=480) 
    }
    
    x <- twoDays$Global_active_power
    
    hist(x, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col="red")
    
    if (onpng) {
        dev.off() 
        cat(paste("Plot saved in file: ",filePath(getwd(),filePNG)))
    }
    
}

# Pass TRUE to save to file, FALSE to plot to screen
plot1(TRUE)
