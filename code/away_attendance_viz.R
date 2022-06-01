#install and load packages.

install.packages("tydiverse")

library(tidyverse)
library(readr)
library(dplyr)
library(skimr)

#load raw data and filter only relevant data.


cfc <- dplyr::filter(matches, home == "Chicago Fire FC")

cfc.h=filter(cfc, attendance!="") %>% 
  group_by(home, away) %>%
  summarize(attendance, .groups="drop")
view(cfc.h)

#Repeating the above steps but this time with Chicago Fire FC as away.

cf <- dplyr::filter(matches, away == "Chicago Fire FC")

cfc.a=filter(cf, attendance!="") %>%
  group_by(home, away, date, year) %>%
  summarize(attendance, .groups="drop")

#Getting the average attendance by team. 

mean.a <- aggregate(x=cfc.a$attendance,
          by=list(cfc.a$home,cfc.a$away),
          FUN=mean) 
view(mean.a)

#data viz
#personal note, fill color black= #353436, color blue = #1b98e0

library(ggplot2)

ggplot(mean.a, aes(x = Group.1, y = x)) +
  geom_col() +
  scale_x_discrete(label = function(x) stringr::str_trunc(x, 12)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  geom_bar(stat = "identity", fill="#1b98e0", colour="red") +
  xlab("Home Teams") +
  ylab("Attendance") + 
  ggtitle("Chicago Fire FC Away")


ggplot(mean, aes(x = Group.2, y = x)) +
  geom_col() +
  scale_x_discrete(label = function(x) stringr::str_trunc(x, 12)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  geom_bar(stat = "identity", fill="#1b98e0", colour="red") +
  xlab("Away Teams") +
  ylab("Attendance") + 
  ggtitle("Chicago Fire FC Home")
