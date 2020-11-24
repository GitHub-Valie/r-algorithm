library("httr")
library("jsonlite")
library("anytime")

symbol <- "BTCUSDT"
interval <- "1m"
endpoint <- "/api/v3/klines"

binance_api <- function(path) {
    url <- modify_url(
        "https://api.binance.com",
        path = path
    )

    resp <- GET(
        url,
        query = list(
            symbol = symbol,
            interval = interval
        )
    )
}

response <- binance_api(endpoint)

json <- fromJSON(
    rawToChar(response$content)
)

df <- data.frame(json)

write.table(
    df,
    "data\\BTCUSDT.csv",
    row.names = FALSE,
    col.names = FALSE
)