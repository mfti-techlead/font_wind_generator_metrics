library(lubridate)
library(rWind)
library(WindCurves)
library(pastecs)

#-----------------------------------------------------------#
#---- Load wind data by coordinates for series of dates ----#
#-----------------------------------------------------------#
dt <- seq(ymd_hms(paste(2020,10,1,00,00,00, sep="-")),
          ymd_hms(paste(2020,12,21,21,00,00, sep="-")),by="3 hours")
wind_data_raw <- wind.dl_2(dt,60.0,60.2,29.4,29.7)
wind_data <- tidy (wind_data_raw)

#-----------------------------------------------------------#
#----- Load wind data by coordinates for single date -------#
#-----------------------------------------------------------#
wind_data_single_date <-wind.dl(2020,2,12,0,58,59,24,25)
# data(wind.data) # example wind data

#-----------------------------------------------------------#
#---------------- Plot wind rose graph  --------------------#
#-----------------------------------------------------------#
source("plot_windrose.R")
windrose <- plot.windrose(spd = wind_data$speed,
                    dir = wind_data$dir)

#-----------------------------------------------------------#
#---------------- Get wind generators info -----------------#
#-----------------------------------------------------------#

#https://cran.r-project.org/web/packages/WindCurves/vignettes/WindCurves_Info.html
data(pcurves)
plot(pcurves[,c('Speed','Nordex N90')])
s <- pcurves$Speed
p <- pcurves$`Nordex N90`
da <- data.frame(s,p)
x <- fitcurve(da)
validate.curve(x)
plot(x)


#-----------------------------------------------------------#
#--------- Merge wind data & wind generators info ----------#
#-----------------------------------------------------------#
wind_data$speed_rnd = round(wind_data$speed,0)
kotlin = merge(wind.data, pcurves, by.x = 'speed_rnd', by.y = 'Speed')
kotlin = kotlin[order(kotlin$time),]
plot(x = kotlin$time, y = kotlin$`Nordex N90`, type = 'b', xlab = 'Период (2020 г.)',ylab = 'Мощность кВт')
stat.desc(kotlin[,8:14])




