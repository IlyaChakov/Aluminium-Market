# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

# Чтение данных из CSV файла
df <- read_csv("C:\\Users\\User\\Documents\\GitHub\\Ilya Chakov\\Aluminium-Market\\Информация\\Производство\\Статистика\\Aluminium primary production (tonnes).csv")

df_summarized <- df %>%
  filter(Date >= 2010) %>%
  group_by(country) %>%
  summarise(total_value = sum(Value, na.rm = FALSE)) %>%
  arrange(desc(total_value))

top_10 <- df_summarized %>%
  slice_max(order_by = total_value, n = 10)

df_top_producers <- df %>%
  filter(Date >= 2010, country %in% top_10) %>%
  group_by(country)

fwrite(df_top_producers, file = "production.csv", sep = "\t", quote = FALSE)

print(top_10)
print(top_10$country)
print(df_top_producers)

print(countries)

str(top_10)

countries2 <- countries %>% pull(country)

top_10$total_value <- NULL
countries <- top_10
print(countries)
print(c_vector)

c_vector <- unlist(countries$country)

df_final <- df %>%
  filter(country %in% countries, Date >=2010) %>%

countries3 <- tibble()



print(countries)

cat(c_vector, sep = "\n")

ct <- as.vector(cat(c_vector, sep = "\n"))
print(ct)

countries <- c("China", "Russia", "Canada", "India", "United Arab Emirates", "Australia", "United States", "Norway", "Bahrain", "Brazil")

print(countries)

df_prod <- df %>%
  filter(Date >= 2010, country %in% countries)

print(df_prod)

fwrite(df_prod, file = "production.csv", sep = "\t", quote = FALSE)

production <- pivot_wider(df_prod, names_from = country, values_from = Value)

print(production)

fwrite(production, file = "production.csv", sep = "\t", quote = FALSE)
