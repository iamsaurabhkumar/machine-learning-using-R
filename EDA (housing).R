#exploratory data analysis using tukey
#remove the null values
#remove useless values
#convert the data into factors

housefeat=read.csv("housefeatures.csv")
View(housefeat)
housesales=read.csv("housesalesdata.csv")
View(housesales)
#merge is used to combine the 2 data sets
housedata=merge(housefeat,housesales,by="ID")
View(housedata)
#to save the new dataset we can use the write.csv command
write.csv(housedata, file = "housedatacomplete.csv")
# summary of the data
summary(housedata)
#dim (dimentions) it is used for the col and rows
dim(housedata)
#structure of the dataset
str(housedata)

#as.character , as.integer ,  as.factor
#these are used for changing the type to character , integer , factor

housedata$CarpetArea = as.character(housedata$CarpetArea)
housedata$CarpetArea = ifelse(housedata$CarpetArea=="na",NA, housedata$CarpetArea)
housedata$CarpetArea = ifelse(housedata$CarpetArea=="Na",NA, housedata$CarpetArea)
housedata$CarpetArea = as.numeric(housedata$CarpetArea)
summary(housedata)

housedata$HouseType = as.factor(housedata$HouseType)
summary(housedata)
mean(housedata$DistFromStreet, na.rm = T)
sd(housedata$SalePrice)
sd(housedata$DistFromStreet, na.rm = T)

#to check the corelation b/w the data.
cor(housedata$BuiltYear, housedata$SalePrice)
#by default it will remove the blank values
#to take the values we will use complete.obs
cor(housedata$DistFromStreet,housedata$SalePrice,use="complete.obs")
cor(housedata$CarpetArea, housedata$SalePrice, use= "complete.obs")
#to check the distribution of numeric variables using histogram
options(scipen = 999)
hist(housedata$SalePrice)
boxplot(housedata$SalePrice, horizontal = T)
#table  function is used for count
table(housedata$SaleType, housedata$Zone)
#see distribution of categorical variable using table or prop.table
prop.table(table(housedata$SaleType,housedata$Zone))
#to find the corelation b/w n no. of columns we will filter out only numeric column
numeric_df=Filter(is.numeric, housedata)
names(numeric_df)
cor(numeric_df,use = "complete.obs")
View(housedata)

#filternonly the nmeric columns
numeric_df=Filter(is.numeric,housedata)
numeric_df

View(cor(numeric_df,use = 'complete.obs'))
#change the housecondition into factor
housedata$HouseCondition = as.factor(housedata$HouseCondition)
numeric_df=Filter(is.numeric,housedata)
numeric_df
View(cor(numeric_df, use='complete.obs'))
str(housedata)
#create a new column of year of renovation
housedata$renovated=(housedata$RenovateYear - housedata$BuiltYear)
View(housedata)
housedata=housedata[,-1]
View(housedata)

#missing values
#if there is any missing values we can replace it by mean and median value
#is.na will check for NAs in columns
#which is used for filter out the col sum

na.cols=which(colSums(is.na(housedata) ) >0 )
colSums(is.na(housedata))
na.cols
is.na(housedata)

which(colSums(is.na(housedata))>0)
housedata$CarpetArea = ifelse(is.na(housedata$CarpetArea),mean(housedata$CarpetArea,na.rm=T),housedata$CarpetArea)
housedata$DistFromStreet = ifelse(is.na(housedata$DistFromStreet),mean(housedata$DistFromStreet,na.rm=T),housedata$DistFromStreet)
View(housedata)
