install.packages("tidyverse")
install.packages("readr")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("janitor")
install.packages("skimr")
install.packages("here")

library(tidyverse)
library(readr)
library(ggplot2)
library(dplyr)
library(janitor)
library(skimr)
library(here)
train <- read_csv("C:/Users/Sierr/Desktop/My Own Projects/My-Own-Projects/Project/Titanic/Dataset/train.csv")

head(train)

skim_without_charts(train)

keep_columns = c("PassengerId", "Survived", "Pclass", "Age", "Sex")

cleaned_train <- train[keep_columns]

skim_without_charts(cleaned_train)

cleaned_train %>% 
  drop_na()

ggplot(data = cleaned_train, aes(x = Sex,fill = Sex))+ 
  geom_bar() + 
  labs("text", title = "Total Count of Each Gender") +
  geom_text(aes(label = ..count..), stat = "count", vjust = 5.5, color = "white") +
  theme_classic()


