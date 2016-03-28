# final-project

**[Final Shiny Application Link](https://kennyle.shinyapps.io/Women_STEM/)**

This project will focus on women in STEM fields and their undergraduate majors. The data is 
extracted from FiveThirtyEight's public data repository on GitHub, found at the link below. 

[Data Here](https://github.com/fivethirtyeight/data/blob/master/college-majors/women-stem.csv)

The project will utilize a Shiny application to display various datasets and visualizations. The
analysis.R file performs all the necessary data wrangling for the project, although further data wrangling 
can be perfomed in the server.R file or any other file. The analysis.R script should be loaded in order to obtain usable dataframes. 

This project is meant to demonstrate to students, specifically female students who are interested in a STEM major and a STEM career, the social dynamics and general career outlooks of many STEM majors and their respective careers. Thus, students will have a clearer understanding how STEM majors compare to each other.

**NOTE: The analysis.R file will no longer be read in as a script but instead included as code in the
server.R file as loading r scripts causes issue with shiny publication. Otherwise, the analysis code is the same.**