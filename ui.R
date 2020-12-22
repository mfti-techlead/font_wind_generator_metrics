library(shiny)
shinyUI(fluidPage(
  titlePanel(title = h1('Анализ метрик ветрогенераторов', align = 'center')),
  sidebarLayout(position = 'left',
    sidebarPanel(h4('huek'), h1('input data'),
                 textInput("my_name", "Enter fuck", ""),
                 textInput("hui_size", "Enter hui size", "huge"),
                 radioButtons("gender_x", "Select gender", list("blah",'blah_blah'), ""),
                 #br(),
                 selectInput('statenames', 'Select state name', c('NY','CF','KG'), selected = 'KG', selectize = T, multiple = T),
                 textInput("bins", "Enter bins num", 1)
    ),
    mainPanel(('pesda'),
              tabsetPanel(type = 'tab',
                          tabPanel("Summary",               textOutput("name"),
                                   textOutput("hui"),
                                   textOutput("gender"),
                                   textOutput("state"),
                                   plotOutput('myhist')),
                          tabPanel("Histogram", plotOutput('myhist')),
                          tabPanel("Table", 'epta!!!', textOutput("gender"))
              )
    )
)
))


