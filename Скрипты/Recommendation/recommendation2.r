library(tidyr)
library(readr)
library(dplyr)
library(data.table)
library(ggplot2)
library(ggflags)
library(readxl)

df <- read_excel("Информация\\Торговля\\Complexity\\data oecd.xlsx")

df$Экспорт <- df$Экспорт / 1000000000

ggplot(
    data = df,
    aes(
        x = Relatedness,
        y = `Trade Value ECI`,
        size = Экспорт,
        country = ggcode
    )
) +

geom_flag()

labs(
    x = "Связанность товара с экспортным портфелем страны",
    y = "Сложность Экономики",
    colour = "Gears"
) +

theme_linedraw()
