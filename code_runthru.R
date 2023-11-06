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
