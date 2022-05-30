#install and load packages.

install.packages("tydiverse")

library(tidyverse)
library(readr)
library(dplyr)
library(skimr)

#load raw data and filter only relevant data.

read_csv("raw_data/matches.csv") 
cfc <- dplyr::filter(matches, home == "Chicago Fire FC")

cfc.h=filter(cfc, attendance!="") %>% 
  group_by(home, away) %>%
  summarize(attendance, .groups="drop")
  
#Repeating the above steps but this time with Chicago Fire FC as away.
 
cf <- dplyr::filter(matches, away == "Chicago Fire FC")

cfc.a=filter(cf, attendance!="") %>%
  group_by(home, away, date, year) %>%
  summarize(attendance, .groups="drop")


                   
view(cfc.a)
  
  