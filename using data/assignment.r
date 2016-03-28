# Using data assignment

# data.frame elements -------------------------------

# Create a vector `names` with 5 names in it
names <- c("Jojo", "Allyson", "Michael", "Justin", "Tej")

# Create a vector `math_grades` with 5 hypothetical grades (0 - 100) in a math course (that correspond to the 5 names above)
math_grades <- c(90, 50, 80, 100, 60)

# Create a vector `spanish_grades` with 5 hypothetical grades (0 - 100) in a spanish course (that correspond to the 5 names above)
spanish_grades <- c(90, 10, 5, 100, 50)

# Combine your vectors `names`, `math_grades`, and `spanish_grades` into a data.frame called `students`
students <- data.frame(names, math_grades, spanish_grades)

# Create a variable `num_rows` that contains the number of rows in your data.frame `students`
num_rows <- nrow(students)

# Create a variable `num_columns` that contains the number of columns in your data.frame `students`
num_columns <- ncol(students)

# Using `cbind`, create a new data.frame called `grades` that includes the `students` dataframe, and a new colum `grade_diff`
# grade_diff should be the `students$math_grades` column minus the `students$spanish_grades` column in the data.frame
grade_diff <- students$math_grades-students$spanish_grades
grades <- cbind.data.frame(students, grade_diff)

# Rename the last column of `grades`to `grade_diff`


# Assign a new variable `grades$better_at_math` as a boolean (TRUE/FALSE) variable if a student got a better grade in Math
grades$better_at_math <- math_grades > spanish_grades

# Create a variable `num_better_at_math` that is the number (i.e., one numeric value) of students better at math
num_better_at_math <- length(grades$better_at_math[grades$better_at_math == TRUE])


# Write your `grades` data.frame to a new .csv file inside your `data/` directory with the filename `grades.csv`.  
# Make sure you're in the proper directory to write this (and later) files
setwd("C:/Users/justinlee/Documents/Info 498/a3-using-data") 
write.csv(grades, 'grades.csv')


# Loading R data -------------------------------


# Load the USArrests dataset
data(USArrests)

# Create a variables `most_murders` that has the name of state with the highest number of murders per 100K people
USArrests$states <- row.names(USArrests)
most_murders <- USArrests$states[USArrests$Murder == max(USArrests$Murder)]

# Create a varaible `least_assaults` that has the name of the state with the lowest number of assaults per 100K people
least_murders <- USArrests$states[USArrests$Murder == min(USArrests$Murder)]


# Create a new column USArrests$ten_times_more as a boolean vector where there are 10X more assault arrests than murder arrests
USArrests$ten_times_more <-(USArrests$Assault/USArrests$Murder > 10)

# Create a variable `high_murders` that has the state names in which there are NOT 10X more assault arrests than murder arrests
high_murders <- USArrests$states[USArrests$ten_times_more == FALSE]

# Write a function `state_info` that returns a sentence describing the state's murder and assault rates

state_info <- function(state) {
  murder <- USArrests$Murder[USArrests$states == state]
  assault <- USArrests$Assault[USArrests$states == state]
  return(paste(state, "murder rate is", murder, "and the assult rate is", assault))
}

# Using your `state_info` variable, create a variable `colorado_info` that has the state's murder and assault rates
colorado_info <- state_info("Colorado")

# Write the `USArrests` data.frame to a new .csv file in your `data/` directory with the filename `USArrests.csv`
write.csv(USArrests, "data/USArrests.csv")

# Reading in data -------------------------------

# Read the life_expectancy.csv file into a variable called `life_expectancy`
life_expectancy <- read.csv('data/life_expectancy.csv')

# Determine if `life_expectancy` is a data.frame by using the is.data.frame function
is.data.frame(life_expectancy)

# Create a column `life_expectancy$change` that is the change in life expectancy from 1960 to 2013
life_expectancy$change <- (life_expectancy$le_2013-life_expectancy$le_1960)

# Create a variable `most_improved` that is the name of the country with the largest gain in life expectancy
# Note, because you're working with a factor variable, it would be best to convert it to a character variable
countries <- as.vector(life_expectancy$country)
most_improved <- countries[life_expectancy$change == max(life_expectancy$change)]

# Create a vector `num_under_5` that has the number of countries whose life expectance has improved fewer than 5 years
num_under_5 <- c(length(countries[life_expectancy$change < 5]))

# Write a function `country_change` that takes in a country as a parameter, and returns 
# it's change in life expectancy from 1960 to 2013
country_change <- function(country) {
  expectancy <- life_expectancy$change[countries == country]
  return(expectancy)
}

# Using your `country_change` funciton, create a variable `sweden_change` that is 
# the change in life expectancy from 1960 to 2013 in Sweden
sweden_change <- country_change("Sweden")

# Write a function `highest_life_exp_in_region` that takes in a region as a parameter, and returns
# the name of the country with the highest 2013 life expectancy 

highest_life_exp_in_region <- function(region) {
  high <- max(life_expectancy$le_2013[life_expectancy$region == region])
  place <- countries[life_expectancy$le_2013 == high]
  return(place)
}

# Create a variable `highest_in_south_asia` that is the country with the highest life expectancy in South Asia
highest_in_south_asia <- highest_life_exp_in_region("South Asia")

# Write a function `bigger_change` that takes in two country names as parameters, and returns
# A sentence that says which country is larger, and by how many years. 
# (make sure to round the value to 2 decimal places)
bigger_change <- function(country1, country2) {
  country1_number <- life_expectancy$change[countries == country1]
  country2_number <- life_expectancy$change[countries == country2]
  years <- abs(country1_number-country2_number)
  if(country1_number > country2_number) {
      return(paste(country1, "is bigger than", country2, "by", round(years, digits = 2), "years"))
  } else {
      return(paste(country2, "is bigger than", country1, "by", round(years, digits = 2), "years"))
  }
}

# Using your `bigger_change` funciton, create a variable `usa_or_france` that indicates 
# who had a larger life expectancy (the United States or France)
usa_or_france <- bigger_change("United States", "France")

# Write your `life_expectancy` data.frame to a new .csv file to your `data/` 
# directory with the filename `life_expectancy_with_change.csv`
write.csv(life_expectancy, "data/life_expectancy_with_change.csv")

