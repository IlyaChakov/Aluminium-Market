# Загрузка необходимых библиотек
library(tidyr)
library(dplyr)
library(readr)  # Для чтения CSV файла

# Чтение данных из CSV файла (Обязательно "//" вместо "/" пути файла!)
df <- read_csv("your_file.csv")

# Преобразование данных
df_wide <- df %>%
  select(country, Date, Value) %>%    # Выбираем только нужные столбцы
  pivot_wider(names_from = Date,      # Столбцы будут именоваться датами
              values_from = Value)    # Значения будут из столбца Value

# Просмотр результирующего датафрейма
print(df_wide)
