# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

df <- read_tsv("Информация\\Торговля\\TSV\\trade-balance-countries.tsv")

# Замена названий столбцов
names(df) <- gsub("Баланс в Стоимость в", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub("г.", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub(" ", "", names(df))  # Убираем "экспорт " из названий столбцов
df <- df[df$Партнеры != "Весь Мир", ]
df$СтоимостьЭкспортав2023 <- NULL
df$СтоимостьИмпортав2023 <- NULL


df <- df %>%
    pivot_longer(
        cols = -"Партнеры",
        names_to = "Год",
        values_to = "Баланс"
    )

df$Год <- as.numeric(df$Год)
df$Партнеры <- as.character(df$Партнеры)

top_5 <- df %>%
    filter(Год >= 2010) %>%
    group_by(Партнеры) %>%
    summarise(total_value = sum(Баланс, na.rm = TRUE)) %>%
    arrange(desc(total_value)) %>%
    slice_max(order_by = total_value, n = 5)

bottom_5 <- df %>%
    filter(Год >= 2010) %>%
    group_by(Партнеры) %>%
    summarise(total_value = sum(Баланс, na.rm = TRUE)) %>%
    arrange(total_value) %>%
    slice_min(order_by = total_value, n = 5)

top_countries <- top_5$Партнеры
bottom_countries <- bottom_5$Партнеры

df_top_5 <- df %>%
    filter(Год >= 2010, Партнеры %in% top_countries) %>%
    group_by(Партнеры)

df_bottom_5 <- df %>%
    filter(Год >= 2010, Партнеры %in% bottom_countries) %>%
    group_by(Партнеры)

df_merge <- rbind(df_top_5, df_bottom_5)
df_merge$Баланс <- df_merge$Баланс / 1000000
df_merge$'Ед. Изм.' <- "млрд долл"
relocate(df_merge, "Ед. Изм.", .after = Год)

table_merge <- df_merge %>%
    pivot_wider(
        names_from = "Партнеры",
        values_from = "Баланс"
    )

fwrite(table_merge, file = "trade-balance-countries.tsv", sep = "\t", quote = FALSE)
