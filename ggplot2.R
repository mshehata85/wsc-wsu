#ggpolt2
#load ggplot2
library("ggplot2")
# remove all the variables
rm(list =ls())
# remove one variable
rm ( variable name)
gapminder  <- read.csv("gapminder.csv")

# scatterplot of lifeExp vs gdpPercap
ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) + geom_point()
#note: aes stand for aesthetics
#      geom stand for geometric objects

# equivelent to
P  <- ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) 
p2 <- P+geom_point()
print(p2) # it will plot only when you print 

# smake the x axis have a log scale
P3 <- P + geom_point() + scale_x_log10()
P3
# Another way to get the log scale
ggplot(gapminder,
       aes (x=log10(gdpPercap), y=lifeExp)) + geom_point()
# Note : still a difference existing
#
#challengemake the same scatter plot but for chaina only
chall1 <- gapminder %>%
  filter(country == "China") %>%
  ggplot(aes (x=gdpPercap, y=lifeExp)) + geom_point()
chall1

# geom options
# if i put parantheses around the whole thing I trigger plotting the plot
(chall1 <- gapminder %>%
  filter(country == "China") %>%
  ggplot(aes (x=gdpPercap, y=lifeExp)) + geom_point(size =4)) 
# to color the points by continent
ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() +aes(color=continent)
# equivelent to
ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp, color=continent)) + geom_point() + scale_x_log10() 

#the next statement change the type of the original data
gapminder$year <- as.factor(gapminder$year)  # to change from numeric to factor
gapminder$year <- as.numeric(gapminder$year)  # to change from factor to numeric
ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp, color=continent, size= pop, shape= year) + geom_point() + scale_x_log10()
# equivelent to      
ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp, color=continent, size= pop, shape= factor(year)) + geom_point() + scale_x_log10() 
# back to china data but with lines
chall1 <- gapminder %>%
   filter(country == "China")
   ggplot(chall1, aes (x=gdpPercap, y=lifeExp)) + geom_line(color="violetred")+ geom_point(color="lightblue",size=5)
chall1
#note the order defines the layer sequance( which is above of which) note the difference -->
chall1 <- gapminder %>%
  filter(country == "China")
ggplot(chall1, aes (x=gdpPercap, y=lifeExp)) + geom_point(color="lightblue",size=5)+ geom_line(color="violetred")
chall1
# how to specify different attributes 
chall1 <- gapminder %>%
  filter(country == "China")
ggplot(chall1, aes (x=gdpPercap, y=lifeExp)) + geom_line(color="violetred")+ geom_point(aes(color=year ),size=5)
chall1
# aes inside geom is only for that geom but the one in the ggplot is general except if overwritten
# challlange
gm_chinaindia<- gapminder %>%
  filter(country %in% c("China","india") # to select data with one of htem
ggplot(gm_chinaindia, aes (x=gdpPercap, y=lifeExp)) + geom_line(color="black")+ geom_point(aes(color=country),size=5)
gm_chinaindia
# | means (or)equivelent to 
gm_chinaindia<- gapminder %>%
  filter(country == "China"| country == "India") # to select data with one of htem
ggplot(aes (x=gdpPercap, y=lifeExp, group=country)) + geom_line(color="black")+ geom_point(aes(color=country),size=5)
gm_chinaindia

# 
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=lifeExp)) + geom_histogram(binwidth=2.5, fill="lightblue", color="black")

gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent))+ 
  geom_boxplot()

#to flip the coordinates ( if you need to search any thing --> internet)
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent))+ 
  geom_boxplot()+coord_flip()
# another tool
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent))+ 
  geom_boxplot() +
  geom_point(position=position_jitter(width=0.1,height=0))

# facet_ grid and facet_wrap
ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) +
       geom_point()+scale_x_log10()+
      facet_grid(~continent) # ~ saying doing it virtically

ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) +
  geom_point()+scale_x_log10()+
  facet_grid(continent ~.) # ~ saying doing it horizontaly, ~ needs a thing after it

ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) +
  geom_point()+scale_x_log10()+
  facet_grid(continent ~ year) 

ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp)) +
  geom_point()+scale_x_log10()+
  facet_wrap(~continent) # ~ saying doing it horizontaly

ggplot(gapminder,
       aes (x=gdpPercap, y=lifeExp, color=continent)) +
  geom_point()+scale_x_log10()+
  facet_wrap(~year) # ~ saying doing it horizontaly

# challenge
p10 <- gapminder %>%
  filter(country %in% c("China","India","United States","France","Nigeria")) %>%
  ggplot(aes (x=gdpPercap, y=lifeExp, group=country)) +
  geom_line()+facet_grid(country~.) 

# changes in the apperance (themes)
p10+theme_bw()
# other themes in other liberaries
liberary(ggthemes)
p10+theme_wsj()
liberary(broman)
p10+theme_karl()

# save the plots
ggsave("four_countries.pdf",p10, height=7, width=10) # height and width in inchs
ggsave("four_countries.png",p10, height=7, width=10) # height and width in inchs
install.packages("ggthemes")

