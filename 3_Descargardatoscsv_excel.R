##Week 1 of getting and cleaning data
##
#install.packages("xlsx")
library(xlsx)
rm(cameras)
downloadtype <- 1 #xls 1 csv 0
setwd("C:/Users/Stephane/Desktop/Coursera/Data Science/GettingandCleaningData")
if(!file.exists("gcd_w1")){
  dir.create("gcd_w1")
}
localpath<-"./gcd_w1/"
if(downloadtype){
  deastfile<-"cameras.xlsx"
}else{
  deastfile<-"cameras.csv"
}

filepath<- paste(localpath,deastfile,sep="")
if(!file.exists(filepath)){
  if(downloadtype){
    url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
    }else{
    url<-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
  }
 
  download.file(url,filepath,mode="wb")
  list.files(localpath)
  downloadDate <- date()
}
if(downloadtype){
  cameras<- read.xlsx(filepath,sheetIndex = 1)
  #youcan read a file partially telling where the data is
#   colindex<-2:3
#   rowindex<-1:3
#   read.xlsx(filepath,sheetIndex = 1,rowIndex=rowindex,colIndex=colindex)
#write.xlsx() exist and can be used to record your results
#package XLConect is much more powerful
}else{
  readmethod <- rbinom(1,1,0.5)
  if(readmethod){cameras<-read.table(filepath,header=TRUE,sep=",")}else{cameras<-read.csv(filepath)}
  
}


head(cameras)
str(cameras)
summary(cameras)
nrow(cameras)
class(cameras)
lapply(cameras,class)
downloadDate

data.table

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
deastfile<-"borreme.csv"
filepath<- paste(localpath,deastfile,sep="")
download.file(url,filepath,mode="wb")
data <- read.csv(filepath)
head(data)
