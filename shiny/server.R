library(shiny)
library(ggplot2)

cfunc <- function(x, n, lambda) sqrt(n) * (mean(x) - 1 / lambda) * lambda

shinyServer(function(input, output) {

  output$lambda <- renderPrint({input$lambda})
  output$nosim <- renderPrint({input$nosim})
  output$noobs <- renderPrint({input$noobs})

  mat <- reactive({ matrix(rexp(input$nosim * input$noobs, input$lambda), input$nosim) })
  
  output$meanTheo <- renderPrint({ 1 / input$lambda })
  output$meanCalc <- renderPrint({ mean(apply(mat(), 1, sd)) })  
  
  output$distPlot <- renderPlot({
    
    dat <- data.frame(
      x = c(apply(mat(), 1, mean)),
      size = factor(rep(c(input$noobs), c(input$nosim))) 
    )
    
    ggplot(dat, aes(x = x, fill = size)) +
      geom_density(size = 2, alpha = .2) +
      geom_vline(xintercept = 1 / input$lambda, size = 2)
        
  })
    
  output$expPlot <- renderPlot({
    
    dat <- data.frame(
      x = c(apply(mat(), 1, cfunc, input$noobs, input$lambda)),
      size = factor(rep(c(input$noobs), c(input$nosim)))
    )
        
    g <- ggplot(dat, aes(x = x, fill = size)) +
      geom_histogram(binwidth=.3, colour = "black", aes(y = ..density..)) 
    g <- g + stat_function(fun = dnorm, size = 2)
    print(g)
    
  })
  
})
