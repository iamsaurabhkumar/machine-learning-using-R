
rm(list = ls())

# get data
#filename and filepath corresponding to the adult income dataset that you would have downloaded
income <- read.csv("adult_income.csv")
str(income)

# baseline accuracy
#prop table is used to check the proportions
prop.table(table(income$income))  # 0.76

# divide into train and test set
set.seed(123)
split.indices <- sample(nrow(income), nrow(income)*0.8, replace = F)
train <- income[split.indices, ]
test <- income[-split.indices, ]

# Classification Trees
library(rpart)
library(rpart.plot)
library(caret)

#1 build tree model- default hyperparameters
tree.model <- rpart(income ~ ., data = train) 

# display decision tree
prp(tree.model)

# make predictions on the test set
tree.predict <- predict(tree.model, 
                        test)

pred_income <- as.factor(ifelse(tree.predict[,2] >= 0.3, ">50K", '<=50K'))

install.packages('e1071')
# evaluate the results
confusionMatrix(pred_income, test$income,
                positive = ">50K")  # 0.8076

#2 Change the algorithm to "information gain" 
# instead of default "gini" ----------------------

tree.model <- rpart(income ~ .,                     # formula
                    data = train,                   
                    parms = list(split = "information"))

# display decision tree
prp(tree.model)

# make predictions on the test set
tree.predict <- predict(tree.model, test)

# evaluate the results
confusionMatrix(tree.predict, test$income, positive = ">50K")  # 0.8076


#3 Tune the hyperparameters ----------------------------------------------------------

tree.model <- rpart(income ~ .,                                # formula
                     data = train,                             # training data
   control = rpart.control(minsplit = 100, 
           minbucket = 100, maxdepth = 10))     




# display decision tree
prp(tree.model)

# make predictions on the test set
tree.predict <- predict(tree.model, test, type = "class")

# evaluate the results
confusionMatrix(tree.predict, test$income, positive = ">50K")  # 0.77740

