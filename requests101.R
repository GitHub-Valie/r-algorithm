# This R program sends a request to Binance servers and prints server time in
# datetime format

library("httr")
library("jsonlite")
library("anytime")

res <- GET("https://api.binance.com/api/v3/time")

json <- fromJSON(rawToChar(res$content))

server_time <- anytime(json$serverTime / 1000)