#### Exploratory Data Analysis
##Peer-graded Assignment: Course Project 1
## Gnel

setwd("./R Tutorials/CourseProject1")
unzip("exdata_data_household_power_consumption.zip")
##Moved files from subfolder to the main forlder for further analysis - Should learn how to make a move in R
list.files() #Getting the list of the files in subfolder for the data


## Reading the data file
powerdata <- read.csv("household_power_consumption.txt", skip = 66636, nrows=2880, sep=";", 
                      col.names = colnames(read.table("household_power_consumption.txt", nrow = 1, sep=";", header = TRUE)))
##Readinng the rows that correspond to 2007/02/01 to 2007/02/02 
##Checking the dimentions of the data
head(powerdata)
tail(powerdata)
dim(powerdata)

#converting the Date and Time variables to R class
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
## powerdata$Time <- strptime(powerdata$Time, "%H:%M:%S") 
##Haven't used it but it works when I merge Date and Time together for the second plot
##Merging date and time variables together
powerdata$datetime <- as.POSIXct(paste(powerdata$Date,powerdata$Time))

##### Time Series plot - Plot 4
##Multiple plots
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))


with(powerdata, {
        ##plot[1,1]
        plot(powerdata$datetime, powerdata$Global_active_power, type ="l", 
             ann=FALSE)
        ##No labels
        mtext(side=2, line=3, "Global Active Power")
        ##Adding y-axis label
        
        ##pllot [2,1]
        plot(powerdata$datetime, powerdata$Voltage, type ="l", ylab = "Voltage", xlab="datetime")
        
        ##plot[1,2]
        with(powerdata, plot(powerdata$datetime, Sub_metering_1, type = "n", ann=FALSE))
        with(powerdata, lines(powerdata$datetime, Sub_metering_1, col = "black"))
        with(powerdata, lines(powerdata$datetime, Sub_metering_2, col = "red"))
        with(powerdata, lines(powerdata$datetime, Sub_metering_3, col = "blue"))
        ##No labels
        mtext(side=2, line=3, "Energy sub metering")
        ##Adding y-axis label
        
        legend("topright", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.width = strwidth("100,000,000,000,000"),
               lty = 1:1, pt.cex = 2, cex=0.8, bty ="n")
        ##plot[2,2]
        plot(powerdata$datetime, powerdata$Global_reactive_power, type ="l", ylab  = "Global_reactive_power", xlab="datetime")
})


dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()
