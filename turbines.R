library(bReeze)
## Not run:
# load example data
data("winddata", package="bReeze")
# create two datasets
set40 <- set(height=40, v.avg=winddata[,2], v.std=winddata[,5],
             dir.avg=winddata[,14])
set30 <- set(height=30, v.avg=winddata[,6], v.std=winddata[,9],
             dir.avg=winddata[,16])
# format time stamp
ts <- timestamp(timestamp=winddata[,1])
# create met mast object
metmast <- mast(timestamp=ts, set40=set40, set30=set30)
# plot time series of met mast signals
plot(metmast)
# calculate frequency and mean wind speed per wind direction sector
freq <- frequency(mast=metmast, v.set=1)
# plot frequency
plot(freq)
# calculate availability of pairs of wind speed and direction
availability(mast=metmast)
# calculate monthly means of wind speed
month.stats(mast=metmast)
# calculate turbulence intensity
turbulence(mast=metmast, turb.set=1)
# calculate weibull parameters
wb <- weibull(mast=metmast, v.set=1)
# calculate total wind energy content
energy(wb=wb)
# calculate wind profile
pf <- windprofile(mast=metmast, v.set=c(1,2), dir.set=1)
4 aep
# import power curve
pc <- pc("Enercon_E126_7.5MW.pow")
# calculate annual energy production
aep <- aep(profile=pf, pc=pc, hub.h=135)
# plot AEP
plot(aep)
## End(Not run)
aep Cal




library(WindCurves)
#https://cran.r-project.org/web/packages/WindCurves/vignettes/WindCurves_Info.html
data(pcurves)
plot(pcurves[,c('Speed','Nordex N90')])
s <- pcurves$Speed
p <- pcurves$`Nordex N90`
da <- data.frame(s,p)
x <- fitcurve(da)
#>    Weibull CDF model
#>    -----------------
#>    P = 1 - exp[-(S/C)^k]
#>    where P -> Power and S -> Speed 
#> 
#>     Shape (k) = 4.242446 
#>     Scale (C) = 9.564993 
#>    ===================================
#> 
#>    Logistic Function model
#>    -----------------------
#>    P = phi1/(1+exp((phi2-S)/phi3))
#>    where P -> Power and S -> Speed 
#> 
#>     phi 1 = 2318.242 
#>     phi 2 = 8.65861 
#>     phi 3 = 1.366053 
#>    ===================================
x
#> $Speed
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
#> [24] 24 25
#> 
#> $Power
#>  [1]    0    0    0   35  175  352  580  870 1237 1623 2012 2230 2300 2300
#> [15] 2300 2300 2300 2300 2300 2300 2300 2300 2300 2300 2300
#> 
#> $`Weibull CDF`
#>  [1]    0.0000    0.0000    0.0000   90.3871  175.0000  327.5161  563.9085
#>  [8]  882.3965 1253.7489 1623.0000 1929.1254 2134.6685 2242.6251 2285.2438
#> [15] 2297.3355 2299.6816 2299.9764 2299.9990 2300.0000 2300.0000 2300.0000
#> [22] 2300.0000 2300.0000 2300.0000 2300.0000
#> 
#> $`Logistic Function`
#>  [1]    0.00000    0.00000    0.00000   74.12813  148.99331  289.70713
#>  [7]  530.79720  884.98933 1303.20985 1686.50765 1964.36723 2133.40810
#> [13] 2225.51236 2272.70005 2296.11389 2307.54694 2313.08606 2315.75946
#> [19] 2317.04738 2317.66729 2317.96554 2318.10900 2318.17801 2318.21119
#> [25] 2318.22715
#> 
#> attr(,"row.names")
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
#> [24] 24 25
#> attr(,"class")
#> [1] "fitcurve"
validate.curve(x)
#>   Metrics Weibull CDF Logistic Function
#> 1    RMSE  30.8761687        38.8753476
#> 2     MAE  15.1381094        29.3213484
#> 3    MAPE   3.9292946         5.9183795
#> 4      R2   0.9989322         0.9983073
#> 5     COR   0.9995413         0.9991591
plot(x)
             