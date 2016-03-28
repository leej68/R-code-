# ui.R is used for the user interface of the shiny app. Used with server.R

# library the plotly and shiny packages
library(plotly)
library(shiny)


shinyUI(navbarPage("Women in STEM Majors",
                   
                   # this tab contains information on the relative porportions
                   # between the major fields and the framing of the project
                   tabPanel("Types of Majors",
                            sidebarLayout(
                              sidebarPanel(
                                "Welcome to our project! We are focusing on recent
                                women graduates who pursued a STEM major in college.
                                We will demonstrate the social dynamic that female
                                students are engaged in depending on their majors. Also,
                                we wanted to show the major details of all STEM majors
                                that women can pursue and how these majors compare to
                                each other. This is important for all female STEM prospects
                                as it gives them insight on their future field (and thus life!).
                                This data came from FiveThirtyEight's public GitHub repository.
                                They extracted the data from the American Community Survey, which  
                                is facilitated by United States Census Bureau."
                              ),
                              mainPanel(
                                plotlyOutput("field")
                              )
                            )
                   ),
                   
                   # this tabs shows all majors with percent/pay data
                   tabPanel("Percentage/Pay of Majors",
                            mainPanel(
                              plotlyOutput("correlation")
                            )
                            
                   ),
                   
                   # this tab contains an overview with percentages
                   tabPanel("Male-Female Ratios",
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons("major", "Choose Type of Major",
                                             c("Biology & Life Science" = "biology",
                                               "Computers & Mathematics" = "computer", 
                                               "Engineering" = "engineering",
                                               "Health" = "health",
                                               "Physical Sciences" = "physical"
                                             ),
                                             selected = "Engineering"
                                )
                              ),
                              mainPanel(
                                plotlyOutput("percentage")
                              )
                            )
                   ),
                   
                   # this tab contains information on the top paying majors for women
                   # in STEM fields
                   tabPanel("Top Median Pay",
                              mainPanel(
                                plotlyOutput("dot")
                              )
                   )
                   
))