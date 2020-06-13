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


##### Time Series plot - Plot 2
plot(powerdata$datetime, powerdata$Global_active_power, type ="l", 
     ann=FALSE)
##No labels
mtext(side=2, line=3, "Global Active Power (kilowatts)")
##Adding y-axis label

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
##saving the plot as a *.png file
