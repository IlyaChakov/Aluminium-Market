# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

df <- read_tsv("Информация\\Торговля\\TSV\\import-countries.tsv")

# Замена названий столбцов
names(df) <- gsub("Стоимость импорта в", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub("г.", "", names(df))  # Убираем "экспорт " из названий столбцов
names(df) <- gsub(" ", "", names(df))  # Убираем "экспорт " из названий столбцов
df <- df[df$Импортеры != "Весь Мир", ]

df <- df %>%
    pivot_longer(
        cols = -"Импортеры",
        names_to = "Год",
        values_to = "Объем"
    )

df$Год <- as.numeric(df$Год)
df$Импортеры <- as.character(df$Импортеры)

top_10 <- df %>%
    filter(Год >= 2010) %>%
    group_by(Импортеры) %>%
    summarise(total_value = sum(Объем, na.rm = TRUE)) %>%
    arrange(desc(total_value))

top_10 <- top_10 %>%
  slice_max(order_by = total_value, n = 10)

countries <- top_10$Импортеры

df_top_10 <- df %>%
    filter(Год >= 2010, Импортеры %in% countries) %>%
    group_by(Импортеры)

table_top_10 <- df_top_10 %>%
    pivot_wider(
        names_from = "Импортеры",
        values_from = "Объем"
    )

df_others <- df %>%
    filter(Год >= 2010, !Импортеры %in% countries) %>%
    group_by(Год) %>%
    summarise(total_value = sum(Объем, na.rm = TRUE)) %>%
    arrange(Год)

table_top_10$Остальные <- df_others$total_value

fwrite(table_top_10, file = "import-countries.tsv", sep = "\t", quote = FALSE)