library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Exponential distribution simulation"),
  p("This is a simple simulator for displaying inner workings of exponential distribution."),
  div("All data used in simulator are generated according to the parameters selected on the left side."),
  div("These parameters are lambda, number of simulations to perform and number of observations per each simulation."),
  br(),
  div("First plot displayed is of distribution of generated values with expected mean value."),
  div("Second plot displays that the means of simulation takes a shape of normalized distribution around theoretical mean (1 / lambda)."),
  br(),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda",
                  "Value of lambda:",
                  min = 0.01,
                  max = 20,
                  value = 0.5,
                  step = 0.01),
      sliderInput("nosim",
                  "Number of simulations:",
                  min = 1000,
                  max = 100000,
                  value = 10000,
                  step = 1000),
      sliderInput("noobs",
                  "Number of observations per simulation:",
                  min = 10,
                  max = 1000,
                  value = 40,
                  step = 1)  
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h4('Entered lambda:'),
      verbatimTextOutput("lambda"),
      h4('Entered number of simulations:'),
      verbatimTextOutput("nosim"),
      h4('Entered number of observations per simulation:'),
      verbatimTextOutput("noobs"),
      
      h4('Theoretical mean:'),
      verbatimTextOutput("meanTheo"),
      h4('Calculated mean:'),
      verbatimTextOutput("meanCalc"),
      
      h4('Showing where the distribution is centered at and comparing it to the theoretical center of the distribution.'),
      plotOutput("distPlot"),
      h4('Showing that the distribution is approximately normal.'),
      plotOutput("expPlot")
    )
  )
))
