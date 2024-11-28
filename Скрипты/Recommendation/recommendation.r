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
        size = Экспорт
    )
) +

geom_hline(
    yintercept = -0.34,
    lty = 2,
    color = "#339999"
) +

geom_hline(
    yintercept = 0.4293,
    lty = 2,
    color = "#800000"
) +

geom_vline(
    xintercept = 0.1948,
    lty = 2,
    color = "#800000"
) +

geom_smooth(
    formula = y ~ poly(x, 2, raw = TRUE), 
    method = lm, 
    se= FALSE, 
    color = "#DCAD76",
    show.legend = FALSE
) +

geom_point() +

labs(
    x = "Связанность товара с экспортным портфелем страны",
    y = "Сложность Экономики",
    colour = "Gears"
) +

theme_linedraw()
