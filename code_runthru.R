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
summarise(group_by(txhousing, year), avg_value = mean(median, na.rm = TRUE))
summarise(group_by(txhousing, year),
          min_value = min(median, na.rm = TRUE),
          avg_value = mean(median, na.rm = TRUE))


mutate(group_by(txhousing, year),
       avg_value = mean(median, na.rm = TRUE),
       res_value = median - avg_value)

filter(group_by(txhousing, city),
       median == max(median, na.rm = TRUE))




