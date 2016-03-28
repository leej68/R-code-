library(dplyr)
library(plotly)
library(shiny)

# Define UI for an application that has a title
shinyUI(

  # Specify a fluidPage layout
  fluidPage(
  
  #title of the graph
  titlePanel("Types of Iris"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      # allows user to choose the length of a sepal or petal
      radioButtons("length_property", label = h1("Length types"),
                   choices = list("Sepal Length" = 'sepal_length', "Petal Length" = "petal_length"),
                   selected = "sepal_length"),
      
      #allows user to choose width of sepal or petal
      radioButtons("width_property", label = h1("Width"),
                   choices = list("Sepal Width" = "sepal_width", "Petal Width" = "petal_width")), 
      
      # allows user to color of length bar graph
      selectInput("color", label = h3("Choose Length Color"), 
                  choices = list("Black" = 'black', "Maroon" = 'Maroon', "Yellow" = 'yellow', "Purple" = 'purple'), 
                  selected = "black"),
      
      #allows user to choose color of width bar graph
      selectInput("color2", label = h3("Choose Width Color"), 
                  choices = list("Blue" = 'blue', "Green" = 'green', "Red" = 'red'), 
                  selected = "blue")
    ),
    
    # plots the bar graph 
    mainPanel(
      plotlyOutput("Bars")
      
    )
    
  )
))