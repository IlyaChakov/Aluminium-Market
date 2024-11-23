# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

df <- read_tsv("Информация\\Торговля\\TSV\\export-countries.tsv")

# Замена названий столбцов
names(df) <- gsub("Стоимость экспорта в", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub("г.", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub(" ", "", names(df))  # Убираем "экспорт " из названий столбцов
df <- df[df$Экспортеры != "Весь Мир", ]

df <- df %>%
    pivot_longer(
        cols = -"Экспортеры",
        names_to = "Год",
        values_to = "Объем"
    )

df$Год <- as.numeric(df$Год)
df$Экспортеры <- as.character(df$Экспортеры)

top_10 <- df %>%
    filter(Год >= 2010) %>%
    group_by(Экспортеры) %>%
    summarise(total_value = sum(Объем, na.rm = TRUE)) %>%
    arrange(desc(total_value))

top_10 <- top_10 %>%
  slice_max(order_by = total_value, n = 10)

countries <- top_10$Экспортеры

df_top_10 <- df %>%
    filter(Год >= 2010, Экспортеры %in% countries) %>%
    group_by(Экспортеры)

table_top_10 <- df_top_10 %>%
    pivot_wider(
        names_from = "Экспортеры",
        values_from = "Объем"
    )

df_others <- df %>%
    filter(Год >= 2010, !Экспортеры %in% countries) %>%
    group_by(Год) %>%
    summarise(total_value = sum(Объем, na.rm = TRUE)) %>%
    arrange(Год)

table_top_10$Остальные <- df_others$total_value

fwrite(table_top_10, file = "export-countries.tsv", sep = "\t", quote = FALSE)