library(tidyr)
library(readr)
library(dplyr)
library(data.table)
library(ggplot2)
library(ggflags)
library(readxl)

df <- read_excel("Информация\\Торговля\\Complexity\\data oecd.xlsx")

df$Экспорт <- df$Экспорт / 1000000000

df <- df %>%
    select(Relatedness, `Trade Value ECI`, Экспорт)

fwrite(df, file = "scatter-test.tsv", sep = "\t", quote = FALSE)
