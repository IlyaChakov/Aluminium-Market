# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

# Чтение данных из CSV файла
df <- read_csv("C:\\Users\\User\\Documents\\GitHub\\Ilya Chakov\\Aluminium-Market\\Информация\\Цены\\Статистика\\Aluminum prices (nominal and real).csv")

# Фильтрация с помощью dplyr
filtered_df <- df %>%
  filter(measure == "nominal US dollars", Date >= 2010)

# Запись данных в новый файл с разделителем табуляцией и без кавычек
fwrite(filtered_df, file = "price-nominal.csv", sep = "\t", quote = FALSE)