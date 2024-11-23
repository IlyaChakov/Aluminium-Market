# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

df <- read_tsv("Информация\\Торговля\\TSV\\reexport-countries.tsv")

# Замена названий столбцов
names(df) <- gsub("Стоимость реэкспорта в", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub("г.", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub(" ", "", names(df))  # Убираем "экспорт " из названий столбцов

df <- df %>%
    pivot_longer(
        cols = -"Реэкспортеры",
        names_to = "Год",
        values_to = "Объем"
    )

df$Год <- as.numeric(df$Год)
df$Реэкспортеры <- as.character(df$Реэкспортеры)

top_10 <- df %>%
    filter(Год == 2023) %>%
    group_by(Реэкспортеры) %>%
    summarise(Объем) %>%
    arrange(desc(Объем)) %>%
    slice_max(order_by = Объем, n = 10)

countries <- top_10$Реэкспортеры

df_top_10 <- df %>%
    filter(Год >= 2010, Реэкспортеры %in% countries) %>%
    group_by(Реэкспортеры)

table_top_10 <- df_top_10 %>%
    pivot_wider(
        names_from = "Реэкспортеры",
        values_from = "Объем"
    )

table_top_10$'Ед. Изм.' <- "млн долл"

table_top_10 <- table_top_10 %>%
    relocate("Ед. Изм.", .after = Год)

table_top_10 <- table_top_10 %>%
    mutate(across(-c(Год, "Ед. Изм."), ~ .x / 1000))

fwrite(table_top_10, file = "reexport-countries.tsv", sep = "\t", quote = FALSE)
