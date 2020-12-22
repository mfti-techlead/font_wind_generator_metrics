library(shiny)
shinyUI(fluidPage(
  titlePanel(title = h2('Wind turbines metrics', align = 'center')),
  sidebarLayout(position = 'left',
                sidebarPanel(h4('Author: D.S.Seledkov, MIPT'),
                             h5('Contacts: seledkov.ds@phystech.edu, +79269461824'),
                             h1('Input parameters'),
                             numericInput("lat", "Enter latitude", 54.3117),
                             numericInput("lon", "Enter longitude", 48.5847),
                             #radioButtons("gender_x", "Select gender", list("blah",'blah_blah'), ""),
                             #br(),
                             selectInput('turbine_names', 'Select turbine name', 
                                         c('Vestad V80', 'Vestad V164', 'Siemens 82', 'Siemens 107', 'Repower 82', 'Nordex N90'), 
                                         selected = 'Nordex N90', selectize = T, multiple = F),
                             #textInput("bins", "Enter bins num", 1),
                             dateInput('dt', 'Inpute date'),
                             submitButton("Calculate"),
                             p('Calculate wind and turbine characteristics')
                ),
                mainPanel(h3('Wind characteristics'),
                          #textOutput("sz"),
                          #textOutput("gender"),
                          plotOutput('myhist'),
                          plotOutput('windrose'),
                          plotOutput('windscat'),
                          tableOutput('df'),
                          h3('Turbine characteristics: ', textOutput("turbine")),
                          plotOutput('power_curve'),
                          plotOutput('power_dyn')
                )
  )
))


