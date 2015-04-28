x<- 8
x *3
y  <-  x/2
y
x  <- 15
ls () # list objects in environment ( this is a comment)

# a vector of weights
weights  <-  c(50, 60, 65, 82)
animals  <- c("mouse", "rat", "dog")
# to open help on a function
?mean  

length(weights)
length(animals)
# find class of an object
class(weights)
class(animals)
#structure
str(weights)
str(animals)
# adding elements to vectors
weights  <-  c(weights, 90)
weights <- c(30, weights)
# challenge 1
z  <- c(x, y, weights)
mean(z)
# Data
# to know our working path
getwd()
# lists files in dir.
list.files()
# change working directory
setwd("~/Destop")
# load data
gapminder  <- read.csv("gapminder.csv")
# gives first 6 rows of data
head(gapminder)
# gives a specified number of rows
head(gapminder, 3)
# earlier funtions work too
class(gapminder)
str(gapminder)
# note it gives the number of levels for non numeric variables only
# number of rows and columns
dim(gapminder)

# bracket subseting to pull some data (not all)
weights[1]
weights[1:3]
#first row, first column
gapminder[1, 1]
#C first row theird column
gapminder[1,3]
# 500th row, 5th & 6th column
gapminder[500,5:6]
# all the population column
gapminder$pop
# equivelent to
gapminder[,5]
gapminder[,"pop"]
# all the rows when country is finland
gapminder[gapminder$country =="Finland",]
# countries and years where pop<=100000
gapminder[gapminder$pop <=100000, c("country","year")]
# equivelent to
gapminder[gapminder$pop <=100000, c(1,3)]
#challenge3
gapminder[50,4]
gapminder[50,"lifeExp"]
gapminder[4,50]
gapminder$lifeExp[50]
# countries with life exp .>50
gapminder[gapminder$lifeExp >80, "country"]
# install an external package
install.packages("dplyr") # data
install.packages("ggplot2") # plotting utility
install.packages("lattice") # Another plotting utility
# load the package
library("dplyr")
# selecting 
select(gapminder,country, year, pop)
filter(gapminder, country=="Finland")
# pipe concept %>% ( sequential operations one after another)

gapminder_sml  <- gapminder %>%
  filter(pop <= 100000)%>%
  select(country, year)

# challenge
gapminder_chal  <- gapminder %>%
  filter(gdpPercap >= 35000)%>%
  select(country, year, gdpPercap)

# mutate function 
# here create new column
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  head  # six rows display

gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent) %>%  # to group by smothing
  summarize(meangdp = mean(totalgdp)) # summerize

gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%  # to group by smothing
  summarize(meangdp = mean(totalgdp)) # summerize

# can summerize more than one in the same time
meanmingdp  <- gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%  
  summarize(meangdp = mean(totalgdp), mingdp= min(totalgdp)) 
#challenge: find the maximum life expectancy for each continent
gapminder %>%
  group_by(continent) %>%  
  summarize(maxlifeExp = max(lifeExp)) 
#challenge: find the max, min, and mean life expectancy for each year
gapminder %>%
  group_by(year) %>%  
  summarize(maxlifeExp = max(lifeExp), minlifeExp = min(lifeExp),meanlifeExp = mean(lifeExp)) 

#challenge: find the population for each year in the data perior to to 1982, return a data frame with the columns country, year and pop
Finland <- gapminder %>%
  filter(country == "Finland") %>%
  group_by(year) %>%
  filter(year < 1982) %>%
  select(country, year, pop) 
#equivelent to 

Finland2 <- gapminder %>%
  filter(country == "Finland", year <1982) %>%
  group_by(year) %>%
  select(country, year, pop) 
# if different packages use the same function. it use the last installed one. you can overidde this:
#dplyer::summarize(------)

# to know the functions in a package
library(help =dplyr)
#or
?compute #C in the bottom index

#to export data as a csv file
write.csv(gapminder_sml,"gabminder_sml.csv")



