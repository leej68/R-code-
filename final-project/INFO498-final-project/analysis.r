# This r script contains various dataframes that can be used for data visulization. Each
# dataframe is specialized and can answer specific questions and explore specific topics. 
# The dataframes are derived from the "women-stem.csv" file that was obtained from 
# https://github.com/fivethirtyeight/data/blob/master/college-majors/women-stem.csv. 
# This r script should be loaded into the appropriate files. 

# loading the dplyr package
library(dplyr)

# reading in the main dataset and adding a column for decimal share of men
# and percentage of men and women
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