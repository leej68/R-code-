# Foundational R skills assignment

# Installing packages -------------------------------

# Install and load the the stringr package, which has a variety of built in functions that make working with string variables easier.
install.packages('stringr')
library(stringr)

# Defining variables -------------------------------

# Create a numeric variable myAge that is equal to your age
myAge <- 19

# Create a variable myName that is equal to your first name
myName <- "Justin"

# Using multiplication, create a variable minutes_in_a_day that is equal to the number of minutes in a day
minutes_in_a_day <- 24 * 60

# Working with functions -------------------------------

# Write a function called introduction that takes in two arguments, name, and age. This function should return a string value that says "Hello, my name is {name}, and I'm {age} years old".
introduction <- function(name, age) {
  return ("Hello, my name is {name}, and I am {age} years old")
}

# Create a variable myIntro by passing your variables myName and myAge into your introduction function
myIntro <- introduction(myName, myAge)

# Create a variable casualIntro by substituting "Hello, my name is ", with "Hey, I'm" in your myIntro variable 
casualIntro <- sub("Hello, my name is ", "Hey, I'm", myIntro)

# Create a new variable 'loud_intro', which is your myIntro variable in all upper-case letters
loud_intro <- toupper(myIntro)

# Create a new variable 'quiet_intro', which is your 'myIntro' variable in all lower-case letters
quiet_intro <- tolower(myIntro)

# Create a new variable 'capitalized', which is your 'myIntro' variable with each word capitalized (hint: use the stringr function str_to_title)
capitalized <- str_to_title(myIntro) 
 
# Using the stringr `str_count` function, create a variable `occurances` that stores the number of times the letter "e" appears in your `myIntro` variable
occurances <- str_count(myIntro, "e")
  
# Write another function `double` that takes in a variable and returns that variable times two
double <- function(number){
  return (number * 2)
}

# Create a variable `twenty` by passing the number 10 to your `double` function
twenty <- double(10)

# Write another function `third_power` that takes in a value and returns that value cubed
third_power <- function(number1) {
  return (value^3) 
}

# Create a variable `twenty_seven` by passing the number 3 to your `third_power` function
twenty_seven <- thrid_power(3)



# Vectors -------------------------------



# Create a vector movies that contains the names of six movies you like
movies <- c('UP', 'Kingsmen', 'Incredibles', 'Star Wars', 'Fast and Furious', 'Igor')

# Create a vector top_three that only contains the first three movies in the vector
top_three <- movies[1:3]

# Using your vector and the paste method, create a vector excited that adds the phrase " is a great movie!" to the end of each element in your movies vector
excited <- paste(movies, " is a great movie!")

# Create a vector without_four that has your first three movies, and your 5th and 6th movies.
without_four <- c(top_three, movies[4:5])

# Create a vector `numbers` that is the numbers 700 through 999
numbers <- c(700:999)

# Using the built in `length` function, create a variable `len` that is equal to the length of your vector `numbers`
len <- length(numbers)

# Using the `mean` function, create a variable `num_mean` that is the mean of your vector `numbers`
num_mean <- (mean(numbers))



