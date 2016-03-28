#sets the working directory to be in my output/ directory with
#the file name outputs
setwd("C:/Users/justinlee/Documents/a4-data-wrangling")

# creates a new directory called outputs in a4-data-wrangling folder
dir.create("C:/Users/justinlee/Documents/a4-data-wrangling/output/")

# Install and load the the dplyr package
#install.packages('dplyr')
require(dplyr)

#read csv files
drinking <- data.frame(read.csv("data/any_drinking.csv"))
binge <- data.frame(read.csv("data/binge_drinking.csv"))

#create a data frame selecting specific parts
area_df <- select(drinking, state, location, ends_with("2012"))

#mutate data frame 
area_df <- mutate(area_df, difference = males_2012-females_2012)

#Q. Are there any locations where females drink more than males?
#A. there is no data in the data frame so there are no locations in which females drink more than males
state <- filter(area_df, difference < 0)


#Q. What is the location in which male and female drinking patterns are most similar?
#A. the smallest difference is in Wisconsin, Oneida County
most_similar <- filter(area_df, difference == min(difference))

#Q. What is the location in which the difference in drinking patterns is greatest?
#A. the greatest difference is in Texas Loving County
greatest <- filter(area_df, difference == max(difference))

#For our reference, write the 2012 data.frame variable you're working with to a .csv file in your output/ directory
write.csv(area_df, "output/area_df.csv")

#creates a data.frame with state level of observations
state_observation_2012 <- filter(area_df, state == as.character(location))


#Q. Which state had the highest drinking rate for both sexes combined?
#A. Vermont
highest_rate <- filter(state_observation_2012, both_sexes_2012 == max(both_sexes_2012))

#Q.State with the lowest drinking rate for both sexes combined
#A. Utah
lowest_rate <- filter(state_observation_2012, both_sexes_2012 == min(both_sexes_2012))

#Q. What was the difference in percentage of drinking between the hightest and lowest consumption states?
#A. 40.2
High_low_percentage_rate <- highest_rate$both_sexes_2012 - lowest_rate$both_sexes_2012

# Write 2012 state data to an appropriately named file in your output/ directory
write.csv(state_observation_2012, "output/state_observation_2012.csv")

#Repeated tasks for Any Drinking data

#Write a function that takes a state as a parameter, and saves a .csv file with only observations from that state
state_observations <- function(name_state) {
  info_state <- paste("output/info_", name_state, ".csv") 
  drinking %>% 
    filter(state == name_state) %>%
    write.csv(info_state)
}

#test the function
state_observations("Oregon")
state_observations("California")
state_observations("Washington")

#Write a function that allows you to specify a year of interest, then saves a .csv file with all observations, but only 
#the columns state, location, and data from the specified year
year_of_interest <- function(year) {
  info_year <- paste("output/", year, ".csv") 
  drinking %>% 
    select(state, location, ends_with(year)) %>%
  write.csv(info_year)
}

#test the function
year_of_interest("2002")
year_of_interest("2008")
year_of_interest("2010")

#bonus
filter(drinking, as.character(location) == as.character(state)) %>% write.csv("output/50_states_drinking.csv")

# Write a function that allows you to specify a year and state of interest, that saves a csv file with observations from that state's 
#counties, and only the columns state, location, and data from the specified year.


year_state_interest <- function(the_state, the_year) {
  observations <- paste("output/", the_state, "_", the_year, ".csv")
  select(drinking, state, location, contains(the_year)) %>%
    filter(state == the_state) %>%
    arrange_(paste("desc(both_sexes_", the_year, ")", sep = "")) %>%
    write.csv(observations)
}
#test the function
year_state_interest("New York", "2004")
year_state_interest("Washington", "2005")
year_state_interest("California", "2010")

#Exploring Binge Drinking Dataset
#--------------------------------

#Create a dataframe with only the county level observations from the binge_driking dataset (i.e., exclude state/national estimates)
#Create columns with the change in binge drinking from 2002 - 2012 for males and females 
county_level <- filter(binge, as.character(location) != state, state != "National") %>% 
  mutate(men_diff_2012_2002 = males_2012-males_2002, female_diff_2012_2002 = females_2012-females_2002)

#Q. What is the average county level of binge drinking in 2012 for both sexes?
#A. 17.962
mean <- mean(county_level$both_sexes_2012)

#Q. What is the minimum county level of binge drinking in each state (in 2012 for both sexes)? Write your answers to a .csv file
#A.data.frame is csv file
min_county <- group_by(binge, state) %>%
  summarise(minimum = min(both_sexes_2012), na.rm = TRUE)
write.csv(min_county, "output/min_county.csv")

#Q. What is the maximum county level of binge drinking in each state (in 2012 for both sexes)? Write your answers to a .csv file
#A. data.frame is csv file
max_county <-  group_by(binge, state) %>%
  summarise(max = max(both_sexes_2012), na.rm = TRUE)
write.csv(max_county, "output/max_county.csv")
  
#Q. What is the county with the largest increase in male binge drinking between 2002 and 2012?
#A. Texas Loving Country 
increase <- filter(county_level, men_diff_2012_2002 == max(county_level$men_diff_2012_2002))

#Q. How many counties observed an increase in male binge drinking in this time period?
#A. 1993
m_hours <- filter(county_level, men_diff_2012_2002 > 0) %>% nrow()

#Q. How many counties observed an increase in female binge drinking in this time period?
#A. 2581
f_hours <- filter(county_level, female_diff_2012_2002 > 0) %>% nrow()

#Q. How many counties experience a rise in female binge drinking and a decline in male binge drinking?
#A. 786
increase_decrease <- county_level %>% 
  filter(men_diff_2012_2002 < 0, female_diff_2012_2002 > 0) %>% nrow()

#Joining Data

# Before joining your datasets, you'll need to rename their columns that store your data. In each 
#dataset, add a prefix (either any_ or binge_) to the columns that store the drinking rates
colnames(binge)[3:35] <- paste("any_", colnames(binge[,c(3:35)]))

#Join your any_drinking and binge_drinking dataframes together.
#Create a column of difference between any and binge for both sexes 2012
Joined <- left_join(drinking, binge, by = c("state", "location"))
Joined <- mutate(Joined, difference_any_binge = both_sexes_2012 - any_both_sexes_2012)

#Q.Which location has the greatest difference between any and binge drinking?
#A.Falls Church City
greater_than_great <- filter(Joined, difference_any_binge == max(difference_any_binge))

#Q. Which location has the smallest difference between any and binge drinking?
#A. Buffalo county, South Dokota
smaller_than_small <- filter(Joined, difference_any_binge == min(difference_any_binge))


#Ask your own question 
#how many states are there with the same county name
highest_lowest <- function(county) {
  stuff <- filter(drinking, location == county) %>% 
    select(state)%>%nrow()
  return(stuff)
}

highest_lowest("York County")






















