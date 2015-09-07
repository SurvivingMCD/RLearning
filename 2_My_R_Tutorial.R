getwd() #Get working directory
setwd("C:/Users/Stephane/Desktop/Coursera/Data Science/RWORK") #set working directory an absolute route
setwd("../")#goes up to the upper directory, uses relative routes
dir() #lists all files in current directory
x <- 1:10 # Assigns to x a numeric vector going from 1 to 10
y <- c(2,5,7,2,3)#c stands for concatenate create a vector of the elements in it
x <- c(x,x)#concatenates the contets of x twice and puts it in x
x <- rep(x,5)
ls() # list all objects in current workspace
class(x) # tells you the class of an object
print(x)#prints the contents of x 
x#uses the auto-print option to print x
str(airquality) #returns the abbreviated structure of an object

ret5 <- function(s){ s[5]} #creates a function named ret5 that receives a one dimensional vector and returns the 5th element
ret5(x)#returns 5
ret5(y)#returns 3
myfunc <- function(){
  x <- rnorm(100)#creates a vector of 100 random numbers generated from a standard normal distribution N(0,1)
  mean(x)#returns the mean of the 100 numbers which should be close to 0
}


rep(1:4,4) #repaeats 1 to 4 four times  1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4
rep(1:4,each = 4)#1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4
rep(1:4,4:1)#repeats 1 4 times 2 3 times 3 2 times and 4 1 time and puts it in a num vector
rep(c("hi","bye",10))#repeats "hi" and "bye" 10 times

paste(y, collapse = ",") # Concatenates in a string the elemnets of y separated by ,
paste(x,y,sep = " ")# creates a character vector with the 1st element of x concatenated with the first element of y the second with the second and so

cbind(x,y) # creates a matrix with elements of x in column 1 and y in column 2 it reuses y until filled
rbind(x,y)# same thing but by row



x<- 0/0#will create a NaN value as it is undefined
is.nan(x)#a Nan can be tested by this function, will return TRUE
is.na(x)#a Nan is also an NA undefined value, will return TRUE

#vectors
x <- vector("numeric",10)#creates an empty atomic vector of class numeric and length 10
length(x) #returns the length of a vector
x <- 1:3
names(x) <- c("first","second","third")
##There are four types of atomic vectors in R
classes <- c("numeric","logical","character","complex")
paste("as",classes,sep = ".")
#Explicit conversion of classes are done with the following functions
as.numeric()
as.logical()
as.character()
as.complex()  

##Matrix data type
my.matrix <- matrix(1:4,2,2)# Creates a matrix of two by two with four elements, they are ordered in a column by column fation
my.matrix2 <- matrix(1:4,2,2,byrow = TRUE)# Creates a matrix of two by two with four elements, they are ordered in a row by row fation
my.matrix3 <- matrix(rnorm(100),10,10) # cretes a 10 by 10 matrix with 100 random values from a normal distribution of mean 0 and standard deviation 1
my.matrix3[,1] # returns a vector with the first column in the matrix

m<- matrix(nrow=2,ncol=3)#creates an empty matrix with 2 rows and 3 columns, all values are NA
attributes(m)#returns a list with all attributes of the matrix in this case only $dim

m <- 1:10 #a numeric vector form 1 to 10
dim(m)#m has no dimensions as it is a vector
dim(m) <- c(2,5)#converts m into a matrix of 2 rows and 5 columns

##lists are a special type of vector
x<- list(1,"a",TRUE,1+4i)#this type of class can handle multiple classes and does not implicitly coerce elements
lapply(x,class)#for each list element tells you the class within than can be an atomic vector or another list
# [[1]]
# [1] "numeric"
# 
# [[2]]
# [1] "character"
# 
# [[3]]
# [1] "logical"
# 
# [[4]]
# [1] "complex"
y <- list(x,x)
# [[1]]
# [[1]][[1]]
# [1] 1
# 
# [[1]][[2]]
# [1] "a"
# 
# [[1]][[3]]
# [1] TRUE
# 
# [[1]][[4]]
# [1] 1+4i
# 
# 
# [[2]]
# [[2]][[1]]
# [1] 1
# 
# [[2]][[2]]
# [1] "a"
# 
# [[2]][[3]]
# [1] TRUE
# 
# [[2]][[4]]
# [1] 1+4i
lapply(y,class)
# [[1]]
# [1] "list"
# 
# [[2]]
# [1] "list"





##factors allow the use of categorical data and the use of levels
x <- factor(c("yes","no","yes","no","yes","no","yes","no"))#creates a factor class with two levels 
unclass(x)#shows the complete structure of a factor has attr(,"levels") "no" "yes" coded 2 and 1 because uses alphabetical order
str(x)#Factor w/ 2 levels "no","yes": 2 1 2 1 2 1 2 1
table(x)#frequency count of each element in the data set
# x
# no yes 
# 4   4 
x <- factor(c("yes","no","yes","no","yes","no","yes","no"),levels("yes","no"))#creates a factor class with two levels in this case yes is coded as 1 and no as 2
f <- gl(10,10,labels = LETTERS[1:10]) #Generate levels 10 levels repeated 10 times with actual value lables using the first 10 letters of the alphabet
class(f)#f is a factor
as.factor(1:10)# Considers the object as a factor of levels
str(f)#returns the structure, a factor class vector with 10 levels, 4 first levels, and first 10 values

##Data frames
df<-data.frame(rep(NA,54),rep(NA,2))#Creates an empty data frame of 54 rows and 2 columns
data.matrix(df)#converts a data frame into a matrix but implicit coercion will happen since a matrix has to have all data in the same class

heigths <- c(188.2, 192.1, 167.3, 178.7)# c stands for concatenate
names <- c("juan","pedro","luis","miguel")
smokes <- c("yes","yes","no","no")
df <- data.frame(heigths,names,smokes)#creates a data frame, a table structure that accepts different classes but all of same length, the representation of tabular data in R
df[1,]#obtains the first row of data
df[,1]#obtains the frist column of data
levels(df$smokes)# returns the distinct type of levels that exist in the factor

##subsetting data
x<- 10:1
x<5 #returns a boolean vector with true if elemnt x[i] < 5
which(x<5)#returns only the indexes of those elements that match to TRUE, Which indices are true
x[x<5] #only returns those elements in x that are true for the condition


##Basic stats commends
table(airquality$Month)
# 5  6  7  8  9 
# 31 30 31 31 30 
table(airquality[,c(5,6)])
# Day
# Month 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
# 5 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
# 6 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  0
# 7 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
# 8 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
# 9 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  0
summary(airquality)
# Ozone           Solar.R           Wind             Temp           Month            Day      
# Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00   Min.   :5.000   Min.   : 1.0  
# 1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00   1st Qu.:6.000   1st Qu.: 8.0  
# Median : 31.50   Median :205.0   Median : 9.700   Median :79.00   Median :7.000   Median :16.0  
# Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88   Mean   :6.993   Mean   :15.8  
# 3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00   3rd Qu.:8.000   3rd Qu.:23.0  
# Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00   Max.   :9.000   Max.   :31.0  
# NA's   :37       NA's   :7                                                           


##reading data from txt or csv files
read.table("filename.txt")
read.csv("filename.csv")


##Control structures
system.time({#additional curly brackets to indicate its a function 
r <- numeric(1000)#creates an empty numeric vector of length 5 --> 0 0 0 0 0
for(i in 1:length(r)) {#will run the code in brackets from 1 to 5
  x <- rnorm(length(r))#generate a numeric vector of 5 random numbers based on the standard normal distribution
  r[i] <- mean(x)#put in r[i] the mean of the numbers in x
}
})



##simulations

vect1 <- rnorm(100,2,4) #creates a randomized vector of 100 elements using a normal distribution of mean 2 and standard deviation of 10
summary(vect1)# mean is 2.336 - will change everytime
vect2 <- runif(100,0,10)#creates a randomized vector of 100 elements using the unifrom distribution, equal probability, indicates a min and max value
vect3 <- sample(1:10,100replace=T)#Samples from values 1 to 10 a set of 100 elements, accepts replacement
sample(10) #easiest way of creating a rondomized permutation of values 1 to 10 
vect4 <- sample(1:2,10,replace=T,prob = c(0.1,0.9))#samples 10 elements from the set 1 and 2 with replacement where 1 comes out with probability 10% and 2 probability 90%

normal <- rnorm(10) #10 values randomly generated from a standard normal distribution N(0,1)
pnorm(normal)# gives the probability of obtaining value normal[i] or lower - cumulative probability distribution
pnorm(normal,lower.tail=FALSE)# Same but now cumulative distribution from the right hand tail
qnorm(0.99)# returns 2.32 which is the value for which with 99% probability will be lower than this
qnorm(0.95)# returns 1.6448 will never get 1.69 because considering all of the lower tail, one tailed-test
plot(x,dnorm(x))#plots the density probability function
plot(x,pnorm(x))# plots the cumulative density probability function
random.probs <- sort(runif(100))
plot(lala,qnorm(lala)) # inverse of the cumulative probability function


## Model is y = 0.5 + 2*x + e and e - N(0,2) let x be N(0,1)
set.seed(20)#for reproducibility
x<- rnorm(100) #100 values from a standard normal distribution
e<- rnorm(100,0,2)# error term
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)
cor(x,y)









##data set exploratory analysis
head(mtcars) #returns the first 6 elements of a data frame called mtcars
summary(mtcars) #for each column in the dataset returns a summary structure with min max quartiles mean and median values
str(mtcars)#structure of data frame, name of objects, class of each column, number of observations and numbers of variables, first 10 values of each variable

range(mtcars$mpg)#returns the min max value for the mpg column  in the data set
range(mtcars[,1])#exact same thing
range(mtcars[["mpg"]])#exact same thing
mean(mtcars) # returns an error, mtcars is not a numeric vector

##using loop functions
lapply(mtcars,mean)#returns the mean for each column in the data frame in the form of a list
lapply(mtcars,range)#returns a list with each element a length two numeric vector withb the minimum and maximum value of the data
sapply(mtcars,mean)#returns the same but in the form of a numeric vector instead of a list
sapply(mtcars,range)#returns the same but in the form of a matrix with two rows one for the min the other for the max
levels(as.factor(mtcars$mpg)#uses the numeric vector as a factor and creates a level for each value
lapply(mtcars,as.factor)
do.call(cbind,lapply(mtcars,as.factor))
lapply(lapply(mtcars,as.factor),levels)# for each column in the data set you convert the data to factors and then obtain the levels for each column
sapply(lapply(mtcars,as.factor),levels)# will not be simplified since each list element has a different length

x<- 1:1000
y<- 1000:1
x+y
mapply("+",x,y)
mapply(sum,x,y)


##Subsets
airquality.bymonth <- split(airquality,airquality$Month) #creates a list of dataframes where each element is a data frame with each given month
lapply(airquality.bymonth,summary,na.rm = TRUE) #provides the summary of all variables for each month
lapply(as.data.frame(airquality.bymonth[1]),mean,na.rm=TRUE) #provides the mean of each variable for the first month, removes all values NA, passes the na.rm to the function mean as a ,...


system.time(sample(1:1000000))
# user  system elapsed 
# 0.13    0.02    0.11 




order
cut
subset
unclass
split
delete <- ls()#delete all objects
rm(list = delete)
replicate
quantile
transform
gsub
seq(0,1,length =4)
