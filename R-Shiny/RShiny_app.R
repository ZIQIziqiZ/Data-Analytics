#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#load the dataset
data(iris)
library(data.table)
data.table::data.table(iris)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Iris Data"),
    p("This is an R-Shiny web app visualizing the 'iris' dataset. The two variables chosen from this dataset are 'Sepal.Length' and 'Sepal.Width'. Users can choose which variable to visualize and change the bin size or graph color of the histogram."),
    h4('How to use the visualization:'),
    p("- Slide to change bin size"),
    p("- Drop down to select graph color"),
    p("- Drop down to select variable to visualize (Sepal Length / Sepal Width)"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            # graph color
            selectInput("colors",
                        "Select a color:",
                        c("darkgrey","red","blue","yellow","black")),
            
            # variable to visualize
            selectInput(inputId = "variable",
                        label = "Select a variable:",
                        choices = c("Sepal Length", "Sepal Width"))
        ),

        # Show a plot of the generated distribution
        mainPanel( # Choose two variables
           plotOutput("IrisPlot"),
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
    variableInput <- reactive({
      switch (input$variable,
              "Sepal Length" = iris$Sepal.Length,
              "Sepal Width" = iris$Sepal.Width)
    })

    output$IrisPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- variableInput()
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = input$colors, border = 'white',
             xlab = input$variable,
             main = paste0('Histogram of ', input$variable))
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
