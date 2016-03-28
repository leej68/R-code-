# load dplyr
library(dplyr)

# read in the the data to analyze the information
data <- read.csv("https://raw.githubusercontent.com/INFO-498F/a7-survey-data/master/intro_survey_data.csv")

# this function takes in data as a parameter and returns a list of information
# about the data in in terms of class standing; data values correspond to class
# standing by index (index 1 is freshman, index 2 is sophmore, index 3 is junior
# and index 4 is senior)
summary_information <- function(data) {
    information <- data %>%
                  # rename the columns to make them easier to work with
                  rename(`Class Standing` = What.is.your.current.class.standing.,
                        `Intent to Apply` = Are.you.interested.in.applying.to.the.Informatics.major.,
                        `Operating System` = What.operating.system.do.you.typically.use.
                        ) %>%
                  # select relevant columns
                  select(`Class Standing`,
                        `Intent to Apply`,
                        `Operating System`
                         ) %>%
                  # group by class standing
                  group_by(`Class Standing`) %>%
                  # summarise the data by the number of people in of each answer for each column selected
                  summarise(`Will Apply to Informatics` = sum(`Intent to Apply` == "Yes"),
                            `Will Not Apply to Informatics` = sum(`Intent to Apply` == "No"),
                            `Intent to Apply Undecided` = sum(`Intent to Apply` == "Maybe"),
                            `Mac Users` = sum(`Operating System` == "Mac"),
                            `Windows Users` = sum(`Operating System` == "Windows"),
                            `Linux Users` = sum(`Operating System` == "Linux")
                  )
    # create vectors based on the information above by class standing 
    applying <- c(information$`Will Apply to Informatics`)
    not_applying <- c(information$`Will Not Apply to Informatics`)
    undecided <- c(information$`Intent to Apply Undecided`)
    mac_users <- c(information$`Mac Users`)
    windows_users <- c(information$`Windows Users`)  
    linux_users <- c(information$`Linux Users`)
    
    # insert the vectors into a list and return the list
    class_information <- list(Applying = applying,
                              Not_Applying = not_applying,
                              Undecided = undecided,
                              Mac_Users = mac_users,
                              Windows_Users = windows_users,
                              Linux_Users = linux_users
                             ) %>%
    return()
}