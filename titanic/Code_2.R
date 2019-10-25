
#### Logistic Regression

# Creating dummy df
require(dummies)
View(ful_dum <- dummy.data.frame(full))

# Split the data back into a train set and a test set
tr_dum <- ful_dum[1:891,]

ts_dum <- ful_dum[892:1309,]

# Create training and validation datasets from train dataset 
# (which HAS target variable column)
require(caTools)
set.seed(100)

i <- sample.split(tr_dum$Survived,
                  SplitRatio = 0.8)

prop.table(table(full$Survived))

trn <- tr_dum[i,]
val <- tr_dum[!i,]

prop.table(table(val$Survived))


# Build the model 
model_1 <- glm(Survived ~ ., data = trn[,-1],
               family = 'binomial')

summary(model_1)
# AIC: 613.25

# Step reduction as per AIC
model_2 <- step(model_1, direction = 'both')

summary(model_2)

# AIC: 605.17

# Although best model as per AIC. But we will compare model fitness later.
# For now, let's continue to reduce insignificant variables despite AIC increases.

# Drop EmbarkedC
model_3 <- glm(formula = Survived ~ Pclass + SexFEMALE + Age + SibSp + 
               EmbarkedQ + titleMASTER + titleMISS, family = "binomial", 
               data = trn[, -1])

summary(model_3)
# AIC: 605.81

# Drop EmbarkedQ
model_4 <- glm(formula = Survived ~ Pclass + SexFEMALE + Age + SibSp + 
               titleMASTER + titleMISS, family = "binomial", 
               data = trn[, -1])

summary(model_4)
# AIC: 606.42

# Now all variables are significant.
# Choosing this as final model. 

# Let's compare their prediction on val dataset (unseen by model so far).
predicted_probability <- predict(model_4,newdata = val, type = "response")

# Setting cutoff value of predicted probability
pred_survived <- ifelse(predicted_probability > mean(predicted_probability), "1", "0")

# Lets see how good their prediction is.
actual_survived <- as.factor(val$Survived)

table(pred_survived, actual_survived)

require(caret)
confusionMatrix(pred_survived, actual_survived, positive = "1")

# We see that despite increse in AIC, there is negligible drop in accuracy.
# Thus, we choose model with all significant variables to avoid overfitting.
# Now prediction on test data (say future data; we don't know the actual result.)
test_pred <- predict(model_4, newdata = ts_dum, type = 'response')

test_pred <- ifelse(test_pred > mean(predicted_probability_4), "1", "0")

ts_dum$Survived <- test_pred

submission <- ts_dum[, c(1,2)]

write.csv(submission, "titanic.csv", row.names = FALSE)

################# -------------- ###############