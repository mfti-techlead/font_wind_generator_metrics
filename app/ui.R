library(shiny)
shinyUI(fluidPage(
  titlePanel(title = h1('Turbines metrics', align = 'center')),
  sidebarLayout(position = 'left',
                sidebarPanel(h4('Parameters section'), h1('Input parameters'),
                             textInput("my_name", "Enter something", ""),
                             textInput("size", "Enter size", "huge"),
                             radioButtons("gender_x", "Select gender", list("blah",'blah_blah'), ""),
                             #br(),
                             selectInput('statenames', 'Select state name', c('NY','CF','KG'), selected = 'KG', selectize = T, multiple = T),
                             textInput("bins", "Enter bins num", 1)
                ),
                mainPanel(('Test_text'),
                          textOutput("sz"),
                          textOutput("gender"),
                          textOutput("state"),
                          plotOutput('myhist'),
                          tableOutput('df')
                

                )
  )
))


