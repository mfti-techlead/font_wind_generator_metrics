library(shiny)
library(lubridate)
library(rWind)
library(WindCurves)
library(pastecs)


shinyServer(
  function(input, output) {
    
    wind_data <- reactive({
      tidy(wind.dl_2(seq(ymd_hms(paste(2020,12,21,00,00,00, sep="-")),
                         ymd_hms(paste(2020,12,21,21,00,00, sep="-")),by="3 hours"),
                     input$lat,input$lat,input$lon,input$lon))
    })
    
    turbine_model <- reactive({
      input$turbine_names
    })
    
    colm <- reactive({
      as.numeric(input$bins)
    })
    #output$name <- renderText(input$my_name)
    output$dtt <- renderText(input$dt)
    #output$sz <- renderText(input$size)
    #output$gender <- renderText(input$gender_x)
    output$turbine <- renderText(input$turbine_names)
    output$df <- renderTable({
      wind_data()
    })
    output$myhist <- renderPlot({
      hist(x = wind_data()[,'speed'], main = 'Histogram of wind speed', xlab = 'Wind speed, m/sec')
      #hist(x = iris[,2])
      
    })
    output$windrose <- renderPlot({
      source("plot_windrose.R")
      plot.windrose(spd = wind_data()[,'speed'],
                                dir = wind_data()[,'dir'])
    })
    output$windscat <- renderPlot({
      plot(wind_data()[,'time'], wind_data()[,'speed'], xlab="Date, time", ylab="Wind speed m/s", pch=19)
    })
    output$power_curve <- renderPlot({
      data(pcurves)
      #plot(pcurves[,c('Speed','Nordex N90')])
      s <- pcurves$Speed
      p <- pcurves[,turbine_model()]
      da <- data.frame(s,p)
      x <- fitcurve(da)
      validate.curve(x)
      plot(x)
    })
    
    output$power_dyn <- renderPlot({
      data(pcurves)
      wind_data_p = wind_data()
      wind_data_p$speed_rnd = round(wind_data_p$speed,0)
      kotlin = merge(wind_data_p, pcurves, by.x = 'speed_rnd', by.y = 'Speed')
      kotlin = kotlin[order(kotlin$time),]
      plot(x = kotlin$time, y = kotlin[,turbine_model()], type = 'b', xlab = 'Period',ylab = 'Power, KWt')
      
    })
      
    
  }
)