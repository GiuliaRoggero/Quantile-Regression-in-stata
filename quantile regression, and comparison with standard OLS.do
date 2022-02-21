clear all
set more off

use C:\Users\giuli\OneDrive\Desktop\Stata_exercises_applied_microeconometrics\quantile_regression\quantile_health.dta
*ssc install grqreg
*ssc inst hdquantile
*ssc install transplot
global ylist totexp
global xlist suppins totchr age female white

describe $ylist $xlist
summarize $ylist $xlist

*descriptive statistic by quantile
sort $ylist
xtile ycat= $ylist,nq(4)
*I can pick which number I want!
bysort ycat: sum $ylist $xlist

*normal OLS regression.

reg $ylist $xlist
*look at the coefficient totchr
*for each additional number of total chronic condition we have increase in total expenditure of 2528 dollars.
*we only have on set of coefficient

*QUANTILE REGRESSION

qreg  $ylist $xlist , quantile(0.25)
*for those who have very low expenditures (0.25 quantile) we have that each additional number of total chroninc condition only bring up the total expediture by 782,4722.
*the effect is lower than the OLS regression.
*we have a significance difference than the OLs regression. that is a significance difference from OLS.




*se ometto, allora è il 0.50 quantile
qreg $ylist $xlist 



qreg $ylist $xlist, quantile(0.75)
*here the confidence interval includes the ols estimates therefore the coefficient of this quantile is not significantly different from the ols estimates of that.
*here we have a much stronger effect of the total number of cronic condion on the total expediture. for those who have higher expenditures


*plot dependent variable by quantiles
*THIS COMMAND IS NOT WORKING
qplot $ylist, recast(line)

*plot coefficients for each regressor by quantiles
quietly qreg $ylist $xlist
grqreg,cons ci ols olsci

*test for heteskedasticity, very important
quietly reg $ylist $xlist 
estat hettest $xlist, iid
*it's significant! we do have heteroskedasticity, so it makes sense to use the quantile regression! 































