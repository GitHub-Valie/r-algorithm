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

# Response:
# [
#   [
#     1499040000000,      // Open time
#     "0.01634790",       // Open
#     "0.80000000",       // High
#     "0.01575800",       // Low
#     "0.01577100",       // Close
#     "148976.11427815",  // Volume
#     1499644799999,      // Close time
#     "2434.19055334",    // Quote asset volume
#     308,                // Number of trades
#     "1756.87402397",    // Taker buy base asset volume
#     "28.46694368",      // Taker buy quote asset volume
#     "17928899.62484339" // Ignore.
#   ]
# ]

write.table(
    df,
    "data\\BTCUSDT.csv",
    row.names = FALSE,
    col.names = c(
        "Open time",
        "Open",
        "High",
        "Low",
        "Close",
        "Volume",
        "Close time",
        "Quote asset volume",
        "Number of trades",
        "Taker buy base asset volume",
        "Taker buy quote asset volume",
        "Ignore"
    )
)