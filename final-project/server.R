# server.R is used to create outputs for the ui.R file.

# library the dplyr, plotly, and shiny packages
library(dplyr)
library(plotly)
library(shiny)

# the analysis.R was originally loaded into this file but is now copied in
# in order to facilitate publishing (there were errors from loading when 
# publishing)
women_stem <- read.csv("women-stem.csv") %>%
  mutate(ShareMen = (Men / Total),
         Men_Percentage = ShareMen * 100.00,
         Women_Percentage = ShareWomen * 100.00
  )

# This dataframe groups the data by major catagories (Biology & Life Science,
# Computer & Mathematics, Engineering, Health, and Physical Sciences). The dataframe
# contains the sum of men and women in each catagory as well as the average percentage
# of women and median pay of women in each catagory
major_catagory <- women_stem %>%
  group_by(Major_category) %>%
  summarise(Total = sum(Total),
            Men = sum(Men),
            Women = sum(Women),
            ShareWomen = mean(ShareWomen),
            MenShare = mean(ShareMen),
            Women_Percentage = mean(Women_Percentage),
            Men_Percentage = mean(Men_Percentage),
            Median_Pay = mean(Median)
  ) 

# This dataframe contains the top ten majors with the highest percentage
# of women. The data lists the ten majors from highest to lowest in terms of 
# percentage.
top_ten_percentage <- women_stem %>%
  top_n(10, ShareWomen) %>%
  arrange(desc(ShareWomen))

# This dataframe contains the lowest ten majors in terms of percentage of women
# with the major. The data lists these ten in ascending order. 
lowest_ten_percentage <- women_stem %>%
  top_n(10, desc(ShareWomen)) %>%
  arrange(ShareWomen) 

# This dataframe contains the highest ten median pay for majors. The majors
# are arranged in descending order by median pay. Note: There are thirteen 
# majors due to ties.
top_ten_pay <- women_stem %>%
  top_n(10, Median) %>%
  arrange(desc(Median))

# This dataframe contains the lowest ten median pay for majors. The majors 
# are arranged in ascending order by median pay. Note: There are sixteen
# majors due to ties. 
lowest_ten_pay <- women_stem %>%
  top_n(10, desc(Median)) %>%
  arrange(Median)

# These dataframes are used for the overview. They are specific categories
# of data for the majors.
biology <- filter(major_catagory, Major_category == "Biology & Life Science")
computer <- filter(major_catagory, Major_category == "Computers & Mathematics")
engineering <- filter(major_catagory, Major_category == "Engineering")
health <- filter(major_catagory, Major_category == "Health")
physical <- filter(major_catagory, Major_category == "Physical Sciences")


shinyServer(function(input, output) {
  
  # outputs a bar graph of the percentages of men and women in
  # the category of majors selected from the user
  output$percentage <- renderPlotly({
    
    # the intial bar graph with percentage of men
    plot_ly(eval(parse(text = input$major)), 
            x = "Percentage of Men", 
            y = Men_Percentage,
            type = "bar",
            name = "Men"
    ) %>%
      
      # adding in bar for women
      add_trace(x = "Percentage of Women",
                y = Women_Percentage,
                name = "Women",
                marker = list(color = toRGB("pink"))
      ) %>%
      
      # overall layout with scale of percentage from 0 to 100 with ticks 
      # every 10%
      layout(title = "Percentage of Men and Women in STEM Majors",
             xaxis = list(title = "Gender"),
             yaxis = list(title = "Percentage in Major (%)", range = c(0, 100), dtick = 10)
      ) %>%
      
      # return the bar plot to be used as output in ui
      return()
  })
  
  # outputs a scatterplot of median pay and percentage of 
  # women for all majors
  output$correlation <- renderPlotly({
    
    # creating the scatterplot
    plot_ly(data = women_stem,
            x = Women_Percentage,
            y = Median,
            text = Major,
            size = Median,
            color = Major_category,
            mode = "markers") %>%
  
   # constructing the overall layout to be large enough    
   layout(title = "Percentage of Women and Median Pay in Field",
          xaxis = list(title = "Percentage of Women in Major  (%)"),
          yaxis = list(title = "Median Pay of Women in Field ($) "),
          width = 1250,
          height = 550
   ) %>%
    
    # return the scatter plot to be used as output in ui    
    return()
  })
  
  # outputs a donut graph of the number of women in each
  # major field
  output$field <- renderPlotly({
    
    # creating the pie graph with a hole
    plot_ly(major_catagory,
            labels = Major_category, 
            values = Women, 
            type = "pie",
            hole = 0.25
    ) %>% 
      
    # setting the layout with proper margins
    layout(title = "Percentage of Women in Different Types of Majors",
           width = 750,
           height = 600,
           margin = list(t = 100)
      ) %>%
      
      # returns the donut grpah to be used as output in ui
      return() 
  })
  
  # Outputs a dot graph of the median pay for women in the
  # top ten higest paid degrees.
  output$dot <- renderPlotly({
    
    # creating the dot graph
    plot_ly(top_ten_pay, 
           x = Median, 
           y = Major, 
           name = "Women",
           mode = "markers",
           marker = list(color = toRGB("purple"))) %>%
      
    # setting the correct margins, range of graph from 0 to 120,000 with 10,000 step
    # and title the graph.
    layout(title = "Majors with Highest Median Pay",
           height = 600,
           width = 1000,
           margin = list(l = 350, 
                         b = 100),
           xaxis = list(range = c(0, 120000), dtick = 10000)) %>%
    
    # returns the dot graph to be used as an output in ui
    return()
  })
  
})