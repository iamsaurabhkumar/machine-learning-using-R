#this is a comment
v1<- 5
v2<- 10
v1+v2
v1+v1
c1<- "hello"
c1+v1
v1**5

class(v1)
l1<- TRUE
I1<- 3+2i
vec1=c(1,2,3,4,5)
char=c('hey' , 'hello' , 'go' )
cghar=c('hey' , 'hello' , 'go' , 5 , 6 , 7 )
text=c(F,"cat")
vec2=c(2,4,7,8,6,8,9)
vec1+vec2
5>10
5<2
vec1<5
vec1==5
v=1:10
matrix(v)
matrix(v,nrow=2)
matrix(v,ncol=5)
mat=matrix(v,ncol=2)
mat[3,2]
mat[,3]
mat[,2]
mat2=matrix(1:20,ncol=2,byrow=F)
google=c(10,20,30,40,12,22,35,45)
mat3=matrix(google,nrow=2,byrow=T)
mat3


googl=c(1,2,3,4,5)
mfst=c(10,15,20,30,40)
stocks=c(googl,mfst)
mat4=matrix(stocks,nrow=2,byrow=T)
mat4
rownames(mat4)=c("google","msft")
mat4
colnames(mat4)=c("day1","day2","day3","day4","day5")
mat4
colSums(mat4)
rowSums(mat4)
rowMeans(mat4)
colMeans(mat4)
fb=c(4,6,33,43,55)
mat5=rbind(mat4,fb)
mat5
colMeans(mat5)
colMeans(mat5)

mat6=cbind(mat5,avg=c(rowMeans(mat5)))
mat6


state.x77
mtcars
data()

s_names=c("a","b","c","d","e")
s_age=c('20','23','22','21','23')
s_gender=c('m','f','m','f','m')
frame=data.frame(s_names,s_age,s_gender)
frame
View(frame)
head(frame)
tail(frame)

mtcars
View(head(mtcars))
View(tail(mtcars))
str(mtcars)
summary(frame)
frame[,2:3]
frame[2:5,]
summary(s_age)

#factors
animals=c('cats','dogs','cats','dogs','dogs','cats')
factor(animals)

#visualization
install.packages("ggplot2")
