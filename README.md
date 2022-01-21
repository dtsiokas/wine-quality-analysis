Wine Quality Analysis

PART 1: SIMPLE LINEAR REGRESSION ANALYSIS (CHAPTERS 4, 16, 17)
In order to analyze the association between pH level and citric acid concentration, we set pH level as the response (y) variable and citric acid concentration as the predictor (x) variable. The pH level will be changed by the concentration of hydrogen ions (acidity) of a solution and that is provided by the citric acid. Thus, based on the definition, the citric acid concentration is the response variable and provided to predict the pH level.  
After constructing a scatterplot of the pH level against citric acid concentration, the R output showed the correlation coefficient between citric acid and pH level is -0.543303. Hence, there is a moderate, negative linear relationship between y and x. Therefore, there is no need for applying transformations. 
We created a simple linear model and regression line, we then superimposed the line on the scatterplot which is shown in Red below. Based on below given R output the LS line is:  ŷ = 3.426728 - 0.420232(x):![pic1](https://user-images.githubusercontent.com/71915516/150610059-64b2d7cf-9c19-40c5-8161-a6d40c3465ee.png)

![pic2](https://user-images.githubusercontent.com/71915516/150612268-4f60a008-c3d6-4492-bb3e-60816db3b434.png)



In this case, based on the above R output, se= 0.1274.  This means that the amounts by which pH level differs from predictions made by this model vary with a standard deviation of 0.1274. R2= 0.2952, and it means that the citric acid concentration accounts for 29.52% of the variation in the pH level. 
Hypothesis Test: H0: There is no linear relationship between x and y, 1= 0
        	   H1: There is a linear relationship between x and y, 1 0
By using R, and based on the output: 
t critical value: tn-2*= 1.962344, and t-test statistic: t = -20.44, and tstat= 20.44 >  tn-2*= 1.96.
P-value = 7.645773e-78 0.000< =0.05, thus, got conclusion:
Reject H0, hence, these data provide evidence of a linear relationship between x and y.
In this case, the 90% confidence band was shown in blue lines. (Red is LS line):
![pic3](https://user-images.githubusercontent.com/71915516/150612409-a8f50751-a15a-4153-8637-82801f5148dd.png)


Based on the two plots below, the residual spread around the horizontal line is not nearly constant, but instead it is random with no pattern. Therefore, the Linearity Assumption and Independence Assumption are satisfied.  However, the Equal Variance Assumption is violated as there is a greater spread near the right side of the axis compared to the left. The normal probability plot forms an approximately straight line, so the Normal Population Assumption is satisfied.

![pic4](https://user-images.githubusercontent.com/71915516/150612442-c2f16830-f0a7-4e20-a52d-1104471de8e5.png)
![pic5](https://user-images.githubusercontent.com/71915516/150612454-fc8458df-2dc1-40af-9eb7-2f3f7b8a6317.png)



PART 2: MULTIPLE LINEAR REGRESSION ANALYSIS (CHAPTERS 18, 19)
Model #1
(i) In this first model, we attempted to create a linear regression that predicts pH value, based on the predictor variables fixed acidity, volatile acidity, and citric acid. The ANOVA table for this model is shown below:

![pic6](https://user-images.githubusercontent.com/71915516/150612521-d4d7c403-a255-4f31-9808-392d81025993.png)


In order to make our interpretation of SST, SSE, & SSR we used the anova update function in r, the output of which is shown below:

![pic7](https://user-images.githubusercontent.com/71915516/150612573-d6500f3c-4541-4704-8f6d-93fbcb0c44f2.png)

SST, or the total sum of squares, measures the variation of values around the mean.  Looking at the above ANOVA table 24.320 is our SST value with 999 corresponding degrees of freedom.
SSE, or the error sum of squares, larger SSE means a larger portion of SST is remained in residuals; and a prediction will be less precise. Based on the above table, 12.612 is our SSE value with 996 degrees of freedom.
SSR, or the regression sum of squares, a larger SSR means that the linear model accounts
for a larger portion of SST.  In this example, SSR can either be found by referencing the updated ANOVA table or by taking the difference between SST and SSE. Regardless, we get a value of 11.709 with 3 corresponding degrees of freedom.
(ii)	The F test of the linear relationship takes hypothesis:

![pic8](https://user-images.githubusercontent.com/71915516/150612595-82e4e5ee-f34d-46e1-86b5-61d5572c232a.png)

There are two methods of getting a conclusion for this linear relationship:
The first way: Based on the critical value method we reject H0as F > Fcrit 
According to the summary table for our model, the test statistic F = MSR/MSE = 285.1 Based on a critical value test given alpha=.05 we get Fcrit= 2.613839.
As 285.1 > 2.613839 we reject H0.
The second way: Based on the p-value method we reject H0if p-value < α.
Conducting a p value test we get p=1.458568e-133
As 1.458568e-133 < .05 we reject H0.
(iii) To determine whether or not x3 is helpful to the regression model given that x1 and x2 are included, we can conduct a t-test for each coefficient. The hypotheses for this test will be:

![pic10](https://user-images.githubusercontent.com/71915516/150612652-bf02f2a0-e180-494f-9758-9ab326a4380c.png)

The p-value method states that we reject H0if p-value < α. Otherwise we do not reject H0. From the summary of our model one, we get:

![pic11](https://user-images.githubusercontent.com/71915516/150612731-89716f41-9e0c-4f29-87c7-901e6a51174d.png)

Based on this report, we learn that the test statistic for x3(citric.acid) is -4.036, and that the p-value is 5.86e-05. Since 5.86e-05 < .05 we reject H0. What this means is that even with the other predictor variables included in the model, x3’s contribution is not insignificant. On the other hand, we can see that x2’s contribution is not significant as it’s p-value is greater than alpha (.857>.05), meaning we cannot reject the null hypothesis for this variable.
Model #2 
(iv) In this model we will be attempting to predict wine density based on alcohol content and quality. In our dataset we had one categorical variable which was wine quality rating.  This variable ranged from values 1-8 and represented the scale rating for each red wine included in the dataset. 

![pic12](https://user-images.githubusercontent.com/71915516/150612748-3ca488d3-96a7-4b43-a2de-c71eaf254818.png)

Recognizing this variable, we converted it into a dummy variable based on the range of the rating in what are called bins.  In our first bin, we had ratings 6-8 and we labeled this bin as “good.” For our second bin, we had quality ratings 5-6 and we labeled these as “okay.” For our last bin we included qualities 3-5 and labeled this as “poor.”  We withheld our indicator variable poor to be our baseline.  In the output below, you can see the indicator variables, Good and Okay in the rightmost columns.

![pic13](https://user-images.githubusercontent.com/71915516/150612786-5cd33a3b-435c-4d4b-9d26-a2f973ffa337.png)

(v) Below is the summary table of model two:   

![pic14](https://user-images.githubusercontent.com/71915516/150612794-e8cb8775-7d8e-4487-825f-0100c984098d.png)

Using the above output we can assess the relationship between wine density, wine quality (i.e., good, okay, or poor), and alcohol content. The regression equation formulated using the above output can be seen below:
Density = b0 + b1X1+ b2X2 + b3X3+ b4X1*X3
Where b0, b1, b2, b3, and b4 are regression coefficients. X1 , X2 , and X3 are regression coefficients defined as:
X1 = The level of alcohol content in the bottle of red wine being observed.
X2 = 1, if good; X2 = 0, otherwise.
X3= 1, if okay; X2 = 0, otherwise. 
X1*X3 = an interaction term used to see if there is a synergistic relationship between variables
In our analysis, we must keep in mind that each dummy variable can only be understood when  compared with the base group (poor). In this example, a positive regression coefficient means that density is higher for the dummy variable “good”, than it was for the reference group “poor”.  On the other hand the negative regression coefficient for “okay” means that density is lower than it was for the reference group “poor”. 
From the summary table we can see that “good” is not statistically significant as it’s p value is greater than our alpha, therefore we can remove it from our model. “Okay” is statistically significant as it’s alpha is less than our alpha. Lastly, we see that our interaction term is also statistically significant as it’s alpha is less than our alpha.
(vi) The graph below shows the deferring slopes between alcohol levels and okay ratings: 
 
Aside from viewing the slopes, we also compared the coefficient of determination for a model that did have the interaction term which was 0.2657 versus the coefficient of determination for a model that didn’t have the interaction term which was 0.2599. 
Because of the differing slopes depicted in the above graph, the statistical significance of the indicator variable as was shown earlier with the p-test, and the clear improvement of the coefficient of determination leads us to believe that it would be best if we left the interaction term in the model.

![pic15](https://user-images.githubusercontent.com/71915516/150612842-16bf55f3-87e1-4ab4-9d34-d966276f672a.png)

Model #3 
(vii)  In this model, we implemented a backward subset selection in order to determine an optimal model. This was also accomplished by using Akaike Information Criterion (AIC), which is used to show how well the model fits the data it is generated from. First, we summarized the model taking all predictor variables into account to see the AIC and Adjusted R-squared values. By implementing R’s ‘step()’ function, the software determined that the best subset selection was to remove the variable ‘volatile acidity’. This caused the model’s adjusted R-squared value to increase from 0.6961 to 0.6963, as well as decrease the AIC of the model from -4949.82 to -4951.32. The lower AIC value and higher R square value indicates that this is a better model. Here is the output of the step() function:
![pic16](https://user-images.githubusercontent.com/71915516/150612886-0e68c93d-e358-4c57-829f-28a1e9fe459c.png)

After the step() function was implemented, the model with the lower AIC value emerged.
The Adjusted R Square value also increased as a result of this, indicating a better fit model. Here is the adjusted R-squared value before backwards subset selection:

![pic17](https://user-images.githubusercontent.com/71915516/150612908-1a2fa521-77e0-4f82-bb90-31fcdc7116ad.png)

After backwards subset selection:

![pic18](https://user-images.githubusercontent.com/71915516/150612936-c3f4a5d5-b83f-4612-89df-9b06940745db.png)

