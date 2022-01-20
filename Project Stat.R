rm(list=ls())
getwd()
setwd("~/Downloads")
redwine = read.csv(file="winequality-red.csv", header=TRUE,sep=';')
str(redwine)
#Random Select Data
set.seed(1)
redwine.new<-redwine[sample(1:nrow(redwine), 1000),]
write.table(redwine.new, file="redwine.new")
read.table("redwine.new")
# Question One ----
#Create a scatterplot to visualize relationship between x and y
x= redwine.new$citric.acid
y= redwine.new$pH
plot(y~x, data=redwine.new, xlab= "Citric Acid", ylab= "pH",
     main= "How does Citric Acid impact red wine pH levels?")
# Correlation coefficient between citric.acid and pH
cor(x,y)
#Create simple linear model
Linear_Model= lm(y~x,data=redwine.new)
summary(Linear_Model)
#Create a regression line to go through the scatterplot to help better visualize the data
abline(Linear_Model, col="red")
# Find t critical value given 95% confidence level
alpha=0.05 # alpha=1-confidence level
qt(1-alpha/2,nrow(redwine.new)-2)
# Find p-value of t test
t.value=-20.44
2*pt(abs(t.value),nrow(redwine.new)-2,lower.tail=FALSE)
# Superimpose the (point-wise) 90% confidence band on the scatter plot
summary(x)
x=seq(0.0,1.0,by=0.2);x
ci90=predict(Linear_Model, data.frame(citric.acid=x),level=0.90,interval="confidence")
lines(x,ci90[,2],col="blue"); lines(x,ci90[,3],col="blue")
#Plot residuals
plot(Linear_Model$residuals~Linear_Model$fitted.values,xlab="Predicted values",ylab="Residuals")
abline(h=0,col="red")
#Make a normal probability plot of residuals
qqnorm(Linear_Model$residuals,main="Normal probability plot of residuals")
# Question Two ----
# Model 1
model.one= lm(pH~fixed.acidity+volatile.acidity+citric.acid, data=redwine.new)
summary(model.one)
#Plot residuals
plot(model.one$residuals~Linear_Model$fitted.values,xlab="Predicted values",ylab="Residuals")
abline(h=0,col="red")
#Make a normal probability plot of residuals
qqnorm(model.one$residuals,main="Normal probability plot of residuals")
# ANOVA table for model one
anova(model.one) # Type I ANOVA
# Obtain SST, SSE, & SSR for Model 1
anova(update(model.one,~1),model.one)
# F critical value given alpha=0.05; Model 1
alpha=0.05 # alpha=1-confidence level
qf(alpha,5,nrow(redwine.new)-5-1,lower.tail=FALSE)
qf(1-alpha,5,nrow(redwine.new)-5-1)
# p-value of F test; Model 1
F.stat=312.9
pf(F.stat,5,nrow(redwine.new)-5-1,lower.tail=FALSE)
1-pf(F.stat,5,nrow(redwine.new)-5-1)
# Model 2
#Quality Rating Bin Conversion
redwine.new$quality = as.character(redwine.new$quality)
redwine.new$quality[redwine.new$quality>= 6] = "Good"
redwine.new$quality[(redwine.new$quality<6 & redwine.new$quality>=5)] = "Okay"
redwine.new$quality[(redwine.new$quality<5 & redwine.new$quality>= 3)] = "Poor"
redwine.new$quality = as.factor(redwine.new$quality)
str(redwine.new$quality)
summary(redwine.new)
#Turning bins into dummy variables
redwine.new$Good = redwine.new$quality
redwine.new$Okay = redwine.new$quality
redwine.new$Good= as.character(redwine.new$Good)
redwine.new$Good[redwine.new$Good=="Good"]= 1
redwine.new$Good[redwine.new$Good=="Okay"]= 0
redwine.new$Good[redwine.new$Good=="Poor"]= 0
redwine.new$Okay= as.character(redwine.new$Okay)
redwine.new$Okay[redwine.new$Okay=="Good"]= 0
redwine.new$Okay[redwine.new$Okay=="Okay"]= 1
redwine.new$Okay[redwine.new$Okay=="Poor"]= 0
#We won't be making a dummy variable for "Poor" and will instead leave that as our âbaselineâ
redwine.new$Good= as.factor(redwine.new$Good)
redwine.new$Okay= as.factor(redwine.new$Okay)
levels(redwine.new$Good)
levels(redwine.new$Okay)
summary(redwine.new)
#Visualize the relationship between alcohol and density
plot(density~alcohol, data=redwine.new, xlab= "Alcohol", ylab= "Density",
     main= "How does an alcohol impact red wine density levels?")
#Does quality rating have an impact on density/ is it worth including as an interaction term?
scatterplot(density~alcohol|Okay,data=redwine.new,smooth=FALSE,xlab="Alcohol",ylab="Density")
#Build our multiple linear model with interaction between okay and alcohol
#Leave out categorical variable good as the baseline
model.two= lm(density~alcohol+Good+Okay+alcohol*Okay, data=redwine.new)
summary(model.two)
#Model Three
#Create a vector including all viable columns (we don't want to include our
#categorical variable quality but instead only include our dummy variables
#derived from this column)
summary(redwine.new)
ModelThreeData = cbind("fixed.acidity", "volatile.acidity", "citric.acid",
                       "residual.sugar", "chlorides", "free.sulfur.dioxide",
                       "total.sulfur.dioxide", "density", "pH", "sulphates",
                       "alcohol","Good", "Okay")
RedWine = redwine.new[,ModelThreeData] # empty space for row/column means to return all
names(RedWine) # show variables in the dataset
summary(RedWine)
#Building a model using backward elimination
m0<-lm(pH~.,data=RedWine); summary(m0)
m.step<-step(m0,direction="backward") # stepwise regression
summary(m.step)