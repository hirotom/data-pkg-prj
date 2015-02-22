# server.R

library(shiny)
library(rCharts)

data(mtcars) # load the built-in 'mtcars' data set

fit <- lm(mpg ~ as.factor(cyl) + wt +hp+ as.factor(am), data=mtcars)

shinyServer(
   function(input, output) {
   
      # Exploratory tab
      output$exploratory <- renderChart({

         p1 <- nPlot(x=input$x, y=input$y, group=input$group, data=mtcars, type="scatterChart", dom="exploratory")
         strSize<-paste0("#! function(d){return d.", input$size, "} !#")
         p1$chart(size = strSize)
         p1$xAxis(axisLabel=input$x)
         p1$yAxis(axisLabel=input$y)
         return(p1)
         
      })
      
      # Simulate MPG tab
      output$result <- renderText({
         sim_in <- data.frame(cyl=input$cyl, wt=input$wt, hp=input$hp, am=input$am)
         sim_out <- predict(fit, sim_in)
         paste0("The expected fuel economy is ", round(sim_out,2), " mpg.")
      })
      
      output$intercept <- renderText({
         paste0("1) Baseline fuel economy is ", round(fit$coefficients[1],2), " mpg.")
      })
      
      output$cyl <- renderText({
         paste0("2) Incremental fuel economy change for 6 and 8 clyinder engines:")
      })
      
      output$cylChart <- renderChart({
         p2_data <- data.frame(x=c(6,8), 
                                y=c(fit$coefficients[2], fit$coefficients[3]))
         p2 <- nPlot(x="x", y="y", data=p2_data, type="discreteBarChart", dom="cylChart", height=200, width=300)
         p2$xAxis(axisLabel="# of Cylinders")
         p2$yAxis(axisLabel="change in mpg")
         if (input$cyl==4) {
            p2$chart(color=c("gray","gray"))
         }
         else if (input$cyl==6) {
            p2$chart(color=c("orange","gray"))
         }
         else if (input$cyl==8) {
            p2$chart(color=c("gray","orange"))
         }
         return(p2)
      })
      
      output$wt <- renderText({
         paste0("3) Incremental fuel economy change for weight (in 1000s of lbs) is ", 
                round(fit$coefficient[4],2),
                " mpg/wt (in 1000s of lb).  ",
                "Total change is ", round(fit$coefficient[4]*input$wt,2), " mpg.")
      })

      output$am <- renderText({
         paste0("4) Incremental fuel economy change for automatic transmission:")
      })
      
      output$amChart <- renderChart({
         p4_data <- data.frame(x=c("Automatic", "Manual"), y=c(0, fit$coefficients[6]))
         p4 <- nPlot(x="x", y="y", data=p4_data, type="discreteBarChart", dom="amChart", height=200, width=300)
         p4$xAxis(axisLabel="Transmission Type")
         p4$yAxis(axisLabel="change in mpg")
         if (input$am==1) {
            p4$chart(color=c("gray", "orange"))
         }
         else  {
            p4$chart(color=c("orange", "gray"))
         }
         return(p4)
      })
      
      output$hp <- renderText({
         paste0("5) Incremental fuel economy change for horsepower is ", 
                round(fit$coefficient[5],2),
                " mpg/hp.  ",
                "Total change is ", round(fit$coefficient[5]*input$hp,2), " mpg.")
      })
      
      # Raw Data tab
      output$table <- renderDataTable({
         out_df <- cbind(rownames(mtcars), mtcars)
         colnames(out_df)[1] <- "car"
         out_df
      })

      output$downloadData <- downloadHandler(
         filename = 'mtcars.csv',
         content = function(file) {
            write.csv(mtcars, file, row.names=TRUE)
         }
      )
   
   }
)