#for validating a condition we will use the if-else condition
x=5
if(x>21)
{print('hello')
}else{
print('hogya')
}


#else if condition
x=5
if(x>5){
  print('hello')
}else if(x==5){
  print('done')
}else{
  print('lasto')
}

temp=10
result='cool'
if(temp>=20 & temp<=25){
  result="cool"
}else if(temp>=26 & temp<=35){
  result="hot"
}else if(temp>35){
  result="very hot"
}
print(result)

#ifelse

a=20
b=ifelse(a>=10,'yes','no')
print(b)

temp=29
result=ifelse(temp>=20 & temp<=25,"cool",ifelse(temp>=26 & temp<=35,"hot",ifelse(temp>35,"very hot")))
print(result)

#loops are used for the repeatative use of variables
#while loop and for loop
#while works on the basis of a condition ,runs until the condition is false
#x=1 while(x<=10){print("hello")}

x=1
while(x<=20){
  x=x+1
  print(x)
}

x=5
while(x<=50){
  
  print(x)
  x=x+5
}

#for loop 
#in this we specify the no. of iterations
#for(i in 1:10)
for(i in 1:10)
{
  print(i*5)
}
# write a code to find the factorial of a number using the for loop or while loop
y=0
for(i in 10:1)
{
  y=y*i
}
print(y)

#we use [i] to iterate according to the row
data=read.csv("OfficeSupplies.csv")
View(data)
data$sales=data$Units*data$Unit.Price
for(i in 1:nrow(data)){
data$rating[i]=ifelse(data$sales[i]<=500,"good",ifelse(data$sales[i]>=500 & data$sales[i]<=1000,"very good",ifelse(data$sales[i]>1000,"excellent")))
}
#to check the 1st row of the data frame
#data.frame[row,col]

data[1,5]
data[,3]
data[2]
