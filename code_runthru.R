# objects

class(ggplot2::diamonds$price)
summary(ggplot2::diamonds$price)
summary(ggplot2::diamonds$cut)

mean(c(1,2,3))

formals(rnorm)

rnorm(n = 5, mean = 10, sd = 5)
rnorm(n = 5, mean = -5, sd = 1)
?rnorm

??"gamma"


runif(n = 5, min = 1, max = 10)
runif(min = 1, max = 10, n = 5)
runif(5, 1, 6)
runif(mi = 1, ma = 10, n = 5)

1 + 2

`+`(1, 2)

c(1, 2, 3) + c(5, 6, 7)


# ex pg.11 ----------------------------------------------------------------

set.seed(123) # we can set the random seed 
sample(x = letters, size = 5)

# R packages --------------------------------------------------------------

# packages are install in your libpath

.libPaths()

install.packages("nycflights13")
# pak::pkg_install() another way (newer) of installing packages

library(MASS)
Animals
?Animals

library(dplyr)

objects("package:stats")

# ex pg.17 ----------------------------------------------------------------

search()
objects("package:datasets")
library(modeldata)
objects("package:modeldata")
search()
objects(2)

# Workspace objects -------------------------------------------------------

x <- 4*3
x = 13

x <- rnorm(n = 10, sd = 2)
y <- runif(10)

# Working directories -----------------------------------------------------

getwd()

setwd(r"(S:\Finance\Shared Area\BNSSG - BI\8 Modelling and Analytics\working\nh\projects\r_training_4)")

file.exists("data/measles.csv")
file.exists("data/foo.csv")

here::here("data", "measles.csv")
here::here("data/measles.csv")

# ex pg. 23 ---------------------------------------------------------------
getwd()
setwd("..")
getwd()
setwd(here::here("")) # here 'knows' where the project is

file.exists("data/bridges.csv")
file.exists(here::here("data", "bridges.csv"))

# reading data ------------------------------------------------------------

library(readr)

measles <- read_csv("data/measles.csv")
View(measles)

head(measles, n = 3)
tail(measles, n = 3)

# ex pg. 28 ---------------------------------------------------------------

bridges <- read_csv("data/bridges.csv")
View(bridges)
tail(bridges, n = 10)

# data frame attributes ---------------------------------------------------
ncol(measles)
nrow(measles)
dim(measles)
names(measles)

# reading data from excel -------------------------------------------------

library(readxl)



excel_sheets("data/RTT-Incomplete-Provider.xls")

rtt_data <- read_excel("data/RTT-Incomplete-Provider.xls", sheet = "Provider")
head(rtt_data)

nrow(rtt_data)
names(rtt_data)

# Vectors -----------------------------------------------------------------

measles$state

c(1, 3, 4, 5)
c("A", "C", "D")
c(TRUE, FALSE, FALSE)

1:100

100:1
-10:10

seq(from = 0, to = 13, by = 1)
seq(from = 0, to = 12, by = 3)
seq(from = 1, to = 37, length.out = 17)
seq(from = 1, to = 37, length.out = 18)

rep(1:3, times = 3)
rep(1:3, each = 3)

c(rep(1:3, each = 3), seq(from = 0, to = 12, by = 3))

# subscripting vectors ----------------------------------------------------

letters
LETTERS
LETTERS[1:3]
LETTERS[c(TRUE, FALSE)]
LETTERS[LETTERS == "G"]
measles[measles$count > 40, ]

# the notional machine ---------------------------------------------------

is.integer(2)
is.integer(2L)

c(1, 2, 3, "4")
length(c("thank you ", "NHS"))
nchar("NHS")

nchar("700000")
nchar(700000)

max(airquality$Ozone)
max(airquality$Ozone, na.rm = TRUE)

mean(replicate(5e3,
               any(duplicated(sample(1:365,
                                     size = 23,
                                     replace = TRUE)
                              ))))


# data manipulation with dplyr --------------------------------------------

library(dplyr)
library(tidyverse)


# intro to dplyr syntax

# data.frame <- DPLYR_VERB(data.frame, ... (specification) ...)

txhousing

filter(txhousing, year == 2007)

filter(txhousing, median < 15E4)

filter(txhousing, year == 2007, median < 15E4)

filter(txhousing, year == 2007 | median < 15E4)

filter(txhousing, month %in% 1:4)

# select ------------------------------------------------------------------

select(txhousing, city, year)

select(txhousing, 1:3, 5)

select(txhousing, -5)

select(txhousing, -inventory)
select(txhousing, -inventory, -sales)

select(txhousing, city:volume)

select(txhousing, starts_with("m"))

select(txhousing, one_of("listings", "date", "this_column_doesnt_exist"))

select(txhousing, contains("a"))


# ex pg.45 ----------------------------------------------------------------
measles <- read_csv("data/measles.csv")

measles_hawaii <- filter(measles, state == "Hawaii")
measles_hawaii

measles_hawaii <- select(measles_hawaii, -state)
measles_hawaii

measles_hawaii <- filter(measles_hawaii, count > 250)
measles_hawaii

# arrange -----------------------------------------------------------------

arrange(txhousing, median)
arrange(txhousing, desc(median))

arrange(txhousing, median, volume)

# mutate/summarise/group_by -----------------------------------------------

mutate(txhousing, sales/listings)
mutate(txhousing, sales_per_listing = sales/listings)
mutate(txhousing,
       sales_per_listing = sales/listings,
       sales_per_listing_squared = sales_per_listing^2)


summarise(txhousing, min_value = min(median, na.rm = TRUE))
summarise(txhousing, n_cities = n_distinct(city), nrows = n())
summarise(txhousing, n_missing = sum(is.na(median)))


summarise(group_by(txhousing, year), min_value = min(median, na.rm = TRUE))
summarise(group_by(txhousing, year), min_value = min(median, na.rm = TRUE))
summarise(group_by(txhousing, year), avg_value = mean(median, na.rm = TRUE))
summarise(group_by(txhousing, year),
          min_value = min(median, na.rm = TRUE),
          avg_value = mean(median, na.rm = TRUE))


library(magrittr)




mutate(group_by(txhousing, year),
       avg_value = mean(median, na.rm = TRUE),
       res_value = median - avg_value)

filter(group_by(txhousing, city),
       median == max(median, na.rm = TRUE))


# ex pg.56 ----------------------------------------------------------------

measles_by_state <- group_by(measles, state)

measles_sum <- summarise(measles_by_state,
                         count_mean = mean(count, na.rm = TRUE),
                         count_min = min(count, na.rm = TRUE),
                         count_max = max(count, na.rm = TRUE))


filter(measles_by_state, count == max(count, na.rm = TRUE))


# the pipe ----------------------------------------------------------------

summarise(group_by(txhousing, year), min_value = min(median, na.rm = TRUE))

txhousing %>%
  group_by(year) %>%
  summarise(min_value = min(median, na.rm = TRUE))


# ex pg.58 ----------------------------------------------------------------

measles %>%
  group_by(state) %>%
  arrange(desc(count)) %>%
  filter(count > 250) %>%
  mutate(max_count = max(count, na.rm = TRUE))


pos_data <-
  tibble(
    date = rep(seq.Date(
      lubridate::ymd("2001-01-01"), lubridate::ymd("2020-01-01"), "months"
    ), each = 10),
    customer = replicate(2290, paste(sample(letters, 2), collapse = "")),
    amount = rnorm(2290)
  )

pos_data %>%
  group_by(customer) %>%
  filter(date == min(date)) %>%
  group_by(date) %>%
  summarise(n_custom = n())


# Awkward data types ------------------------------------------------------
library(lubridate)

now()

now() %>% class()
today()

ymd("2021-03-01")
ymd("2021-Mar-01")

my_dates <- c("23 Apr 2017", "31 Dec 2018", "11 Oct 2015")

dmy(my_dates)

my_times <- c("14:22:00", "13:04:01", "09:00:00")

hms(my_times)

ymd_hms("2021-04-01 13:00:00")

seq(ymd("2021-04-07"), ymd("2022-03-22"), by = "week")

seq(ymd("2021-04-07"), ymd("2022-03-22"), by = "3 week")
seq(ymd("2021-04-07"), ymd("2022-03-22"), by = "month")
seq(ymd("2021-04-07"), ymd("2022-03-22"), by = "6 month")
seq(ymd("2021-04-07"), ymd("2022-03-22"), by = "year")


nye <- ymd_hms("2020-12-31 23:59:59")
nye

nye + seconds(2)
nye + days(2)
nye + weeks(2)
nye + months(2)

months(2)

month(nye)
day(nye)

quarters(dmy(my_dates))


dmy(my_dates) %>%
  ceiling_date(unit = "month")

dmy(my_dates) %>%
  floor_date(unit = "month")


dmy(my_dates) %>%
  rollforward()


today() - dmy(my_dates)

a <- dmy("1/1/1900")
b <- dmy("1/1/2000")

interval <- a %--% b

interval

period <- as.period(interval)
duration <- as.duration(interval)

time_length(period, unit = "year")
time_length(duration, unit = "year")

# mixed formats
c("2021-12-01", "01-01-2004") %>%
  parse_date_time(orders = c("ymd", "dmy")) %>%
  as.Date()

# ex pg.67 ----------------------------------------------------------------

ex_dates <- c("2023-11-09", "2023-12-31", "2024-02-05")

ex_dates <- ymd(ex_dates)
ex_dates

ex_dates[3] - today()

weekdays(ex_dates[2])
wday(ex_dates[2])
ex_date_seq <- seq(ymd("1980-01-01"), ymd("2020-01-01"), by = "6 month")
floor_date(ex_date_seq, unit = years(10))

# factors with forcats ----------------------------------------------------


x <- c("B", "C", "D", "A", "D", "A", "B", "C")
y <- factor(x)

cyl <- ggplot2::mpg %>%
  pull(cyl)

unique(cyl)

cyl <- factor(cyl)
cyl <- factor(cyl, labels = c("four", "five", "six", "eight"))
cyl <- factor(cyl, labels = c("four", "five", "six", "eight"))
cyl <- factor(cyl, levels = 4:8, labels = c("four", "five", "six", "seven", "eight"))

cyl

boxplot(cty ~ trans, data = ggplot2::mpg)

library(forcats)

boxplot(cty ~ fct_reorder(trans, cty),
        data = ggplot2::mpg)


starwars %>%
  mutate(homeworld = fct_infreq(homeworld)) %>%
  count(homeworld)

starwars %>%
  mutate(homeworld = fct_infreq(homeworld),
         homeworld = fct_lump_n(homeworld, n = 5)) %>%
  count(homeworld)

starwars %>%
  mutate(homeworld = fct_infreq(homeworld),
         homeworld = fct_lump_n(homeworld, n = 5),
         homeworld = fct_na_value_to_level(homeworld, level = "(Missing)")) %>%
  count(homeworld)

ages <- c(19, 38, 33, 25, 21, 27, 27, 24, 25, 32)
cut(ages, breaks = 3)

cut(ages, breaks = c(18, 25, 30, Inf))
cut(ages, breaks = c(18, 25, 30, Inf), right = FALSE)
cut(ages, breaks = c(18, 25, 30, Inf), right = FALSE, labels = c("18-25",
                                                                 "25-30",
                                                                 "30+"))

# ex pg.77 ----------------------------------------------------------------


airquality %>%
  mutate(Month = factor(Month,
                        levels = 1:12,
                        labels = month.name),
         high_wind = cut(Wind, breaks = c(0, 15, Inf), labels = c("No", "Yes")))


airquality %>%
  mutate(Month = factor(Month,
                        levels = 1:12,
                        labels = month.name),
         high_wind = ifelse(Wind > 15, no = "No", yes = "Yes"))

# Characters --------------------------------------------------------------

library(stringr)
my_string <- "National Health Service"        # Save the string 
str_length(my_string)                 # Number of characters


str_sub(my_string, 1, 8)
str_sub(my_string, c(1, 10, 17), c(8, 15, 23))

str_c("X", 1:10)
str_c("X", 1:10, sep = "-")
str_c("X", 1:10, sep = "-", collapse = ", ")


firsts  <- c("nick", "dan", "chris")
lasts <- c("howlett", "levy", "waller")

str_c(firsts, lasts, sep = " ")
str_c(firsts, lasts, sep = " ", collapse = ", ")
str_c(str_to_title(firsts), str_to_title(lasts), sep = " ", collapse = ", ")


str_subset(colours(), "orange")
words <- readLines("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")
str_subset(words, "^[^aeiou]*?a[^aeiou]*?e[^aeiou]*?i[^aeiou]*?o[^aeiou]*?u[^aeiou]*$")
str_subset(words, "^[^aeiou]*?u[^aeiou]*?o[^aeiou]*?i[^aeiou]*?e[^aeiou]*?a[^aeiou]*$")

# https://www.google.co.uk/books/edition/Mastering_Regular_Expressions/P5UXAwAAQBAJ?hl=en&gbpv=1&printsec=frontcover

# Visualisation ggplot2 ---------------------------------------------------

library(tidyverse)

p <- ggplot(data = mpg, # DATA
            mapping = aes(x = displ, y = cty) # MAPPING
            ) +
     geom_point() # GEOMETRY

print(p)

# A schematic for a ggplot
# p <- ggplot(data = DATA
#             mapping = MAPPING
# ) +
#     geom_GEOMETRY
# 
# print(p)

p <- ggplot(data = mpg, # DATA
            mapping = aes(x = displ, y = cty) # MAPPING
            ) +
     geom_line() # GEOMETRY

print(p)

ggplot(data = mpg, # DATA
       mapping = aes(x = displ, y = cty) # MAPPING
            ) +
     geom_smooth() +
     geom_point() 

stringi::stri_subset(objects(package:ggplot2), regex = "geom_")

# ex pg.86 ----------------------------------------------------------------

p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = cyl, y = cty)) + # MAPPING 
  geom_point()                                   # GEOMTRY

print(p)

p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = factor(cyl), y = cty)) + # MAPPING 
  geom_point()                                   # GEOMTRY

print(p)

p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = factor(cyl), y = cty)) + # MAPPING 
  geom_boxplot()                                   # GEOMTRY

print(p)

p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = factor(cyl), y = cty)) + # MAPPING 
  geom_boxplot()                                   # GEOMTRY

print(p)

p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = factor(cyl), y = cty)) + # MAPPING 
  geom_boxplot() +
  geom_count() # GEOMTRY

print(p)

# Titles, axis labels, and axis limits ------------------------------------

p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = displ, y = cty)) + # MAPPING 
  geom_point() +                                   # GEOMTRY
  labs(title = "Car mileage vs engine displacement",
       subtitle = "Data from the 'mpg' data",
       x = "Engine displacement, litres",
       y = "City miles per gallon")
print(p)
p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = displ, y = cty)) + # MAPPING 
  geom_point() +                                   # GEOMTRY
  labs(title = "Car mileage vs engine displacement",
       subtitle = "Data from the 'mpg' data",
       x = "Engine displacement, litres",
       y = "City miles per gallon")
print(p)




p <- ggplot(data = mpg,                          # DATA
            mapping = aes(x = displ, y = cty)) + # MAPPING 
  geom_point() +                                 # GEOMTRY
  labs(title = "Car mileage vs engine displacement",
       subtitle = "Data from the 'mpg' data",
       x = "Engine displacement, litres",
       y = "City miles per gallon") +
  coord_cartesian(xlim = c(0, NA),
                  ylim = c(0, NA))
print(p)


# ex pg. 89 ---------------------------------------------------------------

ggplot(data = airquality, 
       mapping = aes(x = Wind, y = Ozone)) +
  geom_point() +
  labs(title = "Is Ozone related to windspeed?",
       subtitle = "Data from 'airquality'",
       y = "Ozone, ppb",
       x = "Windspeed, mph") +
  coord_cartesian(xlim = c(0, NA))

ggplot(data = mpg, aes(x = cty)) +
  geom_histogram(bins = 15)

# A (quick) guide to human perception -------------------------------------

# Mapping more aesthetics -------------------------------------------------
p <- ggplot(data = mpg, aes(x = displ,
                            y = cty,
                            colour = drv)) +
  geom_point() +
  labs(title = 'City mileage Vs engine displacement\nfrom the \"mpg\" Data',
       x = 'Engine displacement, litres',
       y = 'City miles per gallon')

print(p)

p <- ggplot(data = mpg, aes(x = displ,
                            y = cty,
                            colour = drv,
                            size = cyl)) +
  geom_point() +
  labs(title = 'City mileage Vs engine displacement\nfrom the \"mpg\" Data',
       x = 'Engine displacement, litres',
       y = 'City miles per gallon')

print(p)


stringi::stri_subset(objects(package:ggplot2), regex = "scale_")

p <- ggplot(data = mpg, aes(x = displ,
                            y = cty,
                            colour = drv,
                            size = cyl)) +
  geom_point() +
  scale_size_continuous(name = "Number of cylinders",
                        range = c(3, 6),
                        breaks = c(4, 6, 8)) +
  labs(title = 'City mileage Vs engine displacement\nfrom the \"mpg\" Data',
       x = 'Engine displacement, litres',
       y = 'City miles per gallon')

print(p)

p <- ggplot(data = mpg, aes(x = displ,
                            y = cty,
                            colour = drv,
                            size = cyl)) +
  geom_point() +
  scale_size_continuous(name = "Number of cylinders",
                        range = c(3, 6),
                        breaks = c(4, 6, 8)) +
  scale_x_log10() +
  scale_y_log10() +
  annotation_logticks() +
  labs(title = 'City mileage Vs engine displacement\nfrom the \"mpg\" Data',
       x = 'Engine displacement, litres',
       y = 'City miles per gallon')

print(p)

diamonds

# ex pg. 116 --------------------------------------------------------------

ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price,
                     colour = clarity)) +
  geom_point() +
  scale_colour_viridis_d("Clarity", begin = 0.2, end = 0.8, direction = 1)


# Facets ------------------------------------------------------------------

ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price,
                     colour = clarity)) +
  geom_point() +
  scale_colour_viridis_d("Clarity", begin = 0.2, end = 0.8, direction = 1) +
  facet_wrap(vars(cut))
ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price,
                     colour = clarity)) +
  geom_point() +
  scale_colour_viridis_d("Clarity", begin = 0.2, end = 0.8, direction = 1) +
  facet_wrap(vars(cut))


p <- ggplot(data = mpg, aes(x = displ, y = cty, col = drv)) +
  geom_point() +
  scale_size_continuous(name = "Number of cylinders",
                        range = c(2, 6),
                        breaks = c(4, 6, 8)) +
  labs(title = 'City mileage Vs engine displacement\nfrom the \"mpg\" Data',
       x = 'Engine displacement, litres',
       y = 'City miles per gallon',
       col = "Drive train") +
  facet_wrap(vars(cyl),
             labeller = "label_both",
             scales = "free")

print(p)


ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  facet_grid(cut ~ clarity)

library(patchwork)

p1 <- ggplot(data = mpg, aes(x = displ, y = cty)) +
  geom_point() +
  labs(x = 'Engine displacement, litres',
       y = 'City miles per gallon')

p1

p2 <- mpg %>%
  ggplot(aes(x = fct_reorder(factor(cyl), cty, .desc = TRUE), y = cty)) +
  geom_boxplot() +
  labs(x = 'Engine Cylinders',
       y = 'City miles per gallon')

p2

p3 <- mpg %>%
  ggplot(aes(x = fct_reorder(factor(drv, labels = c("4-wheel drive",
                                                    "Front-wheel drive",
                                                    "Rear-wheel drive")),
                             cty, .desc = TRUE), y = cty)) +
  geom_boxplot() +
  scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
  labs(x = 'Vehicle drive train',
       y = 'City miles per gallon')

p3

wrap_plots(p1, p2, p3, nrow = 1)

patch <- wrap_plots(p1, p2, p3, nrow = 1)
patch

# Remove y-axis from p2
patch[[2]] = patch[[2]] + theme(axis.text.y = element_blank(),
                                axis.ticks.y = element_blank(),
                                axis.title.y = element_blank())

# Remove y-axis from p3
patch[[3]] = patch[[3]] + theme(axis.text.y = element_blank(),
                                axis.ticks.y = element_blank(),
                                axis.title.y = element_blank())

# add some plot annotation
patch <- patch + plot_annotation(title = "Fuel economy versus vehicle type",
                                 subtitle = "Data from ggplot2::mpg")

patch


# ex pg.127 ---------------------------------------------------------------

measles <- read_csv("data/measles.csv")
library(lubridate)

measles %>%
  mutate(date = dmy(date)) %>%
  group_by(decade = floor_date(date, unit = "10 years")) %>%
  filter(state == "California") %>%
  summarise(count = mean(count, na.rm = TRUE)) %>%
  ggplot(aes(x = decade, y = count)) +
  geom_step()

measles %>%
  mutate(date = dmy(date)) %>%
  group_by(state, decade = floor_date(date, unit = "10 years")) %>%
  summarise(count = mean(count, na.rm = TRUE)) %>%
  ggplot(aes(x = decade, y = count)) +
  geom_step() +
  facet_wrap(vars(state))

# statistics and modelling ------------------------------------------------

library(tidyverse)

pull(iris, Sepal.Length)
     
iris$Sepal.Length %>% summary()
iris$Species %>% summary()
skimr::skim(iris)

# statistical tests -------------------------------------------------------

sleep
ggplot(sleep, aes(x = group, y = extra)) + geom_boxplot()

t.test(extra ~ group, data = sleep)


sleep

t.test(extra ~ group, data = sleep, paired = TRUE)
t.test(extra ~ group, data = sleep, paired = TRUE)

# in this case the data are randomly shuffled
t.test(extra ~ group,
       data = sleep[sample(nrow(sleep),
                           nrow(sleep), replace = FALSE), ],
       paired = TRUE)

t.test(x = sleep$extra[sleep$group == 1],
       y = sleep$extra[sleep$group == 2],
       paired = TRUE)

library(modeldata)

pairs(Sacramento)

my_lm <- lm(price ~ sqft, data = Sacramento)

summary(my_lm)

resid(my_lm)

# ex pg. 147 --------------------------------------------------------------

ggplot(mpg, aes(x = displ, y = cty)) + geom_point()

ex_lm <- lm(cty ~ displ, data = mpg)
ex_lm
coef(ex_lm)

ggplot(mpg, aes(x = displ, y = cty)) +
  geom_point() +
  geom_smooth(method = "lm")


resid(ex_lm)

ggplot(mpg, aes(x = displ, y = resid(ex_lm))) +
  geom_point() 


plot(my_lm)

library(performance)
library(see)
check_model(my_lm)


# ex pg.149 ---------------------------------------------------------------

summary(ex_lm)

plot(ex_lm)

par(mfrow=c(2, 2)) # set up the graphics device
plot(ex_lm)
dev.off()

# stats book
# https://www.statlearning.com/


my_lm2 <- update(my_lm, price ~ sqft + type)
summary(my_lm2)

my_lm2 <- lm(price ~ sqft + type, data= Sacramento)
summary(my_lm2)

my_lm3 <- lm(price ~ ., data = Sacramento)

my_lm3 <- update(my_lm2, . ~ . + beds)
summary(my_lm3)

anova(my_lm3)

anova(my_lm, my_lm3)

# ex pg.153 ---------------------------------------------------------------

ex_lm2 <- lm(cty ~ displ + drv, data = mpg)

anova(ex_lm, ex_lm2)
ex_lm3 <- lm(cty ~ log10(displ), data = mpg)


anova(ex_lm, ex_lm3)

ex_lm3 <- lm(log10(cty) ~ log10(displ), data = mpg)

anova(ex_lm, ex_lm3)

summary(ex_lm)
summary(ex_lm3)


# 
# 
# 
library(tidymodels)

iris_split <- initial_split(iris, strata = Species)
iris_train <- training(iris_split)
iris_test <- testing(iris_split)

iris_rf <- randomForest::randomForest(Species ~ ., iris_train)
species_pred <- predict(iris_rf, newdata = iris_test)

iris_test_pred <- iris_test %>%
  mutate(pred = species_pred)


# tidy data ---------------------------------------------------------------
# cleaning variable names -------------------------------------------------

state.x77
library(tidyr)
library(tibble)
install.packages("janitor")
library(janitor)

state_df <- state.x77 %>%
  as.data.frame() %>%
  rownames_to_column(var = "state") %>%
  clean_names()

# pivoting data ----------------------------------------------------------

iris

tidy_iris <- iris %>%
  clean_names()


tidy_iris %>%
  pivot_longer(cols = -species,
               names_to = "feature",
               values_to = "observation")

tidy_iris %>%
  mutate(id = 1:n()) %>%
  pivot_longer(cols = -c(id, species),
               names_to = c("feature", "metric"),
               names_sep = "_",
               values_to = "observation")
tidy_iris %>%
  mutate(id = 1:n()) %>%
  pivot_longer(cols = -c(id, species),
               names_to = c("feature", "metric"),
               names_sep = "_",
               values_to = "observation") %>%
  pivot_wider(names_from = "metric",
              values_from = "observation")


# ex pg.164 ---------------------------------------------------------------

table4a

table4a %>%
  pivot_longer(cols = -country, 
               names_to = "year",
               values_to = "count")



table3 %>%
  separate(col = "rate",
           into = c("count", "population"),
           sep = "/")

table2 %>%
  pivot_wider(names_from = "type",
              values_from = "count")

# Performing joins in R ---------------------------------------------------

band_members
band_instruments


left_join(band_members,
          band_instruments,
          by = join_by(name == name))

left_join(band_members,
          band_instruments,
          by = join_by(name == name))
           
right_join(band_members,
          band_instruments,
          by = join_by(name == name))

inner_join(band_members,
          band_instruments,
          by = join_by(name == name))

full_join(band_members,
          band_instruments,
          by = join_by(name == name))



# ex pg.167 ---------------------------------------------------------------

library(nycflights13)

flights
airlines

left_join(flights, airlines, join_by(carrier == carrier)) %>%
  rename(carrier_name = name)

measles <- readr::read_csv("data/measles.csv")


measles %>%
  left_join(select(state_df, state, area), by = join_by(state == state)) %>%
  mutate(count_per_area = count/area) %>%
  arrange(desc(count_per_area))


# quick outro on databases ------------------------------------------------
# https://solutions.posit.co/connections/db/

library(RODBC)

con <- RODBC::odbcDriverConnect(
  "driver={SQL Server};server=Xsw-000-sp09;
  trusted_connection=true")

qry <- "
SELECT top 10 * FROM
[Analyst_SQL_Area].[dbo].[vw_BNSSG_CCG DOACs]
"

df <- sqlQuery(con, qry)



