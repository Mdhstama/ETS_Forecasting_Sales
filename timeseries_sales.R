# ===== LIBRARY
library(forecast)
library(dplyr)
library(ggplot2)

# ===== PREPROCESSING

# membaca file .csv
dataset1 <- read.csv("~/R/UTS/test.csv")
head(dataset1)
summary(dataset1)

# ubah format tanggal menjadi date
dataset1$Date <- as.Date(dataset1$Date)
summary(dataset1)

# data_filter_1 adalah data penjualan id_store 0 dengan kode_produk 0
data_filter_1 <- filter(dataset1, store == 0, product == 0)
head(data_filter_1)

# selected_data adalah data yang akan dijadikan data timeseriesnya (hanya 2 kolom)
selected_data <- data_filter_1[, c("Date", "number_sold")]
head(selected_data)

# ringkasan detail data
jumlah_data <- nrow(selected_data)
jumlah_data
summary(selected_data)

# ===== FORECASTING ETS
ts_data <- ts(selected_data$number_sold, frequency = 1)
forecast_result <- forecast(ts_data, h = 180)
print(forecast_result)
plot(forecast_result, xlab = "Date", ylab = "Number Sold")
lines(fitted(forecast_result), col = "blue")
lines(forecast_result$mean, col = "red")
