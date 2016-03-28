# library the dplyr, plotly, and shiny packages
library(dplyr)
library(plotly)
library(shiny)

# load iris dataset
data(iris)

# grouping data by max length and width for sepal and length
type_of <- group_by(iris, Species) %>%
  summarise(`sepal_length` = max(Sepal.Length),
            `sepal_width` = max(Sepal.Width),
            `petal_length` = max(Petal.Length),
            `petal_width` = max(Petal.Width)
  )

shinyServer(function(input, output) {
  
  # reutrns a bar graph depending on the input that is chosen
  output$Bars <- renderPlotly({
    
    # creates the bar graph of length properties
    plot_ly(type_of,
            x = Species,
            y = eval(parse(text = input$length_property)),
            type = "bar",
            name = "length",
            marker = list(color = toRGB(input$color))
    ) %>%
    #creates a bar graph of width
    add_trace(
      x = Species,
      y = eval(parse(text = input$width_property)),
      name = "width",
      type = "bar",
      marker = list(color = toRGB(input$color2))
    ) %>%
      
      # names the title and yaxis
      layout(title = "Length and Width by species",
             yaxis = list(title = "Properties")
      ) %>%
      
      # returns the created bar graph                
      return()
  })
  
  
  
})