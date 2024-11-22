# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

# Чтение данных из CSV файла
df <- read_csv("C:\\Users\\User\\Documents\\GitHub\\Ilya Chakov\\Aluminium-Market\\Информация\\Производство\\Статистика\\Aluminium primary production (tonnes).csv")

df_summarized <- df %>%
  filter(Date >= 2010) %>%
  group_by(Date) %>%
  summarise(total_value = sum(Value, na.rm = FALSE)) %>%
  arrange(desc(total_value))

print(df_summarized)

top_10 <- df_summarized %>%
  slice_max(order_by = total_value, n = 10)

df_top_producers <- df %>%
  filter(Date >= 2010, country %in% top_10) %>%
  group_by(country)

fwrite(df_top_producers, file = "production.csv", sep = "\t", quote = FALSE)

print(top_10)
print(top_10$country)
print(df_top_producers)
print(df)

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

df_rest

df_prod <- df %>%
  filter(Date >= 2010, country %in% countries)

print(df_prod)

fwrite(df_prod, file = "production.csv", sep = "\t", quote = FALSE)
print(df_prod_mln)

df_prod_mln$Unit <- "mln tonnes"
df_prod_mln$Value <- df_prod_mln$Value / 1000000

  df_prod_mln$Unit <- "mln tonnes" %>%
  df_prod_mln$Value <- df_prod$Value / 1000

production_mln <- pivot_wider(df_prod_mln, names_from = country, values_from = Value)

print(production_mln)

fwrite(production_mln, file = "production_mln.csv", sep = "\t", quote = FALSE)

production_mln <- production %>%
  production_mln$Unit <- "mln tonnes" %>%
  production_mln

production_world <- df %>%
  filter(Date >= 2010) %>%
  group_by(Date) %>%
  summarise(total_value = sum(Value, na.rm = FALSE)) %>%
  arrange(Date)

print(production_world)

fwrite(production_world, file = "production_world.csv", sep = "\t", quote = FALSE)

production_world$Unit <- "mln tonnes"
production_world$total_value <- production_world$total_value / 1000000

production_mln <- read_tsv("C:\\Users\\User\\Documents\\GitHub\\Ilya Chakov\\Aluminium-Market\\Презентация\\Data\\Production\\production_mln.csv")

print(production_mln)

countries <- c("China", "Russia", "Canada", "India", "United Arab Emirates", "Australia", "United States", "Norway", "Bahrain", "Brazil")

top_10_sum <- df %>%
  filter(Date >= 2010, country %in% countries) %>%
  group_by(Date) %>%
  summarise(top_10_value = sum(Value, na.rm = FALSE)) %>%
  arrange(Date)
  
top_10_sum$top_10_value <- top_10_sum$top_10_value / 1000000
top_10_sum$Unit <- "mln tonnes"


print(top_10_sum)

production_mln$Others <- production_world$total_value - top_10_sum$top_10_value

fwrite(production_mln, file = "production_mln.csv", sep = "\t", quote = FALSE)
