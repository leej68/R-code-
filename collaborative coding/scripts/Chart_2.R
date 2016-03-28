# Returns a stacked bar graph of the operating system (Windows or Mac) of each class standing 
# based on the data passed in 
chartTwo <- function(dataset) {
  # getting the operating system information from dataset
  info <- dataset %>%
    group_by(What.is.your.current.class.standing.) %>%
    summarise(Windows = sum(What.operating.system.do.you.typically.use. == "Windows"),
              Macs = sum(What.operating.system.do.you.typically.use. == "Mac")
    )
  
  # plotting the windows data to bar graph                  
  plot_ly(data = info,
          x = What.is.your.current.class.standing.,
          y = Windows,
          name = "Windows",
          type = "bar",
          marker = list(color = toRGB("blue"))
  ) %>%
    
    # adding in mac data
    add_trace(x = What.is.your.current.class.standing.,
              y = Macs,
              name = "Macs",
              marker = list(color = toRGB("gray"))
    ) %>%
    
    # stacking the bars in layout  
    layout(title = "Mac vs. Windows", 
           barmode = "stack",
           yaxis = list(title = "Operating System"), 
           xaxis = list(title = "Class Standing")
    )%>%
    
    # return the bar graph  
    return()
}