# Загрузка необходимых библиотек
library(tidyr)
library(readr)  # Если вам нужна функция read_csv()
library(dplyr)
library(data.table)

df <- read_tsv("Презентация\\Data\\Trade\\import-countries.tsv")

df$'Ед. Изм.' <- "млрд долл"

df <- df %>%
    relocate("Ед. Изм.", .after = Год)

df <- df %>%
    mutate(across(-c(Год, "Ед. Изм."), ~ .x / 1000000))

fwrite(df, file = "import-countries.tsv", sep = "\t", quote = FALSE)