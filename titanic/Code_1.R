####################################################################
####################################################################

rm(list = ls())
dev.off()

require(titanic)

# Imorting the datasets
train <- titanic_train
test <- titanic_test

require(dplyr)
full <- bind_rows(train, test)

# Let's take a peek at dataset
str(full)     
glimpse(train)

summary(full)

# Case matching
full <- mutate_if(full, is.character, toupper)

sapply(full, n_distinct)

# Check duplicates
duplicated(full[,-1])
sum(duplicated(full[,-1]))

colSums(is.na(full))
# NA's
# 418 in Survived
# 263 in Age
# 1 in Fare

# Cheking NA of 'Fare'.
which(is.na(full$Fare))

full[1044,]

# It has 'Pclass' = 3 and 'Embarked' = S
# Let's see if they have impact on price.

summary(full$Fare[which(full$Embarked == 'S' & full$Pclass == 3)])


# We see '0' Fare which seems ambiguous.
# Let's check in detail.
View(filter(full, Fare == 0))

# We see that for all Fare = 0 : 
#   1. 'Embarked' at Port 'S'; 
#   2. Are all male; 
#   3. Have SibSp and Parch '0' i.e. no family travelling with them.
#   4. Have only one person survived i.e. very low survival.

# It seems to be the working crew of the ship for many reasons
# Thus, Replacing NA with zero.
full$Fare[1044] <- 0

colSums(full == "", na.rm = T)
# Blanks
# 1014 in Cabin
1014 / nrow(full) * 100

# 77% missing values. Better drop it than imputing.
full$Cabin <- NULL

# 2 Blanks in Embarked.
table(full$Embarked)
full[which(full$Embarked == ""),]

require(ggplot2)
ggplot(full, aes(x = Embarked, y = Fare)) + 
       facet_grid(. ~ Pclass) + geom_boxplot() + 
       geom_hline(aes(yintercept = 80), col = "red", 
                   linetype = 2, size = 1)

# So we should replace it by 'C'
full$Embarked[which(full$Embarked == "")] <- "C"
full$Embarked <- as.factor(full$Embarked)

sapply(full, function(x) length(which(x == " ")))


#### EDA

# Univariate Analysis
titanic_plot <- ggplot(full[1:891,], 
                       aes(fill = factor(Survived)))

# Survived
titanic_plot + geom_bar(aes(x = Survived))
table(full$Survived)

# Pclass
titanic_plot + geom_bar(aes(x = Pclass))
titanic_plot + geom_bar(aes(x = Pclass), position = 'fill')

# Name
length(unique(full$Name))

# See duplicates in name
arrange(full[duplicated(full$Name) | duplicated(full$Name, fromLast = T),], Name)

# Split name format - Surname, Title. First name
require(stringr)
surname <- str_split(full$Name, pattern = ", ", simplify = T)
full$surname <- surname[,1]

title <- str_split(surname[,2], pattern = "[.]", simplify = T)
full$title <- title[,1]

firstname <- str_split(title[,2], pattern = " ", simplify = T)
full$firstname <- firstname[,2]

full$Name <- NULL

# Check titles
length(unique(full$title))
table(full$title)
# Many categories

# Titles which might have been approached by passengers in times of panic.
full$title[full$title %in% c('CAPT','COL','MAJOR','REV','DR')] <- 'OFFICER'

# Titles of novelties - Rich and Resourceful
full$title[full$title %in% c('DON','DONA','JONKHEER','LADY','MLLE','MME','SIR','THE COUNTESS')] <- 'NOVELTY'

# Synonym titles
full$title[full$title %in% c('MS')] <- 'MISS'

# Check again
full$title <- as.factor(full$title)
summary(full$title)

# First names
length(unique(full$firstname))

# Surname
length(unique(full$surname))

# Too much unique values
full$firstname <- NULL
full$surname <- NULL


#### Visualization ----
titanic_plot <- ggplot(full[1:891,], aes(fill = factor(Survived)))

titanic_plot + geom_bar(aes(x = title))
titanic_plot + geom_bar(aes(x = title), position = 'fill')

# Sex
titanic_plot + geom_bar(aes(x = Sex))
titanic_plot + geom_bar(aes(x = Sex), position = 'fill')

full$Sex <- as.factor(full$Sex)

# Age
titanic_plot + geom_histogram(aes(x = Age), 
                              binwidth = 10, col = 'black')

titanic_plot + geom_histogram(aes(x = Age),
                              binwidth = 10, col = 'black', 
                              position = 'fill')

summary(full$Age)
# Still NA's

# Check outliers
#seq 0 to 1 with .01 diff
plot(quantile(full$Age, seq(0,1,0.01), na.rm = T))
quantile(full$Age, seq(0,1,0.01), na.rm = T)

# At 100th percentile. Cap it.
# if we have a outlier at the bottom then we will floor the variable i.e. we will replace the value with the corresponding variable
full$Age[full$Age > 65] <- 67
summary(full$Age)

summary(full$Age)
# Still NA's

titanic_age <- full$Age

titanic_age <- ifelse(is.na(titanic_age), median(titanic_age, na.rm = T), titanic_age)


par(mfrow = c(1,2))
hist(full$Age, col = 'grey', main = 'Original Age')
hist(titanic_age, col = 'skyblue', main = 'Imputed Age')

# Skewed imputation. Does not seem right.

# NA imputation with mice.
require(randomForest)
require(mice)

mice_df <- full[,!colnames(full) %in% 
                  c('PassengerId','Survived','Ticket')]

set.seed(1)
mice_model <- mice(mice_df, method = 'rf')

mice_data <- complete(mice_model)

# Check imputation 
par(mfrow = c(1,2))

hist(full$Age, col = 'grey', main = 'Original Age')
hist(mice_data$Age, col = 'skyblue', main = 'Imputed Age')

# Seems good to impute.
par(mfrow = c(1,1))
full$Age <- mice_data$Age

# SibSp and Parch
titanic_plot + geom_histogram(aes(SibSp), binwidth = 1, col = 'black')
titanic_plot + geom_histogram(aes(SibSp), binwidth = 1, col = 'black', position = 'fill')

titanic_plot + geom_histogram(aes(Parch), binwidth = 1, col = 'black')
titanic_plot + geom_histogram(aes(Parch), binwidth = 1, col = 'black', position = 'fill')

# Both are not giving any clear info.

# Lets create a derived metric.
full$relatives <- full$SibSp + full$Parch
titanic_plot <- ggplot(full[1:891,], aes(fill = factor(Survived)))

titanic_plot + geom_histogram(aes(relatives), binwidth = 1, col = 'black')
titanic_plot + geom_histogram(aes(relatives), binwidth = 1, col = 'black', position = 'fill')

plot(quantile(full$relatives, seq(0,1,0.01)))
quantile(full$relatives, seq(0,1,0.01))
full$relatives[full$relatives > 7] <- 8

# Ticket
length(unique(full$Ticket))

# To many categories
full$Ticket <- NULL

# Fare
titanic_plot + geom_histogram(aes(Fare), bins = 10, col = 'black')
titanic_plot + geom_histogram(aes(Fare), bins = 10, col = 'black', position = 'fill')

# Check outliers
plot(quantile(full$Fare, seq(0,1,0.01)))
quantile(full$Fare, seq(0,1,0.01))

full$Fare[full$Fare > 262.375] <- 300

# Embarked
titanic_plot <- ggplot(full[1:891,], aes(fill = factor(Survived)))
titanic_plot + geom_bar(aes(Embarked))
titanic_plot + geom_bar(aes(Embarked), position = 'fill')

str(full)

#### EDA complete

require(dummies)
full_dum = dummy.data.frame(full)

