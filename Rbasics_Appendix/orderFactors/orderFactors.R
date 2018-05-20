
# Check current path
getwd()

# Set the path to the file
path <- '~/github/DataAnalyst/Rbasics_Appendix/orderFactors/'
setwd(path)

# Load data
reddit <- read.csv('reddit.csv')

# Inspect data 
table(reddit$employment.status)

str(reddit)

levels(reddit$age.range)

# Load plotting library
library(ggplot2)

# Plot data
qplot(data=reddit, x = age.range)
qplot(data=reddit, x = income.range)


# Ordering age range from youngest to oldest and plot it
reddit$age.range <- ordered(reddit$age.range, 
                            levels = c("Under 18", "18-24", "25-34", 
                                       "35-44", "45-54", "55-64", 
                                       "65 or Above"))

qplot(data=reddit, x = age.range)

# Ordering the income from lowest to highest and plot it
levels(reddit$income.range)

s = c("Under $20,000","$20,000 - $29,999","$30,000 - $39,999", 
      "$40,000 - $49,999", "$50,000 - $69,999", "$70,000 - $99,999",
      "$100,000 - $149,999", "$150,000 or more")

reddit$income.range <- factor(reddit$income.range, levels = s, ordered = T)

qplot(data=reddit, x = income.range)
