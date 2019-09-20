View(mtcars)
install.packages("ggplot2movies")
#histogram
View(movies)
ggplot(movies,aes(x=rating)) + geom_histogram(binwidth = 0.1)
ggplot(movies,aes(x=rating)) + geom_histogram(bins= 10, colour='white',fill='red') + ggtitle("Histogram")
#scatter plot
View(mtcars)
ggplot(mtcars,aes(x=wt,y=mpg)) + geom_point(aes(colour=factor(cyl),size=factor(cyl),shape=factor(cyl))) +ggtitle("Scatter plot") + xlab('weight') + ylab('miles')
#factor is used to distinguish b/w the diff cylinders by diff colors , size , shape
#bar chart
View(mpg)
ggplot(mpg,aes(x=manufacturer)) +geom_bar(color='#FF1700',fill='#FFD100')
ggplot(mpg,aes(x=manufacturer)) +geom_bar(aes(fill=class))
ggplot(mpg,aes(x=manufacturer)) +geom_bar(color='#FF1700',fill='#FFD100')

#interquartile range
mtcars

ggplot(mtcars,aes(x=factor(cyl),y=mpg)) +geom_boxplot()                                          


# central tendency

#mean
s_height = c(100,102,106,109,119,109,122 )
mean(s_height  )
median(s_height )
s1_height = c(100,200,150,120102,106,109,119,109,122,NA,200,100000 )
mean(s1_height, na.rm = T , trim = .1 )
median(s1_height,na.rm = T, trim = .1)
#no direct way to find the mode

table(s_height)

mode_value=109
a=table(s_height)
sort(a , decreasing = T )[1]

#quantile
quantile(s_height)

length(s_height)

#interquantile range
IQR(s_height)

#standard deviation
b=sd(s_height)
b
#variance
var=b^2
var

summary(s_height)

#descriptive stats using psych package
install.packages('psych')
describe(s_height)
