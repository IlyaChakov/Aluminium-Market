library(readr)
library(dplyr)
library(tidyr)

# Чтение данных
df <- read_csv("your_file.csv")

# Обработка данных
df_long <- df %>%
  select(country, Date, Value) %>%
  arrange(country, Date)

# Экспорт данных в .dat файлы
countries <- unique(df_long$country)

for (country_name in countries) {
  country_data <- df_long %>% filter(country == country_name)
  filename <- paste0(country_name, ".dat")
  write.table(country_data[, c("Date", "Value")],
              file = filename,
              sep = "\t",
              row.names = FALSE,
              quote = FALSE)
}