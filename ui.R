# ui.R

library(rCharts)
shinyUI(fluidPage(

   titlePanel("Analysis tool for 'mtcars' data"),
   
   tabsetPanel(
   
      tabPanel("Exploratory",
         sidebarLayout(
            sidebarPanel(
               helpText("Simple x-y plot for data exploration:"),
               
               selectInput("x",
                  label= "X-axis:",
                  choices = c("mpg", "cyl","hp","drat","wt","qsec","vs","am","gear","carb"),
                  selected = "wt"
               ),
               
               selectInput("y",
                  label= "Y-axis:",
                  choices = c("mpg", "cyl","hp","drat","wt","qsec","vs","am","gear","carb"),
                  selected = "mpg"
               ),
               
               selectInput("group",
                  label= "Group by:",
                  choices = list("mpg", "cyl","hp","drat","wt","qsec","vs","am","gear","carb"),
                  selected = "cyl"
               ),
               
               selectInput("size",
                  label= "Size by:",
                  choices = list("mpg", "cyl","hp","drat","wt","qsec","vs","am","gear","carb"),
                  selected = "gear"
               )
               
            ),
            
            mainPanel(
               showOutput("exploratory", "nvd3") # using NVD3 library in rCharts
            )
         )
      ),
      
      tabPanel("Simulate MPG",
         sidebarLayout(
            sidebarPanel(
               helpText("Configure your car to estimate mpg:"),
               radioButtons("cyl", label="Engine: # of cylinders:", 
                            choices = list(4,6,8), selected=4),
               sliderInput("wt", label="Weight (1000s of lb):", min=1.5, max=5.5, value=3.2),
               radioButtons("am", label="Transmission Type:", 
                            choices = list("Automatic"=0, "Manual"=1), selected=1),
               sliderInput("hp", label="Gross horsepower:", min=50, max=350, value=150)
               
            ),
         
            mainPanel(
               h3("Model"),
               "This multivariable linear regression model uses 4 variables (cyl, wt, am, and hp) to predict mpg.",
               h3("Result"),
               textOutput("result"),
               h3("Details"),
               textOutput("intercept"),
               textOutput("cyl"),
               showOutput("cylChart", "polycharts"), # using polycharts library in rCharts
               textOutput("wt"),
               textOutput("am"),
               showOutput("amChart", "polycharts"), # using polycharts library in rCharts
               textOutput("hp")
            )
         )
      ),
      
      tabPanel("Raw Data",
         sidebarPanel(
            downloadButton('downloadData', 'Download')
         ),
         mainPanel(
            dataTableOutput(outputId="table")
         )    
      ),
      
      tabPanel("About the data",
         
            h2("About the Motor Trend Car Road Tests data"),
            includeHTML("mtcars.html")
      )
      
   )
   
))