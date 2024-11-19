# Подключение пакетов
library(readr)
library(dplyr)
library(tidyr)

# Функция для получения пути к текущему скрипту
get_script_path <- function() {
  if (interactive()) {
    if (requireNamespace("rstudioapi", quietly = TRUE)) {
      if (rstudioapi::isAvailable()) {
        return(normalizePath(dirname(rstudioapi::getActiveDocumentContext()$path)))
      }
    }
    return(normalizePath(getwd()))
  } else {
    args <- commandArgs(trailingOnly = FALSE)
    script_path <- sub("^--file=", "", args[grep("^--file=", args)])
    if (length(script_path) > 0) {
      return(normalizePath(dirname(script_path)))
    }
    if (!is.null(sys.frames()[[1]]$ofile)) {
      return(normalizePath(dirname(sys.frames()[[1]]$ofile)))
    }
    return(normalizePath(getwd()))
  }
}

# Чтение данных
df <- read_csv("C:\\Users\\User\\Documents\\GitHub\\Ilya Chakov\\Aluminium-Market\\Информация\\Цены\\Статистика\\Aluminum prices (nominal and real).csv")

# Обработка данных
df_table <- df %>%
  select(commodity, Date, Value) %>%
  arrange(commodity, Date)

# Получение пути к папке со скриптом
output_folder <- get_script_path()

# Экспорт данных в .dat файлы
df_dat <- unique(df_table$commodity)

# Цикл по переменным для сохранения файлов
for (commodity_name in df_dat) {
  # Фильтрация данных
  commodity_data <- df_table %>% filter(commodity == commodity_name)
  # Формирование пути к файлу
  filename <- file.path(output_folder, paste0(commodity_name, ".dat"))

# Сохранение данных в файл
write.table(commodity_data[, c("Date", "Value")],
              file = filename,
              sep = "\t",
              row.names = FALSE,
              quote = FALSE)
}