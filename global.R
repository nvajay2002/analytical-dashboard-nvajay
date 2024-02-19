# Packages
#install.packages(c("shiny", "shinydashboard", "dplyr", "DT", "readxl", "ggplot2", "plotly", "ggtext", "ggcorrplot", "reshape2"))
#library(shiny)
library(shinydashboard)
library(dplyr)
library(DT)
library(readxl)
library(ggplot2)
library(plotly)
library(ggtext)
library(ggcorrplot)
library(reshape2)

#Global 
#setwd("C:/RTSM/Dashboard/New folder")
data = read_excel("Road Accidents_Statewise.xls")
columns_to_remove <- c("Accidents - 2021 - Rank", "Killed - 2021 - Rank", "Injured - 2021 - Rank")

# Corrected usage with setdiff
data <- data[, setdiff(names(data), columns_to_remove)]
data = data[-38, ]#removing total
data <- mutate_all(data, funs(ifelse(. == "NA", NA, .)))

#Converting required columns to numeric


# Columns related to Fatal Accidents
fatal_columns <- c("Fatal Accidents - 2018", "Fatal Accidents - 2019", "Fatal Accidents - 2020", "Fatal Accidents - 2021")

# Columns related to Accidents
accidents_columns <- c("Accidents - 2018", "Accidents - 2019", "Accidents - 2020", "Accidents - 2021 - Number")

# Columns related to Killed
killed_columns <- c("Killed - 2018", "Killed - 2019", "Killed - 2020", "Killed - 2021 - Number")

# Columns related to Injured
injured_columns <- c("Injured - 2018", "Injured - 2019", "Injured - 2020", "Injured - 2021 - Number")

# Combine all relevant columns
numeric_columns <- c(fatal_columns, accidents_columns, killed_columns, injured_columns)

data = data %>%
  mutate_at(vars(numeric_columns), as.numeric)


#structure
data %>% 
  str()

#Summary
data %>% 
  summary()



#Choices for input 
choices1 = data %>% 
  select(-'State/UT') %>% 
  names()


#Assigning statenames
State = data[["State/UT"]]

# Anova Tests

#Fatal Accidents(FA)
FA1 = data$`Fatal Accidents - 2018`
FA2 = data$`Fatal Accidents - 2019`
FA3 = data$`Fatal Accidents - 2020`
FA4 = data$`Fatal Accidents - 2021`


data_FA <- data.frame(
  State = State,
  FA_2018 = FA1,
  FA_2019 = FA2,
  FA_2021 = FA3,
  FA_2021 = FA4
)

FA_data_long1 <- melt(data_FA, id.vars = "State", variable.name = "Year", value.name = "Number")

# Fit repeated measures ANOVA
model_FA <- aov(Number ~ Year + Error(State / Year), data = FA_data_long1)


# Accidents (A)
A1 = data$`Accidents - 2018`
A2 = data$`Accidents - 2019`
A3 = data$`Accidents - 2020`
A4 = data$`Accidents - 2021 - Number`

data_A <- data.frame(
  State = State,
  A_2018 = A1,
  A_2019 = A2,
  A_2020 = A3,
  A_2021 = A4
)

A_data_long2 <- melt(data_A, id.vars = "State", variable.name = "Year", value.name = "Number")

# Fit repeated measures ANOVA
model_A <- aov(Number ~ Year + Error(State / Year), data = A_data_long2)

# Killed (K)
K1 = data$`Killed - 2018`
K2 = data$`Killed - 2019`
K3 = data$`Killed - 2020`
K4 = data$`Killed - 2021 - Number`

data_K <- data.frame(
  State = State,
  K_2018 = K1,
  K_2019 = K2,
  K_2020 = K3,
  K_2021 = K4
)

K_data_long3 <- melt(data_K, id.vars = "State", variable.name = "Year", value.name = "Number")

# Fit repeated measures ANOVA
model_K <- aov(Number ~ Year + Error(State / Year), data = K_data_long3)

# Injured (I)
I1 = data$`Injured - 2018`
I2 = data$`Injured - 2019`
I3 = data$`Injured - 2020`
I4 = data$`Injured - 2021 - Number`

data_I <- data.frame(
  State = State,
  I_2018 = I1,
  I_2019 = I2,
  I_2020 = I3,
  I_2021 = I4
)

I_data_long4 <- melt(data_I, id.vars = "State", variable.name = "Year", value.name = "Number")

# Fit repeated measures ANOVA
model_I <- aov(Number ~ Year + Error(State / Year), data = I_data_long4)
