##Exploratory Data Analysis
##Course Project 1 and week 1
setwd("C:/Users/Stephane/Desktop/Coursera/Data Science/ExploratoryDataAnalysis")
head(iris,10)
summary(iris)
boxplot(iris$Petal.Length, col = "blue")
abline(h = 5, col = "red")

boxplot(iris$Petal.Length ~ iris$Species, col = "blue")
abline(h = 5, col = "red")

hist(as.numeric(iris$Petal.Length), col = "red", breaks = 60)
rug(as.numeric(iris$Petal.Length))

hist( iris[iris$Species == "setosa",3], col = "red")
abline(v=1.2,lwd=6,col="magenta")
abline(v=median(iris[iris$Species == "setosa",3]), col="blue", lwd=4)
rug(as.numeric(iris[iris$Species == "setosa",3]))

par(mfrow=c(3,1),mar=c(4,4,2,1))#mar es de margins c(bottom, left, top, right)
for(i in 1:3){
  hist( iris[iris$Species == levels(iris$Species)[i],i], col = "red")
}

par(mfrow=c(3,1),mar=c(4,4,2,1))
for(i in 1:3){
  hist( subset(iris, Species == levels(iris$Species)[i])$Petal.Length, col = "red")
}


barplot(table(iris$Species),col="wheat",main="Number of plants in each Species")

names(iris)
par(mfrow=c(1,1),mar=c(4,4,2,1))
with(iris,plot(Petal.Length,Petal.Width))
abline(v=mean(iris$Petal.Length), lwd=2,lty=3)
abline(h=mean(iris$Petal.Width), lwd=2,lty=2)

par(mfrow=c(1,1),mar=c(4,4,2,1))
with(iris,plot(Petal.Length,Petal.Width,col=iris$Species))
abline(v=mean(iris$Petal.Length), lwd=2,lty=3)
abline(h=mean(iris$Petal.Width), lwd=2,lty=2)

colors()#list of all color names

x<- rnorm(100)
hist(x)
y<-rnorm(100)
plot(x,y,pch = 6)
legend(locator(1),legend="puntos",pch=6)##te permite poner la leyenda con posicion interactiva
text(locator(2),c("hola","adios"))##Permite añadir texto de manera dinamica, el argumento del locator indica cuantas veces se usa - prueba con 4


example(points)#see examples of plots
example(colors)#see examples of colors
?Devices
# windows
# pdf
# postscript
# bitmap
# xfig
# pictex
# png
# jpeg



lapply(household.energy,class)


hist(household.energy$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
boxplot(data$Global_active_power)


if(!file.exists("CourseProject1")){
  dir.create("CourseProject1")
}
"localpath<-""./CourseProject1/"
filename <- "household_power_consumption.txt"
filepath<- paste(localpath,filename,sep="")
data <- read.table(filepath,header=TRUE,sep=";",na.strings="?")
data <- read.table(filepath,header=TRUE,sep=";")
# test <- head(data$Date,1000)
# test2 <- head(data$Time,10)
names(data)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
lapply(data,class)
hist(data$Global_active_power)
day1 <- subset(data,data$Date == ("2007-02-01"))
day2 <- subset(data,data$Date == ("2007-02-02"))
household.energy <- rbind(day1,day2)
paste(household.energy$Date,household.energy$Time,sep=" ")
household.energy$Time <- strptime(paste(household.energy$Date,household.energy$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S")
for(i in 3:9) {
  household.energy[,i] <- as.numeric(household.energy[,i])
}

head(household.energy)
rm(data)



#plot1
png(filename="./CourseProject1/ExData_Plotting1/plots/plot1.png", width = 480, height = 480)
hist(data$Global_active_power)
dev.off()
#plot2
Sys.setlocale('LC_TIME', 'C')
with(household.energy,plot(Time,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=" "))


#plot3
with(household.energy,plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" "))
with(household.energy,points(Time,Sub_metering_2,type="l",col="red"))
with(household.energy,points(Time,Sub_metering_3,type="l",col="blue"))
legend("topright",lty = 1,legend = names(household.energy)[c(7:9)],col = c("black","red","blue"))

#plot4
par(mfrow = c(2,2))
with(household.energy,plot(Time,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=" "))
with(household.energy,plot(Time,Voltage,type="l",ylab="Voltage",xlab="datetime"))
with(household.energy,plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" "))
with(household.energy,points(Time,Sub_metering_2,type="l",col="red"))
with(household.energy,points(Time,Sub_metering_3,type="l",col="blue"))
legend("topright",lty = 1,legend = names(household.energy)[c(7:9)],col = c("black","red","blue"), bty = "n", xjust =1, cex = 0.85)## cex changes the size of the legend all together
with(household.energy,plot(Time,Global_reactive_power,type="l",xlab="datetime"))

##From grading

d1$datetime<-paste(d1$Date,d1$Time) 
d1$posixDate <- strptime(d1$datetime, "%d/%m/%Y %H:%M:%S") 
d1<-subset(d1,(d1$posixDate$mday==02 | d1$posixDate$mday==01) & d1$posixDate$mon==01 & d1$posixDate$year+1900==2007)


with(d1,{ 
  13      plot(posixDate, Global_active_power,type = "l",ylab = "Global Active Power",xlab="") 
  14      plot(posixDate, Voltage,type="l",ylab="voltage",xlab="datetime") 
  15      plot(posixDate,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="") 
  16      lines(x = posixDate,Sub_metering_2,col = "red") 
  17      lines(x = posixDate,Sub_metering_3,col = "blue") 
  18      legend("topright", lty = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty="n")    
  19      plot(posixDate, Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
    })

qdata<-read.table("house.txt", na.strings="?",header=T,skip=66636,nrows=2880,sep=";") 

with(qdata,hist(Global_active_power, col="red", main ="Global Active Power", xlab="Global Active Power (killowats)")) 
dev.copy(png, file ="plot1.png",width=480,height=480) 
dev.off() 

legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), cex=0.85, lwd=1.5, bty="n")
