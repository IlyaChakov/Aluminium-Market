# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

df <- read_csv("Информация\\Рынок\\Статистика\\Aluminium market concentration index.csv")
summary(df$product)
str(df)

summary <- df %>%
    select(where(~ is.character(.) | is.factor(.))) %>%
    summarise(across(everything(), ~ list(unique(.)))) %>%
    unnest(cols = everything())

# Aluminium
t_conc_al <- df %>%
    filter(
        Date >= 2010,
        product == "Aluminium",
        index == "Concentration Index"
    ) %>%
    group_by(flow) %>%
    pivot_wider(
        names_from = flow,
        values_from = Value
    ) %>%
    select(
        Date,
        everything()
    )

t_struc_al <- df %>%
    filter(
        Date >= 2010,
        product == "Aluminium",
        index == "Structural Change Index (1995=0)"
    ) %>%
    group_by(flow) %>%
    pivot_wider(
        names_from = flow,
        values_from = Value
    ) %>%
    select(
        Date,
        everything()
    )

fwrite(t_conc_al, file = "al-concentration-index.tsv", sep = "\t", quote = FALSE)
fwrite(t_struc_al, file = "al-structure-index.tsv", sep = "\t", quote = FALSE)
