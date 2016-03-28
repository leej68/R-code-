# Libraries that we will need
library(plotly)
library(dplyr)

# A function that when called and passed in a data set it will return a bar chart
chartOne <- function(dataset){
  
  # Getting the number of students within a class standing
  num_class_stand <- dataset %>%
    group_by(What.is.your.current.class.standing.) %>%
    count(What.is.your.current.class.standing.)
  
  # Labels for X and Y axis
  x <- list(title = "Class Standing of Student")
  y <- list(title = "Number of Students")
  
  # Turns the info gathered into a bar chart and saved into the variable named chart to return
  chart <- plot_ly(x = num_class_stand$What.is.your.current.class.standing.,
                   y = num_class_stand$n,
                   type = "bar",
                   marker = list(color = "purple")) %>%
                  layout(xaxis = x, 
                    yaxis = y, 
                    title = "Class Standing in Info498f",
                    margin = list(b = 90))
  
  return(chart)
}
