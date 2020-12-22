library(shiny)
shinyServer(
  function(input, output) {
    colm <- reactive({
      as.numeric(input$bins)
    })
    output$name <- renderText(input$my_name)
    output$sz <- renderText(input$size)
    output$gender <- renderText(input$gender_x)
    output$state <- renderText(input$statenames)
    output$df <- renderTable({
      head(iris)
    })
    output$myhist <- renderPlot({
      hist(x = iris[,colm()])
      #hist(x = iris[,2])
      
    })
  }
)