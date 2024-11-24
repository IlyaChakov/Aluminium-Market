# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)
library(readxl)

df <- read_csv("Информация\\Потребление\\Aluminium refined consumption.csv")
View(df)
summary(df)
str(df)

df$Value <- df$Value / 1000

df_top <- df %>%
    group_by(country) %>%
    summarise(`Совокупный Объем` = sum(Value, na.rm = TRUE)) %>%
    arrange(desc(`Совокупный Объем`))

top_countries <- df_top$country

df_table <- df %>%
    filter(country %in% top_countries) %>%
    pivot_wider(names_from = country,
                values_from = Value) %>%
    select(all_of(top_countries), everything()) %>%
    select(-all_of(top_countries), everything())

fwrite(df_table, file = "comsumption-countries.tsv", sep = "\t", quote = FALSE)

df_pot <- read_excel("Информация\\Потребление\\Потребление.xlsx")